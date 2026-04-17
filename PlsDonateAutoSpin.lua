local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local lastValue = player:GetAttribute("RaisedNumber") or 0
local spinning = false
local function SpinN(times, speed)
    if spinning or times <= 0 then return end
    spinning = true
    speed = speed or 180
    local total = 0
    local target = 360 * times
    local conn
    conn = RunService.Heartbeat:Connect(function(dt)
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local rotate = speed * dt
        total += rotate
        if total >= target then
            rotate = rotate - (total - target)
            conn:Disconnect()
            spinning = false
        end
        hrp.CFrame *= CFrame.Angles(0, math.rad(rotate), 0)
    end)
end
player:GetAttributeChangedSignal("RaisedNumber"):Connect(function()
    local newValue = player:GetAttribute("RaisedNumber") or 0
    local diff = newValue - lastValue
    lastValue = newValue
    
    if diff > 0 then
        SpinN(diff)
    end
end)
wait(0.5)local ba=Instance.new("ScreenGui")
local ca=Instance.new("TextLabel")local da=Instance.new("Frame")
local _b=Instance.new("TextLabel")local ab=Instance.new("TextLabel")ba.Parent=game.CoreGui
ba.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;ca.Parent=ba;ca.Active=true
ca.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)ca.Draggable=true
ca.Position=UDim2.new(0.698610067,0,0.098096624,0)ca.Size=UDim2.new(0,370,0,52)
ca.Font=Enum.Font.SourceSansSemibold;ca.Text="Auto Spin"ca.TextColor3=Color3.new(0,1,1)
ca.TextSize=22;da.Parent=ca
da.BackgroundColor3=Color3.new(0.196078,0.196078,0.196078)da.Position=UDim2.new(0,0,1.0192306,0)
da.Size=UDim2.new(0,370,0,107)_b.Parent=da
_b.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)_b.Position=UDim2.new(0,0,0.800455689,0)
_b.Size=UDim2.new(0,370,0,21)_b.Font=Enum.Font.Arial;_b.Text="Made by lumakd"
_b.TextColor3=Color3.new(0,1,1)_b.TextSize=20;ab.Parent=da
ab.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)ab.Position=UDim2.new(0,0,0.158377,0)
ab.Size=UDim2.new(0,370,0,44)ab.Font=Enum.Font.ArialBold;ab.Text="Status: Active"
ab.TextColor3=Color3.new(0,1,1)ab.TextSize=20;local bb=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
bb:CaptureController()bb:ClickButton2(Vector2.new())
ab.Text="Made by quandz"wait(2)ab.Text="Status : Active"end)
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local MIN_PLAYERS = 15
local function ServerHop()
    TeleportService:Teleport(game.PlaceId)
end
task.spawn(function()
    task.wait(3) -- đợi load player list
    if #Players:GetPlayers() < MIN_PLAYERS then
        ServerHop()
    end
end)
task.spawn(function()
    while true do
        task.wait(30)
        if #Players:GetPlayers() < MIN_PLAYERS then
            ServerHop()
        end
    end
end)
