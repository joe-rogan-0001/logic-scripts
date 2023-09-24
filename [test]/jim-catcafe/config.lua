--print("Jim-CatCafe v1.5.2 - CatCafe Script by Jimathy")

Config = {
	Debug = false, -- false to remove green boxes
	img = "lrp-inventory/html/images/", --Set this to the image directory of your inventory script
	--PatHeal = 2, 			--how much you are healed by patting a cat, 2 hp seems resonable, enough not to be over powered and enough to draw people in.
							--set to 0 if you don't want to use this
	--RelieveStress = 20,		-- How much stress relief per pat
	JimShop = false, 		-- Enable this to use jim-shops for buying ingredients
	CheckMarks = true, -- If true this will show the player if they have the correct items to be able to craft the items
	
	--Simple Toy Reward Support
	RewardItem = "", --Set this to the name of an item eg "bento"
	RewardPool = { -- Set this to the list of items to be given out as random prizes when the item is used - can be more or less items in the list
		"",
		"",
		"",
	},
	
	Items = {
		label = "Ingredients Storage",
		slots = 14,
		items = {
			[1] = { name = "sugar", price = 15, amount = 50, info = {}, type = "item", slot = 1, },
			[2] = { name = "flour", price = 25, amount = 50, info = {}, type = "item", slot = 2, },
			[3] = { name = "onion", price = 15, amount = 50, info = {}, type = "item", slot = 3, },
			[4] = { name = "boba", price = 10, amount = 50, info = {}, type = "item", slot = 4, },
			[5] = { name = "strawberry", price = 5, amount = 50, info = {}, type = "item", slot = 5, },
			[6] = { name = "milk", price = 15, amount = 50, info = {}, type = "item", slot = 6, },
			[7] = { name = "noodles", price = 15, amount = 50, info = {}, type = "item", slot = 7, },
			[8] = { name = "soju", price = 45, amount = 50, info = {}, type = "item", slot = 8, },
			[9] = { name = "mincedmeat", price = 20, amount = 50, info = {}, type = "item", slot = 9, },
			[10] = { name = "shrimp", price = 25, amount = 50, info = {}, type = "item", slot = 10, },
			[11] = { name = "icecube", price = 25, amount = 50, info = {}, type = "item", slot = 11, },
			[12] = { name = "cookedchicken", price = 30, amount = 50, info = {}, type = "item", slot = 12, },
			[13] = { name = "soju", price = 30, amount = 50, info = {}, type = "item", slot = 13, },
		},
	},
	Locations = {
		[1] = {
			zoneEnable = true,
			label = "noodleexchange", -- Set this to the required job
			zones = {
			  vector2(-591.15808105469, -1087.8620605469),
			  vector2(-563.33447265625, -1087.8508300781),
			  vector2(-563.26678466797, -1045.1898193359),
			  vector2(-618.20904541016, -1044.2902832031),
			  vector2(-617.80517578125, -1079.7291259766),
			  vector2(-599.44097900391, -1079.6105957031)
			},
			--garage = { spawn = vector4(-616.68, -1083.44, 22.18, 0),
					   --out = vector4(-593.19, -1084.99, 22.33, 311.96),
					   --list = { "panto", "speedo", } },
			blip = vector3(-581.06, -1066.22, 22.34),
			blipcolor = 280,
		},
	},
}
Crafting = {
	ChoppingBoard = {
	},
	Oven = {
		[1] = { ['springrolls'] = { ['flour'] = 1, ['mincedmeat'] = 1, }, },
		[2] = { ['dragonrolls'] = { ['flour'] = 1, ['shrimp'] = 1, }, },
	},
	Coffee = {
		[1] = { ['fantaslushy'] = { ['icecube'] = 1, ['strawberry'] = 1, ['sugar'] = 1, } },
		[2] = { ['bbobatea'] = { ['boba'] = 1, ['milk'] = 1, ['sugar'] = 1, }, },
	},
	Hob = {
		[1] = { ['saltandpepperchicken'] = { ['cookedchicken'] = 1 }, },
		[2] = { ['ramen'] = { ['noodles'] = 1, ['onion'] = 1, }, },
		--[3] = { ['noodlebowl'] = { ['noodles'] = 1, ['onion'] = 1, ['cookedchicken'] = 1, }, },
		[3] = { ['friednoodles'] = { ['noodles'] = 1, ['onion'] = 1, ['cookedchicken'] = 1, }, },
	},
}