local targetSystem

if Config.Framework == "QBCore" then
    targetSystem = "qb-target"
else
    targetSystem = "qtarget"
end

function SpawnPeds()
    local model = `a_m_m_bevhills_02`
    RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(50)
	end
    
    spawnedPed = CreatePed(0, model, Config.Locations.DutyToggle.Coords[1].x, Config.Locations.DutyToggle.Coords[1].y, Config.Locations.DutyToggle.Coords[1].z - 1.0, 66.74, false, true)
    DecorSetBool(spawnedPed, "entityIsNeeded", true)

    FreezeEntityPosition(spawnedPed, true)
    SetBlockingOfNonTemporaryEvents(spawnedPed, true)
    SetEntityInvincible(spawnedPed, true)
    exports[targetSystem]:AddTargetEntity(spawnedPed, {
        options = {
            {
                event = "multiplayerLumberjack:OpenMainMenu",
                icon = "fa-solid fa-handshake-simple",
                label = "Start Job",
                -- job = "RequiredJob",
                canInteract = function(entity)
                    return #(GetEntityCoords(PlayerPedId()) - vec3(Config.Locations.DutyToggle.Coords[1].x, Config.Locations.DutyToggle.Coords[1].y, Config.Locations.DutyToggle.Coords[1].z)) < 5.0
                end
            },
        },
        distance = 2.5
    })

    local model2 = `a_m_m_rurmeth_01`
    RequestModel(model2)
	while not HasModelLoaded(model2) do
		Citizen.Wait(50)
	end

    rentForkliftPed = CreatePed(0, model2, Config.Locations.rentForklift.Coords[1].x, Config.Locations.rentForklift.Coords[1].y, Config.Locations.rentForklift.Coords[1].z - 1.0, 182.1, false, true)
    DecorSetBool(rentForkliftPed, "entityIsNeeded", true)

    FreezeEntityPosition(rentForkliftPed, true)
    SetBlockingOfNonTemporaryEvents(rentForkliftPed, true)
    SetEntityInvincible(rentForkliftPed, true)
    exports[targetSystem]:AddTargetEntity(rentForkliftPed, {
        options = {
            {
                event = "muliplayerLumberjack:OpenForkliftMenu",
                icon = "fa-solid fa-handshake-simple",
                label = "Rent Forklift",
                -- job = "RequiredJob",
                canInteract = function(entity)
                    return OnDuty and #(GetEntityCoords(PlayerPedId()) - vec3(Config.Locations.rentForklift.Coords[1].x, Config.Locations.rentForklift.Coords[1].y, Config.Locations.rentForklift.Coords[1].z)) < 5.0
                end
            },
        },
        distance = 2.5
    })

    local model3 = `a_m_m_salton_02`
    RequestModel(model3)
	while not HasModelLoaded(model3) do
		Citizen.Wait(50)
	end

    truckPed = CreatePed(0, model3, Config.Locations.WithdrawTruck.Coords[1].x, Config.Locations.WithdrawTruck.Coords[1].y, Config.Locations.WithdrawTruck.Coords[1].z - 1.0, 69.96, false, true)
    DecorSetBool(truckPed, "entityIsNeeded", true)

    FreezeEntityPosition(truckPed, true)
    SetBlockingOfNonTemporaryEvents(truckPed, true)
    SetEntityInvincible(truckPed, true)
    exports[targetSystem]:AddTargetEntity(truckPed, {
        options = {
            {
                event = "muliplayerLumberjack:OpenTruckMenu",
                icon = "fa-solid fa-handshake-simple",
                label = "Rent Truck",
                -- job = "RequiredJob",
                canInteract = function(entity)
                    return OnDuty and #(GetEntityCoords(PlayerPedId()) - vec3(Config.Locations.WithdrawTruck.Coords[1].x, Config.Locations.WithdrawTruck.Coords[1].y, Config.Locations.WithdrawTruck.Coords[1].z)) < 5.0
                end
            },
        },
        distance = 2.5
    })
end

RegisterNetEvent("multiplayerLumberjack:OpenMainMenu", function()
    OpenDutyMenu()
end)

RegisterNetEvent("muliplayerLumberjack:OpenForkliftMenu", function()
    local configArr = Config.Panels["rentForklift"]
    SendNUIMessage({
        action = "showCustomPanel",
        callbackName = "rentForklift",
        tittle = configArr.tittle,
        subtittle = configArr.subtittle,
        content = configArr.content,
        img = "assets/rentForkliftPhoto.webp",
        confirmBtn = configArr.confirmBtn, 
        closeBtn = configArr.closeBtn,
    })
    SetNuiFocus(true, true)
end)

RegisterNetEvent("muliplayerLumberjack:OpenTruckMenu", function()
    local configArr = Config.Panels["rentTruck"]
    SendNUIMessage({
        action = "showCustomPanel",
        callbackName = "withdrawTruck",
        tittle = configArr.tittle,
        subtittle = configArr.subtittle,
        content = configArr.content,
        img = "assets/rentTruckPhoto.webp",
        confirmBtn = configArr.confirmBtn, 
        closeBtn = configArr.closeBtn,
    })
    SetNuiFocus(true, true)
end)

function DeleteTreeFromTarget(entity)
    exports[targetSystem]:RemoveTargetEntity(entity)
end

function AddTreeToTarget(entity, array)
    exports[targetSystem]:AddTargetEntity(entity, {
        options = {
            {
                icon = "fa-solid fa-tree",
                label = "Cut down tree",
                -- job = "RequiredJob",
                action = function()
                    CutDownTree(array) 
                end,
            },
        },
        distance = 1.5
    })
end