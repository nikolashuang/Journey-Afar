local UserInput = game:GetService("UserInputService")
local RepStorage = game:GetService("ReplicatedStorage")
local StarterPlr = game:GetService("StarterPlayer")
local RunService = game:GetService("RunService")

local Controllers = StarterPlr.StarterPlayerScripts.Controllers

local moveController = require(Controllers.MovementController)
local animationController = require(Controllers.AnimationController)

local MovementRemote = RepStorage.Remotes:WaitForChild("MovementRemote")

UserInput.InputBegan:Connect(function(input, processed)
    moveController.Sprint(input, processed, MovementRemote)
    moveController.Walk(input, processed, MovementRemote)
    moveController.Dodge(input, processed, MovementRemote)
end)

MovementRemote.OnClientEvent:Connect(function(player, value)
    local character = player.character
    animationController.SetPlayerValues(character, value)
end)

RunService.PreRender:Connect(function()

end)
