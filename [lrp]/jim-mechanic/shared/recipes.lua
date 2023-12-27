Crafting = {
	Tools = {
		{ ["mechanic_tools"] = { ["iron"] = 10, } },
		{ ["toolbox"] = { ["iron"] = 10, } },
		{ ["ducttape"] = { ["plastic"] = 10, } },
		{ ["paintcan"] = { ["aluminum"] = 10, } },
		{ ["tint_supplies"] = { ["iron"] = 10, } },
		{ ["underglow_controller"] = { ["iron"] = 10, } },
		{ ["cleaningkit"] = { ["rubber"] = 10, } },
		{ ["newoil"] = { ["plastic"] = 10, } },
		{ ["sparkplugs"] = { ["metalscrap"] = 10, } },
		{ ["carbattery"] = { ["metalscrap"] = 10, ["plastic"] = 10 } },
		{ ["axleparts"] = { ["steel"] = 10, } },
		{ ["sparetire"] = { ["rubber"] = 10, } },

				-- Example : Delete me --
		-- Support for multiple items in recipes --
		-- Support for multiple resulting items --
		-- Support to limit items to certain job roles --
--		{ ["cleaningkit"] = { ["rubber"] = 5, ["engine2"] = 1, ["plastic"] = 2 },
--				["amount"] = 2, ["job"] = { ["mechanic"] = 4, ["tuner"] = 4, } },
				-- Example : Delete me --

	},
	Perform = {
		{ ["turbo"] = { ["steel"] = 15, } },
		{ ["car_armor"] = { ["plastic"] = 35, } },
		{ ["engine1"] = { ["steel"] = 15, } },
		{ ["engine2"] = { ["steel"] = 15, } },
		{ ["engine3"] = { ["steel"] = 15, } },
		{ ["engine4"] = { ["steel"] = 15, } },
		{ ["engine5"] = { ["steel"] = 15, } },
		{ ["transmission1"] = { ["steel"] = 15, } },
		{ ["transmission2"] = { ["steel"] = 15, } },
		{ ["transmission3"] = { ["steel"] = 15, } },
		{ ["transmission4"] = { ["steel"] = 15, } },
		{ ["brakes1"] = { ["steel"] = 15, } },
		{ ["brakes2"] = { ["steel"] = 15, } },
		{ ["brakes3"] = { ["steel"] = 15, } },
		{ ["suspension1"] = { ["steel"] = 15, } },
		{ ["suspension2"] = { ["steel"] = 15, } },
		{ ["suspension3"] = { ["steel"] = 15, } },
		{ ["suspension4"] = { ["steel"] = 15, } },
		{ ["suspension5"] = { ["steel"] = 15, } },
		{ ["drifttires"] = { ["rubber"] = 35, } },
		{ ["nos"] = { ["noscan"] = 1, } },
		{ ["noscan"] = { ["steel"] = 30, } },
	},
	Cosmetic = {
		{ ["hood"] = { ["plastic"] = 20, } },
		{ ["roof"] = { ["plastic"] = 20, } },
		{ ["spoiler"] = { ["plastic"] = 20, } },
		{ ["bumper"] = { ["plastic"] = 20, } },
		{ ["skirts"] = { ["plastic"] = 20, } },
		{ ["exhaust"] = { ["iron"] = 20, } },
		{ ["seat"] = { ["plastic"] = 20, } },
		{ ["livery"] = { ["plastic"] = 20 }, },
		{ ["tires"] = { ["rubber"] = 20, } },
		{ ["horn"] = { ["plastic"] = 20, } },
		{ ["internals"] = { ["plastic"] = 20, } },
		{ ["externals"] = { ["plastic"] = 20, } },
		{ ["customplate"] = { ["steel"] = 10, } },
		{ ["headlights"] = { ["plastic"] = 10, } },
		{ ["rims"] = { ["iron"] = 20, } },
		{ ["rollcage"] = { ["steel"] = 10, } },
		{ ["noscolour"] = { ["plastic"] = 20, } },
	},
}

