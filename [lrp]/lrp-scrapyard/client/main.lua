local QBCore = exports['lrp-core']:GetCoreObject()
local closestScrapyard = 0
local emailSend = false
local inScrapYard = false
local scrapyards = {}
local AlertSend = false
local scraping = false
local vehiclebeingscrapped = nil
local scrapingcar = false
local vehiclePlate = nil
local bonnettaken = false
local boottaken = false
local dooramount = 0
local doorsleft = 0
local wheelsleft = 0
local driverdoorf = false
local driverdoorr = false
local passengerdoorf = false
local passengerdoorr = false
local wheellf = false
local wheelrf = false
local wheellr = false
local wheelrr = false
local carpart = nil
local sixdoorcar = false
local fourdoorcar = false
local holdingprop = false
local axe = nil


RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    TriggerServerEvent("qb-scrapyard:server:LoadVehicleList")
end)



Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        SetClosestScrapyard()
        Citizen.Wait(10000)
    end
end)


Citizen.CreateThread(function()
	while true do	
		sleep = 1000
		if inScrapYard then
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
			if IsPedInAnyVehicle(PlayerPedId()) and not scraping and GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then		
				sleep = 5
				if IsControlJustReleased(0, 38) then
					QBCore.Functions.TriggerCallback('lrp-scrap:server:getCops', function(cops)
						if cops >= Config.RequiredCops then
							local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
							if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
								if IsVehicleValid(GetEntityModel(vehicle)) then
									vehiclePlate = QBCore.Functions.GetPlate(vehicle)
									scraping = true
									ScrapVehicle(vehicle)
									sleep = 1000
									exports['textUi']:HideTextUi('hide')
									TriggerServerEvent("qb-scrapyard:server:ScrapVehicle", GetVehicleKey(GetEntityModel(vehicle)))
									if 5 == math.random(1,5) then	
										PoliceCall()
									end
				
								else
									QBCore.Functions.Notify("This Vehicle Cannot Be Scrapped.", "error")
								end
							else
								QBCore.Functions.Notify("You Are Not The Driver", "error")
							end
						else
							QBCore.Functions.Notify('There aint enough cops come back later', 'error')
						end                
					end)
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)



RegisterNetEvent('qb-scapyard:client:setNewVehicles', function(vehicleList)
	Config.CurrentVehicles = vehicleList
end)


function PoliceCall()
    if not AlertSend then
        local vehicle = QBCore.Functions.GetClosestVehicle()
        TriggerEvent("un-dispatch:carscraping", {
            model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)),
            plate = GetVehicleNumberPlateText(vehicle),
            firstColor = Config.Colours[tostring(GetVehicleCustomPrimaryColour(vehicle))],
            secondColor = Config.Colours[tostring(GetVehicleCustomSecondaryColour(vehicle))],
            heading = math.floor(GetEntityHeading(vehicle)) .. '°'
        })
    end
end


function CreateListEmail()
	QBCore.Functions.Notify("An email will be sent to you soon.", "info")
	if Config.CurrentVehicles ~= nil and next(Config.CurrentVehicles) ~= nil then
		emailSend = true
		local vehicleList = ""
		for k, v in pairs(Config.CurrentVehicles) do
			if Config.CurrentVehicles[k] ~= nil then
				local vehicleInfo = QBCore.Shared.Vehicles[v]
				if vehicleInfo ~= nil then
					vehicleList = vehicleList  .. vehicleInfo["brand"] .. " " .. vehicleInfo["name"] .. "<br />"
				end
			end
		end
		SetTimeout(math.random(30000, 60000), function()
			emailSend = false
			TriggerServerEvent('qb-phone:server:sendNewMail', {
				sender = "Turner’s Auto Wrecking",
				subject = "Vehicle List",
				message = "You Can Only Demolish A Number Of Vehicles.<br />You Can Keep Everything You Demolish For Yourself As Long As You Dont Bother Me.<br /><br /><strong>Vehicle List:</strong><br />".. vehicleList,
				button = {}
			})
		end)
	else
		QBCore.Functions.Notify("You Are Not Allowed To Demolish Vehicles Now", "error")
	end
