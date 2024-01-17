local QBCore = exports['lrp-core']:GetCoreObject()
local currentHouseGarage = nil
local hasGarageKey = nil
local currentGarage = nil
local currentJobGarage = nil
local currentGangGarage = nil
local OutsideVehicles = {}
local PlayerData = {}
local PlayerGang = {}
local PlayerJob = {}
local garages = {}
local previewvehicle = nil


AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    PlayerGang = PlayerData.gang
    PlayerJob = PlayerData.job
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang)
    PlayerGang = gang
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerJob = job
end)




RegisterNetEvent('qb-garages:client:setHouseGarage', function(house, hasKey)
    currentHouseGarage = house
    hasGarageKey = hasKey
end)

RegisterNetEvent('qb-garages:client:houseGarageConfig', function(garageConfig)
    HouseGarages = garageConfig
end)

RegisterNetEvent('qb-garages:client:addHouseGarage', function(house, garageInfo)
    HouseGarages[house] = garageInfo
end)
















-- Functions

local DrawText3Ds = function(x, y, z, text)
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

local function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

local function MenuGarage()
    exports['lrp-menu']:openMenu({
        {
            header = "Public Garage",
            isMenuHeader = true
        },
        {
            header = "My Vehicles",
            txt = "View your stored vehicles!",
            params = {
                event = "qb-garages:client:VehicleList"
            }
        },
        {
            header = "⬅ Leave Garage",
            txt = "",
            params = {
                event = "lrp-menu:closeMenu"
            }
        },
    })
end

local function GangMenuGarage()
    exports['lrp-menu']:openMenu({
        {
            header = "Gang Garage",
            isMenuHeader = true
        },
        {
            header = "My Vehicles",
            txt = "View your stored vehicles!",
            params = {
                event = "qb-garages:client:GangVehicleList"
            }
        },
        {
            header = "⬅ Leave Garage",
            txt = "",
            params = {
                event = "lrp-menu:closeMenu"
            }
        },
    })
end

local function JobMenuGarage()
    exports['lrp-menu']:openMenu({
        {
            header = "Job Garage",
            isMenuHeader = true
        },
        {
            header = "Job Vehicles",
            txt = "View stored vehicles!",
            params = {
                event = "qb-garages:client:JobVehicleList"
            }
        },
        {
            header = "Personal Job Vehicles",
            txt = "View stored vehicles!",
            params = {
                event = "qb-garages:client:PersonalJobVehicleList"
            }
        },
        {
            header = "⬅ Leave Garage",
            txt = "",
            params = {
                event = "lrp-menu:closeMenu"
            }
        },
    })
end

local function MenuDepot()
    exports['lrp-menu']:openMenu({
        {
            header = "Impound",
            isMenuHeader = true
        },
        {
            header = "My Vehicles",
            txt = "View your impounded vehicles!",
            params = {
                event = "qb-garages:client:DepotList"
            }
        },
        {
            header = "⬅ Leave Depot",
            txt = "",
            params = {
                event = "lrp-menu:closeMenu"
            }
        },
    })
end

local function MenuHouseGarage(house)
    exports['lrp-menu']:openMenu({
        {
            header = "House Garage",
            isMenuHeader = true
        },
        {
            header = "My Vehicles",
            txt = "View your stored vehicles!",
            params = {
                event = "qb-garages:client:HouseGarage",
                args = house
            }
        },
        {
            header = "⬅ Leave Garage",
            txt = "",
            params = {
                event = "lrp-menu:closeMenu"
            }
        },
    })
end

local function ClearMenu()
	TriggerEvent("lrp-menu:closeMenu")
end

local function closeMenuFull()
    currentGarage = nil
    ClearMenu()
end

local function doCarDamage(currentVehicle, veh)

	smash = false
	damageOutside = false
	damageOutside2 = false
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0
	if engine < 200.0 then
		engine = 200.0
    end

    if engine > 1000.0 then
        engine = 1000.0
    end

	if body < 150.0 then
		body = 150.0
	end
	if body < 900.0 then
		smash = true
	end

	if body < 800.0 then
		damageOutside = true
	end

	if body < 500.0 then
		damageOutside2 = true
	end

    Wait(100)
    SetVehicleEngineHealth(currentVehicle, engine)
	if smash then
		SmashVehicleWindow(currentVehicle, 0)
		SmashVehicleWindow(currentVehicle, 1)
		SmashVehicleWindow(currentVehicle, 2)
		SmashVehicleWindow(currentVehicle, 3)
		SmashVehicleWindow(currentVehicle, 4)
	end
	if damageOutside then
		SetVehicleDoorBroken(currentVehicle, 1, true)
		SetVehicleDoorBroken(currentVehicle, 6, true)
		SetVehicleDoorBroken(currentVehicle, 4, true)
	end
	if damageOutside2 then
		SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	end
	if body < 1000 then
		SetVehicleBodyHealth(currentVehicle, 985.1)
	end
end

local function CheckPlayers(vehicle)
    for i = -1, 5,1 do
        seat = GetPedInVehicleSeat(vehicle,i)
        if seat ~= 0 then
            TaskLeaveVehicle(seat,vehicle,0)
            SetVehicleDoorsLocked(vehicle)
            Wait(1500)
            QBCore.Functions.DeleteVehicle(vehicle)
        end
   end
end














-- Events
RegisterNetEvent("qb-garage:client:garagemenu", function()
    JobMenuGarage()
end) 

RegisterNetEvent('opendepo')
AddEventHandler('opendepo', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local inGarageRange = false
    for k, v in pairs(Depots) do
        --local depottakeDist = #(pos - vector3(Depots[k].takeVehicle.x, Depots[k].takeVehicle.y, Depots[k].takeVehicle.z))
        --if depottakeDist <= 15 then
            inGarageRange = true
            --if IsControlJustPressed(0, 38) then
                MenuDepot()
                currentGarage = k
            -- end
        --end
    end
end)



