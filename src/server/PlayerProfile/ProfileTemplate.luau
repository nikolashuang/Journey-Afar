local ProfileTemplate = {

    Level = 1,
    Experience = 0,

    StatPoints = {
        AvailablePoints = 0,

        AllocatedPoints = {
            Strength = 0,
            Defense = 0,
            Agility = 0,
            Dexterity = 0
        }

    },

    Currency = {
        Gold = 0,
        FareShards = 0
    },

    Inventory = {},
    Equipped = {}
}

return ProfileTemplate