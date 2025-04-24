local Settings,Connections = {
	AutoClick = true,
	AutoShoot = true
},{}
local AttackCooldown = 0
local _ENV = (getgenv or getrenv or getfenv)()
local VirtualInputManager = game:GetService("VirtualInputManager")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local GunValidator: RemoteEvent = Remotes:WaitForChild("Validator2")
local CommF: RemoteFunction = Remotes:WaitForChild("CommF_")
local CommE: RemoteEvent = Remotes:WaitForChild("CommE")

local ChestModels: Folder = workspace:WaitForChild("ChestModels")
local WorldOrigin: Folder = workspace:WaitForChild("_WorldOrigin")
local Characters: Folder = workspace:WaitForChild("Characters")
local SeaBeasts: Folder = workspace:WaitForChild("SeaBeasts")
local Enemies: Folder = workspace:WaitForChild("Enemies")
local Map: Model = workspace:WaitForChild("Map")

local EnemySpawns: Folder = WorldOrigin:WaitForChild("EnemySpawns")
local Locations: Folder = WorldOrigin:WaitForChild("Locations")

local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat
local Stepped = RunService.Stepped
local Player = Players.LocalPlayer

local Data: Folder = Player:WaitForChild("Data")
local Level: IntValue = Data:WaitForChild("Level")
local Fragments: IntValue = Data:WaitForChild("Fragments")
local Money: IntValue = Data:WaitForChild("Beli")

local Modules: Folder? = ReplicatedStorage:WaitForChild("Modules")
local Net: ModuleScript = Modules:WaitForChild("Net")

local EXECUTOR_NAME: string = string.upper(if identifyexecutor then identifyexecutor() else "NULL")
local IS_BLACKLISTED_EXECUTOR: boolean? = table.find({"NULL", "SOLARA", "XENO", "SWIFT", "JJSPLOIT"}, EXECUTOR_NAME)

local hookmetamethod = (not IS_BLACKLISTED_EXECUTOR and hookmetamethod) or (function(...) return ... end)
local hookfunction = (not IS_BLACKLISTED_EXECUTOR and hookfunction) or (function(...) return ... end)
local sethiddenproperty = sethiddenproperty or (function(...) return ... end)

local setupvalue: (any, number, any?) -> (nil) = setupvalue or (debug and debug.setupvalue)
local getupvalue: (any, number) -> any = getupvalue or (debug and debug.getupvalue)

local BRING_TAG = _ENV._Bring_Tag or string.format("b%dt", math.random(80, 2e4))
local KILLAURA_TAG = _ENV._KillAura_Tag or string.format("k%dt", math.random(120, 2e4))



local HIDDEN_SETTINGS: { [string]: any } = {
	SKILL_COOLDOWN = 0.5,
	CLEAR_AFTER = 50
}

_ENV._Bring_Tag = BRING_TAG
_ENV._KillAura_Tag = KILLAURA_TAG
local function GetEnemyName(string: string): string
	return (string:find("Lv. ") and string:gsub(" %pLv. %d+%p", "") or string):gsub(" %pBoss%p", "")
end
local function GetCharacterHumanoid(Character)
	if Character:GetAttribute("IsBoat") or Character.Parent == SeaBeasts then
		if Character:FindFirstChild("Health") then
			return Character.Health
		end
	else
		return Character:FindFirstChildOfClass("Humanoid")
	end
end

local function CheckPlayerAlly(__Player: Player): boolean
	if tostring(__Player.Team) == "Marines" and __Player.Team == Player.Team then
		return false
	elseif __Player:HasTag(`Ally{Player.Name}`) or Player:HasTag(`Ally{__Player.Name}`) then
		return false
	end
	
	return true
end

local function WaitChilds(Instance, ...)
	for _, ChildName in ipairs({...}) do
		Instance = Instance:WaitForChild(ChildName)
	end
	return Instance
end

