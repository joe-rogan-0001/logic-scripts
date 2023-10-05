local QBCore = exports['lrp-core']:GetCoreObject()
local SpawnVehicle = false

RegisterNetEvent('lrp-rentals:MenuCar', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Vehicle Rentals",
            isMenuHeader = true
        },
        {
            header = "Cars",
            txt = "",
            params = {
                event = "lrp-rentals:openCarMenu"
            }
        },
        {
            header = "Bikes",
            txt = "",
            params = {
                event = "lrp-rentals:openCarMenu2"
            }
        },
        {
            header = "⬅ Cancel",
            txt = "",
            params = {
                event = "lrp-menu:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('lrp-rentals:openCarMenu', function()
    exports['lrp-menu']:openMenu({
        {
            id = 1,
            header = "Bison",
            txt = "$600.00",
            params = {
                event = "lrp-rentals:spawncar",
                args = {
                    model = 'bison',
                    money = 600,
                }
            }
        },
        {
            id = 2,
            header = "Buccaneer",
            txt = "$650.00",
            params = {
                event = "lrp-rentals:spawncar",
                args = {
                    model = 'buccaneer',
                    money = 650,
                }
            }
        },
        {
            id = 3,
            header = "Futo",
            txt = "$750.00",
            params = {
                event = "lrp-rentals:spawncar",
                args = {
                    model = 'futo',
                    money = 750,
                }
            }
        },
        {
            id = 4,
            header = "Sultan",
            txt = "$850.00",
            params = {
                event = "lrp-rentals:spawncar",
                args = {
                    model = 'sultan',
                    money = 850,
                }
            }
        },
        {
            id = 5,
            header = "Limo",
            txt = "$1500.00",
            params = {
                event = "lrp-rentals:spawncar",
                args = {
                    model = 'stretch',
                    money = 1500,
                }
            }
        },
        {
            id = 6,
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-rentals:MenuCar"
            }
        },
    })
end)
RegisterNetEvent('lrp-rentals:openCarMenu2', function()
    exports['lrp-menu']:openMenu({
        {
            id = 1,
            header = "BMX",
            txt = "$250.00",
            params = {
                event = "lrp-rentals:spawncar",
                args = {
                    model = 'bimx',
                    money = 250,
                }
            }
        },
        {
            id = 2,
            header = "Sanchez",
            txt = "$500.00",
            params = {
                event = "lrp-rentals:spawncar",
                args = {
                    model = 'Sanchez',
                    money = 500,
                }
            }
        },
        {
            id = 3,
            header = "Akuma ",
            txt = "$600.00",
            params = {
                event = "lrp-rentals:spawncar",
                args = {
                    model = 'akuma',
                    money = 600,
                }
            }
        },
        {
            id = 4,
            header = "Bati 801",
            txt = "$750.00",
            params = {
                event = "lrp-rentals:spawncar",
                args = {
                    model = 'bati',
                    money = 750,
                }
            }
        },
        {
            id = 5,
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-rentals:MenuCar"
            }
        },
    })
end)

