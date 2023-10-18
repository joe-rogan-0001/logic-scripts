function alertOwner(serial)
    local coords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent('av_laptop:alertOwner',serial,coords)
end

function openLaptop() -- Triggered when player opens laptop

end

function closeLaptop() -- Triggered when player closes laptop

end