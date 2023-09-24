TriggerServerEvent("np:server:blackout")

RegisterNetEvent('np:client:blackout')
AddEventHandler('np:client:blackout', function(blackout)
    SetArtificialLightsStateAffectsVehicles(false)
    SetArtificialLightsState(blackout)
end)

RegisterNetEvent("particle:explosion:coord")
AddEventHandler("particle:explosion:coord", function(position)
  AddExplosion(position, 29, 5.0, 1, 0, 1, 1)
  Wait(500)
  StopFireInRange(position, 5.0)
end)