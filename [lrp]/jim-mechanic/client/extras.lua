local QBCore = exports['lrp-core']:GetCoreObject()
RegisterNetEvent('QBCore:Client:UpdateObject', function() QBCore = exports['lrp-core']:GetCoreObject() end)
--=== Car Wax ===--
local cleaning = false
RegisterNetEvent("jim-mechanic:client:CarWax", function(data)
	if not cleaning then cleaning = true else return end
	triggerNotify(nil, Loc[Config.Lan]["police"].cleaning)
	local vehicle
	if not IsPedInAnyVehicle(PlayerPedId(), false) then	vehicle = getClosest(GetEntityCoords(PlayerPedId())) end
	TriggerEvent('animations:client:EmoteCommandStart', {"clean2"})
	while cleaning do
		if GetVehicleDirtLevel(vehicle) >= 1.0 then
			SetVehicleDirtLevel(vehicle, (tonumber(GetVehicleDirtLevel(vehicle))) - 0.3)
		elseif GetVehicleDirtLevel(vehicle) <= 1.0 then
			SetVehicleDirtLevel(vehicle, 0.0)
			WashDecalsFromVehicle(vehicle, 1.0)
			cleaning = false
			triggerNotify(nil, Loc[Config.Lan]["extras"].clean, "success")
			emptyHands(playerPed, true)
		end
		Wait(300)
	end
	Wait(1000)
	emptyHands(playerPed, true)
	if cleaning == false and data.time ~= 0 then
		TriggerServerEvent("jim-mechanic:server:WaxActivator", VehToNet(vehicle), data.time)
	end
	if Config.CosmeticRemoval and not data.skip then toggleItem(false, "cleaningkit") end
end)

