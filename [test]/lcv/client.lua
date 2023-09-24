--[[
---------------------------------------------------
LUXART VEHICLE CONTROL ELS CLICKS (FOR FIVEM)
---------------------------------------------------
Last revision: MAY 01 2017 (VERS. 1.01)
Coded by Lt.Caine
ELS Clicks by Faction
Additonal Modification by TrevorBarns
---------------------------------------------------
NOTES
	LVC will automatically apply to all emergency vehicles (vehicle class 18)
---------------------------------------------------
CONTROLS	
	Right indicator:	=	(Next Custom Radio Track)
	Left indicator:		-	(Previous Custom Radio Track)
	Hazard lights:	Backspace	(Phone Cancel)
	Toggle emergency lights:	Y	(Text Chat Team)
	Airhorn:	E	(Horn)
	Toggle siren:	,	(Previous Radio Station)
	Manual siren / Change siren tone:	N	(Next Radio Station)
	Auxiliary siren:	Down Arrow	(Phone Up)
---------------------------------------------------
]]

--------------------------------------------------
--Runtime Variables (Do not touch unless you know what you're doing.) 
  local count_bcast_timer = 0
  local delay_bcast_timer = 200
  
  local count_sndclean_timer = 0
  local delay_sndclean_timer = 400
  
  local actv_lxsrnmute_temp = false
  local srntone_temp = 0
  local dsrn_mute = true
  
  local state_lxsiren = {}
  local state_pwrcall = {}
  local state_airmanu = {}
  
  local snd_lxsiren = {}
  local snd_pwrcall = {}
  local snd_airmanu = {}
  
  local eModelsWithFireSrn = {
      "FIRETRUK",
  }
  
  local eModelsWithPcall = {	
	"AMBULANCE",
	"FIRETRUK",
	"LGUARD",
  }
---------------------------------------------------------------------

---------------------------------------------------------------------
useFiretruckSiren = function(veh)
	local model = GetEntityModel(veh)
	for i = 1, #eModelsWithFireSrn, 1 do
		if model == GetHashKey(eModelsWithFireSrn[i]) then
			return true
		end
	end
	return false
end

usePowercallAuxSrn = function(veh)
	local model = GetEntityModel(veh)
	for i = 1, #eModelsWithPcall, 1 do
		if model == GetHashKey(eModelsWithPcall[i]) then
			return true
		end
	end
	return false
end

CleanupSounds = function()
	if count_sndclean_timer > delay_sndclean_timer then
		count_sndclean_timer = 0
		for k, v in pairs(state_lxsiren) do
			if v > 0 then
				if not DoesEntityExist(k) or IsEntityDead(k) then
					if snd_lxsiren[k] ~= nil then
						StopSound(snd_lxsiren[k])
						ReleaseSoundId(snd_lxsiren[k])
						snd_lxsiren[k] = nil
						state_lxsiren[k] = nil
					end
				end
			end
		end

		for k, v in pairs(state_pwrcall) do
			if v == true then
				if not DoesEntityExist(k) or IsEntityDead(k) then
					if snd_pwrcall[k] ~= nil then
						StopSound(snd_pwrcall[k])
						ReleaseSoundId(snd_pwrcall[k])
						snd_pwrcall[k] = nil
						state_pwrcall[k] = nil
					end
				end
			end
		end

		for k, v in pairs(state_airmanu) do
			if v == true then
				if not DoesEntityExist(k) or IsEntityDead(k) or IsVehicleSeatFree(k, -1) then
					if snd_airmanu[k] ~= nil then
						StopSound(snd_airmanu[k])
						ReleaseSoundId(snd_airmanu[k])
						snd_airmanu[k] = nil
						state_airmanu[k] = nil
					end
				end
			end
		end
	else
		count_sndclean_timer = count_sndclean_timer + 1
	end
end

TogMuteDfltSrnForVeh = function(veh, toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		DisableVehicleImpactExplosionActivation(veh, toggle)
	end
end

SetLxSirenStateForVeh = function(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_lxsiren[veh] then


			if snd_lxsiren[veh] ~= nil then
				StopSound(snd_lxsiren[veh])
				ReleaseSoundId(snd_lxsiren[veh])
				snd_lxsiren[veh] = nil
			end

			if newstate == 1 then
				if useFiretruckSiren(veh) then
					TogMuteDfltSrnForVeh(veh, false)
				else
					snd_lxsiren[veh] = GetSoundId()	
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
					TogMuteDfltSrnForVeh(veh, true)
				end

			elseif newstate == 2 then
				snd_lxsiren[veh] = GetSoundId()
				PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_SIREN_2", veh, 0, 0, 0)
				TogMuteDfltSrnForVeh(veh, true)

			elseif newstate == 3 then
				snd_lxsiren[veh] = GetSoundId()
				if useFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_AMBULANCE_WARNING", veh, 0, 0, 0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_POLICE_WARNING", veh, 0, 0, 0)
				end
				TogMuteDfltSrnForVeh(veh, true)
				
			else
				TogMuteDfltSrnForVeh(veh, true)
				
			end				
				
			state_lxsiren[veh] = newstate
		end
	end
end

TogPowercallStateForVeh = function(veh, toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if toggle == true then
			if snd_pwrcall[veh] == nil then
				snd_pwrcall[veh] = GetSoundId()
				if usePowercallAuxSrn(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "VEHICLES_HORNS_AMBULANCE_WARNING", veh, 0, 0, 0)
				else
					PlaySoundFromEntity(snd_pwrcall[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
				end
			end

		else
			if snd_pwrcall[veh] ~= nil then
				StopSound(snd_pwrcall[veh])
				ReleaseSoundId(snd_pwrcall[veh])
				snd_pwrcall[veh] = nil
			end
		end
		state_pwrcall[veh] = toggle
	end
end

SetAirManuStateForVeh = function(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_airmanu[veh] then
				
			if snd_airmanu[veh] ~= nil then
				StopSound(snd_airmanu[veh])
				ReleaseSoundId(snd_airmanu[veh])
				snd_airmanu[veh] = nil
			end

			if newstate == 1 then
				snd_airmanu[veh] = GetSoundId()
				if useFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_FIRETRUCK_WARNING", veh, 0, 0, 0)
				else
					PlaySoundFromEntity(snd_airmanu[veh], "SIRENS_AIRHORN", veh, 0, 0, 0)
				end

			elseif newstate == 2 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
			
			elseif newstate == 3 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_SIREN_2", veh, 0, 0, 0)
			end				

			state_airmanu[veh] = newstate
		end
	end
end

SetAirManuStateForVehClick = function(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_airmanu[veh] then
				
			if snd_airmanu[veh] ~= nil then
				StopSound(snd_airmanu[veh])
				ReleaseSoundId(snd_airmanu[veh])
				snd_airmanu[veh] = nil
			end

			if newstate == 1 then
				snd_airmanu[veh] = GetSoundId()
				if useFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_FIRETRUCK_WARNING", veh, 0, 0, 0)
				else
					PlaySoundFromEntity(snd_airmanu[veh], "SIRENS_AIRHORN", veh, 0, 0, 0)
				end

			elseif newstate == 2 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
			
			elseif newstate == 3 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_SIREN_2", veh, 0, 0, 0)
			end				

			state_airmanu[veh] = newstate
		end
	end
end


---------------------------------------------------------------------
function TogPowercallStateForVeh(veh, toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if toggle == true then
			if snd_pwrcall[veh] == nil then
				snd_pwrcall[veh] = GetSoundId()
				if usePowercallAuxSrn(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "VEHICLES_HORNS_AMBULANCE_WARNING", veh, 0, 0, 0)
				else
					PlaySoundFromEntity(snd_pwrcall[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
				end
			end
		else
			if snd_pwrcall[veh] ~= nil then
				StopSound(snd_pwrcall[veh])
				ReleaseSoundId(snd_pwrcall[veh])
				snd_pwrcall[veh] = nil
			end
		end
		state_pwrcall[veh] = toggle
	end
end

---------------------------------------------------------------------
function SetAirManuStateForVeh(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_airmanu[veh] then
				
			if snd_airmanu[veh] ~= nil then
				StopSound(snd_airmanu[veh])
				ReleaseSoundId(snd_airmanu[veh])
				snd_airmanu[veh] = nil
			end
						
			if newstate == 1 then
				snd_airmanu[veh] = GetSoundId()
				if useFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_FIRETRUCK_WARNING", veh, 0, 0, 0)
				else
					PlaySoundFromEntity(snd_airmanu[veh], "SIRENS_AIRHORN", veh, 0, 0, 0)
				end
				
			elseif newstate == 2 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
			
			elseif newstate == 3 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_SIREN_2", veh, 0, 0, 0)
				
			end				
				
			state_airmanu[veh] = newstate
		end
	end
end


---------------------------------------------------------------------

  RegisterNetEvent("lvc_TogDfltSrnMuted_c")
  AddEventHandler("lvc_TogDfltSrnMuted_c", function(sender, toggle)
      local player_s = GetPlayerFromServerId(sender)
      local ped_s = GetPlayerPed(player_s)
      if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
          if ped_s ~= GetPlayerPed(-1) then
              if IsPedInAnyVehicle(ped_s, false) then
                  local veh = GetVehiclePedIsUsing(ped_s)
                  TogMuteDfltSrnForVeh(veh, toggle)
              end
          end
      end
  end)
  
  RegisterNetEvent("lvc_SetLxSirenState_c")
  AddEventHandler("lvc_SetLxSirenState_c", function(sender, newstate)
      local player_s = GetPlayerFromServerId(sender)
      local ped_s = GetPlayerPed(player_s)
      if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
          if ped_s ~= GetPlayerPed(-1) then
              if IsPedInAnyVehicle(ped_s, false) then
                  local veh = GetVehiclePedIsUsing(ped_s)
                  SetLxSirenStateForVeh(veh, newstate)
              end
          end
      end
  end)
  
  RegisterNetEvent("lvc_TogPwrcallState_c")
  AddEventHandler("lvc_TogPwrcallState_c", function(sender, toggle)
      local player_s = GetPlayerFromServerId(sender)
      local ped_s = GetPlayerPed(player_s)
      if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
          if ped_s ~= GetPlayerPed(-1) then
              if IsPedInAnyVehicle(ped_s, false) then
                  local veh = GetVehiclePedIsUsing(ped_s)
                  TogPowercallStateForVeh(veh, toggle)
              end
          end
      end
  end)
  
  RegisterNetEvent("lvc_SetAirManuState_c")
  AddEventHandler("lvc_SetAirManuState_c", function(sender, newstate)
      local player_s = GetPlayerFromServerId(sender)
      local ped_s = GetPlayerPed(player_s)
      if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
          if ped_s ~= GetPlayerPed(-1) then
              if IsPedInAnyVehicle(ped_s, false) then
                  local veh = GetVehiclePedIsUsing(ped_s)
                  SetAirManuStateForVeh(veh, newstate)
              end
          end
      end
  end)


---------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
			local Sleep = true		
			CleanupSounds()
			----- IS IN VEHICLE -----
			local playerped = PlayerPedId()	
			if IsPedInAnyVehicle(playerped, false) then	

				----- IS DRIVER -----
				local veh = GetVehiclePedIsUsing(playerped)	
				if GetPedInVehicleSeat(veh, -1) == playerped then
					Sleep = false
					DisableControlAction(0, 84, true) -- INPUT_VEH_PREV_RADIO_TRACK  
					DisableControlAction(0, 83, true) -- INPUT_VEH_NEXT_RADIO_TRACK 

					--- IS EMERG VEHICLE ---
					if GetVehicleClass(veh) == 18 then
						
						local actv_manu = false
						local actv_horn = false
						
						DisableControlAction(0, 86, true) -- INPUT_VEH_HORN	
						DisableControlAction(0, 172, true) -- INPUT_CELLPHONE_UP 
						DisableControlAction(0, 81, true) -- INPUT_VEH_NEXT_RADIO
						DisableControlAction(0, 82, true) -- INPUT_VEH_PREV_RADIO
						DisableControlAction(0, 19, true) -- INPUT_CHARACTER_WHEEL 
						DisableControlAction(0, 85, true) -- INPUT_VEH_RADIO_WHEEL 
						DisableControlAction(0, 80, true) -- INPUT_VEH_CIN_CAM 
					
						SetVehRadioStation(veh, "OFF")
						SetVehicleRadioEnabled(veh, false)
						
						if state_lxsiren[veh] ~= 1 and state_lxsiren[veh] ~= 2 and state_lxsiren[veh] ~= 3 then
							state_lxsiren[veh] = 0
						end
						if state_pwrcall[veh] ~= true then
							state_pwrcall[veh] = false
						end
						if state_airmanu[veh] ~= 1 and state_airmanu[veh] ~= 2 and state_airmanu[veh] ~= 3 then
							state_airmanu[veh] = 0
						end
						
						if useFiretruckSiren(veh) and state_lxsiren[veh] == 1 then
							TogMuteDfltSrnForVeh(veh, false)
							dsrn_mute = false
						else
							TogMuteDfltSrnForVeh(veh, true)
							dsrn_mute = true
						end
						
						if not IsVehicleSirenOn(veh) and state_lxsiren[veh] > 0 then
							SetLxSirenStateForVeh(veh, 0)
							count_bcast_timer = delay_bcast_timer
						end
						if not IsVehicleSirenOn(veh) and state_pwrcall[veh] == true then
							TogPowercallStateForVeh(veh, false)
							count_bcast_timer = delay_bcast_timer
						end

						----- CONTROLS -----
						if not IsPauseMenuActive() then
					
							-- TOG DFLT SRN LIGHTS
							if IsDisabledControlJustReleased(0, 85) or IsDisabledControlJustReleased(0, 246) then
								if IsVehicleSirenOn(veh) then
									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
									SetVehicleSiren(veh, false)
								else
									PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
									SetVehicleSiren(veh, true)
									count_bcast_timer = delay_bcast_timer
								end		
							
							-- TOG LX SIREN
							elseif IsDisabledControlJustReleased(0, 19) or IsDisabledControlJustReleased(0, 82) then
								local cstate = state_lxsiren[veh]
								if cstate == 0 then
									if IsVehicleSirenOn(veh) then
										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) -- on
										SetLxSirenStateForVeh(veh, 1)
										count_bcast_timer = delay_bcast_timer
									end
								else
									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) -- off
									SetLxSirenStateForVeh(veh, 0)
									count_bcast_timer = delay_bcast_timer
								end
								
							-- POWERCALL
							elseif IsDisabledControlJustReleased(0, 172) then
								if state_pwrcall[veh] == true then
									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
									TogPowercallStateForVeh(veh, false)
									count_bcast_timer = delay_bcast_timer
								else
									if IsVehicleSirenOn(veh) then
										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
										TogPowercallStateForVeh(veh, true)
										count_bcast_timer = delay_bcast_timer
									end
								end
								
							end
							
							-- BROWSE LX SRN TONES
							if state_lxsiren[veh] > 0 then
								if IsDisabledControlJustReleased(0, 80) or IsDisabledControlJustReleased(0, 81) then
									if IsVehicleSirenOn(veh) then
										local cstate = state_lxsiren[veh]
										local nstate = 1
										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) -- on
										if cstate == 1 then
											nstate = 2
										elseif cstate == 2 then
											nstate = 3
										else	
											nstate = 1
										end
										SetLxSirenStateForVeh(veh, nstate)
										count_bcast_timer = delay_bcast_timer
									end
								end
							end
										
							-- MANU
							if state_lxsiren[veh] < 1 then
								if IsDisabledControlPressed(0, 80) or IsDisabledControlPressed(0, 81) then
									actv_manu = true
								else
									actv_manu = false
								end
							else
								actv_manu = false
							end
							
							-- HORN
							if IsDisabledControlPressed(0, 86) then
								actv_horn = true
							else
								actv_horn = false
							end
						
						end

						---- ADJUST HORN / MANU STATE ----
						local hmanu_state_new = 0
						if actv_horn == true and actv_manu == false then
							hmanu_state_new = 1
						elseif actv_horn == false and actv_manu == true then
							hmanu_state_new = 2
						elseif actv_horn == true and actv_manu == true then
							hmanu_state_new = 3
						end
						if hmanu_state_new == 1 then
							if not useFiretruckSiren(veh) then
								if state_lxsiren[veh] > 0 and actv_lxsrnmute_temp == false then
									srntone_temp = state_lxsiren[veh]
									SetLxSirenStateForVeh(veh, 0)
									actv_lxsrnmute_temp = true
								end
							end

						else
							if not useFiretruckSiren(veh) then
								if actv_lxsrnmute_temp == true then
									SetLxSirenStateForVeh(veh, srntone_temp)
									actv_lxsrnmute_temp = false
								end
							end
						end
						if state_airmanu[veh] ~= hmanu_state_new then
							SetAirManuStateForVehClick(veh, hmanu_state_new)
							count_bcast_timer = delay_bcast_timer
						end	
					end

					--- IS ANY LAND VEHICLE ---	
					if GetVehicleClass(veh) ~= 14 and GetVehicleClass(veh) ~= 15 and GetVehicleClass(veh) ~= 16 and GetVehicleClass(veh) ~= 21 then

					----- AUTO BROADCAST VEH STATES -----
						if count_bcast_timer > delay_bcast_timer then
							count_bcast_timer = 0

							--- IS EMERG VEHICLE ---
							if GetVehicleClass(veh) == 18 then
								TriggerServerEvent("lvc_TogDfltSrnMuted_s", dsrn_mute)
								TriggerServerEvent("lvc_SetLxSirenState_s", state_lxsiren[veh])
								TriggerServerEvent("lvc_TogPwrcallState_s", state_pwrcall[veh])
								TriggerServerEvent("lvc_SetAirManuState_s", state_airmanu[veh])
							end

							--- IS ANY OTHER VEHICLE ---
							count_bcast_timer = count_bcast_timer + 1
						end
					end
				end
			end
		if Sleep then
			Citizen.Wait(2500)
		end	
		Citizen.Wait(10)
	end
end)