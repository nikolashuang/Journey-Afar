local UserInput = game:GetService("UserInputService")
local RepStorage = game:GetService("ReplicatedStorage")
local StarterPlr = game:GetService("StarterPlayer")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Controllers = StarterPlr.StarterPlayerScripts.Controllers

local moveController = require(Controllers.MovementController)
local animationController = require(Controllers.AnimationController)

local MovementRemote = RepStorage.Remotes:WaitForChild("MovementRemote")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

animationController.BindCharacter(character)

player.CharacterAdded:Connect(function(newCharacter)
    animationController.BindCharacter(newCharacter)
end)

UserInput.InputBegan:Connect(function(input, processed)
    moveController.Sprint(input, processed, MovementRemote)
    moveController.Walk(input, processed, MovementRemote)
    moveController.Dodge(input, processed, MovementRemote)
end)

MovementRemote.OnClientEvent:Connect(function(animation)
    animationController.SetMovementAnimation(animation)
end)

RunService.PreRender:Connect(function()
    animationController.checkMagnitudeMovement()
end)
