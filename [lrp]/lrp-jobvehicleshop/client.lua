-- Variables
local QBCore = exports['lrp-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData() -- Just for resource restart (same as event handler)
local insideZones = {}

for name, shop in pairs(Config.Shops) do -- foreach shop
    insideZones[name] = false  -- default to not being in a shop
end

local testDriveVeh, inTestDrive = 0, false
local ClosestVehicle = 1
local zones = {}

function getShopInsideOf() 
    for name, shop in pairs(Config.Shops) do -- foreach shop
        if insideZones[name] then
            return name
        end
    end
    return nil
end

-- Handlers

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    local citizenid = PlayerData.citizenid
    local gameTime = GetGameTimer()
    TriggerServerEvent('qb-jobvehicleshop:server:addPlayer', citizenid, gameTime)
    TriggerServerEvent('qb-jobvehicleshop:server:checkFinance')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    local citizenid = PlayerData.citizenid
    TriggerServerEvent('qb-jobvehicleshop:server:removePlayer', citizenid)
    PlayerData = {}
end)






-- Functions


local function comma_value(amount)
    local formatted = amount
    while true do
      formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
      if (k==0) then
        break
      end
    end
    return formatted
end

local function getVehName()
    return QBCore.Shared.Vehicles[Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle]["name"]
end

local function getVehPrice()
    return comma_value(QBCore.Shared.Vehicles[Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle]["price"])
end

local function getVehBrand()
    return QBCore.Shared.Vehicles[Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle]["brand"]
end

local function setClosestShowroomVehicle()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    local closestShop = getShopInsideOf()
    for id, veh in pairs(Config.Shops[closestShop]["ShowroomVehicles"]) do
        local dist2 = #(pos - vector3(Config.Shops[closestShop]["ShowroomVehicles"][id].coords.x, Config.Shops[closestShop]["ShowroomVehicles"][id].coords.y, Config.Shops[closestShop]["ShowroomVehicles"][id].coords.z))
        if current ~= nil then
            if dist2 < dist then
                current = id
                dist = dist2
            end
        else
            dist = dist2
            current = id
        end
    end
    if current ~= ClosestVehicle then
        ClosestVehicle = current
    end
end





local function isInShop() 
    for shopName, isInside in pairs(insideZones) do
        if isInside then
            return true
        end
    end

    return false
end


RegisterNetEvent("openmenu", function()
    openmenu()
end)

function openmenu()
    exports['lrp-menu']:openMenu({
        {
            isMenuHeader = true,
            header = getVehBrand():upper().. ' '..getVehName():upper().. ' - $' ..getVehPrice(),
        },
        {
            header = "Buy Vehicle",
            txt = 'Purchase currently selected vehicle',
            params = {
                event = 'qb-jobvehicleshop:client:jobchosetype',
            }
        },
        {
            header = 'Swap Vehicle',
            txt = 'Change currently selected vehicle',
            params = {
                event = 'qb-jobvehicleshop:client:jobvehCategories',
            }
        },
        {
            header = "⬅ Leave Menu",
            txt = "",
            params = {
                event = "lrp-menu:closeMenu"
            }
        },
    })
end

local isPointInside2 = false


CreateThread(function()
    if not Config.UsingTarget then

        for shopName,v in pairs(Config.Shops) do
            for i = 1, #Config.Shops[shopName]['ShowroomVehicles'] do
                zones[#zones+1] = BoxZone:Create(
                    vector3(Config.Shops[shopName]['ShowroomVehicles'][i]['coords'].x,
                    Config.Shops[shopName]['ShowroomVehicles'][i]['coords'].y,
                    Config.Shops[shopName]['ShowroomVehicles'][i]['coords'].z),
                    9.0,
                    4.0, {
                    name="box_zone",
                    debugPoly=false,
                    minZ = 0,
                    maxZ = Config.Shops[shopName]['ShowroomVehicles'][i]['maxZ'],
                    heading = Config.Shops[shopName]['ShowroomVehicles'][i]['coords'].w,
                })
            end
        end
        local combo = ComboZone:Create(zones, {name = "vehCombo", debugPoly = false})
        combo:onPlayerInOut(function(isPointInside)
            local insideShop = getShopInsideOf()
            Wait(200)
            
             isPointInside2 = isPointInside

                if isPointInside  then                                             
                    local job = PlayerData.job.name
                    local job2 = Config.Shops[insideShop]['Job']

                    if job == job2 then

                        exports['textUi']:Show("Job Vehicleshop", "Press [E] To Open Menu")

                        while isPointInside do
                            Citizen.Wait(0) 
                            if IsControlJustReleased(1, 51) then
                                TriggerEvent("openmenu")
                                exports['textUi']:Close() 
                            end           
                        end
                    end            
                else
                    exports['textUi']:Close() 
                    exports['lrp-menu']:closeMenu()
                end
                
        end)
    end
end)




