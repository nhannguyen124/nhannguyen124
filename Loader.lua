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
local function IsAlive(Character)
    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        return Humanoid and Humanoid.Health > 0
    end
    return false
end
local BaseParts = {}
for _, v in pairs(Player.Character:GetDescendants()) do
    if v:IsA("BasePart") and v.CanCollide then
        table.insert(BaseParts, v)
    end
end
function Brings(Name,Pos)
	for _, v in pairs(workspace.Enemies:GetChildren()) do
		if v.Name == Name then
			v.PrimaryPart.CFrame = CFrame.new(Pos[1],Pos[2],Pos[3])
			v.Humanoid.WalkSpeed = 0
			v.Humanoid.JumpPower = 0
		end
	end
end
local function ATween(TargetPosition)
    local TargetPosition = TargetPosition.Position
    local Character = Player.Character or Player.CharacterAdded:Wait()
    if not IsAlive(Character) then return end

    local BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    BodyVelocity.P = 1000
    
    if _G.tween_bodyvelocity then
        _G.tween_bodyvelocity:Destroy()
    end
    _G.tween_bodyvelocity = BodyVelocity
    local UpperTorso = Character:FindFirstChild("UpperTorso")
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")

    if UpperTorso and Humanoid then
        BodyVelocity.Parent = UpperTorso
        local distance = (UpperTorso.Position - TargetPosition).magnitude
        local timeToMove = distance / _G.speed
        local defaultWalkSpeed = Humanoid.WalkSpeed

        local RunService = game:GetService("RunService")
        local connection
        connection = RunService.Stepped:Connect(function()
            if IsAlive(Character)  then
                BodyVelocity.Velocity = (TargetPosition - UpperTorso.Position).unit * _G.speed
                for i = 1, #BaseParts do
                    BaseParts[i].CanCollide = false
                end
                if (UpperTorso.Position - TargetPosition).magnitude < 5 then
                    -- Dừng di chuyển
                    Humanoid.WalkSpeed = 0
                    BodyVelocity.Velocity = Vector3.zero
                    BodyVelocity:Destroy()
                    
                    -- Đặt lại vị trí
                    Character:SetPrimaryPartCFrame(CFrame.new(TargetPosition))
                    
                    -- Khôi phục WalkSpeed sau khi dừng
                    task.wait(2)
                    Humanoid.WalkSpeed = defaultWalkSpeed
                    connection:Disconnect()
                end
                elseif _G.StopTween then
                    BodyVelocity:Destroy()
                    UpperTorso.Anchored = true
                    wait(1)
                    UpperTorso.Anchored = false
                    connection:Disconnect()
                end
        end)
        task.wait(timeToMove)
        for i = 1, #BaseParts do
            BaseParts[i].CanCollide = true
        end
    end
end
local Settings = {
	AutoClick= true
}
local AttackCooldown = 0
local Player = game.Players.LocalPlayer
local FastAttack = {
    Distance = 50,            -- Khoảng cách tối đa để tấn công
    attackMobs = true,       -- Chỉ định xem có tấn công quái vật không
    attackPlayers = true,    -- Chỉ định xem có tấn công người chơi không
    Equipped = nil,          -- Lưu công cụ hiện tại đang trang bị
    Debounce = 0,            -- Thời gian ngăn chặn tấn công liên tục
    ComboDebounce = 0,       -- Thời gian ngăn chặn tính toán combo
    M1Combo = 0               -- Số lượng combo hiện tại
}
_G.rz_FastAttack = FastAttack
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RegisterHit = ReplicatedStorage.Modules.Net:FindFirstChild("RE/RegisterHit")
local RegisterAttack = ReplicatedStorage.Modules.Net:FindFirstChild("RE/RegisterAttack")
local CachedChars = {}
function IsAlive(Character: Model?): boolean
    if Character then
        local Humanoid, NoCache = CachedChars[Character] or Character.Humanoid
        
        if Humanoid then
            if NoCache ~= true and not CachedChars[Character] then
                CachedChars[Character] = Humanoid
            end
            
            return Humanoid[if Humanoid.ClassName == "Humanoid" then "Health" else "Value"] > 0
        end
    end
    return false -- Trả về false nếu Character không tồn tại hoặc Humanoid không có
