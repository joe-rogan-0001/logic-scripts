CreateThread(function()
    TargetsSetup = false
    while true do
        Citizen.Wait(100)
        if LocalPlayer.state.isLoggedIn then
            if not TargetsSetup then
                local MailDoorModel = GetHashKey("prop_indus_meet_door_l")
                local MailDoorTarget = -1

                RequestModel(MailDoorModel) 
                repeat
                    Wait(10)
                until HasModelLoaded(MailDoorModel)

                MailDoorTarget = CreateObject(MailDoorModel, 78.36, 113.12, 81.48, false, true, true)
                repeat
                    Wait(500)
                    print("Not created... "..MailDoorTarget)
                until DoesEntityExist(MailDoorTarget)

                SetEntityCoords(MailDoorTarget, 78.36, 113.12, 81.48)
                SetEntityHeading(MailDoorTarget, 340.0)
                FreezeEntityPosition(MailDoorTarget, true)

                exports['lrp-target']:AddTargetEntity(MailDoorTarget, {
                    options = {
                        {
                            type = "client",
                            action = function()
                                MailJob.ShowMailJobMenu()
                            end,
                            icon = "fas fa-bolt",
                            targeticon = "fas fa-envelope",
                            label = "Mail Job",
                            --job = "",
                        }
                    },
                    distance = 2.0
                })

                exports['lrp-target']:AddTargetModel(Config.MailBoxModels, {
                    options = {
                        {
                            type = "client",
                            action = function()
                                MailJob.DeliverMail()
                            end,
                            icon = "fas fa-bolt",
                            targeticon = "fas fa-envelope",
                            label = "Deliver Mail",
                            --job = "",
                        }
                    },
                    distance = 1.0
                })

                SetModelAsNoLongerNeeded(MailDoorModel)
                TargetsSetup = true
            end
        end
    end
end)