RegisterNetEvent('lrp-rentals:spawncar')
AddEventHandler('lrp-rentals:spawncar', function(data)
    local money = data.money
    local model = data.model
    local player = PlayerPedId()
    --print(money)
    QBCore.Functions.TriggerCallback('lrp-rentals:server:checkbal', function(success)
        if success then
            QBCore.Functions.SpawnVehicle(model, function(vehicle)
                SetEntityHeading(vehicle, 248.0)
                TaskWarpPedIntoVehicle(player, vehicle, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                SetVehicleEngineOn(vehicle, true, true)
                networkid = NetworkGetNetworkIdFromEntity(vehicle)
                SetNetworkIdExistsOnAllMachines(networkid, true)
                SetNetworkIdCanMigrate(networkid, true)
                SpawnVehicle = true
            end, vector4(-321.48, -997.42, 29.74, 248.52), true)

            Wait(1000)

            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            vehicleLabel = GetLabelText(vehicleLabel) -- kinda scuffed way of doing it but oh well
            local plate = GetVehicleNumberPlateText(vehicle)

            TriggerServerEvent('lrp-rentals:carrentalpapers', plate, vehicleLabel, money)
        else 
            QBCore.Functions.Notify('You dont have enough cash!', 'error')
        end
    end, money)
end)

RegisterNetEvent('lrp-rentals:carreturn')
AddEventHandler('lrp-rentals:carreturn', function()
    if SpawnVehicle then
        local Player = QBCore.Functions.GetPlayerData()
        QBCore.Functions.Notify('Returned vehicle!', 'success')
        TriggerServerEvent('lrp-rentals:removecarpapers')
        local car = GetVehiclePedIsIn(PlayerPedId(),true)
        NetworkFadeOutEntity(car, true,false)
        Citizen.Wait(2000)
        QBCore.Functions.DeleteVehicle(car)
    else 
        QBCore.Functions.Notify("No vehicle to return", "error")
    end
    SpawnVehicle = false
end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('lrp-rentals:MenuCarSandy', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Vehicle Rentals",
            isMenuHeader = true
        },
        {
            header = "Cars",
            txt = "",
            params = {
                event = "lrp-rentals:openCarMenuSandy"
            }
        },
        {
            header = "Bikes",
            txt = "",
            params = {
                event = "lrp-rentals:openCarMenuSandy2"
            }
        },
        {
            header = "⬅ Cancel",
            txt = "",
            params = {
                event = "lrp-menu:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('lrp-rentals:openCarMenuSandy', function()
    exports['lrp-menu']:openMenu({
        {
            id = 1,
            header = "Bison",
            txt = "$600.00",
            params = {
                event = "lrp-rentals:spawncarsandy",
                args = {
                    model = 'bison',
                    money = 600,
                }
            }
        },
        {
            id = 2,
            header = "Buccaneer",
            txt = "$650.00",
            params = {
                event = "lrp-rentals:spawncarsandy",
                args = {
                    model = 'buccaneer',
                    money = 650,
                }
            }
        },
        {
            id = 3,
            header = "Futo",
            txt = "$750.00",
            params = {
                event = "lrp-rentals:spawncarsandy",
                args = {
                    model = 'futo',
                    money = 750,
                }
            }
        },
        {
            id = 4,
            header = "Sultan",
            txt = "$850.00",
            params = {
                event = "lrp-rentals:spawncarsandy",
                args = {
                    model = 'sultan',
                    money = 850,
                }
            }
        },
        {
            id = 5,
            header = "Limo",
            txt = "$1500.00",
            params = {
                event = "lrp-rentals:spawncarsandy",
                args = {
                    model = 'stretch',
                    money = 1500,
                }
            }
        },
        {
            id = 6,
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-rentals:MenuCarSandy"
            }
        },
    })
end)
RegisterNetEvent('lrp-rentals:openCarMenuSandy2', function()
    exports['lrp-menu']:openMenu({
        {
            id = 1,
            header = "BMX",
            txt = "$250.00",
            params = {
                event = "lrp-rentals:spawncarsandy",
                args = {
                    model = 'bimx',
                    money = 250,
                }
            }
        },
        {
            id = 2,
            header = "Sanchez",
            txt = "$500.00",
            params = {
                event = "lrp-rentals:spawncarsandy",
                args = {
                    model = 'Sanchez',
                    money = 500,
                }
            }
        },
        {
            id = 3,
            header = "Akuma ",
            txt = "$600.00",
            params = {
                event = "lrp-rentals:spawncarsandy",
                args = {
                    model = 'akuma',
                    money = 600,
                }
            }
        },
        {
            id = 4,
            header = "Bati 801",
            txt = "$750.00",
            params = {
                event = "lrp-rentals:spawncarsandy",
                args = {
                    model = 'bati',
                    money = 750,
                }
            }
        },
        {
            id = 5,
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-rentals:MenuCarSandy"
            }
        },
    })
end)

RegisterNetEvent('lrp-rentals:spawncarsandy')
AddEventHandler('lrp-rentals:spawncarsandy', function(data)
    local money = data.money
    local model = data.model
    local player = PlayerPedId()
    --print(money)
    QBCore.Functions.TriggerCallback('lrp-rentals:server:checkbal', function(success)
        if success then
            QBCore.Functions.SpawnVehicle(model, function(vehicle)
                SetEntityHeading(vehicle, 137.0)
                TaskWarpPedIntoVehicle(player, vehicle, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                SetVehicleEngineOn(vehicle, true, true)
                networkid = NetworkGetNetworkIdFromEntity(vehicle)
                SetNetworkIdExistsOnAllMachines(networkid, true)
                SetNetworkIdCanMigrate(networkid, true)
                SpawnVehicle = true
            end, vector4(1230.93, 2721.84, 37.4, 137.23), true)

            Wait(1000)

            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            vehicleLabel = GetLabelText(vehicleLabel) -- kinda scuffed way of doing it but oh well
            local plate = GetVehicleNumberPlateText(vehicle)

            TriggerServerEvent('lrp-rentals:carrentalpapers', plate, vehicleLabel, money)
        else 
            QBCore.Functions.Notify('You dont have enough cash!', 'error')
        end
    end, money)
end)

RegisterNetEvent('lrp-rentals:carreturnsandy')
AddEventHandler('lrp-rentals:carreturnsandy', function()
    if SpawnVehicle then
        local Player = QBCore.Functions.GetPlayerData()
        QBCore.Functions.Notify('Returned vehicle!', 'success')
        TriggerServerEvent('lrp-rentals:removecarpapers')
        local car = GetVehiclePedIsIn(PlayerPedId(),true)
        NetworkFadeOutEntity(car, true,false)
        Citizen.Wait(2000)
        QBCore.Functions.DeleteVehicle(car)
    else 
        QBCore.Functions.Notify("No vehicle to return", "error")
    end
    SpawnVehicle = false
end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('lrp-rentals:MenuCarPaleto', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Vehicle Rentals",
            isMenuHeader = true
        },
        {
            header = "Cars",
            txt = "",
            params = {
                event = "lrp-rentals:openCarMenuPaleto"
            }
        },
        {
            header = "Bikes",
            txt = "",
            params = {
                event = "lrp-rentals:openCarMenuPaleto2"
            }
        },
        {
            header = "⬅ Cancel",
            txt = "",
            params = {
                event = "lrp-menu:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('lrp-rentals:openCarMenuPaleto', function()
    exports['lrp-menu']:openMenu({
        {
            id = 1,
            header = "Bison",
            txt = "$600.00",
            params = {
                event = "lrp-rentals:spawncarpaleto",
                args = {
                    model = 'bison',
                    money = 600,
                }
            }
        },
        {
            id = 2,
            header = "Buccaneer",
            txt = "$650.00",
            params = {
                event = "lrp-rentals:spawncarpaleto",
                args = {
                    model = 'buccaneer',
                    money = 650,
                }
            }
        },
        {
            id = 3,
            header = "Futo",
            txt = "$750.00",
            params = {
                event = "lrp-rentals:spawncarpaleto",
                args = {
                    model = 'futo',
                    money = 750,
                }
            }
        },
        {
            id = 4,
            header = "Sultan",
            txt = "$850.00",
            params = {
                event = "lrp-rentals:spawncarpaleto",
                args = {
                    model = 'sultan',
                    money = 850,
                }
            }
        },
        {
            id = 5,
            header = "Limo",
            txt = "$1500.00",
            params = {
                event = "lrp-rentals:spawncarpaleto",
                args = {
                    model = 'stretch',
                    money = 1500,
                }
            }
        },
        {
            id = 6,
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-rentals:MenuCarSandy"
            }
        },
    })
end)
RegisterNetEvent('lrp-rentals:openCarMenuPaleto2', function()
    exports['lrp-menu']:openMenu({
        {
            id = 1,
            header = "BMX",
            txt = "$250.00",
            params = {
                event = "lrp-rentals:spawncarpaleto",
                args = {
                    model = 'bimx',
                    money = 250,
                }
            }
        },
        {
            id = 2,
            header = "Sanchez",
            txt = "$500.00",
            params = {
                event = "lrp-rentals:spawncarpaleto",
                args = {
                    model = 'Sanchez',
                    money = 500,
                }
            }
        },
        {
            id = 3,
            header = "Akuma ",
            txt = "$600.00",
            params = {
                event = "lrp-rentals:spawncarpaleto",
                args = {
                    model = 'akuma',
                    money = 600,
                }
            }
        },
        {
            id = 4,
            header = "Bati 801",
            txt = "$750.00",
            params = {
                event = "lrp-rentals:spawncarpaleto",
                args = {
                    model = 'bati',
                    money = 750,
                }
            }
        },
        {
            id = 5,
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-rentals:MenuCarPaleto"
            }
        },
    })
end)

RegisterNetEvent('lrp-rentals:spawncarpaleto')
AddEventHandler('lrp-rentals:spawncarpaleto', function(data)
    local money = data.money
    local model = data.model
    local player = PlayerPedId()
    --print(money)
    QBCore.Functions.TriggerCallback('lrp-rentals:server:checkbal', function(success)
        if success then
            QBCore.Functions.SpawnVehicle(model, function(vehicle)
                SetEntityHeading(vehicle, 225.0)
                TaskWarpPedIntoVehicle(player, vehicle, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                SetVehicleEngineOn(vehicle, true, true)
                networkid = NetworkGetNetworkIdFromEntity(vehicle)
                SetNetworkIdExistsOnAllMachines(networkid, true)
                SetNetworkIdCanMigrate(networkid, true)
                SpawnVehicle = true
            end, vector4(-207.82, 6219.84, 30.88, 224.89), true)

            Wait(1000)

            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            vehicleLabel = GetLabelText(vehicleLabel) -- kinda scuffed way of doing it but oh well
            local plate = GetVehicleNumberPlateText(vehicle)

            TriggerServerEvent('lrp-rentals:carrentalpapers', plate, vehicleLabel, money)
        else 
            QBCore.Functions.Notify('You dont have enough cash!', 'error')
        end
    end, money)
end)

RegisterNetEvent('lrp-rentals:carreturnpaleto')
AddEventHandler('lrp-rentals:carreturnpaleto', function()
    if SpawnVehicle then
        local Player = QBCore.Functions.GetPlayerData()
        QBCore.Functions.Notify('Returned vehicle!', 'success')
        TriggerServerEvent('lrp-rentals:removecarpapers')
        local car = GetVehiclePedIsIn(PlayerPedId(),true)
        NetworkFadeOutEntity(car, true,false)
        Citizen.Wait(2000)
        QBCore.Functions.DeleteVehicle(car)
    else 
        QBCore.Functions.Notify("No vehicle to return", "error")
    end
    SpawnVehicle = false
end)

-- BOAT
RegisterNetEvent('lrp-rentals:MenuBoat', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Boat Rentals",
            isMenuHeader = true
        },
        {
            header = "Boats",
            txt = "",
            params = {
                event = "lrp-rentals:openBoatMenu"
            }
        },
        {
            header = "⬅ Cancel",
            txt = "",
            params = {
                event = "lrp-menu:closeMenu"
            }
        },
    })
end)
RegisterNetEvent('lrp-rentals:openBoatMenu', function()
    exports['lrp-menu']:openMenu({
        {
            id = 1,
            header = "Sea Shark",
            txt = "$1750.00",
            params = {
                event = "lrp-rentals:spawnboat",
                args = {
                    model = 'seashark',
                    money = 1750,
                }
            }
        },
        {
            id = 2,
            header = "Tropic",
            txt = "$3500.00",
            params = {
                event = "lrp-rentals:spawnboat",
                args = {
                    model = 'tropic',
                    money = 3500,
                }
            }
        },
        {
            id = 3,
            header = "Dinghy",
            txt = "$4000.00",
            params = {
                event = "lrp-rentals:spawnboat",
                args = {
                    model = 'dinghy3',
                    money = 4000,
                }
            }
        },
        {
            id = 3,
            header = "Speeder",
            txt = "$4500.00",
            params = {
                event = "lrp-rentals:spawnboat",
                args = {
                    model = 'speeder',
                    money = 4500,
                }
            }
        },
        {
            id = 4,
            header = "Toro",
            txt = "$6000.00",
            params = {
                event = "lrp-rentals:spawnboat",
                args = {
                    model = 'toro',
                    money = 6000,
                }
            }
        },
        {
            id = 5,
            header = "Marquis",
            txt = "$20000.00",
            params = {
                event = "lrp-rentals:spawnboat",
                args = {
                    model = 'marquis',
                    money = 20000,
                }
            }
        },
        {
            id = 6,
            header = "Submersible",
            txt = "Out Of Stock!",
            params = {
                event = "lrp-rentals:openBoatMenu",
            }
        },
        {
            id = 7,
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-rentals:MenuBoat"
            }
        },
    })
