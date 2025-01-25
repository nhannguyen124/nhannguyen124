return function(Settings)
  local decodeBase64 = loadstring(game:HttpGet("https://raw.githubusercontent.com/nhannguyen124/nhannguyen124/refs/heads/main/base64decoded.lua"))
  local decodedData = decodeBase64(Settings[2])
  game:GetService("TeleportService"):TeleportToPlaceInstance(Settings[1], decodedData, game.Players.LocalPlayer)
end
