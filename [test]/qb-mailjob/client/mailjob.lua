MailJob = {
    StartBlip = nil,
    JobStarted = false,
    CurrentRoute = nil,
    CurrentMailbox = 1,
    CurrentMailboxBlip = nil,
    MailVehicle = nil,
    IsDelivering = false,
    MailboxPosition = vector3(0.0, 0.0, 0.0),
    -- method AddJobBlips () - Add the blips to the map for the job.
    AddJobBlips = function()
        MailJob.StartBlip = AddBlipForCoord(Config.MailJobLocations.startBlip.x, Config.MailJobLocations.startBlip.y, Config.MailJobLocations.startBlip.z)
        SetBlipSprite (MailJob.StartBlip, 525)
        SetBlipDisplay(MailJob.StartBlip, 4)
        SetBlipScale  (MailJob.StartBlip, 0.75)
        SetBlipAsShortRange(MailJob.StartBlip, true)
        SetBlipColour(MailJob.StartBlip, 0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Mail Job")
        EndTextCommandSetBlipName(MailJob.StartBlip)
    end,
    -- method DestroyJobBlips () - Remove the blips for the job from the map (ie when changing jobs)
    DestroyJobBlips = function()
        RemoveBlip(MailJob.StartBlip)
    end,
    -- method DeliverMail () - The function called when using qb-target to deliver mail
    DeliverMail = function()
        if MailJob.JobStarted then
            local PlayerPos = GetEntityCoords(PlayerPedId())
            if #(PlayerPos - MailJob.MailboxPosition) < 5.0 then
                MailJob.IsDelivering = true
                TaskTurnPedToFaceCoord(PlayerPedId(), MailJob.MailboxPosition.x, MailJob.MailboxPosition.y, MailJob.MailboxPosition.z, 10)
                QBCore.Functions.Progressbar("deliver_mail", "Delivering mail...", math.random(2000, 3000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "anim@gangops@facility@servers@",
                    anim = "hotwire",
                    flags = 16,
                }, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    MailJob.CurrentMailbox = MailJob.CurrentMailbox + 1
                    if MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox] == nil then
                        QBCore.Functions.Notify("You have delivered all the mail! Return to GoPostal.", "success")
                        SetBlipCoords(MailJob.CurrentMailboxBlip, Config.JobLocations.startBlip.x, Config.JobLocations.startBlip.y, Config.JobLocations.startBlip.z)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentSubstringPlayerName("Mail Depot")
                        EndTextCommandSetBlipName(MailJob.CurrentMailboxBlip)
                    else
                        QBCore.Functions.Notify("Successfully delivered mail!", "success")
                        for k,v in ipairs(Config.MailBoxModels) do
                            local object = GetClosestObjectOfType(MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox].x, MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox].y, MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox].z, 10.0, v, false, false, false)
                            if DoesEntityExist(object) then
                                MailJob.MailboxPosition = GetEntityCoords(object)
                            else
                                MailJob.MailboxPosition = MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox]
                            end
                        end
                        SetBlipCoords(MailJob.CurrentMailboxBlip, MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox].x, MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox].y, MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox].z)
                        SetBlipRoute(MailJob.CurrentMailboxBlip, true)
                        TriggerServerEvent("qb-mailjob:server:DeliveredMail")
                    end
                    MailJob.IsDelivering = false
                end, function() -- Cancel
                    ClearPedTasksImmediately(PlayerPedId())
                    MailJob.IsDelivering = false
                    QBCore.Functions.Notify("Cancelled!", "error")
                end)
            end
        else
            QBCore.Functions.Notify("You haven't started a delivery route!", "error")
        end
    end,
    -- method ToggleJob () - Start or stop the mail job
    ToggleJob = function()
        MailJob.JobStarted = not MailJob.JobStarted
        if MailJob.JobStarted then
            QBCore.Functions.Progressbar("deliver_mail", "Loading mail bag...", math.random(5000, 10000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "anim@gangops@facility@servers@",
                anim = "hotwire",
                flags = 16,
            }, {}, {}, function() -- Done
                ClearPedTasksImmediately(PlayerPedId())
                MailJob.CurrentMailbox = 1
                local VehicleSpawnPos = Config.MailJobLocations.truckSpawns[math.random(1, #Config.MailJobLocations.truckSpawns)]
                local VehicleModel = GetHashKey("boxville2")
                local CanDoRoute = false
                repeat
                    MailJob.CurrentRoute = Config.MailRoutes[math.random(1, #Config.MailRoutes)]
                    for k,v in ipairs(MailJob.CurrentRoute.routeLevels) do
                        local level, data = GetCarrierLevelFromPackageCount(AllTimePackagesDelivered)
                        if level <= v then
                            CanDoRoute = true
                        end
                    end
                until CanDoRoute
    
                RequestModel(VehicleModel) 
                repeat
                    Wait(10)
                until HasModelLoaded(VehicleModel)
                MailJob.MailVehicle = CreateVehicle(VehicleModel, VehicleSpawnPos.x, VehicleSpawnPos.y, VehicleSpawnPos.z, VehicleSpawnPos.w, true, true)
                Entity(MailJob.MailVehicle).state.ignoreLocks = true
    
                MailJob.CurrentMailboxBlip = AddBlipForCoord(MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox].x, MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox].y, MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox].z)
                SetBlipSprite (MailJob.CurrentMailboxBlip, 1)
                SetBlipDisplay(MailJob.CurrentMailboxBlip, 4)
                SetBlipScale  (MailJob.CurrentMailboxBlip, 0.75)
                SetBlipAsShortRange(MailJob.CurrentMailboxBlip, true)
                SetBlipColour(MailJob.CurrentMailboxBlip, 5)
                SetBlipRoute(MailJob.CurrentMailboxBlip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName("Mailbox")
                EndTextCommandSetBlipName(MailJob.CurrentMailboxBlip)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(MailJob.MailVehicle))
    
                for k,v in ipairs(Config.MailBoxModels) do
                    local object = GetClosestObjectOfType(MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox].x, MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox].y, MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox].z, 10.0, v, false, false, false)
                    if DoesEntityExist(object) then
                        MailJob.MailboxPosition = GetEntityCoords(object)
                    else
                        MailJob.MailboxPosition = MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox]
                    end
                end
                TriggerServerEvent("qb-mailjob:server:MailJobToggled", true)
                QBCore.Functions.Notify("Go to the route marked on your map and start delivering mail!", "success")
            end, function() -- Cancel
                ClearPedTasksImmediately(PlayerPedId())
                MailJob.JobStarted = false
                QBCore.Functions.Notify("Cancelled!", "error")
            end)
        else
            DeleteVehicle(MailJob.MailVehicle)
            RemoveBlip(MailJob.CurrentMailboxBlip)
            TriggerServerEvent("qb-mailjob:server:MailJobToggled", false)
        end
    end,
    -- method ShowMailJobMenu () - Show the mail job menu.
    ShowMailJobMenu = function()
        QBCore.Functions.TriggerCallback("qb-mailjob:server:GetMailJobData", function(data)
            AllTimePackagesDelivered = data.PackagesDelivered
            if AllTimePackagesDelivered then
                local level, data = GetCarrierLevelFromPackageCount(AllTimePackagesDelivered)
                local mailjobmenu = {
                    {
                        header = "GoPostal",
                        txt = "Start the mail job here.<br/><br/>Total Mail Delivered: "..AllTimePackagesDelivered.."<br/>Carrier Level: "..data.name.." ("..level..")<br/>Pay Multiplier: "..data.payMultiplier.."x",
                        isMenuHeader = true
                    },
                    {
                        header = MailJob.JobStarted and "Stop Working" or "Start Working",
                        params = {
                            event = "qb-mailjob:client:ToggleJob",
                        }
                    },
                    {
                        header = "Close Menu",
                        params = {
                            event = "qb-menu:client:closeMenu"
                        }
                    },
                }
                exports['lrp-menu']:openMenu(mailjobmenu)
            end
        end)
    end,
}