end)

RegisterNetEvent('lrp-rentals:spawnboat')
AddEventHandler('lrp-rentals:spawnboat', function(data)
    local money = data.money
    local model = data.model
    local player = PlayerPedId()
    --print(money)
    QBCore.Functions.TriggerCallback('lrp-rentals:server:checkbal', function(success)
        if success then
            QBCore.Functions.SpawnVehicle(model, function(vehicle)
                SetEntityHeading(vehicle, 230.0)
                TaskWarpPedIntoVehicle(player, vehicle, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                SetVehicleEngineOn(vehicle, true, true)
                networkid = NetworkGetNetworkIdFromEntity(vehicle)
                SetNetworkIdExistsOnAllMachines(networkid, true)
                SetNetworkIdCanMigrate(networkid, true)
                SpawnVehicle = true
            end, vector4(-769.34, -1377.58, 0.05, 227.81), true)

            Wait(1000)

            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            vehicleLabel = GetLabelText(vehicleLabel) -- kinda scuffed way of doing it but oh well
            local plate = GetVehicleNumberPlateText(vehicle)

            TriggerServerEvent('lrp-rentals:boatrentalpapers', plate, vehicleLabel, money)
        else 
            QBCore.Functions.Notify('You dont have enough cash!', 'error')
        end
    end, money)
end)

RegisterNetEvent('lrp-rentals:boatreturn')
AddEventHandler('lrp-rentals:boatreturn', function()
    if SpawnVehicle then
        local Player = QBCore.Functions.GetPlayerData()
        QBCore.Functions.Notify('Returned vehicle!', 'success')
        TriggerServerEvent('lrp-rentals:removeboatpapers')
        local boat = GetVehiclePedIsIn(PlayerPedId(),true)
        NetworkFadeOutEntity(car, true,false)
        Citizen.Wait(2000)
        QBCore.Functions.DeleteVehicle(boat)
    else 
        QBCore.Functions.Notify("No vehicle to return", "error")
    end
    SpawnVehicle = false
end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--AIRCRAFT
RegisterNetEvent('lrp-rentals:MenuPlane', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Aircraft Rentals",
            isMenuHeader = true
        },
        {
            header = "Airplanes",
            txt = "",
            params = {
                event = "lrp-rentals:openPlaneMenu"
            }
        },
        {
            header = "Helicopters",
            txt = "",
            params = {
                event = "lrp-rentals:openPlaneMenu2"
            }
        },
        {
            header = "⬅ Cancel",
            txt = "",
            params = {
                event = "lrp-menu:closeMenu"
            }
        },
    })
