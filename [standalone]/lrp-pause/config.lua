Config = Config or {}

----------------------------------------------------------------------------------------------------
-- # BACKGROUND SECTION # --
----------------------------------------------------------------------------------------------------
-- Allows you to set the preferred background Color from a list of available options.
Config.Background = "background_blue"

-- Available Options --
-- background_blue
-- background_darkblue
-- background_darkerblue
-- background_darkgreen
-- background_green
-- background_other
-- background_pink
-- background_projectsloth
-- background_red
-- background_yellow

-- Allows you to change the opactiy of the Background
Config.Opacity = 100

----------------------------------------------------------------------------------------------------
-- # HEADER and OPTIONS SECTION # --
----------------------------------------------------------------------------------------------------

Config.Header = {
    -- LEFT MENU CONFIG
    ["TITLE"] = "Logic Roleplay",
    ["SUBTITLE"] = "Made by Lowballed & Haiku",

    ["MAP"] = "Map",
    ["GAME"] = "Exit Game",
    ["LEAVE"] = "Return to Server List",
    ["QUIT"] = "Return to Desktop",
    ["INFO"] = "Info (WIP)",
    ["STATS"] = "Stats (WIP)",
    ["SETTINGS"] = "Settings",
    ["GALLERY"] = "Gallery",
    ["KEYBIND"] = "Main Keybinds",
    ["EDITOR"] = "Rockstar Editor",

    -- RIGHT MENU CONFIG
    ["SERVER_NAME"] = "Make sure to join discord and read through rules!",
    ["SERVER_TEXT"] = "",
    ["SERVER_DISCORD"] = "DISCORD.GG/LOGICROLEPLAY"
}

--Allows you to Change the Colour ( Use this Website: https://rgbacolorpicker.com/ )
Config.RGBA = {
    LINE = { -- Line over the Options
        ["RED"] = 97,
        ["GREEN"] = 163,
        ["BLUE"] = 185,
        ["ALPHA"] = 255,
    },
    STYLE = { -- Pause Menu Options
        ["RED"] = 0,
        ["GREEN"] = 50,
        ["BLUE"] = 50,
        ["ALPHA"] = 186,
    },
    WAYPOINT = { -- Waypoint
    ["RED"] = 97,
    ["GREEN"] = 163,
    ["BLUE"] = 185,
    ["ALPHA"] = 255,
    },
}
