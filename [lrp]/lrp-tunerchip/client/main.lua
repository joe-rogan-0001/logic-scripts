QBCore = exports['lrp-core']:GetCoreObject()


local inTuner = false
local RainbowNeon = false

local SaveData = {}


function setVehData(veh,data)
    if not DoesEntityExist(veh) or not data then return nil end
    if SaveData[GetVehicleNumberPlateText(veh)] == nil then
        SaveData[GetVehicleNumberPlateText(veh)] = {}
    end
        for k, v in pairs(Config.TuneVars) do 
            if k ~= 'drivetrain' and k ~= 'gearchange' then 
                SetVehicleHandlingFloat(veh, "CHandlingData", v.key, data[k] * v.multp)
                SaveData[GetVehicleNumberPlateText(veh)][k] = data[k]
            elseif k == 'drivetrain' then 
                local dTrain = 0.0
                if tonumber(data.drivetrain) == 2 then dTrain = 0.5 elseif tonumber(data.drivetrain) == 3 then dTrain = 1.0 end
                SetVehicleHandlingFloat(veh, "CHandlingData", v.key, dTrain * v.multp)
                SaveData[GetVehicleNumberPlateText(veh)][k] = dTrain
            elseif k == 'gearchange' then 
                SetVehicleEnginePowerMultiplier(veh, data[k] * v.multp)
                SaveData[GetVehicleNumberPlateText(veh)][k] = data[k]
            end
        end
        
        TriggerServerEvent('SaveTuning', GetVehicleNumberPlateText(veh), SaveData[GetVehicleNumberPlateText(veh)])
end



function resetVeh(veh)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", 1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", 1.0)
    SetVehicleEnginePowerMultiplier(veh, 1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", 0.5)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", 1.0)
end

RegisterNUICallback('save', function(data)
    QBCore.Functions.TriggerCallback('qb-tunerchip:server:HasChip', function(HasChip)
        if HasChip then
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsUsing(ped)
            setVehData(veh, data)
            QBCore.Functions.Notify('Vehicle Tuned and Saved', 'error')

            TriggerServerEvent('qb-tunerchip:server:TuneStatus', GetVehicleNumberPlateText(veh), true)
        end
    end)
end)

RegisterNetEvent('qb-tunerchip:server:TuneStatus')
AddEventHandler('qb-tunerchip:server:TuneStatus', function()
    local ped = PlayerPedId()
    local closestVehicle = GetClosestVehicle(GetEntityCoords(ped), 5.0, 0, 70)
    local plate = GetVehicleNumberPlateText(closestVehicle)
    local vehModel = GetEntityModel(closestVehicle)

    local displayName = GetLabelText(GetDisplayNameFromVehicleModel(vehModel))

    QBCore.Functions.TriggerCallback('qb-tunerchip:server:GetStatus', function(status)
        if status then
            TriggerEvent("chatMessage", "Vehicle Status", "warning", displayName..": Chiptuned: Yes")
        else
            TriggerEvent("chatMessage", "Vehicle Status", "warning", displayName..": Chiptuned: No")
        end
    end, plate)
end)

RegisterNUICallback('checkItem', function(data, cb)
    local retval = false
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            retval = true
        end
        cb(retval)
    end, data.item)
end)

RegisterNUICallback('reset', function(data)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    resetVeh(veh)
    QBCore.Functions.Notify('TunerChip v1.05: Vehicle has been reset!', 'error')
end)

RegisterNetEvent('qb-tunerchip:client:openChip')
AddEventHandler('qb-tunerchip:client:openChip', function()
    local ped = PlayerPedId()
    local inVehicle = IsPedInAnyVehicle(ped)
    local veh = GetVehiclePedIsIn(ped)
    local plate = GetVehicleNumberPlateText(veh)

    if inVehicle then
        QBCore.Functions.Progressbar("connect_laptop", "Plugging Tunerchip In!", 1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 16,
        }, {}, {}, function() -- Done       
                StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                openTunerLaptop(true)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            QBCore.Functions.Notify("Canceled", "error")
        end)
    else
        QBCore.Functions.Notify("You Are Not In A Vehicle", "error")
    end
end)


RegisterNUICallback('exit', function()
    openTunerLaptop(false)
    SetNuiFocus(false, false)
    inTuner = false
end)

