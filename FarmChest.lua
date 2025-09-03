local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
loadstring(game:HttpGet("https://raw.githubusercontent.com/nhannguyen124/nhannguyen124/refs/heads/main/TweenTesting.lua"))()
_G.OnFarm = true
function GetNearestChest(SelectedIsland)
    local char = Player.Character or Player.CharacterAdded:Wait()
    local position = char:GetPivot().Position
    local chests = game:GetService("CollectionService"):GetTagged("_ChestTagged")
    local nearest, shortestDistance = nil, math.huge

    for i = 1, #chests do
        local chest = chests[i]
        if not chest:GetAttribute("IsDisabled") and (not SelectedIsland or chest:IsDescendantOf(SelectedIsland)) then
            local distance = (chest:GetPivot().Position - position).Magnitude
            if distance < shortestDistance then
                nearest, shortestDistance = chest, distance
            end
        end
    end
	if _G.AFC then
    	return nearest
	else
		return false
	end
end
function Tween(pos: Vector3)
    if _G.StopTween then
        _G.StopTween = false
    end
    if not _G.Tweening then
        _G.Tweening = true
    end
    _G.TargetPosition = pos
end
function StopTween()
    _G.Tweening = false
    _G.StopTween = true
    _G.TargetPosition = nil
end
_G.Tweening = false
_G.StopTween = false
RunService.Heartbeat:Connect(function()
	local chest = GetNearestChest()
	if chest then
		local HRP = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
		if HRP then
			local chestPos = chest:GetPivot().Position
			HRP.CFrame = CFrame.new(HRP.Position.X, chestPos.Y, HRP.Position.Z)
			Tween(chestPos)
		end
	end
end)
