local QBCore = exports['lrp-core']:GetCoreObject()

local Base = Config.Gardener.Base
local Garage = Config.Gardener.Garage
local Marker = Config.Gardener.DefaultMarker
local GarageSpawnPoint = Config.Gardener.GarageSpawnPoint
local Type = nil
local AmountPayout = 0
local done = 0
local PlayerData = {}
local salary = nil

onDuty = false
hasCar = false
inGarageMenu = false
inMenu = false
wasTalked = false
appointed = false
waitingDone = false
CanWork = false
Paycheck = false

hasOpenDoor = false
hasBlower = false
hasTrimmer = false
hasLawnMower = false
hasBackPack = false

function Randomize(tb)
	local keys = {}
	for k in pairs(tb) do table.insert(keys, k) end
	return tb[keys[math.random(#keys)]]
end

-- BASE
Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

                if (GetDistanceBetweenCoords(coords, Base.Pos.x, Base.Pos.y, Base.Pos.z, true) < 8) then
                    sleep = 5
                    DrawMarker(Base.Type, Base.Pos.x, Base.Pos.y, Base.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Base.Size.x, Base.Size.y, Base.Size.z, Base.Color.r, Base.Color.g, Base.Color.b, 100, false, true, 2, false, false, false, false)
                    if (GetDistanceBetweenCoords(coords, Base.Pos.x, Base.Pos.y, Base.Pos.z, true) < 1.2) then
                        if not onDuty then
                            sleep = 5
                            DrawText3Ds(Base.Pos.x, Base.Pos.y, Base.Pos.z + 0.4, '~g~[E]~s~ - Sign in the job')
                            if IsControlJustPressed(0, Keys["E"]) then
                                QBCore.Functions.Progressbar("signingin", "You're signing in the job...." , 2500, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                    disableInventory = true,
                                }, {}, {}, {}, function()
                                end)
                                Citizen.Wait(2500)
                                -- exports['lrp-notify']:Alert("Gardener", "You started working!", 3000, 'success')
                                QBCore.Functions.Notify("You started working!", "success")
                                onDuty = true
                                addGarageBlip()
                                QBCore.Functions.Notify("To open the work menu, press [DEL]", "info")
                                -- exports['lrp-notify']:Alert("Gardener", "To open the work menu, press [DEL]", 3000, 'info')
                            end
                        elseif onDuty then
                            sleep = 5
                            DrawText3Ds(Base.Pos.x, Base.Pos.y, Base.Pos.z + 0.4, '~r~[E]~s~ - Sign off the job')
                            if IsControlJustPressed(0, Keys["E"]) then
                                QBCore.Functions.Progressbar("signingin", "You're signing off the job...." , 2500, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                    disableInventory = true,
                                }, {}, {}, {}, function()
                                end)
                                Citizen.Wait(2500)
                                QBCore.Functions.Notify("You finished work!", "success")
                                -- exports['lrp-notify']:Alert("Gardener", "You finished work!", 3000, 'success')
                                onDuty = false
                                removeGarageBlip()
                            end
                        end
                    end
                end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

                if onDuty then
                    if not inMenu then
                        sleep = 2
                        if IsControlJustPressed(0, Keys["DEL"]) then
                            inMenu = true
                        end
                    elseif inMenu then
                        sleep = 2
                        DrawText3Dss(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Search a errand | ~r~[8]~s~ - Cancel errand')
                        if IsControlJustPressed(0, Keys["DEL"]) then
                            inMenu = false
                        elseif IsControlJustPressed(0, Keys["7"]) then
                            if Type == nil then
                                inMenu = false
                                QBCore.Functions.Progressbar("searchingerrand", "Searching a errand..." , 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                    disableInventory = true,
                                }, {}, {}, {}, function()
                                end)
                                Citizen.Wait(15000)
                                Gardens = Randomize(Config.Gardens)
                                CreateWork(Gardens.StreetHouse)
                                QBCore.Functions.Notify("GPS location set! Drive to " ..Gardens.StreetHouse, "success")
                                -- exports['lrp-notify']:Alert("Gardener", "GPS location set! Drive to " ..Gardens.StreetHouse, 3000, 'success')
                                salary = math.random(400, 500)
                                if Type == "Rockford Hills" then
                                    for i, v in ipairs(Config.RockfordHills) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "West Vinewood" then
                                    for i, v in ipairs(Config.WestVinewood) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "Vinewood Hills" then
                                    for i, v in ipairs(Config.VinewoodHills) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "El Burro Heights" then
                                    for i, v in ipairs(Config.ElBurroHeights) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "Richman" then
                                    for i, v in ipairs(Config.Richman) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "Mirror Park" then
                                    for i, v in ipairs(Config.MirrorPark) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "East Vinewood" then
                                    for i, v in ipairs(Config.EastVinewood) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                end
                            else
                                QBCore.Functions.Notify("You already have an errand!", "warning")
                                -- exports['lrp-notify']:Alert("Gardener", "You already have an errand!", 2000, 'warning')
                            end
                        elseif IsControlJustPressed(0, Keys["8"]) then
                            if Type then
                                CancelWork()
                                DeleteWaypoint()
                                QBCore.Functions.Notify("You canceled a meeting with a client", "warning")
                                -- exports['lrp-notify']:Alert("Gardener", "You canceled a meeting with a client", 2000, 'warning')
                            elseif not Type then
                                QBCore.Functions.Notify("You currently have no appointment", "info")
                                -- exports['lrp-notify']:Alert("Gardener", "You currently have no appointment", 2000, 'info')
                            end
                        end
                    end
                end
        Citizen.Wait(sleep)
    end
end)