local LastRainbowNeonColor = 0

local RainbowNeonColors = {
    [1] = {
        r = 255,
        g = 0,
        b = 0
    },
    [2] = {
        r = 255,
        g = 165,
        b = 0
    },
    [3] = {
        r = 255,
        g = 255,
        b = 0
    },
    [4] = {
        r = 0,
        g = 0,
        b = 255
    },
    [5] = {
        r = 75,
        g = 0,
        b = 130
    },
    [6] = {
        r = 238,
        g = 130,
        b = 238
    },
}

RegisterNetEvent('qb-tunerchip:client:ApplyTunes')
AddEventHandler('qb-tunerchip:client:ApplyTunes', function(veh)
    Citizen.Wait(500) 
    local plate = GetVehicleNumberPlateText(veh)
    QBCore.Functions.TriggerCallback('qb-tunerchip:server:GetVehicleTuning', function(result)
        if result ~= nil then
            local data = result
            SaveData[plate] = result

            for k, v in pairs(Config.TuneVars) do 
                if data[k] ~= nil then
                    if k ~= 'drivetrain' and k ~= 'gearchange' then 
                        SetVehicleHandlingFloat(veh, "CHandlingData", v.key, data[k] * v.multp)
                    elseif k == 'drivetrain' then 
                        local dTrain = 0.0
                        if tonumber(data.drivetrain) == 2 then dTrain = 0.5 elseif tonumber(data.drivetrain) == 3 then dTrain = 1.0 end
                        SetVehicleHandlingFloat(veh, "CHandlingData", v.key, dTrain * v.multp)
                    elseif k == 'gearchange' then 
                        SetVehicleEnginePowerMultiplier(veh, data[k] * v.multp)
                    end
                end
            end

            if result.neonEnabled ~= nil then
                if result.neonEnabled == 1 then 
                    for x = 0, 3, 1 do
                        SetVehicleNeonLightEnabled(veh, x, true)
                    end
                    SetVehicleNeonLightsColour(veh, tonumber(data.r), tonumber(data.g), tonumber(data.b))
                end
            end

            if result.h ~= nil then 
                ToggleVehicleMod(veh, 22, true)
                SetVehicleXenonLightsColor(veh, tonumber(data.h))
            end
            
            for k, v in pairs(Config.Stancer) do 
                if data[k] ~= nil then 
                    local st = data
                    exports["vstancer"]:SetWheelPreset(veh, st.fOffset, st.fRotation, st.rOffset, st.rRotation)
                end
            end
        end
    end, plate)
end)

RegisterNUICallback('saveNeon', function(data)
    QBCore.Functions.TriggerCallback('qb-tunerchip:server:HasChip', function(HasChip)
        if HasChip then
            if not data.rainbowEnabled then
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped)
                if SaveData[GetVehicleNumberPlateText(veh)] == nil then
                    SaveData[GetVehicleNumberPlateText(veh)] = {}
                end
                if tonumber(data.neonEnabled) == 1 then
                    for x = 0, 3, 1 do
                        SetVehicleNeonLightEnabled(veh, x, true)
                    end
                    if tonumber(data.r) ~= nil and tonumber(data.g) ~= nil and tonumber(data.b) ~= nil then
                        SetVehicleNeonLightsColour(veh, tonumber(data.r), tonumber(data.g), tonumber(data.b))
                        SaveData[GetVehicleNumberPlateText(veh)].r = tonumber(data.r)
                        SaveData[GetVehicleNumberPlateText(veh)].g = tonumber(data.g)
                        SaveData[GetVehicleNumberPlateText(veh)].b = tonumber(data.b)
                        SaveData[GetVehicleNumberPlateText(veh)].neonEnabled = tonumber(data.neonEnabled)
                        TriggerServerEvent('SaveTuning', GetVehicleNumberPlateText(veh), SaveData[GetVehicleNumberPlateText(veh)])
                    else
                        SetVehicleNeonLightsColour(veh, 255, 255, 255)
                    end
                    RainbowNeon = false
                else
                    for x = 0, 3, 1 do
                        SetVehicleNeonLightEnabled(veh, x, false)
                    end
                    RainbowNeon = false
                end
            else
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped)

                if tonumber(data.neonEnabled) == 1 then
                    if not RainbowNeon then
                        RainbowNeon = true
                        for x = 0, 3, 1 do
                            SetVehicleNeonLightEnabled(veh, x, true)
                        end
                        Citizen.CreateThread(function()
                            while true do
                                if RainbowNeon then
                                    if (LastRainbowNeonColor + 1) ~= 7 then
                                        LastRainbowNeonColor = LastRainbowNeonColor + 1
                                        SetVehicleNeonLightsColour(veh, RainbowNeonColors[LastRainbowNeonColor].r, RainbowNeonColors[LastRainbowNeonColor].g, RainbowNeonColors[LastRainbowNeonColor].b)
                                    else
                                        LastRainbowNeonColor = 1
                                        SetVehicleNeonLightsColour(veh, RainbowNeonColors[LastRainbowNeonColor].r, RainbowNeonColors[LastRainbowNeonColor].g, RainbowNeonColors[LastRainbowNeonColor].b)
                                    end
                                else
                                    break
                                end

                                Citizen.Wait(350)
                            end
                        end)
                    end
                else
                    RainbowNeon = false
                    for x = 0, 3, 1 do
                        SetVehicleNeonLightEnabled(veh, x, false)
                    end
                end
            end
        end
    end)
