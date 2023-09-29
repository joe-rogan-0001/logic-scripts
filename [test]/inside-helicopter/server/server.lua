local QBCore = exports['lrp-core']:GetCoreObject()


QBCore.Functions.CreateCallback('inside-helicopter:payout', function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local money = Config.Payout
	xPlayer.Functions.AddMoney("cash", money)
    cb(money)
end)