-- Zones

function createFreeUseShop(shopShape, name)
    local zone = PolyZone:Create(shopShape, {  -- create the zone
        name= name,
        debugPoly = false,
        minZ = shopShape.minZ,
        maxZ = 40.0,
    })
    
    zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            insideZones[name] = true
            CreateThread(function()
                while insideZones[name] do
                    setClosestShowroomVehicle()
                    Wait(200)
                end
            end)
        else
            insideZones[name] = false 
            ClosestVehicle = 1
        end
    end)
end



for name, shop in pairs(Config.Shops) do 
    if shop['Type'] == 'free-use' then
        createFreeUseShop(shop['Zone']['Shape'], name)
    end
end

-- Events

RegisterNetEvent('qb-jobvehicleshop:client:homeMenu', function()
    exports['lrp-menu']:openMenu(vehicleMenu)
end)

RegisterNetEvent('qb-jobvehicleshop:client:showVehOptions', function()
    exports['lrp-menu']:openMenu(vehicleMenu)
end)






RegisterNetEvent('qb-jobvehicleshop:client:jobvehCategories', function()
    local categoryMenu = {
        {
            header = '< Go Back',
            params = {
                event = 'qb-jobvehicleshop:client:homeMenu'
            }
        }
    }
    for k,v in pairs(Config.Shops[getShopInsideOf()]['Categories']) do
        categoryMenu[#categoryMenu + 1] = {
            header = v,
            params = {
                event = 'qb-jobvehicleshop:client:openVehCats',
                args = {
                    catName = k
                }
            }
        }
    end
    exports['lrp-menu']:openMenu(categoryMenu)
end)

RegisterNetEvent('qb-jobvehicleshop:client:openVehCats', function(data)
    local vehicleMenu = {
        {
            header = '< Go Back',
            params = {
                event = 'qb-jobvehicleshop:client:jobvehCategories'
            }
        }
    }
    for k,v in pairs(QBCore.Shared.Vehicles) do
        if QBCore.Shared.Vehicles[k]["category"] == data.catName and QBCore.Shared.Vehicles[k]["shop"] == getShopInsideOf() then
            vehicleMenu[#vehicleMenu + 1] = {
                header = v.name,
                txt = 'Price: $'..v.price,
                params = {
                    isServer = true,
                    event = 'qb-jobvehicleshop:server:swapVehicle',
                    args = {
                        toVehicle = v.model,
                        ClosestVehicle = ClosestVehicle,
                        ClosestShop = getShopInsideOf()
                    }
                }
            }
        end
    end
    exports['lrp-menu']:openMenu(vehicleMenu)
end)



RegisterNetEvent('qb-jobvehicleshop:client:jobchosetype', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Buy as Job Vehicle",
            txt = 'Vehicle will belong to job',
            params = {
                event = 'qb-jobvehicleshop:client:jobbuycars',

            }
        },
        {
            header = "Buy as Personal Vehicle",
            txt = 'Vehicle will belong to you',
            params = {
                event = 'qb-jobvehicleshop:client:jobbuycars2',
            }
        },
    })
end)


RegisterNetEvent('qb-jobvehicleshop:client:jobbuycars', function(data)
    exports['lrp-menu']:openMenu({
        {
            header = "Buy Vehicle",
            txt = 'Vehicle will be give to you here',
            params = {
                isServer = true,
                event = 'qb-jobvehicleshop:server:buyShowroomVehicle',
                args = {
                    buyVehicle = Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle
                }
            }
        },
        {
            header = 'Get Vehicle Delivered',
            txt = 'Vehicle will be delivered to main garage',
            params = {
                isServer = true,
                event = 'qb-jobvehicleshop:server:deliverVehicle',
                args = {
                    buyVehicle = Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle
                }
            }
        },
    })
end)


RegisterNetEvent('qb-jobvehicleshop:client:jobbuycars2', function(data)
    exports['lrp-menu']:openMenu({
        {
            header = "Buy Vehicle",
            txt = 'Vehicle will be give to you here',
            params = {
                isServer = true,
                event = 'qb-jobvehicleshop:server:buyShowroomVehiclepersonal',
                args = {
                    buyVehicle = Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle
                }
            }
        },
    })
end)








