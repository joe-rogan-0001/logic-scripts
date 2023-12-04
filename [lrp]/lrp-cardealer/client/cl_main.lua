WSCore = exports['lrp-core']:GetCoreObject()


CreateThread(function()
  local hash = Config.PedProps['hash']
  local coords = Config.PedProps['location']
  WSCore.Functions.LoadModel(hash)
  local buyerPed = CreatePed(0, hash, coords.x, coords.y, coords.z-1.0, coords.w, false, false)
TaskStartScenarioInPlace(buyerPed, 'WORLD_HUMAN_HANG_OUT_STREET_CLUBHOUSE', true)
FreezeEntityPosition(buyerPed, true)
SetEntityInvincible(buyerPed, true)
SetBlockingOfNonTemporaryEvents(buyerPed, true)

exports.ox_target:addBoxZone({
  coords = Config.Target.pos,
  size = Config.Target.size,
  rotation = Config.Target.heading,
  debug = Config.Target.debug,
  options = {
      {
          name = 'Cardealer',
          event = 'lrp-cardealer:enterExperience',
          icon = Config.Target.icon,
          label = ("View Catalog"),
      }
  }
})
end)

RegisterNUICallback("showroomPurchaseCurrentVehicle", function(data, cb)
  WSCore.Functions.TriggerCallback("lrp-cardealer:purchaseVehicle", function(success, model, plate)
	if success then
    DoScreenFadeOut(0)
    Wait(400)
    DoScreenFadeIn(1000)
    SetNuiFocus(false, false)
    ClearFocus()
    TriggerEvent("lrp-cardealer:exit")
    RenderScriptCams(false, false, 0, 1, 0)
    DeleteEntity(vehicle)
    TakeOutVehicle(model, plate)
		cb({
			data = {},
			meta = {
				ok = true,
			}
		});
	else
		WSCore.Functions.Notify("You don't have enough money in your bank account!")
	end;
  end, data.model, data.price, data.zoneName)
end);

function TakeOutVehicle(vehicle, plate)
    WSCore.Functions.SpawnVehicle(vehicle, function(vehicle)
      --TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
      exports['cdn-fuel']:SetFuel(vehicle, 100)
      SetVehicleNumberPlateText(vehicle, plate)
      SetEntityHeading(vehicle, vector4(-27.81, -1081.75, 26.01, 70.97).w)
      SetEntityAsMissionEntity(vehicle, true, true)
      TriggerEvent("vehiclekeys:client:SetOwner", plate)
      --TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', plate, GetPlayerServerId(PlayerPedId()))
      TriggerServerEvent("qb-vehicletuning:server:SaveVehicleProps", WSCore.Functions.GetVehicleProperties(vehicle))
      local networkid = NetworkGetNetworkIdFromEntity(vehicle)
      SetNetworkIdExistsOnAllMachines(networkid, true)
      SetNetworkIdCanMigrate(networkid, true)
      WSCore.Functions.Notify("Your vehicle in the garage!")
    end, vector4(-27.81, -1081.75, 26.01, 70.97), true)
end

--[[
RegisterCommand("cord", function()
coords = GetEntityCoords(PlayerPedId())
head = GetEntityHeading(PlayerPedId())
print(coords, head)
end)
]]--

--Blips
Citizen.CreateThread(function ()
  local Dealer = AddBlipForCoord(vector3(-46.74, -1097.86, 26.42))
  SetBlipSprite (Dealer, 326)
  SetBlipDisplay(Dealer, 4)
  SetBlipScale  (Dealer, 0.75)
  SetBlipAsShortRange(Dealer, true)
  SetBlipColour(Dealer, 3)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName("PDM")
  EndTextCommandSetBlipName(Dealer)
end)



