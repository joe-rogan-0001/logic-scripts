local canOpen = false


function openMenu(drug)
    local options = {
        {
            title = Lang['open_stash'],
            icon = "fa-solid fa-box",
            event = "av_runs:openStash",
            args = {
                drug = drug
            }
        },
        {
            title = Lang['start'],
            event = "av_runs:startJob",
            icon = "fa-solid fa-location-crosshairs",
            args = {
                drug = drug
            }
        },
        {
            title = Lang['sell'],
            event = "av_runs:sellPackage",
            icon = "fa-solid fa-comments-dollar",
            args = {
                drug = drug
            }
        }
    }
    lib.registerContext({id = drug..'_menu',title = Lang['npc_name'],options = options})
    lib.showContext(drug..'_menu')
end

RegisterNetEvent("av_runs:openStash", function(data)
    local drug = data['drug']
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:openInventory('stash', drug)
        return
    end
    local drugConfig = Config.Drugs[drug]
    if drugConfig then
        local weight = drugConfig['stashWeight']
        local slots = drugConfig['maxQty']
        TriggerEvent("inventory:client:SetCurrentStash", drug)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", drug, {
            maxweight = weight,
            slots = slots,
        }, Lang['npc_name'])
    end
end)

RegisterNetEvent("av_runs:startJob", function(data)
    local drug = data['drug']
    local neededCops = Config.Drugs[drug]['minCops']
    if onlineCops >= neededCops then
        local isAvailable = lib.callback.await('av_runs:checkCooldown', false, drug)
        if isAvailable then
            TriggerServerEvent("av_runs:processInventory", drug)
        else
            TriggerEvent("av_runs:notification", Lang['npc_name'], Lang['not_available'], "error")
        end
    else
        TriggerEvent("av_runs:notification", Lang['npc_name'], Lang['no_cops'], "error")
    end
end)

RegisterNetEvent("av_runs:sellPackage", function(data)
    local drug = data['drug']
    if drug then
        local stash = drug..'_sell'
        if Config.Inventory == "ox_inventory" then
            exports.ox_inventory:openInventory('stash', stash)
        else
            TriggerEvent("inventory:client:SetCurrentStash", stash)
            TriggerServerEvent("inventory:server:OpenInventory", "stash", stash, {
                maxweight = 100000,
                slots = 5,
            }, Lang['npc_name'])
        end
    end
end)