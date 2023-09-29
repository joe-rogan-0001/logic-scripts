QBCore = exports['lrp-core']:GetCoreObject()

PlayerJob = nil
AllTimePackagesDelivered = nil

CreateThread(function()
    while true do
        Wait(500)
        if LocalPlayer.state.isLoggedIn and not PlayerJob then
            PlayerJob = QBCore.Functions.GetPlayerData().job
            if PlayerJob.name == Config.MailJob then
                MailJob.AddJobBlips()
                QBCore.Functions.TriggerCallback("qb-mailjob:server:GetMailJobData", function(data)
                    AllTimePackagesDelivered = data.PackagesDelivered
                end)
            end
        end
    end
end)

RegisterCommand("mailjob", function(source, args)
    MailJob.ToggleJob()
end)

CreateThread(function()
    while true do
        Wait(3)
        if MailJob.JobStarted and MailJob.MailVehicle ~= nil then
            if MailJob.CurrentRoute.mailboxes[MailJob.CurrentMailbox] ~= nil then
                if MailJob.MailboxPosition ~= nil then
                    DrawMarker(0, MailJob.MailboxPosition.x, MailJob.MailboxPosition.y, MailJob.MailboxPosition.z + 2.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 200, 200, 0, 222, true, false, false, true, false, false, false)
                end
            end
            if DoesEntityExist(MailJob.JobVehicle) then
                if GetEntityhealth(MailJob.JobVehicle) < 400 then
                    -- TODO: Fail job
                end
            else
                -- TODO: Fail job
            end
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerJob.name == Config.MailJob then
            MailJob.AddJobBlips()
            QBCore.Functions.TriggerCallback("qb-mailjob:server:GetMailJobData", function(data)
                AllTimePackagesDelivered = data.PackagesDelivered
            end)
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    if PlayerJob.name == Config.MailJob then
        MailJob.AddJobBlips()
        QBCore.Functions.TriggerCallback("qb-mailjob:server:GetMailJobData", function(data)
            AllTimePackagesDelivered = data.PackagesDelivered
        end)
    else
        MailJob.DestroyJobBlips()
    end
end)

RegisterNetEvent("qb-mailjob:client:ToggleJob", function()
    MailJob.ToggleJob()
end)

DrawText3Ds = function(x, y, z, text)
	SetTextScale(0.55, 0.55)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
    SetTextDropShadow()
	AddTextComponentString(text)
	SetDrawOrigin(x, y, z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0185, 0.019+ factor, 0.05, 0, 0, 0, 75)
	ClearDrawOrigin()
end