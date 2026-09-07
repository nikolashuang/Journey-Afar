local RPS = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local movementConfig = require(RPS.Shared.MovementConfig)

local CharacterClass = {}

CharacterClass.__index = CharacterClass

function CharacterClass.new(player, profile)
    local self = setmetatable({}, CharacterClass)

    self.Player = player
    self.Profile = profile

    self.Character = nil
    self.Humanoid = nil
    self.RootPart = nil

    self.MaxHealth = 100

    self.Stamina = 100
    self.MaxStamina = 100
    self.StaminaRegen = 0

    self.Damage = 10
    self.WeightLimit = 200

    self.Posture = 0
    self.MaxPosture = 100
    self.PostureRecovery = 0
    self.PostureDamage = 0
    self.ParryWindow = 0.2

    self.sprintSpeed = movementConfig.MovementSpeeds.SprintSpeed
    self.jogSpeed = movementConfig.MovementSpeeds.JogSpeed
    self.walkSpeed = movementConfig.MovementSpeeds.WalkSpeed

    self.isJogging = true
    self.isSprinting = false
    self.isWalking = false

    self.Staggered = false
    self.LastDodge = 0

    return self

end

function CharacterClass:BindCharacter(character)
    self.Character = character
    self.Humanoid = character:WaitForChild("Humanoid")
    self.RootPart = character:WaitForChild("HumanoidRootPart")

    self:RecalculateStats()
    
    self.Humanoid.Health = self.MaxHealth
    self.Humanoid.WalkSpeed = self.jogSpeed
    self.Stamina = self.MaxStamina

    self.MovementAttachment = Instance.new("Attachment")
    self.MovementAttachment.Name = "MovementAttachment"
    self.MovementAttachment.Parent = self.RootPart

end

function CharacterClass:RecalculateStats()

end

function CharacterClass:SetSprinting(state)
    if self.Staggered then
        return false
    end

    self.isSprinting = state

    if state and self.Stamina > 0 then
        self.Humanoid.WalkSpeed = self.sprintSpeed
        self.isJogging = false
        self.isWalking = false
    else
        self.Humanoid.WalkSpeed = self.jogSpeed
        self.isJogging = true
        self.isWalking = false
    end

    return "Sprinting"
end

function CharacterClass:SetWalking(state)
    if self.Staggered  then
        return false
    end

    self.isWalking = state

    if state then
        self.Humanoid.WalkSpeed = self.walkSpeed
        self.isJogging = false
        self.isSprinting = false
    else
        self.Humanoid.WalkSpeed = self.jogSpeed
        self.isJogging = true
        self.isSprinting = false
    end

    return "Walking"
end

function CharacterClass:Dodge(direction, behavior)
    local now = tick()
    local deb = movementConfig.DodgeCooldown

    if now - self.LastDodge < deb or self.Staggered then return end

    self.LastDodge = now

    local root = self.RootPart

    local lv = Instance.new("LinearVelocity")
    lv.Attachment0 = self.MovementAttachment
    lv.RelativeTo = Enum.ActuatorRelativeTo.World
    lv.ForceLimitsEnabled = false

    if behavior then
        if direction == "Forward" then
            lv.VectorVelocity = root.CFrame.LookVector * 90
        elseif direction == "Left" then
            lv.VectorVelocity = -root.CFrame.RightVector * 90
        elseif direction == "Backward" then
            lv.VectorVelocity = -root.CFrame.LookVector * 90
        elseif direction == "Right" then
            lv.VectorVelocity = root.CFrame.RightVector * 90
        end
    else
        lv.VectorVelocity = root.CFrame.LookVector * 90
    end

    lv.Parent = root

    Debris:AddItem(lv, 0.2)
end

return CharacterClass