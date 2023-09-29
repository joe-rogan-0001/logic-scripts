local wheelInUse = false
QBCore = exports['lrp-core']:GetCoreObject()

QBCore.Functions.CreateCallback('np-wheelfitment_sv:getIsWheelFitmentInUse', function(source, cb)
    cb(wheelInUse)
end)

QBCore.Functions.CreateCallback('np-wheelfitment_sv:setIsWheelFitmentInUse', function(pSource, pBool)
    wheelInUse = pBool
end)

QBCore.Functions.CreateCallback('np-wheelfitment_sv:checkfitment', function(source, cb, pVin)
    if pVin == nil or pVin == 0 or pVin == "" then return end

    if IsVehicleOwned(pVin) then
        local resthing = {}
        MySQL.query('SELECT wheels FROM player_vehicles WHERE plate = ?', {pVin}, function(result)
            if result then   
                if result[1].wheels then
                    print("Query Resulted in Wheel Fitment " .. result[1].wheels)  
                    resthing = result[1].wheels
                    cb(resthing)
                end
            end
        end)
    end
end)

RegisterServerEvent("np-wheelfitment_sv:saveWheelfitment")
AddEventHandler("np-wheelfitment_sv:saveWheelfitment", function(pVin, pData)
    if pVin == nil or pVin == 0 or pVin == "" then return end

    if IsVehicleOwned(pVin) then
        pData = json.encode(pData)
        local affectedRows = MySQL.update.await('UPDATE player_vehicles SET wheels = ? WHERE plate = ? ', {pData, pVin})
    end
end)

function IsVehicleOwned(plate)
    local retval = false
    local result = MySQL.Sync.fetchScalar('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        retval = true
    end
    return retval
end