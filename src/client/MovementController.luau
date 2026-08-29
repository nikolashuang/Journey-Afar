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

    remote:FireServer("Walk", true)

end

function MovementController.Dodge(input, processed, remote)
    if processed then return end

    if input.KeyCode ~= Enum.KeyCode.Q then return end

    if isKeyDown("W") then
        remote:FireServer("Dodge", "Forward")
    elseif isKeyDown("A") then
        remote:FireServer("Dodge", "Left")
    elseif isKeyDown("S") then
        remote:FireServer("Dodge", "Backward")
    elseif isKeyDown("D") then
        remote:FireServer("Dodge", "Right")
    end

end



return MovementController
