-- =================================================================================
-- ||                            INS HUB - SCRIPT FINAL                           ||
-- =================================================================================

--[[
=================================================================================
    SECTION DE CONFIGURATION DES MODULES
=================================================================================
]]
local Categories = {
    {
        Name = "Main",
        Icon = "rbxassetid://6031023225", -- Épées croisées
        Module = function()
            -- Contenu du module "Main"
            return function(parent, mainFrame)
                local label = Instance.new("TextLabel", parent)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.Text = "Page principale (Auto Farm, etc.)"
                label.TextColor3 = Color3.new(1, 1, 1)
                label.Font = Enum.Font.SourceSansBold
                label.TextSize = 24
                label.BackgroundTransparency = 1
            end
        end
    },
    {
        Name = "Webhook",
        Icon = "rbxassetid://5108038234", -- Lien
        Module = function()
            -- Contenu du module "Webhook"
            return function(parent, mainFrame)
                local label = Instance.new("TextLabel", parent)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.Text = "Page Webhook"
                label.TextColor3 = Color3.new(1, 1, 1)
                label.Font = Enum.Font.SourceSansBold
                label.TextSize = 24
                label.BackgroundTransparency = 1
            end
        end
    },
    {
        Name = "Dungeon",
        Icon = "rbxassetid://6134237334", -- Porte
        Module = function()
            -- Contenu du module "Dungeon"
            return function(parent, mainFrame)
                local label = Instance.new("TextLabel", parent)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.Text = "Page Dungeon"
                label.TextColor3 = Color3.new(1, 1, 1)
                label.Font = Enum.Font.SourceSansBold
                label.TextSize = 24
                label.BackgroundTransparency = 1
            end
        end
    },
    {
        Name = "Raid",
        Icon = "rbxassetid://2853189422", -- Crâne
        Module = function()
            -- Contenu du module "Raid"
            return function(parent, mainFrame)
                local label = Instance.new("TextLabel", parent)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.Text = "Page Raid"
                label.TextColor3 = Color3.new(1, 1, 1)
                label.Font = Enum.Font.SourceSansBold
                label.TextSize = 24
                label.BackgroundTransparency = 1
            end
        end
    },
    {
        Name = "Teleport",
        Icon = "rbxassetid://5113522269", -- Marqueur de carte
        Module = function()
            -- Contenu pour teleport.lua
            return function(parent)
                -- 'parent' est le frame de droite où tout doit être dessiné
                local selectedVille = nil
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

                local listFrame = Instance.new("ScrollingFrame", parent)
                listFrame.Size = UDim2.new(0, 200, 1, -10)
                listFrame.Position = UDim2.new(0, 5, 0, 5)
                listFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                listFrame.BorderSizePixel = 0
                Instance.new("UIListLayout", listFrame).Padding = UDim.new(0, 5)
                Instance.new("UICorner", listFrame).CornerRadius = UDim.new(0, 4)

                local infoPanel = Instance.new("Frame", parent)
                infoPanel.Size = UDim2.new(1, -215, 1, -10)
                infoPanel.Position = UDim2.new(0, 210, 0, 5)
                infoPanel.BackgroundTransparency = 1

                local selectedLabel = Instance.new("TextLabel", infoPanel)
                selectedLabel.Size = UDim2.new(1, 0, 0, 30)
                selectedLabel.Text = "Selected: None"
                selectedLabel.Font = Enum.Font.SourceSans
                selectedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
                selectedLabel.BackgroundTransparency = 1

                local tpButton = Instance.new("TextButton", infoPanel)
                tpButton.Size = UDim2.new(1, 0, 0, 30)
                tpButton.Position = UDim2.new(0, 0, 0, 40)
                tpButton.Text = "  Teleport >"
                tpButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                tpButton.Font = Enum.Font.SourceSans
                tpButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                tpButton.TextXAlignment = Enum.TextXAlignment.Left
                Instance.new("UICorner", tpButton).CornerRadius = UDim.new(0, 4)

                for nomVille, _ in pairs(villes) do
                    local cityButton = Instance.new("TextButton", listFrame)
                    cityButton.Size = UDim2.new(1, -10, 0, 25)
                    cityButton.Text = nomVille
                    cityButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                    cityButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    cityButton.Font = Enum.Font.SourceSans
                    Instance.new("UICorner", cityButton).CornerRadius = UDim.new(0, 4)
                    cityButton.MouseButton1Click:Connect(function()
                        selectedVille = nomVille
                        selectedLabel.Text = "Selected: " .. nomVille
                    end)
                end
                
                tpButton.MouseButton1Click:Connect(function()
                    if selectedVille then
                        local player = game.Players.LocalPlayer
                        local character = player and player.Character
                        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart then
                            humanoidRootPart.CFrame = CFrame.new(villes[selectedVille])
                        end
                    end
                end)
            end
        end
    },
    {
        Name = "Misc",
        Icon = "rbxassetid://2842511382", -- Engrenage
        Module = function()
            -- Contenu pour misc.lua
            return function(parent, mainFrame)
                local UIAccentColor = Color3.fromRGB(25, 25, 25)
                local UITextColor = Color3.fromRGB(200, 200, 200)
                local listLayout

                local function createSection(title)
                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1, -20, 0, 30); label.Text = title; label.Font = Enum.Font.SourceSansBold
                    label.TextSize = 20; label.TextColor3 = Color3.new(1, 1, 1); label.TextXAlignment = Enum.TextXAlignment.Left
                    label.BackgroundTransparency = 1; label.LayoutOrder = #listLayout.Parent:GetChildren()
                    label.Parent = listLayout.Parent
                end

                local function createToggle(text, callback)
                    local container = Instance.new("Frame"); container.Size = UDim2.new(1, -20, 0, 30); container.BackgroundTransparency = 1
                    container.LayoutOrder = #listLayout.Parent:GetChildren(); container.Parent = listLayout.Parent
                    local label = Instance.new("TextLabel", container); label.Size = UDim2.new(0.7, 0, 1, 0); label.Text = text
                    label.Font = Enum.Font.SourceSans; label.TextSize = 16; label.TextColor3 = UITextColor; label.TextXAlignment = Enum.TextXAlignment.Left; label.BackgroundTransparency = 1
                    local switch = Instance.new("Frame", container); switch.Size = UDim2.new(0, 50, 0, 24); switch.Position = UDim2.new(1, -50, 0.5, -12)
                    switch.BackgroundColor3 = Color3.fromRGB(50, 50, 50); Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)
                    local nub = Instance.new("Frame", switch); nub.Size = UDim2.new(0, 20, 0, 20); nub.Position = UDim2.new(0, 2, 0.5, -10)
                    nub.BackgroundColor3 = Color3.fromRGB(150, 150, 150); Instance.new("UICorner", nub).CornerRadius = UDim.new(1, 0)
                    local button = Instance.new("TextButton", switch); button.Size = UDim2.new(1,0,1,0); button.BackgroundTransparency = 1; button.Text = ""
                    local toggled = false
                    button.MouseButton1Click:Connect(function()
                        toggled = not toggled; local pos = toggled and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
                        local color = toggled and Color3.fromRGB(186, 85, 211) or Color3.fromRGB(150, 150, 150)
                        nub:TweenPosition(pos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true); nub.BackgroundColor3 = color
                        if callback then callback(toggled) end
                    end)
                end
                
                local function createButton(text, callback)
                    local button = Instance.new("TextButton"); button.Size = UDim2.new(1, -20, 0, 30); button.Text = "  " .. text
                    button.Font = Enum.Font.SourceSans; button.TextSize = 16; button.TextColor3 = UITextColor
                    button.BackgroundColor3 = UIAccentColor; button.TextXAlignment = Enum.TextXAlignment.Left
                    button.LayoutOrder = #listLayout.Parent:GetChildren(); button.Parent = listLayout.Parent
                    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 4)
                    if callback then button.MouseButton1Click:Connect(callback) end
                end

                local scrollingFrame = Instance.new("ScrollingFrame", parent); scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
                scrollingFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35); scrollingFrame.BorderSizePixel = 0
                scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(186, 85, 211); scrollingFrame.ScrollBarThickness = 6
                listLayout = Instance.new("UIListLayout", scrollingFrame); listLayout.Padding = UDim.new(0, 8); listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

                createSection("Settings")
                createToggle("Auto Hide UI", function(value) print("Auto Hide UI:", value) end)
                createToggle("UI Size", function(value) print("UI Size:", value) end)
                createToggle("Auto Exec", function(value) print("Auto Exec:", value) end)
                createToggle("No Dash CD", function(value) shared.NoDashCD = value end)
                createToggle("No Punch CD", function(value) shared.NoPunchCD = value end)
                local hiddenUsers = {}
                createToggle("Hide Other Users", function(value)
                    if value then for _, p in ipairs(game.Players:GetPlayers()) do if p ~= game.Players.LocalPlayer and p.Character then hiddenUsers[p]=p.Character.Parent;p.Character.Parent=nil end end
                    else for p, par in pairs(hiddenUsers) do if p and p.Character then p.Character.Parent=par end end; hiddenUsers={} end
                end)

                createSection("Export Config")
                createButton("Export Config Clipboard", function() if not setclipboard then return end setclipboard("-- Config\nshared.NoDashCD = "..tostring(shared.NoDashCD)); end)

                createSection("FPS Stuff")
                local blackScreen = Instance.new("Frame", parent); blackScreen.Size = UDim2.new(1,0,1,0); blackScreen.BackgroundColor3 = Color3.new(0,0,0); blackScreen.ZIndex=100; blackScreen.Visible=false
                createToggle("Black Screen", function(value) blackScreen.Visible = value end)
                createButton("[LOW PLAYER] ServerHop", function() local ts=game:GetService("TeleportService");local hs=game:GetService("HttpService");local s=hs:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..tostring(game.PlaceId).."/servers/Public?sortOrder=Asc&limit=100"));for _,v in ipairs(s.data) do if v.playing<10 and v.playing<v.maxPlayers and v.id~=game.JobId then ts:TeleportToPlaceInstance(game.PlaceId,v.id,game.Players.LocalPlayer);return end end end)

                shared.NoDashCD = false; shared.NoPunchCD = false
                spawn(function() while wait() do if shared.NoDashCD then pcall(function() end) end end end)
                spawn(function() while wait() do if shared.NoPunchCD then pcall(function() end) end end)
                
                scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
            end
        end
    }
}


