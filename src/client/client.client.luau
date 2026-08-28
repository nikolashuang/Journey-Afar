local uis = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")
local sps = game:GetService("StarterPlayer")

local moveController = require(sps.StarterPlayerScripts.MovementController)

local SprintRemote = rs.Remotes.SprintRemote

uis.InputBegan:Connect(function(input, processed)
    moveController.Sprint(input, processed, SprintRemote)
end)