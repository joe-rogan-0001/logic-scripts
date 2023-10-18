--[[
    PLEASE READ DOCS BEFORE USING THE SCRIPT
    https://docs.av-scripts.com/laptop-pack/av-restaurants
    https://docs.av-scripts.com/laptop-pack/av-restaurants
    https://docs.av-scripts.com/laptop-pack/av-restaurants
]]

Config = {}
Config.Framework = "QBCore" -- QBCore or ESX... For latest ESX versions make sure to uncomment the import in fxmanifest.lua
Config.Inventory = 'ox_inventory' -- Available options: "ox_inventory", "qs-inventory", "qb-inventory", "lj-inventory"
Config.CashAccountName = "money" -- How the cash money account is named in your Framework
Config.UnemployedJobName = "unemployed" -- How your unemployed job is named
Config.UsingCCLaundering = false -- true if using CC-Laundering: https://ccdev.tebex.io/package/5729384
Config.UsingRenewedBanking = false -- true if you want to use renewed banking for business accounts

-- Item types
Config.ItemTypes = { -- Used for Create Item in Laptop APP
    {value = "drink", label = "Drink"},
    {value = "food", label = "Food"},
    {value = "joint", label = "Joint"},
    {value = "others", label = "Others"},
}

-- Ingredients Config
Config.UseIngredients = true -- true/false if you want food to require ingredients to be crafted
Config.Ingredients = { -- You need to register this items in your Framework/Inventory
    -- value = item name, label = item label
    {value = "water", label = "Water"},
    {value = "sugar", label = "Sugar"},
    {value = "chocolate", label = "Chocolate"},
    {value = "milk", label = "Milk"},
}
Config.TargetSystem = "qb-target" -- qb-target, bt-target, qtarget
Config.Command = "restaurant" -- Used to create new zones
Config.AdminLevel = "admin" -- Permission level needed to use command
Config.DeleteZoneDistance = 15 -- Distance needed between you and the zone you want to delete
Config.itemsWhitelist = { -- If an item is already registered in your Framework it can't be added again, you can whitelist them here.
    ["water"] = true,
    ["bread"] = true,
    ["milkshake"] = true,
    ["vodka"] = true,
}

Config.Events = { -- Used to create zones
    ['cashier'] = {label = {"Cashier", "Pay"}, event = {"av_restaurant:chargeCustomer", "av_restaurant:pay"}, icon = {"fas fa-cash-register", "fas fa-credit-card"}},
    ['drink'] = {label = "Drinks", event = "av_restaurant:drink", icon = "fas fa-glass-whiskey"},
    ['food'] = {label = "Food", event = "av_restaurant:food", icon = "fas fa-utensils"},
    ['joint'] = {label = "Joint", event = "av_restaurant:joint", icon = "fas fa-cannabis"},
    ['others'] = {label = "Others", event = "av_restaurant:others", icon = "fas fa-box"},
    ['stash'] = {label = "Stash", event = "av_restaurant:stash", icon = "fas fa-box-open"},
    ['tray'] = {label = "Tray", event = "av_restaurant:tray", icon = "fas fa-box-open"},
    ['rate'] = {label = "Rate", event = "av_restaurant:rate", icon = "fas fa-star"},
    ['duty'] = {label = "Duty", event = "av_restaurant:duty", icon = "fa-solid fa-briefcase"},
    ['applications'] = {label = "Applications", event = "av_restaurant:applications", icon = "fa-solid fa-briefcase"},
}

-- Items, Stash and Tray Weights
Config.DefaultItemWeight = 5000 -- Just in case the item type isn't defined in the following table
Config.ItemsWeight = {
    ['drink'] = 5000, -- 1kg
    ['food'] = 5000, -- 1kg
    ['joint'] = 1000, -- 1kg
    ['others'] = 1000, -- 1kg
}
Config.StashWeight = 500000 -- Stash Weight (500kg)
Config.StashSlots = 50 -- Stash Item Slots
Config.TrayWeight = 50000 -- Tray Weight (50kg)
Config.TraySlots = 10 -- Tray Item Slots

-- Crafting Options
Config.CraftingTime = 5000 -- 5 seconds
Config.CraftingDict = "anim@amb@business@coc@coc_unpack_cut@" -- Animation dictionary
Config.CraftAnimation = "fullcut_cycle_v6_cokecutter" -- Animation

-- Eat, Drink and Smoke
Config.EatAnimDuration = 3000 -- 3 seconds, eating animation
Config.DrinkAnimDuration = 3000 -- 3 seconds, drinking animation
Config.JointAnimDuration = 10000 -- 10 seconds, smoking animation
Config.EatValue = 50 -- How many hunger points will the food add to player
Config.DrinkValue = 50 -- How many thirst points will the food add to player
Config.JointValue = 50 -- How many stress points will the joint remove from player

Config.NotRestaurant = { -- This jobs can't access the Register Product tab in Laptop
    ['police'] = true,
    ['ambulance'] = true,
    ['taxi'] = true,
    ['judge'] = true,
    ['mechanic'] = true,
}