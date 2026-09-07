local RepStorage = game:GetService("ReplicatedStorage")

local AnimationKey = RepStorage.PlayerAnimations

local MovementAnimations = {
    JogAnim = AnimationKey.MovementAnimations:FindFirstChild("Jog"),
    SprintAnim = AnimationKey.MovementAnimations:FindFirstChild("Sprint"),
    WalkAnim = AnimationKey.MovementAnimations:FindFirstChild("Walk")
}

local humanoid = nil
local currentMovement = nil

local AnimationController = {}

function AnimationController.SetPlayerValues(character, value)
    if not character then return end

    humanoid = character:FindFirstChild("Humanoid")
    currentMovement = value
end

function AnimationController.CheckMagnitude()
    if not humanoid then return end

    if humanoid.MoveDirection.Magnitude > 0 then
        if currentMovement == "Sprinting" then
            
        end
    end

end



return AnimationController