local QBCore = exports['lrp-core']:GetCoreObject()

local JobStart = Config.Warehouse.JobStart
local Boss = Config.Warehouse.Boss
local Garage = Config.Warehouse.Garage
local GarageSpawnPoint = Config.Warehouse.GarageSpawnPoint
local PostOP = Config.Warehouse.PostOP
local GoPostal = Config.Warehouse.GoPostal
local AlphaMail = Config.Warehouse.AlphaMail
local IKEA = Config.Warehouse.IKEA
local PackageMarker = Config.Warehouse.PackageMarker
local HasRandomBox = nil
local Type = nil
local Plate = nil
local createdPed = false
local jobPed = nil
local done, AmountPayout = 0, 0

onDuty = false
hasCar = false
hasOpenDoor = false
hasBox = false

exports['lrp-target']:AddTargetModel(`hc_driver`, {
    options = {
        {
            event = "inside-warehouse:startJob",
            icon = "fas fa-sign-in-alt",
            label = "Sign In Warehouse Job",
        },
        {
            event = "inside-warehouse:stopJob",
            icon = "fas fa-sign-out-alt",
            label = "Sign Off Warehouse Job",
        },
        {
            event = "inside-warehouse:cancelErrand",
            icon = "fas fa-times",
            label = "Cancel Errand",
        },
        {
            event = "inside-warehouse:getJob",
            icon = "fas fa-search-plus",
            label = "Find Another Errand",
        },
    },
    distance = 10.0
})

RegisterNetEvent("inside-warehouse:startJob", function()
    if not onDuty then
        onDuty = true
        QBCore.Functions.Notify("You signed in!","success", 3000)
        GetErrand()
    else
        QBCore.Functions.Notify("You are already on duty!","error", 3000) 
    end
end)

RegisterNetEvent("inside-warehouse:getJob", function()
    if onDuty then
        GetErrand()
    else
        QBCore.Functions.Notify("You are not on duty!","error", 3000) 
    end
end)




RegisterNetEvent("inside-warehouse:stopJob", function()
    local salary = Config.Payout * AmountPayout
    if onDuty then
        if AmountPayout == HasRandomBox then
            if not hasCar then
                TriggerServerEvent('inside-warehouse:Payout', salary)
                RemoveBlip(garageBlip)
                AmountPayout = 0
                done = 0
                HasRandomBox = nil
            elseif hasCar then
                QBCore.Functions.Notify('Put the vehicle into garage',"error", 3000)
            end
        end    
        onDuty = false
        QBCore.Functions.Notify("You signed off!","success", 3000)
    else
        QBCore.Functions.Notify("You are already off!","error", 3000)
    end
end)

RegisterNetEvent("inside-warehouse:cancelErrand", function()
    if HasRandomBox and AmountPayout == 0 then
        if not hasCar then
            done = 0
            Type = nil
            HasRandomBox = nil
            DeleteCompanyBlip()
            RemoveBlip(garageBlip)
            for i, v in ipairs(Config.WarehouseSpots) do
                v.taked = true
                RemoveBlip(v.blip)
            end
            QBCore.Functions.Notify("You're canceled the errand","success", 3000)
        elseif hasCar then
            QBCore.Functions.Notify("Put the vehicle into garage","error", 3000)
        end
    else
        QBCore.Functions.Notify("You don't have an errand!","error", 3000)
    end
end)

function GetErrand()
    if not HasRandomBox then
        HasRandomBox = math.random(6, 16)
        Companies = Randomize(Config.Companies)
        CreateWork(Companies.CompanyName)
        addBlipsHRB()
        QBCore.Functions.Notify("You have to collect " ..HasRandomBox.. " packages from the warehouse. Take the " ..Companies.CompanyName.. " vehicle from the garage and start!","success", 10000)
    end
end

function DeleteJobPed(ped)
	SetBlockingOfNonTemporaryEvents(ped, false)
	SetPedDiesWhenInjured(ped, true)
	SetEntityInvincible(ped, false)
	FreezeEntityPosition(ped, false)
	DeletePed(ped)
	createdPed = false
end

