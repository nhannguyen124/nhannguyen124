local Player = game.Players.LocalPlayer
_G.TweenSpeed = _G.TweenSpeed or 300
_G.Tweening = true
local function IsAlive(Character)
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	return Humanoid and Humanoid.Health > 0
end
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
	local char = Player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end
	local root = char.HumanoidRootPart
	local humanoid = char.Humanoid
	local targetCFrame = CFrame.new(Pos)
	local distance = (targetCFrame.Position - root.Position).Magnitude

	if humanoid.Sit then
		humanoid.Sit = false
	end

	local tweenInfo = TweenInfo.new(distance / 5000, Enum.EasingStyle.Linear)
	local tween = game:GetService("TweenService"):Create(root, tweenInfo, {CFrame = targetCFrame})

	if distance <= 250 then
		tween:Cancel()
		root.CFrame = targetCFrame
		return
	end

	tween:Play()
	coroutine.wrap(function()
		while tween.PlaybackState == Enum.PlaybackState.Playing do
			if _G.StopTween then
				tween:Cancel()
				_G.Clip = false
				break
			end
			task.wait()
		end
	end)()
end
function ATween1(TargetPosition)
	local Character = Player.Character or Player.CharacterAdded:Wait()
	if typeof(TargetPosition) ~= "Vector3" or not IsAlive(Character) then return end

	local HRP = Character:FindFirstChild("HumanoidRootPart")
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if not HRP or not Humanoid then return end

	local Direction = (TargetPosition - HRP.Position)
	local Distance = Direction.Magnitude

	if Distance <= 210 then
		ATween(TargetPosition)
	else
		if Humanoid.Sit then
			Humanoid.Sit = false
			task.wait(0.1)
		end
		if _G.tween_bodyvelocity then _G.tween_bodyvelocity:Destroy() end
		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		BodyVelocity.P = 1000
		BodyVelocity.Velocity = Direction.Unit * _G.TweenSpeed
		_G.tween_bodyvelocity = BodyVelocity
		BodyVelocity.Parent = HRP
		local BaseParts = GetBaseParts()
		for i = 1, #BaseParts do
			pcall(function() BaseParts[i].CanCollide = false end)
		end
		if BodyVelocity then BodyVelocity:Destroy() end
	end
end
ATween1(_G.TargetPosition)
