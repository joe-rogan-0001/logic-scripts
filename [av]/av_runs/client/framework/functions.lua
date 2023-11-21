function GiveKeys(vehicle) -- Just in case u need the vehicle object
    local plates = GetVehicleNumberPlateText(vehicle)
    -- Give vehicle keys export/event:
end

function SetFuel(vehicle)
    -- Add your own fuel export/event here:
    
end

function ApplyTuning(vehicle)
    SetVehicleModKit(vehicle,0)
    ToggleVehicleMod(vehicle, 18, true) -- enable turbo
    SetVehicleMod(vehicle, 11, 2, false) -- better engine
    SetVehicleMod(vehicle, 12, 2, false) -- better brakes
    SetVehicleMod(vehicle, 16, 2, false) -- better armour
end