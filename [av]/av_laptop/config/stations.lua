-- THIS ONLY WORKS WITH OX_INVENTORY, DON'T BLAME ME BUT OTHER INVENTORIES DOESN'T HAVE THE NEEDED EXPORTS FOR THIS TO WORK CORRECTLY!
-- THIS ONLY WORKS WITH OX_INVENTORY, DON'T BLAME ME BUT OTHER INVENTORIES DOESN'T HAVE THE NEEDED EXPORTS FOR THIS TO WORK CORRECTLY!
-- THIS ONLY WORKS WITH OX_INVENTORY, DON'T BLAME ME BUT OTHER INVENTORIES DOESN'T HAVE THE NEEDED EXPORTS FOR THIS TO WORK CORRECTLY!
-- Charge stations are zones where only authorized personal can access to charge laptops
-- Every 5 minutes charge stations will add X percentage to every laptop until they reach 100% of battery charge
-- type = "charge" are zones where u can leave laptops to charge battery
-- type = "reset" are zones where u can leave 1 laptop to do a factory reset
useZones = true -- true/false to use zones with TextUI, if false check the docs to know how to trigger the open event

Stations = {
    ['uwu_station'] = {
        label = Lang['charging_station'],
        coords = {-585.4407, -1056.0166, 22.3442},
        job = "police",
        slots = 10,
        maxWeight = 50000,
        percentage = 10,
        type = "charge"
    },
    ['digital_den'] = {
        label = Lang['reset_station'],
        coords = {1134.5182, -467.1835, 66.4859},
        job = "police",
        slots = 1, -- Don't use more than 1
        maxWeight = 50000,
        type = "reset",
        price = 500, --Amount to be charged for each factory reset
        account = "bank",
        money_symbol = "$"
    },
}