function CreateJobPed(hash,x,y,z)
	local ped_hash = GetHashKey(hash)
	RequestModel(ped_hash)
	while not HasModelLoaded(ped_hash) do
		Citizen.Wait(1)
	end
	jobPed = CreatePed(1, ped_hash, x,y,z, 180.0, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	SetPedDiesWhenInjured(jobPed, false)
	SetPedCanPlayAmbientAnims(jobPed, true)
	SetPedCanRagdollFromPlayerImpact(jobPed, false)
	SetEntityInvincible(jobPed, true)
	PlaceObjectOnGroundProperly(jobPed)
	FreezeEntityPosition(jobPed, true)
	createdPed = true
	return jobPed
end

-- STARTING JOB
Citizen.CreateThread(function()
    while true do
        local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
        if (GetDistanceBetweenCoords(coords, JobStart.Pos.x, JobStart.Pos.y, JobStart.Pos.z, true) < 50) then
            if not createdPed then
				jobPed = CreateJobPed("hc_driver",JobStart.Pos.x, JobStart.Pos.y, JobStart.Pos.z-1)
                -- print("created ped")
			end
        else
            if jobPed ~= nil then
            DeleteJobPed(jobPed)
            -- print("deleted ped")
            else
                sleep = 2500
            end 
           
        end
        Citizen.Wait(sleep)
    end
end)

-- BOSS
-- Citizen.CreateThread(function()
--     while true do
--         local sleep = 500
-- 		local ped = PlayerPedId()
-- 		local coords = GetEntityCoords(ped)
--         local salary = Config.Payout * AmountPayout

--             if onDuty then
--                 if not HasRandomBox then
--                     HasRandomBox = math.random(6, 16)
--                     Companies = Randomize(Config.Companies)
--                     CreateWork(Companies.CompanyName)
--                     addBlipsHRB()
--                     QBCore.Functions.Notify("You have to collect " ..HasRandomBox.. " packages from the warehouse. Take the " ..Companies.CompanyName.. " vehicle from the garage and start!", 10000)
--                 elseif HasRandomBox then
--                     if AmountPayout == 0 then
--                         DrawText3Ds(Boss.Pos.x, Boss.Pos.y, Boss.Pos.z + 0.4, "~r~[E]~s~ - Cancel the errand")
--                         if IsControlJustPressed(0, Keys["E"]) then
                            
--                         end
--                     elseif AmountPayout == HasRandomBox then
--                         DrawText3Ds(Boss.Pos.x, Boss.Pos.y, Boss.Pos.z + 0.4, "~g~[E]~s~ - Receive a salary of " ..salary.. "$")
--                         if IsControlJustPressed(0, Keys["E"]) then
--                             if not hasCar then
--                                 QBCore.Functions.Progressbar("calc_paycheck", "You're calculating your paycheck..." , 2000, false, true, {
--                                     disableMovement = true,
--                                     disableCarMovement = true,
--                                     disableMouse = false,
--                                     disableCombat = true,
--                                     disableInventory = true,
--                                 }, {}, {}, {}, function()
--                                 end)
--                                 Citizen.Wait(2000)
--                                 TriggerServerEvent('inside-warehouse:Payout', AmountPayout)
--                                 QBCore.Functions.Notify('You earned ' ..salary.. '$!', 3000)
--                                 RemoveBlip(garageBlip)
--                                 AmountPayout = 0
--                                 done = 0
--                                 HasRandomBox = nil
--                             elseif hasCar then
--                                 QBCore.Functions.Notify('Put the vehicle into garage', 3000)
            
--                             end
--                         end
--                     end
--                 end
--             end
--         Citizen.Wait(sleep)
--     end
-- end)
-- CAR DEPOSIT
Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

            if HasRandomBox then
                if (GetDistanceBetweenCoords(coords, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z, true) < Config.DrawDistance) then
                    sleep = 5
                    DrawMarker(Garage.Type, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Garage.Size.x, Garage.Size.y, Garage.Size.z, Garage.Color.r, Garage.Color.g, Garage.Color.b, 100, false, true, 2, false, false, false, false)
                    if (GetDistanceBetweenCoords(coords, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z, true) < 2.5) then
                        if IsPedInAnyVehicle(ped, false) then
                            DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.4, '~r~[E]~s~ - Return vehicle')
                            if IsControlJustReleased(0, Keys["E"]) then
                                if hasCar then
                                    TriggerServerEvent('inside-warehouse:returnVehicle')
                                    ReturnVehicle()
                                    QBCore.Functions.Notify('You received ' ..Config.DepositPrice.. '$ for returning the vehicle',"success", 3000)

                                    hasCar = false
                                    Plate = nil
                                end
                            end
                        elseif not IsPedInAnyVehicle(ped, false) then
                            if not hasCar then
                                DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.4, '~g~[E]~s~ - Take out vehicle')
                            elseif hasCar then
                                DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.4, 'You already have a pulled out vehicle')
                            end
                            if IsControlJustReleased(0, Keys["E"]) then
                                QBCore.Functions.TriggerCallback('inside-warehouse:checkMoney', function(hasMoney, vehicle)
                                if hasMoney then
                                    if Type == "Post OP" then
                                       
                                        QBCore.Functions.SpawnVehicle(Config.CarPostOP, function(vehicle)
                                        
                                            SetVehicleNumberPlateText(vehicle, "WRH"..tostring(math.random(1000, 9999)))
                                            SetVehicleEngineOn(vehicle, true, true)
                                            QBCore.Functions.Notify('You paid ' ..Config.DepositPrice.. '$ to take out the vehicle',"success", 1500)

                                            hasCar = true
                                            Plate = GetVehicleNumberPlateText(vehicle)
                                            BlipsOnWorking()
                                            for i, v in ipairs(Config.WarehouseSpots) do
                                                v.taked = false
                                            end
                                            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vehicle))
                                        end, Config.Warehouse.GarageSpawnPoint, true)

                                    elseif Type == "GoPostal" then
                                        QBCore.Functions.SpawnVehicle(Config.CarGoPostal,  function(vehicle)
                                        SetVehicleNumberPlateText(vehicle, "WRH"..tostring(math.random(1000, 9999)))
                                        SetVehicleEngineOn(vehicle, true, true)
                                        QBCore.Functions.Notify('You paid ' ..Config.DepositPrice.. '$ to take out the vehicle',"success", 1500)

                                        hasCar = true
                                        Plate = GetVehicleNumberPlateText(vehicle)
                                        BlipsOnWorking()
                                        for i, v in ipairs(Config.WarehouseSpots) do
                                            v.taked = false
                                        end
                                        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vehicle))
                                        end, Config.Warehouse.GarageSpawnPoint, true)

                                    elseif Type == "Alpha Mail" then
                                        QBCore.Functions.SpawnVehicle(Config.CarAlphaMail, function(vehicle)
                                        SetVehicleNumberPlateText(vehicle, "WRH"..tostring(math.random(1000, 9999)))
                                        SetVehicleEngineOn(vehicle, true, true)
                                        QBCore.Functions.Notify('You paid ' ..Config.DepositPrice.. '$ to take out the vehicle',"success", 1500)
                                        hasCar = true
                                        Plate = GetVehicleNumberPlateText(vehicle)
                                        BlipsOnWorking()
                                        for i, v in ipairs(Config.WarehouseSpots) do
                                            v.taked = false
                                        end
                                        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vehicle))
                                        end, Config.Warehouse.GarageSpawnPoint, true)

                                    elseif Type == "IKEA" then
                                        QBCore.Functions.SpawnVehicle(Config.CarDefault, function(vehicle)
                                        SetVehicleNumberPlateText(vehicle, "WRH"..tostring(math.random(1000, 9999)))
                                        SetVehicleEngineOn(vehicle, true, true)
                                        QBCore.Functions.Notify('You paid ' ..Config.DepositPrice.. '$ to take out the vehicle',"success", 1500)
                                        hasCar = true
                                        Plate = GetVehicleNumberPlateText(vehicle)
                                        BlipsOnWorking()
                                        for i, v in ipairs(Config.WarehouseSpots) do
                                            v.taked = false
                                        end
                                        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vehicle))
                                        end, Config.Warehouse.GarageSpawnPoint, true)
                                    end
                                end
                                end)
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
                        local trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -3.5, 0)
                        if (GetDistanceBetweenCoords(coords.x, coords.y, coords.z, trunkpos.x, trunkpos.y, trunkpos.z, true) < 2) then
                            sleep = 5
                            if not hasOpenDoor and not hasBox then
                                sleep = 5
                                DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.4, "~g~[G]~s~ - Open Doors")
                                if IsControlJustReleased(0, Keys["G"]) then
                                    QBCore.Functions.Progressbar("open_doors", "You're opening the rear doors", 1500, false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                        disableInventory = true,
                                    })
                                    Citizen.Wait(1500)
                                    SetVehicleDoorOpen(vehicle, 3, false, false)
                                    SetVehicleDoorOpen(vehicle, 2, false, false)
                                    hasOpenDoor = true
                                end
                            elseif hasOpenDoor then
                                sleep = 5
                                DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.25, "Packages: ~g~" ..done.. "/" ..HasRandomBox.. "~s~")
                                if not hasBox and done == 0 then
                                    sleep = 5
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.4, "~r~[G]~s~ - Close Doors")
                                    if IsControlJustReleased(0, Keys["G"]) then
                                        QBCore.Functions.Progressbar("closing_doors", "You're closing the rear doors", 1500, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                            disableInventory = true,
                                        })
                                        Citizen.Wait(1500)
                                        SetVehicleDoorShut(vehicle, 3, false)
                                        SetVehicleDoorShut(vehicle, 2, false)
                                        hasOpenDoor = false
                                    end
                                elseif not hasBox then
                                    sleep = 5
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.4, "~r~[G]~s~ - Close Doors | ~r~[E]~s~ - Take package out")
                                    if IsControlJustReleased(0, Keys["G"]) then
                                        QBCore.Functions.Progressbar("closing_doors1", "You're closing the rear doors", 1500, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                            disableInventory = true,
                                        })
                                        Citizen.Wait(1500)
                                        SetVehicleDoorShut(vehicle, 3, false)
                                        SetVehicleDoorShut(vehicle, 2, false)
                                        hasOpenDoor = false
                                    elseif IsControlJustReleased(0, Keys["E"]) then
                                        QBCore.Functions.Progressbar("picking_package", "You're picking package...", 1500, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                            disableInventory = true,
                                        })
                                        Citizen.Wait(1500)
                                        addPackage()
                                        hasBox = true
                                        done = done - 1
                                    end
                                elseif hasBox then
                                    sleep = 5
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.4, "~g~[E]~s~ - Put package in")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        QBCore.Functions.Progressbar("putting_package", "You're putting package...", 1500, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                            disableInventory = true,
                                        })
                                        Citizen.Wait(1500)
                                        removePackage()
                                        hasBox = false
                                        done = done + 1
                                        if done == HasRandomBox then
                                        QBCore.Functions.Notify("You collected all boxes from base, now deliver it to " ..Companies.CompanyName.. ' company!',"success", 5000)

                                            if Type == "GoPostal" then
                                                SetNewWaypoint(GoPostal.Pos.x, GoPostal.Pos.y, GoPostal.Pos.z)
                                            elseif Type == "Post OP" then
                                                SetNewWaypoint(PostOP.Pos.x, PostOP.Pos.y, PostOP.Pos.z)
                                            elseif Type == "Alpha Mail" then
                                                SetNewWaypoint(AlphaMail.Pos.x, AlphaMail.Pos.y, AlphaMail.Pos.z)
                                            elseif Type == "IKEA" then
                                                SetNewWaypoint(IKEA.Pos.x, IKEA.Pos.y, IKEA.Pos.z)
                                            end
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