-- GARAGE MENU
Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local vehicle = GetVehiclePedIsIn(ped, false)
        local WLCar = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))

                if onDuty then
                    if (GetDistanceBetweenCoords(coords, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z, true) < 8) then
                        sleep = 5
                        DrawMarker(Marker.Type, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Garage.Size.x, Garage.Size.y, Garage.Size.z, Garage.Color.r, Garage.Color.g, Garage.Color.b, 100, false, true, 2, false, false, false, false)
                        if (GetDistanceBetweenCoords(coords, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z, true) < 1.2) then
                            if IsPedInAnyVehicle(ped, false) then
                                sleep = 5
                                DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.4, '~r~[E]~s~ - Return vehicle')
                                if IsControlJustReleased(0, Keys["E"]) then
                                    if hasCar then
                                        TriggerServerEvent('inside-gardener:returnVehicle', source)
                                        ReturnVehicle()
                                        QBCore.Functions.Notify('You received ' ..Config.DepositPrice.. '$ for returning the vehicle', "success")
                                        -- exports['lrp-notify']:Alert("Gardener", 'You received ' ..Config.DepositPrice.. '$ for returning the vehicle', 2000, 'success')
                                        hasCar = false
                                        Plate = nil
                                    else
                                        QBCore.Functions.Notify('You haven\'t paid deposit for this vehicle!', "warning")
                                        -- exports['lrp-notify']:Alert("Gardener", 'You haven\'t paid deposit for this vehicle!', 2000, 'warning')
                                    end
                                end
                            elseif not IsPedInAnyVehicle(ped, false) then
                                sleep = 5
                                if not inGarageMenu then
                                    DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.4, '~g~[E]~s~ - Open Garage Menu')
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if not inMenu then
                                            FreezeEntityPosition(ped, true)
                                            inGarageMenu = true
                                            QBCore.Functions.Notify('Select a parking space', "success")
                                            -- exports['lrp-notify']:Alert("Gardener", 'Select a parking space', 2000, 'success')
                                        elseif inMenu then
                                            QBCore.Functions.Notify('Close the work menu!', "info")
                                            -- exports['lrp-notify']:Alert("Gardener", 'Close the work menu!', 2000, 'info')
                                        end
                                    end
                                elseif inGarageMenu then
                                    DrawText3DMenu(Garage.Pos.x - 0.8, Garage.Pos.y, Garage.Pos.z + 0.8, '~g~[7]~s~ - Parking Space #1\n~g~[8]~s~ - Parking Space #2\n~r~[E]~s~ - Close Garage Menu ')
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        inGarageMenu = false
                                        FreezeEntityPosition(ped, false)
                                    elseif IsControlJustReleased(0, Keys["7"]) then
                                        if not hasCar then
                                            QBCore.Functions.TriggerCallback('inside-gardener:checkMoney', function(hasMoney)
                                            if hasMoney then
                                                QBCore.Functions.SpawnVehicle(Config.CompanyVehicle, function(vehicle)
                                                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                                                -- SetVehicleNumberPlateText(vehicle, "GRD"..tostring(math.random(1000, 9999)))
                                                SetVehicleEngineOn(vehicle, true, true)
                                                QBCore.Functions.Notify('You paid ' ..Config.DepositPrice.. '$ to take out the vehicle', "info")
                                                -- exports['lrp-notify']:Alert("Gardener", 'You paid ' ..Config.DepositPrice.. '$ to take out the vehicle', 2500, 'info')
                                                hasCar = true
                                                Plate = GetVehicleNumberPlateText(vehicle)
                                                end, vector4(GarageSpawnPoint.Pos1.x, GarageSpawnPoint.Pos1.y, GarageSpawnPoint.Pos1.z, GarageSpawnPoint.Pos1.h),false)
                                                inGarageMenu = false
                                                FreezeEntityPosition(ped, false)
                                            else
                                                QBCore.Functions.Notify('You don\'t have enough money!', "error")
                                                -- exports['lrp-notify']:Alert("Gardener", 'You don\'t have enough money!', 2500, 'error')
                                                inGarageMenu = false
                                                FreezeEntityPosition(ped, false)
                                            end
                                            end)
                                        elseif hasCar then
                                            QBCore.Functions.Notify('First, put down the car you pulled out', "info")
                                            -- exports['lrp-notify']:Alert("Gardener", 'First, put down the car you pulled out', 2500, 'info')
                                        end
                                    elseif IsControlJustReleased(0, Keys["8"]) then
                                        if not hasCar then
                                            QBCore.Functions.TriggerCallback('inside-gardener:checkMoney', function(hasMoney)
                                            if hasMoney then
                                                QBCore.Functions.SpawnVehicle(Config.CompanyVehicle, function(vehicle)
                                                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                                                -- SetVehicleNumberPlateText(vehicle, "GRD"..tostring(math.random(1000, 9999)))
                                                SetVehicleEngineOn(vehicle, true, true)
                                                QBCore.Functions.Notify('You paid ' ..Config.DepositPrice.. '$ to take out the vehicle', "success")
                                                -- exports['lrp-notify']:Alert("Gardener", 'You paid ' ..Config.DepositPrice.. '$ to take out the vehicle', 2500, 'success')
                                                hasCar = true
                                                Plate = GetVehicleNumberPlateText(vehicle)
                                                end, vector4(GarageSpawnPoint.Pos2.x, GarageSpawnPoint.Pos2.y, GarageSpawnPoint.Pos2.z, GarageSpawnPoint.Pos2.h),true)
                                                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                                                inGarageMenu = false
                                                FreezeEntityPosition(ped, false)
                                            else
                                                QBCore.Functions.Notify('You don\'t have enough money!', "error")
                                                -- exports['lrp-notify']:Alert("Gardener", 'You don\'t have enough money!', 2500, 'error')
                                                inGarageMenu = false
                                                FreezeEntityPosition(ped, false)
                                            end
                                            end)
                                        elseif hasCar then
                                            QBCore.Functions.Notify('First, put down the car you pulled out', "error")
                                            -- exports['lrp-notify']:Alert("Gardener", 'First, put down the car you pulled out', 2500, 'error')
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
        Citizen.Wait(sleep)
    end