RegisterNetEvent('qb-garages:client:takeOutDepot', function(vehicle, garage)
    if OutsideVehicles and next(OutsideVehicles) then
        if DoesEntityExist(OutsideVehicles[vehicle.plate]) then
            QBCore.Functions.Notify("Your vehicle is on the street's somwhere!", "error", 2500)       
        elseif OutsideVehicles[vehicle.plate] then
            local Engine = GetVehicleEngineHealth(OutsideVehicles[vehicle.plate])
            QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
                QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                    QBCore.Functions.SetVehicleProperties(veh, properties)
                    enginePercent = round(vehicle.engine / 10, 0)
                    bodyPercent = round(vehicle.body / 10, 0)
                    currentFuel = vehicle.fuel

                    if vehicle.plate then
                        DeleteVehicle(OutsideVehicles[vehicle.plate])
                        OutsideVehicles[vehicle.plate] = veh
                        TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                    end
                    networkid = NetworkGetNetworkIdFromEntity(veh)
                    SetNetworkIdExistsOnAllMachines(networkid, true)
                    SetNetworkIdCanMigrate(networkid, true)
                    SetVehicleNumberPlateText(veh, vehicle.plate)
                    SetEntityHeading(veh, 417.30)
                    exports['lrp-notify']:Alert("Depot", "Your vehicle has been parked outside!", '5000', 'info')
                    exports['cdn-fuel']:SetFuel(veh, vehicle.fuel)
                    SetEntityAsMissionEntity(veh, true, true)
                    doCarDamage(veh, vehicle)
                    TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                    closeMenuFull()
                    SetVehicleEngineOn(veh, true, true)
                end, vehicle.plate)
                TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate)
            end, garage, true)
            SetTimeout(250, function()
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(GetVehiclePedIsIn(PlayerPedId(), false)))
            end)
        else
            QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
                QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                    QBCore.Functions.SetVehicleProperties(veh, properties)
                    enginePercent = round(vehicle.engine / 10, 0)
                    bodyPercent = round(vehicle.body / 10, 0)
                    currentFuel = vehicle.fuel

                    if vehicle.plate then
                        OutsideVehicles[vehicle.plate] = veh
                        TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                    end
                    networkid = NetworkGetNetworkIdFromEntity(veh)
                    SetNetworkIdExistsOnAllMachines(networkid, true)
                    SetNetworkIdCanMigrate(networkid, true)
                    SetVehicleNumberPlateText(veh, vehicle.plate)
                    SetEntityHeading(veh, 417.30)
                    exports['lrp-notify']:Alert("Depot", "Your vehicle has been parked outside!", '5000', 'info')
                    exports['cdn-fuel']:SetFuel(veh, vehicle.fuel)
                    SetEntityAsMissionEntity(veh, true, true)
                    doCarDamage(veh, vehicle)
                    TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                    closeMenuFull()
                    SetVehicleEngineOn(veh, true, true)
                end, vehicle.plate)
                TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate)
            end, garage, true)
            SetTimeout(250, function()
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(GetVehiclePedIsIn(PlayerPedId(), false)))
            end)
        end
    else
        QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
            QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                QBCore.Functions.SetVehicleProperties(veh, properties)
                enginePercent = round(vehicle.engine / 10, 0)
                bodyPercent = round(vehicle.body / 10, 0)
                currentFuel = vehicle.fuel

                if vehicle.plate then
                    OutsideVehicles[vehicle.plate] = veh
                    TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                end
                networkid = NetworkGetNetworkIdFromEntity(veh)
                SetNetworkIdExistsOnAllMachines(networkid, true)
                SetNetworkIdCanMigrate(networkid, true)
                SetVehicleNumberPlateText(veh, vehicle.plate)
                SetEntityHeading(veh, 417.30)
                --TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                exports['lrp-notify']:Alert("Depot", "Your vehicle has been parked outside!", '5000', 'info')
                exports['cdn-fuel']:SetFuel(veh, vehicle.fuel)
                SetEntityAsMissionEntity(veh, true, true)
                doCarDamage(veh, vehicle)
                TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                closeMenuFull()
                SetVehicleEngineOn(veh, true, true)
            end, vehicle.plate)
            TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate)
        end, garage, true)
        SetTimeout(250, function()
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(GetVehiclePedIsIn(PlayerPedId(), false)))
        end)
    end
end)

RegisterNetEvent("qb-garages:client:HouseGarage", function(house)
    QBCore.Functions.TriggerCallback("qb-garage:server:GetHouseVehicles", function(result)
        if result == nil then
            QBCore.Functions.Notify("You don't have any vehicles in your garage!", "error", 5000)
        else
            local MenuHouseGarageOptions = {
                {
                    header = "Garage: "..HouseGarages[house].label,
                    isMenuHeader = true
                },
            }

            for k, v in pairs(result) do
                enginePercent = round(v.engine / 10, 0)
                bodyPercent = round(v.body / 10, 0)
                currentFuel = v.fuel
                curGarage = HouseGarages[house].label
                if QBCore.Shared.Vehicles[v.vehicle] then
                    vname = QBCore.Shared.Vehicles[v.vehicle].name  
                else 
                    vname = 'Vehicle not in shared, please report to dev! Vehicle = '..v.vehicle
                end

                if v.state == 0 then
                    v.state = "Out"
                elseif v.state == 1 then
                    v.state = "Garaged"
                elseif v.state == 2 then
                    v.state = "Impounded By Police"
                end

                MenuHouseGarageOptions[#MenuHouseGarageOptions+1] = {
                    header = vname.." ["..v.plate.."]",
                    txt = "State: "..v.state.. "<br>Fuel: "..currentFuel.." | Engine: "..enginePercent.." | Body: "..bodyPercent,
                    params = {
                        event = "qb-garages:client:TakeOutHouseGarage",
                        args = v
                    }
                }
            end

            MenuHouseGarageOptions[#MenuHouseGarageOptions+1] = {
                header = "⬅ Leave Garage",
                txt = "",
                params = {
                    event = "lrp-menu:closeMenu",
                }
            }
            exports['lrp-menu']:openMenu(MenuHouseGarageOptions)
        end
    end, house)
end)





RegisterNetEvent("qb-garages:client:DepotList", function()
    QBCore.Functions.TriggerCallback("qb-garage:server:GetDepotVehicles", function(result)
        if result == nil then
            QBCore.Functions.Notify("You don't have any impounded vehicles!", "error", 5000)
        else
            local MenuDepotOptions = {
                {
                    header = "Depot: "..Depots[currentGarage].label,
                    isMenuHeader = true
                },
            }
            for k, v in pairs(result) do
                enginePercent = round(v.engine / 10, 0)
                bodyPercent = round(v.body / 10, 0)
                currentFuel = v.fuel
                if QBCore.Shared.Vehicles[v.vehicle] then
                    vname = QBCore.Shared.Vehicles[v.vehicle].name  
                else 
                    vname = 'Vehicle not in shared, please report to dev! Vehicle = '..v.vehicle
                end

                if v.state == 0 then
                    v.state = "Impound"
                end

                MenuDepotOptions[#MenuDepotOptions+1] = {
                    header = vname.." [$"..v.depotprice.."]",
                    txt = "Plate: "..v.plate.."<br>Fuel: "..currentFuel.." | Engine: "..enginePercent.." | Body: "..bodyPercent,
                    params = {
                        event = "qb-garages:client:TakeOutDepotVehicle",
                        args = v
                    }
                }
            end

            MenuDepotOptions[#MenuDepotOptions+1] = {
                header = "⬅ Leave Depot",
                txt = "",
                params = {
                    event = "lrp-menu:closeMenu",
                }
            }
            exports['lrp-menu']:openMenu(MenuDepotOptions)
        end
    end)
end)