-- WORKING
Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
        local vheading = GetEntityHeading(vehicle)

            if hasCar then
                for i, v in ipairs(Config.WarehouseSpots) do
                    if HasRandomBox and i > HasRandomBox then break end
                    if not v.taked then
                        if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 40) then
                            sleep = 5
                            DrawMarker(PackageMarker.Type, v.x, v.y, v.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, PackageMarker.Size.x, PackageMarker.Size.y, PackageMarker.Size.z, PackageMarker.Color.r, PackageMarker.Color.g, PackageMarker.Color.b, 100, false, true, 2, false, false, false, false)
                            if not hasBox then
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Pickup package")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if hasOpenDoor then
                                            QBCore.Functions.Progressbar("picking_package1", "You're picking package......", 1500, false, true, {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                                disableInventory = true,
                                            })
                                            Citizen.Wait(1500)
                                            addPackage()
                                            v.taked = true
                                            hasBox = true
                                            RemoveBlip(v.blip)
                                        elseif not hasOpenDoor then
                                        QBCore.Functions.Notify("Open the rear doors in your vehicle!","warning", 5000)

                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if Type == "GoPostal" then
                for i, v in ipairs(Config.GoPostal) do
                    if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 15) then
                        sleep = 5
                        DrawMarker(PackageMarker.Type, v.x, v.y, v.z - 0.85, 0.0, 0.0, 0.0, 0, 0.0, 0.0, PackageMarker.Size.x, PackageMarker.Size.y, PackageMarker.Size.z, PackageMarker.Color.r, PackageMarker.Color.g, PackageMarker.Color.b, 100, false, true, 2, false, false, false, false)
                        if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                            if not hasBox then
                                DrawText3Ds(v.x, v.y, v.z + 0.4, "Take package from vehicle")
                            elseif hasBox then
                                DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Deliver package")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    QBCore.Functions.Progressbar("putting_package1", "You're putting package......", 1500, false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                        disableInventory = true,
                                    })
                                    Citizen.Wait(1500)
                                    removePackage()
                                    hasBox = false
                                    AmountPayout = AmountPayout + 1
                                    if AmountPayout == HasRandomBox then
                                        QBCore.Functions.Notify("You deliver all package to GoPostal, now return vehicle and go to the boss!","success", 5000)

                                        SetNewWaypoint(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z)
                                        Type = nil
                                        DeleteCompanyBlip()
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "Post OP" then
                for i, v in ipairs(Config.PostOP) do
                    if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 15) then
                        sleep = 5
                        DrawMarker(PackageMarker.Type, v.x, v.y, v.z - 0.85, 0.0, 0.0, 0.0, 0, 0.0, 0.0, PackageMarker.Size.x, PackageMarker.Size.y, PackageMarker.Size.z, PackageMarker.Color.r, PackageMarker.Color.g, PackageMarker.Color.b, 100, false, true, 2, false, false, false, false)
                        if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                            if not hasBox then
                                DrawText3Ds(v.x, v.y, v.z + 0.4, "Take package from vehicle")
                            elseif hasBox then
                                DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Deliver package")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    QBCore.Functions.Progressbar("putting_package2", "You're putting package......", 1500, false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                        disableInventory = true,
                                    })
                                    Citizen.Wait(1500)
                                    removePackage()
                                    hasBox = false
                                    AmountPayout = AmountPayout + 1
                                    if AmountPayout == HasRandomBox then
                                        QBCore.Functions.Notify("You deliver all package to Post OP, now return vehicle and go to the boss!","success", 5000)

                                        SetNewWaypoint(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z)
                                        Type = nil
                                        DeleteCompanyBlip()
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "Alpha Mail" then
                for i, v in ipairs(Config.AlphaMail) do
                    if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 15) then
                        sleep = 5
                        DrawMarker(PackageMarker.Type, v.x, v.y, v.z - 0.85, 0.0, 0.0, 0.0, 0, 0.0, 0.0, PackageMarker.Size.x, PackageMarker.Size.y, PackageMarker.Size.z, PackageMarker.Color.r, PackageMarker.Color.g, PackageMarker.Color.b, 100, false, true, 2, false, false, false, false)
                        if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                            if not hasBox then
                                DrawText3Ds(v.x, v.y, v.z + 0.4, "Take package from vehicle")
                            elseif hasBox then
                                DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Deliver package")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    QBCore.Functions.Progressbar("putting_package3", "You're putting package......", 1500, false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                        disableInventory = true,
                                    })
                                    Citizen.Wait(1500)
                                    removePackage()
                                    hasBox = false
                                    AmountPayout = AmountPayout + 1
                                    if AmountPayout == HasRandomBox then
                                        QBCore.Functions.Notify("You deliver all package to Alpha Mail, now return vehicle and go to the boss!","success", 5000)

                                        SetNewWaypoint(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z)
                                        Type = nil
                                        DeleteCompanyBlip()
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "IKEA" then
                for i, v in ipairs(Config.IKEA) do
                    if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 15) then
                        sleep = 5
                        DrawMarker(PackageMarker.Type, v.x, v.y, v.z - 0.85, 0.0, 0.0, 0.0, 0, 0.0, 0.0, PackageMarker.Size.x, PackageMarker.Size.y, PackageMarker.Size.z, PackageMarker.Color.r, PackageMarker.Color.g, PackageMarker.Color.b, 100, false, true, 2, false, false, false, false)
                        if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                            if not hasBox then
                                DrawText3Ds(v.x, v.y, v.z + 0.4, "Take package from vehicle")
                            elseif hasBox then
                                DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Deliver package")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    QBCore.Functions.Progressbar("putting_package4", "You're putting package......", 1500, false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                        disableInventory = true,
                                    })
                                    Citizen.Wait(1500)
                                    removePackage()
                                    hasBox = false
                                    AmountPayout = AmountPayout + 1
                                    if AmountPayout == HasRandomBox then
                                        QBCore.Functions.Notify("You deliver all package to IKEA, now return vehicle and go to the boss!","success", 5000)

                                        SetNewWaypoint(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z)
                                        Type = nil
                                        DeleteCompanyBlip()
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

