local QBCore = exports['lrp-core']:GetCoreObject()

DrawText3D = function(x, y, z, text)
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

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local started = false
local progress = 0
local CurrentVehicle 
local pause = false
local quality = 0
local LastCar

local part2 = false
local part3 = false
local part4 = false



RegisterNetEvent('lrp-methcar:stop')
AddEventHandler('lrp-methcar:stop', function()
	started = false
	QBCore.Functions.Notify("Production stopped...", "error")
	FreezeEntityPosition(LastCar, false)
end)

RegisterNetEvent('lrp-methcar:stopfreeze')
AddEventHandler('lrp-methcar:stopfreeze', function(id)
	FreezeEntityPosition(id, false)
end)

RegisterNetEvent('lrp-methcar:notify')
AddEventHandler('lrp-methcar:notify', function(message)
	QBCore.Functions.Notify(message)
end)

RegisterNetEvent('lrp-methcar:startprod')
AddEventHandler('lrp-methcar:startprod', function()
	started = true
	FreezeEntityPosition(CurrentVehicle,true)
	QBCore.Functions.Notify("Production started", "success")	
	SetPedIntoVehicle((PlayerPedId()), CurrentVehicle, 3)
	SetVehicleDoorOpen(CurrentVehicle, 2)
end)

RegisterNetEvent('lrp-methcar:smoke')
AddEventHandler('lrp-methcar:smoke', function(posx, posy, posz, bool)
	if bool == 'a' then
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_bzgas_smoke", posx, posy, posz + 1.6, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.9)
		Citizen.Wait(60000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end
end)

RegisterNetEvent('lrp-methcar:fire')
AddEventHandler('lrp-methcar:fire', function(posx, posy, posz, bool)
	if bool == 'a' then
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		
		TriggerEvent('lrp-methcar:stop')
		SetVehicleEngineHealth(CurrentVehicle, -4000)

		local fire = StartParticleFxLoopedAtCoord("ent_ray_meth_fires", posx, posy, posz + 0.6, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		SetParticleFxLoopedAlpha(fire, 0.9)
		Citizen.Wait(15000)
		
		SetPtfxAssetNextCall("core")
		local fire2 = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz + 0.6, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		SetParticleFxLoopedAlpha(fire2, 0.9)
		Citizen.Wait(40000)

		AddExplosion(posx, posy, posz + 2, 15, 20.0, true, false, 1.0, true)

		StopParticleFxLooped(fire, 0)
		StopParticleFxLooped(fire2, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end
end)




-------------------------------------------------------EVENTS NEGATIVE
RegisterNetEvent('lrp-methcar:boom', function(data)
	playerPed = (PlayerPedId())
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	pause = false
	Citizen.Wait(500)
	started = false
	Citizen.Wait(3000)
	CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
	TriggerServerEvent('lrp-methcar:blow', pos.x, pos.y, pos.z)
	TriggerEvent('lrp-methcar:stop')
	FreezeEntityPosition(LastCar,false)
end)

RegisterNetEvent('lrp-methcar:blowup')
AddEventHandler('lrp-methcar:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2, 15, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)	
end)

RegisterNetEvent('lrp-methcar:drugged')
AddEventHandler('lrp-methcar:drugged', function()
	local pos = GetEntityCoords((PlayerPedId()))
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur((PlayerPedId()), true)
	SetPedMovementClipset((PlayerPedId()), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk((PlayerPedId()), true)
	quality = quality - 3
	pause = false
	Citizen.Wait(90000)
	ClearTimecycleModifier()
	TriggerServerEvent('lrp-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('lrp-methcar:q-1police', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 1
	pause = false
	TriggerServerEvent('police:server:policeAlert', 'Person reports stange smell!')
	TriggerServerEvent('lrp-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('lrp-methcar:q-1', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 1
	pause = false
	TriggerServerEvent('lrp-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('lrp-methcar:q-3', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 3
	pause = false
	TriggerServerEvent('lrp-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('lrp-methcar:q-5', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 5
	pause = false
	TriggerServerEvent('lrp-methcar:make', pos.x,pos.y,pos.z)
end)

-------------------------------------------------------EVENTS POSITIVE
RegisterNetEvent('lrp-methcar:q2', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 2
	pause = false
	TriggerServerEvent('lrp-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('lrp-methcar:q3', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 3
	pause = false
	TriggerServerEvent('lrp-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('lrp-methcar:q5', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 5
	pause = false
	TriggerServerEvent('lrp-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('lrp-methcar:gasmask', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	SetPedPropIndex(playerPed, 1, 26, 7, true)
	quality = quality + 2
	pause = false
	TriggerServerEvent('lrp-methcar:make', pos.x,pos.y,pos.z)
end)
















------------------------------------------- ingredient parts

------Methylamine

RegisterNetEvent('lrp-methcar:Methylamineq2', function(data)
	part2 = true
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 2
	pause = false
	TriggerServerEvent('lrp-methcar:Methylamine', pos.x,pos.y,pos.z)
end)


RegisterNetEvent('lrp-methcar:Methylamineq5', function(data)
	part2 = true
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 5
	pause = false
	TriggerServerEvent('lrp-methcar:Methylamine2', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('lrp-methcar:Methylamineq-5', function(data)
	part2 = true
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality - 5
	pause = false
	TriggerServerEvent('lrp-methcar:Methylamine3', pos.x,pos.y,pos.z)
end)



------Methanol

RegisterNetEvent('lrp-methcar:Methanolq-2', function(data)
	part2 = false
	part3 = true
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality - 2
	pause = false
	TriggerServerEvent('lrp-methcar:Methanol', pos.x,pos.y,pos.z)
end)


RegisterNetEvent('lrp-methcar:Methanolq5', function(data)
	part2 = false
	part3 = true
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 5
	pause = false
	TriggerServerEvent('lrp-methcar:Methanol2', pos.x,pos.y,pos.z)
end)



------Phosphorus

RegisterNetEvent('lrp-methcar:Phosphorusq-2', function(data)
	part3 = false
	part4 = true
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality - 2
	pause = false
	TriggerServerEvent('lrp-methcar:Phosphorus', pos.x,pos.y,pos.z)
end)


RegisterNetEvent('lrp-methcar:Phosphorusq5', function(data)
	part3 = false
	part4 = true
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 5
	pause = false
	TriggerServerEvent('lrp-methcar:Phosphorus2', pos.x,pos.y,pos.z)
end)


RegisterNetEvent('lrp-methcar:phosphorusq-5', function(data)
	part3 = false
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality - 5
	pause = false
	TriggerServerEvent('lrp-methcar:phosphorus4', pos.x,pos.y,pos.z)
end)



------Pseudoephedrine

RegisterNetEvent('lrp-methcar:Pseudoephedrineq-2', function(data)
	part4 = false
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality - 2
	pause = false
	TriggerServerEvent('lrp-methcar:Pseudoephedrine', pos.x,pos.y,pos.z)
end)


RegisterNetEvent('lrp-methcar:Pseudoephedrineq5', function(data)
	part4 = false
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 5
	pause = false
	TriggerServerEvent('lrp-methcar:Pseudoephedrine2', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('lrp-methcar:Pseudoephedrinefire', function(data)
	part4 = false
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 5
	pause = false
	TriggerServerEvent('lrp-methcar:Pseudoephedrine3', pos.x,pos.y,pos.z)
end)

local getname = nil

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		getname = exports['lrp-territories']:IsTerritoryDominationMoreThanZero('Vespucci')
		Citizen.Wait(Config.Delays.territory)
	end
end)


Citizen.CreateThread(function()
	while true do
		Wait(1500)
		local models = {
		'journey',
		}
		exports['lrp-target']:AddTargetModel(models, { 
			options = {
				{
					type = "client",
					event = "lrp-methcar:begin",
					icon = "fas fa-box-circle-check",
					label = "Start Cooking",
					--gang = getname
				}
			},
			distance = 1.5, 
		})
		Citizen.Wait(Config.Delays.territory)
	end
end)









RegisterNetEvent('lrp-methcar:begin', function(data)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	CurrentVehicle = QBCore.Functions.GetClosestVehicle(pos)

	if pos.y > 1800 then
		if IsVehicleSeatFree(CurrentVehicle, 3) then
			TriggerServerEvent('lrp-methcar:start')
			TriggerServerEvent('lrp-methcar:make', pos.x,pos.y,pos.z)
			progress = 0
			pause = false
			quality = 0		
		else
			QBCore.Functions.Notify('This kichen is already in use..')
		end
	else	
		QBCore.Functions.Notify("You are to close to the city!", "error")
	end
end)




-------------------------------------------------------THREAD
Citizen.CreateThread(function(data)
	while true do
		Citizen.Wait(1000)		
		playerPed = (PlayerPedId())
		local pos = GetEntityCoords(playerPed)
	
		if started == true  then			
			if progress < 96 then
				Citizen.Wait(500)
				if not pause and IsPedInAnyVehicle(playerPed) then
					progress = progress +  1
					quality = quality + 1
					Citizen.Wait(4000)
				end
				

				
				--ingredients--
				
				
				--   PART1
				--
				if  progress < 2 then
					pause = true
					exports['lrp-menu']:openMenu({
						{
							header = "How much Methylamine should you add?",
							txt = "Pick your answer below. Progres: " .. progress .. "%",
							isMenuHeader = true
						},
						{
							header = "25g",
							params = {
								event = "lrp-methcar:Methylamineq5",
								args = {
									message = "Perfect Amount!"
								}
							}
						},
						{
							header = "70g",
							params = {
								event = "lrp-methcar:Methylamineq-5",
								args = {
									message = "You made shit of the meth, you donkey!"
								}
							}
						},
						{
							header = "15g",
							params = {
								event = "lrp-methcar:Methylamineq2",
								args = {
									message = "Not quite enough but close!"
								}
							}
						},
					})
				end
				--
				--   PART2
				--
				if  progress > 15 and progress < 22 and part2 then
					pause = true
					exports['lrp-menu']:openMenu({
						{
							header = "How much Methanol should you add?",
							txt = "Pick your answer below. Progres: " .. progress .. "%",
							isMenuHeader = true
						},
						{
							header = "145ml",
							params = {
								event = "lrp-methcar:Methanolq5",
								args = {
									message = "Perfect Amount!"
								}
							}
						},
						{
							header = "30ml",
							params = {
								event = "lrp-methcar:Methanolq-2",
								args = {
									message = "Not quite enough but close!"
								}
							}
						},
						{
							header = "500ml",
							params = {
								event = "lrp-methcar:boom",
								args = {
									message = "Thick cunt!"
								}
							}
						},
					})
				end

				
				--   PART3
				--
				if progress > 37 and progress < 43 and part3 then
					pause = true
					exports['lrp-menu']:openMenu({
						{
							header = "How much Red Phosphorus should you add?",
							txt = "Pick your answer below. Progres: " .. progress .. "%",
							isMenuHeader = true
						},
						{
							header = "140g",
							params = {
								event = "lrp-methcar:phosphorusq-5",
								args = {
									message = "Bit hot aye?"
								}
							}
						},
						{
							header = "63g",
							params = {
								event = "lrp-methcar:Phosphorusq-2",
								args = {
									message = "Not quite enough!"
								}
							}
						},
						{
							header = "80g",
							params = {
								event = "lrp-methcar:Phosphorusq5",
								args = {
									message = "Perfect Amount!"
								}
							}
						},
					})
				end

				
				--   PART4
				--
				if  progress > 67 and progress < 73 and part4 then
					pause = true
					exports['lrp-menu']:openMenu({
						{
							header = "How much Pseudoephedrine should you add?",
							txt = "Pick your answer below. Progres: " .. progress .. "%",
							isMenuHeader = true
						},
						{
							header = "250g",
							params = {
								event = "lrp-methcar:Pseudoephedrineq5",
								args = {
									message = "Perfect Amount!"
								}
							}
						},
						{
							header = "145g",
							params = {
								event = "lrp-methcar:Pseudoephedrineq-2",
								args = {
									message = "Not quite enough!"
								}
							}
						},
						{
							header = "500g",
							params = {
								event = "lrp-methcar:Pseudoephedrinefire",
								args = {
									message = "Bit hot aye?"
								}
							}
						},
					})
				end














				---Random events----

				--
				--   EVENT 1
				--
				if progress > 9 and progress < 11 then
					pause = true
					exports['lrp-menu']:openMenu({
						{
							header = "Gas tank is leaking... now what?",
							txt = "Pick your answer below. Progres: " .. progress .. "%",
							isMenuHeader = true,
						},
						{
							header = " Fix with tape",
							params = {
								event = "lrp-methcar:q-3",
								args = {
									message = "That kinda fixed it, i think?!"
								}
							}
						},
						{
							header = " Let it go!",
							params = {
								event = "lrp-methcar:boom"
							}
						},
						{
							header = "  Replace tube",
							params = {
								event = "lrp-methcar:q5",
								args = {
									message = "Replacing was the best solution!"
								}
							}
						},
					})
				end
				--
				--   EVENT 2
				--
				if progress > 22 and progress < 24 then
					pause = true
					exports['lrp-menu']:openMenu({
						{
							header = "You spilled some acetone on the floor.. now what?",
							txt = "Pick your answer below. Progres: " .. progress .. "%",
							isMenuHeader = true,
						},
						{
							header = "  Open a window",
							params = {
								event = "lrp-methcar:q-1police",
								args = {
									message = "The smell is reaching more people..."
								}
							}
						},
						{
							header = "  Breathe it in..",
							params = {
								event = "lrp-methcar:drugged"
							}
						},
						{
							header = "  Put on a gass mask",
							params = {
								event = "lrp-methcar:gasmask",
								args = {
									message = "Good choise"
								}
							}
						},
					})
				end
				--
				--   EVENT 3
				--
				if progress > 29 and progress < 31 then
					pause = true
					exports['lrp-menu']:openMenu({
						{
							header = "Meth is clugging up to fast, what to do?",
							txt = "Pick your answer below. Progres: " .. progress .. "%",
							isMenuHeader = true,
						},
						{
							header = "  Add more temperature",
							params = {
								event = "lrp-methcar:q5",
								args = {
									message = "A higher temperture made the perfect balance!"
								}
							}
						},
						{
							header = "  Add more pressure",
							params = {
								event = "lrp-methcar:q-3",
								args = {
									message = "The pressure fluctuated a lot.."
								}
							}
						},
						{
							header = "  Lower the pressure",
							params = {
								event = "lrp-methcar:q-5",
								args = {
									message = "That was the worst thing to do!"
								}
							}
						},
					})
				end
				--
				--   EVENT 4
				--
				if progress > 43 and progress < 45 then
					pause = true
					exports['lrp-menu']:openMenu({
						{
							header = "The acetone concentration is to high for the mix, what to do?",
							txt = "Pick your answer below. Progres: " .. progress .. "%",
							isMenuHeader = true,
						},
						{
							header = "  Do nothing..",
							params = {
								event = "lrp-methcar:q-5",
								args = {
									message = "The Meth is smelling like pure acetone"
								}
							}
						},
						{
							header = "  Use a straw to suck it out",
							params = {
								event = "lrp-methcar:drugged"
							}
						},
						{
							header = "  Add lithium to stabilize",
							params = {
								event = "lrp-methcar:q5",
								args = {
									message = "Smart solution"
								}
							}
						},
					})
				end
				--
				--   EVENT 5
				--
				if progress > 49 and progress < 51 then
					pause = true
					exports['lrp-menu']:openMenu({
						{
							header = "There is some blue pigment, use it?",
							txt = "Pick your answer below. Progres: " .. progress .. "%",
							isMenuHeader = true,
						},
						{
							header = "  Add it in the mix!",
							params = {
								event = "lrp-methcar:q5",
								args = {
									message = "Smart move, people like it!"
								}
							}
						},
						{
							header = "  Put away",
							params = {
								event = "lrp-methcar:q-1",
								args = {
									message = "Not very creative are you?"
								}
							}
						},
					})
				end
				--
				--   EVENT 6
				--
				if progress > 59 and progress < 61 then
					pause = true
					exports['lrp-menu']:openMenu({
						{
							header = "The filter is filthy, now what?",
							txt = "Pick your answer below. Progres: " .. progress .. "%",
							isMenuHeader = true,
						},
						{
							header = " Blow it out with a compressor",
							params = {
								event = "lrp-methcar:q-5",
								args = {
									message = "You made a mess of the product!"
								}
							}
						},
						{
							header = " Replace the filter!",
							params = {
								event = "lrp-methcar:q5",
								args = {
									message = "Replacing was the best option!"
								}
							}
						},
						{
							header = " Clean it with a brush",
							params = {
								event = "lrp-methcar:q-1",
								args = {
									message = "It helped but not enough"
								}
							}
						},
					})
				end
				--
				--   EVENT 7
				--
				if progress > 73 and progress < 75 then
					pause = true
					exports['lrp-menu']:openMenu({
						{
							header = "You spilled some acetone on the floor.. now what?",
							txt = "Pick your answer below. Progres: " .. progress .. "%",
							isMenuHeader = true,
						},
						{
							header = " Breathe it in..",
							params = {
								event = "lrp-methcar:drugged"
							}
						},
						{
							header = " Put on a gass mask",
							params = {
								event = "lrp-methcar:gasmask",
								args = {
									message = "Good choise"
								}
							}
						},
						{
							header = " Open a window",
							params = {
								event = "lrp-methcar:q-1police",
								args = {
									message = "The smell is reaching more people..."
								}
							}
						},
					})
				end
				--
				--   EVENT 8
				--
				if progress > 79 and progress < 81 then
					pause = true
					exports['lrp-menu']:openMenu({
						{
							header = "Gas tank is leaking... now what?",
							txt = "Pick your answer below. Progres: " .. progress .. "%",
							isMenuHeader = true,
						},
						{
							header = " Let it go!",
							params = {
								event = "lrp-methcar:boom"
							}
						},
						{
							header = " Fix it with tape",
							params = {
								event = "lrp-methcar:q-3",
								args = {
									message = "That kinda fixed it, i think?!"
								}
							}
						},
						{
							header = " Replace tube",
							params = {
								event = "lrp-methcar:q5",
								args = {
									message = "Replacing was the best solution!"
								}
							}
						},
					})
				end
				--
				--   EVENT 9
				--
				if progress > 89 and progress < 91 then
					pause = true
					exports['lrp-menu']:openMenu({
						{
							header = "You really need to take a shit! What do you do?",
							txt = "Pick your answer below. Progres: " .. progress .. "%",
							isMenuHeader = true,
						},
						{
							header = " Just pinch it off!",
							params = {
								event = "lrp-methcar:q5",
								args = {
									message = "SUPER JOB, i'm proud!"
								}
							}
						},
						{
							header = " Go outside to shit!",
							params = {
								event = "lrp-methcar:q-1police",
								args = {
									message = "Somebody spotted you're suspicious work!"
								}
							}
						},
						{
							header = " Shit inside!",
							params = {
								event = "lrp-methcar:q-5",
								args = {
									message = "Not good! Everything smells like SHIT!"
								}
							}
						},
					})
				end
			else
				TriggerEvent('lrp-methcar:stop')
				progress = 100
				QBCore.Functions.Notify('Meth production: ' .. progress .. '%')
				QBCore.Functions.Notify("Done!!", "success")
				TriggerServerEvent('lrp-methcar:finish', quality)
				SetPedPropIndex(playerPed, 1, 0, 0, true)
				FreezeEntityPosition(LastCar, false)
			end	
		end		
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
			if IsPedInAnyVehicle((PlayerPedId())) then
			else
				if started then
					started = false
					TriggerEvent('lrp-methcar:stop')
					FreezeEntityPosition(LastCar,false)
				end		
			end
	end
end)