end)

local RainbowHeadlight = false
local RainbowHeadlightValue = 0

RegisterNUICallback('saveHeadlights', function(data)
    QBCore.Functions.TriggerCallback('qb-tunerchip:server:HasChip', function(HasChip)
        if HasChip then
            if data.rainbowEnabled then
                RainbowHeadlight = true
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped)
                local value = tonumber(data.value)

                Citizen.CreateThread(function()
                    while true do
                        if RainbowHeadlight then
                            if (RainbowHeadlightValue + 1) ~= 12 then
                                RainbowHeadlightValue = RainbowHeadlightValue + 1
                                ToggleVehicleMod(veh, 22, true)
                                SetVehicleXenonLightsColor(veh, RainbowHeadlightValue)
                            else
                                RainbowHeadlightValue = 1
                                ToggleVehicleMod(veh, 22, true)
                                SetVehicleXenonLightsColor(veh, RainbowHeadlightValue)
                            end
                        else
                            break
                        end
                        Citizen.Wait(300)
                    end
                end)                
                ToggleVehicleMod(veh, 22, true)
                SetVehicleXenonLightsColor(veh, value)
                if SaveData[GetVehicleNumberPlateText(veh)] == nil then
                    SaveData[GetVehicleNumberPlateText(veh)] = {}
                end
                SaveData[GetVehicleNumberPlateText(veh)].h = value
                TriggerServerEvent('SaveTuning', GetVehicleNumberPlateText(veh), SaveData[GetVehicleNumberPlateText(veh)])
            else
                RainbowHeadlight = false
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped)
                local value = tonumber(data.value)

                ToggleVehicleMod(veh, 22, true)
                SetVehicleXenonLightsColor(veh, value)

                if SaveData[GetVehicleNumberPlateText(veh)] == nil then
                    SaveData[GetVehicleNumberPlateText(veh)] = {}
                end
                SaveData[GetVehicleNumberPlateText(veh)].h = value
                TriggerServerEvent('SaveTuning', GetVehicleNumberPlateText(veh), SaveData[GetVehicleNumberPlateText(veh)])
            end
        end
    end)
end)

function openTunerLaptop(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool
    })
    inTuner = bool
end

RegisterNUICallback('SetStancer', function(data, cb)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    local plate = GetVehicleNumberPlateText(veh)

    if SaveData[GetVehicleNumberPlateText(veh)] == nil then
        SaveData[GetVehicleNumberPlateText(veh)] = {}
    end

    for k,v in pairs(Config.Stancer) do 
        SaveData[GetVehicleNumberPlateText(veh)][k] = -(data[k] * 100 / 1000)
    end
    TriggerServerEvent('SaveTuning', GetVehicleNumberPlateText(veh), SaveData[GetVehicleNumberPlateText(veh)])
    
    local st = SaveData[plate]

    exports["vstancer"]:SetWheelPreset(veh, st.fOffset, st.fRotation, st.rOffset, st.rRotation)
end)