RegisterNetEvent("qb-garages:client:VehicleList", function()
    QBCore.Functions.TriggerCallback("qb-garage:server:GetUserVehicles", function(result)
        if result == nil then
            QBCore.Functions.Notify("You don't have any vehicles in this garage!", "error", 5000)
        else
            local MenuPublicGarageOptions = {
                {
                    header = "Garage: "..Garages[currentGarage].label,
                    isMenuHeader = true
                },
            }
            for k, v in pairs(result) do
                enginePercent = round(v.engine / 10, 0)
                bodyPercent = round(v.body / 10, 0)
                currentFuel = v.fuel
                curGarage = Garages[v.garage].label
                if QBCore.Shared.Vehicles[v.vehicle] then
                    vname = QBCore.Shared.Vehicles[v.vehicle].name  
                else 
                    vname = 'Vehicle not in shared, please report to dev! Vehicle = '..v.vehicle
                end
                

                if v.state == 0 then
                    v.state = "Out"
                elseif v.state == 1 then
                    v.state = "Garaged"
                elseif v.state == 2 then
                    v.state = "Impounded By Police"
                end

                MenuPublicGarageOptions[#MenuPublicGarageOptions+1] = {
                    header = vname.." ["..v.plate.."]",
                    txt = "State: "..v.state.." <br>Fuel: "..currentFuel.." | Engine: "..enginePercent.." | Body: "..bodyPercent,
                    params = {
                        event = "qb-garages:client:takeOutPublicGarage",
                        args = v,
                    }
                }
            end

            MenuPublicGarageOptions[#MenuPublicGarageOptions+1] = {
                header = "⬅ Leave Garage",
                txt = "",
                params = {
                    event = "lrp-menu:closeMenu",
                }
            }
            exports['lrp-menu']:openMenu(MenuPublicGarageOptions)
        end
    end, currentGarage)
end)


RegisterNetEvent("qb-garages:client:GangVehicleList", function()
    QBCore.Functions.TriggerCallback("qb-garage:server:GetGangVehicles", function(result)
        if result == nil then
            QBCore.Functions.Notify("You don't have any vehicles in this garage!", "error", 5000)
        else
            local MenuGangGarageOptions = {
                {
                    header = "Garage: "..GangGarages[currentGangGarage].label,
                    isMenuHeader = true
                },
            }
            for k, v in pairs(result) do
                enginePercent = round(v.engine / 10, 0)
                bodyPercent = round(v.body / 10, 0)
                currentFuel = v.fuel
                curGarage = GangGarages[v.garage].label
                if QBCore.Shared.Vehicles[v.vehicle] then
                    vname = QBCore.Shared.Vehicles[v.vehicle].name  
                else 
                    vname = 'Vehicle not in shared, please report to dev! Vehicle = '..v.vehicle
                end
               
                if v.state == 0 then
                    v.state = "Out"
                elseif v.state == 1 then
                    v.state = "Garaged"
                elseif v.state == 2 then
                    v.state = "Impounded By Police"
                end

                MenuGangGarageOptions[#MenuGangGarageOptions+1] = {
                    header = vname.." ["..v.plate.."]",
                    txt = "State: "..v.state.."<br>Fuel: "..currentFuel.." | Engine: "..enginePercent.." | Body: "..bodyPercent,
                    params = {
                        event = "qb-garages:client:takeOutGangGarage",
                        args = v
                    }
                }
            end

            MenuGangGarageOptions[#MenuGangGarageOptions+1] = {
                header = "⬅ Leave Garage",
                txt = "",
                params = {
                    event = "lrp-menu:closeMenu",
                }
            }
            exports['lrp-menu']:openMenu(MenuGangGarageOptions)
        end
    end, currentGangGarage)
end)




RegisterNetEvent("qb-garages:client:jobvehiclemenuextra", function(vehicle)
    exports['lrp-menu']:openMenu({
        {
            header = "⬅ Go Back",
            params = {
                event = "qb-garages:client:jobgoback",
                args = vehicle
            }
        },
        {
            header = "Take Out Vehicle",
            params = {
                event = "qb-garages:client:takeoutjob",
                args = vehicle
            }
        },
        {   
            header = "Rename Vehicle",
            params = {
                event = "qb-garage:client:changevehiclename",
                args = vehicle
            }
        },
    })

end)

RegisterNetEvent("qb-garages:client:jobvehiclemenuextrapersonal", function(vehicle)
    exports['lrp-menu']:openMenu({
        {
            header = "⬅ Go Back",
            params = {
                event = "qb-garages:client:personaljobgoback",
                args = vehicle
            }
        },
        {
            header = "Take Out Vehicle",
            params = {
                event = "qb-garages:client:takeoutjob",
                args = vehicle
            }
        },
        {   
            header = "Rename Vehicle",
            params = {
                event = "qb-garage:client:changevehiclename2",
                args = vehicle
            }
        },
    })
end)




RegisterNetEvent("qb-garages:client:takeoutjob", function(vehicle)
    TriggerEvent("qb-garages:client:takeoutdeletepreview", vehicle)
end)


RegisterNetEvent("qb-garages:client:jobgoback", function(vehicle)
    TriggerEvent("qb-garages:client:JobVehicleList", vehicle)
    TriggerEvent("qb-garages:client:deletepreview", vehicle)
end)

RegisterNetEvent("qb-garages:client:personaljobgoback", function(vehicle)
    TriggerEvent("qb-garages:client:PersonalJobVehicleList", vehicle)
    TriggerEvent("qb-garages:client:deletepreview", vehicle)
end)

RegisterNetEvent("qb-garages:client:openjobvehiclemenuextra", function(vehicle)
    TriggerEvent('qb-garages:client:jobvehiclemenuextra', vehicle)
    TriggerEvent("qb-garages:client:preview", vehicle)
end)

RegisterNetEvent("qb-garages:client:openpersonaljobvehiclemenuextra", function(vehicle)
    TriggerEvent('qb-garages:client:jobvehiclemenuextrapersonal', vehicle)
    TriggerEvent("qb-garages:client:preview", vehicle)
end)

RegisterNetEvent('qb-garage:client:changevehiclename')
AddEventHandler('qb-garage:client:changevehiclename', function(vehicle)
    local result = LocalInput('Rename Vehicle', 40, '')
    if result ~= nil then
        TriggerServerEvent('qb-garage:server:changevehiclename', result, vehicle.plate )
        TriggerEvent('qb-garages:client:jobvehiclemenuextra', vehicle)
    end
end)

RegisterNetEvent('qb-garage:client:changevehiclename2')
AddEventHandler('qb-garage:client:changevehiclename2', function(vehicle)
    local result = LocalInput('Rename Vehicle', 40, '')
    if result ~= nil then
        TriggerServerEvent('qb-garage:server:changevehiclename', result, vehicle.plate )
        TriggerEvent('qb-garages:client:jobvehiclemenuextrapersonal', vehicle)
    end
end)





RegisterNetEvent("qb-garages:client:PersonalJobVehicleList", function()
    QBCore.Functions.TriggerCallback("qb-garage:server:GetUserVehicles2", function(result)
        if result == nil then
            QBCore.Functions.Notify("You don't have any vehicles in this garage!", "error", 5000)
        else
            local MenuJobGarageOptions = {
                {
                    header = "Garage: "..JobGarages[currentJobGarage].label,
                    isMenuHeader = true
                },
            }
            for k, v in pairs(result) do
                currentName = v.garagename
                enginePercent = round(v.engine / 10, 0)
                bodyPercent = round(v.body / 10, 0)
                currentFuel = v.fuel
                curGarage = JobGarages[v.garage].label
                if QBCore.Shared.Vehicles[v.vehicle] then
                    vname = QBCore.Shared.Vehicles[v.vehicle].name  
                else 
                    vname = 'Vehicle not in shared, please report to dev! Vehicle = '..v.vehicle
                end
                if v.jobstate == 0 then
                    v.jobstate = "Out"
                elseif v.jobstate == 1 then
                    v.jobstate = "Garaged"
                elseif v.jobstate == 2 then
                    v.jobstate = "Impounded By Police"
                end

                MenuJobGarageOptions[#MenuJobGarageOptions+1] = {
                    header = currentName,
                    txt = "State: "..v.jobstate.."<br>Plate: "..v.plate.." | Fuel: "..currentFuel.."<br>Engine: "..enginePercent.." | Body: "..bodyPercent ,
                    params = {
                        event = "qb-garages:client:openpersonaljobvehiclemenuextra",
                        args = v,
                    }
                }
            end

            MenuJobGarageOptions[#MenuJobGarageOptions+1] = {
                header = "⬅ Go Back",
                txt = "",
                params = {
                    event = "qb-garage:client:garagemenu",
                }
            }
            exports['lrp-menu']:openMenu(MenuJobGarageOptions)
        end
    end, currentJobGarage)
end)


