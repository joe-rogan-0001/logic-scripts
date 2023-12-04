local QBCore = exports["lrp-core"]:GetCoreObject()

local ox_inventory = exports.ox_inventory   
lib.locale()

RegisterNetEvent("spy_pawnshop:sell", function(args)
    local playerPed = GetPlayerPed(source)
    local coords = Config.Target.pos
    local pcoords = GetEntityCoords(playerPed)
    local distance = #(pcoords-coords)
    if distance == nil then
        TriggerEvent("spy_pawnshop:drp", source)
        return
    end
    if distance > Config.Distance then
        TriggerEvent("spy_pawnshop:drp", source)
        return
    end
    local items = ox_inventory:Search(source, 'count', args.item)

    if items >= 1 then
        ox_inventory:RemoveItem(source, args.item, 1)
        ox_inventory:AddItem(source, Config.Currency, args.price)
    else
        lib.notify(source, {
            title = locale("menu1_title"),
            description = locale("notify_not_enough_items"),
            type = "error",
        })
    end
end)


RegisterNetEvent("spy_pawnshop:buy", function(args)
    local playerPed = GetPlayerPed(source)
    local coords = Config.Target.pos
    local pcoords = GetEntityCoords(playerPed)
    local distance = #(pcoords-coords)
    if distance == nil then
        TriggerEvent("spy_pawnshop:drp", source)
        return
    end
    if distance > Config.Distance then
        TriggerEvent("spy_pawnshop:drp", source)
        return
    end
    local items = ox_inventory:Search(source, 'count', Config.Currency)

    if items >= args.price then
        ox_inventory:RemoveItem(source, Config.Currency, args.price)
        ox_inventory:AddItem(source, args.item, 1)
    else
        lib.notify(source, {
            title = locale("menu1_title"),
            description = locale("notify_not_enough_money"),
            type = "error",
        })
    end
end)



RegisterServerEvent("spy_pawnshop:drp")
AddEventHandler("spy_pawnshop:drp", function(source)
    DropPlayer(source, "Cheating tried to give item")
    -- Here you can add your trigger to ban player
end)


