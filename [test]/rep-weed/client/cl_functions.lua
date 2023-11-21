Core = exports[Config.Framework]:GetCoreObject()

function Notification(msg, type, time)
    Core.Functions.Notify(msg, type, time)
end

function policeAlert(type)
    if type == 'cornering' then
        -- police alert for cornering here
        -- exports['ps-dispatch']:SuspiciousActivity() -- Project-Sloth ps-dispatch
        -- exports['qb-dispatch']:Oxy() -- Project-SLoth qb-dispatch
        -- TriggerServerEvent('police:server:policeAlert', 'Suspicious Hand-off') -- Regular qbcore
    else
        -- policeAlert for Weed Run here
        -- exports['ps-dispatch']:SuspiciousActivity() -- Project-SLoth ps-dispatch
        -- exports['qb-dispatch']:Oxy() -- Project-SLoth qb-dispatch
        -- TriggerServerEvent('police:server:policeAlert', 'Suspicious Hand-off') -- Regular qbcore
    end
    -- These are just examples, you will have to implement your own preferred dispatch service!
end

function showTextUi(msg)
    TriggerEvent('qb-core:client:DrawText', msg)
end

function hideTextUi()
    TriggerEvent('qb-core:client:HideText')
end

function Effect(lvl)
    Wait(5000)
    if not lvl then
        lvl = 0
    end
    CreateThread(function()
        local ped = PlayerPedId()
        while true do
            if IsEntityPlayingAnim(ped, "amb@world_human_aa_smoke@male@idle_a", "idle_b", 3) or IsPedUsingScenario(ped, 'WORLD_HUMAN_SMOKING_POT') then
                TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
                SetPedArmour(ped, GetPedArmour(ped) + math.random(Config.Corner.Effect.AddArmorAmount[lvl].min, Config.Corner.Effect.AddArmorAmount[lvl].max))
            else
                break
            end
            Wait(Config.Corner.Effect.Time * 1000)
        end
    end)
end

RegisterNetEvent('rep-weed:client:joint', function(data)
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        RequestModel("amb@world_human_aa_smoke@male@idle_a")
        while not HasModelLoaded("amb@world_human_aa_smoke@male@idle_a") do
            Wait(0)
        end
        local plyCoords = GetEntityCoords(ped)
        local weedObject = CreateObjectNoOffset("prop_cs_ciggy_01", plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 0)
        SetObjectAsNoLongerNeeded(weedObject)
        AttachEntityToEntity(weedObject, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
        TaskPlayAnim(ped, 'amb@world_human_aa_smoke@male@idle_a', 'idle_b', 8.0, -8, -1, 49, 0, 0, 0, 0)
    else
        ClearPedTasks(ped)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING_POT", 0, true)
    end
    local lvl = 0
    TriggerServerEvent('rep-weed:server:joint', data)
    if Config.OxInventory then
        if data.metadata and data.metadata.n and data.metadata.p and data.metadata.k then
            local strain = getStrain(data.metadata.n, data.metadata.p, data.metadata.k)
            if strain then
                local max = -99
                for k, v in pairs(Config.RepString) do
                    local rep = tonumber(v.rep)
                    if rep <= strain.rep and max < rep then
                        lvl = k
                    end
                end
            end
        end
    else
        if data.info and data.info.n and data.info.p and data.info.k then
            local strain = getStrain(data.info.n, data.info.p, data.info.k)
            if strain then
                local max = -99
                for k, v in pairs(Config.RepString) do
                    local rep = tonumber(v.rep)
                    if rep <= strain.rep and max < rep then
                        lvl = k
                    end
                end
            end
        end
    end
    Effect(lvl)
end)


-- Police
RegisterNetEvent('police:SetCopCount', function(amount) -- Update your police count
    CurrentCops = amount
end)

CreateThread(function()
    if Config.OxInventory then
        exports.ox_inventory:displayMetadata({
            strain = 'Strain',
            dry = 'Dry',
            water = 'Water',
            remainweight = 'Weights Left'
        })
    end
end)
