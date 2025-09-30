local Settings = {
	AutoClick= true
}
local AttackCooldown = 0
local Player = game.Players.LocalPlayer
local FastAttack = {
    Distance = 1000,            -- Khoảng cách tối đa để tấn công
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
function FastAttack:GetAllBladeHits(Character)
	local CFrame = Character:GetPivot().Position -- Lấy vị trí của nhân vật
	local BladeHits, FirstRootPart = {} -- Khởi tạo danh sách cho các mục tiêu bị tấn công
	local EnemyList = workspace.Enemies:GetChildren()
	for _, v in ipairs(workspace.Characters:GetChildren()) do
		if v ~= game.Players.LocalPlayer.Character then
			table.insert(EnemyList, v)
		end
	end
	for i = 1, #EnemyList do
		local Enemy = EnemyList[i]
		local RootPart = Enemy.PrimaryPart -- Lấy phần gốc (root part) của kẻ thù
		if RootPart and IsAlive(Enemy) and Player:DistanceFromCharacter(RootPart.Position) <= self.Distance then
			if not FirstRootPart then
				FirstRootPart = RootPart -- Lưu lại phần gốc đầu tiên để tấn công
			else
				table.insert(BladeHits, { Enemy, RootPart }) -- Thêm kẻ thù vào danh sách tấn công
			end
		end
	end
	
	return FirstRootPart, BladeHits -- Trả về phần gốc đầu tiên và danh sách các mục tiêu bị tấn công
end
function FastAttack:GetCombo()
	local Combo = if tick() - self.ComboDebounce <= 0.35 then self.M1Combo else 0
	Combo = if Combo >= 4 then 1 else Combo + 1
	
	self.ComboDebounce = tick()
	self.M1Combo = Combo
	
	return Combo
end
function FastAttack:UseFruitM1(Character, Equipped, Combo)
	local Position = Character:GetPivot().Position
	local EnemyList = workspace.Enemies:GetChildren()
	for _, v in pairs(workspace.Characters:GetChildren()) do
		table.insert(EnemyList, v)
	end
	for i = 1, #EnemyList do
		local Enemy = EnemyList[i]
		local PrimaryPart = Enemy.PrimaryPart
		
		if IsAlive(Enemy) and PrimaryPart and (PrimaryPart.Position - Position).Magnitude <= 50 then
			local Direction = (PrimaryPart.Position - Position).Unit
			return Equipped.LeftClickRemote:FireServer(Direction, Combo)
		end
	end
end
function FastAttack:CheckStun(ToolTip, Character, Humanoid)
	local Stun = Character:FindFirstChild("Stun")
	local Busy = Character:FindFirstChild("Busy")
	if Humanoid.Sit and (ToolTip == "Sword" or ToolTip == "Melee" or ToolTip == "Gun") then
		return false
	elseif Stun and Stun.Value > 0 then -- {{ or Busy and Busy.Value }}
		return false
	end
	return true
end
function FastAttack:UseNormalClick(Humanoid, Character)
	local RootPart, BladeHits = self:GetAllBladeHits(Character)
	
	if RootPart then
		RegisterAttack:FireServer(0.25)
		RegisterHit:FireServer(RootPart, BladeHits)
	end
end
function FastAttack.attack()
    if not Settings.AutoClick then return end
    if not IsAlive(Player.Character) then return end

    local self = FastAttack
    local Character = Player.Character
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local Equipped = Character:FindFirstChildOfClass("Tool")
    
    if not Humanoid or not Equipped then return end

    local ToolTip = Equipped.ToolTip
    local ToolName = Equipped.Name

    if ToolTip ~= "Melee" and ToolTip ~= "Sword" and ToolTip ~= "Blox Fruit" then return end

    local Cooldown = Equipped:FindFirstChild("Cooldown") and Equipped.Cooldown.Value or 0.25

    if (tick() - self.Debounce) >= Cooldown and self:CheckStun(ToolTip, Character, Humanoid) then
        local Combo = self:GetCombo()
        Cooldown += (Combo >= 4) and 0.15 or 0
        self.Equipped = Equipped
        self.Debounce = (Combo >= 4) and (tick() + 0.15) or tick()

        if ToolTip == "Blox Fruit" then
            if ToolName == "Ice-Ice" or ToolName == "Light-Light" then
                self:UseNormalClick(Humanoid, Character)
            elseif Equipped:FindFirstChild("LeftClickRemote") then
                self:UseFruitM1(Character, Equipped, Combo)
            end
        else
            self:UseNormalClick(Humanoid, Character)
        end
    end
end
while true do
	pcall(function()
		if _G.AutoAttack then
			FastAttack.attack()
		end
	end)
end