end)

-- OPENING VAN DOORS
Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)

            if hasCar then
                if not IsPedInAnyVehicle(ped, false) then
                    if Plate == GetVehicleNumberPlateText(vehicle) then
                        local trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.0, 0)
                        if (GetDistanceBetweenCoords(coords.x, coords.y, coords.z, trunkpos.x, trunkpos.y, trunkpos.z, true) < 2) then
                            if not hasOpenDoor then
                                sleep = 5
                                DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.4, "~g~[G]~s~ - Open Doors")
                                if IsControlJustReleased(0, Keys["G"]) then
                                    QBCore.Functions.Progressbar("openingdoors", "You're opening the rear doors...." , 1500, false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                        disableInventory = true,
                                    }, {}, {}, {}, function()
                                    end)
                                    Citizen.Wait(1500)
                                    SetVehicleDoorOpen(vehicle, 3, false, false)
                                    SetVehicleDoorOpen(vehicle, 2, false, false)
                                    hasOpenDoor = true
                                end
                            elseif hasOpenDoor then
                                if not hasBlower and not hasLawnMower and not hasTrimmer and not hasBackPack then
                                    sleep = 5
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.7, "~g~[E]~s~ - Leaf Blower | ~g~[H]~s~ Back Pack")
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.5, "~g~[7]~s~ - Trimmer | ~g~[8]~s~ - Lawn Mower")
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.3, "~r~[G]~s~ - Close Doors")
                                    if IsControlJustReleased(0, Keys["G"]) then
                                        QBCore.Functions.Progressbar("closingdoors", "You're closing the rear doors...." , 1500, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                            disableInventory = true,
                                        }, {}, {}, {}, function()
                                        end)
                                        Citizen.Wait(1500)
                                        SetVehicleDoorShut(vehicle, 3, false)
                                        SetVehicleDoorShut(vehicle, 2, false)
                                        hasOpenDoor = false
                                    elseif IsControlJustReleased(0, Keys["E"]) then
                                        QBCore.Functions.Progressbar("leafblower", "You pulling out the Leaf Blower..." , 1500, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                            disableInventory = true,
                                        }, {}, {}, {}, function()
                                        end)
                                        Citizen.Wait(1500)
                                        addLeafBlower()
                                        hasBlower = true
                                    elseif IsControlJustReleased(0, Keys["H"]) then
                                        QBCore.Functions.Progressbar("backpack", "You pulling out the Backpack..." , 1500, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                            disableInventory = true,
                                        }, {}, {}, {}, function()
                                        end)
                                        
                                        Citizen.Wait(1500)
                                        addBackPack()
                                        hasBackPack = true
                                    elseif IsControlJustReleased(0, Keys["7"]) then
                                        QBCore.Functions.Progressbar("trimmer", "You pulling out the Trimmer..." , 1500, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                            disableInventory = true,
                                        }, {}, {}, {}, function()
                                        end)
                                        
                                        Citizen.Wait(1500)
                                        addTrimmer()
                                        hasTrimmer = true
                                    elseif IsControlJustReleased(0, Keys["8"]) then
                                        QBCore.Functions.Progressbar("lawnmower", "You pulling out the Lawn Mower..." , 1500, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                            disableInventory = true,
                                        }, {}, {}, {}, function()
                                        end)
                                        Citizen.Wait(1500)
                                        addLawnMower()
                                        hasLawnMower = true
                                    end
                                elseif hasLawnMower or hasBlower or hasBackPack or hasTrimmer then
                                    sleep = 5
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.5, "~g~[E]~s~ - Put the tool into trunk")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        QBCore.Functions.Progressbar("tool", "You are putting the tool into the trunk..." , 1500, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                            disableInventory = true,
                                        }, {}, {}, {}, function()
                                        end)
                                        Citizen.Wait(1500)
                                        removeLawnMower()
                                        removeBackPack()
                                        removeLeafBlower()
                                        removeTrimmer()
                                        hasLawnMower = false
                                        hasBlower = false
                                        hasTrimmer = false
                                        hasBackPack = false
                                        ClearPedTasks(ped)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

            if Type == 'Rockford Hills' then
                for i, v in ipairs(Config.RockfordHills) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, 'Hi, you want to clean up my garden for ~g~' ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Yeah, sure | ~r~[8]~s~ - No, thanks')
                                if IsControlJustReleased(0, Keys["7"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    QBCore.Functions.Notify('Pull up weeds from the yard', "info")
                                    -- exports['lrp-notify']:Alert("Gardener", 'Pull up weeds from the yard', 5000, 'info')
                                    BlipsWorkingRH()
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Okay, I'll find a better gardener!")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Great! when you're done, let me know, I'll be at the front door")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "You haven't finished cleaning garden")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Now the garden looks great, here's your paycheck")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Take the money')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                QBCore.Functions.Notify("You earned " ..salary.. "$!", "info")
                                                -- exports['lrp-notify']:Alert("Gardener", "You earned " ..salary.. "$!", 2500, 'success')
                                                startAnim(ped, 'mp_common', 'givetake1_a')	
                                                startAnim(v.ped, 'mp_common', 'givetake1_a')
                                                Citizen.Wait(3500)
                                                ClearPedTasks(ped)
                                                CancelWork()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.RockfordHillsWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Tear out the weed")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        QBCore.Functions.Progressbar("gardener_tearing_weed", "Tearing out the weed", 3500, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {
                                            animDict = "amb@world_human_gardener_plant@male@enter",
                                            anim = "enter",
                                            flags = 8,
                                        }, {}, {}, function() -- Done
                                            isWorking = false
                                            StopAnimTask(PlayerPedId(), "amb@world_human_gardener_plant@male@enter", "enter", 1.0)
                                            
                                        end, function() -- Cancel
                                            isWorking = false
                                            StopAnimTask(PlayerPedId(), "amb@world_human_gardener_plant@male@enter", "enter", 1.0)
                                            QBCore.Functions.Notify("Cancelled", "error")
                                            -- QBCore.Functions.Notify("Cancelled", "success")
                                        end)
                                        Citizen.Wait(3500)
                                        v.taked = true
                                        RemoveBlip(v.blip)
                                        done = done + 1
                                        ClearPedTasks(ped)
                                        if done == #Config.RockfordHillsWork then
                                            Paycheck = true
                                            done = 0
                                            AmountPayout = AmountPayout + 1
                                            QBCore.Functions.Notify('The garden is clean, go get your paycheck', "success")
                                            -- exports['lrp-notify']:Alert("Gardener", 'The garden is clean, go get your paycheck', 2500, 'success')
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "West Vinewood" then
                for i, v in ipairs(Config.WestVinewood) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, 'Hello, do you want to plant me trees for ~g~' ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Of course | ~r~[8]~s~ - No way')
                                if IsControlJustReleased(0, Keys["7"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    QBCore.Functions.Notify('Plant trees in the driveway', "success")
                                    -- exports['lrp-notify']:Alert("Gardener", 'Plant trees in the driveway', 5000, 'success')
                                    BlipsWorkingWV()
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Alright, I don't need you anymore!")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "I'll wait near the pool with the money")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "You didn't plant all the trees")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Now just wait until they grow up! keep your paycheck")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Take the money')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                QBCore.Functions.Notify("You earned " ..salary.. "$!", "success")
                                                -- exports['lrp-notify']:Alert("Gardener", "You earned " ..salary.. "$!", 2500, 'success')
                                                startAnim(ped,'mp_common', 'givetake1_a')
                                                startAnim(v.ped, 'mp_common', 'givetake1_a')
                                                Citizen.Wait(3500)
                                                ClearPedTasks(ped)
                                                CancelWork()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.WestVinewoodWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Plant a tree")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        QBCore.Functions.Progressbar("planting_tree", "Planting a tree..", math.random(5000, 10000), false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {
                                            animDict = "amb@world_human_gardener_plant@male@enter",
                                            anim = "enter",
                                            flags = 9,
                                        }, {}, {}, function() -- Done
                                            isWorking = false
                                            StopAnimTask(PlayerPedId(), "amb@world_human_gardener_plant@male@enter", "enter", 1.0)
                                            
                                        end, function() -- Cancel
                                            isWorking = false
                                            StopAnimTask(PlayerPedId(), "amb@world_human_gardener_plant@male@enter", "enter", 1.0)
                                            QBCore.Functions.Notify("Cancelled", "error")
                                            -- QBCore.Functions.Notify("Cancelled", "success")
                                        end)
                                        ClearPedTasks(ped)
                                        v.taked = true
                                        RemoveBlip(v.blip)
                                        done = done + 1
                                        if done == #Config.WestVinewoodWork then
                                            Paycheck = true
                                            done = 0
                                            AmountPayout = AmountPayout + 1
                                            QBCore.Functions.Notify("All trees planted, get your paycheck", "success")
                                            -- exports['lrp-notify']:Alert("Gardener", "All trees planted, get your paycheck", 2500, 'success')
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "Vinewood Hills" then
                for i, v in ipairs(Config.VinewoodHills) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, 'Good Morning Sir, want to earn ~g~' ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Willingly | ~r~[8]~s~ - Falling off')
                                if IsControlJustReleased(0, Keys["7"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    QBCore.Functions.Notify("Pull the Leaf Blower out of the trunk and blow the leaves off the garden", "info")
                                    -- exports['lrp-notify']:Alert("Gardener", "Pull the Leaf Blower out of the trunk and blow the leaves off the garden", 5000, 'info')
                                    BlipsWorkingVH()
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Go away!")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "I'm waiting on the terrace with the money")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "You didn't blow off all the leaves")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Well done, grab the money")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Take the money')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                if not hasBlower then
                                                    TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                    TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                    QBCore.Functions.Notify("You earned " ..salary.. "$!", "success")
                                                    -- exports['lrp-notify']:Alert("Gardener", "You earned " ..salary.. "$!", 2500, 'success')
                                                    startAnim(ped,'mp_common', 'givetake1_a')
                                                    startAnim(v.ped, 'mp_common', 'givetake1_a')
                                                    Citizen.Wait(3500)
                                                    ClearPedTasks(ped)
                                                    CancelWork()
                                                elseif hasBlower then
                                                    QBCore.Functions.Notify("Put the Leaf Blower into trunk", "info")
                                                    -- exports['lrp-notify']:Alert("Gardener", "Put the Leaf Blower into trunk", 2500, 'info')
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.VinewoodHillsWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Blow off the leaves")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if hasBlower then
                                            QBCore.Functions.Progressbar("gardener_blowingoff_leaves", "Blowing off the leaves...", 3500, false, true, {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }, {
                                                animDict = "amb@world_human_gardener_leaf_blower@idle_a",
                                                anim = "idle_a",
                                                flags = 8,
                                            }, {}, {}, function() -- Done
                                                isWorking = false
                                                StopAnimTask(PlayerPedId(), "amb@world_human_gardener_leaf_blower@idle_a", "idle_a", 1.0)
                                                
                                            end, function() -- Cancel
                                                isWorking = false
                                                StopAnimTask(PlayerPedId(), "amb@world_human_gardener_leaf_blower@idle_a", "idle_a", 1.0)
                                                QBCore.Functions.Notify("Cancelled", "error")
                                                -- QBCore.Functions.Notify("Cancelled", "success")
                                            end)
                                            Citizen.Wait(5500)
                                            ClearPedTasks(ped)
                                            v.taked = true
                                            RemoveBlip(v.blip)
                                            done = done + 1
                                            if done == #Config.VinewoodHillsWork then
                                                Paycheck = true
                                                done = 0
                                                AmountPayout = AmountPayout + 1
                                                QBCore.Functions.Notify("All leaves cleared, take cash from the customer", "success")
                                                -- exports['lrp-notify']:Alert("Gardener", "All leaves cleared, take cash from the customer", 2500, 'success')
                                            end
                                        elseif not hasBlower then
                                            QBCore.Functions.Notify("You do not have a Leaf Blower", "error")
                                            -- exports['lrp-notify']:Alert("Gardener", "You do not have a Leaf Blower", 2500, 'error')
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "El Burro Heights" then
                for i, v in ipairs(Config.ElBurroHeights) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, 'E you! You want a quick ~g~' ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Yup | ~r~[8]~s~ - Give it up')
                                if IsControlJustReleased(0, Keys["7"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    QBCore.Functions.Notify("Pull the grass out of the property", "info")
                                    -- exports['lrp-notify']:Alert("Gardener", "Pull the grass out of the property", 5000, 'info')
                                    BlipsWorkingEBH()
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Get out of here!")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "When you're done, let me know ...")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "You haven't pulled all the grass out!")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Hold the money, good job ...")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Take the money')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                QBCore.Functions.Notify("You earned " ..salary.. "$!", "success")
                                                -- exports['lrp-notify']:Alert("Gardener", "You earned " ..salary.. "$!", 2500, 'success')
                                                startAnim(ped,'mp_common', 'givetake1_a')
                                                startAnim(v.ped, 'mp_common', 'givetake1_a')
                                                Citizen.Wait(3500)
                                                ClearPedTasks(ped)
                                                CancelWork()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.ElBurroHeightsWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Pull up the grass")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        QBCore.Functions.Progressbar("gardener_pullinggrass", "Pulling up the grass...", 3500, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {
                                            animDict = "amb@world_human_gardener_plant@male@idle_c",
                                            anim = "idle_c",
                                            flags = 8,
                                        }, {}, {}, function() -- Done
                                            isWorking = false
                                            StopAnimTask(PlayerPedId(), "amb@world_human_gardener_plant@male@idle_c", "idle_c", 1.0)
                                            
                                        end, function() -- Cancel
                                            isWorking = false
                                            StopAnimTask(PlayerPedId(), "amb@world_human_gardener_plant@male@idle_c", "idle_c", 1.0)
                                            
                                            QBCore.Functions.Notify("Cancelled", "success")
                                        end)
                                        Citizen.Wait(5500)
                                        ClearPedTasks(ped)
                                        v.taked = true
                                        RemoveBlip(v.blip)
                                        done = done + 1
                                        if done == #Config.ElBurroHeightsWork then
                                            Paycheck = true
                                            done = 0
                                            AmountPayout = AmountPayout + 1
                                            QBCore.Functions.Notify("You pulled all the grass, go get the money", "success")
                                            -- exports['lrp-notify']:Alert("Gardener", "You pulled all the grass, go get the money", 2500, 'success')
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "Richman" then
                for i, v in ipairs(Config.Richman) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, 'Good Morning buddy, you want to get rich by ~g~' ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Okay | ~r~[8]~s~ - I have no time')
                                if IsControlJustReleased(0, Keys["7"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    QBCore.Functions.Notify("Pull the Trimmer out of the trunk and Trim the client's hedge", "success")
                                    -- exports['lrp-notify']:Alert("Gardener", "Pull the Trimmer out of the trunk and Trim the client's hedge", 5000, 'success')
                                    BlipsWorkingRM()
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "No problem, have a nice day")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "I'll wait at the door")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "You didn't trim the entire hedge")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Here is the money, you are the best!")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Take the money')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                if not hasTrimmer then
                                                    TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                    TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                    QBCore.Functions.Notify("You earned " ..salary.. "$!", "success")
                                                    -- exports['lrp-notify']:Alert("Gardener", "You earned " ..salary.. "$!", 2500, 'success')
                                                    startAnim(ped,'mp_common', 'givetake1_a')
                                                    startAnim(v.ped, 'mp_common', 'givetake1_a')
                                                    Citizen.Wait(3500)
                                                    ClearPedTasks(ped)
                                                    CancelWork()
                                                elseif hasTrimmer then
                                                    QBCore.Functions.Notify("Put the Trimmer into trunk", "info")
                                                    -- exports['lrp-notify']:Alert("Gardener", "Put the Trimmer into trunk", 2500, 'info')
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.RichmanWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Trim hedge")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if hasTrimmer then
                                            QBCore.Functions.Progressbar("gardener_pullinggrass", "Pulling up the grass...", 3500, false, true, {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }, {
                                                animDict = "anim@mp_radio@garage@high",
                                                anim = "idle_c",
                                                flags = 8,
                                            }, {}, {}, function() -- Done
                                                isWorking = false
                                                StopAnimTask(PlayerPedId(), "anim@mp_radio@garage@high", "idle_a", 1.0)
                                                
                                            end, function() -- Cancel
                                                isWorking = false
                                                StopAnimTask(PlayerPedId(), "anim@mp_radio@garage@high", "idle_a", 1.0)
                                                QBCore.Functions.Notify("Cancelled", "success")
                                            end)
                                            
                                            Citizen.Wait(5500)
                                            ClearPedTasks(ped)
                                            v.taked = true
                                            RemoveBlip(v.blip)
                                            done = done + 1
                                            if done == #Config.RichmanWork then
                                                Paycheck = true
                                                done = 0
                                                AmountPayout = AmountPayout + 1
                                                QBCore.Functions.Notify("Hedge is done, get your paycheck", "success")
                                                -- exports['lrp-notify']:Alert("Gardener", "Hedge is done, get your paycheck", 2500, 'success')
                                            end
                                        elseif not hasTrimmer then
                                            QBCore.Functions.Notify("You do not have a Trimmer", "error")
                                            -- exports['lrp-notify']:Alert("Gardener", "You do not have a Trimmer", 2500, 'error')
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "Mirror Park" then
                for i, v in ipairs(Config.MirrorPark) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Hi, you don't want to mow your lawn for ~g~" ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, "~g~[7]~s~ - All right | ~r~[8]~s~ - I'm in a hurry")
                                if IsControlJustReleased(0, Keys["7"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    QBCore.Functions.Notify("Pull the Lawn Mower out of the trunk and Mow the grass on the customer's property", "info")
                                    -- exports['lrp-notify']:Alert("Gardener", "Pull the Lawn Mower out of the trunk and Mow the grass on the customer's property", 5000, 'info')
                                    BlipsWorkingMP()
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "It's good that there are many gardeners in this city...")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "When you are finished, come for the payment")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "You haven't mowed all the grass")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Now this garden makes sense, hold promissed money")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Take the money')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                if not hasLawnMower then
                                                    TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                    TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                    QBCore.Functions.Notify("You earned " ..salary.. "$!", "success")
                                                    -- exports['lrp-notify']:Alert("Gardener", "You earned " ..salary.. "$!", 2500, 'success')
                                                    startAnim(ped,'mp_common', 'givetake1_a')
                                                    startAnim(v.ped, 'mp_common', 'givetake1_a')
                                                    Citizen.Wait(3500)
                                                    ClearPedTasks(ped)
                                                    CancelWork()
                                                elseif hasLawnMower then
                                                    QBCore.Functions.Notify("Put the Lawn Mower into trunk", "info")
                                                    -- exports['lrp-notify']:Alert("Gardener", "Put the Lawn Mower into trunk", 2500, 'info')
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.MirrorParkWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Mow the grass")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if hasLawnMower then
                                            v.taked = true
                                            RemoveBlip(v.blip)
                                            done = done + 1
                                            if done == #Config.MirrorParkWork then
                                                Paycheck = true
                                                done = 0
                                                AmountPayout = AmountPayout + 1
                                                QBCore.Functions.Notify("Grass is done, get your paycheck", "success")
                                                -- exports['lrp-notify']:Alert("Gardener", "Grass is done, get your paycheck", 2500, 'success')
                                            end
                                        elseif not hasLawnMower then
                                            QBCore.Functions.Notify("You do not have a Lawn Mower", "error")
                                            -- exports['lrp-notify']:Alert("Gardener", "You do not have a Lawn Mower", 2500, 'error')
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "East Vinewood" then
                for i, v in ipairs(Config.EastVinewood) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Yo, you don't want to water my plants for ~g~" ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, "~g~[7]~s~ - I'm interested | ~r~[8]~s~ - I'm not interested")
                                if IsControlJustReleased(0, Keys["7"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    QBCore.Functions.Notify("Pull the Back Pack out of the trunk and Water the plants in the customer's backyard", "info")
                                    -- exports['lrp-notify']:Alert("Gardener", "Pull the Back Pack out of the trunk and Water the plants in the customer's backyard", 5000, 'info')
                                    BlipsWorkingEV()
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Your loss, regret it")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "When you're done, come in for your paycheck")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "You didn't water all the plants")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "They'll grow any minute... Hold your cash")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Take the money')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                if not hasBackPack then
                                                    TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                    TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                    QBCore.Functions.Notify("You earned " ..salary.. "$!", "success")
                                                    -- exports['lrp-notify']:Alert("Gardener", "You earned " ..salary.. "$!", 2500, 'success')
                                                    startAnim(ped,'mp_common', 'givetake1_a')
                                                    startAnim(v.ped, 'mp_common', 'givetake1_a')
                                                    Citizen.Wait(3500)
                                                    ClearPedTasks(ped)
                                                    CancelWork()
                                                elseif hasBackPack then
                                                    QBCore.Functions.Notify("Put the Back Pack into trunk", "error")
                                                    -- exports['lrp-notify']:Alert("Gardener", "Put the Back Pack into trunk", 2500, 'error')
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.EastVinewoodWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Water the plants")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if hasBackPack then
                                            QBCore.Functions.Progressbar("gardener_wateringplants", "Watering the plants", 5500, false, true, {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }, {
                                                animDict = "missarmenian3_gardener",
                                                anim = "blower_idle_a",
                                                flags = 8,
                                            }, {}, {}, function() -- Done
                                                isWorking = false
                                                StopAnimTask(PlayerPedId(), "missarmenian3_gardener", "blower_idle_a", 1.0)
                                                
                                            end, function() -- Cancel
                                                isWorking = false
                                                StopAnimTask(PlayerPedId(), "missarmenian3_gardener", "blower_idle_a", 1.0)
                                                QBCore.Functions.Notify("Cancelled", "success")
                                            end)
                                            Citizen.Wait(5500)
                                            ClearPedTasks(ped)
                                            v.taked = true
                                            RemoveBlip(v.blip)
                                            done = done + 1
                                            if done == #Config.EastVinewoodWork then
                                                Paycheck = true
                                                done = 0
                                                AmountPayout = AmountPayout + 1
                                                QBCore.Functions.Notify("You watered all the plants, it's time to pay", "success")
                                                -- exports['lrp-notify']:Alert("Gardener", "You watered all the plants, it's time to pay", 2500, 'success')
                                            end
                                        elseif not hasBackPack then
                                            QBCore.Functions.Notify("You do not have a Back Pack", "error")
                                            -- exports['lrp-notify']:Alert("Gardener", "You do not have a Back Pack", 2500, 'error')
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

function CreateWork(type)

    if type == "Rockford Hills" then
        for i, v in ipairs(Config.RockfordHills) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Gardener] Workplace')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "West Vinewood" then
        for i, v in ipairs(Config.WestVinewood) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Gardener] Workplace')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "Vinewood Hills" then
        for i, v in ipairs(Config.VinewoodHills) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Gardener] Workplace')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "El Burro Heights" then
        for i, v in ipairs(Config.ElBurroHeights) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Gardener] Workplace')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "Richman" then
        for i, v in ipairs(Config.Richman) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Gardener] Workplace')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "Mirror Park" then
        for i, v in ipairs(Config.MirrorPark) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Gardener] Workplace')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "East Vinewood" then
        for i, v in ipairs(Config.EastVinewood) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Gardener] Workplace')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    end
    Type = type
