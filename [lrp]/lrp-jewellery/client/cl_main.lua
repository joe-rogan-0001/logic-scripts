local QBCore = exports['lrp-core']:GetCoreObject()

-- Code

local robberyAlert = false
local isLoggedIn = true
local firstAlarm = false

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('lrp-jewellery:client:startbreakinglass')
AddEventHandler('lrp-jewellery:client:startbreakinglass', function()
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        inRange = false

        if QBCore ~= nil and isLoggedIn then
            for case,_ in pairs(Config.Locations) do
                local dist = #(pos - vector3(Config.Locations[case]["coords"]["x"], Config.Locations[case]["coords"]["y"], Config.Locations[case]["coords"]["z"]))
                local storeDist = #(pos - vector3(Config.JewelleryLocation["coords"]["x"], Config.JewelleryLocation["coords"]["y"], Config.JewelleryLocation["coords"]["z"]))
                if dist < 30 then
                    inRange = true
                    if dist < 0.6 then
                        if not Config.Locations[case]["isBusy"] and not Config.Locations[case]["isOpened"] then
                                QBCore.Functions.TriggerCallback('lrp-jewellery:server:getCops', function(cops)
                                    if cops >= Config.RequiredCops then
                                        if validWeapon() then
                                            smashVitrine(case)
                                        else
                                            QBCore.Functions.Notify('Your weapon doesnt seem strong enough..', 'error')
                                        end
                                    else
                                        QBCore.Functions.Notify('The city is to quiet come back later', 'error')
                                    end                
                                end)
                            
                        end
                    end
                end
            end
        end

        if not inRange then
            Citizen.Wait(2000)
        end

        Citizen.Wait(3)
end)

RegisterNetEvent('lrp-jewellery:client:startheist')
AddEventHandler('lrp-jewellery:client:startheist', function()
        Citizen.Wait(100)
            local pos = GetEntityCoords(PlayerPedId())
            local dist = #(pos - vector3(-596.2597, -283.8713, 50.323726))
            if dist < 3 then
                DrawMarker(2, -596.2597, -283.8713, 50.323726 -0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                if dist < 1 then
                        QBCore.Functions.TriggerCallback('lrp-jewellery:server:getCops', function(cops)
                            if cops >= Config.RequiredCops then
                            QBCore.Functions.TriggerCallback('lrp-jewellery:server:HasHack', function(HasItem)
                                if HasItem then
                                    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
                                    QBCore.Functions.Progressbar("anim@heists@ornate_bank@hack", "Hacking security...", 15000, false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = true,
                                        disableCombat = true,
                                    }, {}, {}, {}, function() -- Done
                                        exports["lrp-memorygame"]:thermiteminigame(10, 3, 3, 10,
                                        function() -- success
                                            local success = true
                                            HackingSuccess(success)
                                            --print("Maybe your not so bad")
                                        end,
                                        function() -- failure
                                            local success = false
                                            HackingSuccess(success)
                                            --print("you're a failure :(")
                                        end)
                                        ClearPedTasks(PlayerPedId())
                                    end, function() -- CANCEL
                                        ClearPedTasks(PlayerPedId())
                                    end)
                                else
                                    QBCore.Functions.Notify('You don\'t have the right items', 'error')
                                end
                            end)
                            else
                                QBCore.Functions.Notify('There are not enough cops...', 'error')
                            end    
                        end)
                end
            else
                Citizen.Wait(2000)
            end
end)

RegisterNetEvent('lrp-jewellery:client:UsePinkCard')
AddEventHandler('lrp-jewellery:client:UsePinkCard', function()
    local pos = GetEntityCoords(PlayerPedId())
    local dist = #(pos - vector3(-619.557, -224.2047, 38.056964))
    if dist < 1.00 then
        TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
        QBCore.Functions.Progressbar("anim@heists@ornate_bank@hack", "Overriding Security System", 7500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            ExchangeSuccess2()
            ClearPedTasks(PlayerPedId())
            QBCore.Functions.Notify('Doors system disabled.', 'success')
        end)
    end
end)

function HackingSuccess(success)
    if success then
        ExchangeSuccess()
    else
		--TriggerEvent('mhacking:hide')
		ExchangeFail()
        --print("sus")
        -- add suspicious activity notify
	end
end

function ExchangeSuccess()
    -- remove items
    QBCore.Functions.TriggerCallback('lrp-jewellery:server:ExchangeSuccess', function(result)
    end)

    -- trigger alarm
    TriggerEvent('ps-dispatch:client:vangelicoRobbery')
    TriggerServerEvent('lrp-jewellery:server:cooldown')

    -- open door
    local sourcething = GetPlayerServerId(PlayerId())
    TriggerServerEvent('nui_doorlock:server:updateState', 75, false, sourcething, false, true, sourcething)

    -- close door after 1.5 minutes
    Citizen.Wait(60000)
    QBCore.Functions.Notify('Cops are on the way! Doors are now locked.', 'error')
    TriggerServerEvent('nui_doorlock:server:updateState', 75, true, sourcething, false, true, sourcething)
end

function ExchangeSuccess2()
    -- remove items
    QBCore.Functions.TriggerCallback('lrp-jewellery:server:ExchangeSuccess2', function(result)
    end)
    -- open ndoor
    local sourcething = GetPlayerServerId(PlayerId())
    TriggerServerEvent('nui_doorlock:server:updateState', 75, false, sourcething, false, true, sourcething)
end

function ExchangeFail()
    -- remove items
	QBCore.Functions.TriggerCallback('lrp-jewellery:server:ExchangeFail', function(result)
	end)
    -- call police
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    TriggerEvent('ps-dispatch:client:suspiciousActivity')
    --QBCore.Functions.TriggerCallback('lrp-jewellery:server:PoliceHackMessage', function(result)
    --end, "Security system hack attempt", pos, true)