RegisterNetEvent("jim-mechanic:client:CarWax:WaxTick", function(vehicle)
	if not LocalPlayer.state.isLoggedIn then return end
	if not NetworkDoesEntityExistWithNetworkId(vehicle) then return end
	if DoesEntityExist(NetToVeh(vehicle)) then
		if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(NetToVeh(vehicle))) <= 100.0 then
			SetVehicleDirtLevel(NetToVeh(vehicle), 0.0)
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:cleanVehicle', function(skip)
	local coords = GetEntityCoords(PlayerPedId())
	if not inCar() then return end
	if not nearPoint(coords) then return end
	local vehicle = getClosest(coords) pushVehicle(vehicle) lookVeh(vehicle)
	if DoesEntityExist(vehicle) then
		local CleanMenu = {
			{ icon = "cleaningkit", isMenuHeader = true, header = searchCar(vehicle), txt = "Class: "..getClass(vehicle).."<br>"..Loc[Config.Lan]["check"].plate..trim(GetVehicleNumberPlateText(vehicle))..Loc[Config.Lan]["check"].value..searchPrice(vehicle).."<br>"..searchDist(vehicle), },
			{ icon = "fas fa-circle-xmark", header = "", txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""), params = { event = "jim-mechanic:client:Menu:Close" } } }

			CleanMenu[#CleanMenu + 1] = { header = Loc[Config.Lan]["carwax"].head1, params = { event = "jim-mechanic:client:CarWax", args = { time = 0, skip = skip }}}
		if Config.WaxFeatures then
			CleanMenu[#CleanMenu + 1] = { header = Loc[Config.Lan]["carwax"].head2, params = { event = "jim-mechanic:client:CarWax", args = { time = 1800, skip = skip }}}
			CleanMenu[#CleanMenu + 1] = { header = Loc[Config.Lan]["carwax"].head3, params = { event = "jim-mechanic:client:CarWax", args = { time = 3600, skip = skip }}}
			CleanMenu[#CleanMenu + 1] = { header = Loc[Config.Lan]["carwax"].head4, params = { event = "jim-mechanic:client:CarWax", args = { time = 5400, skip = skip }}}
		end
		exports['lrp-menu']:openMenu(CleanMenu)
	end
end)

--Quick Repair
RegisterNetEvent('jim-mechanic:quickrepair', function()
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local repaireng = true
	local repairbody = true
	if not IsPedInAnyVehicle(playerPed, false) then	vehicle = getClosest(coords) pushVehicle(vehicle) end
	if DoesEntityExist(vehicle) then
		currentenginehealth = GetVehicleEngineHealth(vehicle)
		currentbodyhealth = GetVehicleBodyHealth(vehicle)

		if GetVehicleEngineHealth(vehicle) >= Config.MaxDuctEngine then repaireng = false else repaireng = true end
		if Config.DuctTapeBody and GetVehicleBodyHealth(vehicle) >= Config.MaxDuctBody then repairbody = false else repairbody = true end

		if repaireng or repairbody then
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			SetVehicleDoorOpen(vehicle, 4, false, false)
			QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["repair"].applyduct, 10000, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
			{ animDict = "mini@repair",	anim = "fixing_a_ped", flags = 16, }, {}, {}, function() SetVehicleModKit(vehicle, 0)
				Wait(1000)
				emptyHands(playerPed)
				if Config.DuctSimpleMode then
					SetVehicleEngineHealth(vehicle, Config.MaxDuctEngine)
					SetVehicleBodyHealth(vehicle, Config.MaxDuctBody)
				elseif not Config.DuctSimpleMode then
					if currentenginehealth <= 50.0 and currentenginehealth <= 200 then SetVehicleEngineHealth(vehicle, 300.0)
					else
						SetVehicleEngineHealth(vehicle, currentenginehealth + Config.DuctAmountEngine)
						if GetVehicleEngineHealth(vehicle) > Config.MaxDuctEngine then SetVehicleEngineHealth(vehicle, Config.MaxDuctEngine) end
					end
					if Config.DuctTapeBody then
						if currentbodyhealth <= 50.0 and currentbodyhealth <= 200 then SetVehicleBodyHealth(vehicle, 300.0)
						else SetVehicleBodyHealth(vehicle, currentbodyhealth + Config.DuctAmountBody)
							if GetVehicleBodyHealth(vehicle) > Config.MaxDuctBody then SetVehicleBodyHealth(vehicle, Config.MaxDuctBody) end
						end
					end
					SetVehicleDoorShut(vehicle, 4, false, false)
				end
				if Config.RemoveDuctTape then toggleItem(false, "ducttape") end
			end, function()
				SetVehicleDoorShut(vehicle, 4, false, false)
				emptyHands(playerPed)
			end, "ducttape")
		else triggerNotify(nil, Loc[Config.Lan]["repair"].ductfull, "error") end
	else triggerNotify(nil, Loc[Config.Lan]["repair"].nocar, "error") end
end)

--Multipurpose Door command
RegisterNetEvent('jim-mechanic:client:openDoor', function(door)
	local doornum = tonumber(door)
	if doornum < 0 or doornum > 5 then
		triggerNotify(nil, Loc[Config.Lan]["extras"].doorerr, "error")
		return
	end
	local coords = GetEntityCoords(PlayerPedId())
	if not nearPoint(coords) then return end
	local vehicle = nil
	if IsPedSittingInAnyVehicle(PlayerPedId()) then	vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	else vehicle = getClosest(coords) pushVehicle(vehicle) end
	if DoesEntityExist(vehicle) then
		if GetVehicleDoorLockStatus(vehicle) == 2 then
			triggerNotify(nil, Loc[Config.Lan]["extras"].locked, "error")
			return
		else
			if GetVehicleDoorAngleRatio(vehicle, doornum) > 0.0 then SetVehicleDoorShut(vehicle, doornum, false)
			else SetVehicleDoorOpen(vehicle, doornum, false, false) end
		end
	end
end)

RegisterNetEvent("jim-mechanic:flipvehicle", function()
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if not inCar() then	return end
	if not nearPoint(coords) then return end
	local vehicle = getClosest(coords) pushVehicle(vehicle)
	if DoesEntityExist(vehicle) then
		QBCore.Functions.Progressbar("accepted_key", Loc[Config.Lan]["extras"].flipping, 12000, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false,	disableCombat = false, },
		{ animDict = "missfinale_c2ig_11", anim = "pushcar_offcliff_f",	flags = 17, }, {}, {}, function()
			qblog("used `/flipvehicle`")
			emptyHands(playerPed)
			local vehiclecoords = GetEntityCoords(vehicle)
			SetEntityCoords(vehicle, vehiclecoords.x+0.5, vehiclecoords.y+0.5, vehiclecoords.z+1)
			Wait(200)
			SetEntityRotation(vehicle, GetEntityRotation(PlayerPedId(), 2), 2)
			Wait(500)
			SetVehicleOnGroundProperly(vehicle)
			triggerNotify(nil, Loc[Config.Lan]["extras"].flipped, "success")
		end, function() -- Cancel
			triggerNotify(nil, Loc[Config.Lan]["extras"].failed, "error")
			emptyHands(playerPed)
		end, "fas fa-car-burst")
	end
end)

RegisterNetEvent("jim-mechanic:seat", function(seat)
	if not seat then triggerNotify(nil, Loc[Config.Lan]["extras"].noseat, "error") return end
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	local IsSeatFree = IsVehicleSeatFree(vehicle, tonumber(seat))
	local speed = GetEntitySpeed(vehicle)
	local HasHarnass = exports['qb-smallresources']:HasHarness()
	if not HasHarnass then
		local kmh = (speed * 3.6);
		if IsSeatFree then
			if kmh <= 100.0 then
				SetPedIntoVehicle(PlayerPedId(), vehicle, tonumber(seat))
				triggerNotify(nil, Loc[Config.Lan]["extras"].moveseat..seat.."!")
			else
				triggerNotify(nil, Loc[Config.Lan]["extras"].fastseat)
			end
		else
			triggerNotify(nil, Loc[Config.Lan]["extras"].notseat)
		end
	else
		triggerNotify(nil, Loc[Config.Lan]["extras"].harness, 'error')
	end
end)

local vehicle_sounds = {}
local soundTog = false
RegisterNetEvent("jim-mechanic:togglesound", function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
	if not soundTog then soundTog = true
		currentEngine = GetVehicleMod(vehicle, 11)
		if currentEngine == 4 then ForceVehicleEngineAudio(vehicle, "monster")
		elseif currentEngine == 3 then ForceVehicleEngineAudio(vehicle, "monster")
		elseif currentEngine == 2 then	ForceVehicleEngineAudio(vehicle, "krieger")
		elseif currentEngine == 1 then	ForceVehicleEngineAudio(vehicle, "zentorno")
		elseif currentEngine == 0 then	ForceVehicleEngineAudio(vehicle, "zorrusso") end
	elseif soundTog then soundTog = false
		ForceVehicleEngineAudio(vehicle, string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))))
	end
