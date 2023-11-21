local QBCore = exports['lrp-core']:GetCoreObject()
local CurrentCops = 1

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true

    if model == `mp_m_freemode_01` then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

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

CanOpenSafe = false

RegisterNetEvent('qb-storerobbery:client:cracksafe', function(data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    local SafeID = data.entity

    local canrob = true
    local resultarrived = false
    local isCooldown = false

    local haslockpick = exports.ox_inventory:GetItemCount('advancedlockpick', nil, nil)
    local waitingforitemcheck = false

    if not (haslockpick >= 1) then QBCore.Functions.Notify("What are you trying to crack the safe with?.", "error") return end
    
    local waitingforcooldown = false
    QBCore.Functions.TriggerCallback('qb-storerobbery:server:checkcooldown', function(result)
        isCooldown = result
        waitingforcooldown = true
    end, SafeID)

    while not waitingforcooldown do
        Wait(5)
    end

    if isCooldown then QBCore.Functions.Notify("Come back later.", "error") return end

    QBCore.Functions.TriggerCallback('qb-storerobbery:server:canrobsafe', function(result)
        canrob = result
        resultarrived = true
    end, SafeID)

    while not resultarrived do
        Wait(5)
    end
    
    if not canrob then 
        QBCore.Functions.Notify("Safe is Empty.", "error")
        return 
    end    

    if not (CurrentCops >= 1) then QBCore.Functions.Notify("Not enough Police", "error") return end

    exports["lrp-memorygame"]:thermiteminigame(10, 3, 5, 19,

    function()
        QBCore.Functions.Notify("Crack Complete, safe will open soon.", "success")
        TriggerEvent('ps-dispatch:client:storeRobbery')

        if math.random(1,4) > 3 then
            TriggerServerEvent("QBCore:Server:RemoveItem", "advancedlockpick", 1)
        end

        if not IsWearingHandshoes() then
            TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
        end
        
        TriggerServerEvent("qb-storerobbery:server:startcooldown")
        TriggerServerEvent("qb-storerobbery:server:emptysafe", SafeID)
        Citizen.Wait(Config.Timer) -- 2.5 minutes
        CanOpenSafe = true
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, 'shopsafe', 0.5)
    end,
    function()
        QBCore.Functions.Notify("Crack failed.", "error")
        TriggerServerEvent("QBCore:Server:RemoveItem", "advancedlockpick", 1)
        if not IsWearingHandshoes() then
            TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
        end
    end)
end)

RegisterNetEvent('qb-storerobbery:client:opensafe', function()
    if CanOpenSafe then
        TriggerServerEvent('qb-storerobbery:server:safe')
        CanOpenSafe = false
    else
        QBCore.Functions.Notify("Safe is not open.", "error")
    end
end)

RegisterNetEvent('storerobbery:client:skillbar', function(data)
    local pEntity = data.entity
    local currentTargetCoords = GetEntityCoords(pEntity)
    local registerId = string.format("%.2f", currentTargetCoords.x) .. "_" .. string.format("%.2f", currentTargetCoords.y) .. "_" .. string.format("%.2f", currentTargetCoords.z)
    local canrob = true
    local resultarrived = false

    if not (CurrentCops >= 1) then QBCore.Functions.Notify("Not enough Police", "error") return end

    QBCore.Functions.TriggerCallback('qb-storerobbery:server:canrobregister', function(result)
        canrob = result
        resultarrived = true
    end, registerId)

    while not resultarrived do
        Wait(5)
    end

    if not canrob then 
        QBCore.Functions.Notify("Register is Empty.", "error")
        return 
    end

    TriggerEvent('ps-dispatch:client:storeRobbery')

    local seconds = math.random(5,10)
    local success = exports['lrp-skill']:StartLockPickCircle(2, seconds, success)

    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    if not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
    end

    if success then
        TriggerServerEvent("qb-storerobbery:server:register")
        TriggerServerEvent("qb-storerobbery:server:emptyregister", registerId)
    end
end)

Citizen.CreateThread(function()
    exports['lrp-target']:AddTargetModel({303280717}, {
        debugPoly = true,
        options = {
            {
                event = "storerobbery:client:skillbar",
                icon = "fas fa-hammer",
                label = "Smash!",
                canInteract = function(entity)
                    return GetObjectFragmentDamageHealth(entity, true) < 1.0
                end,
            },
        },
        distance = 1
    })
  end)
