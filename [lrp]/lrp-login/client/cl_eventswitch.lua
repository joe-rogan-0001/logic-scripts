function Login.playerLoaded() end

function Login.characterLoaded()  
end

function Login.characterSpawned()

  isNear = false
  TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
  TriggerEvent('QBCore:Client:OnPlayerLoaded')
  TriggerEvent('lrp-login:server:startReady')
  
  SetPedMaxHealth(PlayerPedId(), 200)
  SetPlayerMaxArmour(PlayerId(), 60)
  runGameplay() -- moved from NP-base 
  Spawn.isNew = false
end

RegisterNetEvent("np-spawn:characterSpawned");
AddEventHandler("np-spawn:characterSpawned", Login.characterSpawned)

RegisterNetEvent("np-spawn:getStartingItems");
AddEventHandler("np-spawn:getStartingItems", function(cid, information)
  TriggerServerEvent('server-inventory-give', cid, "idcard", 1, 1, true, information)
	TriggerServerEvent('server-inventory-give', cid, "mobilephone", 2, 1, false, {})
end)

RegisterNetEvent("np-spawn:getNewAccountBox");
AddEventHandler("np-spawn:getNewAccountBox", function(cid)
  TriggerServerEvent('server-inventory-give', cid, "newaccountbox", 3, 1, false, {})
end)

RegisterNetEvent("np-spawn:displayInfo", function()
  SendNUIMessage({
    displayInfo = true,
  })
  TriggerEvent("chatMessage", "SYSTEM", 4, "We should've opened two links in your browser, make sure you read through them both.")
end)