end)

--ODOMETER FUNCTION
local DistAdd = 0
local DistCount = 0
local maxspeed = 0
local ShowingOdo = false
ShowOdo = Config.ShowOdo
local owned = false
local veh, prevVeh
local invehicle = false
local databasecalc = false
local odocalc = false
local nosUpdate = false
CreateThread(function()
	while true do
		local invehicle = IsPedInAnyVehicle(PlayerPedId(), true)
		if invehicle then
			nosCheck = true
			local ped = PlayerPedId()
			local dist = ""
			veh = GetVehiclePedIsIn(ped)
			if DoesEntityExist(veh) then
				if GetPedInVehicleSeat(veh, -1) == ped then
					local prevLoc = GetEntityCoords(veh)
					local plate = trim(GetVehicleNumberPlateText(veh))
					if veh ~= prevVeh then
						--ModifyVehicleTopSpeed(veh, -1.0)
						owned = IsVehicleOwned(plate)
						prevVeh = GetVehiclePedIsIn(ped)
						local nos = {}
						if VehicleNitrous[trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())))] then
							nos = {
								VehicleNitrous[trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())))].hasnitro,
								VehicleNitrous[trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())))].level
							}
						end
						TriggerEvent('hud:client:UpdateNitrous', nos[1] or false, nos[2] or 0, false)
					end
					if owned then
						local p = promise.new()
						QBCore.Functions.TriggerCallback('jim-mechanic:distGrab', function(cb) p:resolve(cb) end, trim(GetVehicleNumberPlateText(veh)))
						dist = Citizen.Await(p)
					end
					CreateThread(function() -- LOOP TO UPDATE DATABASE WHILE DRIVING
						if not databasecalc then databasecalc = true
							while owned and databasecalc do
								if IsPedInAnyVehicle(PlayerPedId(), true) then
									if not IsVehicleStopped(GetVehiclePedIsIn(ped)) then
										DistAdd = DistAdd + #(prevLoc - GetEntityCoords(veh))
										if DistAdd >= 3000 then
											if useMechJob() then
												local mechDamages = {
													["radiator"] = (math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "radiator"))+0.0 or 100),
													["axle"] = (math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "axle"))+0.0 or 100),
													["brakes"] = (math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "brakes"))+0.0 or 100),
													["clutch"] = (math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "clutch"))+0.0 or 100),
													["fuel"] = (math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "fuel"))+0.0 or 100),
												}
												TriggerServerEvent('jim-mechanic:server:saveStatus', mechDamages, plate)
											end
											TriggerServerEvent('jim-mechanic:server:UpdateDrivingDistance', plate, math.round(DistAdd))
											dist = dist + DistAdd
											DistAdd = 0
										end
									else Wait(5000) end
								else databasecalc = false end
								Wait(5000)
							end
						end
					end)
					CreateThread(function() -- Odometer
						if not odocalc then odocalc = true
							while odocalc do
								if ShowOdo and IsPedInAnyVehicle(PlayerPedId(), true) then
									local odotext = ""
									local lights = ""
										if dist ~= "" then
											if Config.distkph then odotext = string.format("%05d", math.floor((dist+math.round(DistAdd)) * 0.001)).." <b>Km</b>"
											else odotext = string.format("%05d", math.floor((dist+math.round(DistAdd)) * 0.000621371)).." <b>Mi</b>" end
										end
										if Config.Debug then
											odotext =
											"<br><b>Vehicle Debug Info</b>:"..
											"<br>"..searchCar(veh)..
											"Class: "..getClass(veh)..
											"<br>"..Loc[Config.Lan]["check"].plate..plate.."]"..
											"<br>Dist: "..tostring(odotext or "")..
											"<br>Fuel: "..nosBar(math.floor(exports['LegacyFuel']:GetFuel(veh) or 0)).." "..math.floor(exports['LegacyFuel']:GetFuel(veh) or 0).."%"
											if VehicleNitrous[plate] then
												odotext = odotext.."<br>NOS: "..nosBar((VehicleNitrous[plate].level)).." "..tostring((VehicleNitrous[plate].level)).."%"
											end

											if maxspeed <= math.floor(GetEntitySpeed(veh) * 2.236936) then maxspeed = math.floor(GetEntitySpeed(veh) * 2.236936) end

											odotext = odotext.."<br><br>Top Speed Modifier: "..GetVehicleTopSpeedModifier(veh)..
																"<br>Current MPH: "..math.floor(GetEntitySpeed(veh) * 2.236936)..
																"<br>Recorded Max: "..maxspeed

											local vehcoord = GetEntityCoords(veh)
											local streetname, crossingname = GetStreetNameAtCoord(vehcoord.x, vehcoord.y, vehcoord.z, veh)
											odotext = odotext.."<br><br>Street Name: "..GetStreetNameFromHashKey(streetname)..
																"<br>onRoad: "..tostring(IsPointOnRoad(GetEntityCoords(veh), veh))

											odotext = odotext..
											"<br><br><b>Vehicle Health</b>:"..
											"<br>Engine: "..math.floor(GetVehicleEngineHealth(veh)/10).."%<br>"..nosBar(math.floor(GetVehicleEngineHealth(veh)/10))..
											"<br>Body: "..math.floor(GetVehicleBodyHealth(veh)/10).."%<br>"..nosBar(math.floor(GetVehicleBodyHealth(veh)/10))
											if useMechJob() then
												odotext = odotext..
												"<br><br><b>Extra Damages</b>:"..
												"<br>"..Loc[Config.Lan]["repair"].radiator..": "..math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "radiator") or 100).."%<br>"..nosBar(math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "radiator") or 100)).." "..
												"<br>"..Loc[Config.Lan]["repair"].driveshaft..": "..math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "axle") or 100).."%<br>"..nosBar(math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "axle") or 100)).." "..
												"<br>"..Loc[Config.Lan]["repair"].brakes..": "..math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "brakes") or 100).."%<br>"..nosBar(math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "brakes") or 100)).." "..
												"<br>"..Loc[Config.Lan]["repair"].clutch..": "..math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "clutch") or 100).."%<br>"..nosBar(math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "clutch") or 100)).." "..
												"<br>"..Loc[Config.Lan]["repair"].tank..": "..math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "fuel") or 100).."%<br>"..nosBar(math.floor(exports['qb-mechanicjob']:GetVehicleStatus(plate, "fuel") or 100))
											end
											odotext = odotext..
											"<br><br><b>Upgrade Levels</b>:"..
											"<br>"..Loc[Config.Lan]["check"].label1.." Lvl "..(GetVehicleMod(veh, 11)+1).." / "..GetNumVehicleMods(veh, 11)..
											"<br>"..Loc[Config.Lan]["check"].label2.." Lvl "..(GetVehicleMod(veh, 12)+1).." / "..GetNumVehicleMods(veh, 12)..
											"<br>"..Loc[Config.Lan]["check"].label3.." Lvl "..(GetVehicleMod(veh, 15)+1).." / "..GetNumVehicleMods(veh, 15)..
											"<br>"..Loc[Config.Lan]["check"].label4.." Lvl "..(GetVehicleMod(veh, 13)+1).." / "..GetNumVehicleMods(veh, 13)..
											"<br>"..Loc[Config.Lan]["check"].label5.." Lvl "..(GetVehicleMod(veh, 16)+1).." / "..GetNumVehicleMods(veh, 16)..
											"<br>"..Loc[Config.Lan]["check"].label6.." "..tostring(IsToggleModOn(veh, 18))..
											"<br>"..Loc[Config.Lan]["check"].label7.." "..tostring(IsToggleModOn(veh, 22))..
											"<br>"..Loc[Config.Lan]["check"].label8.." "..tostring(GetDriftTyresEnabled(veh))..
											"<br>"..Loc[Config.Lan]["check"].label9.." "..tostring(not GetVehicleTyresCanBurst(veh))
										end
										if Config.OdoShowIcons or Config.Debug then
											local br = "&nbsp;&nbsp;"
											if Config.OdoLocation == "right" or Config.OdoLocation == "left" then br = "<br>" vert = "horizontal" end
											if Config.OdoIconsToShow["engine"] then
												if GetVehicleEngineHealth(veh) > 700 then
													if Config.OdoAlwaysShowIcons then lights = lights.."<img style='vertical-align:middle; filter: invert(106%); height:3.0vh' src='img/engine.png'>"..br
													else lights = lights.."" end
												elseif GetVehicleEngineHealth(veh) < 700 and GetVehicleEngineHealth(veh) > 450 then
													lights = lights.. "<img style='vertical-align:middle; filter: invert(106%) sepia(99%) saturate(7404%) hue-rotate(4deg) brightness(95%) contrast(118%); height:3.0vh' src='img/engine.png'>"..br
												elseif GetVehicleEngineHealth(veh) < 450 then
													lights = lights.."<img style='vertical-align:middle; filter: invert(16%)  sepia(99%) saturate(7404%) hue-rotate(4deg) brightness(95%) contrast(118%); height:3.0vh' src='img/engine.png'>"..br
												end
											end
											if useMechJob() then
												for k, v in pairs({"radiator", "brakes", "axle", "clutch"}) do
													if Config.OdoIconsToShow[v] then
														if exports['qb-mechanicjob']:GetVehicleStatus(plate, v) then
															if exports['qb-mechanicjob']:GetVehicleStatus(plate, v) > 70 then
																if Config.OdoAlwaysShowIcons then lights = lights.."<img style='vertical-align:middle; filter: invert(106%); height:3.0vh' src='img/"..v..".png'>"..br
																else lights = lights.."" end
															elseif exports['qb-mechanicjob']:GetVehicleStatus(plate, v) < 70 and exports['qb-mechanicjob']:GetVehicleStatus(plate, v) > 45 then
																lights = lights.."<img style='vertical-align:middle; filter: invert(106%) sepia(99%) saturate(7404%) hue-rotate(4deg) brightness(95%) contrast(118%); height:3.0vh' src='img/"..v..".png'>"..br
															elseif exports['qb-mechanicjob']:GetVehicleStatus(plate, v) < 45 then
																lights = lights.."<img style='vertical-align:middle; filter: invert(16%) sepia(99%) saturate(7404%) hue-rotate(4deg) brightness(95%) contrast(118%); height:3.0vh' src='img/"..v..".png'>"..br
															end
														end
													end
												end
											end
											if Config.OdoIconsToShow["headlight"] then
												local headlights = {}
												headlights[1], headlights[2], headlights[3] = GetVehicleLightsState(veh)
												if headlights[2] == 1 then
													if headlights[3] == 0 then
														lights = lights.."<img style='vertical-align:middle; filter: invert(106%); height:3.0vh' src='img/headlight1.png'>"..br
													elseif headlights[3] == 1 then
														lights = lights.."<img style='vertical-align:middle; filter: invert(106%); height:3.0vh' src='img/headlight2.png'>"..br
													end
												end
											end
											if Config.OdoIconsToShow["wheel"] then
												for _, v in pairs({0, 1, 4, 5}) do
													if IsVehicleTyreBurst(vehicle, v, false) then
														lights = lights.."<img style='vertical-align:middle; filter: invert(16%)  sepia(99%) saturate(7404%) hue-rotate(4deg) brightness(95%) contrast(118%); height:3.0vh' src='img/wheel.png'>"..br
														break
													end
												end
											end
											if VehicleNitrous[plate] then
												local style
												if purgemode then
													style = "vertical-align:middle; filter: invert("..(purgeSize*100).."%); opacity: "..VehicleNitrous[plate].level/100 .."; height:3.0vh"
													lights = lights.."<img style='"..style.."' src='img/purge.png'>"..br
												else
													if purgeCool > 0 then
														local brightness = 100 - (100 / (purgeCool+1))
														lights = lights..purgeCool.."<img style='vertical-align:middle; filter: invert("..brightness.."%); ; height:3.0vh' src='img/nos.png'>"..br
													else
														style = "vertical-align:middle; filter: invert(100%); height:3.0vh"
														if boostLevel == 2 then style = "vertical-align:middle; filter: invert(106%) sepia(99%) saturate(7404%) hue-rotate(4deg) brightness(95%) contrast(118%); opacity: "..VehicleNitrous[plate].level/100 .."; height:3.0vh" end
														if boostLevel == 3 then style = "vertical-align:middle; filter: invert(16%) sepia(99%) saturate(7404%) hue-rotate(4deg) brightness(95%) contrast(118%); opacity: "..VehicleNitrous[plate].level/100 .."; height:3.0vh" end
														lights = lights.."<img style='"..style.."' src='img/nos.png'>"..br
													end
												end
											end
										TriggerEvent("jim-mechanic:client:DrawText", "<center>"..lights.."<span style=''>"..odotext.."</span>", tostring(Config.OdoLocation))
									end
								else TriggerEvent("jim-mechanic:client:HideText") odocalc = false Wait(1000) end
								Wait(600)
							end
						end
					end)
				end
			end
		else TriggerEvent("jim-mechanic:client:HideText") end
		Wait(10000)
		if not invehicle then
			if nosCheck and VehicleNitrous[trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true)))] then
				TriggerServerEvent('jim-mechanic:database:UpdateNitroLevel', trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true))), VehicleNitrous[trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true)))].level) -- Update the nos when you are no longer in that vehicle
			end
			maxspeed = 0
			nosCheck = false
			odocalc = false
			databasecalc = false
			TriggerEvent("jim-mechanic:client:HideText")
			DistAdd = 0
		else Wait(10000) end
	end
end)

RegisterNetEvent("jim-mechanic:ShowOdo", function() print("^3ShowOdo^7: ^2Odometer toggled^7") ShowOdo = not ShowOdo end)