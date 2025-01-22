_G.AutoFMode = "TikiF"
_G.AutoFarm = true
_G.StopTween = false
local Pos = nil
function ATween(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
    pcall(function() tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/210, Enum.EasingStyle.Linear),{CFrame = Pos}) end)
    tween:Play()
    if Distance <= 250 then
        tween:Cancel()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    end
    if _G.StopTween == true then
        tween:Cancel()
        _G.Clip = false
    end
end
local Settings = {
	AutoClick= true
}
local Tiki =  workspace.Map:FindFirstChild("TikiOutpost")
if Tiki then
	Tiki:Destroy()
end
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
function IsAlive(Character: Model?)
    if Character then
		local Humanoid = Character:FindFirstChild('Humanoid')
        if Humanoid and Humanoid.Health > 0 then
			return true
        end
    end
    return false
end
local Player = game.Players.LocalPlayer
_G.speed = 350
local BaseParts = {}
function ATween1(x,y,z)
	local TargetPosition = Vector3.new(x, y, z)
    local Character = Player.Character or Player.CharacterAdded:Wait()
    if not IsAlive(Character) then return end
	table.clear(BaseParts)
	for _, v in pairs(Player.Character:GetDescendants()) do
		if v:IsA("BasePart") and v.CanCollide then
			table.insert(BaseParts, v)
		end
	end
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
            if IsAlive(Character) then
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
            end
        end)
        task.wait(timeToMove)
        for i = 1, #BaseParts do
            BaseParts[i].CanCollide = true
        end
    end
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
local Enemies = workspace.Enemies
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
	elseif Stun and Stun.Value > 0 then
		return false
	end
	return true
end
function UseNormalClick(Humanoid, Character)
	local RootPart, BladeHits = GetAllBladeHits(Character)
	
	if RootPart then
		RegisterAttack:FireServer(0.25)
		RegisterHit:FireServer(RootPart, BladeHits)
	end
end
function attack()
    if not Settings.AutoClick or (tick() - AttackCooldown) <= 1 then
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
function AutoHaki()
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end
function Brings(Name,x,y,z)
	local Pos = CFrame.new(x,y,z)
	for _, v in pairs(workspace.Enemies:GetChildren()) do
		if v.Name == Name and (v.PrimaryPart.Position - Pos.Position).Magnitude <= 250 then
			v.PrimaryPart.CFrame = Pos
			v.Humanoid.WalkSpeed = 0
			v.Humanoid.JumpPower = 0
			v.PrimaryPart.CanCollide = false
		end
	end
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
_G.SelectWeapon = _G.SelectWeapon or "Melee"
task.spawn(function()
	while wait() do
		pcall(function()
			if _G.SelectWeapon == "Melee" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Melee" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			elseif _G.SelectWeapon == "Sword" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Sword" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			elseif _G.SelectWeapon == "Gun" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Gun" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			elseif _G.SelectWeapon == "Fruit" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Blox Fruit" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			end
		end)
	end
end)
function EquipWeapon(ToolSe)
    if not _G.NotAutoEquip then
        if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
            Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
            wait(.1)
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
        end
    end
end
while wait() do
    if _G.AutoFMode == "TikiF" and _G.AutoFarm then
        local foundEnemy = false
        for _, v in pairs(workspace.Enemies:GetChildren()) do
            if v.Name == "Serpent Hunter" or 
               v.Name == "Isle Outlaw" or 
               v.Name == "Island Boy" or 
               v.Name == "Isle Champion" or 
               v.Name == "Skull Slayer" or 
               v.Name == "Sun-kissed Warrior" then
                foundEnemy = true
                repeat task.wait()
                    if v.Name == "Serpent Hunter" then
                        Brings(v.Name, -16595.294921875, 112.61631774902344, 1369.0260009765625)
                        Brings(v.Name, -16501.435546875, 76.83646392822266, 1701.9688720703125)
                    elseif v.Name == "Isle Outlaw" then
                        Brings(v.Name, -16276.8359375, 27.25471305847168, -203.26133728027344)
                    elseif v.Name == "Island Boy" then
                        Brings(v.Name, -16817.173828125, 27.637248992919922, -161.99288940429688)
                    elseif v.Name == "Isle Champion" then
                        Brings(v.Name, -16795.30078125, 27.25471305847168, 1053.7841796875)
                    elseif v.Name == "Skull Slayer" then
                        Brings(v.Name, -16501.435546875, 30.83646392822266, 1701.9688720703125)
                    elseif v.Name == "Sun-kissed Warrior" then
                        Brings(v.Name, -16264.2236328125, 27.254718780517578, 1017.7523193359375)
                    end
                    EquipWeapon(_G.SelectWeapon)
                    AutoHaki()
                    if IsAlive(v) then
                        local targetCFrame = _G.SelectWeapon ~= "Blox Fruit" 
                            and CFrame.new(0, 20, 0) 
                            or CFrame.new(20, 0, 0)
                        ATween(v.PrimaryPart.CFrame * targetCFrame)
                    end
                    attack()
                until not _G.AutoFMode == "TikiF" and _G.AutoFarm or not v.Parent or v.Humanoid.Health == 0
            end
        end
        if not foundEnemy then
            ATween1(-16270.119140625, 96.40803527832031, 1042.4984130859375)
            wait(2)
        end
    end
end
