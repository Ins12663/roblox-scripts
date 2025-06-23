--[[
    Script de Téléportation pour Delta Executor
    Créé à partir des coordonnées fournies.
    Le jeu doit être le même que celui où les positions ont été sauvegardées.
]]

-- Crée une table (dictionnaire) pour stocker les noms des villes et leurs coordonnées
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

-- Création de l'interface graphique (GUI)
local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("CoreGui") -- Utiliser CoreGui pour éviter la suppression par le jeu

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 150)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderColor3 = Color3.fromRGB(80, 80, 255)
mainFrame.BorderSizePixel = 2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -30, 1, 0)
titleLabel.Text = "Téléporteur de Villes"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 16
titleLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleLabel.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 16
closeButton.Parent = titleBar
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Menu déroulant
local dropdownLabel = Instance.new("TextLabel")
dropdownLabel.Size = UDim2.new(0, 230, 0, 30)
dropdownLabel.Position = UDim2.new(0.5, -115, 0, 40)
dropdownLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
dropdownLabel.BorderColor3 = Color3.fromRGB(100, 100, 100)
dropdownLabel.TextColor3 = Color3.new(1, 1, 1)
dropdownLabel.Text = "Choisir une ville..."
dropdownLabel.Font = Enum.Font.SourceSans
dropdownLabel.TextSize = 14
dropdownLabel.Parent = mainFrame

local dropdownButton = Instance.new("TextButton")
dropdownButton.Size = UDim2.new(1, 0, 1, 0)
dropdownButton.Text = ""
dropdownButton.BackgroundTransparency = 1
dropdownButton.Parent = dropdownLabel

local optionsFrame = Instance.new("ScrollingFrame")
optionsFrame.Size = UDim2.new(0, 230, 0, 120)
optionsFrame.Position = UDim2.new(0, 0, 1, 0)
optionsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
optionsFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
optionsFrame.Visible = false
optionsFrame.Parent = dropdownLabel
optionsFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Sera ajusté

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 2)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = optionsFrame

local selectedVille = nil

-- Remplir le menu déroulant avec les villes
for nomVille, _ in pairs(villes) do
    local optionButton = Instance.new("TextButton")
    optionButton.Size = UDim2.new(1, -10, 0, 25)
    optionButton.Text = nomVille
    optionButton.TextColor3 = Color3.new(1, 1, 1)
    optionButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    optionButton.Font = Enum.Font.SourceSans
    optionButton.TextSize = 14
    optionButton.Parent = optionsFrame
    
    optionButton.MouseButton1Click:Connect(function()
        selectedVille = nomVille
        dropdownLabel.Text = nomVille
        optionsFrame.Visible = false
    end)
end

-- Logique pour ouvrir/fermer le menu déroulant
dropdownButton.MouseButton1Click:Connect(function()
    optionsFrame.Visible = not optionsFrame.Visible
end)

-- Bouton de téléportation
local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0, 230, 0, 40)
teleportButton.Position = UDim2.new(0.5, -115, 0, 90)
teleportButton.Text = "Se Téléporter"
teleportButton.TextColor3 = Color3.new(1, 1, 1)
teleportButton.BackgroundColor3 = Color3.fromRGB(80, 80, 255)
teleportButton.Font = Enum.Font.SourceSansBold
teleportButton.TextSize = 18
teleportButton.Parent = mainFrame

teleportButton.MouseButton1Click:Connect(function()
    if selectedVille then
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart then
            local destination = villes[selectedVille]
            humanoidRootPart.CFrame = CFrame.new(destination)
            print("Téléportation vers : " .. selectedVille)
        else
            warn("HumanoidRootPart non trouvé. Impossible de se téléporter.")
        end
    else
        warn("Veuillez d'abord sélectionner une ville.")
    end
end)