end


RegisterNetEvent('qb-scapyard:client:CreateListEmail', function()	
	CreateListEmail()
end)


function ScrapVehicle(vehicle)
	vehiclebeingscrapped = vehicle
	bonnettaken = false
	boottaken = false
	dooramount = 0
	doorsleft = 0
	wheelsleft = 0
	driverdoorf = false
	driverdoorr = false
	passengerdoorf = false
	passengerdoorr = false
	wheellf = false
	wheelrf = false
	wheellr = false
	wheelrr = false
	sixdoorcar = false
	fourdoorcar = false
	holdingprop = false
	carpart = nil


	local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false )
	TaskEveryoneLeaveVehicle(vehicle)
	dooramount = GetNumberOfVehicleDoors(vehicle)
	doorsleft = dooramount 
	wheelsleft = 4
	if dooramount == 6 then
		sixdoorcar = true
		scrapingcar = true
	elseif dooramount == 4 then
		fourdoorcar = true
		scrapingcar = true
	end
end


function IsVehicleValid(vehicleModel)
	local retval = false
	if Config.CurrentVehicles ~= nil and next(Config.CurrentVehicles) ~= nil then
		for k, v in pairs(Config.CurrentVehicles) do
			if Config.CurrentVehicles[k] ~= nil and GetHashKey(Config.CurrentVehicles[k]) == vehicleModel then
				retval = true
			end
		end
	end
	return retval
end


function GetVehicleKey(vehicleModel)
	local retval = 0
	if Config.CurrentVehicles ~= nil and next(Config.CurrentVehicles) ~= nil then
		for k, v in pairs(Config.CurrentVehicles) do
			if GetHashKey(Config.CurrentVehicles[k]) == vehicleModel then
				retval = k
			end
		end
	end
	return retval
end


function SetClosestScrapyard()
	local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
	for id, scrapyard in pairs(Config.Locations) do
		if current ~= nil then
			if #(pos - vector3(Config.Locations["main"].x, Config.Locations["main"].y, Config.Locations["main"].z)) < dist then
				current = id
				dist = #(pos - vector3(Config.Locations["main"].x, Config.Locations["main"].y, Config.Locations["main"].z))
			end
		else
			dist = #(pos - vector3(Config.Locations["main"].x, Config.Locations["main"].y, Config.Locations["main"].z))
			current = id
		end
	end
	closestScrapyard = current
end


RegisterNetEvent("lrp-scraping:client:removeparts", function(doortype, prop, x1, y1, z1, x2, y2, z2)
	if doortype == 0 then
		carpart = "driverdoorf"
	elseif doortype == 1 then
		carpart = "passengerdoorf"
	elseif doortype == 2 then
		carpart = "driverdoorr"
	elseif doortype == 3 then
		carpart = "passengerdoorr"
	elseif doortype == 4 then
		carpart = "bonnet"
	elseif doortype == 5 then
		carpart = "boot"
	end

	loadAnimDict("mini@repair")
    TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped" ,8.0, 8.0, -1, 81, 0, 0, 0, 0)

	SetVehicleDoorOpen(vehiclebeingscrapped, doortype, false, false)
	QBCore.Functions.Progressbar("scrap_vehicle", "Removing Vehicle Part", 27500, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		doorsleft = doorsleft - 1
		QBCore.Functions.Notify(doorsleft.. " Doors Left to Remove", "info")

		ClearPedTasksImmediately(PlayerPedId())
		local hash = GetHashKey(prop)
		local model = loadModel(hash)
		axe = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
		AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), x1, y1, z1, x2, y2, z2, false, true, false, true, 0, true)

		RequestAnimDict("anim@heists@box_carry@")
   	 	while (not HasAnimDictLoaded("anim@heists@box_carry@")) do Citizen.Wait(0) end
    	TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 50000000, 51, 0, false, false, false)
		
		TriggerServerEvent("qb-scrapyard:server:removedoor", vehiclebeingscrapped, doortype)
		holdingprop = true
	end, function() -- Cancel
		QBCore.Functions.Notify("Canceled", "error")
	end)
