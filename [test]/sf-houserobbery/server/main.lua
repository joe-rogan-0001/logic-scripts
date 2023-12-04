RegisterNetEvent("sf-houserobbery:playerLoaded", function()
    local _source = source
    local openedHouses = {}
    for k, v in pairs(Houses) do
        table.insert(openedHouses, k)
    end
    TriggerClientEvent("sf-houserobbery:openedHouses", _source, openedHouses)
end)

RegisterNetEvent("sf-houserobbery:sellItems", function()
    local _source = source
    local itemCounts = {}
    local totalCount = 0
    for k, v in pairs(Config.ItemPrices) do
        itemCounts[k] = Bridge.GetItemCount(_source, k)
        totalCount += itemCounts[k]
    end
    if(totalCount < 1) then
        ShowNotification(_source, _L("no_items_to_sell"))
        return
    end
    Player(_source).state:set("HRSelling", true, true)
    Citizen.Wait(100)
    local totalAmount = 0
    for k, v in pairs(itemCounts) do
        Bridge.RemoveItem(_source, k, v)
        totalAmount += math.floor(v * Config.ItemPrices[k])
    end
    Bridge.AddItem(_source, "money", totalAmount)
    Citizen.Wait(100)
    Player(_source).state:set("HRSelling", nil, true)
end)

function DispatchHouse(source, houseId)
    -- if you have dispatch that sends server event through client you can use this and implement it in the editable_client.lua
    -- local playerPing = GetPlayerPing(source)
    -- if(playerPing > 0 and playerPing < 500) then
    --     TriggerClientEvent("sf-houserobbery:dispatch", source, Config.Houses[houseId].coords.xyz)
    -- else
    --     local house = Houses[houseId]
    --     for k, v in pairs(house.players) do
    --         playerPing = GetPlayerPing(k)
    --         if(playerPing > 0 and playerPing < 500) then
    --             TriggerClientEvent("sf-houserobbery:dispatch", k, Config.Houses[houseId].coords.xyz)
    --             break
    --         end
    --     end
    -- end
    if(not Config.PoliceBlipSettings.disable) then
        local players = Bridge.GetJobPlayers(Config.PoliceJob)
        local randomCoords = Config.Houses[houseId].coords.xy
        if(Config.PoliceBlipSettings.radius) then
            local halfRadius = math.floor(Config.PoliceBlipSettings.radius/2.2)
            randomCoords = vector2(randomCoords.x + math.random(-halfRadius, halfRadius), randomCoords.y + math.random(-halfRadius, halfRadius)) 
        end
        local payload = msgpack.pack_args(houseId, vector2(randomCoords.x, randomCoords.y))
        local payLen = payload:len()
        for _, pSource in ipairs(players) do
            TriggerClientEventInternal("sf-houserobbery:policeBlip", pSource, payload, payLen)
        end
    end
end

-- if(GetResourceState("sf-phone") ~= "missing") then
--     PhoneActive = true
--     function SendMessageToPlayer(source, textLocale)
--         local targetNum = exports['sf-phone']:getPlayerNumber(source)
--         if(not targetNum) then return end
--         exports["sf-phone"]:SendScriptMessage("LESTER", targetNum, _L(textLocale.."_sms"))
--         return true
--     end
-- else
    function SendMessageToPlayer(source, textLocale)
        ShowNotification(source, _L(textLocale))
        return true
    end
-- end

-- lockpick usage
if(GetResourceState("ox_inventory") ~= "missing") then
    exports("useLockpick", function(event, item, inventory, slot, data)
        if(event ~= "usingItem") then return end
        if(OnLockpickUse(inventory.id)) then
            exports['ox_inventory']:RemoveItem(inventory.id, item.name, 1, nil, slot)
        end
    end) 
elseif(GetResourceState("es_extended") ~= "missing") then
    ESX.RegisterUsableItem("lockpick", function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        if(OnLockpickUse(source)) then
            xPlayer.removeItem("lockpick", 1)
        end
    end)
elseif(GetResourceState("lrp-core") ~= "missing") then
    QBCore.Functions.CreateUseableItem('lockpick', function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player.Functions.GetItemByName(item.name) then return end
        if(OnLockpickUse(source)) then
            Player.Functions.RemoveItem(item.name, 1, item.slot)
        end
    end)
end

function ShowNotification(source, notification)
    TriggerClientEvent("sf-houserobbery:showNotification", source, notification)
end

function Verbose(message, level)
    if(level == "error" and Config.Verbose ~= "none") then
        print(("^1Error: %s^0"):format(message))
    end
    if(level == "warning" and Config.Verbose ~= "error") then
        print(("^3Warning: %s^0"):format(message))
    end
    if(level == "info" and Config.Verbose == "all") then
        print(("Info: %s"):format(message))
    end
end