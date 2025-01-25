function base64(data)
    if type(data) ~= "string" or data == "" then
        error("Invalid input: expected a non-empty Base64 string")
    end

    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

    -- Function to decode Base64
    local function decodeBase64(encoded)
        encoded = encoded:gsub('[^' .. b .. '=]', '') -- Remove invalid Base64 characters

        local decoded = encoded:gsub('.', function(x)
            if x == '=' then return '' end
            local f = (b:find(x) or 1) - 1
            local r = ''

            -- Convert character to binary string
            for i = 6, 1, -1 do
                r = r .. ((f % 2^i - f % 2^(i - 1)) > 0 and '1' or '0')
            end

            return r
        end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(bits)
            if #bits ~= 8 then return '' end
            local char = 0

            -- Convert binary string to character
            for i = 1, 8 do
                char = char + ((bits:sub(i, i) == '1') and 2^(8 - i) or 0)
            end

            return string.char(char)
        end)

        return decoded
    end
end
return function(data)
    k = base64(data)
    return k
end
