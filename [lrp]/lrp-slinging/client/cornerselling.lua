local QBCore = exports['lrp-core']:GetCoreObject()
local cornerselling = false
local hasTarget = false
local startLocation = nil
local lastPed = {}
local stealingPed = nil
local stealData = {}
local availableDrugs = {}
local policeMessage = {
    Lang:t("info.suspicious_situation"),
    Lang:t("info.possible_drug_dealing"),
}
local startedselling = false
local AlertSend = false

CurrentCops = 0


RegisterNetEvent('qb-drugs:client:cornerselling', function(data)
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    
    if PlayerJob.name == "police" then
        QBCore.Functions.Notify("You cant sell drugs as a cop!", "error")
    else
        if CurrentCops >= Config.MinimumDrugSalePolice then
            QBCore.Functions.TriggerCallback('qb-drugs:server:cornerselling:getAvailableDrugs', function(result)
                    if result ~= nil then
                        availableDrugs = result
                        if not cornerselling then
                            cornerselling = true
                            startedselling = true
                            AlertSend = false
                            QBCore.Functions.Notify(Lang:t("info.started_selling_drugs"))
                            startLocation = GetEntityCoords(PlayerPedId())
                        else
                            cornerselling = false
                            QBCore.Functions.Notify(Lang:t("info.stopped_selling_drugs"))
                        end
                    else
                        QBCore.Functions.Notify(Lang:t("error.has_no_drugs"), 'error')
                    end
                
            end)
        else
            QBCore.Functions.Notify(Lang:t("error.not_enough_police", {polices = Config.MinimumDrugSalePolice}), "error")
        end
    end
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)


RegisterNetEvent('qb-drugs:client:refreshAvailableDrugs', function(items)
    availableDrugs = items
    if #availableDrugs <= 0 then
        QBCore.Functions.Notify(Lang:t("error.no_drugs_left"), 'error')
        cornerselling = false
    end
end)


function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end
  
function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end


function AddPropToPlayer(ped, prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))
  
    if not HasModelLoaded(prop1) then
      LoadPropDict(prop1)
    end
  
    prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, ped, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    SetModelAsNoLongerNeeded(prop1)
end

local function DrawText3D(x, y, z, text)
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

local function loadAnimDict(dict)
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

local function toFarAway()
    QBCore.Functions.Notify(Lang:t("error.too_far_away"), 'error')
    cornerselling = false
    startedselling = false
    AlertSend = false
    hasTarget = false
    startLocation = nil
    availableDrugs = {}
    Wait(5000)
end




function callPolice(ped)
    PlayAmbientSpeech1(ped, 'GENERIC_FRIGHTENED_HIGH', 'SPEECH_PARAMS_STANDARD')

    local dealerAnimDict = "cellphone@"
    RequestAnimDict(dealerAnimDict)
    while not HasAnimDictLoaded(dealerAnimDict) do
        Wait(0)
    end
    
    TaskPlayAnim(ped, dealerAnimDict, "cellphone_call_listen_base", 1.0, 1.0, -1, 51, 0, false, false, false)
    RemoveAnimDict("cellphone@")
    Wait(100)
    AddPropToPlayer(ped, "prop_npc_phone_02", 28422, 0, 0, 0, 0, 0, 0)

    Wait(5000)
    TriggerEvent("ps-dispatch:client:drugsale")
    hasTarget = false
    AlertSend = true
    SetEntityAsNoLongerNeeded(ped)
    ClearPedTasks(ped)
end