end)


RegisterNetEvent("lrp-scraping:client:removedoor", function(vehiclebeingscrapped,doortype)
    SetVehicleDoorBroken(vehiclebeingscrapped, doortype, true)
end)


RegisterNetEvent("lrp-scraping:client:removewheels", function(wheelno)
	carpart = "tire"

	TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_KNEEL", -1, true)
	Wait(3000)
	ExecuteCommand('e mechanic')

	QBCore.Functions.Progressbar("scrap_vehicle", "Removing Vehicle Tire", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		wheelsleft = wheelsleft - 1
		QBCore.Functions.Notify(wheelsleft.. " Wheels Left to Remove", "info")
		ClearPedTasks(PlayerPedId())

		local hash = GetHashKey('prop_wheel_tyre')
		local model = loadModel(hash)
		axe = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)

		AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.25, 0.0, 0.2, -90.0, 280.0, 40.0, false, true, false, true, 0, true)

		RequestAnimDict("anim@heists@box_carry@")
   	 	while (not HasAnimDictLoaded("anim@heists@box_carry@")) do Citizen.Wait(0) end
    	TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 50000000, 51, 0, false, false, false)

		SetVehicleTyreBurst(vehiclebeingscrapped, wheelno, true, 1000)
		holdingprop = true
	end, function() -- Cancel
		QBCore.Functions.Notify("Canceled", "error")
	end)