local function FastWait(Seconds, Instance, ...)
	local Success, Result = pcall(function(...)
		for _, ChildName in ipairs({...}) do
			Instance = Instance:WaitForChild(ChildName, Seconds)
		end
		return Instance
	end, ...)
	
	return Success and Result or nil
end

local function CreateNewClear()
	local COUNT_NEWINDEX = 0
	
	return {
		__newindex = function(self, index, value)
			if COUNT_NEWINDEX >= HIDDEN_SETTINGS.CLEAR_AFTER then
				for key, cache in pairs(self) do
					if typeof(cache) == "Instance" and not cache:IsDescendantOf(game) then
						rawset(self, key, nil)
					end
				end
				COUNT_NEWINDEX = 0
			end
			
			COUNT_NEWINDEX += 1
			return rawset(self, index, value)
		end
	}
end
local Cached = {
	Closest = nil,
	Equipped = nil,
	Humanoids = setmetatable({}, CreateNewClear()),
	Enemies = {},
	Progress = {},
	Bring = {},
	Tools = {}
}
function IsAlive(Character)
	if Character then
		local Humanoids = Cached.Humanoids
		local Humanoid = Humanoids[Character] or GetCharacterHumanoid(Character)
		
		if Humanoid then
			if not Humanoids[Character] then
				Humanoids[Character] = Humanoid
			end
			
			return Humanoid[if Humanoid.ClassName == "Humanoid" then "Health" else "Value"] > 0
		end
	end
end
function ToDictionary(array: { any }): { [any]: boolean }
	local Dictionary = {}
	
	for _, String in ipairs(array) do
		Dictionary[String] = true
	end
	
	return Dictionary
end

local Signal = {} do
	local Connection = {} do
		Connection.__index = Connection
		
		function Connection:Disconnect(): (nil)
			if not self.Connected then
				return nil
			end
			
			local find = table.find(self.Signal, self)
			
			if find then
				table.remove(self.Signal, find)
			end
			
			self.Function = nil
			self.Connected = false
		end
		
		function Connection:Fire(...): (nil)
			if not self.Function then
				return nil
			end
			
			task.spawn(self.Function, ...)
		end
		
		function Connection.new(): Connection
			return setmetatable({
				Connected = true
			}, Connection)
		end
		
		setmetatable(Connection, {
			__index = function(self, index)
				error(("Attempt to get Connection::%s (not a valid member)"):format(tostring(index)), 2)
			end,
			__newindex = function(tb, key, value)
				error(("Attempt to set Connection::%s (not a valid member)"):format(tostring(key)), 2)
			end
		})
	end
	
	Signal.__index = Signal
	
	function Signal:Connect(Function): Connection
		if type(Function) ~= "function" then
			return nil
		end
		
		local NewConnection = Connection.new()
		NewConnection.Function = Function
		NewConnection.Signal = self
		
		table.insert(self.Connections, NewConnection)
		return NewConnection
	end
	
	function Signal:Once(Function): (nil)
		local Connection;
		Connection = self:Connect(function(...)
			Function(...)
			Connection:Disconnect()
		end)
		return Connection
	end
	
	function Signal:Wait(): any?
		local WaitingCoroutine = coroutine.running()
		local Connection;Connection = self:Connect(function(...)
			Connection:Disconnect()
			task.spawn(WaitingCoroutine, ...)
		end)
		return coroutine.yield()
	end
	
	function Signal:Fire(...): (nil)
		for _, Connection in ipairs(self.Connections) do
			if Connection.Connected then
				Connection:Fire(...)
			end
		end
	end
	
	function Signal.new(): Signal
		return setmetatable({
			Connections = {}
		}, Signal)
	end
	
	setmetatable(Signal, {
		__index = function(self, index)
			error(`Attempt to get Signal::{ tostring(index) } (not a valid member)`, 2)
		end,
		__newindex = function(self, index, value)
			error(`Attempt to set Signal::{ tostring(index) } (not a valid member)`, 2)
		end
	})
