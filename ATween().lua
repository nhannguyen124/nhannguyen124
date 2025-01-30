local Player = game.Players.LocalPlayer
_G.speed = 350
_G.Tweening = true -- Thiết lập trạng thái tweening
local function IsAlive(Character)
    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        return Humanoid and Humanoid.Health > 0
    end
    return false
end

-- Lấy tất cả BaseParts của nhân vật
local BaseParts = {}
for _, v in pairs(Player.Character:GetDescendants()) do
    if v:IsA("BasePart") and v.CanCollide then
        table.insert(BaseParts, v)
    end
end

-- Hàm di chuyển
function ATween1(TargetPosition)
    local Character = Player.Character or Player.CharacterAdded:Wait()
    if not IsAlive(Character) then return end

    local BodyPosition = Instance.new("BodyPosition")
    BodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    BodyPosition.D = 100 -- Độ dập tắt
    BodyPosition.P = 10000 -- Lực đẩy
    BodyPosition.Position = TargetPosition -- Vị trí mục tiêu
    BodyPosition.Parent = Character.PrimaryPart -- Gắn vào PrimaryPart

    local UpperTorso = Character:FindFirstChild("UpperTorso")
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")

    if UpperTorso and Humanoid then
        -- Xử lý trạng thái ngồi
        if Humanoid.Sit then
            Humanoid.Sit = false
            task.wait(0.1) -- Đợi trạng thái ngồi bị hủy
        end

        for i = 1, #BaseParts do
            BaseParts[i].CanCollide = false
        end

        -- Di chuyển đến vị trí mục tiêu
        while IsAlive(Character) and _G.Tweening do
            if (UpperTorso.Position - TargetPosition).magnitude < 5 then
                BodyPosition:Destroy() -- Gỡ bỏ BodyPosition khi đến đích
                break
            end
            task.wait(0.1)
        end

        -- Khôi phục CanCollide
        for i = 1, #BaseParts do
            BaseParts[i].CanCollide = true
        end
    end
end

-- Gọi hàm ATween với vị trí được chỉ định
ATween1(_G.Position)