RegisterNetEvent("qb-garages:client:JobVehicleList", function()
    QBCore.Functions.TriggerCallback("qb-garage:server:GetjobVehicles", function(result)
        if result == nil then
            QBCore.Functions.Notify("You don't have any vehicles in this garage!", "error", 5000)
        else
            local MenuJobGarageOptions = {
                {
                    header = "Garage: "..JobGarages[currentJobGarage].label,
                    isMenuHeader = true
                },
            }
            for k, v in pairs(result) do
                currentName = v.garagename
                enginePercent = round(v.engine / 10, 0)
                bodyPercent = round(v.body / 10, 0)
                currentFuel = v.fuel
                curGarage = JobGarages[v.garage].label
                if QBCore.Shared.Vehicles[v.vehicle] then
                    vname = QBCore.Shared.Vehicles[v.vehicle].name  
                else 
                    vname = 'Vehicle not in shared, please report to dev! Vehicle = '..v.vehicle
                end
                if v.jobstate == 0 then
                    v.jobstate = "Out"
                elseif v.jobstate == 1 then
                    v.jobstate = "Garaged"
                elseif v.jobstate == 2 then
                    v.jobstate = "Impounded By Police"
                end

                MenuJobGarageOptions[#MenuJobGarageOptions+1] = {
                    header = currentName,
                    txt = "State: "..v.jobstate.."<br>Plate: "..v.plate.." | Fuel: "..currentFuel.."<br>Engine: "..enginePercent.." | Body: "..bodyPercent ,
                    params = {
                        event = "qb-garages:client:openjobvehiclemenuextra",
                        args = v,
                    }
                }
            end

            MenuJobGarageOptions[#MenuJobGarageOptions+1] = {
                header = "⬅ Go Back",
                txt = "",
                params = {
                    event = "qb-garage:client:garagemenu",
                }
            }
            exports['lrp-menu']:openMenu(MenuJobGarageOptions)
        end
    end, currentJobGarage)
end)






-- job preview


local function trim(plate)
    if not plate then return nil end
    return (string.gsub(plate, '^%s*(.-)%s*$', '%1'))
end

RegisterNetEvent('qb-garages:client:preview', function(vehicle)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)


    for i=1, #JobGarages[currentJobGarage]["parking"] do
        local garage = #(pos - vector3(JobGarages[currentJobGarage]["parking"][i].x, JobGarages[currentJobGarage]["parking"][i].y, JobGarages[currentJobGarage]["parking"][i].z))
           
        if garage <= 3.5 then  
            if vehicle.jobstate == "Garaged" then
                enginePercent = round(vehicle.engine / 10, 1)
                bodyPercent = round(vehicle.body / 10, 1)
                local isclear = IsSpawnPointClear(vector3(JobGarages[currentJobGarage]["parking"][i].x, JobGarages[currentJobGarage]["parking"][i].y, JobGarages[currentJobGarage]["parking"][i].z), 3.0)
                if isclear then
                    QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
                        QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                            previewvehicle = veh
                            QBCore.Functions.SetVehicleProperties(veh, properties)
                            SetVehicleNumberPlateText(veh, "preview")
                            SetEntityHeading(veh, JobGarages[currentJobGarage]["parking"][i].w)
                            doCarDamage(veh, vehicle)
                            SetEntityAsMissionEntity(veh, true, true)
                            FreezeEntityPosition(veh,true)
                            SetVehicleDoorsLocked(veh, 3)
                            SetEntityInvincible(veh,true)
                            QBCore.Functions.Notify("You have spawned a preview vehicle", "info", 2500)
                        end, vehicle.plate)
                    end, JobGarages[currentJobGarage]["parking"][i], true)
                else
                    QBCore.Functions.Notify("Vehicle in the way!", "error", 2500)
                end    
            elseif vehicle.jobstate == "Out" then
                QBCore.Functions.Notify("Cant preview vehicle that is already out!", "error", 2500)
            elseif vehicle.jobstate == "Impound" then
                QBCore.Functions.Notify("This vehicle was impounded by the police!", "error", 4000)
            end
            break
        end
    end
end)


RegisterNetEvent('qb-garages:client:deletepreview', function(vehicle)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    if DoesEntityExist(previewvehicle) then
        NetworkFadeOutEntity(previewvehicle, true, false)
        Wait(1000)
        QBCore.Functions.DeleteVehicle(previewvehicle)
    end
end)


RegisterNetEvent('qb-garages:client:takeoutdeletepreview', function(vehicle)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    if DoesEntityExist(previewvehicle) then
        NetworkFadeOutEntity(previewvehicle, true, false)
        Wait(1000)
        QBCore.Functions.DeleteVehicle(previewvehicle)
        TriggerEvent("qb-garages:client:takeOutJobGarage", vehicle)
    end  
end)











-- spawn vehicles

RegisterNetEvent('qb-garages:client:takeOutPublicGarage', function(vehicle)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    for i=1, #Garages[currentGarage]["parking"] do
        local garage = #(pos - vector3(Garages[currentGarage]["parking"][i].x, Garages[currentGarage]["parking"][i].y, Garages[currentGarage]["parking"][i].z))

        if garage <= 2.2 then              
            if vehicle.state == "Garaged" then
                enginePercent = round(vehicle.engine / 10, 1)
                bodyPercent = round(vehicle.body / 10, 1)
                currentFuel = vehicle.fuel
                local isclear = IsSpawnPointClear(vector3(Garages[currentGarage]["parking"][i].x, Garages[currentGarage]["parking"][i].y, Garages[currentGarage]["parking"][i].z), 3.0)
                if isclear then
                    QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)  
                             
                        QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                            if vehicle.plate ~= nil then
                                OutsideVehicles[vehicle.plate] = veh
                                TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                            end
                            
                            QBCore.Functions.SetVehicleProperties(veh, properties)
                            networkid = NetworkGetNetworkIdFromEntity(veh)
                            SetNetworkIdExistsOnAllMachines(networkid, true)
                            SetNetworkIdCanMigrate(networkid, true)
                            SetVehicleNumberPlateText(veh, vehicle.plate)
                            SetEntityHeading(veh, Garages[currentGarage]["parking"][i].w)
                            exports['cdn-fuel']:SetFuel(veh, vehicle.fuel)
                            doCarDamage(veh, vehicle)
                            SetEntityAsMissionEntity(veh, true, true)
                            TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage) --up dates whether the car is out or not
                            closeMenuFull()
                            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                            TriggerEvent('qb-radial:client:vehiclelist', false)
                            TriggerEvent('qb-radial:client:parking', true)

                        end, vehicle.plate)
                    end, Garages[currentGarage]["parking"][i], true) 
                else
                    QBCore.Functions.Notify("Vehicle in the way!", "error", 2500)            
                end
            elseif vehicle.state == "Out" then
                QBCore.Functions.Notify("Is your vehicle in the Depot", "error", 2500)                
            elseif vehicle.state == "Impound" then
                QBCore.Functions.Notify("This vehicle was impounded by the Police", "error", 4000)          
            end
            break
        end  
    end 
