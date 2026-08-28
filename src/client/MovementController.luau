local MovementController = {}

function MovementController.Sprint(input, processed, sprintRemote)
    if processed then return end

    if input.KeyCode ~= Enum.KeyCode.LeftShift then return end

    sprintRemote:FireServer(true)

end

function MovementController.Dodge(input, processed, sprintRemote)
    if processed then return end


end



return MovementController