function GetVehicleProperties(vehicle)
    if Config.Framework == "QBCore" then
        return QBCore.Functions.GetVehicleProperties(vehicle)
    end
    if Config.Framework == "ESX" then
        return ESX.Game.GetVehicleProperties(vehicle)
    end
end

function SetVehicleProperties(vehicle,props)
    if Config.Framework == "QBCore" then
        QBCore.Functions.SetVehicleProperties(vehicle,props)
    end
    if Config.Framework == "ESX" then
        ESX.Game.SetVehicleProperties(vehicle,props)
    end
end