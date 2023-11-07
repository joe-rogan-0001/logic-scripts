AddEventHandler('av_restaurant:box', function(data)
    local job = data['job']
    local type = 'box'
    lib.callback('av_restaurant:getItems', false, function(items)
        local menu = {}
        for k, v in pairs(items) do
            local ingredientsLabel = ""
            local ingredients = false
            if v['ingredients'] then
                ingredients = json.decode(v['ingredients'])
                if ingredients then
                    for k, v in pairs(ingredients) do
                        if tonumber(k) == 1 then
                            ingredientsLabel = v
                        else
                            ingredientsLabel = ingredientsLabel.." | "..v
                        end
                    end
                end
            end
            menu[#menu+1] = {
                title = v['label'],
                description = "Ingredients: "..ingredientsLabel,
                event = "av_restaurant:craft",
                args = {
                    item = v['name'],
                    job = job,
                    type = type,
                    ingredients = ingredients,
                    image = v['image'],
                    itemLabel = v['label'],
                }
            }
        end
        lib.registerContext({
            id = 'av_restaurants:box',
            title = Lang['box'],
            options = menu,
        })
        lib.showContext('av_restaurants:box')
    end,{job = job, type = type})
end)

RegisterNetEvent('av_restaurants:openBox', function(serial)
    if Config.Inventory == 'ox_inventory' then
        if exports.ox_inventory:openInventory('stash', serial) == false then
            TriggerServerEvent('ox:loadStashes')
            exports.ox_inventory:openInventory('stash', serial)
        end
        return
    end
    if Config.Inventory == 'mf-inventory' then
        exports["mf-inventory"]:openOtherInventory(serial)
        return
    end
    if Config.Inventory == 'qs-inventory' then
        local other = {}
        other.maxweight = Config.Boxes['weight']
        other.slots = Config.Boxes['slots']
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "Stash_"..serial, other)
        TriggerEvent("inventory:client:SetCurrentStash", "Stash_"..serial)
        return
    end
    TriggerEvent("inventory:client:SetCurrentStash", serial) -- qb-inventory, lj-inventory and ps-inventory
    TriggerServerEvent("inventory:server:OpenInventory", "stash", serial, {
        maxweight = Config.Boxes['weight'],
        slots = Config.Boxes['slots'],
    })
end)