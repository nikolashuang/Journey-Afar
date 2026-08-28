local uis = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")
local sp = game:GetService("StarterPlayer")

local moveController = require(sp.StarterPlayerScripts.MovementController)

local SprintRemote = rs.Remotes.SprintRemote

uis.InputBegan:Connect(function(input, processed)
    moveController.Sprint(input, processed, SprintRemote)
end)