local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Example GUI",
    LoadingTitle = "Loading Example GUI",
    LoadingSubtitle = "By YourName",
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
    Name = "Say Hello",
    Callback = function()
        print("Hello from Rayfield!")
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
