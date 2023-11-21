onlineCops = 0

function isCop()
    local job = GetJob()
    if job and job.name then
        return Config.PoliceJobs[job.name]
    end
    return false
end

RegisterNetEvent("av_runs:sendDispatch", function(vehicle)
    -- Your dispatch event/export goes here:
    -- This example is only for ps-dispatch (make sure to read the docs first)
    if Config.Debug then
        print("Dispatch triggered")
    end
    if GetResourceState("ps-dispatch") ~= "missing" then
        exports['ps-dispatch']:VehicleShooting(vehicle)
    end
end)

RegisterNetEvent('police:SetCopCount', function(amount) -- This event is triggered from qb-policejob server
    onlineCops = amount
end)