end)


Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1000)
		while scrapingcar do	
			Citizen.Wait(2000)
				local ped = PlayerPedId()
    			local pos = GetEntityCoords(ped)
    			local closestVehicle = QBCore.Functions.GetClosestVehicle(vector3(pos.x, pos.y, pos.z))
				local vehiclePlate2 = QBCore.Functions.GetPlate(closestVehicle)

				exports['lrp-target']:AddTargetBone('bonnet', { 
					options = { 
					{ 
						type = "client", 
						icon = 'fas fa-car',
						label = 'Bonnet', 
						action = function() 		
							TriggerEvent('lrp-scraping:client:removeparts', 4, 'imp_prop_impexp_trunk_02a', 0.25, -0.3, 0.2, -90.0, 280.0, 300.0) 
							bonnettaken = true
						end,
						canInteract = function()
							if not bonnettaken and inScrapYard and not holdingprop and vehiclePlate == vehiclePlate2 then
							return true
							else
							return false
							end
						end,
					}
					},
					distance = 2.3, 
				})

				exports['lrp-target']:AddTargetBone("boot", { 
					options = { 
					{ 
						type = "client", 
						icon = 'fas fa-car',
						label = 'Boot', 
						action = function() 		
							TriggerEvent('lrp-scraping:client:removeparts', 5, 'imp_prop_impexp_trunk_01a', 0.25, -0.3, 0.2, -90.0, 280.0, 300.0) 
							boottaken = true
						end,
						canInteract = function()
							if not boottaken and inScrapYard and not holdingprop and vehiclePlate == vehiclePlate2 then
							return true
							else
							return false
							end
						end,
					}
					},
					distance = 2.3, 
				})

				exports['lrp-target']:AddTargetBone("seat_dside_f", { 
					options = { 
					{ 
						type = "client", 
						icon = 'fas fa-car',
						label = 'Driver Door Front', 
						action = function() 		
							TriggerEvent('lrp-scraping:client:removeparts', 0, 'prop_car_door_01', 0.45, -0.3, 0.2, -90.0, 280.0, 40.0) 
							driverdoorf = true
						end,
						canInteract = function()
							if not driverdoorf and inScrapYard and not holdingprop and vehiclePlate == vehiclePlate2 then
							return true
							else
							return false
							end
						end,
					}
					},
					distance = 2.3, 
				})

				exports['lrp-target']:AddTargetBone("seat_dside_r", { 
					options = { 
					{ 
						type = "client", 
						icon = 'fas fa-car',
						label = 'Driver Door Rear', 
						action = function() 		
							TriggerEvent('lrp-scraping:client:removeparts', 2, 'prop_car_door_03', 0.45, -0.3, 0.2, -90.0, 280.0, 40.0) 
							driverdoorr = true
						end,
						canInteract = function()
							if not driverdoorr and inScrapYard and not holdingprop and vehiclePlate == vehiclePlate2 then
							return true
							else
							return false
							end
						end,
					}
					},
					distance = 2.3, 
				})

				exports['lrp-target']:AddTargetBone("seat_pside_f", { 
					options = { 
					{ 
						type = "client", 
						icon = 'fas fa-car',
						label = 'Passenger Door Front', 
						action = function() 		
							TriggerEvent('lrp-scraping:client:removeparts', 1, 'prop_car_door_01', 0.45, -0.3, 0.2, -90.0, 280.0, 40.0) 
							passengerdoorf = true
						end,
						canInteract = function()
							if not passengerdoorf and inScrapYard and not holdingprop and vehiclePlate == vehiclePlate2 then
							return true
							else
							return false
							end
						end,
					}
					},
					distance = 2.3, 
				})

				exports['lrp-target']:AddTargetBone("seat_pside_r", { 
					options = { 
					{ 
						type = "client", 
						icon = 'fas fa-car',
						label = 'Passenger Door Rear', 
						action = function() 		
							TriggerEvent('lrp-scraping:client:removeparts', 3, 'prop_car_door_03', 0.45, -0.3, 0.2, -90.0, 280.0, 40.0) 
							passengerdoorr = true
						end,
						canInteract = function()
							if not passengerdoorr and inScrapYard and not holdingprop and vehiclePlate == vehiclePlate2 then
							return true
							else
							return false
							end
						end,
					}
					},
					distance = 2.3, 
				})

				exports['lrp-target']:AddTargetBone("wheel_lf", { 
					options = { 
					{ 
						type = "client", 
						icon = 'fas fa-gear',
						label = 'Front Left Wheel', 
						action = function() 		
							TriggerEvent('lrp-scraping:client:removewheels', 0) 
							wheellf = true
						end,
						canInteract = function()
							if not wheellf and inScrapYard and not holdingprop and vehiclePlate == vehiclePlate2 then
								return true
							else
								return false
							end
						end,
					}
					},
					distance = 1.3, 
				})

				exports['lrp-target']:AddTargetBone("wheel_rf", { 
					options = { 
					{ 
						type = "client", 
						icon = 'fas fa-gear',
						label = 'Front Right Wheel', 
						action = function() 		
							TriggerEvent('lrp-scraping:client:removewheels', 1) 
							wheelrf = true
						end,
						canInteract = function()
							if not wheelrf and inScrapYard and not holdingprop and vehiclePlate == vehiclePlate2 then
								return true
							else
								return false
							end
						end,
					}
					},
					distance = 1.3, 
				})

				exports['lrp-target']:AddTargetBone("wheel_lr", { 
					options = { 
					{ 
						type = "client", 
						icon = 'fas fa-gear',
						label = 'Rear Left Wheel', 
						action = function() 		
							TriggerEvent('lrp-scraping:client:removewheels', 4) 
							wheellr = true
						end,
						canInteract = function()
							if not wheellr and inScrapYard and not holdingprop and vehiclePlate == vehiclePlate2 then
							return true
							else
							return false
							end
						end,
					}
					},
					distance = 1.3, 
				})

				exports['lrp-target']:AddTargetBone("wheel_rr", { 
					options = { 
					{ 
						type = "client", 
						icon = 'fas fa-gear',
						label = 'Rear Right Wheel', 
						action = function() 		
							TriggerEvent('lrp-scraping:client:removewheels', 5) 
							wheelrr = true
						end,
						canInteract = function()
							if not wheelrr and inScrapYard and not holdingprop and vehiclePlate == vehiclePlate2 then
							return true
							else
							return false
							end
						end,
					}
					},
					distance = 1.3, 
				})
		end
	end
end)