end)
RegisterNetEvent('lrp-rentals:openPlaneMenu', function()
    exports['lrp-menu']:openMenu({
        {
            id = 1,
            header = "Vestra",
            txt = "$4000.00",
            params = {
                event = "lrp-rentals:spawnplane",
                args = {
                    model = 'vestra',
                    money = 4000,
                }
            }
        },
        {
            id = 2,
            header = "Dodo",
            txt = "$5000.00",
            params = {
                event = "lrp-rentals:spawnplane",
                args = {
                    model = 'dodo',
                    money = 5000,
                }
            }
        },
        {
            id = 3,
            header = "Velum",
            txt = "$6500.00",
            params = {
                event = "lrp-rentals:spawnplane",
                args = {
                    model = 'velum',
                    money = 6500,
                }
            }
        },
        {
            id = 4,
            header = "Luxor",
            txt = "$10000.00",
            params = {
                event = "lrp-rentals:spawnplane",
                args = {
                    model = 'Luxor',
                    money = 10000,
                }
            }
        },
        {
            id = 5,
            header = "Blimp",
            txt = "Out Of Stock!",
            params = {
                event = "lrp-rentals:openPlaneMenu",
            }
        },
        {
            id = 6,
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-rentals:MenuPlane"
            }
        },
    })
end)
RegisterNetEvent('lrp-rentals:openPlaneMenu2', function()
    exports['lrp-menu']:openMenu({
        {
            id = 1,
            header = "Buzzard",
            txt = "$5500.00",
            params = {
                event = "lrp-rentals:spawnplane",
                args = {
                    model = 'buzzard2',
                    money = 5500,
                }
            }
        },
        {
            id = 2,
            header = "Havok",
            txt = "$6250.00",
            params = {
                event = "lrp-rentals:spawnplane",
                args = {
                    model = 'havok',
                    money = 6250,
                }
            }
        },
        {
            id = 3,
            header = "Volatus ",
            txt = "$8000.00",
            params = {
                event = "lrp-rentals:spawnplane",
                args = {
                    model = 'volatus',
                    money = 8000,
                }
            }
        },
        {
            id = 4,
            header = "Swift",
            txt = "$10000.00",
            params = {
                event = "lrp-rentals:spawnplane",
                args = {
                    model = 'swift',
                    money = 10000,
                }
            }
        },
        {
            id = 5,
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-rentals:MenuPlane"
            }
        },
    })
