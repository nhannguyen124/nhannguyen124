_G.Speed      = 350
local Players = game:GetService("Players")
function ATween(Pos)
    local Pos              = Vector3.new(Pos)
    local Player           = Players.LocalPlayer
    local Character        = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    local distance         = (Pos - HumanoidRootPart.Position).Magnitude
    if distance <= 350 then
        HumanoidRootPart.CFrame = Pos
    else
        -- Nếu khoảng cách lớn hơn 350, sử dụng BodyVelocity để di chuyển
        local direction       = (Pos - HumanoidRootPart.Position).Unit
        local bodyVelocity    = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = direction * _G.Speed
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Parent   = HumanoidRootPart

        local connection
        connection = game:GetService("RunService").Stepped:Connect(function()
            local distance = (Pos.Position - HumanoidRootPart.Position).Magnitude
            if distance <= 350 then
                HumanoidRootPart.CFrame = Pos
            elseif _G.StopTween then
                -- Đến gần đích hoặc yêu cầu dừng, hủy BodyVelocity
                bodyVelocity:Destroy()
                connection:Disconnect()
            else
                for _, v in pairs(Character:GetChildren()) do
                    if v:IsA("Part") or v:IsA("MeshPart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end
end
ATween(1000,1000,1000)
