local Player = game.Players.LocalPlayer
_G.speed = 350
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
local function ATween(TargetPosition)
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
        local distance = (UpperTorso.Position - TargetPosition).magnitude
        local timeToMove = distance / _G.speed
        local defaultWalkSpeed = Humanoid.WalkSpeed

        local RunService = game:GetService("RunService")
        local connection
        connection = RunService.Stepped:Connect(function()
            if IsAlive(Character) then
                BodyVelocity.Parent = UpperTorso
                BodyVelocity.Velocity = (TargetPosition - UpperTorso.Position).unit * _G.speed
                for i = 1, #BaseParts do
                    BaseParts[i].CanCollide = false
                end
                if (UpperTorso.Position - TargetPosition).magnitude < 5 then
                    BodyVelocity.Velocity = Vector3.zero
                    BodyVelocity:Destroy()
                    Character:SetPrimaryPartCFrame(CFrame.new(TargetPosition))
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
ATween(_G.Position)
