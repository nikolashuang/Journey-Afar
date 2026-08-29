local uis = game:GetService("UserInputService")

local MovementController = {}

local function isKeyDown(key)
    return uis:IsKeyDown(Enum.KeyCode[key])
end

function MovementController.Sprint(input, processed, remote)
    if processed then return end

    if input.KeyCode ~= Enum.KeyCode.LeftShift then return end

    remote:FireServer("Sprint", true)

end

function MovementController.Walk(input, processed, remote)
    if processed then return end

    if input.KeyCode ~= Enum.KeyCode.LeftAlt then return end

    remote:FireServer(true)

end

function MovementController.Dodge(input, processed, remote)
    if processed then return end


end



return MovementController