end)


RegisterNetEvent('qb-garages:client:takeOutGangGarage', function(vehicle)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    
    for i=1, #GangGarages[currentGangGarage]["parking"] do
        local garage = #(pos - vector3(GangGarages[currentGangGarage]["parking"][i].x, GangGarages[currentGangGarage]["parking"][i].y, GangGarages[currentGangGarage]["parking"][i].z))


        if garage <= 6.5 then  
            QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleState', function(garaged)
                if garaged then
                    enginePercent = round(vehicle.engine / 10, 1)
                    bodyPercent = round(vehicle.body / 10, 1)
                    currentFuel = vehicle.fuel
                    local isclear = IsSpawnPointClear(vector3(GangGarages[currentGangGarage]["parking"][i].x, GangGarages[currentGangGarage]["parking"][i].y, GangGarages[currentGangGarage]["parking"][i].z), 3.0)
                    if isclear then
                        QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
                            QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)

                                if vehicle.plate then
                                    OutsideVehicles[vehicle.plate] = veh
                                    TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                                end

                                QBCore.Functions.SetVehicleProperties(veh, properties)
                                networkid = NetworkGetNetworkIdFromEntity(veh)
                                SetNetworkIdExistsOnAllMachines(networkid, true)
                                SetNetworkIdCanMigrate(networkid, true)
                                SetVehicleNumberPlateText(veh, vehicle.plate)
                                SetEntityHeading(veh, GangGarages[currentGangGarage]["parking"][i].w)
                                exports['cdn-fuel']:SetFuel(veh, vehicle.fuel)
                                doCarDamage(veh, vehicle)
                                SetEntityAsMissionEntity(veh, true, true)
                                TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                                closeMenuFull()
                                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                                SetVehicleEngineOn(veh, true, true)
                                TriggerEvent('qb-radial:client:gangvehiclelist', false)
                                TriggerEvent('qb-radial:client:gangparking', true)
                            end, vehicle.plate)

                        end, GangGarages[currentGangGarage]["parking"][i], true)
                    else
                        QBCore.Functions.Notify("Vehicle in the way!", "error", 2500)
                    end 
                elseif DoesEntityExist(OutsideVehicles[vehicle.plate]) then
                    QBCore.Functions.Notify("Your vehicle is on the street's somwhere!", "error", 2500)
                else
                    QBCore.Functions.Notify("Your vehicle may be in the depot!", "error", 2500)
                end
            end, vehicle.plate)
            break
        end
    end
end)



RegisterNetEvent('qb-garages:client:takeOutJobGarage', function(vehicle)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    for i=1, #JobGarages[currentJobGarage]["parking"] do
        local garage = #(pos - vector3(JobGarages[currentJobGarage]["parking"][i].x, JobGarages[currentJobGarage]["parking"][i].y, JobGarages[currentJobGarage]["parking"][i].z))
       
        if garage <= 3.5 then  
            if vehicle.jobstate == "Garaged" then
                enginePercent = round(vehicle.engine / 10, 1)
                bodyPercent = round(vehicle.body / 10, 1)
                currentFuel = vehicle.fuel
                local isclear = IsSpawnPointClear(vector3(JobGarages[currentJobGarage]["parking"][i].x, JobGarages[currentJobGarage]["parking"][i].y, JobGarages[currentJobGarage]["parking"][i].z), 3.0)
                if isclear then
                    QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
                        QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                            if vehicle.plate then
                                OutsideVehicles[vehicle.plate] = veh
                                TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                            end
                            QBCore.Functions.SetVehicleProperties(veh, properties)
                            networkid = NetworkGetNetworkIdFromEntity(veh)
                            SetNetworkIdExistsOnAllMachines(networkid, true)
                            SetNetworkIdCanMigrate(networkid, true)
                            SetVehicleNumberPlateText(veh, vehicle.plate)
                            SetEntityHeading(veh, JobGarages[currentJobGarage]["parking"][i].w)
                            exports['cdn-fuel']:SetFuel(veh, vehicle.fuel)
                            doCarDamage(veh, vehicle)
                            SetEntityAsMissionEntity(veh, true, true)
                            TriggerServerEvent('qb-garage:server:updateVehicleJobState', 0, vehicle.plate, vehicle.garage)
                            closeMenuFull()
                            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                            SetVehicleEngineOn(veh, true, true)
                            TriggerEvent('qb-radial:client:jobvehiclelist', false)
                            if vehicle.job == "personaljobveh" then 
                                TriggerEvent('qb-radial:client:personaljobparking', true)
                            else                   
                                TriggerEvent('qb-radial:client:jobparking', true)
                            end
                        end, vehicle.plate)
                    end, JobGarages[currentJobGarage]["parking"][i], true)
                else
                    QBCore.Functions.Notify("Vehicle in the way!", "error", 2500)              
                end         
            elseif vehicle.jobstate == "Out" then
                QBCore.Functions.Notify("This Vehicle is already Out!", "error", 2500)
            elseif vehicle.jobstate == "Impound" then
                QBCore.Functions.Notify("This vehicle was impounded by the police!", "error", 4000)            
            end
            break
        end

    end
end)




RegisterNetEvent('qb-garages:client:TakeOutDepotVehicle', function(vehicle)
    local impound1 = vector3(408.91, -1622.84, 29.29)
    local impound2 = vector3(-173.2, -1166.2, 22.62)
    local impound3 = vector3(-213.0, -1168.62, 22.62)
    local impound4 = vector3(-205.91, -1168.49, 22.62)
    local isclear = IsSpawnPointClear(vector3(408.91, -1622.84, 29.29), 3.0)
    local isclear2 = IsSpawnPointClear(vector3(-173.16, -1166.33, 22.62), 3.0)
    local isclear3 = IsSpawnPointClear(vector3(-213.0, -1168.62, 22.62), 3.0)
    local isclear4 = IsSpawnPointClear(vector3(-205.91, -1168.49, 22.62), 3.0)

    if vehicle.state == "Impound" then
        if isclear then    
            TriggerServerEvent("qb-garage:server:PayDepotPrice", vehicle, impound1)
        elseif isclear2 then
            TriggerServerEvent("qb-garage:server:PayDepotPrice", vehicle, impound2)
        elseif isclear3 then
            TriggerServerEvent("qb-garage:server:PayDepotPrice", vehicle, impound3)
        elseif isclear4 then
            TriggerServerEvent("qb-garage:server:PayDepotPrice", vehicle, impound4)
        else
            QBCore.Functions.Notify("Vehicle in the way!", "error", 2500)
        end 
    end


end)