Stores = {
	ToolItems = {
		label = Loc[Config.Lan]["stores"].tools,
		items = {
			{ name = "mechanic_tools", price = 1000, amount = 10, info = {}, type = "item", },
			{ name = "toolbox", price = 1000, amount = 10, info = {}, type = "item", },
			{ name = "ducttape", price = 1000, amount = 100, info = {}, type = "item", },
			{ name = "paintcan", price = 1000, amount = 50, info = {}, type = "item", },
			{ name = "tint_supplies", price = 1000, amount = 50, info = {}, type = "item", },
			{ name = "underglow_controller", price = 1000, amount = 50, info = {}, type = "item", },
			{ name = "cleaningkit", price = 1000, amount = 100, info = {}, type = "item", },
			{ name = "sparetire", price = 1000, amount = 100, info = {}, type = "item", },
			{ name = "axleparts", price = 1000, amount = 1000, info = {}, type = "item", },
			{ name = "carbattery", price = 1000, amount = 1000, info = {}, type = "item", },
			{ name = "sparkplugs", price = 1000, amount = 1000, info = {}, type = "item", },
			{ name = "newoil", price = 1000, amount = 1000, info = {}, type = "item", },
		},
	},
	PerformItems = {
		label = Loc[Config.Lan]["stores"].perform,
		items = {
			{ name = "turbo", price = 35000, amount = 50, info = {}, type = "item", },
			{ name = "engine1", price = 7500, amount = 50, info = {}, type = "item", },
			{ name = "engine2", price = 10000, amount = 50, info = {}, type = "item", },
			{ name = "engine3", price = 15000, amount = 50, info = {}, type = "item", },
			{ name = "engine4", price = 20000, amount = 50, info = {}, type = "item", },
			{ name = "engine5", price = 34000, amount = 50, info = {}, type = "item", },
			{ name = "transmission1", price = 7500, amount = 50, info = {}, type = "item", },
			{ name = "transmission2", price = 10000, amount = 50, info = {}, type = "item", },
			{ name = "transmission3", price = 15000, amount = 50, info = {}, type = "item", },
			{ name = "transmission4", price = 30000, amount = 50, info = {}, type = "item", },
			{ name = "brakes1", price = 5000, amount = 50, info = {}, type = "item", },
			{ name = "brakes2", price = 7500, amount = 50, info = {}, type = "item", },
			{ name = "brakes3", price = 15000, amount = 50, info = {}, type = "item", },
			{ name = "car_armor", price = 30000, amount = 50, info = {}, type = "item", },
			{ name = "suspension1", price = 5000, amount = 50, info = {}, type = "item", },
			{ name = "suspension2", price = 10000, amount = 50, info = {}, type = "item", },
			{ name = "suspension3", price = 15000, amount = 50, info = {}, type = "item", },
			{ name = "suspension4", price = 20000, amount = 50, info = {}, type = "item", },
			{ name = "suspension5", price = 25000, amount = 50, info = {}, type = "item", },
			{ name = "bprooftires", price = 500000, amount = 50, info = {}, type = "item", },
			{ name = "drifttires", price = 35000, amount = 50, info = {}, type = "item", },
			{ name = "nos", price = 15000, amount = 50, info = {}, type = "item", },
		},
	},
	StoreItems = {
		label = Loc[Config.Lan]["stores"].cosmetic,
		items = {
			{ name = "hood", price = 200, amount = 50, info = {}, type = "item", },
			{ name = "roof", price = 200, amount = 50, info = {}, type = "item", },
			{ name = "spoiler", price = 200, amount = 50, info = {}, type = "item", },
			{ name = "bumper", price = 200, amount = 50, info = {}, type = "item", },
			{ name = "skirts", price = 200, amount = 50, info = {}, type = "item", },
			{ name = "exhaust", price = 200, amount = 50, info = {}, type = "item", },
			{ name = "seat", price = 200, amount = 50, info = {}, type = "item", },
			{ name = "livery", price = 200, amount = 50, info = {}, type = "item", },
			{ name = "tires", price = 200, amount = 50, info = {}, type = "item", },
			{ name = "horn", price = 200, amount = 50, info = {}, type = "item", },
			{ name = "internals", price = 200, amount = 50, info = {}, type = "item", },
			{ name = "externals", price = 200, amount = 50, info = {}, type = "item", },
			{ name = "customplate", price = 200, amount = 50, info = {}, type = "item", },
			{ name = "headlights", price = 200, amount = 50, info = {}, type = "item", },
			{ name = "rims", price = 200, amount = 100, info = {}, type = "item", },
			{ name = "rollcage", price = 200, amount = 50, info = {}, type = "item", },
			{ name = "noscolour", price = 200, amount = 50, info = {}, type = "item", },
		},
	},
}

-- No Touch
	-- This is corrective code to help simplify the stores for people removing the slot info
	-- Jim shops doesn"t use it but other inventories do
	-- Most people don"t even edit the slots, these lines generate the slot info autoamtically
Stores.StoreItems.slots = #Stores.StoreItems.items
for k in pairs(Stores.StoreItems.items) do Stores.StoreItems.items[k].slot = k end
Stores.PerformItems.slots = #Stores.PerformItems.items
for k in pairs(Stores.PerformItems.items) do Stores.PerformItems.items[k].slot = k end
Stores.ToolItems.slots = #Stores.ToolItems.items
for k in pairs(Stores.ToolItems.items) do Stores.ToolItems.items[k].slot = k end