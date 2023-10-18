local delivery = nil

RegisterNetEvent('av_blackmarket:setGPS', function()
    if DoesBlipExist(delivery) then
        RemoveBlip(delivery)
    end
    local delivery = AddBlipForCoord(Config.BlipCoords[1], Config.BlipCoords[2], Config.BlipCoords[3])
    SetBlipSprite(delivery, Config.BlipIcon)
    SetBlipScale(delivery, Config.BlipScale)
    SetBlipDisplay(delivery, 4)
    SetBlipColour(delivery, Config.BlipColor)
    SetBlipAsShortRange(delivery, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Lang['blip_text'])
    EndTextCommandSetBlipName(delivery)
end)