RegisterNetEvent('qb-garages:client:TakeOutHouseGarage', function(vehicle)
    if vehicle.state == "Garaged" then
        QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
            QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                QBCore.Functions.SetVehicleProperties(veh, properties)
                enginePercent = round(vehicle.engine / 10, 1)
                bodyPercent = round(vehicle.body / 10, 1)
                currentFuel = vehicle.fuel

                if vehicle.plate then
                    OutsideVehicles[vehicle.plate] = veh
                    TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                end
                networkid = NetworkGetNetworkIdFromEntity(veh)
                SetNetworkIdExistsOnAllMachines(networkid, true)
                SetNetworkIdCanMigrate(networkid, true)
                SetVehicleNumberPlateText(veh, vehicle.plate)
                SetEntityHeading(veh, HouseGarages[currentHouseGarage].takeVehicle.h)
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                exports['cdn-fuel']:SetFuel(veh, vehicle.fuel)
                SetEntityAsMissionEntity(veh, true, true)
                doCarDamage(veh, vehicle)
                TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                closeMenuFull()
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                SetVehicleEngineOn(veh, true, true)
            end, vehicle.plate)
        end, HouseGarages[currentHouseGarage].takeVehicle, true)
    end
end)













-- finding what garage you are at and opening menu


RegisterNetEvent('qb-garages:client:takeoutvehicle')
AddEventHandler('qb-garages:client:takeoutvehicle', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local inGarageRange = false
    

    for k, v in pairs(Garages) do    
        for i=1, #Garages[k]["parking"] do
            local garage = #(pos - vector3(Garages[k]["parking"][i].x, Garages[k]["parking"][i].y, Garages[k]["parking"][i].z))

            if garage <= 6.0 then
                if not IsPedInAnyVehicle(ped) then
                    MenuGarage()
                    currentGarage = k
                end
            end  
        end

    end
end)



RegisterNetEvent('qb-garages:client:takeoutjobvehicle')
AddEventHandler('qb-garages:client:takeoutjobvehicle', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local inGarageRange = false
    
    for k, v in pairs(JobGarages) do    
        for i=1, #JobGarages[k]["parking"] do
            local garage = #(pos - vector3(JobGarages[k]["parking"][i].x, JobGarages[k]["parking"][i].y, JobGarages[k]["parking"][i].z))

            if garage <= 6.0 then
                if not IsPedInAnyVehicle(ped) then
                    JobMenuGarage()
                    currentJobGarage = k
                end
            end  
        end

    end
end)



RegisterNetEvent('qb-garages:client:takeoutgangvehicle')
AddEventHandler('qb-garages:client:takeoutgangvehicle', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local inGarageRange = false
    
    for k, v in pairs(GangGarages) do    
        for i=1, #GangGarages[k]["parking"] do
            local garage = #(pos - vector3(GangGarages[k]["parking"][i].x, GangGarages[k]["parking"][i].y, GangGarages[k]["parking"][i].z))

            if garage <= 6.0 then
                if not IsPedInAnyVehicle(ped) then
                    GangMenuGarage()
                    currentGangGarage = k
                end
            end  
        end

    end

end)









-- putting in vehicle 


RegisterNetEvent('qb-garages:client:putingangvehicle')
AddEventHandler('qb-garages:client:putingangvehicle', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local vehicleclose = QBCore.Functions.GetClosestVehicle(pos)
    local inGarageRange = false

    for k, v in pairs(GangGarages) do          
        for i=1, #GangGarages[k]["parking"] do
            local garage = #(pos - vector3(GangGarages[k]["parking"][i].x, GangGarages[k]["parking"][i].y, GangGarages[k]["parking"][i].z))

            if garage <= 6 then                 
                local plate = QBCore.Functions.GetPlate(vehicleclose)          
                QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleOwnergang', function(owned)                    
                    if DoesEntityExist(vehicleclose) and owned then            
                        local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicleclose))
                        local engineDamage = math.ceil(GetVehicleEngineHealth(vehicleclose))
                        local totalFuel = exports['cdn-fuel']:GetFuel(vehicleclose)
                        local passenger = GetVehicleMaxNumberOfPassengers(vehicleclose)
                        local vehProperties = QBCore.Functions.GetVehicleProperties(vehicleclose)
                        CheckPlayers(vehicleclose)
                        TriggerServerEvent('qb-garage:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, k)
                        TriggerServerEvent('qb-garage:server:updateVehicleState', 1, plate, k)
                        TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', vehProperties)   
                        TriggerEvent('qb-radial:client:gangvehiclelist', true)
                        TriggerEvent('qb-radial:client:gangparking', false)  

                        if plate  then
                            OutsideVehicles[plate] = veh
                            TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                        end
                        QBCore.Functions.Notify("Vehicle Parked", "primary", 4500)
                        Wait(500)
                        DeleteEntity(vehicleclose)
                        
                      
                    else
                        QBCore.Functions.Notify("Cant put this vehicle here", "error", 3500)
                    end 
                end, plate)
                

            end
        end
    end
    if not inGarageRange then
        Wait(1000)
    end
end)



RegisterNetEvent('qb-garages:client:putinvehicle')
AddEventHandler('qb-garages:client:putinvehicle', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local vehicleclose = QBCore.Functions.GetClosestVehicle(pos)
    local inGarageRange = false

    for k, v in pairs(Garages) do          
        for i=1, #Garages[k]["parking"] do
            local garage = #(pos - vector3(Garages[k]["parking"][i].x, Garages[k]["parking"][i].y, Garages[k]["parking"][i].z))

            if garage <= 4 then                 
                local plate = QBCore.Functions.GetPlate(vehicleclose)
                QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleOwner', function(owned)

                    if DoesEntityExist(vehicleclose) and owned then
                        local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicleclose))
                        local engineDamage = math.ceil(GetVehicleEngineHealth(vehicleclose))
                        local totalFuel = exports['cdn-fuel']:GetFuel(vehicleclose)
                        local passenger = GetVehicleMaxNumberOfPassengers(vehicleclose)
                        local vehProperties = QBCore.Functions.GetVehicleProperties(vehicleclose)
                        CheckPlayers(vehicleclose)
                        TriggerServerEvent('qb-garage:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, k)
                        TriggerServerEvent('qb-garage:server:updateVehicleState', 1, plate, k)
                        TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', vehProperties)
                        TriggerServerEvent('qb-garage:server:setjobstate', "none", plate) 
                        TriggerEvent('qb-radial:client:vehiclelist', true)
                        TriggerEvent('qb-radial:client:parking', false)
                        
                        if plate  then
                            OutsideVehicles[plate] = veh
                            TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                        end
                        QBCore.Functions.Notify("Vehicle Parked", "primary", 4500)
                        Wait(500)
                        DeleteEntity(vehicleclose)
                    else
                        QBCore.Functions.Notify("Vehicle not owned", "error", 3500)
                    end
                end, plate)
            end    
        end
    end
    if not inGarageRange then
        Wait(1000)
    end
end)



