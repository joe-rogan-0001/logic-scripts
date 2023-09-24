local QBCore = exports['lrp-core']:GetCoreObject()

local CoolDown = false

RegisterNetEvent('kevin-bounties:server:coolout', function()
    CoolDown = true
    local timer = Config.CoolDown
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            CoolDown = false
        end
    end
end)

QBCore.Functions.CreateCallback("kevin-bounties:server:coolc",function(source, cb)
    if CoolDown then
        cb(true)
    else
        cb(false) 
    end
end)

RegisterNetEvent('kevin-bounties:server:Contract', function(FirstName,LastName,LastSeen,bountyprice,WantedFor)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {}
    info.targetname = FirstName
    info.targetlastname = LastName
    info.lastseen = LastSeen
    info.bountyprice = bountyprice
    info.wantedfor = WantedFor
    Player.Functions.AddItem("bounty-contract", 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items["bounty-contract"], 'add')
end)

RegisterNetEvent('kevin-bounties:server:CollectPay', function (data)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local pay = data.BountyPay
    local hasContract = Player.Functions.GetItemByName("bounty-contract")
    if hasContract then
        Player.Functions.RemoveItem("bounty-contract", 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items["bounty-contract"], 'remove')
    end
    Player.Functions.AddMoney('cash', pay, 'Bounty Contract Completed')
    TriggerClientEvent('kevin-bounties:client:Clean',src)
	Wait(2500)
end)