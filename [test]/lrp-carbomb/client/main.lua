-- Variables

local QBCore = exports['lrp-core']:GetCoreObject()
local vehiclebeingsbombed = nil
local close2 = false 





RegisterNetEvent('lrp-carbomb:client:addcarbomb')
AddEventHandler('lrp-carbomb:client:addcarbomb', function(veh)  
    local vehicle = QBCore.Functions.GetClosestVehicle()
    QBCore.Functions.Progressbar("scrap_vehicle2", "Putting Car Bomb under the Vehicle", 2000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() 
        vehiclebeingsbombed = vehicle
	end, function() 
		QBCore.Functions.Notify("Canceled", "error")
	end)
end)



RegisterNetEvent('lrp-carbomb:client:ripbozo')
AddEventHandler('lrp-carbomb:client:ripbozo', function(veh, pos)    
    local ped = PlayerPedId()
    local posped = GetEntityCoords(ped)
    local posvehicle = pos
    NetworkExplodeVehicle(veh, true, false, 0)

    local dis = #(posped - posvehicle)

    close2 = false 
    if dis <= 2500 then 
        close2 = true 
    end

    AddExplosion(posvehicle.x, posvehicle.y, posvehicle.z-1.0, 82, 100.0, close2, false, false, false)
    AddExplosion(posvehicle.x, posvehicle.y-5.0, posvehicle.z-1.0, 82, 100.0, false, true, false, false)
    AddExplosion(posvehicle.x, posvehicle.y+5.0, posvehicle.z-1.0, 82, 100.0, false, true, false, false)
    Wait(100)
    AddExplosion(posvehicle.x+5.0, posvehicle.y, posvehicle.z-1.0, 82, 100.0, close2, false, false, false)
    AddExplosion(posvehicle.x-5.0, posvehicle.y, posvehicle.z-1.0, 82, 100.0, false, true, false, false)
    AddExplosion(posvehicle.x-4.0, posvehicle.y+4.0, posvehicle.z-1.0, 31, 100.0, false, false, false, false)
    AddExplosion(posvehicle.x+4.0, posvehicle.y-4.0, posvehicle.z-1.0, 82, 100.0, false, true, false, false)
    AddExplosion(posvehicle.x-5.0, posvehicle.y-5.0, posvehicle.z-1.0, 31, 100.0, false, false, false, false)
    AddExplosion(posvehicle.x+5.0, posvehicle.y+5.0, posvehicle.z-1.0, 82, 100.0, false, true, false, false)
end)







RegisterCommand('addbomb', function()
    TriggerEvent('lrp-carbomb:client:addcarbomb')
end)

RegisterCommand('boom', function()
    local pos = GetEntityCoords(vehiclebeingsbombed)
    TriggerServerEvent('lrp-carbomb:server:ripbozo', vehiclebeingsbombed, pos)
end)

