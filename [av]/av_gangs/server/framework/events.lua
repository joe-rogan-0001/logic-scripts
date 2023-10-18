local cooldowns = {}
local npc = {}

RegisterServerEvent('av_gangs:buyItem', function(data)
    local src = source
    local gang = data.gang
    local item = data.item
    local price = data.price
    cooldowns[gang] = cooldowns[gang] or {}
    cooldowns[gang][item] = cooldowns[gang][item] or 0
    if cooldowns[gang][item] < Config.ItemLimit[item] then
        local myMoney = exports['av_laptop']:getMoney(src, Config.ShopAccount)
        if myMoney >= price then
            local info = {}
            info.gang = gang
            info.expiration = addHours()
            exports['av_laptop']:removeMoney(src, Config.ShopAccount, price)
            exports['av_laptop']:addItem(src,item,1,info)
            cooldowns[gang][item] = cooldowns[gang][item] + 1
        else
            TriggerClientEvent('av_laptop:notification',src,Lang['gang_shop'],Lang['no_money'],"error")
        end
    else
        TriggerClientEvent('av_laptop:notification',src,Lang['gang_shop'],Lang['spray_limit'],"error")
    end
end)

RegisterServerEvent('av_grafiti:robgang', function(netId,gang)
    if not gang then return end
    if not netId then return end
    local src = source
    if npc[netId] then
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['already_robbed'],'error')
        return 
    end
    local entity = NetworkGetEntityFromNetworkId(netId)
    if entity then
        npc[netId] = true
        local coords = GetEntityCoords(entity)
        local members = MySQL.query.await('SELECT * FROM av_gangs WHERE name = ?', {gang})
        if members and members[1] then
            for k, v in pairs(members) do
                local Player = exports['av_laptop']:getSourceByIdentifier(v['identifier'])
                if Player then 
                    TriggerClientEvent('av_gangs:alertMember', Player, coords, Lang['robbery_alert'])
                end
            end
        end
        local total = math.random(Config.RobMoney['min'], Config.RobMoney['max'])
        exports['av_laptop']:addMoney(src,Config.RobAccount,total)
        local user = GetPlayerName(src)
        local content = {
            {
                ["title"] = 'Robbed NPC',
                ["description"] = user.." robbed a gang NPC from "..gang.." and received $"..total,
                ["footer"] = {
                    ["text"] = os.date('%c'),
                },
            }
        }
        Discord(content)
    end
end)