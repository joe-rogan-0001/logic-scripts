busy = false
AddEventHandler('av_restaurant:craft', function(data)
    if busy then return end
    busy = true
    local job, item, type, ingredients, image, label = data['job'], data['item'], data['type'], data['ingredients'], data['image'], data['itemLabel']
    loadAnimDict(Config.CraftingDict)
    TaskPlayAnim(PlayerPedId(), Config.CraftingDict, Config.CraftAnimation, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
    Wait(Config.CraftingTime)
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent('av_restaurant:craftEnd',job,item,type,ingredients,image)
    busy = false
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end