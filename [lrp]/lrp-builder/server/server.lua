local QBCore = exports['lrp-core']:GetCoreObject()

RegisterServerEvent('inside-builder:Payout')
AddEventHandler('inside-builder:Payout', function(amount)	
	local src = source
	local player = QBCore.Functions.GetPlayer(src)
	TriggerEvent('qb-banking:server:sendPaycheck', amount, src)
	--TriggerClientEvent('QBCore:Notify', -1, "You received a Paycheck, you can get it at the Pacific Standard Bank!", "success")
	-- player.Functions.AddMoney('bank', amount)
end)