loadModel = function(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end


function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end


CreateThread(function() 
    for k=1, #Config.Locations["deliver"] do
		scrapyards[k] = BoxZone:Create(Config.Locations["deliver"][k], 24.0, 25.0, {
			name="ScrapYard"..k,
			offset={0.0, 0.0, 0.0},
			scale={1.0, 1.0, 1.0},
			minZ = 	Config.Locations["deliver"][k].z-2.0,
			maxZ = Config.Locations["deliver"][k].z+5.0,
			heading = Config.Locations["deliver"][k].w,
			debugPoly=false,
		})
		scrapyards[k]:onPlayerInOut(function(isPointInside)
			if isPointInside then
				local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
				if IsPedInAnyVehicle(PlayerPedId()) and GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
					exports['textUi']:DrawTextUi('show', "[E] To scrap vehicle") 
					inScrapYard = true
				end
			else
				inScrapYard = false
				scraping = false
				exports['textUi']:HideTextUi('hide')
			end
		end)
    end
end)


RegisterNetEvent('lrp-scrapyard:client:sellcar', function()
    local ped = PlayerPedId()
	
	if vehiclebeingscrapped ~= nil then
		QBCore.Functions.Progressbar("scrap_vehicle", "Handing over vehicle keys", 4000, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function() -- Done
			loadAnimDict("gestures@f@standing@casual")
			TaskPlayAnim(ped, "gestures@f@standing@casual", "gesture_point", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
			Wait(650)
			ClearPedTasks(ped)
			NetworkFadeOutEntity(vehiclebeingscrapped,slow)
			Wait(2000)
			QBCore.Functions.DeleteVehicle(vehiclebeingscrapped)
			vehiclebeingscrapped = nil
			TriggerServerEvent('lrp-scrapyard:server:sellcar')
		end, function() -- Cancel
			QBCore.Functions.Notify("Canceled", "error")
		end)
    else
        QBCore.Functions.Notify("There is no current vehicle being scrapped!!", "error", 2500)
    end
end)


RegisterNetEvent("lrp-scrapyard:client:sellpart", function()
	if carpart ~= nil then
		QBCore.Functions.Progressbar("scrap_vehicle", "Selling part", 3000, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function() -- Done
			TriggerServerEvent('lrp-scrapyard:server:sellpart', carpart)
			carpart = nil
			ClearPedTasks(PlayerPedId())
			DeleteObject(axe)
			holdingprop = false
		end, function() -- Cancel
			QBCore.Functions.Notify("Canceled", "error")
		end)
	else
		QBCore.Functions.Notify("You dont have any vehicle parts to sell", "error")
	end
end)


RegisterNetEvent('lrp-scrapyard:client:sellmenu')
AddEventHandler('lrp-scrapyard:client:sellmenu', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Vehicle Scrapping",
			isMenuHeader = true
        },
        {
            header = "Sell Vehicle Part",
            txt = 'sell part you are holding',
            params = {
                event = "lrp-scrapyard:client:sellpart"
            }
        },
		{
            header = "Hand over vehicle to scrapyard",
            txt = 'Let the scrapyard take care of the scrapped car',
            params = {
                event = "lrp-scrapyard:client:sellcar"
            }
        },
		{
            header = "⬅ Close Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)


exports['lrp-target']:AddTargetModel(`cs_nigel`, {
    options = {
        {
            event = "qb-scapyard:client:CreateListEmail",
            icon = "fas fa-car",
            label = "Get Vehicle Scrap List",
			canInteract = function()
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)
    			local pedpos2 = #(pos - vector3(2728.19, 4144.85, 44.29))

				if pedpos2 <= 5.0 then
				return true
				else
				return false
				end
			end,
        },
    },
    distance = 5.0
})


exports['lrp-target']:AddTargetModel(`cs_old_man2`, {
    options = {
        {
            event = "lrp-scrapyard:client:sellmenu",
            icon = "fas fa-car",
            label = "Sell vehicle part",
			canInteract = function()
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)
    			local pedpos2 = #(pos - vector3(2340.72, 3126.48, 48.21))

				if pedpos2 <= 6.0 then
					return true
				else
					return false
				end
			end,
        },
    },
    distance = 6.0
})
