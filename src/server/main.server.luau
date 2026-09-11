local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local PlayerProfile = require(ServerScriptService.PlayerProfile.ProfileService)
local CharacterClass = require(ServerScriptService.Character.CharacterClass)

local Characters = {}

Players.PlayerAdded:Connect(function(player)
    local profile = PlayerProfile.LoadProfile(player)

    if not profile then
        player:Kick("Failed to load your progress. Please rejoin.")
        return
    end

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

local mRemote = ReplicatedStorage.Remotes:WaitForChild("MovementRemote")

mRemote.OnServerEvent:Connect(function(player, action, direction, behavior)
    local character = Characters[player]

    if not character then return end

    if action == "Sprint" then
        character:SetSprinting(not character.isSprinting)

        if character.isSprinting then 
            mRemote:FireClient(player, "SprintAnim")
        else 
            mRemote:FireClient(player, "Default")
        end
    elseif action == "Walk" then
        character:SetWalking(not character.isWalking)
        if character.isWalking then 
            mRemote:FireClient(player, "WalkAnim")
        else
            mRemote:FireClient(player, "Default")
        end
    elseif action == "Dodge" then
        local animationType = character:Dodge(direction, behavior)
        mRemote:FireClient(player, animationType)
        if character.isWalking then 
            character:SetWalking(not character.isWalking) 
            mRemote:FireClient(player, animationType)
        end
    end

end)




