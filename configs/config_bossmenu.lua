wx = {}

wx.Jobs = {
    ['police'] = {
        Label = "LSPD", -- Job label in context menu
        Icon = 'handcuffs', -- https://fontawesome.com/icons/ (Only FREE ones)
        Location = vector3(450.0966, -973.1896, 30.6896), -- Target location
        Permissions = { -- Permissions for each job grade
            [0] = {
                CanOpen = false, -- Allow opening the boss menu
                CanHire = false, -- Allow hiring new employees
                CanPromote = false, -- Allow promoting other employees
                CanDemote = false, -- Allow demoting other employees
                CanKick = false, -- Allow kicking employees
            },
            [4] = {
                CanOpen = true,
                CanHire = true,
                CanPromote = true,
                CanDemote = true,
                CanKick = true,
            },
        }
    },
    ['unemployed'] = {
        Label = "Bezdomovci", -- Job label in context menu
        Icon = 'user', -- https://fontawesome.com/icons/ (Only FREE ones)
        Location = vector3(448.7969, -979.4689, 30.6896), -- Target location
        Permissions = { -- Permissions for each job grade

            [0] = {
                CanOpen = true,
                CanHire = true,
                CanPromote = true,
                CanDemote = true,
                CanKick = true,
            },
        }
    },
}