local RepStorage = game:GetService("ReplicatedStorage")

local AnimationKey = RepStorage.PlayerAnimations

local AnimationsStorage = {
    Movement = {
        JogAnim = AnimationKey.Movement:FindFirstChild("Jog"),
        SprintAnim = AnimationKey.Movement:FindFirstChild("Sprint"),
        WalkAnim = AnimationKey.Movement:FindFirstChild("Walk"),
    },

    Dodges = {
        ForwardRoll = AnimationKey.Movement:FindFirstChild("ForwardRoll"),
        LeftRoll = AnimationKey.Movement:FindFirstChild("LeftRoll"),
        Backstep = AnimationKey.Movement:FindFirstChild("Backstep"),
        RightRoll = AnimationKey.Movement:FindFirstChild("RightRoll"),
    }
}


local humanoid = nil
local animator = nil
local MovementAnimationTrack = nil
local DodgeAnimationTrack = nil
local animationStopOffset = 0.3

local AnimationController = {}

function AnimationController.BindCharacter(character)
    humanoid = character:WaitForChild("Humanoid")
    animator = humanoid:FindFirstChild("Animator")
end

function AnimationController.SetMovementAnimation(animation)
    if MovementAnimationTrack and MovementAnimationTrack.IsPlaying then
        MovementAnimationTrack:Stop(animationStopOffset)
    end

    if animation == "Default" then
        MovementAnimationTrack:Stop(animationStopOffset)
        MovementAnimationTrack = nil
        return
    end

    local selectedAnimation = AnimationsStorage["Movement"][animation]

    if not selectedAnimation then return end

    MovementAnimationTrack = animator:LoadAnimation(selectedAnimation)
end

function AnimationController.DodgeAnimation(animation)
    local selectedAnimation = AnimationsStorage["Dodges"][animation]

    if not selectedAnimation then return end

    DodgeAnimationTrack = animator:LoadAnimation(selectedAnimation)
    DodgeAnimationTrack:Play()
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
            MovementAnimationTrack:Stop(animationStopOffset)
        end
    end
end


return AnimationController