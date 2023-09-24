if MySQLFramework.GHMATTI_MYSQL then
    MySQL = {}
    MySQL.Sync = {}
    MySQL.Async = {}

    MySQL.Async.fetchAll = function(query, table_, cb)
        return exports['ghmattimysql']:execute(query, table_, cb)
    end

    MySQL.Sync.fetchAll = function(query, table_, cb)
        return exports['ghmattimysql']:executeSync(query, table_, cb)
    end

    MySQL.Async.execute = function(query, table_, cb)
        return exports['ghmattimysql']:execute(query, table_, cb)
    end

    MySQL.Sync.execute = function(query, table_, cb)
        return exports['ghmattimysql']:executeSync(query, table_, cb)
    end

    MySQL.Async.fetchScalar = function(query, table_, cb)
        return exports['ghmattimysql']:scalar(query, table_, cb)
    end

    MySQL.Sync.fetchScalar = function(query, table_, cb)
        return exports['ghmattimysql']:scalarSync(query, table_, cb)
    end
end