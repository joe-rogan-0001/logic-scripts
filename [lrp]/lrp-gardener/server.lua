local QBCore = exports['lrp-core']:GetCoreObject()

QBCore.Functions.CreateCallback('inside-gardener:checkMoney', function(source, cb)
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

RegisterServerEvent('inside-gardener:returnVehicle')
AddEventHandler('inside-gardener:returnVehicle', function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	-- TriggerEvent('qb-banking:server:sendPaycheck', Config.DepositPrice, source)
	xPlayer.Functions.AddMoney('bank', Config.DepositPrice)
end)

RegisterServerEvent('inside-gardener:Payout')
AddEventHandler('inside-gardener:Payout', function(salary, arg)	
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local Payout = salary * arg
	TriggerEvent('qb-banking:server:sendPaycheck', Payout, source)
	--TriggerClientEvent('QBCore:Notify', -1, "You received a Paycheck, you can get it at the Pacific Standard Bank!", "success")
	-- xPlayer.Functions.AddMoney('bank', Payout)
end)