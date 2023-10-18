Cupcake = {}
Cupcake.BuyAccount = "bank" -- Money account used to buy any crypto from the list
Cupcake.DefaultTab = "buy"
Cupcake.Tabs = {
    ["buy"] = true,
    ["transfer"] = true,
    ["sell"] = true
}
Cupcake.AvailableCryptos = {
    {
        name = "cosmo", -- How your account is named in your framework
        label = "Cosmo", -- How the player will see the account in app
        buy = 20, -- Price 1x crypto = 20 of buyAccount money
        sell = 15, -- Price 1x crypto = 15 of buyAccount money
        canBuy = true, -- Can players buy it from cupcake app?
        canTransfer = true, -- Can players transfer it using cupcake app?
        canSell = true, -- Can players sell it using cupcake app?
        buyAccount = "bank", -- Account used to buy crypto
        buyAccountLabel = "USD", -- The account label
        sellAccount = "bank", -- Account used to receive your funds after selling this crypto
        sellAccountLabel = "USD" -- The account label
    },
    -- This is just an example for a different crypto
    -- {
    --     name = "gne", -- How your account is named in your framework
    --     label = "GNE", -- How the player will see the account in app
    --     buy = 20, -- Price 1x crypto = 20 of buyAccount money
    --     sell = 15, -- Price 1x crypto = 15 of buyAccount money
    --     canBuy = false, -- Can players buy it from cupcake app?
    --     canTransfer = true, -- Can players transfer it using cupcake app?
    --     canSell = true, -- Can players sell it using cupcake app?
    --     buyAccount = "cosmo", -- Account used to buy crypto
    --     buyAccountLabel = "Cosmo", -- The account label
    --     sellAccount = "btc", -- Account used to receive your funds after selling this crypto
    --     sellAccountLabel = "BTC" -- The account label
    -- },
    
}