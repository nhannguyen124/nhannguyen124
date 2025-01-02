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
local MainTab = Window:CreateTab("Main", 4483362458) -- Icon ID from Roblox library
local SettingsTab = Window:CreateTab("Settings", 4483362458)
-- Adding Sections and Elements to Main Tab
local MainSection = MainTab:CreateSection("Main Functions")
MainTab:CreateButton({
    Name = "Buso",
    Callback = function()
            if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end
        end
})
MainTab:CreateToggle({
    Name = "AutoStoreFruit",
    CurrentValue = false,
    Callback = function(Value)
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
    end,
})
MainTab:CreateToggle({
    Name = "AutoBuso",
    CurrentValue = false,
    Callback = function(Value)
            if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") and Value then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end
        end,
})
MainTab:CreateToggle({
    Name = "Enable Feature",
    CurrentValue = false,
    Callback = function(Value)
        print("Feature Enabled:", Value)
    end,
})
MainTab:CreateSlider({
    Name = "Adjust Value",
    Range = {0, 100},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(Value)
        print("Slider Value:", Value)
    end,
})

-- Adding Elements to Settings Tab
local SettingsSection = SettingsTab:CreateSection("Settings")

SettingsTab:CreateDropdown({
    Name = "Select Option",
    Options = {"Option 1", "Option 2", "Option 3"},
    CurrentOption = "Option 1",
    Callback = function(Option)
        print("Selected Option:", Option)
    end,
})

SettingsTab:CreateInput({
    Name = "Enter Text",
    PlaceholderText = "Type here...",
    Callback = function(Text)
        print("Input Text:", Text)
    end,
})
