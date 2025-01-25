return function(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    
    -- Loại bỏ ký tự không hợp lệ khỏi chuỗi Base64
    data = string.gsub(data, '[^' .. b .. '=]', '')

    -- Giải mã Base64
    local decoded = data:gsub('.', function(x)
        if x == '=' then return '' end
        local r, f = '', (b:find(x) - 1)
        
        -- Chuyển ký tự thành chuỗi bit
        for i = 6, 1, -1 do
            r = r .. (f % 2^i - f % 2^(i - 1) > 0 and '1' or '0')
        end
        
        return r
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(bits)
        if #bits ~= 8 then return '' end
        local char = 0
        
        -- Chuyển chuỗi bit thành ký tự
        for i = 1, 8 do
            char = char + (bits:sub(i, i) == '1' and 2^(8 - i) or 0)
        end
        
        return string.char(char)
    end)

    return decoded
end
