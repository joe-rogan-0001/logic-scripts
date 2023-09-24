local QBCore = exports['lrp-core']:GetCoreObject()

--[[QBCore = nil

TriggerEvent(AOD.Strings.QBServer, function(obj) QBCore = obj end)]]--

QBCore.Functions.CreateUseableItem('huntingknife', function(source)
    TriggerClientEvent('AOD-huntingknife',source)
end)

QBCore.Functions.CreateUseableItem('huntingbait', function(source)
    TriggerClientEvent('AOD-huntingbait', source)
end)

RegisterServerEvent('AOD-butcheranimal')
AddEventHandler('AOD-butcheranimal', function(animal)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local boar = -832573324
    local deer = -664053099
    local coyote = 1682622302
    if animal == boar then
        xPlayer.Functions.AddItem('boarmeat', AOD.BoarMeat)
        xPlayer.Functions.AddItem('boarskin', AOD.BoarSkin)
    elseif animal == deer then
        xPlayer.Functions.AddItem('deerskin', AOD.DeerSkin)
        xPlayer.Functions.AddItem('deermeat', AOD.DeerMeat)
    elseif animal == coyote then
        xPlayer.Functions.AddItem('coyotefur', AOD.CoyoteFur)
        xPlayer.Functions.AddItem('coyotemeat', AOD.CoyoteMeat)
    else
        print('exploit detected')
        --add your ban event here for cheating
    end
end)

RegisterServerEvent('AOD-hunt:TakeItem')
AddEventHandler('AOD-hunt:TakeItem', function(item)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.RemoveItem(item, 1)
end)

QBCore.Functions.CreateCallback('lrp-hunting:server:get:ingredientBoarProcess', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local boarskin = Player.Functions.GetItemByName("boarskin")
    local limewater = Player.Functions.GetItemByName("limewater")
    if boarskin ~= nil and limewater ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('lrp-hunting:server:get:ingredientDeerProcess', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local deerskin = Player.Functions.GetItemByName("deerskin")
    local limewater = Player.Functions.GetItemByName("limewater")
    if deerskin ~= nil and limewater ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('lrp-hunting:server:get:ingredientCoyoteProcess', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local coyotefur = Player.Functions.GetItemByName("coyotefur")
    local limewater = Player.Functions.GetItemByName("limewater")
    if coyotefur ~= nil and limewater ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('lrp-hunting:SellPelts')
AddEventHandler('lrp-hunting:SellPelts', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local boarskin = Player.Functions.GetItemByName("processed_boarskin")
    local deerskin = Player.Functions.GetItemByName("processed_deerskin")
    local coyotefur = Player.Functions.GetItemByName("processed_coyotefur")

    local boaram = 0
    local deeram = 0
    local coyoteam = 0

    if boarskin then  
        boaram = boarskin.amount
        for i = 1, boaram do
            Player.Functions.RemoveItem("processed_boarskin", 1)
            TriggerEvent('qb-banking:server:sendPaycheck', Config.payout.boarskin, src)
            --TriggerClientEvent('QBCore:Notify', -1, "You received a Paycheck, you can get it at the Pacific Standard Bank!", "success")
            -- Player.Functions.AddMoney('cash', Config.payout.boarskin)
        end
    end

    if deerskin then  
        deeram = deerskin.amount 
        for i = 1, deeram do
            Player.Functions.RemoveItem("processed_deerskin", 1)
            TriggerEvent('qb-banking:server:sendPaycheck', Config.payout.deerskin, src)
            --TriggerClientEvent('QBCore:Notify', -1, "You received a Paycheck, you can get it at the Pacific Standard Bank!", "success")
            -- Player.Functions.AddMoney('cash', Config.payout.deerskin)
        end
    end

    if coyotefur then    
        coyoteam = coyotefur.amount
        for i = 1, coyoteam do
            Player.Functions.RemoveItem("processed_coyotefur", 1)
            TriggerEvent('qb-banking:server:sendPaycheck', Config.payout.coyotefur, src)
            --TriggerClientEvent('QBCore:Notify', -1, "You received a Paycheck, you can get it at the Pacific Standard Bank!", "success")
            -- Player.Functions.AddMoney('cash', Config.payout.coyotefur)
        end
    end
end)