local function SellToPed(ped)

    hasTarget = true
    for i = 1, #lastPed, 1 do
        if lastPed[i] == ped then
            hasTarget = false
            return
        end
    end

    local succesChance = math.random(1, 20)

    local scamChance = math.random(1, 5)

    local getRobbed = math.random(1, 20)

    if succesChance <= 10 then
        hasTarget = false
        return
    elseif succesChance >= 17 and not AlertSend then
        hasTarget = false
        callPolice(ped)
        return
    end

    local drugType = math.random(1, #availableDrugs)
    local bagAmount = math.random(1, availableDrugs[drugType].amount)


    if bagAmount > 15 then
        bagAmount = math.random(1, 7)
    end
    currentOfferDrug = availableDrugs[drugType]


    local ddata = Config.DrugsPrice[currentOfferDrug.item]
    local randomPrice = math.random(ddata.min, ddata.max) * bagAmount
    if scamChance == 5 then
       randomPrice = math.random(3, 10) * bagAmount
    end


    SetEntityAsNoLongerNeeded(ped)
    ClearPedTasks(ped)


    local coords = GetEntityCoords(PlayerPedId(), true)
    local pedCoords = GetEntityCoords(ped)
    local pedDist = #(coords - pedCoords)



    --[[if getRobbed == 18 or getRobbed == 9 then
        TaskGoStraightToCoord(ped, coords, 15.0, -1, 0.0, 0.0)
    else
        TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
    end]]--

    local inveh = false

    if pedDist > 1.5 then
        inveh = IsPedInAnyVehicle(PlayerPedId())
        if not inveh then
            if getRobbed == 18 or getRobbed == 9 then
                TaskGoStraightToCoord(ped, coords, 15.0, -1, 0.0, 0.0)
            else
                TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
            end
            TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
            pedDist = #(coords - pedCoords)
        elseif inveh then
            local veh = GetVehiclePedIsIn(PlayerPedId(), 0)
            local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(veh)

            if maxSeats == 4 then
                if IsVehicleSeatFree(veh, 0) then
                    freeSeat = 0
                elseif IsVehicleSeatFree(veh, 1) then
                    freeSeat = 1
                elseif IsVehicleSeatFree(veh, 2) then
                    freeSeat = 2
                else
                    TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
                end
            elseif maxSeats == 2 then
                if IsVehicleSeatFree(veh, 0) then
                    freeSeat = 0
                else
                    TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
                end
            end

            ClearPedTasksImmediately(ped)
            TaskEnterVehicle(ped, veh, -1, freeSeat, 1.0, 0)
            pedDist = #(coords - pedCoords)
        end
    end


    while pedDist > 1.5 do
        coords = GetEntityCoords(PlayerPedId(), true)
        pedCoords = GetEntityCoords(ped)
        
        pedDist = #(coords - pedCoords)
        Wait(100)
    end

    if not inveh then
        print("cunt")
        TaskLookAtEntity(ped, PlayerPedId(), 5500.0, 2048, 3)
        TaskTurnPedToFaceEntity(ped, PlayerPedId(), 5500)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, false)
    end

    if hasTarget then
        while pedDist < 1.5 do

            coords = GetEntityCoords(PlayerPedId(), true)
            pedCoords = GetEntityCoords(ped)
            pedDist = #(coords - pedCoords)
            if getRobbed == 18 or getRobbed == 9 and pedDist < 1.1 then
                TriggerServerEvent('qb-drugs:server:robCornerDrugs', availableDrugs[drugType].item, bagAmount)
                QBCore.Functions.Notify(Lang:t("info.has_been_robbed", {bags = bagAmount, drugType = availableDrugs[drugType].label}))
                stealingPed = ped
                stealData = {
                    item = availableDrugs[drugType].item,
                    amount = bagAmount,
                }
                hasTarget = false
                local rand = (math.random(6,9) / 100) + 0.3
                local rand2 = (math.random(6,9) / 100) + 0.3
                if math.random(10) > 5 then
                    rand = 0.0 - rand
                end
                if math.random(10) > 5 then
                    rand2 = 0.0 - rand2
                end
                local moveto = GetEntityCoords(PlayerPedId())
                local movetoCoords = {x = moveto.x + math.random(100, 500), y = moveto.y + math.random(100, 500), z = moveto.z, }
                ClearPedTasksImmediately(ped)
                TaskGoStraightToCoord(ped, movetoCoords.x, movetoCoords.y, movetoCoords.z, 15.0, -1, 0.0, 0.0)
                lastPed[#lastPed+1] = ped
                break
            else
                if pedDist < 1.5 and cornerselling then
                    DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z, Lang:t("info.drug_offer", {bags = bagAmount, drugLabel = currentOfferDrug.label, randomPrice = randomPrice}))
                    if IsControlJustPressed(0, 38) then
                        if not inveh then
                            TriggerServerEvent('qb-drugs:server:sellCornerDrugs', availableDrugs[drugType].item, bagAmount, randomPrice)
                            hasTarget = false

                            loadAnimDict("gestures@f@standing@casual")
                            TaskPlayAnim(PlayerPedId(), "gestures@f@standing@casual", "gesture_point", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
                            Wait(650)
                            ClearPedTasks(PlayerPedId())

                            SetPedKeepTask(ped, false)
                            SetEntityAsNoLongerNeeded(ped)
                            ClearPedTasksImmediately(ped)
                            lastPed[#lastPed+1] = ped
                            break
                        elseif inveh then
                            local veh = GetVehiclePedIsIn(PlayerPedId(), 0)
                            TriggerServerEvent('qb-drugs:server:sellCornerDrugs', availableDrugs[drugType].item, bagAmount, randomPrice)
                            hasTarget = false

                            loadAnimDict("gestures@f@standing@casual")
                            TaskPlayAnim(PlayerPedId(), "gestures@f@standing@casual", "gesture_point", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
                            Wait(650)
                            ClearPedTasks(PlayerPedId())

                            SetPedKeepTask(ped, false)
                            SetEntityAsNoLongerNeeded(ped)
                            TaskLeaveVehicle(ped, veh, 0)
                            lastPed[#lastPed+1] = ped
                            break
                        end

                    end

                    if IsControlJustPressed(0, 47) then
                        if not inveh then
                            QBCore.Functions.Notify(Lang:t("error.offer_declined"), 'error')
                            hasTarget = false
                            SetPedKeepTask(ped, false)
                            SetEntityAsNoLongerNeeded(ped)
                            ClearPedTasksImmediately(ped)
                            lastPed[#lastPed+1] = ped
                            break
                        elseif inveh then
                            local veh = GetVehiclePedIsIn(PlayerPedId(), 0)
                            QBCore.Functions.Notify(Lang:t("error.offer_declined"), 'error')
                            hasTarget = false
                            SetPedKeepTask(ped, false)
                            SetEntityAsNoLongerNeeded(ped)
                            TaskLeaveVehicle(ped, veh, 0)
                            lastPed[#lastPed+1] = ped
                            break
                        end

                    end
                else
                    hasTarget = false
                    pedDist = 5
                    SetPedKeepTask(ped, false)
                    SetEntityAsNoLongerNeeded(ped)
                    ClearPedTasksImmediately(ped)
                    lastPed[#lastPed+1] = ped
                    cornerselling = false
                end
            end
            Wait(3)
        end
        Wait(math.random(4000, 7000))
    end
end




CreateThread(function()
    while true do
        sleep = 1000
        if stealingPed ~= nil and stealData ~= nil then
            sleep = 0
            if IsEntityDead(stealingPed) then
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local pedpos = GetEntityCoords(stealingPed)
                if #(pos - pedpos) < 1.5 then
                    DrawText3D(pedpos.x, pedpos.y, pedpos.z, Lang:t("info.pick_up_button"))
                    if IsControlJustReleased(0, 38) then
                        RequestAnimDict("pickup_object")
                        while not HasAnimDictLoaded("pickup_object") do
                            Wait(0)
                        end
                        TaskPlayAnim(ped, "pickup_object" ,"pickup_low" ,8.0, -8.0, -1, 1, 0, false, false, false )
                        Wait(2000)
                        ClearPedTasks(ped)
                        TriggerServerEvent("QBCore:Server:AddItem", stealData.item, stealData.amount)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[stealData.item], "add")
                        stealingPed = nil
                        stealData = {}
                    end
                end
            end
        end
        Wait(sleep)
    end
end)




CreateThread(function()
    while true do
        sleep = 500

        if cornerselling then
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            local inveh = IsPedInAnyVehicle(PlayerPedId())
            if not hasTarget then
                local PlayerPeds = {}
                if next(PlayerPeds) == nil then
                    for _, player in ipairs(GetActivePlayers()) do
                        local ped = GetPlayerPed(player)
                        PlayerPeds[#PlayerPeds+1] = ped
                    end
                end
                local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)
                if not inveh then
                    if closestDistance < 30.0 and closestPed ~= 0 and not IsPedInAnyVehicle(closestPed) then
                        SellToPed(closestPed)
                    end
                else
                    if closestDistance < 50.0 and closestPed ~= 0 and not IsPedInAnyVehicle(closestPed) then
                        SellToPed(closestPed)
                    end
                end
            end
        end
        Wait(sleep)
    end
end)



CreateThread(function()
    while true do
        Wait(2000)
        if startedselling then
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            local startDist = #(startLocation - coords)
            if startDist > 80 then
                toFarAway()
            end
        end
    end
end)