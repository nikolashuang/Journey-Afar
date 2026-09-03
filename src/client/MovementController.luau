local uis = game:GetService("UserInputService")

local MovementController = {}

local function isKeyDown(key)
    return uis:IsKeyDown(Enum.KeyCode[key])
end

local function isShiftLockEnabled()
    return uis.MouseBehavior == Enum.MouseBehavior.LockCenter
end

function MovementController.Sprint(input, processed, remote)
    if processed then return end
    
    if input.KeyCode ~= Enum.KeyCode.LeftShift then return end

    remote:FireServer("Sprint")

end

function MovementController.Walk(input, processed, remote)
    if processed then return end
    
    if input.KeyCode ~= Enum.KeyCode.LeftControl then return end

    remote:FireServer("Walk")

end

function MovementController.Dodge(input, processed, remote)
    if processed then return end
    if input.KeyCode ~= Enum.KeyCode.Q then return end

    local mouseBehavior = isShiftLockEnabled()

    print("MouseBehavior", uis.MouseBehavior)
    print("Shiftlock: ", mouseBehavior)

    if isKeyDown("W") then
        remote:FireServer("Dodge", "Forward", mouseBehavior)
    elseif isKeyDown("A") then
        remote:FireServer("Dodge", "Left", mouseBehavior)
    elseif isKeyDown("S") then
        remote:FireServer("Dodge", "Backward", mouseBehavior)
    elseif isKeyDown("D") then
        remote:FireServer("Dodge", "Right", mouseBehavior)
    else
        remote:FireServer("Dodge", "Forward", mouseBehavior)
    end

end



return MovementController
