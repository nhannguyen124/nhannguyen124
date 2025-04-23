local Settings, Connections = {},{}
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

function Tween()
	local BodyVelocity = Instance.new("BodyVelocity")
	BodyVelocity.Velocity = Vector3.zero
	BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	BodyVelocity.P = 1000
	
	if _ENV.tween_bodyvelocity then
		_ENV.tween_bodyvelocity:Destroy()
	end
	
	_ENV.tween_bodyvelocity = BodyVelocity
	local BaseParts, CanCollideObjects, CanTouchObjects = {}, {}, {} do
		local function AddObjectToBaseParts(Object)
			if Object:IsA("BasePart") and (Object.CanCollide or Object.CanTouch) then
				table.insert(BaseParts, Object)
				
				if Object.CanCollide then CanCollideObjects[Object] = true end
				if Object.CanTouch then CanTouchObjects[Object] = true end
			end
		end
		
		local function RemoveObjectsFromBaseParts(BasePart)
			local index = table.find(BaseParts, BasePart)
			
			if index then
				table.remove(BaseParts, index)
			end
		end
		
		local function NewCharacter(Character)
			table.clear(BaseParts)
			
			for _, Object in ipairs(Character:GetDescendants()) do AddObjectToBaseParts(Object) end
			Character.DescendantAdded:Connect(AddObjectToBaseParts)
			Character.DescendantRemoving:Connect(RemoveObjectsFromBaseParts)
			
			Character:WaitForChild("Humanoid", 9e9).Died:Wait()
			table.clear(BaseParts)
		end
		
		table.insert(Connections, Player.CharacterAdded:Connect(NewCharacter))
		task.spawn(NewCharacter, Player.Character)
	end
	
	local function NoClipOnStepped(Character)
		if not IsAlive(Character) then
			return nil
		end
		
		if _ENV.OnFarm and not Player:HasTag("Teleporting") then
			Player:AddTag("Teleporting")
		elseif not _ENV.OnFarm and Player:HasTag("Teleporting") then
			Player:RemoveTag("Teleporting")
		end
		
		if _ENV.OnFarm then
			for i = 1, #BaseParts do
				local BasePart = BaseParts[i]
				local CanTouchValue = if (tick() - 0) <= 1 then false else true
				
				if CanTouchObjects[BasePart] and BasePart.CanTouch ~= CanTouchValue then
					BasePart.CanTouch = CanTouchValue
				end
				if CanCollideObjects[BasePart] and BasePart.CanCollide then
					BasePart.CanCollide = false
				end
			end
		elseif Character.PrimaryPart and (not Character.PrimaryPart.CanCollide or not Character.PrimaryPart.CanTouch) then
			for i = 1, #BaseParts do
				local BasePart = BaseParts[i]
				
				if CanCollideObjects[BasePart] then
					BasePart.CanCollide = true
				end
				if CanTouchObjects[BasePart] then
					BasePart.CanTouch = true
				end
			end
		end
	end
	
	local function UpdateVelocityOnStepped(Character,TargetPosition)
		local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character and Character:FindFirstChild("Humanoid")
		local BodyVelocity = _ENV.tween_bodyvelocity
		if RootPart and Humanoid and Humanoid.Health > 0 then
			if _ENV.OnFarm then
				if BodyVelocity.Parent ~= RootPart then
					BodyVelocity.Parent = RootPart
				end
				BodyVelocity.Velocity = _G.TargetPosition and (_G.TargetPosition - RootPart.Position).unit * _G.TweenSpeed or Vector3.zero
			else
				if BodyVelocity.Parent then
					BodyVelocity.Parent = nil
				end
			end
		else
			if BodyVelocity.Parent then
				BodyVelocity.Parent = nil
			end
		end
	end
	local Character = Player.Character
	UpdateVelocityOnStepped(Character)
	NoClipOnStepped(Character)
end
spawn(function()
	while wait() do
		Tween()
	end
end)