function Randomize(tb)
	local keys = {}
	for k in pairs(tb) do table.insert(keys, k) end
	return tb[keys[math.random(#keys)]]
end

function CreateWork(type)

    if type == "GoPostal" then
        for i, v in ipairs(Config.GoPostal) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 318)
            SetBlipColour(v.blip, 24)
            SetBlipScale(v.blip, 0.6)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Warehouse] GoPostal')
            EndTextCommandSetBlipName(v.blip)
        end
    elseif type == "Post OP" then
        for i, v in ipairs(Config.PostOP) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 318)
            SetBlipColour(v.blip, 24)
            SetBlipScale(v.blip, 0.6)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Warehouse] Post OP')
            EndTextCommandSetBlipName(v.blip)
        end
    elseif type == "Alpha Mail" then
        for i, v in ipairs(Config.AlphaMail) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 318)
            SetBlipColour(v.blip, 24)
            SetBlipScale(v.blip, 0.6)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Warehouse] Alpha Mail')
            EndTextCommandSetBlipName(v.blip)
        end
    elseif type == "IKEA" then
        for i, v in ipairs(Config.IKEA) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 318)
            SetBlipColour(v.blip, 24)
            SetBlipScale(v.blip, 0.6)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('[Warehouse] IKEA')
            EndTextCommandSetBlipName(v.blip)
        end
    end
    Type = type
