--[[
    Script: INS Hub - Interface de Téléportation
    Description: Une interface inspirée de Goomba Hub pour se téléporter aux emplacements définis.
    Instructions:
    1. Cliquez sur le nom d'une ville dans la liste de gauche.
    2. Cliquez sur le bouton "Teleport" à droite.
]]

-- Configuration des emplacements (Villes et Coordonnées)
local villes = {
    ["Hurricane Town"] = Vector3.new(-1289.81689, 24.9105072, -4613.44775),
    ["Nen City"] = Vector3.new(-4779.98633, 34.6580772, -2668.4585),
    ["Summer Island"] = Vector3.new(-352.715088, 47.0305405, -2580.3125),
    ["Hunters City"] = Vector3.new(1482.901, 24.1079426, -2628.19409),
    ["Winter Raid"] = Vector3.new(4930.82568, 29.7264671, -2153.01538),
    ["Kindama City"] = Vector3.new(-2471.64038, 21.9620514, 2952.65137),
    ["XZ City"] = Vector3.new(2286.91357, 25.3927879, 1842.56128),
    ["Dragon City"] = Vector3.new(-653.285889, 27.198103, 36.519516),
    ["World Arena"] = Vector3.new(1650.90576, 23.6456509, -66.527092)
}

-- Variables pour la gestion de l'état de l'UI
local selectedVille = nil
local selectedButton = nil
local UIBgColor = Color3.fromRGB(20, 20, 20)
local UIAccentColor = Color3.fromRGB(25, 25, 25)
local UIMainColor = Color3.fromRGB(186, 85, 211) -- Violet/Magenta
local UITextColor = Color3.fromRGB(200, 200, 200)

-- Création de l'interface (GUI)
local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
screenGui.Parent = game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 230) -- Hauteur réduite
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -115) -- Position ajustée
mainFrame.BackgroundColor3 = UIBgColor
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 5)

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = UIAccentColor
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 5)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 150, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.Text = "INS Hub" -- CHANGEMENT: Nom de l'interface
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = topBar

local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.new(0, 150, 1, 0)
versionLabel.Position = UDim2.new(0, 80, 0, 0) -- Position ajustée pour le nouveau titre
versionLabel.Text = "v4.2"
versionLabel.TextColor3 = UIMainColor
versionLabel.Font = Enum.Font.SourceSansBold
versionLabel.TextSize = 16
versionLabel.TextXAlignment = Enum.TextXAlignment.Left
versionLabel.BackgroundTransparency = 1
versionLabel.Parent = topBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Position = UDim2.new(1, -25, 0.5, -10)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 14
closeButton.BackgroundTransparency = 1
closeButton.Parent = topBar
closeButton.MouseButton1Click:Connect(function() screenGui:Destroy() end)

-- Panneau de gauche pour la liste des villes
local leftPanel = Instance.new("ScrollingFrame")
leftPanel.Size = UDim2.new(0, 180, 1, -35)
leftPanel.Position = UDim2.new(0, 5, 0, 35)
leftPanel.BackgroundColor3 = UIAccentColor
leftPanel.BorderSizePixel = 0
leftPanel.ScrollBarImageColor3 = UIMainColor
leftPanel.ScrollBarThickness = 5
leftPanel.Parent = mainFrame
Instance.new("UICorner", leftPanel).CornerRadius = UDim.new(0, 4)

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 5)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.Parent = leftPanel

-- Panneau de droite pour les actions
local rightPanel = Instance.new("Frame")
rightPanel.Size = UDim2.new(1, -195, 1, -35)
rightPanel.Position = UDim2.new(0, 190, 0, 35)
rightPanel.BackgroundTransparency = 1
rightPanel.Parent = mainFrame

local teleportHeader = Instance.new("TextLabel")
teleportHeader.Size = UDim2.new(1, 0, 0, 30)
teleportHeader.Text = "Teleport"
teleportHeader.TextColor3 = Color3.new(1, 1, 1)
teleportHeader.Font = Enum.Font.SourceSansBold
teleportHeader.TextSize = 20
teleportHeader.TextXAlignment = Enum.TextXAlignment.Left
teleportHeader.BackgroundTransparency = 1
teleportHeader.Parent = rightPanel

local selectedLabel = Instance.new("TextLabel")
selectedLabel.Size = UDim2.new(1, -10, 0, 20)
selectedLabel.Position = UDim2.new(0, 5, 0, 35)
selectedLabel.Text = "Selected: None"
selectedLabel.TextColor3 = UITextColor
selectedLabel.Font = Enum.Font.SourceSans
selectedLabel.TextSize = 14
selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
selectedLabel.BackgroundTransparency = 1
selectedLabel.Parent = rightPanel

-- Création du bouton de téléportation unique
local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(1, -10, 0, 30)
tpButton.Position = UDim2.new(0, 5, 0, 70)
tpButton.BackgroundColor3 = UIAccentColor
tpButton.Text = "  Teleport" .. string.rep(" ", 15) .. ">"
tpButton.TextColor3 = UITextColor
tpButton.Font = Enum.Font.SourceSans
tpButton.TextSize = 16
tpButton.TextXAlignment = Enum.TextXAlignment.Left
tpButton.Parent = rightPanel
Instance.new("UICorner", tpButton).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", tpButton).Color = UIMainColor

-- Logique de téléportation
local function doTeleport()
    if not selectedVille then
        warn("Aucune ville sélectionnée.")
        return
    end
    
    local player = game.Players.LocalPlayer
    local character = player and player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if humanoidRootPart and villes[selectedVille] then
        humanoidRootPart.CFrame = CFrame.new(villes[selectedVille])
        print("Téléportation à " .. selectedVille)
    else
        warn("Impossible de trouver le personnage ou la destination.")
    end
end

tpButton.MouseButton1Click:Connect(doTeleport)

-- Remplissage de la liste des villes
for nomVille, _ in pairs(villes) do
    local cityButton = Instance.new("TextButton")
    cityButton.Name = nomVille
    cityButton.Size = UDim2.new(1, -10, 0, 25)
    cityButton.Text = nomVille
    cityButton.TextColor3 = UITextColor
    cityButton.Font = Enum.Font.SourceSans
    cityButton.TextSize = 14
    cityButton.BackgroundColor3 = UIAccentColor
    cityButton.Parent = leftPanel
    Instance.new("UICorner", cityButton).CornerRadius = UDim.new(0, 4)
    
    cityButton.MouseButton1Click:Connect(function()
        -- Réinitialiser l'ancien bouton sélectionné
        if selectedButton then
            selectedButton.BackgroundColor3 = UIAccentColor
            selectedButton.TextColor3 = UITextColor
            selectedButton.Font = Enum.Font.SourceSans
        end
        
        -- Mettre à jour le nouveau bouton sélectionné
        selectedVille = nomVille
        selectedButton = cityButton
        selectedLabel.Text = "Selected: " .. nomVille
        
        -- Mettre en surbrillance
        cityButton.BackgroundColor3 = UIMainColor
        cityButton.TextColor3 = Color3.new(1, 1, 1)
        cityButton.Font = Enum.Font.SourceSansBold
    end)
end
