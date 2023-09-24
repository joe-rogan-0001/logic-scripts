local QBCore = exports['lrp-core']:GetCoreObject()

function dump(o)
  if type(o) == 'table' then
     local s = '{ '
     for k,v in pairs(o) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '['..k..'] = ' .. dump(v) .. ','
     end
     return s .. '} '
  else
     return tostring(o)
  end
end

RegisterServerEvent('evidence:pooled')
AddEventHandler('evidence:pooled', function(data)
    TriggerClientEvent('evidence:pooled',-1,data)
end)

RegisterServerEvent('evidence:removal')
AddEventHandler('evidence:removal', function(id)
    TriggerClientEvent('evidence:remove:done',-1,id)
end)

RegisterServerEvent('evidence:clear')
AddEventHandler('evidence:clear', function(id)
    for k,v in ipairs(id) do
      TriggerClientEvent('evidence:remove:done',-1,v)
    end
end)

RegisterServerEvent('evidence:server:AddEvidenceToInventory')
AddEventHandler('evidence:server:AddEvidenceToInventory', function(id,eType,other,item)
  local src = source

  local info = {}
  info.id = id
  if eType == "vehiclefragment" then
    info.id = '0'
  end
  info.etype = eType
  info.other = other
  info.item = item 

  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
    if Player.Functions.AddItem("filled_evidence_bag", 1, false, info) then
      TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
    end
  else
    TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
  end
end)

QBCore.Commands.Add("clearevidence", "Clear Evidence in Area (Police Only)", {}, false, function(source)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
      TriggerClientEvent("evidence:clear", src)
  else
      TriggerClientEvent('QBCore:Notify', src, 'For on-duty police only', 'error')
  end
end)

QBCore.Functions.CreateUseableItem("camera", function(source, item)
  local src = source
  TriggerClientEvent("camera:Activate2", src)
end)