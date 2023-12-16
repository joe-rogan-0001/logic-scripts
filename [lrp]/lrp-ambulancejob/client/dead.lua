local deadAnimDict = "missarmenian2"
local deadAnim = "drunk_loop"
local hold = 5
deathTime = 0

-- Functions

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

RegisterNetEvent('hospital:client:bleedout')
AddEventHandler('hospital:client:bleedout', function()
    OnDeath()
    DeathTimer()  
end)


function OnDeath()
    if not isDead then
        isDead = true
        isdeadpersondead = true
        Wait(1500)
        TriggerServerEvent("hospital:server:SetDeathStatus", true)
        local player = PlayerPedId()
        local speed = 1.1

        while speed > 1 do
            player = PlayerPedId()
            speed = GetEntitySpeed(player)
            Wait(500)
        end

        if isDead then
            local pos = GetEntityCoords(player)
            local heading = GetEntityHeading(player)
            
            --SetEntityHealth(player, GetEntityMaxHealth(player))
            --SetEntityInvincible(PlayerPedId(), true)

            if IsPedInAnyVehicle(player, false) then
                loadAnimDict("veh@low@front_ps@idle_duck")
                TaskPlayAnim(player, "veh@low@front_ps@idle_duck", "sit", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                SetEntityInvincible(PlayerPedId(), true)
            else
                NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z + 0.5, heading, true, false)
                loadAnimDict(deadAnimDict)
                TaskPlayAnim(player, deadAnimDict, deadAnim, 8.0, -8, -1, 1, 0, 0, 0, 0)
                SetEntityInvincible(PlayerPedId(), true)
            end
        end
    end
end





function DeathTimer()
    hold = 5
    while isDead do
        Wait(1000)
        deathTime = deathTime - 1
        if deathTime <= 0 then
            if IsControlPressed(0, 38) and hold <= 0 and not isInHospitalBed then
                QBCore.Functions.GetPlayerData(function(PlayerData)
                    if PlayerData.metadata.injail ~= 0 then
                        TriggerEvent("qb-jail:client:PrisonRevive")
                    else
                        TriggerEvent("hospital:client:RespawnAtHospital")
                    end
                end)
                hold = 5
            end
            if IsControlPressed(0, 38) then
                if hold - 1 >= 0 then
                    hold = hold - 1
                else
                    hold = 0
                end
            end
            if IsControlReleased(0, 38) then
                hold = 5
            end
        end
    end
end


local function DrawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/1 + 0.350)
end




CreateThread(function()
	while true do
		Wait(10)
		local player = PlayerId()
            local playerPed = PlayerPedId()

            if IsPedInAnyVehicle(playerPed, false) then
                if IsEntityDead(playerPed) then
                    local killer_2, killerWeapon = NetworkGetEntityKillerOfPlayer(player)
                    local killer = GetPedSourceOfDeath(playerPed)
            
                    if killer_2 ~= 0 and killer_2 ~= -1 then
                        killer = killer_2
                    end
            
                    local killerId = NetworkGetPlayerIndexFromPed(killer)
                    local killerName = killerId ~= -1 and GetPlayerName(killerId) .. " " .. "("..GetPlayerServerId(killerId)..")" or "Himself or a NPC"
                    local weaponLabel = "Unknown"
                    local weaponName = "Unknown_Weapon"
                    local weaponItem = QBCore.Shared.Weapons[killerWeapon]
                    if weaponItem then
                        weaponLabel = weaponItem.label
                        weaponName = weaponItem.name
                    end
                    TriggerServerEvent("qb-log:server:CreateLog", "death", GetPlayerName(-1) .. " ("..GetPlayerServerId(player)..") is dead", "red", "**".. killerName .. "** has killed ".. GetPlayerName(player) .." with a **".. weaponLabel .. "** (" .. weaponName .. ")")
                    deathTime = Config.DeathTime
                    OnDeath()
                    DeathTimer()
                end
            else
                if IsEntityDead(playerPed) then  
                    local killer_2, killerWeapon = NetworkGetEntityKillerOfPlayer(player)
                    local killer = GetPedSourceOfDeath(playerPed)
            
                    if killer_2 ~= 0 and killer_2 ~= -1 then
                        killer = killer_2
                    end
            
                    local killerId = NetworkGetPlayerIndexFromPed(killer)
                    local killerName = killerId ~= -1 and GetPlayerName(killerId) .. " " .. "("..GetPlayerServerId(killerId)..")" or "Himself or a NPC"
                    local weaponLabel = "Unknown"
                    local weaponName = "Unknown_Weapon"
                    local weaponItem = QBCore.Shared.Weapons[killerWeapon]
                    if weaponItem then
                        weaponLabel = weaponItem.label
                        weaponName = weaponItem.name
                    end
                    TriggerServerEvent("qb-log:server:CreateLog", "death", GetPlayerName(-1) .. " ("..GetPlayerServerId(player)..") is dead", "red", "**".. killerName .. "** has killed ".. GetPlayerName(player) .." with a **".. weaponLabel .. "** (" .. weaponName .. ")")
                    deathTime = Config.DeathTime
                    OnDeath()
                    DeathTimer()
                end
            end

	end
end)

