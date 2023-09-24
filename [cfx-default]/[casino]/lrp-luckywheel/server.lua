
local QBCore = exports['lrp-core']:GetCoreObject()
isRoll = false

if Config.LimitedSpins then
	Citizen.CreateThread(function()
		while true do
			Wait(Config.LimitedSpinResetTime)
			MySQL.Async.fetchAll('UPDATE players SET luckywheel_spins = 0')
			TriggerClientEvent('QBCore:Notify', -1, "Daily LuckyWheel reset", "success")
		end
	end)
end

RegisterNetEvent('luckywheel:getwheel', function(rigness)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Config.LimitedSpins then 
		local result = MySQL.Sync.fetchScalarSync('SELECT luckywheel_spins FROM players where citizenid= ?', {Player.PlayerData.citizenid})
		if result == '0' then
			TriggerEvent("luckywheel:startwheel", Player, src)
		else
			TriggerClientEvent('QBCore:Notify', src, "You have already had a spin on the wheel today", "error")
		end
	elseif Config.LimitedSpins == false then
		if Player.PlayerData.money["cash"] >= rigness then
			Player.Functions.RemoveMoney("cash", tonumber(rigness), "lucky-wheel")
			TriggerEvent('qb-banking:society:server:DepositMoney', src, tonumber(rigness), 'casino')
			TriggerEvent("luckywheel:startwheel", Player, src)
		else
			return TriggerClientEvent('QBCore:Notify', src, "You have enough cash to spin", "error")
		end
	end
end)

RegisterNetEvent('luckywheel:startwheel', function(Player, source)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if not isRoll then
        if Player then
            --MySQL.Async.fetchAll('UPDATE players SET luckywheel_spins = 1 where citizenid= ?', {Player.PlayerData.citizenid})
			isRoll = true
			local rnd = math.random(1, 1000)
			local price = 0
			local priceIndex = 0
			for k,v in pairs(Config.Prices) do
				if (rnd > v.probability.a) and (rnd <= v.probability.b) then
					price = v
					priceIndex = k
					break
				end
			end
			TriggerClientEvent("luckywheel:syncanim", src, priceIndex)
			TriggerClientEvent("luckywheel:startroll", -1, src, priceIndex, price)
		end
	end
end)

RegisterNetEvent('luckywheel:give', function(source, price)
	local Player = QBCore.Functions.GetPlayer(source)
	isRoll = false
	if price.type == 'car' then
		TriggerClientEvent("dojLuckywheel:winCar", source)
		TriggerClientEvent("chCasinoWall:bigWin", source)
	elseif price.type == 'item' then
		TriggerClientEvent("chCasinoWall:bigWin", source)
		Player.Functions.AddItem(price.name, price.count, slot, {["quality"] = 100})
		TriggerClientEvent('QBCore:Notify', source, "Congratulations! You won "..price.count.." "..price.name.."!", 'success')
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[price.name], "add",price.count )
	elseif price.type == 'money' then
		TriggerClientEvent("chCasinoWall:bigWin", source)
		Player.Functions.AddMoney('cash', tonumber(price.count), 'banking-quick-depo')
		TriggerEvent('qb-banking:society:server:DepositMoney', source, tonumber(price.count) * -1, 'casino')
		TriggerClientEvent('QBCore:Notify', source, "Congratulations! You won $"..price.count, 'success')
	elseif price.type == 'weapon' then
		TriggerClientEvent("chCasinoWall:bigWin", source)
		Player.Functions.AddItem(price.name, 1, slot, {["quality"] = 100})
		TriggerClientEvent('QBCore:Notify', source, "Congratulations! You won a Pistol!", 'success')
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[price.name], "add",1)
	end
	TriggerClientEvent("luckywheel:rollFinished", -1)
end)

RegisterNetEvent('luckywheel:stoproll', function()
	isRoll = false
end)

RegisterNetEvent('luckywheel:server:setVehicleOwner', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local cid = Player.PlayerData.citizenid
	local vehicle = Config.VehiclePrize
	local plate = GeneratePlate()
	MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
		Player.PlayerData.license,
		cid,
		vehicle,
		GetHashKey(vehicle),
		'{}',
		plate,
		0
	})
end)


function GeneratePlate()
    local plate = QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(2)
    local result = MySQL.Sync.fetchScalarSync('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        return GeneratePlate()
    else
        return plate:upper()
    end
end
