local cantSell = {}

RegisterServerEvent('av_corners:sell', function(netId,currentDrug,gangZone,mapZone)
    if Config.Debug then
        print("entity: "..netId)
    end
    local src = source
    if cantSell[netId] then
        if Config.Debug then
            print("entity exists in cantSell table...")
        end
        local entity = NetworkGetEntityFromNetworkId(netId)
        if entity and DoesEntityExist(entity) then
            DeleteEntity(entity)
            cantSell[netId] = nil
            if Config.Debug then
                print("entity deleted (?)")
            end
        end
        return 
    end
    cantSell[netId] = true
    local entity = NetworkGetEntityFromNetworkId(netId)
    if not entity then return end
    local player = GetPlayerPed(src)
    local entityCoords = GetEntityCoords(entity)
    local playerCoords = GetEntityCoords(player)
    local dist = #(entityCoords - playerCoords)
    if dist < 10 then
        local itemInfo = exports['av_laptop']:getInventoryItem(src,currentDrug)
        local strain = false
        local amount = 1
        for k, v in pairs(itemInfo) do
            if v['name'] == currentDrug then
                if v['info'] and v['info']['strain'] then
                    strain = v['info']['strain']
                end
                if v['metadata'] and v['metadata']['strain'] then
                    strain = v['metadata']['strain']
                end
                if v['amount'] then
                    if tonumber(v['amount']) > Corners.MaxBags then
                        amount = math.random(1,Corners.MaxBags)
                    else
                        amount = math.random(1,tonumber(v['amount']))
                    end
                end
                if v['count'] then
                    if tonumber(v['count']) > Corners.MaxBags then
                        amount = math.random(1,Corners.MaxBags)
                    else
                        amount = math.random(1,tonumber(v['count']))
                    end
                end
                break
            end
        end
        exports['av_laptop']:removeItem(src,currentDrug,amount)
        if strain then
            local price = getZonePrice(strain,amount,currentDrug,gangZone,mapZone)
            exports['av_laptop']:addMoney(src,Corners.Account,price)
        else
            local price = Corners.Drugs[currentDrug]['basePrice']
            if Corners.GangZoneMultiplier and gangZone then
                local lucky = math.random(1,10)
                if lucky == 3 then
                    local gang = exports['av_gangs']:getGang(src)
                    if gang and gang.name then
                        TriggerEvent('av_gangs:addXP',gang.name,1)
                    end
                end
                price = price * Corners.GangMultiplier
            end
            price = Round((price * amount))
            exports['av_laptop']:addMoney(src,Corners.Account,price)
        end
    end
end)