end
function GetAllBladeHits(Character)
	local CFrame = Character:GetPivot().Position -- Lấy vị trí của nhân vật
	local BladeHits, FirstRootPart = {} -- Khởi tạo danh sách cho các mục tiêu bị tấn công
	local EnemyList = workspace.Enemies:GetChildren() -- Lấy danh sách tất cả kẻ thù

	-- Duyệt qua danh sách kẻ thù
	for i = 1, #EnemyList do
		local Enemy = EnemyList[i]
		local RootPart = Enemy.PrimaryPart -- Lấy phần gốc (root part) của kẻ thù

		-- Kiểm tra điều kiện để xác định xem kẻ thù có thể bị tấn công hay không
		if RootPart and IsAlive(Enemy) and Player:DistanceFromCharacter(RootPart.Position) <= FastAttack.Distance then
			if not FirstRootPart then
				FirstRootPart = RootPart -- Lưu lại phần gốc đầu tiên để tấn công
			else
				table.insert(BladeHits, { Enemy, RootPart }) -- Thêm kẻ thù vào danh sách tấn công
			end
		end
	end
	
	return FirstRootPart, BladeHits -- Trả về phần gốc đầu tiên và danh sách các mục tiêu bị tấn công
end
function GetCombo()
	local Combo = if tick() - FastAttack.ComboDebounce <= 0.35 then FastAttack.M1Combo else 0
	Combo = if Combo >= 4 then 1 else Combo + 1
	
	FastAttack.ComboDebounce = tick()
	FastAttack.M1Combo = Combo
	
	return Combo
end
function UseFruitM1(Character, Equipped, Combo)
	local Position = Character:GetPivot().Position
	local EnemyList = Enemies:GetChildren()
	
	for i = 1, #EnemyList do
		local Enemy = EnemyList[i]
		local PrimaryPart = Enemy.PrimaryPart
		
		if IsAlive(Enemy) and PrimaryPart and (PrimaryPart.Position - Position).Magnitude <= 50 then
			local Direction = (PrimaryPart.Position - Position).Unit
			return Equipped.LeftClickRemote:FireServer(Direction, Combo)
		end
	end
end
function CheckStun(ToolTip, Character, Humanoid)
	local Stun = Character:FindFirstChild("Stun")
	local Busy = Character:FindFirstChild("Busy")
	if Humanoid.Sit and (ToolTip == "Sword" or ToolTip == "Melee" or ToolTip == "Gun") then
		return false
	elseif Stun and Stun.Value > 0 then -- {{ or Busy and Busy.Value }}
		return false
	end
	return true
end
function UseNormalClick(Humanoid, Character,Cooldown)
	local RootPart, BladeHits = GetAllBladeHits(Character)
	
	if RootPart then
		RegisterAttack:FireServer(Cooldown)
		RegisterHit:FireServer(RootPart, BladeHits)
	end
end
function attack()
    if not Settings.AutoClick or (tick() - 0) <= 1 then
        return 
    end
    if not IsAlive(Player.Character) then 
        return 
    end
    local Character = Player.Character
    local Humanoid = Character.Humanoid
    local Equipped = Character:FindFirstChildOfClass("Tool")
    local ToolTip = Equipped and Equipped.ToolTip
    local ToolName = Equipped and Equipped.Name
    if not Equipped or (ToolTip ~= "Melee" and ToolTip ~= "Blox Fruit" and ToolTip ~= "Sword") then
        return nil
    end
    local Cooldown = Equipped:FindFirstChild("Cooldown") and Equipped.Cooldown.Value or 0.25
    if (tick() - FastAttack.Debounce) >= Cooldown and CheckStun(ToolTip, Character, Humanoid) then
        local Combo = GetCombo()
        Cooldown += if Combo >= 4 then 0.15 else 0
        FastAttack.Equipped = Equipped
        FastAttack.Debounce = if Combo >= 4 then (tick() + 0.15) else tick()
        if ToolTip == "Blox Fruit" then
            if ToolName == "Ice-Ice" or ToolName == "Light-Light" then
                return UseNormalClick(Humanoid, Character, Cooldown)
            elseif Equipped:FindFirstChild("LeftClickRemote") then
                return UseFruitM1(Character, Equipped, Combo)
            end
        else
            return UseNormalClick(Humanoid, Character, Cooldown)
        end
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
local FarmTab = Window:CreateTab("Farm",4483362458)
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
FarmTab:CreateToggle({
	Name = "Farm Tiki",
	CurrentValue = false,
	Callback = function(value)
		_G.AutoFarmTiki = value
	end
})
