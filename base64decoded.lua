return function(data)
    local function decodedbase64(data)
        return (data:gsub('.', function(x)
            local r, b = '', x:byte()
            for i = 8, 1, -1 do
                r = r .. (b % 2^i - b % 2^(i-1) > 0 and '1' or '0')
            end
            return r
        end):gsub('%z', ''):gsub('(%d%d%d?)(%d%d?)(%d?)', function(a, b, c)
            local r = tonumber(a, 2) or 0
            r = r * 64 + (tonumber(b, 2) or 0)
            r = r * 4 + (tonumber(c, 2) or 0)
            return string.char(r)
        end))
    end
    return decodedbase64(data)
end
