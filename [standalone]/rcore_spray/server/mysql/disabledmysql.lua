if MySQLFramework.DISABLE_MYSQL then
    MySQL = {}
    MySQL.Sync = {}
    MySQL.Async = {}

    MySQL.Async.fetchAll = function(query, table_, cb)
        return {}
    end

    MySQL.Sync.fetchAll = function(query, table_, cb)
        return {}
    end

    MySQL.Async.execute = function(query, table_, cb)
        return 1
    end

    MySQL.Sync.execute = function(query, table_, cb)
        return 1
    end

    MySQL.Async.fetchScalar = function(query, table_, cb)
        return {}
    end

    MySQL.Sync.fetchScalar = function(query, table_, cb)
        return {}
    end
end