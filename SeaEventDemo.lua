local Module = {}
local Player = game.Players.LocalPlayer
local Stepped = game:GetService("RunService").Stepped
local Heartbeat = game:GetService("RunService").Heartbeat

local CachedChars = {} -- Bảng để lưu trữ các nhân vật đã được kiểm tra

local function GetCharacterHumanoid(Character)
    return Character:FindFirstChildOfClass("Humanoid"), false
end

local function IsAlive(Character)
    if Character then
        local Humanoid, NoCache = CachedChars[Character] or GetCharacterHumanoid(Character)
        
        if Humanoid then
            if NoCache ~= true and not CachedChars[Character] then
                CachedChars[Character] = Humanoid
            end
            
            return Humanoid.Health > 0
        end
    end
    return false
end

Module.IsAlive = IsAlive -- Thêm hàm IsAlive vào Module

Module.Tween = (function()
    if getgenv().TweenVelocity then
        return getgenv().TweenVelocity
    end

    local Velocity = Instance.new("BodyVelocity", workspace)
    Velocity.Name = "hidden_user_folder_ :)"
    Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    Velocity.Velocity = Vector3.zero

    getgenv().TweenVelocity = Velocity

    Stepped:Connect(function()
        local Character = Player.Character

        if getgenv().OnFarm and Velocity.Parent ~= nil and Character then
            for _, Part in Character:GetDescendants() do
                if Part:IsA("BasePart") and Part.CanCollide then
                    Part.CanCollide = false
                end
            end
        end
    end)

    Heartbeat:Connect(function()
        local Character = Player.Character
        local isAlive = IsAlive(Character)

        if isAlive and Velocity.Velocity ~= Vector3.zero and (not Character.Humanoid.SeatPart or not getgenv().OnFarm) then
            Velocity.Velocity = Vector3.zero
        end

        if getgenv().OnFarm and isAlive then
            if Velocity.Parent == nil then
                Velocity.Parent = Character.PrimaryPart
            end
        elseif Velocity.Parent ~= nil then
            Velocity.Parent = nil
        end
    end)

    return Velocity
end)()

return Module -- Kết thúc module tại đây