CreateThread(function()
	while true do
        sleep = 1000
		if isDead or InLaststand then
            sleep = 0
            local ped = PlayerPedId()
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
			EnableControlAction(0, 2, true)
			EnableControlAction(0, 245, true)
            EnableControlAction(0, 38, true)
            EnableControlAction(0, 0, true)
            EnableControlAction(0, 322, true)
            EnableControlAction(0, 288, true)
            EnableControlAction(0, 213, true)
	        EnableControlAction(0, 249, true)
            EnableControlAction(0, 46, true)

            if isDead then
                if not isInHospitalBed then
                    if deathTime > 0 then
                     --   (x, y, width, height, scale, text, r, g, b, a, outline)
                        DrawTxt(0.936, 1.42, 1.0, 0.94, 0.48, "Dead: ~r~ " .. math.ceil(deathTime) .. " ~w~ seconds remaining", 255, 255, 255, 255)
                        DrawTxt(0.936, 1.45, 1.0, 0.94, 0.38, "~w~ Press and hold [F1] to call ems/police ~w~", 255, 255, 255, 255)
                    else
                        DrawTxt(0.936, 1.42, 1.0, 0.94, 0.48, "~w~ HOLD ~r~[E] ~w~("..hold..")~w~ TO ~r~RESPAWN ~w~OR WAIT FOR EMS", 255, 255, 255, 255)
                    end
                end

                if IsPedInAnyVehicle(ped, false) then
                    loadAnimDict("veh@low@front_ps@idle_duck")
                    if not IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
                        TaskPlayAnim(ped, "veh@low@front_ps@idle_duck", "sit", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                    end
                else
                    if isInHospitalBed then
                        if not IsEntityPlayingAnim(ped, inBedDict, inBedAnim, 3) then
                            loadAnimDict(inBedDict)
                            TaskPlayAnim(ped, inBedDict, inBedAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    else
                        if not IsEntityPlayingAnim(ped, deadAnimDict, deadAnim, 3) then
                            loadAnimDict(deadAnimDict)
                            TaskPlayAnim(ped, deadAnimDict, deadAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    end
                end

                SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
            elseif InLaststand then
                sleep = 0
                DisableAllControlActions(0)
                EnableControlAction(0, 1, true)
                EnableControlAction(0, 2, true)
                EnableControlAction(0, 245, true)
                EnableControlAction(0, 38, true)
                EnableControlAction(0, 0, true)
                EnableControlAction(0, 322, true)
                EnableControlAction(0, 288, true)
                EnableControlAction(0, 213, true)
		        EnableControlAction(0, 249, true)
                EnableControlAction(0, 46, true)

                if InLaststand then
                    DrawTxt(0.91, 1.44, 1.0, 1.0, 0.6, "YOU WILL BLEED OUT IN: ~r~" .. math.ceil(LaststandTime) .. "~w~ SECONDS", 255, 255, 255, 255)
                end

                if not isEscorted then
                    if IsPedInAnyVehicle(ped, false) then
                        loadAnimDict("veh@low@front_ps@idle_duck")
                        if not IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
                            TaskPlayAnim(ped, "veh@low@front_ps@idle_duck", "sit", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    else
                        loadAnimDict(lastStandDict)
                        if not IsEntityPlayingAnim(ped, lastStandDict, lastStandAnim, 3) then
                            TaskPlayAnim(ped, lastStandDict, lastStandAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    end
                else
                    if IsPedInAnyVehicle(ped, false) then
                        loadAnimDict("veh@low@front_ps@idle_duck")
                        if IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
                            StopAnimTask(ped, "veh@low@front_ps@idle_duck", "sit", 3)
                        end
                    else
                        loadAnimDict(lastStandDict)
                        if IsEntityPlayingAnim(ped, lastStandDict, lastStandAnim, 3) then
                            StopAnimTask(ped, lastStandDict, lastStandAnim, 3)
                        end
                    end
                end
            end
		end
        Wait(sleep)
	end
end)