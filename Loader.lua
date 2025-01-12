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
_G.Speed = 210
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
local Players = game:GetService("Players")

_G.Speed      = 350
local Players = game:GetService("Players")
function ATween(Pos)
    local Pos              = Vector3.new(Pos)
    local Player           = Players.LocalPlayer
    local Character        = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    local distance         = (Pos - HumanoidRootPart.Position).Magnitude
    if distance <= 350 then
        HumanoidRootPart.CFrame = Pos
    else
        -- Nếu khoảng cách lớn hơn 350, sử dụng BodyVelocity để di chuyển
        local direction       = (Pos - HumanoidRootPart.Position).Unit
        local bodyVelocity    = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = direction * _G.Speed
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Parent   = HumanoidRootPart

        local connection
        connection = game:GetService("RunService").Stepped:Connect(function()
            local distance = (Pos.Position - HumanoidRootPart.Position).Magnitude
            if distance <= 350 then
                HumanoidRootPart.CFrame = Pos
            elseif _G.StopTween then
                -- Đến gần đích hoặc yêu cầu dừng, hủy BodyVelocity
                bodyVelocity:Destroy()
                connection:Disconnect()
            else
                for _, v in pairs(Character:GetChildren()) do
                    if v:IsA("Part") or v:IsA("MeshPart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
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
        _G.Speed = Value
    end,
})

-- Adding Elements to Settings Tab
local SettingsSection = SettingsTab:CreateSection("Settings")
SettingsTab:CreateInput({
    Name = "Enter Text",
    PlaceholderText = "Type here...",
    Callback = function(Pos)
            print(Pos[1],Pos[2],Pos[3])
            Pos = Vector3.new(Pos[1],Pos[2],Pos[3])
            Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            print('3')
            if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
                pcall(function() tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/_G.Speed, Enum.EasingStyle.Linear),{CFrame = Pos}) end)
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
        Name = "Auto Pirate Raid",
        CurrentValue = false,
        Callback = function(value)
            _G.AutoPirateRaid = value
        end
    })
spawn(function()
    while wait() do
        if FarmMode == "Quest" and _G.AutoFarm then
            pcall(function()
                local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                if not string.find(QuestTitle, NameMon) then
                    StartMagnet = false
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                end
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    StartMagnet = false
                    CheckQuest()
                    if BypassTP then
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude > 1500 then
                    BTP(CFrameQuest)
                    elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude < 1500 then
                    ATween(CFrameQuest)
                    end
                else
                    ATween(CFrameQuest)
                end
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 5 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",NameQuest,LevelQuest)
                    end
                elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                    CheckQuest()
                    if game:GetService("Workspace").Enemies:FindFirstChild(Mon) then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                if v.Name == Mon then
                                    if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                        repeat task.wait()
                                            EquipWeapon(_G.SelectWeapon)
                                            AutoHaki()                                            
                                            PosMon = v.HumanoidRootPart.CFrame
                                            ATween(v.HumanoidRootPart.CFrame * Pos)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Head.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(70,70,70)
                                            StartMagnet = true
                                            game:GetService'VirtualUser':CaptureController()
                                            game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                        until not _G.AutoFarm or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    else
                                        StartMagnet = false
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                    end
                                end
                            end
                        end
                    else
                        ATween(CFrameMon)
                        UnEquipWeapon(_G.SelectWeapon)
                        StartMagnet = false
                        if game:GetService("ReplicatedStorage"):FindFirstChild(Mon) then
                         ATween(game:GetService("ReplicatedStorage"):FindFirstChild(Mon).HumanoidRootPart.CFrame * CFrame.new(15,10,2))
                        end
                    end
                end
            end)
        end
    end
end)
