local QBCore = exports['lrp-core']:GetCoreObject()

local ItemList = {
    ["casino_whitechip"] = 1,
}
RegisterServerEvent("qb-casino:server:WhiteSell")
AddEventHandler("qb-casino:server:WhiteSell", function()
    local src = source
    local price = Config.whiteChipPrice
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("casino_whitechip")
    local chipamount = 0

    if xItem then
        chipamount = xItem.amount
        --for i = 1, chipamount do
        Player.Functions.RemoveItem("casino_whitechip", chipamount)
        Player.Functions.AddMoney(Config.payment, chipamount, "sold-casino-chips")
        TriggerEvent('qb-banking:society:server:DepositMoney', src, chipamount * -1, 'casino')
            --TriggerEvent('qb-banking:server:sendPaycheck', 1, src)
            --TriggerClientEvent('QBCore:Notify', -1, "You received a Paycheck, you can get it at the Pacific Standard Bank!", "success")
            -- Player.Functions.AddMoney('cash', Config.payout.boarskin)
        --end
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have any black casino chips...", "error")
        TriggerClientEvent("doj:casinoChipMenu", src)
    end
end)

local ItemList = {
    ["casino_redchip"] = 1,
}
RegisterServerEvent("qb-casino:server:RedSell")
AddEventHandler("qb-casino:server:RedSell", function()
    local src = source
    local price = Config.redChipPrice
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("casino_redchip")
    local chipamount = 0

    if xItem then
        chipamount = xItem.amount
        --for i = 1, chipamount do
        Player.Functions.RemoveItem("casino_redchip", chipamount)
        Player.Functions.AddMoney(Config.payment, chipamount, "sold-casino-chips")
        TriggerEvent('qb-banking:society:server:DepositMoney', src, chipamount * -1, 'casino')
            --TriggerEvent('qb-banking:server:sendPaycheck', 1, src)
            --TriggerClientEvent('QBCore:Notify', -1, "You received a Paycheck, you can get it at the Pacific Standard Bank!", "success")
            -- Player.Functions.AddMoney('cash', Config.payout.boarskin)
        --end
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have any black casino chips...", "error")
        TriggerClientEvent("doj:casinoChipMenu", src)
    end
end)

local ItemList = {
    ["casino_bluechip"] = 1,
}
RegisterServerEvent("qb-casino:server:BlueSell")
AddEventHandler("qb-casino:server:BlueSell", function()
    local src = source
    local price = Config.blueChipPrice
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("casino_bluechip")
    local chipamount = 0

    if xItem then
        chipamount = xItem.amount
        --for i = 1, chipamount do
        Player.Functions.RemoveItem("casino_bluechip", chipamount)
        Player.Functions.AddMoney(Config.payment, chipamount, "sold-casino-chips")
        TriggerEvent('qb-banking:society:server:DepositMoney', src, chipamount * -1, 'casino')
            --TriggerEvent('qb-banking:server:sendPaycheck', 1, src)
            --TriggerClientEvent('QBCore:Notify', -1, "You received a Paycheck, you can get it at the Pacific Standard Bank!", "success")
            -- Player.Functions.AddMoney('cash', Config.payout.boarskin)
        --end
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have any black casino chips...", "error")
        TriggerClientEvent("doj:casinoChipMenu", src)
    end
end)

local ItemList = {
    ["casino_blackchip"] = 1,
}
RegisterServerEvent("qb-casino:server:BlackSell")
AddEventHandler("qb-casino:server:BlackSell", function()
    local src = source
    local price = Config.blackChipPrice
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("casino_blackchip")
    local chipamount = 0

    if xItem then
        chipamount = xItem.amount
        --for i = 1, chipamount do
        Player.Functions.RemoveItem("casino_blackchip", chipamount)
        Player.Functions.AddMoney(Config.payment, chipamount, "sold-casino-chips")
        TriggerEvent('qb-banking:society:server:DepositMoney', src, chipamount * -1, 'casino')
            --TriggerEvent('qb-banking:server:sendPaycheck', 1, src)
            --TriggerClientEvent('QBCore:Notify', -1, "You received a Paycheck, you can get it at the Pacific Standard Bank!", "success")
            -- Player.Functions.AddMoney('cash', Config.payout.boarskin)
        --end
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have any black casino chips...", "error")
        TriggerClientEvent("doj:casinoChipMenu", src)
    end

end)

--[[
local ItemList = {
    ["casino_goldchip"] = 1,
}
RegisterServerEvent("qb-casino:server:GoldSell")
AddEventHandler("qb-casino:server:GoldSell", function()
    local src = source
    local price = Config.goldChipPrice
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("casino_goldchip")
    local chipamount = 0

    if xItem then
        chipamount = xItem.amount
        --for i = 1, chipamount do
        Player.Functions.RemoveItem("casino_goldchip", chipamount)
        Player.Functions.AddMoney(Config.payment, chipamount, "sold-casino-chips")
        TriggerEvent('qb-banking:society:server:DepositMoney', src, chipamount * -1, 'casino')
            --TriggerEvent('qb-banking:server:sendPaycheck', 1, src)
            --TriggerClientEvent('QBCore:Notify', -1, "You received a Paycheck, you can get it at the Pacific Standard Bank!", "success")
            -- Player.Functions.AddMoney('cash', Config.payout.boarskin)
        --end
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have any black casino chips...", "error")
        TriggerClientEvent("doj:casinoChipMenu", src)
    end
end)
]]--















