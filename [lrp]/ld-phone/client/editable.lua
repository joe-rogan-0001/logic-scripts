Framework = nil

Citizen.CreateThread(function()
    while Framework == nil do
        Config.GetSharedObject(function(obj)
            Framework = obj
        end)        
        Citizen.Wait(0)
    end
end)

RegisterCommand('openPhone', function()
    if not PhoneData.IsOpen then
        Config.ItemCheck(Framework, function(state)
            if state then
                OpenPhone()
            end
        end)
    end
end)

RegisterKeyMapping('openPhone', 'Open Phone', 'keyboard', Config.OpenPhone)

OpenPhone = function()
    if PhoneData.CanOpen then 
        PhoneData.IsOpen = true
        SetNuiFocus(true, true)
        -- SetNuiFocusKeepInput(true)
        TriggerServerEvent('phone:getinfos')
        if PhoneData.phone_number == 0 then
            Framework.Functions.TriggerCallback('ld-phone:GetPlayerDetails', function(details)
                PhoneData.phone_number = details.phonenumber
                PhoneData.cid = details.cid
            end)
            Framework.Functions.TriggerCallback('ld-phone:GetPlayerContacts', function(details)
                PhoneData.contacts = details
            end)
        end
        while PhoneData.phone_number == 0 do
            Wait(0)
        end
        SendNUIMessage({
            type = "open",
            id = GetPlayerServerId(PlayerId()),
            phonenumber = PhoneData.phone_number,
            applications = Config.Applications,
        })
        DoPhoneAnimation('cellphone_text_in')
        newPhoneProp()

        CreateThread(function()
            local playerId = PlayerId()
            repeat
                DisablePlayerFiring(playerId, true)
				-- DisableControlAction(0, 24, true)
                DisableControlAction(0, 25, true)
                DisableControlAction(0, 37, true)
                -- DisableControlAction(0, 142, true)
                Wait(0)
            until PhoneData.IsOpen == false
        end)
    end
end

ClosePhone = function()
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    SendNUIMessage({
        type = "close"
    })
    if not PhoneData.InCall then
        DoPhoneAnimation('cellphone_text_out')
        SetTimeout(400, function()
            StopAnimTask(PlayerPedId(), PhoneData.Animationlib, PhoneData.Animationanim, 2.5)
            deletePhone()
            PhoneData.Animationlib = nil
            PhoneData.Animationanim = nil
        end)
    else
        PhoneData.Animationlib = nil
        PhoneData.Animationanim = nil
        DoPhoneAnimation('cellphone_text_to_call')
    end

    Wait(500)
    PhoneData.IsOpen = false
end

RegisterNUICallback('ClosePhone', function()
    ClosePhone()
end)

RegisterNUICallback('GetPlayerVehicles', function(data, cb)
    Framework.Functions.TriggerCallback('ld-phone:GetPlayerVehicles', function(details)
        for i = 1, #details do
            details[i].modelname = GetDisplayNameFromVehicleModel(details[i].modelname)
        end
        cb(details)
    end)
end)

--[[
RegisterNetEvent('ld-phone:client:UseVPN')
AddEventHandler('ld-phone:client:UseVPN', function()
    local finished = exports["ld-taskbar"]:taskBar(5000, "Using VPN...")
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        SendNUIMessage({
            type = "vpn",
            status = true
        })
        if Config.VPNEnableForceClose then
            Citizen.Wait(Config.VPNTime * 1000)
            ClosePhone()
            SendNUIMessage({
                type = "vpn",
                status = false
            })
        end
    end
end)
]]--

SendNUIMessage({
    type = "vpn",
    status = true
})

RegisterNUICallback('SpawnVehicle', function(data, cb)
    -- MAKE GPS FOR CAR AND CHECK IF
    --[[
    Framework.Functions.TriggerCallback('ld-phone:GetVehicleFromPlate', function(asd)
        if asd then
            local adata = json.encode(asd.mods)
            local wait = 1000 * math.random(Config.VehicleSpawnDelay.min, Config.VehicleSpawnDelay.max)
            cb(true)
            -- Wait(wait)
            local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
            local spawnPoint = {x = coords.x,  y = coords.y, z = coords.z, r = 1.0}
            Framework.Functions.SpawnVehicle(asd.vehicle, function(veh) 
                if data.plate ~= nil then
                    Config.VehicleStoredTrigger(data.plate)
                end

                Framework.Functions.SetVehicleProperties(veh, adata)
                SetVehicleNumberPlateText(veh, data.plate)
                SetEntityAsMissionEntity(veh, true, true)
                SetVehicleEngineOn(veh, true, true)
            end, spawnPoint, true)
        else 
            cb(false)
        end
    end, data.plate)
    ]]--
end)

--[[
RegisterNetEvent('qb-phone:client:recieveMail', function(sender, subject, message)
    exports['ld-phone']:SendMailToPlayer(playerId, subject, sender, message)
end)
]]--