end

function DeleteCompanyBlip()
    for i, v in ipairs(Config.PostOP) do
        RemoveBlip(v.blip)
    end
    for i, v in ipairs(Config.GoPostal) do
        RemoveBlip(v.blip)
    end
    for i, v in ipairs(Config.AlphaMail) do
        RemoveBlip(v.blip)
    end
    for i, v in ipairs(Config.IKEA) do
        RemoveBlip(v.blip)
    end
end

-- RETURNING VEHICLE
function ReturnVehicle()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)

    QBCore.Functions.DeleteVehicle(vehicle)
end

-- MAIN BLIP
Citizen.CreateThread(function()
    mainBlip = AddBlipForCoord(JobStart.Pos.x, JobStart.Pos.y, JobStart.Pos.z)
    SetBlipSprite(mainBlip, 365)
    SetBlipDisplay(mainBlip, 4)
    SetBlipScale(mainBlip, JobStart.BlipScale)
    SetBlipAsShortRange(mainBlip, true)
    SetBlipColour(mainBlip, JobStart.BlipColor)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(JobStart.BlipLabel)
    EndTextCommandSetBlipName(mainBlip)
end)

-- AFTER BOSS BLIPS
function addBlipsHRB()
    
    garageBlip = AddBlipForCoord(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z)
    SetBlipSprite(garageBlip, 326)
    SetBlipDisplay(garageBlip, 4)
    SetBlipScale(garageBlip, Garage.BlipScale)
    SetBlipAsShortRange(garageBlip, true)
    SetBlipColour(garageBlip, Garage.BlipColor)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Garage.BlipLabel)
    EndTextCommandSetBlipName(garageBlip)
end

-- WORKING BLIPS
function BlipsOnWorking()
    for i, v in ipairs(Config.WarehouseSpots) do
        if HasRandomBox and i > HasRandomBox then break end
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.3)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Warehouse] Packages')
        EndTextCommandSetBlipName(v.blip)
    end
end

function addPackage()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    RequestAnimDict("anim@heists@box_carry@")
    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
        Citizen.Wait(7)
    end
    TaskPlayAnim(GetPlayerPed(-1), "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
    pack = CreateObject(GetHashKey('prop_cs_cardbox_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(pack, ped, GetPedBoneIndex(ped, 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
end

function removePackage()
    local ped = PlayerPedId()

    ClearPedTasks(ped)
    DeleteEntity(pack)
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
