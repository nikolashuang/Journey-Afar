local RPS = game:GetService("ReplicatedStorage")
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

    self.Humanoid.Health = 100
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



    return self

end

function CharacterClass:BindCharacter(character)
    self.Character = character
    self.Humanoid = character:WaitForChild("Humanoid")
    self.RootPart = character:WaitForChild("HumanoidRootPart")

    self:RecalculateStats()
    
    self.Humanoid.Health = self.Humanoid.MaxHealth
    self.Stamina = self.MaxStamina

end

function CharacterClass:RecalculateStats()

end

function CharacterClass:SetSprinting(state)
    self.isSprinting = state

    if state then
        self.Humanoid.WalkSpeed = self.sprintSpeed
        self.isJogging = false
        self.isWalking = false
    else
        self.Humanoid.WalkSpeed = self.jogSpeed
        self.isJogging = true
        self.isSprinting = false
    end

end

function CharacterClass:SetWalking(state)
    self.isWalking = state

    if state then
        self.Humanoid.WalkSpeed = self.walkSpeed
        self.isJogging = false
        self.isSprinting = false
    else
        self.Humanoid.WalkSpeed = self.jogSpeed
        self.isJogging = true
        self.isWalking = false
    end
end

function CharacterClass:Dodge(direction)

end

return CharacterClass