end

function loadParticle()
	if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
    RequestNamedPtfxAsset("scr_jewelheist")
    end
    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
    Citizen.Wait(0)
    end
    SetPtfxAssetNextCall("scr_jewelheist")
end

function loadAnimDict(dict)  
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(3)
    end
end

function validWeapon()
    local ped = PlayerPedId()
    local pedWeapon = GetSelectedPedWeapon(ped)

    for k, v in pairs(Config.WhitelistedWeapons) do
        if pedWeapon == k then
            return true
        end
    end
    return false
end

local smashing = false

function smashVitrine(k)
    local animDict = "missheist_jewel"
    local animName = "smash_case"
    local ped = PlayerPedId()
    local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0, 0.6, 0)
    local pedWeapon = GetSelectedPedWeapon(ped)

    if math.random(1, 100) <= 80 and not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", plyCoords)
    elseif math.random(1, 100) <= 5 and IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", plyCoords)
        QBCore.Functions.Notify("You broke the glass..", "error")
    end

    smashing = true

    QBCore.Functions.Progressbar("smash_vitrine", "Smashing jewellery case..", Config.WhitelistedWeapons[pedWeapon]["timeOut"], false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        QBCore.Functions.TriggerCallback('lrp-jewellery:server:setVitrineState', function(result)
        end, "isOpened", true, k)
        QBCore.Functions.TriggerCallback('lrp-jewellery:server:setVitrineState', function(result)
        end, "isBusy", false, k)
        QBCore.Functions.TriggerCallback('lrp-jewellery:vitrineReward', function()
        end)
        QBCore.Functions.TriggerCallback('lrp-jewellery:server:setTimeout', function(result)
        end)
        smashing = false
        TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
    end, function() -- Cancel
        QBCore.Functions.TriggerCallback('lrp-jewellery:server:setVitrineState', function(result)
        end, "isBusy", false, k)
        TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
        smashing = false
    end)
    QBCore.Functions.TriggerCallback('lrp-jewellery:server:setVitrineState', function(result)
    end, "isBusy", true, k)

    Citizen.CreateThread(function()
        while smashing do
            loadAnimDict(animDict)
            TaskPlayAnim(ped, animDict, animName, 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
            Citizen.Wait(500)
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "breaking_vitrine_glass", 0.25)
            loadParticle()
            StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", plyCoords.x, plyCoords.y, plyCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
            Citizen.Wait(2500)
        end
    end)
end

RegisterNetEvent('lrp-jewellery:client:setVitrineState')
AddEventHandler('lrp-jewellery:client:setVitrineState', function(stateType, state, k)
    Config.Locations[k][stateType] = state
end)

RegisterNetEvent('lrp-jewellery:client:setAlertState')
AddEventHandler('lrp-jewellery:client:setAlertState', function(bool)
    robberyAlert = bool
end)

RegisterNetEvent('lrp-jewellery:client:executeEvents')
AddEventHandler('lrp-jewellery:client:executeEvents', function()
    TriggerServerEvent('lrp-jewellery:server:vitrineReward')
end)

--[[
RegisterNetEvent('lrp-jewellery:client:PoliceAlertMessage')
AddEventHandler('lrp-jewellery:client:PoliceAlertMessage', function(title, coords, blip)
    if blip then
        TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
            timeOut = 10000,
            alertTitle = title,
            details = {
                [1] = {
                    icon = '<i class="fas fa-gem"></i>',
                    detail = "Vangelico Juwelier",
                },
                [2] = {
                    icon = '<i class="fas fa-video"></i>',
                    detail = "31 | 32 | 33 | 34",
                },
                [3] = {
                    icon = '<i class="fas fa-globe-europe"></i>',
                    detail = "Rockford Dr",
                },
            },
            callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
        })
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        Citizen.Wait(100)
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        Citizen.Wait(100)
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        local transG = 250
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 617)
        SetBlipColour(blip, 4)
        SetBlipDisplay(blip, 4)
        SetBlipAlpha(blip, transG)
        SetBlipScale(blip, 1.9)
        SetBlipFlashes(blip, true)
        SetBlipAsShortRange(blip, false)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("911: Jewellery Store")
        EndTextCommandSetBlipName(blip)
        while transG ~= 0 do
            Wait(180 * 4)
            transG = transG - 1
            SetBlipAlpha(blip, transG)
            if transG == 0 then
                SetBlipSprite(blip, 2)
                RemoveBlip(blip)
                return
            end
        end
    else
        if not robberyAlert then
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
                timeOut = 10000,
                alertTitle = title,
                details = {
                    [1] = {
                        icon = '<i class="fas fa-gem"></i>',
                        detail = "Vangelico Jewellery",
                    },
                    [2] = {
                        icon = '<i class="fas fa-video"></i>',
                        detail = "31 | 32 | 33 | 34",
                    },
                    [3] = {
                        icon = '<i class="fas fa-globe-europe"></i>',
                        detail = "Rockford Dr",
                    },
                },
                callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
            })
            robberyAlert = true
        end
    end
end)
]]--

function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == GetHashKey("mp_m_freemode_01") then
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

Citizen.CreateThread(function()
    Dealer = AddBlipForCoord(Config.JewelleryLocation["coords"]["x"], Config.JewelleryLocation["coords"]["y"], Config.JewelleryLocation["coords"]["z"])

    SetBlipSprite (Dealer, 617)
    SetBlipDisplay(Dealer, 4)
    SetBlipScale  (Dealer, 0.7)
    SetBlipAsShortRange(Dealer, true)
    SetBlipColour(Dealer, 3)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Vangelico Jeweller")
    EndTextCommandSetBlipName(Dealer)
end)
