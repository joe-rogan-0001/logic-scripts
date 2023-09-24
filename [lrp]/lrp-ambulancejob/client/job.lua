local statusCheckPed = nil
local PlayerJob = {}
local onDuty = false
local currentGarage = 1

-- elevator


local function MenuElevator()
    exports['lrp-menu']:openMenu({
        {
            header = "Elevator",
            isMenuHeader = true
        },
        {
            header = "Third Floor",
            txt = "Pillbox Third Floor",
            params = {
                event = "qb-ambulancejob:job:thirdfloor"
            }
        },
        {
            header = "Second Floor",
            txt = "Pillbox Second Floor",
            params = {
                event = "qb-ambulancejob:job:secondfloor"
            }
        },
        {
            header = "Ground Floor",
            txt = "Pillbox Ground Floor",
            params = {
                event = "qb-ambulancejob:job:groundfloor"
            }
        },
    })
end

RegisterNetEvent('qb-ambulancejob:job:openmenu')
AddEventHandler('qb-ambulancejob:job:openmenu', function(PlayerData)
    QBCore.Functions.Progressbar("elevetor", "Waiting for Elevator", 10000, false, true, {}, {}, {}, {}, function() 
        MenuElevator()  
    end)
end)



RegisterNetEvent('qb-ambulancejob:job:groundfloor')
AddEventHandler('qb-ambulancejob:job:groundfloor', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Wait(10)
        end


        SetEntityCoords(ped, 344.25, -586.28, 28.8, 0, 0, 0, false)
        SetEntityHeading(ped, 247.77)

        Wait(100)

        DoScreenFadeIn(1000)
end)

RegisterNetEvent('qb-ambulancejob:job:secondfloor')
AddEventHandler('qb-ambulancejob:job:secondfloor', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Wait(10)
        end

        
        SetEntityCoords(ped, 330.32, -601.02, 43.28, 0, 0, 0, false)
        SetEntityHeading(ped, 63.97)

        Wait(100)

        DoScreenFadeIn(1000)
end)

RegisterNetEvent('qb-ambulancejob:job:thirdfloor')
AddEventHandler('qb-ambulancejob:job:thirdfloor', function()
   if PlayerJob.name =="ambulance" and onDuty then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Wait(10)
        end

        
        SetEntityCoords(ped, 338.5, -583.85, 74.16, 0, 0, 0, false)
        SetEntityHeading(ped, 245.5)

        Wait(100)

        DoScreenFadeIn(1000)
    else 
        QBCore.Functions.Notify('You dont have access to the elevators!', 'error')
    end
end)





