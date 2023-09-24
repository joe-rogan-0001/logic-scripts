Config = {}

Config.UseLanguage = "en"
Config.UseSoundEffect = true 
--do sound

Config.Elevators = {
    ["PillBoxOne"] = {
        Group = {"ambulance"},
        Sound = "liftSoundBellRing",
        Name = "Elevator Two",
        Floors = {
            [1] = {
                Label = "Second Floor",
                FloorDesc = "Hospital Rooftop",
                Coords = vector3(338.51, -583.81, 74.16),
                ExitHeading = "250.07"
            },
            [2] = {
                Label = "First Floor",
                FloorDesc = "Hospital Upper Lobby",
                Coords = vector3(327.02, -603.85, 43.28),
                ExitHeading = "337.25"
            },
            [3] = {
                Label = "Ground Floor",
                FloorDesc = "Hospital Garage",
                Coords = vector3(340.18, -584.68, 28.8),
                ExitHeading = "104.87"
            },
        }
    },
    ["PillBoxTwo"] = {
        Sound = "liftSoundBellRing",
        Name = "Elevator One",
        Floors = {
            [1] = {
                Label = "First Floor",
                FloorDesc = "Hospital Upper Lobby",
                Require = "thermite",
                Coords = vector3(330.43, -601.16, 43.28),
                ExitHeading = "70.91"
            },
            [2] = {
                Label = "Ground Floor",
                FloorDesc = "Hospital Lower Lobby",
                Coords = vector3(345.62, -582.54, 28.8),
                ExitHeading = "262.86"
            },
        }
    },
    ["Casino"] = {
        Sound = "liftSoundBellRing",
        Name = "Elevator Two",
        Floors = {
            [1] = {
                Label = "Hotel",
                FloorDesc = "Rooms for Rent",
                Coords = vector3(910.50, -52.85, 21.01),
                ExitHeading = "151.5"
            },
            [2] = {
                Label = "Penthouse",
                FloorDesc = "ERP Arena",
                Coords = vector3(982.44, 55.46, 116.17),
                ExitHeading = "51.58"
            },
            [3] = {
                Label = "Roof",
                FloorDesc = "Rooftop pleasures",
                Coords = vector3(964.49, 58.83, 112.56),
                ExitHeading = "49.08"
            },
            [4] = {
                Label = "Office",
                FloorDesc = "Management",
                Coords = vector3(994.02, 56.06, 75.06),
                ExitHeading = "244.09"
            },
            [5] = {
                Label = "Casino",
                FloorDesc = "Casino Main Floor",
                Coords = vector3(960.55, 43.24, 71.71),
                ExitHeading = "244.09"
            },
        }
    },
}

Config.PolyZone = false -- This will show the box zones | If set to false it will hide the box zones

--Config.WaitTime = 4000 -- This will set the time for the ProgressBar | 1000 = 1 second
-- ignore this not used

Config.ElevatorButton = {

    ------ / Pill Box Hospital
    -- UnRestricted
    [1] = { name = "Ground Floor", location = vector3(346.10, -581.00, 28.8), width = 0.1, length = 0.3, heading = 69.47, minz = 28.9, maxz = 29.3},
    [2] = { name = "First Floor", location = vector3(330.04, -602.7, 43.28), width = 0.2, length = 0.3, heading = 247.68, minz = 43.48, maxz = 43.78 },

    -- Restricted
    [3] = { name = "EMS Garage", location = vector3(339.70, -586.20, 28.8), width = 0.1, length = 0.3, heading = 246.66, minz = 28.9, maxz = 29.3},
    [4] = { name = "Main Floor", location = vector3(325.65, -603.39, 43.28), width = 0.1, length = 0.3, heading = 160.6, minz = 43.48, maxz = 43.78},
    [5] = { name = "Heli Pad", location = vector3(338.42, -583.71, 74.16), width = 0.5, length = 2.8, heading = 70.21, minz = 74.16 - 1, maxz = 74.16 + 1.5 },

    -- Casino
    [6] = { name = "Hotel", location = vector3(910.12, -52.07, 21.0), width = 0.4, length = 0.6, heading = 311.0, minz = 21.0, maxz = 21.6 },
    [7] = { name = "Penthouse", location = vector3(982.58, 57.01, 116.17), width = 0.4, length = 0.6, heading = 328.0, minz = 116.16, maxz = 116.76 },
    [8] = { name = "Roof", location = vector3(964.39, 57.66, 112.55), width = 0.4, length = 0.6, heading = 60.0, minz = 112.35, maxz = 112.95 },
    [9] = { name = "Office", location = vector3(993.42, 55.50, 75.06), width = 0.4, length = 0.6, heading = 329.0, minz = 75.01, maxz = 75.61 },
    [10] = { name = "Casino", location = vector3(960.0, 42.3, 71.7), width = 0.4, length = 0.6, heading = 103.52, minz = 71.5, maxz = 72.3},
}

Config.Language = {
    ["en"] = {
        Waiting = "Waiting for the Elevator...",
        Restricted = "Access Restricted!",
        Item = "Access Restricted!",
        CurrentFloor = "Current Floor: ",
        Unable = "You Can't Use The Elevator...",
    },
    ["pt"] = {
        Waiting = "À espera do Elevador...",
        Restricted = "Piso restrito!",
        CurrentFloor = "Piso Atual: "
    }
}