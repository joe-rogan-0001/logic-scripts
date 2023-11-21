Core = exports[Config.Framework]:GetCoreObject()

function Notify(src ,msg, type, time)
    TriggerClientEvent('QBCore:Notify', src, msg, type, time)
end

function CustomNotify(src, header, msg, icon, colour, length)
    TriggerClientEvent('rep-tablet:client:CustomNotification', src,
            header or "NO HEADER",
            msg or "NO MSG",
            icon or "fas fa-phone-square",
            colour or "#e84118",
            length or 7500
        )
end

function cleanMoney(src, money)
    local Player = Core.Functions.GetPlayer(src)
    local chance = math.random(0 , 100)
    Player.Functions.AddMoney('cash', math.ceil(money))
    if chance < Config.BandsLaunderingChance then
        local bagAmount = Player.Functions.GetItemByName(src, Config.BandsItem)
        if bagAmount then
            if bagAmount.amount > 0 then
                local random = math.random(Config.MinBandsToClean,Config.MaxBandsToClean)
                local giaBand = math.random(Config.MinBandsPayout, Config.MaxBandsPayout)
                if bagAmount.amount >= random then
                    Player.Functions.AddMoney('cash', random * giaBand)
                    Player.Functions.RemoveItem(Config.BandsItem, random)
                    TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[Config.BandsItem], "remove", random)
                else
                    Player.Functions.AddMoney('cash', bagAmount.amount * giaBand)
                    Player.Functions.RemoveItem(Config.BandsItem, bagAmount.amount)
                    TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[Config.BandsItem], "remove", bagAmount.amount)
                end
            end
        end
    end
    if chance < Config.RollsLaunderingChance then
        local bagAmount = Player.Functions.GetItemByName(src, Config.RollsItem)
        if bagAmount then
            if bagAmount.amount > 0 then
                local random = math.random(Config.MinRollsToClean,Config.MaxRollsToClean)
                local giaRoll = math.random(Config.MinRollsToCleanPayout, Config.MaxRollsToCleanPayout)
                if bagAmount.amount >= random then
                    Player.Functions.AddMoney('cash', random * giaRoll)
                    Player.Functions.RemoveItem(Config.RollsItem, random)
                    TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[Config.RollsItem], "remove", random)
                else
                    Player.Functions.AddMoney('cash', bagAmount.amount * giaRoll)
                    Player.Functions.RemoveItem(Config.RollsItem, bagAmount.amount)
                    TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[Config.RollsItem], "remove", bagAmount.amount)
                end
            end
        end
    end
end

function bonusTaco(src, price)
    local Player = Core.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash', tonumber(price))
end

Core.Functions.CreateCallback("rep-weed:callback:checkowner", function(source, cb, plate)
    MySQL.query('SELECT * FROM player_vehicles WHERE plate = ?',{plate}, function(result)
        if result[1] then
            cb(true)
        else
            cb(false)
        end
    end)
end)