--[[
=================================================================================
    CRÉATION DE L'INTERFACE PRINCIPALE (Le Cerveau)
=================================================================================
]]
local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
screenGui.Parent = game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 700, 0, 450)
mainFrame.Position = UDim2.new(0.5, -350, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 6)

local leftPanel = Instance.new("Frame")
leftPanel.Size = UDim2.new(0, 180, 1, 0)
leftPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
leftPanel.BorderSizePixel = 0
leftPanel.Parent = mainFrame

local rightPanel = Instance.new("Frame")
rightPanel.Size = UDim2.new(1, -180, 1, 0)
rightPanel.Position = UDim2.new(0, 180, 0, 0)
rightPanel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
rightPanel.BorderSizePixel = 0
rightPanel.Parent = mainFrame

local categoryList = Instance.new("UIListLayout")
categoryList.Padding = UDim.new(0, 5)
categoryList.HorizontalAlignment = Enum.HorizontalAlignment.Center
categoryList.VerticalAlignment = Enum.VerticalAlignment.Top
categoryList.Parent = leftPanel

local selectedButton = nil

-- ======================= LA CORRECTION EST ICI =========================
local function switchPage(categoryData)
    -- Nettoyer la page de droite
    for _, child in ipairs(rightPanel:GetChildren()) do
        child:Destroy()
    end
    
    -- Charger le module de la nouvelle page
    local moduleLoader = categoryData.Module
    if moduleLoader then
        local moduleContentFunction = moduleLoader() -- On exécute la première fonction pour obtenir la seconde
        if typeof(moduleContentFunction) == "function" then
            moduleContentFunction(rightPanel, mainFrame) -- On appelle la seconde avec les bons arguments
        end
    end
end
-- =====================================================================

for _, categoryData in ipairs(Categories) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Text = "  " .. categoryData.Name
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 16
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    button.BorderSizePixel = 0
    button.Parent = leftPanel
    
    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 20, 0, 20)
    icon.Position = UDim2.new(1, -30, 0.5, -10)
    icon.Image = categoryData.Icon
    icon.BackgroundTransparency = 1
    icon.Parent = button
    
    button.MouseButton1Click:Connect(function()
        if selectedButton then
            selectedButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        end
        button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        selectedButton = button
        switchPage(categoryData)
    end)
end

-- Sélectionner la première page par défaut
if Categories[1] then
    local firstButton = leftPanel:FindFirstChildOfClass("TextButton")
    if firstButton then
        firstButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        selectedButton = firstButton
    end
    switchPage(Categories[1])
end
