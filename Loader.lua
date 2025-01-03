local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local CakePos = CFrame.new(-2091.911865234375, 70.00884246826172, -12142.8359375)
local Window = Rayfield:CreateWindow({
    Name = "HackerLoVN",
    LoadingTitle = "Đợi đi cu",
    LoadingSubtitle = "By nhannguyen6886",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil, -- Use a custom folder name for saving settings
        FileName = "ExampleGUIConfig"
    },
    KeySystem = false, -- Set to true if you want a key system
})
local Speed = 210
function Click()
    game:GetService'VirtualUser':CaptureController()
    game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
end
function UnEquipWeapon(Weapon)
    if game.Players.LocalPlayer.Character:FindFirstChild(Weapon) then
        _G.NotAutoEquip = true
        wait(.5)
        game.Players.LocalPlayer.Character:FindFirstChild(Weapon).Parent = game.Players.LocalPlayer.Backpack
        wait(.1)
        _G.NotAutoEquip = false
    end
end
function EquipWeapon(ToolSe)
    if not _G.NotAutoEquip then
        if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
            Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
            wait(.1)
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
        end
    end
end
function BTP(p)
    pcall(function()
        if (p.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1500 and not Auto_Raid and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
            repeat wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p
                wait(.05)
                game.Players.LocalPlayer.Character.Head:Destroy()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p
            until (p.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1500 and game.Players.LocalPlayer.Character.Humanoid.Health > 0
        end
    end)
end
function ATween(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
    pcall(function() tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = Pos}) end)
    tween:Play()
    if Distance <= 350 then
        tween:Cancel()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    end
    if _G.StopTween == true then
        tween:Cancel()
        _G.Clip = false
    end
end
function StopTween(target)
    if not target then
        _G.StopTween = true
        wait()
        ATween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
        if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
        end
        _G.StopTween = false
        _G.Clip = false
    end
    if game.Players.LocalPlayer.Character:FindFirstChild('Highlight') then
        game.Players.LocalPlayer.Character:FindFirstChild('Highlight'):Destroy()
    end
end
local MainTab = Window:CreateTab("Main", 4483362458) -- Icon ID from Roblox library
local SettingsTab = Window:CreateTab("Settings", 4483362458)
-- Adding Sections and Elements to Main Tab
local MainSection = MainTab:CreateSection("Main Functions")
MainTab:CreateDropdown({
    Name = "Select Option",
    Options = {"NoQuest", "Quest"},
    CurrentOption = "NoQuest",
    Callback = function(Option)
        CakeFMode = Option
    end,
})
MainTab:CreateButton({
    Name = "Buso",
    Callback = function()
            if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end
        end
})
MainTab:CreateToggle({
    Name = "Invisible Monster",
    CurrentValue = false,
    Callback = function(value)
            _G.inv = value
            while wait() do
                if _G.inv then
                    pcall(function()
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do
                            if v.ClassName == "MeshPart" then
                                v.Transparency = 1
                            end
                        end
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do
                            if v.Name == "Head" then
                                v.Transparency = 1
                            end
                        end
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do
                            if v.ClassName == "Accessory" then
                                v.Handle.Transparency = 1
                            end
                        end
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do
                            if v.ClassName == "Decal" then
                                v.Transparency = 1
                            end
                        end
                    end)
                end
            end
        end,
})
MainTab:CreateToggle({
    Name = "AutoStoreFruit",
    CurrentValue = false,
    Callback = function(Value)
            while wait() do
                if Value then
                    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v:IsA("Tool") and string.find(v.Name, "Fruit") then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit",v:GetAttribute("OriginalName"),v)
                            Load.Text = "Keep Fruit Success"
                        end
                    end
                    for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                        if v:IsA("Tool") and string.find(v.Name, "Fruit") then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit",v:GetAttribute("OriginalName"),v)
                            Load.Text = "Keep Fruit Success"
                        end
                    end
                end
            end
        end,
})
MainTab:CreateToggle({
    Name = "AutoBuso",
    CurrentValue = false,
    Callback = function(Value)
            while wait() do
                if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") and Value then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                end
            end
        end,
})
MainTab:CreateToggle({
    Name = "BypassTP",
    CurrentValue = false,
    Callback = function(Value)
        BypassTP = value
    end,
})
MainTab:CreateSlider({
    Name = "Adjust Value",
    Range = {210, 350},
    Increment = 1,
    CurrentValue = 210,
    Callback = function(Value)
        Speed = Value
    end,
})

-- Adding Elements to Settings Tab
local SettingsSection = SettingsTab:CreateSection("Settings")
SettingsTab:CreateInput({
    Name = "Enter Text",
    PlaceholderText = "Type here...",
    Callback = function(Pos)
        Pos = CFrame.new(Pos)
        Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
            pcall(function() tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/350, Enum.EasingStyle.Linear),{CFrame = Pos}) end)
            tween:Play()
        if Distance <= 350 then
            tween:Cancel()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
        end
    end,
})
MainTab:CreateToggle({
        Name = "Auto Random Fruit",
        CurrentValue = false,
        Callback = function(Value)
            local args = {
                [1] = "Cousin",
                [2] = "Buy"
            }
            while wait() and Value == true do
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
        end,
    })
MainTab:CreateToggle({
        Name = "Auto Random Fruit",
        CurrentValue = false,
        Callback = function(Value)
                while wait() do
                    if _G.RaidPirate then
                        pcall(function()
                            local CFrameBoss = CFrame.new(-5496.17432, 313.768921, -2841.53027, 0.924894512, 7.37058015e-09, 0.380223751, 3.5881019e-08, 1, -1.06665446e-07, -0.380223751, 1.12297109e-07, 0.924894512)
                            if (CFrame.new(-5539.3115234375, 313.800537109375, -2972.372314453125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if _G.RaidPirate and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                        if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
                                            repeat wait()
                                                AutoHaki()
                                                EquipWeapon(_G.SelectWeapon)
                                                v.HumanoidRootPart.CanCollide = false
                                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                                ATween(v.HumanoidRootPart.CFrame * Pos)
                                                Click()
                                            until v.Humanoid.Health <= 0 or not v.Parent or not _G.RaidPirate
                                        end
                                    end
                                end
                            else
                                UnEquipWeapon(_G.SelectWeapon)
                                if BypassTP then
                                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameBoss.Position).Magnitude > 1500 then
            			        BTP(CFrameBoss)
            				    elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameBoss.Position).Magnitude < 1500 then
            				    ATween(CFrameBoss)
            					end
                                end
                            end
                        end)
                    end
                end
            end,
    })