RegisterNetEvent('qb-garages:client:putinjobvehicle')
AddEventHandler('qb-garages:client:putinjobvehicle', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local vehicleclose = QBCore.Functions.GetClosestVehicle(pos)
    local inGarageRange = false

    for k, v in pairs(JobGarages) do          
        for i=1, #JobGarages[k]["parking"] do
            local garage = #(pos - vector3(JobGarages[k]["parking"][i].x, JobGarages[k]["parking"][i].y, JobGarages[k]["parking"][i].z))

            if garage <= 4 then                 
                local plate = QBCore.Functions.GetPlate(vehicleclose)
                QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleJob', function(owned)

                    if DoesEntityExist(vehicleclose) and owned then
                        local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicleclose))
                        local engineDamage = math.ceil(GetVehicleEngineHealth(vehicleclose))
                        local totalFuel = exports['cdn-fuel']:GetFuel(vehicleclose)
                        local passenger = GetVehicleMaxNumberOfPassengers(vehicleclose)
                        local vehProperties = QBCore.Functions.GetVehicleProperties(vehicleclose)
                        CheckPlayers(vehicleclose)
                        TriggerServerEvent('qb-garage:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, k)
                        TriggerServerEvent('qb-garage:server:updateVehicleJobState', 1, plate, k)
                        TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', vehProperties)
                        TriggerEvent('qb-radial:client:jobvehiclelist', true)
                        TriggerEvent('qb-radial:client:jobparking', false)
                        TriggerEvent('qb-radial:client:personaljobparking', false)


                        if plate  then
                            OutsideVehicles[plate] = veh
                            TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                        end
                        QBCore.Functions.Notify("Vehicle Parked", "primary", 4500)
                        Wait(500)
                        DeleteEntity(vehicleclose)
                    else
                        QBCore.Functions.Notify("Vehicle not owned", "error", 3500)
                    end
                end, plate )
            end    
        end
    end
end)



RegisterNetEvent('qb-garages:client:putinpersonaljobvehicle')
AddEventHandler('qb-garages:client:putinpersonaljobvehicle', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local vehicleclose = QBCore.Functions.GetClosestVehicle(pos)
    local inGarageRange = false


    for k, v in pairs(JobGarages) do          
        for i=1, #JobGarages[k]["parking"] do
            local garage = #(pos - vector3(JobGarages[k]["parking"][i].x, JobGarages[k]["parking"][i].y, JobGarages[k]["parking"][i].z))

            if garage <= 4 then                 
                local plate = QBCore.Functions.GetPlate(vehicleclose)
                QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleOwner2', function(owned)

                    if DoesEntityExist(vehicleclose) and owned then
                        local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicleclose))
                        local engineDamage = math.ceil(GetVehicleEngineHealth(vehicleclose))
                        local totalFuel = exports['cdn-fuel']:GetFuel(vehicleclose)
                        local passenger = GetVehicleMaxNumberOfPassengers(vehicleclose)
                        local vehProperties = QBCore.Functions.GetVehicleProperties(vehicleclose)
                        CheckPlayers(vehicleclose)
                        TriggerServerEvent('qb-garage:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, k)
                        TriggerServerEvent('qb-garage:server:updateVehicleJobState', 1, plate, k)
                        TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', vehProperties)
                        TriggerEvent('qb-radial:client:jobvehiclelist', true)
                        TriggerEvent('qb-radial:client:jobparking', false)
                        TriggerEvent('qb-radial:client:personaljobparking', false)

                        
                        if plate  then
                            OutsideVehicles[plate] = veh
                            TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                        end
                        QBCore.Functions.Notify("Vehicle Parked", "primary", 4500)
                        Wait(500)
                        DeleteEntity(vehicleclose)
                    else
                        QBCore.Functions.Notify("Can only put police and owned vehicles in this garage", "error", 3500)
                    end
                end, plate)
            end    
        end
    end
end)













--UTIL

function LocalInput(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
        return result
    end
end

function comma_value(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end


function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end

	for k,entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))

		if distance <= maxDistance then
			table.insert(nearbyEntities, isPlayerEntities and k or entity)
		end
	end

	return nearbyEntities
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		local next = true

		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

GetVehicles = function()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

GetVehiclesInArea = function(coords, maxDistance) return EnumerateEntitiesWithinDistance(GetVehicles(), false, coords, maxDistance) end
IsSpawnPointClear = function(coords, maxDistance) return #GetVehiclesInArea(coords, maxDistance) == 0 end








-- Threads

CreateThread(function() 
    for j, v in pairs(Garages) do             
        for k=1, #Garages[j]["parking"] do
            garages[k] = BoxZone:Create(Garages[j]["parking"][k], Garages[j]["width"][k].x, Garages[j]["width"][k].y, {
                name="Garage"..k,
                offset={0.0, 0.0, 0.0},
                scale={1.0, 1.0, 1.0},
                minZ = 	Garages[j]["parking"][k].z-2.0,
                maxZ = Garages[j]["parking"][k].z+3.0,
                heading = Garages[j]["parking"][k].w,
                debugPoly=false,
            })
            garages[k]:onPlayerInOut(function(isPointInside)
                if isPointInside then
                    exports['textUi']:Show("Garage", "[F1] To Access Public Garage")
                    local ped = PlayerPedId()
                    local pos = GetEntityCoords(ped)
                    local vehicleclose = QBCore.Functions.GetClosestVehicle(pos)
                    local vehiclepos = GetEntityCoords(vehicleclose)
                    local plate = QBCore.Functions.GetPlate(vehicleclose)
                    local dis = #(pos - vehiclepos)

                    QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleOwner', function(owned)
                        if DoesEntityExist(vehicleclose) and owned and dis <= 3 then
                            TriggerEvent('qb-radial:client:parking', true)
                        else
                            TriggerEvent('qb-radial:client:vehiclelist', true)
                        end
                    end, plate)
                else
                    exports['textUi']:Close()
                    TriggerEvent('qb-radial:client:outgarage')
                end
            end)
        end
    end
end)

