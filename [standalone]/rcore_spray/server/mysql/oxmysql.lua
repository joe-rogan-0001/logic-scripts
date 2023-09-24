if MySQLFramework.OXMYSQL then
    MySQL = {}
    MySQL.Sync = {}
    MySQL.Async = {}
    MySQL.Sync.fetchAll = function(query, table_, cb)
        return exports['oxmysql']:executeSync(query, table_)
    end

    MySQL.Sync.execute = function(query, table_, cb)
        return exports['oxmysql']:executeSync(query, table_)
    end

    MySQL.Sync.fetchScalar = function(query, table_, cb)
        return exports['oxmysql']:scalarSync(query, table_)
    end

    MySQL.Async.execute = MySQL.Sync.execute
end