local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false

-- Hàm kiểm tra và lấy server
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" then
        foundAnything = Site.nextPageCursor
    else
        foundAnything = ""
    end

    for _, v in pairs(Site.data) do
        local ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            local isAlreadyChecked = false
            for _, existingID in pairs(AllIDs) do
                if ID == existingID then
                    isAlreadyChecked = true
                    break
                end
            end

            if not isAlreadyChecked then
                table.insert(AllIDs, ID)
                local success, result = pcall(function()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)

                if success then
                    print("Teleporting to server:", ID)
                    wait(4) -- Đợi trước khi thử tiếp
                else
                    warn("Teleport failed. Retrying...")
                end
                break
            end
        end
    end
end

-- Hàm teleport liên tục
function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

-- Gọi hàm teleport
Teleport()
