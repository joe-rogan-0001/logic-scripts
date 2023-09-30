local QBCore = exports['lrp-core']:GetCoreObject()

RegisterNUICallback('GetJobCentersJobs', function(data, cb)
    print('hi')
    cb(Config.JobCenter)
end)

RegisterNUICallback('CasinoPhoneJobCenter', function(data)
    if data.action == 1 then
        for k,v in pairs(Config.JobCenter) do
            if (v.job == data.job) then
                SetNewWaypoint(v.Coords[1], v.Coords[2])
            end
        end
    elseif data.action == 2 then
        for k,v in pairs(Config.JobCenter) do
            if (v.job == data.job) then
                SetNewWaypoint(v.Coords[1], v.Coords[2])
            end
        end
        QBCore.Functions.Notify('GPS set', "success")
    end
end)