RegisterNetEvent('qb-ambulancejob:job:spawnheli')
AddEventHandler('qb-ambulancejob:job:spawnheli', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    for k, v in pairs(Config.Locations["helicopter"]) do
    local dist = #(pos - vector3(v.x, v.y, v.z))
    if dist < 7.5 then
        if onDuty then
            sleep = 7   
                local coords = Config.Locations["helicopter"][k]
                QBCore.Functions.SpawnVehicle(Config.Helicopter, function(veh)
                    SetVehicleNumberPlateText(veh, "LIFE"..tostring(math.random(1000, 9999)))
                    SetEntityHeading(veh, coords.w)
                    SetVehicleLivery(veh, 1) -- Ambulance Livery
                    exports['lj-fuel']:SetFuel(veh, 100.0)
                    closeMenuFull()
                    TaskWarpPedIntoVehicle(ped, veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
        elseif not onDuty then
            QBCore.Functions.Notify('Maybe try going on duty dumbass!!', 'error')
        end
    end
  end
end)


RegisterNetEvent('qb-ambulancejob:job:deleteheli')
AddEventHandler('qb-ambulancejob:job:deleteheli', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local vehicleclose = QBCore.Functions.GetClosestVehicle(pos)
    QBCore.Functions.DeleteVehicle(vehicleclose)
end)

-- Functions


local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end
	return closestPlayer, closestDistance
end

local function DrawText3D(x, y, z, text)
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

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["vehicle"][currentGarage]
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "AMBU"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        exports['lj-fuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end

function MenuGarage()
    local vehicleMenu = {
        {
            header = "Ambulance Vehicles",
            isMenuHeader = true
        }
    }

    local authorizedVehicles = Config.AuthorizedVehicles[QBCore.Functions.GetPlayerData().job.grade.level]
    for veh, label in pairs(authorizedVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = label,
            txt = "",
            params = {
                event = "ambulance:client:TakeOutVehicle",
                args = {
                    vehicle = veh
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = "⬅ Close Menu",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['lrp-menu']:openMenu(vehicleMenu)
end

-- Events

RegisterNetEvent('ambulance:client:TakeOutVehicle', function(data)
    local vehicle = data.vehicle
    TakeOutVehicle(vehicle)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    TriggerServerEvent("hospital:server:SetDoctor")
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    exports.spawnmanager:setAutoSpawn(false)
    local ped = PlayerPedId()
    local player = PlayerId()
    TriggerServerEvent("hospital:server:SetDoctor")
    CreateThread(function()
        Wait(5000)
        SetEntityMaxHealth(ped, 200)
        SetEntityHealth(ped, 200)
        SetPlayerHealthRechargeMultiplier(player, 0.0)
        SetPlayerHealthRechargeLimit(player, 0.0)
    end)
    CreateThread(function()
        Wait(1000)
        QBCore.Functions.GetPlayerData(function(PlayerData)
            PlayerJob = PlayerData.job
            onDuty = PlayerData.job.onduty
            SetPedArmour(ped, PlayerData.metadata["armor"])
            if (not PlayerData.metadata["inlaststand"] and PlayerData.metadata["isdead"]) then
                deathTime = Laststand.ReviveInterval
                OnDeath()
                DeathTimer()
            elseif (PlayerData.metadata["inlaststand"] and not PlayerData.metadata["isdead"]) then
                SetLaststand(true, true)
            else
                TriggerServerEvent("hospital:server:SetDeathStatus", false)
                TriggerServerEvent("hospital:server:SetLaststandStatus", false)
            end
        end)
    end)
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
    TriggerServerEvent("hospital:server:SetDoctor")
end)


RegisterNetEvent('qb-ambulancejob:Client:SetDuty', function()
    onDuty = not onDuty
    TriggerServerEvent("hospital:server:SetDoctor")
    TriggerServerEvent("QBCore:ToggleDuty")
    TriggerServerEvent("police:server:UpdateBlips")
end)





RegisterNetEvent('hospital:client:CheckStatus', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 5.0 then
        local playerId = GetPlayerServerId(player)
        statusCheckPed = GetPlayerPed(player)
        QBCore.Functions.TriggerCallback('hospital:GetPlayerStatus', function(result)
            if result then
                for k, v in pairs(result) do
                    if k ~= "BLEED" and k ~= "WEAPONWOUNDS" then
                        statusChecks[#statusChecks+1] = {bone = Config.BoneIndexes[k], label = v.label .." (".. Config.WoundStates[v.severity] ..")"}
                    elseif result["WEAPONWOUNDS"] then
                        for k, v in pairs(result["WEAPONWOUNDS"]) do
                            --[[
                            TriggerEvent('chat:addMessage', {
                                color = { 255, 0, 0},
                                multiline = false,
                                args = {"Status Check", WeaponDamageList[v]}
                            })
                            ]]--
                            TriggerEvent("chatMessage", "Status", 4, WeaponDamageList[v])
                        end
                    elseif result["BLEED"] > 0 then
                        --[[
                        TriggerEvent('chat:addMessage', {
                            color = { 255, 0, 0},
                            multiline = false,
                            args = {"Status Check", "Is "..Config.BleedingStates[v].label}
                        })
                        ]]--
                        TriggerEvent("chatMessage", "Status", 4, Config.BleedingStates[v].label)
                    else
                        QBCore.Functions.Notify('Player Is Healthy', 'success')
                    end
                end
                isStatusChecking = true
                statusCheckTime = Config.CheckTime
            end
        end, playerId)
    else
        QBCore.Functions.Notify('No Player Nearby', 'error')
    end
end)

RegisterNetEvent('hospital:client:RevivePlayer', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
        if hasItem then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                isHealingPerson = true
                QBCore.Functions.Progressbar("hospital_revive", "Reviving person..", 5000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = healAnimDict,
                    anim = healAnim,
                    flags = 16,
                }, {}, {}, function() -- Done
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    QBCore.Functions.Notify("You revived the person!")
                    TriggerServerEvent("hospital:server:RevivePlayer", playerId)
                end, function() -- Cancel
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    QBCore.Functions.Notify("Failed!", "error")
                end)
            else
                QBCore.Functions.Notify("No Player Nearby", "error")
            end
        else
            QBCore.Functions.Notify("You Need A First Aid Kit", "error")
        end
    end, 'firstaid')
end)

RegisterNetEvent('hospital:client:TreatWounds', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
        if hasItem then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                isHealingPerson = true
                QBCore.Functions.Progressbar("hospital_healwounds", "Healing wounds..", 5000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = healAnimDict,
                    anim = healAnim,
                    flags = 16,
                }, {}, {}, function() -- Done
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    QBCore.Functions.Notify("You helped the person!")
                    TriggerServerEvent("hospital:server:TreatWounds", playerId)
                end, function() -- Cancel
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    QBCore.Functions.Notify("Failed!", "error")
                end)
            else
                QBCore.Functions.Notify("No Player Nearby", "error")
            end
        else
            QBCore.Functions.Notify("You Need A Bandage", "error")
        end
    end, 'bandage')
end)

-- Threads

CreateThread(function()
    while true do
        Wait(10)
        if isStatusChecking then
            for k, v in pairs(statusChecks) do
                local x,y,z = table.unpack(GetPedBoneCoords(statusCheckPed, v.bone))
                DrawText3D(x, y, z, v.label)
            end
        end
        if isHealingPerson then
            local ped = PlayerPedId()
            if not IsEntityPlayingAnim(ped, healAnimDict, healAnim, 3) then
                loadAnimDict(healAnimDict)
                TaskPlayAnim(ped, healAnimDict, healAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
            end
        end
    end
end)




RegisterNetEvent('ambulance:client:stash', function(data)
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "hospital", Config.Items)
end)

exports['lrp-target']:AddBoxZone("pillboxonoffduty", vector3(306.7134, -601.9030, 43.2841), 1.0, 4.0, {
    name = "pillboxonoffduty",
    heading = 160.3563,
    debugPoly = false,
    minZ = 43.28,
    maxZ = 44.59,
    }, 
    { 
    options = {
        {
            type = "client",
            event = "ambulance:client:stash",
            icon = "fas fa-notes-medical",
            label = "open armory",
            job = "ambulance",
        },
    },
    distance = 1.5
})
