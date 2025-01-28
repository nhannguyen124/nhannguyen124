ggServerId = nil
if _G.ServerId[1] and _G.ServerId[2] then
	ggServerId = _G.ServerId
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
if ggServerId then
  local decodedData = not string.find(ggServerId[2],'-') and from_base64(ggServerId[2]) or ggServerId[2]
  game:GetService("TeleportService"):TeleportToPlaceInstance(ggServerId[1], decodedData, game.Players.LocalPlayer)
end
