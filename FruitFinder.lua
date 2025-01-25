local HttpService = game:GetService("HttpService")
function to_base64(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end
function from_base64(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end
local encoded = to_base64(game.JobId)
local webhookUrl = "https://discord.com/api/webhooks/1332253559848439818/K2RSHHiIGjg9yZiyfAoZM53xorbdgi2O9vVadYXlwc38OJEwyXD3jb9Ojjyy-OMt9Svc" -- Thay thế bằng URL webhook của bạn
local function sendWebhook(fruitNames, playerCount, world)
    local fruitList = table.concat(fruitNames, ", ")
    local data = {
        username = "Fruit Finder Bot",
        avatar_url = "https://static.wikia.nocookie.net/roblox-blox-piece/images/4/4e/DragonIcon.png/revision/latest/scale-to-width/360?cb=20241231011212",
        embeds = {
            {
                title = "Fruit Finder",
                description = "Fruits: **" .. fruitList .. "**\nPlayers: `" .. playerCount .. "`\nWorld: `" .. world .. "`",
                color = 65280,
                fields = {
                    {
                        name = "Dành cho PC",
                        value = "```lua\n_G.ServerId = {"..game.PlaceId..",'"..encoded.."'}\nloadstring(game:HttpGet('https://raw.githubusercontent.com/nhannguyen124/nhannguyen124/refs/heads/main/ditmemay.lua'))()\n```", -- Định dạng mã cho PC
                        inline = true
                    }
                }
            }
        }
    }

    local json_data = HttpService:JSONEncode(data)

    local httpRequest = http_request or request or syn.request

    local success, response = pcall(function()
        return httpRequest({
            Url = webhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = json_data
        })
    end)

    if success and response.StatusCode == 204 then
        print("Webhook sent successfully")
    else
        warn("Failed to send webhook:", response and response.Body or "No response")
    end
end
local function checkForFruits()
    local fruits = {}
    for _, obj in pairs(workspace:GetChildren()) do
        if obj.Name ~= "Fruit" and obj.Name:lower():find("fruit") then
            print()
            table.insert(fruits, obj.Name)
        elseif obj.Name == "Fruit" and obj.Fruit then
            local meshId = obj.Fruit.Fruit.MeshId
            local fruitName = FruitsId[meshId] or "Unknown Fruit"
            table.insert(fruits, fruitName.." (Spawned)")
        end
    end
    return fruits
end
spawn(function()
	while wait() do
		for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") and string.find(v.Name, "Fruit") then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit",v:GetAttribute("OriginalName"),v)
				Load.Text = "Keep Fruit Success"
			end
		end
		for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("Tool") and string.find(v.Name, "Fruit") then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit",v:GetAttribute("OriginalName"),v)
				Load.Text = "Keep Fruit Success"
			end
		end
	end
end)
local fruitNames = checkForFruits()
local playerCount = tostring(#game.Players:GetPlayers()) .. "/12"
local world = game.PlaceId == 2753915549 and "Sea 1" or (game.PlaceId == 4442272183 and "Sea 2" or "Sea 3")
if #fruitNames > 0 then
	sendWebhook(fruitNames, playerCount, world)
	wait()
	local currentTeam = game.Players.LocalPlayer.Team
    if currentTeam == nil or currentTeam.Name ~= "Marines" then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
    end
	for _, v in pairs(workspace:GetChildren()) do
		if string.find(v.Name,'Fruit') then
			local Handle = v:FindFirstChild("Handle") or false
			local FruitPart = v.Fruit:FindFirstChild("Fruit")
			if Handle then
				_G.Position = Handle.Position
				loadstring(game:HttpGet("https://raw.githubusercontent.com/nhannguyen124/nhannguyen124/refs/heads/main/ATween().lua"))()
			else
				_G.Position = FruitPart.Position
				loadstring(game:HttpGet("https://raw.githubusercontent.com/nhannguyen124/nhannguyen124/refs/heads/main/ATween().lua"))()
			end
			wait()
		end
	end
	wait(2)
	loadstring(game:HttpGet("https://raw.githubusercontent.com/nhannguyen124/nhannguyen124/refs/heads/main/Hop.lua"))()
else
	loadstring(game:HttpGet("https://raw.githubusercontent.com/nhannguyen124/nhannguyen124/refs/heads/main/Hop.lua"))()
end
