Config = {}

Config["AuthorizedJobs"] = {
    "police"
}

Config["EmsJobs"] = {
    "ambulance"
}

Config["Both"] = {
    "police",
    "ambulance"
}

Config["AutoAlerts"] = {
    ["CarJacking"] = true,
    ["GunshotAlert"] = true
}

Config["CoreSettings"] = {
    ["Core"] = "qbcore", -- Your core | qbcore, esx, npbase
    ["ESX"] = {
        ["ESXTrigger"] = "esx:getSharedObject"
    },
    ["QBCore"] = {
        ["QBCoreVersion"] = "new", -- new = using exports | old = using events
        ["QBCoreExport"] = exports['lrp-core']:GetCoreObject(), -- If you are using old qbcore version just remove this line
        ["QBUSTrigger"] = "QBCore:GetObject"
    },
    ["NPBase"] = {
        ["CoreName"] = "iconic-fw"
    }
}