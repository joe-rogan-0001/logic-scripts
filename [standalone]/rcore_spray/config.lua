-- if "STANDALONE" is on true, nothing under will take effect.
Framework = {
    STANDALONE = false,

    ESX = false,
    QBCORE = true,
}

-- if "DISABLE_MYSQL" is on true, nothing under will take effect.
MySQLFramework = {
    DISABLE_MYSQL = false,

    MYSQL_ASYNC = false,
    GHMATTI_MYSQL = false,
    OXMYSQL = true,
}

-- If True, will use old non-additive rendering style
-- the sprays will look a bit "out of place" and won't blend into it's wall well
UseLegacyRendering = false

Config = {
    SPRAY_PERSIST_DAYS = 999,
    SPRAY_PROGRESSBAR_DURATION = 20000,
    SPRAY_REMOVE_DURATION = 30000,

    SPRAY_CHAR_LIMIT = 5,
    
    Keys = {
        CANCEL = {code = "BACK", label = 'INPUT_FRONTEND_RRIGHT'},
    },

    Blacklist = {
        'nigger',
        'niger',
        'nigga',
    },

    Text = {
        CANCEL = 'Cancel',
        SPRAY_ERRORS = {
            NOT_FLAT = 'This surface is not flat enough',
            TOO_FAR = 'The surface is too far',
            INVALID_SURFACE = 'It cannot be sprayed on this surface',
            AIM = 'Aim the spray at a flat wall',
        },
        NO_SPRAY_NEARBY = 'There is no spray nearby to remove',
        NEED_SPRAY = 'You do not have any spray to spray with',
        WORD_LONG = 'Spray word can be at most 9 characters',
        USAGE = 'Usage: /spray',
        NUI_TEXT = {
            ['text'] = 'TEXT',
            ['image'] = 'IMAGE',
            ['word-not-allowed'] = 'This word is not allowed!',
            ['color'] = 'color',
            ['spray'] = 'SPRAY',
            ['click-to-select'] = 'CLICK TO SELECT',
            ['cancel'] = 'CANCEL',
            ['keybind-spray'] = 'Spray',
            ['keybind-change-size'] = 'Change Size',
            ['keybind-back'] = 'Back',
            ['input-placeholder'] = 'Your graffiti text here',
            ['default-graffiti'] = 'GRAFFITI',
            ['save-color'] = 'Save',
        }
    }
}

FONTS = {
    {
        font = 'graffiti1',
        label = 'Next Custom',
        allowed = '^[A-Z0-9\\-.]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z0-9\\-.]+',
        sizeMult = 0.35,
    },
    {
        font = 'graffiti2',
        label = 'Dripping Marker',
        allowed = '^[A-Za-z0-9]+$',
        allowedInverse = '[^A-Za-z0-9]+',
        sizeMult = 1.0,
    },
    {
        font = 'graffiti6',
        label = 'Barrio Santo',
        forceUppercase = true,
        allowed = '^[A-Z0-9]+$',
        allowedInverse = '[^A-Z0-9]+',
        sizeMult = 0.90,
    },
    {
        font = 'graffiti7',
        label = 'Bomb',
        allowed = '^[A-Z0-9!?]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z0-9!?]+',
        sizeMult = 0.75,
    },
    {
        font = 'graffiti8',
        label = 'Bombing',
        allowed = '^[A-Z0-9!?+\\-*/]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z0-9!?+\\-*/]+',
        sizeMult = 1.15,
    },
    {
        font = 'graffiti9',
        label = 'Train Gangsta',
        allowed = '^[A-Z0-9?!]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z0-9?!]+',
        sizeMult = 0.6,
    },
    {
        font = 'graffiti10',
        label = 'Street Wrister',
        allowed = '^[A-Z0-9!?+\\-*/]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z0-9!?+\\-*/]+',
        sizeMult = 1.0,
    },
    {
        font = 'graffiti11',
        label = 'Peinture Fraiche',
        allowed = '^[A-Z0-9!?+\\-*/]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z0-9!?+\\-*/]+',
        sizeMult = 1.0,
    },
    {
        font = 'PricedownGTAVInt',
        label = 'Pricedown',
        allowed = '^[A-Za-z0-9]+$',
        allowedInverse = '[^A-Za-z0-9]+',
        sizeMult = 0.75,
    },
}

