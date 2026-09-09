local RepStorage = game:GetService("ReplicatedStorage")

local AnimationKey = RepStorage.PlayerAnimations

local AnimationsStorage = {
    Movement = {
        JogAnim = AnimationKey.Movement:FindFirstChild("Jog"),
        SprintAnim = AnimationKey.Movement:FindFirstChild("Sprint"),
        WalkAnim = AnimationKey.Movement:FindFirstChild("Walk")
    }
}


local humanoid = nil
local animator = nil
local MovementAnimationTrack = nil

local AnimationController = {}

function AnimationController.BindCharacter(character)
    humanoid = character:WaitForChild("Humanoid")
    animator = humanoid:FindFirstChild("Animator")
end

function AnimationController.SetMovementAnimation(animation)
    if MovementAnimationTrack and MovementAnimationTrack.IsPlaying then
        MovementAnimationTrack:Stop()
    end

    local selectedAnimation = AnimationsStorage["Movement"][animation]

    if not selectedAnimation then
        warn("Animation not found or referencing wrong table")
        return
    end

    MovementAnimationTrack = animator:LoadAnimation(selectedAnimation)
end

function AnimationController.checkMagnitudeMovement()
    if not humanoid then return end
    if not MovementAnimationTrack then return end

    if humanoid.MoveDirection.Magnitude > 0 then
        if not MovementAnimationTrack.IsPlaying then
            MovementAnimationTrack:Play()
        end
    else
        if MovementAnimationTrack.IsPlaying then
            MovementAnimationTrack:Stop()
        end
    end
end


return AnimationController