end

function CancelWork()

    if Type == "Rockford Hills" then
        for i, v in ipairs(Config.RockfordHills) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.RockfordHillsWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "West Vinewood" then
        for i, v in ipairs(Config.WestVinewood) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.WestVinewoodWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "Vinewood Hills" then
        for i, v in ipairs(Config.VinewoodHills) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.VinewoodHillsWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "El Burro Heights" then
        for i, v in ipairs(Config.ElBurroHeights) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.ElBurroHeightsWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "Richman" then
        for i, v in ipairs(Config.Richman) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.RichmanWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "Mirror Park" then
        for i, v in ipairs(Config.MirrorPark) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.MirrorParkWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "East Vinewood" then
        for i, v in ipairs(Config.EastVinewood) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.EastVinewoodWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    end
    Type = nil
    appointed = false
    wasTalked = false
    waitingDone = false
    CanWork = false
    Paycheck = false
    salary = nil
    AmountPayout = 0
    done = 0
end

function startAnim(ped, dictionary, anim)
	Citizen.CreateThread(function()
	  RequestAnimDict(dictionary)
	  while not HasAnimDictLoaded(dictionary) do
		Citizen.Wait(0)
	  end
		TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)

		RequestAnimDict(dictionary)
		while not HasAnimDictLoaded(dictionary) do
		  Citizen.Wait(0)
		end
		  TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)

		  RequestAnimDict(dictionary)
		  while not HasAnimDictLoaded(dictionary) do
			Citizen.Wait(0)
		  end
			TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
	end)