end
Signals = {} do
	local SignalsTable = {}

	-- Khởi tạo tất cả các tín hiệu
	local SignalNames = {
		"PossibleStaff",
		"OptionChanged",
		"EnemyAdded",
		"EnemyDied",
		"Notify",
		"Error"
	}
	for _, name in ipairs(SignalNames) do
		SignalsTable[name] = Signal.new()
	end

	-- Xử lý lỗi khi tín hiệu Error được kích hoạt
	SignalsTable.Error:Connect(function(ErrorMessage)
		_ENV.loadedFarm = false
		_ENV.OnFarm = false

		local Message = Instance.new("Message", workspace)
		_ENV.redz_hub_error = Message
		Message.Text = (`redz-Hub error [ {Settings.RunningOption or "Null"} ] {ErrorMessage}`)
	end)
end
GameData = {
	Sea = ({ [2753915549] = 1, [4442272183] = 2, [7449423635] = 3 })[game.PlaceId] or 0,
	SeasName = { "Main", "Dressrosa", "Zou" },
	MaxMastery = 600,
	MaxLevel = 2600,
}
Enemies = (function()
	local EnemiesModule = {
		__CakePrince = {},
		__PirateRaid = {},
		__RaidBoss = {},
		__Bones = {},
		__Elite = {},
		__Others = {}
	}
	local SeaCastle = CFrame.new(-5556, 314, -2988)

	local Elites = ToDictionary({ "Deandre", "Diablo", "Urban" })
	local Bones = ToDictionary({ "Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy" })
	local CakePrince = ToDictionary({ "Head Baker", "Baking Staff", "Cake Guard", "Cookie Crafter" })
	
	local Attachment = Instance.new("Attachment")
	local AlignPosition = Instance.new("AlignPosition")
	AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
	AlignPosition.Position = Vector3.new(0, 20, 0)
	AlignPosition.Responsiveness = 200
	AlignPosition.MaxForce = math.huge
	AlignPosition.Attachment0 = Attachment
	AlignPosition.Parent = Attachment

	local function newEnemy(List, Enemy)
		if table.find(List, Enemy) then return end
		local Humanoid = Enemy:FindFirstChild("Humanoid")
		if Humanoid and Humanoid.Health > 0 then
			table.insert(List, Enemy)
			Humanoid.Died:Connect(function()
				table.remove(List, table.find(List, Enemy))
				for _, tagList in pairs(EnemiesModule.__Others) do
					table.remove(tagList, table.find(tagList, Enemy))
				end
			end)
		end
	end

	local function PirateRaidEnemy(Enemy)
		local Humanoid = Enemy:FindFirstChild("Humanoid")
		if not Humanoid or Humanoid.Health <= 0 then return end

		local HRP = Enemy:FindFirstChild("HumanoidRootPart")
		if HRP and (Enemy.Name ~= "rip_indra True Form" and Enemy.Name ~= "Blank Buddy") then
			if (HRP.Position - SeaCastle.Position).Magnitude <= 750 then
				task.spawn(newEnemy, EnemiesModule.__PirateRaid, Enemy)
				Module.PirateRaid = tick()
			end
		end
	end

	local function EnemyAdded(Enemy)
		local Name = Enemy.Name
		local Others = EnemiesModule.__Others

		if EnemiesModule[`__{Name}`] then
			task.spawn(newEnemy, EnemiesModule[`__{Name}`], Enemy)
		elseif Enemy:GetAttribute("RaidBoss") then
			task.spawn(newEnemy, EnemiesModule.__RaidBoss, Enemy)
		elseif Elites[Name] then
			task.spawn(newEnemy, EnemiesModule.__Elite, Enemy)
		elseif Bones[Name] then
			task.spawn(newEnemy, EnemiesModule.__Bones, Enemy)
		elseif CakePrince[Name] then
			task.spawn(newEnemy, EnemiesModule.__CakePrince, Enemy)
		end

		if GameData.Sea == 3 then
			task.spawn(PirateRaidEnemy, Enemy)
		end

		Others[Name] = Others[Name] or {}
		task.spawn(newEnemy, Others[Name], Enemy)
	end

	function EnemiesModule.IsSpawned(EnemyName)
		local Cached = Module.SpawnLocations[EnemyName]
		if Cached and Cached.Parent then
			return (Cached:GetAttribute("Active") or EnemiesModule:GetEnemyByTag(EnemyName)) and true or false
		end
		return EnemiesModule:GetEnemyByTag(EnemyName) and true or false
	end

	function EnemiesModule:GetTagged(TagName)
		return self[`__{TagName}`] or self.__Others[TagName]
	end

	function EnemiesModule:GetEnemyByTag(TagName)
		local CachedEnemy = Cached.Enemies[TagName]
		if CachedEnemy and IsAlive(CachedEnemy) then return CachedEnemy end

		local Enemies = self:GetTagged(TagName)
		if Enemies then
			for _, e in ipairs(Enemies) do
				if IsAlive(e) then
					Cached.Enemies[TagName] = e
					return e
				end
			end
		end
	end
	
	function EnemiesModule:GetClosest(Enemies)
		local SpecialTag = table.concat(Enemies, ".")
		local CachedEnemy = Cached.Enemies[SpecialTag]
		if CachedEnemy and IsAlive(CachedEnemy) then return CachedEnemy end

		local Distance, Nearest = math.huge
		for _, tag in ipairs(Enemies) do
			local Enemy = self:GetClosestByTag(tag)
			local Magnitude = Enemy and Player:DistanceFromCharacter(Enemy.PrimaryPart.Position)
			if Enemy and Magnitude <= Distance then
				Distance, Nearest = Magnitude, Enemy
			end
		end

		if Nearest then
			Cached.Enemies[SpecialTag] = Nearest
			return Nearest
		end
	end

	function EnemiesModule:GetClosestByTag(TagName)
		local CachedEnemy = Cached.Enemies[TagName]
		if CachedEnemy and IsAlive(CachedEnemy) then return CachedEnemy end

		local Enemies = self:GetTagged(TagName)
		if Enemies then
			local Distance, Nearest = math.huge
			local Position = (Player.Character or Player.CharacterAdded:Wait()):GetPivot().Position
			for _, Enemy in ipairs(Enemies) do
				local Part = Enemy.PrimaryPart
				if Part and IsAlive(Enemy) then
					local Magnitude = (Position - Part.Position).Magnitude
					if Magnitude <= 15 then
						Cached.Enemies[TagName] = Enemy
						return Enemy
					elseif Magnitude <= Distance then
						Distance, Nearest = Magnitude, Enemy
					end
				end
			end
			if Nearest then
				Cached.Enemies[TagName] = Nearest
				return Nearest
			end
		end
	end

	function EnemiesModule:CreateNewTag(Tag, EnemyNames)
		local NewTag = {}
		self[`__{Tag}`] = NewTag
		for _, Name in ipairs(EnemyNames) do
			self[`__{Name}`] = NewTag
			local Others = self.__Others[Name]
			if Others then
				for _, Enemy in ipairs(Others) do
					task.spawn(newEnemy, NewTag, Enemy)
				end
			end
		end
		return NewTag
	end

	local function Bring(Enemy)
		local RootPart = Enemy:FindFirstChild("HumanoidRootPart")
		local Humanoid = Enemy:FindFirstChild("Humanoid")
		local Name = Enemy.Name

		local Clone = Attachment:Clone()
		local Align = Clone.AlignPosition
		Clone.Parent = RootPart

		while Enemy and Enemy.Parent and Enemy:HasTag(BRING_TAG) do
			if not Humanoid or Humanoid.Health <= 0 then break end
			if not RootPart or RootPart.Parent ~= Enemy then break end

			local Target = Cached.Bring[Module.IsSuperBring and "ALL_MOBS" or Name]
			if Target and (Target.Position - RootPart.Position).Magnitude <= Settings.BringDistance then
				if Align.Position ~= Target.Position then
					Align.Position = Target.Position
				end
			else
				break
			end
			task.wait()
		end

		if Enemy and Enemy:HasTag(BRING_TAG) then Enemy:RemoveTag(BRING_TAG) end
		if Clone then Clone:Destroy() end
	end
	local function KillAura(Enemy)
		local Humanoid = Enemy:FindFirstChild("Humanoid")
		local RootPart = Enemy:FindFirstChild("HumanoidRootPart")

		pcall(sethiddenproperty, Player, "SimulationRadius", math.huge)

		if Humanoid and RootPart then
			RootPart.CanCollide = false
			RootPart.Size = Vector3.new(60, 60, 60)
			Humanoid:ChangeState(15)
			Humanoid.Health = 0
			task.wait()
			Enemy:RemoveTag(KILLAURA_TAG)
		end
	end

	for _, Enemy in CollectionService:GetTagged("BasicMob") do
		EnemyAdded(Enemy)
	end

	table.insert(Connections, CollectionService:GetInstanceAddedSignal("BasicMob"):Connect(EnemyAdded))
	table.insert(Connections, CollectionService:GetInstanceAddedSignal(KILLAURA_TAG):Connect(KillAura))
	table.insert(Connections, CollectionService:GetInstanceAddedSignal(BRING_TAG):Connect(Bring))

	return EnemiesModule
end)()
_G.FastAttack = (function()
	local FastAttack = {
		Distance = 50,
		attackMobs = true,
		attackPlayers = true,
		Equipped = nil,
		Debounce = 0,
		ComboDebounce = 0,
		ShootDebounce = 0,
		M1Combo = 0,
		
		Overheat = {
			["Dragonstorm"] = {
				MaxOverheat = 3,
				Cooldown = 0,
				TotalOverheat = 0,
				Distance = 350,
				Shooting = false
			}
		},
		ShootsPerTarget = {
			["Dual Flintlock"] = 2
		},
		SpecialShoots = {
			["Skull Guitar"] = "TAP",
			["Bazooka"] = "Position",
			["Cannon"] = "Position",
			["Dragonstorm"] = "Overheat"
		},
		HitboxLimbs = {"RightLowerArm", "RightUpperArm", "LeftLowerArm", "LeftUpperArm", "RightHand", "LeftHand"}
	}
	
	local RE_RegisterAttack = Net:WaitForChild("RE/RegisterAttack")
	local RE_ShootGunEvent = Net:WaitForChild("RE/ShootGunEvent")
	local RE_RegisterHit = Net:WaitForChild("RE/RegisterHit")
	local Events = ReplicatedStorage:WaitForChild("Events")
	
	local SUCCESS_FLAGS, COMBAT_REMOTE_THREAD = pcall(function()
		return require(Modules.Flags).COMBAT_REMOTE_THREAD or false
	end)
	
	local SUCCESS_SHOOT, SHOOT_FUNCTION = pcall(function()
		return getupvalue(require(ReplicatedStorage.Controllers.CombatController).Attack, 9)
	end)
	FastAttack.ShootsFunctions = {
		["Skull Guitar"] = function(self: FastAttack, Equipped: Tool, Position: Vector3)
			Events.ShootSoulGuitar:Invoke(Position) -- Equipped.RemoteEvent:FireServer("TAP", Position)
		end
	}
	
	function FastAttack:ShootInTarget(TargetPosition: Vector3): (nil)
		local Equipped = IsAlive(Player.Character) and Player.Character:FindFirstChildOfClass("Tool")
		
		if Equipped and Equipped.ToolTip == "Gun" then
			if Equipped:FindFirstChild("Cooldown") and (tick() - self.ShootDebounce) >= Equipped.Cooldown.Value then
				if self.ShootsFunctions[Equipped.Name] then
					return self.ShootsFunctions[Equipped.Name](self, Equipped, TargetPosition)
				end
				
				if SUCCESS_SHOOT and SHOOT_FUNCTION then
					local ShootType = self.SpecialShoots[Equipped.Name] or "Normal"
					
					if ShootType == "Position" or (ShootType == "TAP" and Equipped:FindFirstChild("RemoteEvent")) then
						Equipped:SetAttribute("LocalTotalShots", (Equipped:GetAttribute("LocalTotalShots") or 0) + 1)
						GunValidator:FireServer(self:GetValidator2())
						
						if ShootType == "TAP" then
							Equipped.RemoteEvent:FireServer("TAP", TargetPosition)
						else
							RE_ShootGunEvent:FireServer(TargetPosition)
						end
						
						self.ShootDebounce = tick()
					end
				else
					VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1);task.wait(0.05)
					VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1);task.wait(0.05)
					self.ShootDebounce = tick()
				end
			end
		end
	end
	
	function FastAttack:CheckStun(ToolTip: string, Character: Character, Humanoid: Humanoid): boolean
		local Stun = Character:FindFirstChild("Stun")
		local Busy = Character:FindFirstChild("Busy")
		
		if Humanoid.Sit and (ToolTip == "Sword" or ToolTip == "Melee" or ToolTip == "Gun") then
			return false
		elseif Stun and Stun.Value > 0 then -- {{ or Busy and Busy.Value }}
			return false
		end
		
		return true
	end
	
	function FastAttack:Process(assert: boolean, Enemies: Folder, BladeHits: table, Position: Vector3, Distance: number): (nil)
		if not assert then return end
		
		local HitboxLimbs = self.HitboxLimbs
		local Mobs = workspace.Enemies:GetChildren()
		
		for i = 1, #Mobs do
			local Enemy = Mobs[i]
			local BasePart = Enemy:FindFirstChild(HitboxLimbs[math.random(#HitboxLimbs)]) or Enemy.PrimaryPart
			
			if not BasePart then continue end
			
			local CanAttack = Enemy.Parent == Characters and CheckPlayerAlly(Players:GetPlayerFromCharacter(Enemy))
			
			if Enemy ~= Player.Character and (Enemy.Parent ~= Characters or CanAttack) then
				if IsAlive(Enemy) and (Position - BasePart.Position).Magnitude <= Distance then
					if not self.EnemyRootPart then
						self.EnemyRootPart = BasePart
					else
						table.insert(BladeHits, { Enemy, BasePart })
					end
				end
			end
		end
	end
	
	function FastAttack:GetAllBladeHits(Character: Character, Distance: number?): (nil)
		local Position = Character:GetPivot().Position
		local BladeHits = {}
		Distance = Distance or self.Distance
		
		self:Process(self.attackMobs, Enemies, BladeHits, Position, Distance)
		self:Process(self.attackPlayers, Characters, BladeHits, Position, Distance)
		
		return BladeHits
	end
	
	function FastAttack:GetClosestEnemy(Character: Character, Distance: number?): (nil)
		local BladeHits = self:GetAllBladeHits(Character, Distance)
		
		local Distance, Closest = math.huge
		
		for i = 1, #BladeHits do
			local Magnitude = if Closest then (Closest.Position - BladeHits[i][2].Position).Magnitude else Distance
			
			if Magnitude <= Distance then
				Distance, Closest = Magnitude, BladeHits[i][2]
			end
		end
		
		return Closest
	end
	
	function FastAttack:GetGunHits(Character: Character, Distance: number?)
		local BladeHits = self:GetAllBladeHits(Character, Distance)
		local GunHits = {}
		
		for i = 1, #BladeHits do
			if not GunHits[1] or (BladeHits[i][2].Position - GunHits[1].Position).Magnitude <= 10 then
				table.insert(GunHits, BladeHits[i][2])
			end
		end
		
		return GunHits
	end
	
	function FastAttack:GetCombo(): number
		local Combo = if tick() - self.ComboDebounce <= 0.4 then self.M1Combo else 0
		Combo = if Combo >= 4 then 1 else Combo + 1
		
		self.ComboDebounce = tick()
		self.M1Combo = Combo
		
		return Combo
	end
	
	function FastAttack:UseFruitM1(Character: Character, Equipped: Tool, Combo: number): (nil)
		local Position = Character:GetPivot().Position
		local EnemyList = workspace.Enemies:GetChildren()
		
		for i = 1, #EnemyList do
			local Enemy = EnemyList[i]
			local PrimaryPart = Enemy.PrimaryPart
			if IsAlive(Enemy) and PrimaryPart and (PrimaryPart.Position - Position).Magnitude <= 50 then
				local Direction = (PrimaryPart.Position - Position).Unit
				return Equipped.LeftClickRemote:FireServer(Direction, Combo)
			end
		end
		local PlayerList = workspace.Characters:GetChildren()
		for i = 1, #PlayerList do
			local Enemy = PlayerList[i]
			local PrimaryPart = Enemy.PrimaryPart
			if IsAlive(Enemy) and PrimaryPart and (PrimaryPart.Position - Position).Magnitude <= 50 and Enemy ~= Player then
				local Direction = (PrimaryPart.Position - Position).Unit
				return Equipped.LeftClickRemote:FireServer(Direction, Combo)
			end
		end
	end
	
	function FastAttack:GetValidator2()
		local v1 = getupvalue(SHOOT_FUNCTION, 15) -- v40, 15
		local v2 = getupvalue(SHOOT_FUNCTION, 13) -- v41, 13
		local v3 = getupvalue(SHOOT_FUNCTION, 16) -- v42, 16
		local v4 = getupvalue(SHOOT_FUNCTION, 17) -- v43, 17
		local v5 = getupvalue(SHOOT_FUNCTION, 14) -- v44, 14
		local v6 = getupvalue(SHOOT_FUNCTION, 12) -- v45, 12
		local v7 = getupvalue(SHOOT_FUNCTION, 18) -- v46, 18
		
		local v8 = v6 * v2									-- v133
		local v9 = (v5 * v2 + v6 * v1) % v3 -- v134
		
		v9 = (v9 * v3 + v8) % v4
		v5 = math.floor(v9 / v3)
		v6 = v9 - v5 * v3
		v7 = v7 + 1
		
		setupvalue(SHOOT_FUNCTION, 15, v1) -- v40, 15
		setupvalue(SHOOT_FUNCTION, 13, v2) -- v41, 13
		setupvalue(SHOOT_FUNCTION, 16, v3) -- v42, 16
		setupvalue(SHOOT_FUNCTION, 17, v4) -- v43, 17
		setupvalue(SHOOT_FUNCTION, 14, v5) -- v44, 14
		setupvalue(SHOOT_FUNCTION, 12, v6) -- v45, 12
		setupvalue(SHOOT_FUNCTION, 18, v7) -- v46, 18
		
		return math.floor(v9 / v4 * 16777215), v7
	end
	
	function FastAttack:UseGunShoot(Character, Equipped)
		if not Equipped.Enabled then return end
		
		local ShootType = self.SpecialShoots[Equipped.Name] or "Normal"
		
		if ShootType == "Normal" or ShootType == "Overheat" then
			if ShootType == "Overheat" then
				local Data = self.Overheat[Equipped.Name]
				
				if Data.Shooting then
					return nil
				end
				
				local Target = self:GetClosestEnemy(Character, Data.Distance or 100)
				
				if Target then
					Data.Shooting = true
					
					while Equipped and Equipped.Parent == Player.Character and Data.TotalOverheat < Data.MaxOverheat do
						if Target and Target.Parent and IsAlive(Target.Parent) then
							Equipped:SetAttribute("LocalTotalShots", (Equipped:GetAttribute("LocalTotalShots") or 0) + 1)
							GunValidator:FireServer(self:GetValidator2())
							RE_ShootGunEvent:FireServer(Target.Position, { Target })
							Data.TotalOverheat += task.wait(Data.Cooldown)
						else
							break
						end
					end
					
					while Data.TotalOverheat > 0 do
						Data.TotalOverheat = math.clamp(Data.TotalOverheat - task.wait(), 0, Data.MaxOverheat)
					end
					
					Data.Shooting = false
				end
			else
				local Hits = self:GetGunHits(Character, 120)
				local Target = Hits[1] and Hits[1].Position
				
				if Target then
					Equipped:SetAttribute("LocalTotalShots", (Equipped:GetAttribute("LocalTotalShots") or 0) + 1)
					GunValidator:FireServer(self:GetValidator2())
					
					for i = 1, (self.ShootsPerTarget[Equipped.Name] or 1) do
						RE_ShootGunEvent:FireServer(Target, Hits)
					end
				end
			end
		elseif ShootType == "Position" or (ShootType == "TAP" and Equipped:FindFirstChild("RemoteEvent")) then
			local Target = self:GetClosestEnemy(Character, 200)
			
			if Target then
				if self.ShootsFunctions[Equipped.Name] then
					return self.ShootsFunctions[Equipped.Name](self, Equipped, Target.Position)
				end
				
				Equipped:SetAttribute("LocalTotalShots", (Equipped:GetAttribute("LocalTotalShots") or 0) + 1)
				GunValidator:FireServer(self:GetValidator2())
				
				if ShootType == "TAP" then
					Equipped.RemoteEvent:FireServer("TAP", Target.Position)
				else
					RE_ShootGunEvent:FireServer(Target.Position)
				end
			end
		end
	end
	function FastAttack:UseNormalClick(Humanoid: Humanoid, Character: Character)
		local RootPart, BladeHits = Character.HumanoidRootPart,self:GetAllBladeHits(Character)
		if RootPart then
			RE_RegisterAttack:FireServer(0.3)
			RE_RegisterHit:FireServer(RootPart, BladeHits)
		end
	end
	function FastAttack.attack()
		if not Settings.AutoClick or (tick() - AttackCooldown) <= 1 then return end
		if not IsAlive(Player.Character) then return end
		
		local self = FastAttack
		local Character = Player.Character
		local Humanoid = Character.Humanoid
		
		local Equipped = Character:FindFirstChildOfClass("Tool")
		local ToolTip = Equipped and Equipped.ToolTip
		local ToolName = Equipped and Equipped.Name
		
		if not Equipped or (ToolTip ~= "Gun" and ToolTip ~= "Melee" and ToolTip ~= "Blox Fruit" and ToolTip ~= "Sword") then
			return nil
		end
		
		local Cooldown = Equipped:FindFirstChild("Cooldown") and Equipped.Cooldown.Value or 0.3
		if (tick() - self.Debounce) >= Cooldown and self:CheckStun(ToolTip, Character, Humanoid) then
			local Combo = self:GetCombo()
			Cooldown += if Combo >= 4 then 0.05 else 0
			
			self.Equipped = Equipped
			self.Debounce = if Combo >= 4 and ToolTip ~= "Gun" then (tick() + 0.05) else tick()
				
			if ToolTip == "Blox Fruit" then
				if ToolName == "Ice-Ice" or ToolName == "Light-Light" then
					return self:UseNormalClick(Humanoid, Character)
				elseif Equipped:FindFirstChild("LeftClickRemote") then
					return self:UseFruitM1(Character, Equipped, Combo)
				end
			elseif ToolTip == "Gun" then
				if SUCCESS_SHOOT and SHOOT_FUNCTION and Settings.AutoShoot then
					return self:UseGunShoot(Character, Equipped)
				end
			else
				return self:UseNormalClick(Humanoid, Character)
			end
		end
	end
	return FastAttack
end)()
