local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local PlayerProfile = require(ServerScriptService.PlayerProfile.ProfileService)
local CharacterClass = require(ServerScriptService.Character.CharacterClass)

local Characters = {}


Players.PlayerAdded:Connect(function(player)
    local profile = PlayerProfile.LoadProfile(player)
    local plrCharacter = CharacterClass.new(player, profile)

    Characters[player] = plrCharacter

    if player.Character then
        plrCharacter:BindCharacter(player.Character)
    end

    player.CharacterAdded:Connect(function(character)
        plrCharacter:BindCharacter(character)
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    PlayerProfile.SaveProfile(player)
    PlayerProfile:ReleaseProfile(player)
    Characters[player] = nil
end)




