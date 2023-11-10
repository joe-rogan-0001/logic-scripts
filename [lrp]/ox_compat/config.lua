QBCore = exports['lrp-core']:GetCoreObject()
Config = {}

Config.Modules = {
    ['qb-menu'] = {
        active = true, -- Do you need this module to be enabled?
        resource_name = 'lrp-menu' -- What is the name of the resource that provided this module? (In case you changed its name)
    },
    ['qb-input'] = {
        active = true, -- Do you need this module to be enabled?
        resource_name = 'lrp-input' -- What is the name of the resource that provided this module? (In case you changed its name)
    },
    ['qb-target'] = {
        active = false, -- Do you need this module to be enabled?
        resource_name = 'qb-target' -- What is the name of the resource that provided this module? (In case you changed its name)
    },
}

Config.InventoryName = 'ox_inventory'