end

function BlipsWorkingRH()
    for i, v in ipairs(Config.RockfordHillsWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Gardener] Weeds')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingWV()
    for i, v in ipairs(Config.WestVinewoodWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Gardener] Trees')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingVH()
    for i, v in ipairs(Config.VinewoodHillsWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Gardener] Leaves')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingEBH()
    for i, v in ipairs(Config.ElBurroHeightsWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Gardener] Grass')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingRM()
    for i, v in ipairs(Config.RichmanWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Gardener] Hedge')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingMP()
    for i, v in ipairs(Config.MirrorParkWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Gardener] Grass to mow')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingEV()
    for i, v in ipairs(Config.EastVinewoodWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Gardener] Watering plants')
        EndTextCommandSetBlipName(v.blip)
    end
end

function addBackPack()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    backpack = CreateObject(GetHashKey('prop_spray_backpack_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(backpack, ped, GetPedBoneIndex(ped, 56604), 0.0, -0.12, 0.28, 0.0, 0.0, 180.0, true, true, false, true, 1, true)
end

function removeBackPack()
    local ped = PlayerPedId()

    DeleteEntity(backpack)
end

function addLawnMower()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    RequestAnimDict("anim@heists@box_carry@")
    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
        Citizen.Wait(7)
    end
    TaskPlayAnim(ped, "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
    lawnmower = CreateObject(GetHashKey('prop_lawnmower_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(lawnmower, ped, GetPedBoneIndex(ped, 56604), -0.05, 1.0, -0.85, 0.0, 0.0, 180.0, true, true, false, true, 1, true)
end

function removeLawnMower()
    local ped = PlayerPedId()

    DeleteEntity(lawnmower)
end

function addTrimmer()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    trimmer = CreateObject(GetHashKey('prop_hedge_trimmer_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(trimmer, ped, GetPedBoneIndex(ped, 57005), 0.09, 0.02, 0.01, -121.0, 181.0, 187.0, true, true, false, true, 1, true)
end

function removeTrimmer()
    local ped = PlayerPedId()

    DeleteEntity(trimmer)
end

function addLeafBlower()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    leafblower = CreateObject(GetHashKey('prop_leaf_blower_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(leafblower, ped, GetPedBoneIndex(ped, 57005), 0.14, 0.02, 0.0, -40.0, -40.0, 0.0, true, true, false, true, 1, true)
end

function removeLeafBlower()
    local ped = PlayerPedId()

    DeleteEntity(leafblower)
end

-- RETURNING VEHICLE
function ReturnVehicle()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)

    QBCore.Functions.DeleteVehicle(vehicle)
end

-- MAIN BLIP
Citizen.CreateThread(function()
    baseBlip = AddBlipForCoord(Base.Pos.x, Base.Pos.y, Base.Pos.z)
    SetBlipSprite(baseBlip, Base.BlipSprite)
    SetBlipDisplay(baseBlip, 4)
    SetBlipScale(baseBlip, Base.BlipScale)
    SetBlipAsShortRange(baseBlip, true)
    SetBlipColour(baseBlip, Base.BlipColor)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Base.BlipLabel)
    EndTextCommandSetBlipName(baseBlip)
end)

-- ADDING GARAGES BLIPS
function addGarageBlip()
    garageBlip = AddBlipForCoord(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z)
    SetBlipSprite(garageBlip, Garage.BlipSprite)
    SetBlipDisplay(garageBlip, 4)
    SetBlipScale(garageBlip, Garage.BlipScale)
    SetBlipAsShortRange(garageBlip, true)
    SetBlipColour(garageBlip, Garage.BlipColor)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Garage.BlipLabel)
    EndTextCommandSetBlipName(garageBlip)
end

-- REMOVING GARAGES BLIPS
function removeGarageBlip()
    RemoveBlip(garageBlip)
end

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

function DrawText3DMenu(x, y, z, text)
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
    DrawRect(0.0, 0.02+0.0125, -0.14+ factor, 0.08, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function DrawText3Dss(x, y, z, text)
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
    DrawRect(0.0, 0.0+0.0125, 0.008+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end