end)

RegisterNetEvent('lrp-rentals:spawnplane')
AddEventHandler('lrp-rentals:spawnplane', function(data)
    local money = data.money
    local model = data.model
    local player = PlayerPedId()
    --print(money)
    QBCore.Functions.TriggerCallback('lrp-rentals:server:checkbal', function(success)
        if success then
            QBCore.Functions.SpawnVehicle(model, function(vehicle)
                SetEntityHeading(vehicle, 330.0)
                TaskWarpPedIntoVehicle(player, vehicle, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                SetVehicleEngineOn(vehicle, true, true)
                networkid = NetworkGetNetworkIdFromEntity(vehicle)
                SetNetworkIdExistsOnAllMachines(networkid, true)
                SetNetworkIdCanMigrate(networkid, true)
                SpawnVehicle = true
            end, vector4(-1646.62, -3133.05, 14.17, 329.35), true)

            Wait(1000)

            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            vehicleLabel = GetLabelText(vehicleLabel) -- kinda scuffed way of doing it but oh well
            local plate = GetVehicleNumberPlateText(vehicle)

            TriggerServerEvent('lrp-rentals:planerentalpapers', plate, vehicleLabel, money)
        else 
            QBCore.Functions.Notify('You dont have enough cash!', 'error')
        end
    end, money)
end)

RegisterNetEvent('lrp-rentals:planereturn')
AddEventHandler('lrp-rentals:planereturn', function()
    if SpawnVehicle then
        local Player = QBCore.Functions.GetPlayerData()
        QBCore.Functions.Notify('Returned vehicle!', 'success')
        TriggerServerEvent('lrp-rentals:removeplanepapers')
        local plane = GetVehiclePedIsIn(PlayerPedId(),true)
        NetworkFadeOutEntity(car, true,false)
        Citizen.Wait(2000)
        QBCore.Functions.DeleteVehicle(plane)
    else 
        QBCore.Functions.Notify("No vehicle to return", "error")
    end
    SpawnVehicle = false
end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local blips = {
    {title="Vehicle Rental", colour=33, id=225, x = 109.01, y = -1088.6, z = 29.3},
    {title="Vehicle Rental", colour=33, id=225, x = 1224.7, y = 2728.11, z = 38.0},
    {title="Vehicle Rental", colour=33, id=225, x = -215.2, y = 6218.93, z = 31.49},
    {title="Boat Rentals", colour=33, id=410, x = -773.28, y = -1361.16, z = 5.0},
    {title="Aircraft Rentals", colour=33, id=423, x = -1621.75, y = -3152.7, z = 13.99}
}
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)