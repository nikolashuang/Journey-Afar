local uis = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")
local sp = game:GetService("StarterPlayer")

local moveController = require(sp.StarterPlayerScripts.MovementController)

local MovementRemote = rs.Remotes.MovementRemote

uis.InputBegan:Connect(function(input, processed)
    moveController.Sprint(input, processed, MovementRemote)
    moveController.Walk(input, processed, MovementRemote)
    moveController.Dodge(input, processed, MovementRemote)
end)