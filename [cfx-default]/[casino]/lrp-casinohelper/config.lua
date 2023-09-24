Config = {}

Config.PlayCasinoAmbientNoise = true
Config.SetShowCarOnDisplay = true
Config.VehicleOnDisplay = `panamera17turbo`
Config.CasinoEmployeePrompt  = 'peek' -- 'peek' or 'walk-up' ['walk-up' = walk up to open menu] ['peek' = uses  to interact with employee]


Config.SetAnimatedWalls = true
Config.AnimatedWallNormal = 'CASINO_DIA_PL'
Config.AnimatedWallWin = 'CASINO_WIN_PL'
-- WALLS
-- CASINO_DIA_PL    - Falling Diamonds
-- CASINO_HLW_PL    - Falling Skulls
-- CASINO_SNWFLK_PL - Falling Snowflakes
-- CASINO_WIN_PL    - Falling Confetti

Config.SendWelcomeMail = false -- Sends a email to players phone on entering casino
Config.WelcomeMailsender = "The Diamond Casino"
Config.WelcomeMailsubject ="Welcome!"
Config.WelcomeMailmessage = "Welcome to The Diamond Casino, We are Open 24/7 & only accept Electronic Transactions"

Config.payment = "cash" -- or "cash" -- Payment player will recieve by selling casino chips

Config.whiteChipPrice   = 1
Config.redChipPrice     = 1
Config.blueChipPrice    = 1
Config.blackChipPrice   = 1
Config.goldChipPrice    = 1


Config.CasinoShop = {
    [1] = { name = "casino_whitechip",  price = 1,   amount = 999999999, info = {}, type = "item", slot = 1 },
    [2] = { name = "casino_redchip",    price = 1,   amount = 999999999, info = {}, type = "item", slot = 2 },
    [3] = { name = "casino_bluechip",   price = 1,  amount = 99999999, info = {}, type = "item", slot = 3 },
    [4] = { name = "casino_blackchip",  price = 1,  amount = 99999999, info = {}, type = "item", slot = 4 },
    --[5] = { name = "casino_goldchip",   price = 1, amount = 99999999999, info = {}, type = "item", slot = 5 },
}   