IMAGES = {
    {
        dict = 'rcore_graffiti',
        name = 'littleangels',
        scale = 0.30,
        color = {0, 0, 0},
        gangTags = {'littleangels'}, -- Used for capturing territory when using https://store.rcore.cz/package/4913168
        width = 552,
        height = 552,
    },
    {
        dict = 'rcore_graffiti',
        name = 'NBK',
        scale = 0.30,
        color = {0, 0, 0},
        gangTags = {'NBK'}, -- Used for capturing territory when using https://store.rcore.cz/package/4913168
        width = 552,
        height = 552,
    },
    {
        dict = 'rcore_graffiti',
        name = 'uptr',
        scale = 0.30,
        color = {0, 0, 0},
        gangTags = {'uptr'}, -- Used for capturing territory when using https://store.rcore.cz/package/4913168
        width = 552,
        height = 552,
    },
    {
        dict = 'rcore_graffiti',
        name = 'syndicate',
        scale = 0.30,
        color = {0, 0, 0},
        gangTags = {'syndicate'}, -- Used for capturing territory when using https://store.rcore.cz/package/4913168
        width = 552,
        height = 552,
    },
    {
        dict = 'rcore_graffiti',
        name = 'vw72',
        scale = 0.30,
        color = {0, 0, 0},
        gangTags = {'vw72'}, -- Used for capturing territory when using https://store.rcore.cz/package/4913168
        width = 552,
        height = 552,
    },
    {
        dict = 'rcore_graffiti',
        name = 'laguild',
        scale = 0.30,
        color = {0, 0, 0},
        gangTags = {'laguild'}, -- Used for capturing territory when using https://store.rcore.cz/package/4913168
        width = 552,
        height = 552,
    },
}

FastImageMap = {}
for _, d in pairs(IMAGES) do FastImageMap[d.dict .. d.name] = d end

COLORS = {
    {
        basic = 'WHITE',
        hex = 'ffffff',
        rgb = {255, 255, 255},
    },
    {
        basic = 'RED',
        hex = 'c81912',
        rgb = {200, 25, 18},
    },
    {
        basic = 'RED',
        hex = 'f64b3c',
        rgb = {246, 75, 60},
    },
    {
        basic = 'PINK',
        hex = 'f76a8c',
        rgb = {247, 106, 140},
    },
    {
        basic = 'PINK',
        hex = 'fde2e2',
        rgb = {253, 226, 226},
    },
    {
        basic = 'BLUE',
        hex = '000839',
        rgb = {0, 8, 57},
    },
    {
        basic = 'BLUE',
        hex = '005082',
        rgb = {0, 80, 130},
    },
    {
        basic = 'BLUE',
        hex = '00a8cc',
        rgb = {0, 168, 204},
    },
    {
        basic = 'YELLOW',
        hex = 'ffd31d',
        rgb = {255, 211, 29},
    },
    {
        basic = 'YELLOW',
        hex = 'f5fcc1',
        rgb = {245, 252, 193},
    },
    {
        basic = 'GREEN',
        hex = '2b580c',
        rgb = {43, 88, 12},
    },
    {
        basic = 'GREEN',
        hex = '639a67',
        rgb = {99, 154, 103},
    },
    {
        basic = 'ORANGE',
        hex = 'ea6227',
        rgb = {234, 98, 39},
    },
    {
        basic = 'ORANGE',
        hex = 'ffa41b',
        rgb = {255, 164, 27},
    },
    {
        basic = 'BROWN',
        hex = '442727',
        rgb = {68, 39, 39},
    },
    {
        basic = 'BROWN',
        hex = '9c5518',
        rgb = {156, 85, 24},
    },
    {
        basic = 'PURPLE',
        hex = '844685',
        rgb = {132, 70, 133},
    },
    {
        basic = 'PURPLE',
        hex = 'be79df',
        rgb = {190, 121, 223},
    },
    {
        basic = 'GREY',
        hex = 'cccccc',
        rgb = {204, 204, 204},
    },
    {
        basic = 'GREY',
        hex = '323232',
        rgb = {50, 50, 50},
    },
    {
        basic = 'BLACK',
        hex = '000000',
        rgb = {0, 0, 0},
    },
}

SIMPLE_COLORS = {}

for idx, c in pairs(COLORS) do
    SIMPLE_COLORS[idx] = c.rgb
end
