local Player = game.Players.LocalPlayer
_G.TweenSpeed = _G.TweenSpeed or 350
_G.Tweening = true -- bật trạng thái Tween

-- Kiểm tra nhân vật còn sống
local function IsAlive(Character)
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	return Humanoid and Humanoid.Health > 0
end

-- Trả về tất cả BasePart có CanCollide = true
local function GetBaseParts()
	local BaseParts = {}
	for _, v in pairs(Player.Character:GetDescendants()) do
		if v:IsA("BasePart") and v.CanCollide then
			table.insert(BaseParts, v)
		end
	end
	return BaseParts
end
function ATween(Pos: Vector3)
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end
    local root = char.HumanoidRootPart
    local humanoid = char.Humanoid
    local targetCFrame = CFrame.new(Pos)
    local distance = (targetCFrame.Position - root.Position).Magnitude
    if humanoid.Sit then
        humanoid.Sit = false
    end
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(distance / 500, Enum.EasingStyle.Linear)
    local tween
    local success = pcall(function()
        tween = tweenService:Create(root, tweenInfo, {CFrame = targetCFrame})
    end)
    if success and tween and _G.OnFarm then
        tween:Play()
        if _G.StopTween then
            tween:Cancel()
            _G.Clip = false
        end
		tween.Completed:Wait()
    end
end
function ATween1(TargetPosition)
	if TargetPosition and _G.OnFarm and _G.Tweening then
		local Character = Player.Character or Player.CharacterAdded:Wait()
		if not IsAlive(Character) then return end

		local HRP = Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		if not HRP or not Humanoid then return end
		local Direction = (TargetPosition - HRP.Position)
		local Distance = Direction.Magnitude
		local Duration = Distance / _G.TweenSpeed
		if Distance <= 210 then
			ATween(TargetPosition)
		else
			if Humanoid.Sit then
				Humanoid.Sit = false
				task.wait(0.1)
			end
			if _G.tween_bodyvelocity then
				_G.tween_bodyvelocity:Destroy()
			end
			local BodyVelocity = Instance.new("BodyVelocity")
			BodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
			BodyVelocity.P = 1000
			BodyVelocity.Velocity = Vector3.zero
			_G.tween_bodyvelocity = BodyVelocity

			local BaseParts = GetBaseParts()

			-- Gỡ CanCollide khi Tween
			for i = 1, #BaseParts do
				pcall(function()
					BaseParts[i].CanCollide = false
				end)
			end
			BodyVelocity.Parent = HRP
			BodyVelocity.Velocity = Direction.Unit * _G.TweenSpeed
			wait(0.1)
			if BodyVelocity then BodyVelocity:Destroy() end
		end
	end
end
spawn(function()
	while wait() do
		pcall(function() ATween1(_G.TargetPosition) end)
	end
end
