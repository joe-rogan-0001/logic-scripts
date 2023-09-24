local currentLocation = 0
currentBlip = nil
local isWorking = false

-- Functions

local function CreateJobBlip()
    if currentLocation ~= 0 then
        if DoesBlipExist(currentBlip) then
            RemoveBlip(currentBlip)
        end
        currentBlip = AddBlipForCoord(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)


        SetBlipSprite (currentBlip, 402)
        SetBlipDisplay(currentBlip, 4)
        SetBlipScale  (currentBlip, 0.8)
        SetBlipAsShortRange(currentBlip, true)
        SetBlipColour(currentBlip, 1)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Job Task")
        EndTextCommandSetBlipName(currentBlip)

        local Chance = math.random(100)
        local Odd = math.random(100)
        if Chance == Odd then
            TriggerServerEvent('QBCore:Server:AddItem', 'phone', 1)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["phone"], "add")
            QBCore.Functions.Notify(Lang:t("success.found_phone"), "success")
        end
    end
end

local function JobDone()
    if math.random(1, 100) <= 50 then
        QBCore.Functions.Notify(Lang:t("success.time_cut"))
        jailTime = jailTime - math.random(1, 2)
    end
    local newLocation = math.random(1, #Config.Locations.jobs[currentJob])
    while (newLocation == currentLocation) do
        Wait(100)
        newLocation = math.random(1, #Config.Locations.jobs[currentJob])
    end
    currentLocation = newLocation
    CreateJobBlip()
end

-- Threads

CreateThread(function()
    while true do
        Wait(1)
        if inJail and currentJob == "electrician" then
            if currentLocation ~= 0 then
                if not DoesBlipExist(currentBlip) then
                    CreateJobBlip()
                end
                local pos = GetEntityCoords(PlayerPedId())
                if #(pos - vector3(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)) < 10.0 and not isWorking then
                    DrawMarker(2, Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 150, 200, 50, 222, false, false, false, true, false, false, false)
                    if #(pos - vector3(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)) < 1 and not isWorking then
                        isWorking = true
                        QBCore.Functions.Progressbar("work_electric", "Working on electricity..", math.random(5000, 10000), false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "anim@gangops@facility@servers@",
                            anim = "hotwire",
                            flags = 16,
                        }, {}, {}, function() -- Done
                            isWorking = false
                            StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                            JobDone()
                        end, function() -- Cancel
                            isWorking = false
                            StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                            QBCore.Functions.Notify(Lang:t("error.cancelled"), "error")
                        end)
                    end
                end
            else
                currentLocation = math.random(1, #Config.Locations.jobs[currentJob])
                CreateJobBlip()
            end
            Wait(5000)
        elseif inJail and currentJob == "cook" then
            if currentLocation ~= 0 then
                if not DoesBlipExist(currentBlip) then
                    CreateJobBlip()
                end
                local pos = GetEntityCoords(PlayerPedId())
                if #(pos - vector3(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)) < 10.0 and not isWorking then
                    DrawMarker(2, Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 150, 200, 50, 222, false, false, false, true, false, false, false)
                    if #(pos - vector3(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)) < 1 and not isWorking then
                        isWorking = true
                        QBCore.Functions.Progressbar("work_electric", "Prepping Prison Slop..", math.random(5000, 10000), false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "amb@prop_human_bbq@male@idle_a",
                            anim = "idle_a",
                            flags = 16,
                            prop = "",
                        }, {}, {}, function() -- Done
                            isWorking = false
                            StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@idle_a", "idle_a", 1.0)
                            JobDone()
                        end, function() -- Cancel
                            isWorking = false
                            StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@idle_a", "idle_a", 1.0)
                            QBCore.Functions.Notify(Lang:t("error.cancelled"), "error")
                            ClearPedTasks(PlayerPedId())
                        end)
                    end
                end
            else
                currentLocation = math.random(1, #Config.Locations.jobs[currentJob])
                CreateJobBlip()
            end
            Wait(5000)
        elseif inJail and currentJob == "janitor" then
            if currentLocation ~= 0 then
                if not DoesBlipExist(currentBlip) then
                    CreateJobBlip()
                end
                local pos = GetEntityCoords(PlayerPedId())
                if #(pos - vector3(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)) < 10.0 and not isWorking then
                    DrawMarker(2, Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 150, 200, 50, 222, false, false, false, true, false, false, false)
                    if #(pos - vector3(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)) < 1 and not isWorking then
                        local broomModel = `prop_tool_broom`

                        RequestModel(broomModel)
                        while not HasModelLoaded(broomModel) do
                            Wait(1)
                        end
                        BroomObject = CreateObject(broomModel, 1.0, 1.0, 1.0, 1, 1, 0)
                        local bone1 = GetPedBoneIndex(PlayerPedId(), 28422)
                        AttachEntityToEntity(BroomObject, PlayerPedId(), bone1, -0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
                        isWorking = true
                        QBCore.Functions.Progressbar("work_electric", "Cleaning Up Garbage..", math.random(5000, 10000), false, true, {
                            
                            
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "anim@amb@drug_field_workers@rake@male_a@base",
                            anim = "base",
                            flags = 16,
                            
                            Prop = "prop_tool_broom",
                            PropBone = 28422,
                            PropPlacement = {-0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0},


                        }, {}, {}, function() -- Done
                            isWorking = false
                            StopAnimTask(PlayerPedId(), "anim@amb@drug_field_workers@rake@male_a@base", "base", 1.0)
                            JobDone()
                        end, function() -- Cancel
                            isWorking = false
                            StopAnimTask(PlayerPedId(), "anim@amb@drug_field_workers@rake@male_a@base", "base", 1.0)
                            QBCore.Functions.Notify(Lang:t("error.cancelled"), "error")
                            ClearPedTasks(PlayerPedId())
                        end)
                    end
                end
            else
                currentLocation = math.random(1, #Config.Locations.jobs[currentJob])
                CreateJobBlip()
            end
            Wait(5000)
        end
    end
end)