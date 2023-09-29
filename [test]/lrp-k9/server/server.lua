local QBCore = exports['lrp-core']:GetCoreObject()

RegisterServerEvent("K9:SERVER:SPAWN_K9", function(model, colour, vest)
    local PLAYER = QBCore.Functions.GetPlayer(source).PlayerData

    if PLAYER.job ~= nil and PLAYER.job.name == "police" and PLAYER.job.grade.level >= 1 then

      TriggerClientEvent("K9:CLIENT:SPAWN_K9", source, model, colour, vest)

    end

end)

RegisterServerEvent("K9:SERVER:SEARCH_PERSON")
AddEventHandler("K9:SERVER:SEARCH_PERSON", function(target)
  
   local PLAYER_CHECK =  HasIllegalItems(target)

   if PLAYER_CHECK then
   	TriggerClientEvent("k9:client:search_results", source, true, 'person')
   end

end)

RegisterServerEvent("K9:SERVER:SEARCH_VEHICLE")
AddEventHandler("K9:SERVER:SEARCH_VEHICLE", function(vehicle, players)

	SearchVehicle(source, vehicle, players)

end)

function SearchVehicle(source, vehicle, players)
  local VEHICLE_RESULTS = nil
  local PLAYER_RESULTS = false

    TriggerEvent("inventory:server:SearchLocalVehicleInventory", vehicle, Config.K9Search, function (results)
   		VEHICLE_RESULTS = results
	end)

	while VEHICLE_RESULTS == nil do
    	Citizen.Wait(0)
    end

    if not VEHICLE_RESULTS then
		for i = 1, #players do

		local ITEM = HasIllegalItems(players[i])

			if ITEM then
				PLAYER_RESULTS = true
				break
			end
		end
	end

	if VEHICLE_RESULTS or PLAYER_RESULTS then
		TriggerClientEvent("k9:client:search_results", source, true, 'vehicle')
	else
		TriggerClientEvent("k9:client:search_results", source, false, 'vehicle')
	end
end

function HasIllegalItems(target)
	local Player = QBCore.Functions.GetPlayer(target)

	for i = 1, #Config.K9Search do

 		local item = Player.Functions.GetItemByName(Config.K9Search[i])

 		if item ~= nil then
 			return true
 		end
	end

	return false
end