CreateThread(function()
    while true do
        sleep = 1000
        if LocalPlayer.state['isLoggedIn'] then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            inGarageRange = false
            if HouseGarages and currentHouseGarage then
                if hasGarageKey and HouseGarages[currentHouseGarage] and HouseGarages[currentHouseGarage].takeVehicle and HouseGarages[currentHouseGarage].takeVehicle.x then
                    local takehouseDist = #(pos - vector3(HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z))
                    if takehouseDist <= 15 then
                        sleep = 5
                        inGarageRange = true
                        DrawMarker(2, HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                        if takehouseDist < 2.0 then
                            if not IsPedInAnyVehicle(ped) then
                                DrawText3Ds(HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z + 0.5, '~g~E~w~ - Garage')
                                if IsControlJustPressed(0, 38) then
                                    MenuHouseGarage(currentHouseGarage)

                                end
                            elseif IsPedInAnyVehicle(ped) then
                                DrawText3Ds(HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z + 0.5, '~g~E~w~ - To Park')
                                if IsControlJustPressed(0, 38) then
                                    local curVeh = GetVehiclePedIsIn(ped)
                                    local plate = QBCore.Functions.GetPlate(curVeh)
                                    QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleHouseOwner', function(owned)
                                        if owned then
                                            local bodyDamage = round(GetVehicleBodyHealth(curVeh), 1)
                                            local engineDamage = round(GetVehicleEngineHealth(curVeh), 1)
                                            local totalFuel = exports['cdn-fuel']:GetFuel(curVeh)
                                            local vehProperties = QBCore.Functions.GetVehicleProperties(curVeh)
                                                CheckPlayers(curVeh)
                                            if DoesEntityExist(curVeh) then
                                                    QBCore.Functions.Notify("The Vehicle wasn't deleted, please check if is someone inside the car.", "error", 4500)
                                            else
                                            TriggerServerEvent('qb-garage:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, currentHouseGarage)
                                            TriggerServerEvent('qb-garage:server:updateVehicleState', 1, plate, currentHouseGarage)
                                            TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', vehProperties)
                                            QBCore.Functions.DeleteVehicle(curVeh)
                                            if plate then
                                                OutsideVehicles[plate] = veh
                                                TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                                            end
                                            QBCore.Functions.Notify("Vehicle Parked", "primary", 4500)
                                        end
                                        else
                                            QBCore.Functions.Notify("Vehicle not owned", "error", 3500)
                                        end

                                    end, plate, currentHouseGarage)
                                end
                            end
                        end
                        if takehouseDist > 1.99 then
                            closeMenuFull()
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)



CreateThread(function()
    for k, v in pairs(Garages) do
        if v.showBlip then
            local Garage = AddBlipForCoord(Garages[k].blip.x, Garages[k].blip.y, Garages[k].blip.z)
            SetBlipSprite (Garage, 357)
            SetBlipDisplay(Garage, 4)
            SetBlipScale  (Garage, 0.85)
            SetBlipAsShortRange(Garage, true)
            SetBlipColour(Garage, 3)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Garages[k].label)
            EndTextCommandSetBlipName(Garage)
        end
    end

    -- garage blips need fix

    local Depot = AddBlipForCoord(vector3(416.99, -1627.88, 29.29))
    SetBlipSprite (Depot, 68)
    SetBlipDisplay(Depot, 4)
    SetBlipScale  (Depot, 0.7)
    SetBlipAsShortRange(Depot, true)
    SetBlipColour(Depot, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName('Depot')
    EndTextCommandSetBlipName(Depot)
end)







CreateThread(function() 
    for j, v in pairs(Garages) do             
        for k=1, #Garages[j]["parking"] do
            garages[k] = BoxZone:Create(Garages[j]["parking"][k], Garages[j]["width"][k].x, Garages[j]["width"][k].y, {
                name="Garage"..k,
                offset={0.0, 0.0, 0.0},
                scale={1.0, 1.0, 1.0},
                minZ = 	Garages[j]["parking"][k].z-2.0,
                maxZ = Garages[j]["parking"][k].z+3.0,
                heading = Garages[j]["parking"][k].w,
                debugPoly=false,
            })
            garages[k]:onPlayerInOut(function(isPointInside)
                if isPointInside then
                    exports['textUi']:Show("Garage", "[F1] To Access Public Garage")
                    local ped = PlayerPedId()
                    local pos = GetEntityCoords(ped)
                    local vehicleclose = QBCore.Functions.GetClosestVehicle(pos)
                    local vehiclepos = GetEntityCoords(vehicleclose)
                    local plate = QBCore.Functions.GetPlate(vehicleclose)
                    local dis = #(pos - vehiclepos)

                    QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleOwner', function(owned)
                        if DoesEntityExist(vehicleclose) and owned and dis <= 3 then
                            TriggerEvent('qb-radial:client:parking', true)
                        else
                            TriggerEvent('qb-radial:client:vehiclelist', true)
                        end
                    end, plate)
                else
                    exports['textUi']:Close()
                    TriggerEvent('qb-radial:client:outgarage')
                end
            end)
        end
    end
end)






CreateThread(function() 
    for j, v in pairs(JobGarages) do             
        for k=1, #JobGarages[j]["parking"] do
            garages[k] = BoxZone:Create(JobGarages[j]["parking"][k], JobGarages[j]["width"][k].x, JobGarages[j]["width"][k].y, {
                name="Garage"..k,
                offset={0.0, 0.0, 0.0},
                scale={1.0, 1.0, 1.0},
                minZ = 	JobGarages[j]["parking"][k].z-2.0,
                maxZ = JobGarages[j]["parking"][k].z+3.0,
                heading = JobGarages[j]["parking"][k].w,
                debugPoly=false,
            })
            garages[k]:onPlayerInOut(function(isPointInside)
                if isPointInside and PlayerJob.name == JobGarages[j].job then
                    exports['textUi']:Show("Garage", "[F1] To Access Job Garage")
                    local ped = PlayerPedId()
                    local pos = GetEntityCoords(ped)
                    local vehicleclose = QBCore.Functions.GetClosestVehicle(pos)
                    local vehiclepos = GetEntityCoords(vehicleclose)
                    local plate = QBCore.Functions.GetPlate(vehicleclose)
                    local dis = #(pos - vehiclepos)

                    QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleOwner2', function(owned)
                        if DoesEntityExist(vehicleclose) and owned and dis <= 2.5 then
                            TriggerEvent('qb-radial:client:personaljobparking', true)
                        elseif DoesEntityExist(vehicleclose) and not owned and dis <= 2.5 then 
                            TriggerEvent('qb-radial:client:jobparking', true)
                        else
                            TriggerEvent('qb-radial:client:jobvehiclelist', true)
                        end
                    end, plate)
                else
                    exports['textUi']:Close()
                    TriggerEvent('qb-radial:client:joboutgarage')
                end
            end)
        end
    end
end)






CreateThread(function() 
    for j, v in pairs(GangGarages) do             
        for k=1, #GangGarages[j]["parking"] do
            garages[k] = BoxZone:Create(GangGarages[j]["parking"][k], GangGarages[j]["width"][k].x, GangGarages[j]["width"][k].y, {
                name="Garage"..k,
                offset={0.0, 0.0, 0.0},
                scale={1.0, 1.0, 1.0},
                minZ = 	GangGarages[j]["parking"][k].z-2.0,
                maxZ = GangGarages[j]["parking"][k].z+3.0,
                heading = GangGarages[j]["parking"][k].w,
                debugPoly=false,
            })
            garages[k]:onPlayerInOut(function(isPointInside)
                if isPointInside and PlayerGang.name == GangGarages[j].gang then
                    exports['textUi']:Show("Garage", "[F1] To Access Gang Garage")
                    local ped = PlayerPedId()
                    local pos = GetEntityCoords(ped)
                    local vehicleclose = QBCore.Functions.GetClosestVehicle(pos)
                    local vehiclepos = GetEntityCoords(vehicleclose)
                    local plate = QBCore.Functions.GetPlate(vehicleclose)
                    local dis = #(pos - vehiclepos)

                    QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleOwnergang', function(owned)
                        if DoesEntityExist(vehicleclose) and owned and dis <= 3 then
                            TriggerEvent('qb-radial:client:gangparking', true)
                        else
                            TriggerEvent('qb-radial:client:gangvehiclelist', true)
                        end
                    end, plate)
                else
                    exports['textUi']:Close()
                    TriggerEvent('qb-radial:client:gangoutgarage')
                end
            end)
        end
    end
end)


exports['lrp-target']:AddTargetModel(`a_m_m_indian_01`, {
    options = {
        {
            event = "opendepo",
            icon = "fas fa-example",
            label = "Depot",
            canInteract = function()
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local pedpos = #(pos - vector3(408.91, -1622.84, 28.29))

                if pedpos <= 3.0 then
                return true
                else
                return false
                end
            end,
        },
    },
    distance = 3.0
})