RegisterNetEvent('qb-jobvehicleshop:client:jobswapVehicle', function(data)
    local shopName = getShopInsideOf()
    if Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].chosenVehicle ~= data.toVehicle then
        local closestVehicle, closestDistance = QBCore.Functions.GetClosestVehicle(vector3(Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.x, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.y, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.z))
        if closestVehicle == 0 then return end
        if closestDistance < 5 then QBCore.Functions.DeleteVehicle(closestVehicle) end
        Wait(250)
        local model = GetHashKey(data.toVehicle)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(250)
        end
        local veh = CreateVehicle(model, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.x, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.y, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.z, false, false)
        SetModelAsNoLongerNeeded(model)
        SetVehicleOnGroundProperly(veh)
        SetEntityInvincible(veh,true)
        SetVehicleColours(veh, 1,1)
        SetVehicleLivery(veh, 4)
        SetEntityHeading(veh, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.w)
        SetVehicleDoorsLocked(veh, 3)
        FreezeEntityPosition(veh, true)
        SetVehicleNumberPlateText(veh, 'BUY ME')
        Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].chosenVehicle = data.toVehicle
    end
    openmenu()
end)

RegisterNetEvent('qb-jobvehicleshop:client:buyShowroomVehicle', function(vehicle, plate)
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)   
        exports['cdn-fuel']:SetFuel(veh, 100)
        SetVehicleNumberPlateText(veh, plate)
        SetEntityHeading(veh, Config.Shops[getShopInsideOf()]["VehicleSpawn"].w)
        SetEntityAsMissionEntity(veh, true, true)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        TriggerServerEvent("qb-vehicletuning:server:SaveVehicleProps", QBCore.Functions.GetVehicleProperties(veh))
    end, Config.Shops[getShopInsideOf()]["VehicleSpawn"], true)
end)

RegisterNetEvent('qb-jobvehicleshop:client:buyShowroomVehiclepersonal', function(vehicle, plate)
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)   
        exports['cdn-fuel']:SetFuel(veh, 100)
        SetVehicleNumberPlateText(veh, plate)
        SetEntityHeading(veh, Config.Shops[getShopInsideOf()]["VehicleSpawn"].w)
        SetEntityAsMissionEntity(veh, true, true)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        TriggerServerEvent("qb-vehicletuning:server:SaveVehicleProps", QBCore.Functions.GetVehicleProperties(veh))
    end, Config.Shops[getShopInsideOf()]["VehicleSpawn"], true)
end)


RegisterNetEvent('qb-jobvehicleshop:client:getVehicles', function()
    QBCore.Functions.TriggerCallback('qb-jobvehicleshop:server:getVehicles', function(vehicles)
        local ownedVehicles = {}
        for k,v in pairs(vehicles) do
            if v.balance then
                local name = QBCore.Shared.Vehicles[v.vehicle]["name"]
                local plate = v.plate:upper()
                ownedVehicles[#ownedVehicles + 1] = {
                    header = ''..name..'',
                    txt = 'Plate: ' ..plate,
                    params = {
                        event = 'qb-jobvehicleshop:client:getVehicleFinance',
                        args = {
                            vehiclePlate = plate,
                            balance = v.balance,
                            paymentsLeft = v.paymentsleft,
                            paymentAmount = v.paymentamount
                        }
                    }
                }
            end
        end
        exports['lrp-menu']:openMenu(ownedVehicles)
    end)
end)


-- Threads

CreateThread(function()
    for k,v in pairs(Config.Shops) do
        if v.showBlip then
	    local Dealer = AddBlipForCoord(Config.Shops[k]["Location"])
	    SetBlipSprite (Dealer, 326)
            SetBlipDisplay(Dealer, 4)
            SetBlipScale  (Dealer, 0.75)
	    SetBlipAsShortRange(Dealer, true)
	    SetBlipColour(Dealer, 3)
            BeginTextCommandSetBlipName("STRING")
	    AddTextComponentSubstringPlayerName(Config.Shops[k]["ShopLabel"])
	    EndTextCommandSetBlipName(Dealer)
	end
    end
end)


CreateThread(function()
    for k,v in pairs(Config.Shops) do
        for i = 1, #Config.Shops[k]['ShowroomVehicles'] do
            local model = GetHashKey(Config.Shops[k]["ShowroomVehicles"][i].defaultVehicle)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end
            local veh = CreateVehicle(model, Config.Shops[k]["ShowroomVehicles"][i].coords.x, Config.Shops[k]["ShowroomVehicles"][i].coords.y, Config.Shops[k]["ShowroomVehicles"][i].coords.z, false, false)
            SetModelAsNoLongerNeeded(model)
            SetEntityAsMissionEntity(veh, true, true)
            SetVehicleOnGroundProperly(veh)
            SetEntityInvincible(veh,true)
            SetVehicleDirtLevel(veh, 0.0)
            SetVehicleDoorsLocked(veh, 3)
            SetEntityHeading(veh, Config.Shops[k]["ShowroomVehicles"][i].coords.w)
            FreezeEntityPosition(veh,true)
        end
    end
end)
