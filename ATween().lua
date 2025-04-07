local Player = game.Players.LocalPlayer
_G.speed = 350
_G.Tweening = true

-- Kiểm tra nhân vật sống
local function IsAlive(Character)
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    return Humanoid and Humanoid.Health > 0
end

-- Lấy BaseParts mới nhất
local function GetBaseParts(Character)
    local Parts = {}
    for _, v in pairs(Character:GetDescendants()) do
        if v:IsA("BasePart") and v.CanCollide then
            table.insert(Parts, v)
        end
    end
    return Parts
end

-- Tween di chuyển
function ATween1(TargetPosition)
    local Character = Player.Character or Player.CharacterAdded:Wait()
    if not IsAlive(Character) then return end

    if not Character.PrimaryPart then
        Character.PrimaryPart = Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("UpperTorso")
        if not Character.PrimaryPart then return end
    end

    local BodyPosition = Instance.new("BodyPosition")
    BodyPosition.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    BodyPosition.D = 100
    BodyPosition.P = _G.speed * 100 -- Có thể scale theo speed
    BodyPosition.Position = TargetPosition
    BodyPosition.Parent = Character.PrimaryPart

    local UpperTorso = Character:FindFirstChild("UpperTorso")
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")

    if UpperTorso and Humanoid then
        if Humanoid.Sit then
            Humanoid.Sit = false
            task.wait(0.1)
        end

        local BaseParts = GetBaseParts(Character)
        for _, part in pairs(BaseParts) do
            part.CanCollide = false
        end

        -- Di chuyển đến đích
        while IsAlive(Character) and _G.Tweening and BodyPosition do
            local dist = (UpperTorso.Position - TargetPosition).Magnitude
            if dist < 5 then break end
            task.wait(0.1)
        end

        -- Cleanup
        if BodyPosition then BodyPosition:Destroy() end
        for _, part in pairs(BaseParts) do
            part.CanCollide = true
        end
    end
end

-- Gọi hàm chính
if _G.Position then
    ATween1(_G.Position)
end
