local QBCore = exports['lrp-core']:GetCoreObject()

QBCore.Functions.CreateCallback('inside-warehouse:checkMoney', function(source,cb)
	local src = source
	local player = QBCore.Functions.GetPlayer(src)
	local bank = player.PlayerData.money['bank']

	if bank >= Config.DepositPrice then
        player.Functions.RemoveMoney('bank', Config.DepositPrice)
        cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('inside-warehouse:returnVehicle')
AddEventHandler('inside-warehouse:returnVehicle', function()
	local src = source
	local player = QBCore.Functions.GetPlayer(src)
	local Payout = Config.DepositPrice
	-- TriggerEvent('qb-banking:server:sendPaycheck', Config.DepositPrice, source)
	player.Functions.AddMoney('bank', Config.DepositPrice)
end)

RegisterServerEvent('inside-warehouse:Payout')
AddEventHandler('inside-warehouse:Payout', function(arg)	
	local src = source
	local player = QBCore.Functions.GetPlayer(src)
	local Payout = Config.Payout * arg
	TriggerEvent('qb-banking:server:sendPaycheck', Payout, source)
	--TriggerClientEvent('QBCore:Notify', -1, "You received a Paycheck, you can get it at the Pacific Standard Bank!", "success")
	-- player.Functions.AddMoney('bank', Payout)
end)