return {
	['testburger']                 = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 7500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			},
			{
				label = 'What do you call a vegan burger?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('A misteak.')
				end
			},
			{
				label = 'What do frogs like to eat with their hamburgers?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('French flies.')
				end
			},
			{
				label = 'Why were the burger and fries running?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('Because they\'re fast food.')
				end
			}
		},
		consume = 0.3
	},

	['mdtcitation'] 				 = {
		label = 'Citation', 			
		weight = 10, 						
	},


	['bandage']                    = {
		label = 'Bandage',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
--			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = {combat = true },
			usetime = 7500,
		}
	},

	['blackmoney']                = {
		label = 'Dirty Money',
	},

	['burger']                     = {
		label = 'Burger',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 7500,
			notification = 'You ate a delicious burger'
		},
	},

	['cola']                       = {
		label = 'eCola',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 7500,
			notification = 'You quenched your thirst with cola'
		}
	},

	['parachute']                  = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage']                    = {
		label = 'Garbage',
	},

	['paperbag']                   = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['identification']             = {
		label = 'Identification',
	},

	['panties']                    = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 7500,
		}
	},

	['lockpick']                   = {
		label = 'Lockpick',
		weight = 160,
	},

	['phone']                      = {
		label = 'Phone',
		weight = 190,
		stack = false,
		consume = 0,
		client = {
			add = function(total)
				if total > 0 then
					pcall(function() return exports.npwd:setPhoneDisabled(false) end)
				end
			end,

			remove = function(total)
				if total < 1 then
					pcall(function() return exports.npwd:setPhoneDisabled(true) end)
				end
			end
		}
	},

	['money']                      = {
		label = 'Money',
	},

	['mustard']                    = {
		label = 'Mustard',
		weight = 500,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 7500,
			notification = 'You.. drank mustard'
		}
	},

	['water']                      = {
		label = 'Water',
		weight = 500,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 7500,
			cancel = true,
			notification = 'You drank some refreshing water'
		}
	},

	['radio']                      = {
		label = 'Radio',
		weight = 1000,
		stack = false,
		allowArmed = true
	},

	['armour']                     = {
		label = 'Bulletproof Vest',
		weight = 3000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 7500
		}
	},

	['clothing']                   = {
		label = 'Clothing',
		consume = 0,
	},

	['mastercard']                 = {
		label = 'Mastercard',
		stack = false,
		weight = 10,
	},

	['scrapmetal']                 = {
		label = 'Scrap Metal',
		weight = 80,
	},

	["crack_baggy"]                = {
		label = "Bag of Crack",
		weight = 0,
		stack = true,
		close = true,
		description = "To get happy faster",
		client = {
			image = "crack_baggy.png",
		}
	},

	["milk"]                       = {
		label = "Milk",
		weight = 300,
		stack = true,
		close = true,
		description = "Carton of Milk",
		client = {
			image = "burger-milk.png",
		}
	},

	["casino_member"]              = {
		label = "Casino Membership",
		weight = 500,
		stack = false,
		close = false,
		description = "Diamond Casino Member Card",
		client = {
			image = "casino_member.png",
		}
	},

	["plastic"]                    = {
		label = "Plastic",
		weight = 500,
		stack = true,
		close = false,
		description = "RECYCLE! - Greta Thunberg 2019",
		client = {
			image = "plastic.png",
		}
	},

	["casino_goldchip"]            = {
		label = "Casino Chip",
		weight = 0,
		stack = true,
		close = false,
		description = "Diamond Casino Chip",
		client = {
			image = "casino_goldchip.png",
		}
	},

	["fishingkey"]                 = {
		label = "Corroded Key",
		weight = 800,
		stack = true,
		close = true,
		description = "A weathered key that looks usefull",
		client = {
			image = "fishingkey.png",
		}
	},

	["orange"]                     = {
		label = "Orange",
		weight = 500,
		stack = true,
		close = true,
		description = "Orange",
		client = {
			image = "orange.png",
		}
	},

	["methlab"]                    = {
		label = "Methlab Gear",
		weight = 500,
		stack = true,
		close = true,
		description = "Lab Gear",
		client = {
			image = "lab.png",
		}
	},

	["vodka"]                      = {
		label = "Vodka",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "vodka.png",
		}
	},

	["glock_extendedclip"]         = {
		label = "Glock EXT Clip",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "glock_extendedclip.png",
		}
	},

	["marijuana_phone"]            = {
		label = "Burner Phone",
		weight = 0,
		stack = true,
		close = true,
		description = "Burner phone used to sell eights",
		client = {
			image = "marijuana_phone.png",
		}
	},

	["marijuana_crop_mid"]         = {
		label = "Harvested Crop",
		weight = 5500,
		stack = true,
		close = false,
		description = "mid grade harvested marijuana crop",
		client = {
			image = "marijuana_crop_mid.png",
		}
	},

	["tunerlaptop"]                = {
		label = "Tunerchip",
		weight = 2000,
		stack = false,
		close = true,
		description = "With this tunerchip you can get your car on steroids... If you know what you're doing",
		client = {
			image = "tunerchip.png",
		}
	},

	["table"]                      = {
		label = "Deployable table",
		weight = 10000,
		stack = true,
		close = true,
		description = "table",
		client = {
			image = "coketable.png",
		}
	},

	["burger-toy1"]                = {
		label = "Action Figure",
		weight = 350,
		stack = false,
		close = false,
		description = "An Action Figure From the late 90's",
		client = {
			image = "action-figure.png",
		}
	},

	["boarskin"]                   = {
		label = "Boar skin",
		weight = 8000,
		stack = true,
		close = false,
		description = "Pelt of a Boar.",
		client = {
			image = "boarskin.png",
		}
	},

	["gelatine"]                   = {
		label = "Gelatine",
		weight = 100,
		stack = true,
		close = true,
		description = "A packet of gelatine, good for making sweets!",
		client = {
			image = "gelatine.png",
		}
	},

	["labkey"]                     = {
		label = "Key",
		weight = 500,
		stack = false,
		close = true,
		description = "Key for a lock...?",
		client = {
			image = "labkey.png",
		}
	},

	["tree_lumber"]                = {
		label = "Lumber",
		weight = 4500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lumber.png",
		}
	},

	["burger-toy2"]                = {
		label = "Pink Teddy",
		weight = 350,
		stack = false,
		close = false,
		description = "A Fluffy Pink Teddy from the Atic",
		client = {
			image = "beaniebaby.png",
		}
	},

	["huntingbait"]                = {
		label = "Hunting Bait",
		weight = 2000,
		stack = true,
		close = true,
		description = "Bait for hunting animals, works best up north.",
		client = {
			image = "huntingbait.png",
		}
	},

	["water_bottle"]               = {
		label = "Bottle of Water",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "water_bottle.png",
		}
	},

	["weed_white-widow"]           = {
		label = "White Widow 2g",
		weight = 600,
		stack = true,
		close = false,
		description = "A weed bag with 2g White Widow",
		client = {
			image = "weed_baggy.png",
		}
	},

	["casino_whitechip"]           = {
		label = "Casino Chip",
		weight = 0,
		stack = true,
		close = false,
		description = "Diamond Casino Slot Machine Chip",
		client = {
			image = "casino_whitechip.png",
		}
	},

	["rolls"]                      = {
		label = "Roll Of Small Notes",
		weight = 100,
		stack = true,
		close = false,
		description = "A roll of small notes..",
		client = {
			image = "cashroll.png",
		}
	},

	["weed_ak47_cbd"]              = {
		label = "CBD AK47 2g",
		weight = 2,
		stack = true,
		close = false,
		description = "A 2g bag of CBD AK47!",
		client = {
			image = "weed_ak47_cbd.png",
		}
	},

	["laptop_red"]                 = {
		label = "Red Laptop",
		weight = 2500,
		stack = false,
		close = true,
		description = "Red Laptop (marked for police seizure)",
		client = {
			image = "laptop_red.png",
		}
	},

	["gummybearmould"]             = {
		label = "Gummy Bear Mould",
		weight = 100,
		stack = true,
		close = true,
		description = "A BPA free mould, shaped like a bear!",
		client = {
			image = "gummybearmould.png",
		}
	},

	["visa"]                       = {
		label = "Visa Card",
		weight = 500,
		stack = false,
		close = false,
		description = "Visa can be used via ATM",
		client = {
			image = "visacard.png",
		}
	},

	["gatecrack"]                  = {
		label = "Gatecrack",
		weight = 0,
		stack = true,
		close = true,
		description = "Handy software to tear down some fences",
		client = {
			image = "usb_device.png",
		}
	},

	["boarmeat"]                   = {
		label = "Boar Meat",
		weight = 5000,
		stack = true,
		close = false,
		description = "Meat of Boar.",
		client = {
			image = "boarmeat.png",
		}
	},

	["drill"]                      = {
		label = "Drill",
		weight = 20000,
		stack = true,
		close = false,
		description = "The real deal...",
		client = {
			image = "drill.png",
		}
	},

	["rubber"]                     = {
		label = "Rubber",
		weight = 100,
		stack = true,
		close = false,
		description = "Rubber, I believe you can make your own rubber ducky with it :D",
		client = {
			image = "rubber.png",
		}
	},

	["casino_bluechip"]            = {
		label = "Casino Chip",
		weight = 0,
		stack = true,
		close = false,
		description = "Diamond Casino Roulette Chip",
		client = {
			image = "casino_bluechip.png",
		}
	},

	["marijuana_scale"]            = {
		label = "Scale",
		weight = 0,
		stack = true,
		close = false,
		description = "This is not what it looks like",
		client = {
			image = "marijuana_scale.png",
		}
	},

	["gangcrate"]                  = {
		label = "Unknown Crate",
		weight = 30000,
		stack = false,
		close = false,
		description = "Suspicious looking crate (LOCKED)",
		client = {
			image = "gangcrate.png",
		}
	},

	["marijuana_rollingpapers"]    = {
		label = "Rolling Papers",
		weight = 0,
		stack = true,
		close = true,
		description = "These aint Raw Rolling Papers!!?",
		client = {
			image = "marijuana_rollingpapers.png",
		}
	},

	["fruit_pack"]                 = {
		label = "Fruit Pack",
		weight = 300,
		stack = true,
		close = true,
		description = "Fruit Pack",
		client = {
			image = "fruit_pack.png",
		}
	},

	["gunpowder"]                  = {
		label = "Gun Powder",
		weight = 250,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "gunpowder.png",
		}
	},

	["lawyerpass"]                 = {
		label = "Lawyer Pass",
		weight = 500,
		stack = false,
		close = false,
		description = "Pass exclusive to lawyers to show they can represent a suspect",
		client = {
			image = "lawyerpass.png",
		}
	},

	["casino_blackchip"]           = {
		label = "Casino Chip",
		weight = 0,
		stack = true,
		close = false,
		description = "Diamond Casino Blackjack Chip",
		client = {
			image = "casino_blackchip.png",
		}
	},

	["remote_detinator"]           = {
		label = "Remote Detinator",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "remote_detinator.png",
		}
	},

	["cdl_license"]                = {
		label = "CDL License",
		weight = 500,
		stack = false,
		close = false,
		description = "Permit to show you can drive a Heavy goods vehicle",
		client = {
			image = "driver_license.png",
		}
	},

	["advancedlockpick"]           = {
		label = "Advanced Lockpick",
		weight = 500,
		stack = true,
		close = true,
		description = "If you lose your keys a lot this is very useful... Also useful to open your beers",
		client = {
			image = "advancedlockpick.png",
		}
	},

	["meth"]                       = {
		label = "Meth",
		weight = 500,
		stack = true,
		close = true,
		description = "A baggie of Meth a day will keep the suicidal thoughts away!",
		client = {
			image = "meth_baggy.png",
		}
	},

	["dp9_extendedclip"]           = {
		label = "DP9 EXT Clip",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "dp9_extendedclip.png",
		}
	},

	["stickynote"]                 = {
		label = "Sticky note",
		weight = 0,
		stack = false,
		close = false,
		description = "Sometimes handy to remember something :)",
		client = {
			image = "stickynote.png",
		}
	},

	["boba"]                       = {
		label = "Boba",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "boba.png",
		}
	},

	["fishingrod"]                 = {
		label = "Fishing Rod",
		weight = 1250,
		stack = true,
		close = true,
		description = "A fishing rod for adventures with friends!!",
		client = {
			image = "fishingrod.png",
		}
	},

	["gummy_amnesia_cbd"]          = {
		label = "CBD Amnesia Gummy",
		weight = 4,
		stack = true,
		close = true,
		description = "A edible cbd og kush gummy bear!",
		client = {
			image = "gummy_amnesia_cbd.png",
		}
	},

	["weed_skunk"]                 = {
		label = "Skunk 2g",
		weight = 600,
		stack = true,
		close = false,
		description = "A weed bag with 2g Skunk",
		client = {
			image = "weed_baggy.png",
		}
	},

	["boombox"]                    = {
		label = "Boombox",
		weight = 5000,
		stack = false,
		close = true,
		description = "Play some music anywhere.",
		client = {
			image = "boombox.png",
		}
	},

	["gummy_white-widow_cbd"]      = {
		label = "CBD White-Widow Gummy",
		weight = 4,
		stack = true,
		close = true,
		description = "A edible cbd white widow gummy bear!",
		client = {
			image = "gummy_white-widow_cbd.png",
		}
	},

	["greendongle"]                = {
		label = "Green Dongle",
		weight = 10000,
		stack = false,
		close = false,
		description = "Progress for something big... (Marked For Police Seizure)",
		client = {
			image = "greendongle.png",
		}
	},

	["heavyarmor"]                 = {
		label = "Heavy Armour",
		weight = 5000,
		stack = true,
		close = true,
		description = "Some protection won't hurt... right?",
		client = {
			image = "armor.png",
		}
	},

	["burger-potato"]              = {
		label = "Bag of Potatoes",
		weight = 1500,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bs_potato.png",
		}
	},

	["drug_grinder"]               = {
		label = "Tobacco Grinder",
		weight = 100,
		stack = true,
		close = true,
		description = "A tobacco grinder or something more..",
		client = {
			image = "drug_grinder.png",
		}
	},

	["anchor"]                     = {
		label = "Boat Anchor",
		weight = 3500,
		stack = true,
		close = true,
		description = "Boat Anchor",
		client = {
			image = "anchor.png",
		}
	},

	["usb_red"]                    = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A red USB flash drive",
		client = {
			image = "usb_red.png",
		}
	},

	["explosive"]                  = {
		label = "Explosive",
		weight = 5000,
		stack = true,
		close = true,
		description = "An improvised explosive of fireworks and thermite",
		client = {
			image = "explosive.png",
		}
	},

	["lmg_barrel"]                 = {
		label = "LMG Barrel",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lmg_barrel.png",
		}
	},

	["diamond_ring"]               = {
		label = "Diamond Ring",
		weight = 1500,
		stack = true,
		close = true,
		description = "A diamond ring seems like the jackpot to me!",
		client = {
			image = "diamond_ring.png",
		}
	},

	["weed_amnesia"]               = {
		label = "Amnesia 2g",
		weight = 600,
		stack = true,
		close = false,
		description = "A weed bag with 2g Amnesia",
		client = {
			image = "weed_baggy.png",
		}
	},

	["m4_holographic"]             = {
		label = "M4 Holographic",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "m4_holographic.png",
		}
	},

	["processed_coyotefur"]        = {
		label = "Processed Coyote Fur",
		weight = 6500,
		stack = true,
		close = false,
		description = "Fur of a coyote.",
		client = {
			image = "processed_coyotefur.png",
		}
	},

	["burger-bun"]                 = {
		label = "Bun",
		weight = 525,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bs_bun.png",
		}
	},

	["heistlaptop3"]               = {
		label = "Green Laptop",
		weight = 20000,
		stack = false,
		close = false,
		description = "High-tech laptop, with sketchy software installed (Marked For Police Seizure)",
		client = {
			image = "greenlaptop.png",
		}
	},

	["huntinglicense"]             = {
		label = "Hunting License",
		weight = 500,
		stack = false,
		close = true,
		description = "Hunting License",
		client = {
			image = "hunting_license.png",
		}
	},

	["marijuana_1oz_low"]          = {
		label = "1oz marijuana",
		weight = 2800,
		stack = false,
		close = false,
		description = "1oz low grade marijuana",
		client = {
			image = "marijuana_1oz_low.png",
		}
	},

	["meth_cured"]                 = {
		label = "Unlocked Crate",
		weight = 30000,
		stack = true,
		close = false,
		description = "Suspicious looking crate (UNLOCKED)",
		client = {
			image = "gangcrate.png",
		}
	},

	["burger-mshake"]              = {
		label = "Milkshake",
		weight = 1250,
		stack = true,
		close = true,
		description = "Hand-scooped for you!",
		client = {
			image = "bs_milkshake.png",
		}
	},

	["package"]                    = {
		label = "Suspicious Package",
		weight = 15000,
		stack = false,
		close = false,
		description = "A mysterious package.. Scary!",
		client = {
			image = "package.png",
		}
	},

	["m4_ironsight"]               = {
		label = "M4 Iron Sight",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "m4_ironsight.png",
		}
	},

	["mincedmeat"]                 = {
		label = "Minced Meat",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mincedmeat.png",
		}
	},

	["limewater"]                  = {
		label = "Bottle of Limewater",
		weight = 750,
		stack = true,
		close = false,
		description = "Bottle of Limewater, used for processing furs and pelts",
		client = {
			image = "limewater.png",
		}
	},

	["boating_license"]            = {
		label = "Boating License",
		weight = 500,
		stack = false,
		close = true,
		description = "Boating License",
		client = {
			image = "boating_license.png",
		}
	},

	["cratekey"]                   = {
		label = "Crate Key",
		weight = 0,
		stack = false,
		close = false,
		description = "Key for a crate",
		client = {
			image = "cratekey.png",
		}
	},

	["weed_og-kush_seed"]          = {
		label = "OGKush Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of OG Kush",
		client = {
			image = "weed_seed.png",
		}
	},

	["bowlingreceipt"]             = {
		label = "Bowling Recepit",
		weight = 150,
		stack = true,
		close = true,
		description = "Magic",
		client = {
			image = "bowlingreceipt.png",
		}
	},

	["ironoxide"]                  = {
		label = "Iron Powder",
		weight = 500,
		stack = true,
		close = false,
		description = "Some powder to mix with.",
		client = {
			image = "ironoxide.png",
		}
	},

	["cookedchicken"]              = {
		label = "Cooked Chicken",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cookedchicken.png",
		}
	},

	["glock_defaultclip"]          = {
		label = "Glock Clip",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "glock_defaultclip.png",
		}
	},

	["burger-torpedo"]             = {
		label = "Torpedo",
		weight = 3100,
		stack = true,
		close = true,
		description = "Sates Hunger.",
		client = {
			image = "bs_torpedo.png",
		}
	},

	["burger-meatfree"]            = {
		label = "MeatFree",
		weight = 1250,
		stack = true,
		close = true,
		description = "Sates Hunger.",
		client = {
			image = "bs_meat-free.png",
		}
	},

	["rawhoney"]                   = {
		label = "Raw Honey",
		weight = 100,
		stack = true,
		close = true,
		description = "A jar of rawhoney, good for making sweets!",
		client = {
			image = "rawhoney.png",
		}
	},

	["weed_og-kush"]               = {
		label = "OGKush 2g",
		weight = 600,
		stack = true,
		close = false,
		description = "A weed bag with 2g OG Kush",
		client = {
			image = "weed_baggy.png",
		}
	},

	["emp_cartilage"]              = {
		label = "EMP Cartridge",
		weight = 1000,
		stack = true,
		close = true,
		description = "Government (PD/EMS/DOC) Issued Equipment",
		client = {
			image = "empammo.png",
		}
	},

	["thermitec"]                  = {
		label = "Thermite Charge",
		weight = 1000,
		stack = true,
		close = true,
		description = "Go Burning (Marked For Police Seizure)",
		client = {
			image = "thermitec.png",
		}
	},

	["marijuana_1oz_high"]         = {
		label = "1oz marijuana",
		weight = 2800,
		stack = false,
		close = false,
		description = "1oz high grade marijuana",
		client = {
			image = "marijuana_1oz_high.png",
		}
	},

	["fishingloot"]                = {
		label = "Metal Box",
		weight = 1500,
		stack = true,
		close = true,
		description = "Seems to be a corroded from the salt water, Should be easy to open",
		client = {
			image = "fishingloot.png",
		}
	},

	["marijuana_3.5_high"]         = {
		label = "3.5g marijuana",
		weight = 2800,
		stack = false,
		close = true,
		description = "3.5g high grade marijuana",
		client = {
			image = "marijuana_3.5_high.png",
		}
	},

	["mackerel"]                   = {
		label = "Mackerel",
		weight = 3500,
		stack = false,
		close = false,
		description = "Mackerel",
		client = {
			image = "mackerel.png",
		}
	},

	["killerwhale"]                = {
		label = "Whale",
		weight = 15000,
		stack = false,
		close = false,
		description = "Killer Whale",
		client = {
			image = "killerwhale.png",
		}
	},

	["friednoodles"]               = {
		label = "Fried Noodles",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 48,
			},
			image = "friednoodles.png",
		}
	},

	["wood_plank"]                 = {
		label = "Wood Plank",
		weight = 10000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "woodplank.png",
		}
	},

	["weed_ak47_cbd_crop"]         = {
		label = "CBD AK 47 Crop",
		weight = 1200,
		stack = true,
		close = false,
		description = "A crop of CBD AK47!",
		client = {
			image = "weed_ak47_cbd_crop.png",
		}
	},

	["huntingknife"]               = {
		label = "Hunting Knife",
		weight = 2000,
		stack = false,
		close = false,
		description = "Hunting Knife.",
		client = {
			image = "huntingknife.png",
		}
	},

	["deermeat"]                   = {
		label = "Deer Meat",
		weight = 5000,
		stack = true,
		close = false,
		description = "Meat of a deer.",
		client = {
			image = "deermeat.png",
		}
	},

	["rolex"]                      = {
		label = "Golden Watch",
		weight = 1500,
		stack = true,
		close = true,
		description = "A golden watch seems like the jackpot to me!",
		client = {
			image = "rolex.png",
		}
	},

	["security_card_01"]           = {
		label = "Security Card A",
		weight = 500,
		stack = true,
		close = true,
		description = "A security card... I wonder what it goes to",
		client = {
			image = "security_card_01.png",
		}
	},

	["marijuana_joint3g"]          = {
		label = "Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "3g joint",
		client = {
			image = "marijuana_joint3g.png",
		}
	},

	["campfire"]                   = {
		label = "Campfire",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "campfire.png",
		}
	},

	["burger-softdrink"]           = {
		label = "Soft Drink",
		weight = 1250,
		stack = true,
		close = true,
		description = "An Ice Cold Drink.",
		client = {
			image = "bs_softdrink.png",
		}
	},

	["weed_skunk_cbd_crop"]        = {
		label = "CBD Skunk Crop",
		weight = 1200,
		stack = true,
		close = false,
		description = "A crop of CBD Skunk!",
		client = {
			image = "weed_skunk_cbd_crop.png",
		}
	},

	["burger-moneyshot"]           = {
		label = "Moneyshot",
		weight = 3000,
		stack = true,
		close = true,
		description = "Sates Hunger.",
		client = {
			image = "bs_money-shot.png",
		}
	},

	["charcoal"]                   = {
		label = "Charcoal",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "charcoal.png",
		}
	},

	["burger-meat"]                = {
		label = "Cooked Patty",
		weight = 525,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bs_patty.png",
		}
	},

	["fishbait"]                   = {
		label = "Fish Bait",
		weight = 500,
		stack = true,
		close = true,
		description = "Fishing bait",
		client = {
			image = "fishbait.png",
		}
	},

	["box"]                        = {
		label = "Box",
		weight = 500,
		stack = true,
		close = true,
		description = "box",
		client = {
			image = "box.png",
		}
	},

	["coke_brick"]                 = {
		label = "Coke Brick",
		weight = 10000,
		stack = false,
		close = true,
		description = "Heavy package of cocaine, mostly used for deals and takes a lot of space",
		client = {
			image = "coke_brick.png",
		}
	},

	["marijuana_seeds"]            = {
		label = "Marijuana Seeds",
		weight = 500,
		stack = true,
		close = true,
		description = "marijuana seeds",
		client = {
			image = "marijuana_seeds.png",
		}
	},

	["burger-sodasyrup"]           = {
		label = "Soda Syrup",
		weight = 525,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bs_ingredients_hfcs.png",
		}
	},

	["cement"]                     = {
		label = "Cement",
		weight = 2000,
		stack = true,
		close = true,
		description = " Just Cement",
		client = {
			image = "cement.png",
		}
	},

	["driver_license"]             = {
		label = "Drivers License",
		weight = 500,
		stack = false,
		close = false,
		description = "Permit to show you can drive a vehicle",
		client = {
			image = "driver_license.png",
		}
	},

	["hydratedlime"]               = {
		label = "Hydrated Lime",
		weight = 2000,
		stack = true,
		close = true,
		description = "Powdered lime",
		client = {
			image = "hydratedlime.png",
		}
	},

	["armor"]                      = {
		label = "Armour",
		weight = 5000,
		stack = true,
		close = true,
		description = "Some protection won't hurt... right?",
		client = {
			image = "armor.png",
		}
	},

	["advancedrepairkit"]          = {
		label = "Advanced Repairkit",
		weight = 4000,
		stack = true,
		close = true,
		description = "A nice toolbox with stuff to repair your vehicle",
		client = {
			image = "advancedkit.png",
		}
	},

	["sharktiger"]                 = {
		label = "Shark",
		weight = 8000,
		stack = false,
		close = false,
		description = "Tigershark",
		client = {
			image = "sharktiger.png",
		}
	},

	["m4_flashlight"]              = {
		label = "M4 Flashlight",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "smg_flashlight.png",
		}
	},

	["ifak"]                       = {
		label = "IFAK",
		weight = 1000,
		stack = true,
		close = true,
		description = "Government (PD/EMS/DOC) Issued Equipment",
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
--			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = {combat = true },
			usetime = 7500,
		}
	},

	["coffee"]                     = {
		label = "Coffee",
		weight = 600,
		stack = true,
		close = true,
		description = "Pump 4 Caffeine",
		client = {
			image = "coffee.png",
		}
	},

	["weed_purple-haze"]           = {
		label = "Purple Haze 2g",
		weight = 600,
		stack = true,
		close = false,
		description = "A weed bag with 2g Purple Haze",
		client = {
			image = "weed_baggy.png",
		}
	},

	["noodles"]                    = {
		label = "Instant Noodles",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "noodles.png",
		}
	},

	["id_card"]                    = {
		label = "ID Card",
		weight = 500,
		stack = false,
		close = false,
		description = "A card containing all your information to identify yourself",
		client = {
			image = "id_card.png",
		}
	},

	["grape"]                      = {
		label = "Grape",
		weight = 500,
		stack = true,
		close = false,
		description = "Mmmmh yummie, grapes",
		client = {
			image = "grape.png",
		}
	},

	["10kgoldchain"]               = {
		label = "10k Gold Chain",
		weight = 2000,
		stack = true,
		close = true,
		description = "10 carat golden chain",
		client = {
			image = "10kgoldchain.png",
		}
	},

	["firstaid"]                   = {
		label = "First Aid",
		weight = 2500,
		stack = true,
		close = true,
		description = "You can use this First Aid kit to get people back on their feet",
		client = {
			image = "firstaid.png",
		}
	},

	["weed_ak47_seed"]             = {
		label = "AK47 Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of AK47",
		client = {
			image = "weed_seed.png",
		}
	},

	["firework3"]                  = {
		label = "WipeOut",
		weight = 10000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework3.png",
		}
	},

	["weed_white-widow_cbd_crop"]  = {
		label = "CBD White Widow Crop",
		weight = 1200,
		stack = true,
		close = false,
		description = "A crop of CBD White Widow",
		client = {
			image = "weed_white-widow_cbd_crop.png",
		}
	},

	["washedstone"]                = {
		label = "Washed Stone",
		weight = 2500,
		stack = true,
		close = false,
		description = "ORE",
		client = {
			image = "washedstone.png",
		}
	},

	["markedbills"]                = {
		label = "Marked Money",
		weight = 10000,
		stack = false,
		close = true,
		description = "Money?",
		client = {
			image = "markedbills.png",
		}
	},

	["pinger"]                     = {
		label = "Pinger",
		weight = 10000,
		stack = true,
		close = true,
		description = "With a pinger and your phone you can send out your location",
		client = {
			image = "pinger.png",
		}
	},

	["radioscanner"]               = {
		label = "Radio Scanner",
		weight = 10000,
		stack = true,
		close = true,
		description = "With this you can get some police alerts. Not 100% effective however",
		client = {
			image = "radioscanner.png",
		}
	},

	["m4bp"]                       = {
		label = "M4 BluePrint",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "m4bp.png",
		}
	},

	["lithium"]                    = {
		label = "Lithium",
		weight = 500,
		stack = true,
		close = true,
		description = "Lithium salts",
		client = {
			image = "lithium.png",
		}
	},

	["tent"]                       = {
		label = "Deployable tent",
		weight = 2000,
		stack = true,
		close = true,
		description = "tent",
		client = {
			image = "tent.png",
		}
	},
	["saltandpepperchicken"]       = {
		label = "S & P Chicken",
		weight = 500,
		stack = true,
		close = true,
		description = "Whole Chicken",
		client = {
			status = {
				hunger = 48,
			},
			image = "saltandpepperchicken.png",
		}
	},

	["marijuana_crop_low"]         = {
		label = "Harvested Crop",
		weight = 5500,
		stack = true,
		close = false,
		description = "low grade harvested marijuana crop",
		client = {
			image = "marijuana_crop_low.png",
		}
	},

	["tree_bark"]                  = {
		label = "Tree Bark",
		weight = 1200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "treebark.png",
		}
	},

	["bass"]                       = {
		label = "Bass",
		weight = 2250,
		stack = false,
		close = false,
		description = "A normal fish Tatses pretty good!",
		client = {
			image = "bass.png",
		}
	},

	["harness"]                    = {
		label = "Race Harness",
		weight = 10000,
		stack = false,
		close = true,
		description = "Racing Harness so no matter what you stay in the car",
		client = {
			image = "harness.png",
		}
	},

	["casino_redchip"]             = {
		label = "Casino Chip",
		weight = 0,
		stack = true,
		close = false,
		description = "Diamond Casino Inside Track Chip",
		client = {
			image = "casino_redchip.png",
		}
	},

	["firework4"]                  = {
		label = "Weeping Willow",
		weight = 10000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework4.png",
		}
	},

	["weed_brick"]                 = {
		label = "Weed Brick",
		weight = 10000,
		stack = true,
		close = true,
		description = "1KG Weed Brick to sell to large customers.",
		client = {
			image = "weed_brick.png",
		}
	},

	["marijuana_water"]            = {
		label = "Plant Water",
		weight = 0,
		stack = true,
		close = true,
		description = "Plant water",
		client = {
			image = "marijuana_water.png",
		}
	},

	["recvoucher"]                 = {
		label = "Recycling Voucher",
		weight = 200,
		stack = true,
		close = true,
		description = "Redeem for something nice",
		client = {
			image = "printerdocument.png",
		}
	},

	["coke"]                       = {
		label = "Coke Powder",
		weight = 100,
		stack = true,
		close = true,
		description = "COKE!!",
		client = {
			image = "coke.png",
		}
	},

	["metalscrap"]                 = {
		label = "Metal Scrap",
		weight = 100,
		stack = true,
		close = false,
		description = "You can probably make something nice out of this",
		client = {
			image = "metalscrap.png",
		}
	},

	["weed_skunk_seed"]            = {
		label = "Skunk Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of Skunk",
		client = {
			image = "weed_seed.png",
		}
	},

	["weaponlicense"]              = {
		label = "Weapon License",
		weight = 500,
		stack = false,
		close = true,
		description = "Weapon License",
		client = {
			image = "weapon_license.png",
		}
	},

	["drug_shears"]                = {
		label = "Trimming Shears",
		weight = 200,
		stack = true,
		close = true,
		description = "A set of high quality trimming shears.",
		client = {
			image = "drug_shears.png",
		}
	},

	["weed_bag"]                   = {
		label = "Weed Bag",
		weight = 350,
		stack = true,
		close = true,
		description = "A Road To Happieness!!",
		client = {
			image = "weed_baggy.png",
		}
	},

	["barrel"]                     = {
		label = "Barrel",
		weight = 3000,
		stack = true,
		close = true,
		description = "barrel",
		client = {
			image = "barrel.png",
		}
	},

	["laptop"]                     = {
		label = "Laptop",
		weight = 4000,
		stack = true,
		close = true,
		description = "Expensive laptop",
		client = {
			image = "laptop.png",
		}
	},

	["firework1"]                  = {
		label = "2Brothers",
		weight = 10000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework1.png",
		}
	},

	["weed_ak47"]                  = {
		label = "AK47 2g",
		weight = 600,
		stack = true,
		close = false,
		description = "A weed bag with 2g AK47",
		client = {
			image = "weed_baggy.png",
		}
	},

	["pestle"]                     = {
		label = "Pestle",
		weight = 900,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pestle.png",
		}
	},

	["bowlingball"]                = {
		label = "Bowling Ball",
		weight = 150,
		stack = true,
		close = true,
		description = "Magic",
		client = {
			image = "bowlingball.png",
		}
	},

	["pdarmor"]                    = {
		label = "Police Armour",
		weight = 5000,
		stack = true,
		close = true,
		description = "Government (PD/EMS/DOC) Issued Equipment",
		client = {
			image = "armor.png",
		}
	},

	["rollingpapers"]              = {
		label = "Rolling Papers",
		weight = 50,
		stack = true,
		close = true,
		description = "Paper made specifically for encasing and smoking tobacco or cannabis.",
		client = {
			image = "rollingpapers.png",
		}
	},

	["kurkakola"]                  = {
		label = "Cola",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "cola.png",
		}
	},

	["ramen"]                      = {
		label = "Ramen Noodles",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "ramen.png",
		}
	},

	["handcuffs"]                  = {
		label = "Handcuffs",
		weight = 500,
		stack = true,
		close = true,
		description = "Comes in handy when people misbehave. Maybe it can be used for something else?",
		client = {
			image = "handcuffs.png",
		}
	},

	["weed_amnesia_cbd_joint"]     = {
		label = "CBD Amnesia Joint",
		weight = 1,
		stack = true,
		close = false,
		description = "Light up that amnesia son!",
		client = {
			image = "weed_amnesia_cbd_joint.png",
		}
	},

	["iphone"]                     = {
		label = "iPhone",
		weight = 10000,
		stack = true,
		close = true,
		description = "Very expensive phone",
		client = {
			image = "iphone.png",
		}
	},

	["burger-murdermeal"]          = {
		label = "Murder Meal",
		weight = 325,
		stack = true,
		close = true,
		description = "An Amazing Murder Meal with a chance of a toy.",
		client = {
			image = "burger-box.png",
		}
	},

	["snikkel_candy"]              = {
		label = "Snikkel",
		weight = 500,
		stack = true,
		close = true,
		description = "Some delicious candy :O",
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'candy',
			usetime = 7500,
			notification = 'You ate a delicious treat',
			image = "snikkel_candy.png",
		},
	},

	["cannabis"]                   = {
		label = "Weed",
		weight = 80,
		stack = true,
		close = true,
		description = "Almost Road To Happieness!!",
		client = {
			image = "weed.png",
		}
	},

	["lowervaultcodes"]            = {
		label = "Access Codes",
		weight = 0,
		stack = false,
		close = false,
		description = "A copy of the Pacific Bank lower vault access code..",
		client = {
			image = "lowervaultcodes.png",
		}
	},

	["weed_amnesia_seed"]          = {
		label = "Amnesia Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of Amnesia",
		client = {
			image = "weed_seed.png",
		}
	},

	["dendrogyra_coral"]           = {
		label = "Dendrogyra",
		weight = 10000,
		stack = true,
		close = true,
		description = "Its also known as pillar coral",
		client = {
			image = "dendrogyra_coral.png",
		}
	},

	["printerdocument"]            = {
		label = "Document",
		weight = 500,
		stack = false,
		close = true,
		description = "A nice document",
		client = {
			image = "printerdocument.png",
		}
	},

	["usb_green"]                  = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A green USB flash drive",
		client = {
			image = "usb_green.png",
		}
	},

	["walkstick"]                  = {
		label = "Walking Stick",
		weight = 10000,
		stack = true,
		close = true,
		description = "Walking stick for ya'll grannies out there.. HAHA",
		client = {
			image = "walkstick.png",
		}
	},

	["fishtacklebox"]              = {
		label = "Tackle Box",
		weight = 11000,
		stack = true,
		close = true,
		description = "Seems to be left over tackle box from another fisherman",
		client = {
			image = "fishtacklebox.png",
		}
	},

	["marijuana_trowel"]           = {
		label = "Trowel",
		weight = 0,
		stack = true,
		close = true,
		description = "Small handheld garden shovel",
		client = {
			image = "marijuana_trowel.png",
		}
	},

	["strawberry"]                 = {
		label = "Strawberry",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "strawberry.png",
		}
	},

	["marijuana_3.5_mid"]          = {
		label = "3.5g marijuana",
		weight = 2800,
		stack = false,
		close = true,
		description = "3.5g mid grade marijuana",
		client = {
			image = "marijuana_3.5_mid.png",
		}
	},

	["marijuana_nutrition"]        = {
		label = "Plant Fertilizer",
		weight = 0,
		stack = true,
		close = true,
		description = "Plant nutrition",
		client = {
			image = "marijuana_nutrition.png",
		}
	},

	["grapejuice"]                 = {
		label = "Grape Juice",
		weight = 600,
		stack = true,
		close = false,
		description = "Grape juice is said to be healthy",
		client = {
			image = "grapejuice.png",
		}
	},

	["laptop_blue"]                = {
		label = "Blue Laptop",
		weight = 2500,
		stack = false,
		close = true,
		description = "Blue Laptop (marked for police seizure)",
		client = {
			image = "laptop_blue.png",
		}
	},

	["electronickit"]              = {
		label = "Electronic Kit",
		weight = 100,
		stack = true,
		close = true,
		description =
		"If you've always wanted to build a robot you can maybe start here. Maybe you'll be the new Elon Musk?",
		client = {
			image = "electronickit.png",
		}
	},

	["weed_ak47_cbd_joint"]        = {
		label = "CBD AK 47 Joint",
		weight = 1,
		stack = true,
		close = false,
		description = "Light up that ak47 son!",
		client = {
			image = "weed_ak47_cbd_joint.png",
		}
	},

	["laptop_gold"]                = {
		label = "Gold Laptop",
		weight = 2500,
		stack = false,
		close = true,
		description = "Sketchy laptop marked for police seizure",
		client = {
			image = "laptop_gold.png",
		}
	},

	["fishinglicense"]             = {
		label = "Fishing License",
		weight = 500,
		stack = false,
		close = true,
		description = "Fishing License",
		client = {
			image = "fishing_license.png",
		}
	},

	["deerskin"]                   = {
		label = "Deer Pelt",
		weight = 7500,
		stack = true,
		close = false,
		description = "Pelt of a deer.",
		client = {
			image = "deerskin.png",
		}
	},

	["empty_evidence_bag"]         = {
		label = "Empty Evidence Bag",
		weight = 1000,
		stack = true,
		close = false,
		description = "Used a lot to keep DNA from blood, bullet shells and more",
		client = {
			image = "evidence.png",
		}
	},

	["corn_packet"]                = {
		label = "Cone Packet",
		weight = 500,
		stack = true,
		close = true,
		description = "Corn Packet",
		client = {
			image = "corn_packet.png",
		}
	},

	["weed_nutrition"]             = {
		label = "Plant Fertilizer",
		weight = 2000,
		stack = true,
		close = true,
		description = "Plant nutrition",
		client = {
			image = "weed_nutrition.png",
		}
	},

	["weed_white-widow_cbd"]       = {
		label = "CBD White Widow 2g",
		weight = 2,
		stack = true,
		close = false,
		description = "A 2g bag of CBD White Widow!",
		client = {
			image = "weed_white-widow_cbd.png",
		}
	},

	["coyotemeat"]                 = {
		label = "Coyote Meat",
		weight = 4000,
		stack = true,
		close = false,
		description = "Meat of a coyote.",
		client = {
			image = "coyotemeat.png",
		}
	},

	["gummy_skunk_cbd"]            = {
		label = "CBD Skunk Gummy",
		weight = 4,
		stack = true,
		close = true,
		description = "A edible cbd skunk gummy bear!",
		client = {
			image = "gummy_skunk_cbd.png",
		}
	},

	["sugar"]                      = {
		label = "Sugar",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sugar.png",
		}
	},

	["marijuana_joint"]            = {
		label = "Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "1g joint",
		client = {
			image = "marijuana_joint.png",
		}
	},

	["burger-lettuce"]             = {
		label = "Lettuce",
		weight = 525,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bs_lettuce.png",
		}
	},

	["diving_gear"]                = {
		label = "Diving Gear",
		weight = 30000,
		stack = false,
		close = true,
		description = "An oxygen tank and a rebreather",
		client = {
			image = "diving_gear.png",
		}
	},

	["iron"]                       = {
		label = "Iron",
		weight = 100,
		stack = true,
		close = false,
		description = "Handy piece of metal that you can probably use for something",
		client = {
			image = "iron.png",
		}
	},

	["wine"]                       = {
		label = "Wine",
		weight = 300,
		stack = true,
		close = false,
		description = "Some good wine to drink on a fine evening",
		client = {
			image = "wine.png",
		}
	},

	["screwdriverset"]             = {
		label = "Toolkit",
		weight = 1000,
		stack = true,
		close = false,
		description = "Very useful to screw... screws...",
		client = {
			image = "screwdriverset.png",
		}
	},

	["burger-tomato"]              = {
		label = "Tomato",
		weight = 525,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bs_tomato.png",
		}
	},

	["steel"]                      = {
		label = "Steel",
		weight = 100,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something",
		client = {
			image = "steel.png",
		}
	},

	["sulfur"]                     = {
		label = "Sulfur",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sulfur.png",
		}
	},

	["burger-fries"]               = {
		label = "Fries",
		weight = 1250,
		stack = true,
		close = true,
		description = "Sates Hunger.",
		client = {
			image = "bs_fries.png",
		}
	},

	["moneybag"]                   = {
		label = "Money Bag",
		weight = 0,
		stack = false,
		close = true,
		description = "A bag with cash",
		client = {
			image = "moneybag.png",
		}
	},

	["gummy_og-kush_cbd"]          = {
		label = "CBD OG-Kush Gummy",
		weight = 4,
		stack = true,
		close = true,
		description = "A edible cbd og kush gummy bear!",
		client = {
			image = "gummy_og-kush_cbd.png",
		}
	},

	["beer"]                       = {
		label = "Beer",
		weight = 500,
		stack = true,
		close = true,
		description = "Nothing like a good cold beer!",
		client = {
			image = "beer.png",
		}
	},

	["antipatharia_coral"]         = {
		label = "Antipatharia",
		weight = 10000,
		stack = true,
		close = true,
		description = "Its also known as black corals or thorn corals",
		client = {
			image = "antipatharia_coral.png",
		}
	},

	["redphosphorus"]              = {
		label = "Red Phosphorus",
		weight = 500,
		stack = true,
		close = true,
		description = "Very reactive powder, Watch your eyebrows!!",
		client = {
			image = "redphosphorus.png",
		}
	},

	["detinator\9"]                = {
		label = "Detinator",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "detinator.png",
		}
	},

	["stingray"]                   = {
		label = "Stingray",
		weight = 3500,
		stack = false,
		close = false,
		description = "Stingray",
		client = {
			image = "stingray.png",
		}
	},

	["carrentalpapers"]            = {
		label = "Car Rental Papers",
		weight = 500,
		stack = false,
		close = false,
		description = "I dont have money for my own car Sadge",
		client = {
			image = "carrentalpapers.png",
		}
	},

	["noodlebowl"]                 = {
		label = "Noodles",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				hunger = 50,
			},
			image = "ramennoodles.png",
		}
	},

	["processed_deerskin"]         = {
		label = "Procesed Deer Pelt",
		weight = 7000,
		stack = true,
		close = false,
		description = "Pelt of a deer.",
		client = {
			image = "processed_deerskin.png",
		}
	},

	["twerks_candy"]               = {
		label = "Twerks",
		weight = 500,
		status = { hunger = 200000 },
		stack = true,
		close = true,
		description = "Some delicious candy :O",
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'candy',
			usetime = 7500,
			notification = 'You ate a delicious treat',
			image = "twerks_candy.png",
		},
	},

	["hydrochloricacid"]           = {
		label = "Hydrochloric Acid",
		weight = 10000,
		stack = true,
		close = true,
		description = "Dont Drink!!",
		client = {
			image = "hydrochloricacid.png",
		}
	},

	["rentalpapers"]               = {
		label = "Rental Papers",
		weight = 0,
		stack = false,
		close = false,
		description = "No Sir, the car is not stolen!",
		client = {
			image = "rentalpapers.png",
		}
	},

	["dmr_receiver"]               = {
		label = "DMR Receiver",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sniper_receiver.png",
		}
	},

	["laptop_green"]               = {
		label = "Laptop",
		weight = 2500,
		stack = false,
		close = true,
		description = "Green Laptop (marked for police seizure)",
		client = {
			image = "laptop_green.png",
		}
	},

	["untrimmedweed"]              = {
		label = "Untrimmed Weed",
		weight = 500,
		stack = true,
		close = true,
		description = "Hairy weed.",
		client = {
			image = "untrimmed_weed.png",
		}
	},

	["weed_skunk_cbd_joint"]       = {
		label = "CBD Skunk Joint",
		weight = 1,
		stack = true,
		close = false,
		description = "Light up that skunk son!",
		client = {
			image = "weed_skunk_cbd_joint.png",
		}
	},

	["springrolls"]                = {
		label = "Spring Rolls",
		weight = 500,
		stack = true,
		close = true,
		description = "A Spring Rolls",
		client = {
			status = {
				hunger = 41,
			},
			image = "springrolls.png",
		}
	},

	["burger-raw"]                 = {
		label = "Raw Patty",
		weight = 525,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bs_patty_raw.png",
		}
	},

	["firework2"]                  = {
		label = "Poppelers",
		weight = 10000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework2.png",
		}
	},

	["xtcbaggy"]                   = {
		label = "Bag of XTC",
		weight = 0,
		stack = true,
		close = true,
		description = "Pop those pills baby",
		client = {
			image = "xtc_baggy.png",
		}
	},

	["methylamine"]                = {
		label = "Methylamine",
		weight = 500,
		stack = true,
		close = true,
		description = "Very toxic acid",
		client = {
			image = "methylamine.png",
		}
	},

	["coyotefur"]                  = {
		label = "Coyote Fur",
		weight = 7000,
		stack = true,
		close = false,
		description = "Fur of a coyote.",
		client = {
			image = "coyotefur.png",
		}
	},

	["jerry_can"]                  = {
		label = "Jerrycan 20L",
		weight = 20000,
		stack = true,
		close = true,
		description = "A can full of Fuel",
		client = {
			image = "jerry_can.png",
		}
	},

	["flounder"]                   = {
		label = "Flounder",
		weight = 3500,
		stack = false,
		close = false,
		description = "Flounder",
		client = {
			image = "flounder.png",
		}
	},

	["burger-mshakeformula"]       = {
		label = "Milkshake Formula",
		weight = 525,
		stack = true,
		close = true,
		description = "An Ingredient",
		client = {
			image = "bs_ingredients_icecream.png",
		}
	},

	["trojan_usb"]                 = {
		label = "Trojan USB",
		weight = 0,
		stack = true,
		close = true,
		description = "Handy software to shut down some systems (Marked For Police Seizure)",
		client = {
			image = "usb_device.png",
		}
	},

	["weed_purple-haze_seed"]      = {
		label = "Purple Haze Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of Purple Haze",
		client = {
			image = "weed_seed.png",
		}
	},

	["coke_small_brick"]           = {
		label = "Coke Package",
		weight = 350,
		stack = false,
		close = true,
		description = "Small package of cocaine, mostly used for deals and takes a lot of space",
		client = {
			image = "coke_small_brick.png",
		}
	},

	["whiskey"]                    = {
		label = "Whiskey",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "whiskey.png",
		}
	},

	["corn_kernel"]                = {
		label = "Cone Kernel",
		weight = 300,
		stack = true,
		close = true,
		description = "Corn kernel",
		client = {
			image = "corn_kernel.png",
		}
	},

	["casino_vip"]                 = {
		label = "V.I.P Membership",
		weight = 500,
		stack = false,
		close = false,
		description = "Diamond Casino V.I.P Card",
		client = {
			image = "casino_vip.png",
		}
	},

	["marijuana_lighter"]          = {
		label = "Lighter",
		weight = 0,
		stack = true,
		close = true,
		description = "Cheap tweaker lighter, Still does the job",
		client = {
			image = "marijuana_lighter.png",
		}
	},

	["cokepaste"]                  = {
		label = "Coke Paste",
		weight = 100,
		stack = true,
		close = true,
		description = "Coke but not coke",
		client = {
			image = "cokepaste.png",
		}
	},

	["aluminum"]                   = {
		label = "Aluminium",
		weight = 100,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something",
		client = {
			image = "aluminum.png",
		}
	},

	["ammonia"]                    = {
		label = "Ammonia",
		weight = 500,
		stack = true,
		close = true,
		description = "DANGER!",
		client = {
			image = "ammonia.png",
		}
	},

	["fantaslushy"]                = {
		label = "Fanta Slushy",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 41,
			},
			image = "mochameow.png",
		}
	},

	["onion"]                      = {
		label = "Onion",
		weight = 500,
		stack = true,
		close = false,
		description = "An onion",
		client = {
			image = "burger-onion.png",
		}
	},

	["marijuana_baggies"]          = {
		label = "Baggies",
		weight = 0,
		stack = true,
		close = true,
		description = "Need some baggies? i got some baggies",
		client = {
			image = "marijuana_baggies.png",
		}
	},

	["samsungphone"]               = {
		label = "Samsung S10",
		weight = 10000,
		stack = true,
		close = true,
		description = "Very expensive phone",
		client = {
			image = "samsungphone.png",
		}
	},

	["m4_muzzle"]                  = {
		label = "M4 Muzzle",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "m4_muzzle.png",
		}
	},

	["soju"]                       = {
		label = "Soju",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			status = {
				thirst = 49,
			},
			image = "soju.png",
		}
	},

	["police_stormram"]            = {
		label = "Stormram",
		weight = 14000,
		stack = true,
		close = true,
		description = "A nice tool to break into doors",
		client = {
			image = "police_stormram.png",
		}
	},

	["sharkhammer"]                = {
		label = "Shark",
		weight = 8000,
		stack = false,
		close = false,
		description = "Hammerhead Shark",
		client = {
			image = "sharkhammer.png",
		}
	},

	["weed_og-kush_cbd_crop"]      = {
		label = "CBD OG Kush Crop",
		weight = 1200,
		stack = true,
		close = false,
		description = "A crop of CBD OG Kush",
		client = {
			image = "weed_og-kush_cbd_crop.png",
		}
	},

	["acetone"]                    = {
		label = "Acetone",
		weight = 500,
		stack = true,
		close = true,
		description = "An organic compound",
		client = {
			image = "acetone.png",
		}
	},

	["lmg_receiver"]               = {
		label = "LMG Receiver",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lmg_receiver.png",
		}
	},

	["weed_white-widow_seed"]      = {
		label = "White Widow Seed",
		weight = 0,
		stack = true,
		close = false,
		description = "A weed seed of White Widow",
		client = {
			image = "weed_seed.png",
		}
	},

	["boatrentalpapers"]           = {
		label = "Boat Rental Papers",
		weight = 500,
		stack = false,
		close = false,
		description = "Definitely not rented to use in a getaway",
		client = {
			image = "boatrentalpapers.png",
		}
	},

	["tazer_cartilage"]            = {
		label = "Tazer Cartridges",
		weight = 1000,
		stack = true,
		close = true,
		description = "Government (PD/EMS/DOC) Issued Equipment",
		client = {
			image = "taserammo.png",
		}
	},

	["dolphin"]                    = {
		label = "Dolphin",
		weight = 7000,
		stack = false,
		close = false,
		description = "Dolphin",
		client = {
			image = "dolphin.png",
		}
	},

	["bbobatea"]                   = {
		label = "Bubble Tea",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bubbletea.png",
		}
	},

	["glass"]                      = {
		label = "Glass",
		weight = 100,
		stack = true,
		close = false,
		description = "It is very fragile, watch out",
		client = {
			image = "glass.png",
		}
	},

	["weed_amnesia_cbd"]           = {
		label = "CBD Amnesia 2g",
		weight = 2,
		stack = true,
		close = false,
		description = "A 2g bag of CBD Amnesia!",
		client = {
			image = "weed_amnesia_cbd.png",
		}
	},

	["burger-heartstopper"]        = {
		label = "Heartstopper",
		weight = 2500,
		stack = true,
		close = true,
		description = "Sates Hunger.",
		client = {
			image = "bs_the-heart-stopper.png",
		}
	},

	["rolling_paper"]              = {
		label = "Rolling Paper",
		weight = 0,
		stack = true,
		close = true,
		description = "Paper made specifically for encasing and smoking tobacco or cannabis.",
		client = {
			image = "rolling_paper.png",
		}
	},

	["painkillers"]                = {
		label = "Painkillers",
		weight = 1000,
		stack = true,
		close = true,
		description = "For pain you can't stand anymore, take this pill that'd make you feel great again",
		client = {
			image = "painkillers.png",
		}
	},

	["gummy_ak47_cbd"]             = {
		label = "CBD AK47 Gummy",
		weight = 4,
		stack = true,
		close = true,
		description = "A edible cbd ak47 gummy bear!",
		client = {
			image = "gummy_ak47_cbd.png",
		}
	},

	["repairkit"]                  = {
		label = "Repairkit",
		weight = 2500,
		stack = true,
		close = true,
		description = "A nice toolbox with stuff to repair your vehicle",
		client = {
			image = "repairkit.png",
		}
	},

	["usb_blue"]                   = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A blue USB flash drive",
		client = {
			image = "usb_blue.png",
		}
	},

	["flour"]                      = {
		label = "Flour",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "flour.png",
		}
	},

	["launcher_shell"]             = {
		label = "Launcher Shell",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "launcher_shell.png",
		}
	},

	["milk_pack"]                  = {
		label = "Milk Pack",
		weight = 500,
		stack = true,
		close = true,
		description = "Milk pack",
		client = {
			image = "milk_pack.png",
		}
	},

	["fishingtin"]                 = {
		label = "Fishing Tin",
		weight = 2500,
		stack = true,
		close = false,
		description = "Fishing Tin",
		client = {
			image = "fishingtin.png",
		}
	},

	["certificate"]                = {
		label = "Certificate",
		weight = 0,
		stack = true,
		close = true,
		description = "Certificate that proves you own certain stuff",
		client = {
			image = "certificate.png",
		}
	},

	["methanol"]                   = {
		label = "Methanol",
		weight = 500,
		stack = true,
		close = true,
		description = "Methyl alcohol",
		client = {
			image = "methanol.png",
		}
	},

	["pilot_license"]              = {
		label = "Pilot License",
		weight = 500,
		stack = false,
		close = true,
		description = "Pilot License",
		client = {
			image = "pilot_license.png",
		}
	},

	["weed_amnesia_cbd_crop"]      = {
		label = "CBD Amnesia Crop",
		weight = 1200,
		stack = true,
		close = false,
		description = "A crop of CBD Amnesia!",
		client = {
			image = "weed_amnesia_cbd_crop.png",
		}
	},

	["pseudoephedrine"]            = {
		label = "Pseudoephedrine",
		weight = 500,
		stack = true,
		close = true,
		description = "Crushed up powder, only one thing you need this for and we both know what that is ;)",
		client = {
			image = "pseudoephedrine.png",
		}
	},

	["filled_evidence_bag"]        = {
		label = "Evidence Bag",
		weight = 1200,
		stack = false,
		close = false,
		description = "A filled evidence bag to see who committed the crime >:(",
		client = {
			image = "evidence.png",
		}
	},

	["cokebaggy"]                  = {
		label = "Bag of Coke",
		weight = 350,
		stack = true,
		close = true,
		description = "The finest powder know to mankind",
		client = {
			image = "cocaine_baggy.png",
		}
	},

	["fitbit"]                     = {
		label = "Fitbit",
		weight = 500,
		stack = false,
		close = true,
		description = "I like fitbit",
		client = {
			image = "fitbit.png",
		}
	},

	["explosives"]                 = {
		label = "Explosives",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "explosives.png",
		}
	},

	["binoculars"]                 = {
		label = "Binoculars",
		weight = 600,
		stack = true,
		close = true,
		description = "Sneaky Breaky...",
		client = {
			image = "binoculars.png",
		}
	},

	["weed_og-kush_cbd"]           = {
		label = "CBD OGKush 2g",
		weight = 2,
		stack = true,
		close = false,
		description = "A 2g bag of CBD OG Kush!",
		client = {
			image = "weed_og-kush_cbd.png",
		}
	},

	["goldchain"]                  = {
		label = "Golden Chain",
		weight = 1500,
		stack = true,
		close = true,
		description = "A golden chain seems like the jackpot to me!",
		client = {
			image = "goldchain.png",
		}
	},

	["empty_weed_bag"]             = {
		label = "Empty Bag",
		weight = 350,
		stack = true,
		close = true,
		description = "Just an empty bag",
		client = {
			image = "weed_baggy_empty.png",
		}
	},

	["codfish"]                    = {
		label = "Cod",
		weight = 3500,
		stack = false,
		close = false,
		description = "Cod",
		client = {
			image = "codfish.png",
		}
	},

	["usb_grey"]                   = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A grey USB flash drive",
		client = {
			image = "usb_grey.png",
		}
	},

	["spikestrip"]                 = {
		label = "Spikestrip",
		weight = 3000,
		stack = true,
		close = true,
		description = "Government (PD/EMS/DOC) Issued Equipment",
		client = {
			image = "spikestrip.png",
		}
	},

	["marijuana_1oz_mid"]          = {
		label = "1oz marijuana",
		weight = 2800,
		stack = false,
		close = false,
		description = "1oz mid grade marijuana",
		client = {
			image = "marijuana_1oz_mid.png",
		}
	},

	["glockbp"]                    = {
		label = "Glock BluePrint",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "glockbp.png",
		}
	},

	["microsmgbp"]                 = {
		label = "Micro Smg BluePrint",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "microsmgbp.png",
		}
	},

	["stone"]                      = {
		label = "Stone",
		weight = 2500,
		stack = true,
		close = false,
		description = "ORE",
		client = {
			image = "stone.png",
		}
	},

	["thermite"]                   = {
		label = "Thermite",
		weight = 1000,
		stack = true,
		close = true,
		description = "Sometimes you'd wish for everything to burn (Marked For Police Seizure)",
		client = {
			image = "thermite.png",
		}
	},

	["fishicebox"]                 = {
		label = "Fishing Ice Chest",
		weight = 2500,
		stack = false,
		close = true,
		description = "Ice Box to store all of your fish",
		client = {
			image = "fishicebox.png",
		}
	},

	["processed_boarskin"]         = {
		label = "Processed Boar skin",
		weight = 7000,
		stack = true,
		close = false,
		description = "Pelt of a Boar.",
		client = {
			image = "processed_boarskin.png",
		}
	},

	["copium"]                     = {
		label = "Copium",
		weight = 100,
		stack = true,
		close = true,
		description = "Dont Worry It will get better, have some Copium",
		client = {
			image = "copium.png",
		}
	},

	["burger-bleeder"]             = {
		label = "Bleeder",
		weight = 2500,
		stack = true,
		close = true,
		description = "Sates Hunger.",
		client = {
			image = "bs_the-bleeder.png",
		}
	},

	["glock_flashlight"]           = {
		label = "Glock Flashlight",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "glock_flashlight.png",
		}
	},

	["sandwich"]                   = {
		label = "Sandwich",
		weight = 600,
		stack = true,
		close = true,
		description = "Nice bread for your stomach",
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'sandwich',
			usetime = 7500,
			notification = 'You ate a delicious sandwich',
			image = "sandwich.png",
		},
	},

	["lighter"]                    = {
		label = "Lighter",
		weight = 0,
		stack = true,
		close = true,
		description = "On new years eve a nice fire to stand next to",
		client = {
			image = "lighter.png",
		}
	},

	["weed_og-kush_cbd_joint"]     = {
		label = "CBD OG Kush Joint",
		weight = 1,
		stack = true,
		close = false,
		description = "Light up that og kush son!",
		client = {
			image = "weed_og-kush_cbd_joint.png",
		}
	},

	["planerentalpapers"]          = {
		label = "Aircraft Rental Papers",
		weight = 500,
		stack = false,
		close = false,
		description = "No Sir, this is not stolen!",
		client = {
			image = "planerentalpapers.png",
		}
	},

	["pearlscard"]                 = {
		label = "Pearls Seafood",
		weight = 500,
		stack = true,
		close = true,
		description = "A special member of Pearl's Seafood Restaurant",
		client = {
			image = "pearlscard.png",
		}
	},

	["cleaningkit"]                = {
		label = "Cleaning Kit",
		weight = 250,
		stack = true,
		close = true,
		description = "A microfiber cloth with some soap will let your car sparkle again!",
		client = {
			image = "cleaningkit.png",
		}
	},

	["joint"]                      = {
		label = "Joint",
		weight = 0,
		stack = true,
		close = true,
		description = "Sidney would be very proud at you",
		client = {
			image = "joint.png",
		}
	},

	["dp9_defaultclip"]            = {
		label = "DP9 Clip",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "dp9_defaultclip.png",
		}
	},

	["oxy"]                        = {
		label = "Prescription Oxy",
		weight = 100,
		stack = true,
		close = true,
		description = "The Label Has Been Ripped Off",
		client = {
			image = "oxy.png",
		}
	},

	["fishingboot"]                = {
		label = "Fishing Boot",
		weight = 2500,
		stack = true,
		close = false,
		description = "Fishing Boot",
		client = {
			image = "fishingboot.png",
		}
	},

	["phenylaceticacid"]           = {
		label = "Phenylacetic Acid",
		weight = 500,
		stack = true,
		close = true,
		description = "Very toxic acid ",
		client = {
			image = "phenylaceticacid.png",
		}
	},

	["cryptostick"]                = {
		label = "Crypto Stick",
		weight = 600,
		stack = false,
		close = true,
		description = "Why would someone ever buy money that doesn't exist.. How many would it contain..?",
		client = {
			image = "cryptostick.png",
		}
	},

	["casinochips"]                = {
		label = "Casino Chips",
		weight = 0,
		stack = true,
		close = false,
		description = "Chips For Casino Gambling",
		client = {
			image = "casinochips.png",
		}
	},

	["icecube"]                    = {
		label = "icecube",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "icecube.png",
		}
	},

	["weed_skunk_cbd"]             = {
		label = "CBD Skunk 2g",
		weight = 2,
		stack = true,
		close = false,
		description = "A 2g bag of CBD Skunk!",
		client = {
			image = "weed_skunk_cbd.png",
		}
	},

	["usb_gold"]                   = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A gold USB flash drive",
		client = {
			image = "usb_gold.png",
		}
	},

	["shrimp"]                     = {
		label = "Shrimp",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "shrimp.png",
		}
	},

	["marijuana_crop_high"]        = {
		label = "Harvested Crop",
		weight = 5500,
		stack = true,
		close = false,
		description = "high grade harvested marijuana crop",
		client = {
			image = "marijuana_crop_high.png",
		}
	},

	["aluminumoxide"]              = {
		label = "Aluminium Powder",
		weight = 500,
		stack = true,
		close = false,
		description = "Some powder to mix with",
		client = {
			image = "aluminumoxide.png",
		}
	},

	["dragonrolls"]                = {
		label = "Dragon Rolls",
		weight = 500,
		stack = true,
		close = true,
		description = "A Dragon Rolls",
		client = {
			status = {
				hunger = 48,
			},
			image = "dragonrolls.png",
		}
	},

	["fishinglootbig"]             = {
		label = "Treasure Chest",
		weight = 2500,
		stack = true,
		close = true,
		description = "The lock seems to be intact, Might need a key",
		client = {
			image = "fishinglootbig.png",
		}
	},

	["security_card_02"]           = {
		label = "Security Card B",
		weight = 500,
		stack = true,
		close = true,
		description = "A security card... I wonder what it goes to",
		client = {
			image = "security_card_02.png",
		}
	},

	["m4_grip"]                    = {
		label = "M4 Grip",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "m4_grip.png",
		}
	},

	["rubberslug"]                 = {
		label = "12-Gauge Rubber Slugs",
		weight = 1000,
		stack = true,
		close = true,
		description = "Government (PD/EMS/DOC) Issued Equipment",
		client = {
			image = "rubberslugs.png",
		}
	},

	["rpg_shell"]                  = {
		label = "RPG Shell",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "rpg_shell.png",
		}
	},

	["camera"]                     = {
		label = "PD Camera",
		weight = 150,
		stack = false,
		close = true,
		description = "Works 100% of the time 60% of the time.",
		client = {
			image = "camera.png",
		}
	},

	["m4_defaultclip"]             = {
		label = "M4 Clip",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "m4_defaultclip.png",
		}
	},

	["goldbar"]                    = {
		label = "Gold Bar",
		weight = 6000,
		stack = true,
		close = true,
		description = "Looks pretty expensive to me",
		client = {
			image = "goldbar.png",
		}
	},

	["dmr_barrel\9"]               = {
		label = "DMR Barrel",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sniper_barrel.png",
		}
	},

	["marijuana_3.5_low"]          = {
		label = "3.5g marijuana",
		weight = 2800,
		stack = false,
		close = true,
		description = "3.5g low grade marijuana",
		client = {
			image = "marijuana_3.5_low.png",
		}
	},

	["bands"]                      = {
		label = "Band Of Notes",
		weight = 100,
		stack = true,
		close = false,
		description = "A band of small notes..",
		client = {
			image = "cashstack.png",
		}
	},

	["nitrous"]                    = {
		label = "Nitrous",
		weight = 10000,
		stack = true,
		close = true,
		description = "Speed up, gas pedal! :D",
		client = {
			image = "nitrous.png",
		}
	},

	["tablet"]                     = {
		label = "Tablet",
		weight = 2000,
		stack = true,
		close = true,
		description = "Expensive tablet",
		client = {
			image = "tablet.png",
		}
	},

	["grenade_shell"]              = {
		label = "Grenade Shell",
		weight = 5000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "grenade_shell.png",
		}
	},

	["cocaleaf"]                   = {
		label = "Coca Leaf",
		weight = 500,
		stack = true,
		close = true,
		description = "The leaf of coke",
		client = {
			image = "cocaleaf.png",
		}
	},

	["permit"]                     = {
		label = "Driving Permit",
		weight = 500,
		stack = false,
		close = false,
		description = "A Driving permit to show you can drive a vehicle as long as you have a passenger",
		client = {
			image = "id_card.png",
		}
	},

	["tosti"]                      = {
		label = "Grilled Cheese Sandwich",
		weight = 600,
		stack = true,
		close = true,
		description = "Yummy Sandwich",
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'sandwich',
			usetime = 7500,
			notification = 'You ate a delicious grilled cheese',
			image = "tosti.png",
		},
	},

	["copper"]                     = {
		label = "Copper",
		weight = 100,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something",
		client = {
			image = "copper.png",
		}
	},

	["snowball"]                   = {
		label = "Snowball",
		weight = 0,
		stack = true,
		close = true,
		description = "Should have catched it :D",
		client = {
			image = "snowball.png",
		}
	},

	["bbmenu"]                     = {
		label = "Best Buds Menu",
		weight = 10,
		stack = true,
		close = true,
		description = "A menu for the best buds medical dispensary!",
		client = {
			image = "bbmenu.png",
		}
	},

	["medickeycard"] = {
		label = "Medical Keycard",
		weight = 10,
		close = true,
		description = "A medical key card? I wonder what this opens!",
		client = {
			image = "medickeycard.png"
		}
	},
	
	["documenttube"] = {
		label = "Document Tube",
		weight = 1000,
		close = true,
		description = "An airtight document tube, could contain anything.",
		client = {
			image = "documenttube.png"
		}
	},
	
	["jewellerybag"] = {
		label = "Jewellery Bag",
		weight = 500,
		close = true,
		description = "A jewellery bag, anything good inside?",
		client = {
			image = "jewellerybag.png"
		}
	},
	
	["ruineddocuments"] = {
		label = "Ruined Documents",
		weight = 100,
		close = true,
		description = "Ruined documents.. These are worthless.",
		client = {
			image = "ruineddocuments.png"
		}
	},
	
	["rolex_fake"] = {
		label = "Fake Rolex",
		weight = 100,
		close = true,
		description = "Would be nice if it was real..",
		client = {
			image = "rolex_fake.png"
		}
	},
	
	["goldchain_fake"] = {
		label = "Fake Goldchain",
		weight = 100,
		close = true,
		description = "Ruined documents.. These are worthless.",
		client = {
			image = "goldchain_fake.png"
		}
	},

	["inactivekeycard"]            = {
		label = "De-Activated Keycard",  
		weight = 10,
		stack = false, 
		close = true,
		description = "Ruined documents.. These are worthless.",
		client = {
			image = "inactivekeycard.png"
		}
	},

	
	["nightvisiongoggles"]         = {
		label = "Night Vision goggles",
		weight = 500,
		stack = false,
		close = true,
		description = "Bravo Six, going dark",
		client = {
			image = "nightvisiongoggles.png",
		}
	},

	["weed_white-widow_cbd_joint"] = {
		label = "CBD White Widow Joint",
		weight = 1,
		stack = true,
		close = false,
		description = "Light up that white widow son!",
		client = {
			image = "weed_white-widow_cbd_joint.png",
		}
	},

	["emerald_ring_silver"] = {
		label = "Emerald Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_ring_silver.png",
		}
	},

	["mininglaser"] = {
		label = "Mining Laser",
		weight = 900,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "mininglaser.png",
		}
	},

	["sapphire_necklace"] = {
		label = "Sapphire Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_necklace.png",
		}
	},

	["miningdrill"] = {
		label = "Mining Drill",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "miningdrill.png",
		}
	},

	["emerald_earring"] = {
		label = "Emerald Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_earring.png",
		}
	},

	["uncut_diamond"] = {
		label = "Uncut Diamond",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Diamond",
		client = {
			image = "uncut_diamond.png",
		}
	},

	["ruby"] = {
		label = "Ruby",
		weight = 100,
		stack = true,
		close = false,
		description = "A Ruby that shimmers",
		client = {
			image = "ruby.png",
		}
	},

	["ruby_ring_silver"] = {
		label = "Ruby Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_ring_silver.png",
		}
	},

	["ruby_necklace"] = {
		label = "Ruby Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_necklace.png",
		}
	},

	["diamond_necklace_silver"] = {
		label = "Diamond Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_necklace_silver.png",
		}
	},

	["goldpan"] = {
		label = "Gold Panning Tray",
		weight = 10,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "goldpan.png",
		}
	},

	["goldearring"] = {
		label = "Golden Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "gold_earring.png",
		}
	},

	["emerald"] = {
		label = "Emerald",
		weight = 100,
		stack = true,
		close = false,
		description = "A Emerald that shimmers",
		client = {
			image = "emerald.png",
		}
	},

	["ironore"] = {
		label = "Iron Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Iron, a base ore.",
		client = {
			image = "ironore.png",
		}
	},

	["uncut_sapphire"] = {
		label = "Uncut Sapphire",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Sapphire",
		client = {
			image = "uncut_sapphire.png",
		}
	},

	["silverchain"] = {
		label = "Silver Chain",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silverchain.png",
		}
	},

	["ruby_earring"] = {
		label = "Ruby Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_earring.png",
		}
	},

	["emerald_ring"] = {
		label = "Emerald Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_ring.png",
		}
	},

	["goldingot"] = {
		label = "Gold Ingot",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "goldingot.png",
		}
	},

	["ruby_earring_silver"] = {
		label = "Ruby Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_earring_silver.png",
		}
	},

	["uncut_ruby"] = {
		label = "Uncut Ruby",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Ruby",
		client = {
			image = "uncut_ruby.png",
		}
	},

	["sapphire_necklace_silver"] = {
		label = "Sapphire Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_necklace_silver.png",
		}
	},

	["diamond_earring"] = {
		label = "Diamond Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_earring.png",
		}
	},

	["sapphire_earring"] = {
		label = "Sapphire Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_earring.png",
		}
	},

	["gold_ring"] = {
		label = "Gold Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "gold_ring.png",
		}
	},

	["drillbit"] = {
		label = "Drill Bit",
		weight = 10,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "drillbit.png",
		}
	},

	["silverore"] = {
		label = "Silver Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Silver Ore",
		client = {
			image = "silverore.png",
		}
	},

	["emerald_necklace"] = {
		label = "Emerald Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_necklace.png",
		}
	},

	["diamond_necklace"] = {
		label = "Diamond Necklace",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_necklace.png",
		}
	},

	["goldore"] = {
		label = "Gold Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Gold Ore",
		client = {
			image = "goldore.png",
		}
	},

	["silveringot"] = {
		label = "Silver Ingot",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silveringot.png",
		}
	},

	["sapphire_ring_silver"] = {
		label = "Sapphire Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_ring_silver.png",
		}
	},

	["can"] = {
		label = "Empty Can",
		weight = 10,
		stack = true,
		close = false,
		description = "An empty can, good for recycling",
		client = {
			image = "can.png",
		}
	},

	["carbon"] = {
		label = "Carbon",
		weight = 1000,
		stack = true,
		close = false,
		description = "Carbon, a base ore.",
		client = {
			image = "carbon.png",
		}
	},

	["copperore"] = {
		label = "Copper Ore",
		weight = 1000,
		stack = true,
		close = false,
		description = "Copper, a base ore.",
		client = {
			image = "copperore.png",
		}
	},

	["emerald_earring_silver"] = {
		label = "Emerald Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_earring_silver.png",
		}
	},

	["pickaxe"] = {
		label = "Pickaxe",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "pickaxe.png",
		}
	},

	["sapphire_earring_silver"] = {
		label = "Sapphire Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_earring_silver.png",
		}
	},

	["ruby_necklace_silver"] = {
		label = "Ruby Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_necklace_silver.png",
		}
	},

	["sapphire_ring"] = {
		label = "Sapphire Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "sapphire_ring.png",
		}
	},

	["uncut_emerald"] = {
		label = "Uncut Emerald",
		weight = 100,
		stack = true,
		close = false,
		description = "A rough Emerald",
		client = {
			image = "uncut_emerald.png",
		}
	},

	["diamond_ring_silver"] = {
		label = "Diamond Ring Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_ring_silver.png",
		}
	},

	["silverearring"] = {
		label = "Silver Earrings",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silver_earring.png",
		}
	},

	["emerald_necklace_silver"] = {
		label = "Emerald Necklace Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "emerald_necklace_silver.png",
		}
	},

	["ruby_ring"] = {
		label = "Ruby Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ruby_ring.png",
		}
	},

	["silver_ring"] = {
		label = "Silver Ring",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "silver_ring.png",
		}
	},

	["bottle"] = {
		label = "Empty Bottle",
		weight = 10,
		stack = true,
		close = false,
		description = "A glass bottle",
		client = {
			image = "bottle.png",
		}
	},

	["diamond_earring_silver"] = {
		label = "Diamond Earrings Silver",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "diamond_earring_silver.png",
		}
	},

	["sapphire"] = {
		label = "Sapphire",
		weight = 100,
		stack = true,
		close = false,
		description = "A Sapphire that shimmers",
		client = {
			image = "sapphire.png",
		}
	},

	["diamond"] = {
		label = "Diamond",
		weight = 100,
		stack = true,
		close = false,
		description = "A Diamond that shimmers",
		client = {
			image = "diamond.png",
		}
	},
	["stone"] = {
		name = "stone",
		label = "Stone",
		weight = 2000,
		type = "item",
		image = "stone.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "Stone woo"
	},
	
	["uncut_emerald"] = {
		name = "uncut_emerald",
		label = "Uncut Emerald",
		weight = 100,
		type = "item",
		image = "uncut_emerald.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "A rough Emerald"
	},
	
	["uncut_ruby"] = {
		name = "uncut_ruby",
		label = "Uncut Ruby",
		weight = 100,
		type = "item",
		image = "uncut_ruby.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "A rough Ruby"
	},
	
	["uncut_diamond"] = {
		name = "uncut_diamond",
		label = "Uncut Diamond",
		weight = 100,
		type = "item",
		image = "uncut_diamond.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "A rough Diamond"
	},
	
	["uncut_sapphire"] = {
		name = "uncut_sapphire",
		label = "Uncut Sapphire",
		weight = 100,
		type = "item",
		image = "uncut_sapphire.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "A rough Sapphire"
	},
	
	["emerald"] = {
		name = "emerald",
		label = "Emerald",
		weight = 100,
		type = "item",
		image = "emerald.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "A Emerald that shimmers"
	},
	
	["ruby"] = {
		name = "ruby",
		label = "Ruby",
		weight = 100,
		type = "item",
		image = "ruby.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "A Ruby that shimmers"
	},
	
	["diamond"] = {
		name = "diamond",
		label = "Diamond",
		weight = 100,
		type = "item",
		image = "diamond.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "A Diamond that shimmers"
	},
	
	["sapphire"] = {
		name = "sapphire",
		label = "Sapphire",
		weight = 100,
		type = "item",
		image = "sapphire.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "A Sapphire that shimmers"
	},
	
	["gold_ring"] = {
		name = "gold_ring",
		label = "Gold Ring",
		weight = 200,
		type = "item",
		image = "gold_ring.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["diamond_ring"] = {
		name = "diamond_ring",
		label = "Diamond Ring",
		weight = 200,
		type = "item",
		image = "diamond_ring.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["ruby_ring"] = {
		name = "ruby_ring",
		label = "Ruby Ring",
		weight = 200,
		type = "item",
		image = "ruby_ring.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["sapphire_ring"] = {
		name = "sapphire_ring",
		label = "Sapphire Ring",
		weight = 200,
		type = "item",
		image = "sapphire_ring.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["emerald_ring"] = {
		name = "emerald_ring",
		label = "Emerald Ring",
		weight = 200,
		type = "item",
		image = "emerald_ring.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["silver_ring"] = {
		name = "silver_ring",
		label = "Silver Ring",
		weight = 200,
		type = "item",
		image = "silver_ring.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["diamond_ring_silver"] = {
		name = "diamond_ring_silver",
		label = "Diamond Ring Silver",
		weight = 200,
		type = "item",
		image = "diamond_ring_silver.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["ruby_ring_silver"] = {
		name = "ruby_ring_silver",
		label = "Ruby Ring Silver",
		weight = 200,
		type = "item",
		image = "ruby_ring_silver.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["sapphire_ring_silver"] = {
		name = "sapphire_ring_silver",
		label = "Sapphire Ring Silver",
		weight = 200,
		type = "item",
		image = "sapphire_ring_silver.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["emerald_ring_silver"] = {
		name = "emerald_ring_silver",
		label = "Emerald Ring Silver",
		weight = 200,
		type = "item",
		image = "emerald_ring_silver.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["goldchain"] = {
		name = "goldchain",
		label = "Golden Chain",
		weight = 200,
		type = "item",
		image = "goldchain.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["diamond_necklace"] = {
		name = "diamond_necklace",
		label = "Diamond Necklace",
		weight = 200,
		type = "item",
		image = "diamond_necklace.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["ruby_necklace"] = {
		name = "ruby_necklace",
		label = "Ruby Necklace",
		weight = 200,
		type = "item",
		image = "ruby_necklace.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["sapphire_necklace"] = {
		name = "sapphire_necklace",
		label = "Sapphire Necklace",
		weight = 200,
		type = "item",
		image = "sapphire_necklace.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["emerald_necklace"] = {
		name = "emerald_necklace",
		label = "Emerald Necklace",
		weight = 200,
		type = "item",
		image = "emerald_necklace.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["silverchain"] = {
		name = "silverchain",
		label = "Silver Chain",
		weight = 200,
		type = "item",
		image = "silverchain.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["diamond_necklace_silver"] = {
		name = "diamond_necklace_silver",
		label = "Diamond Necklace Silver",
		weight = 200,
		type = "item",
		image = "diamond_necklace_silver.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["ruby_necklace_silver"] = {
		name = "ruby_necklace_silver",
		label = "Ruby Necklace Silver",
		weight = 200,
		type = "item",
		image = "ruby_necklace_silver.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["sapphire_necklace_silver"] = {
		name = "sapphire_necklace_silver",
		label = "Sapphire Necklace Silver",
		weight = 200,
		type = "item",
		image = "sapphire_necklace_silver.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["emerald_necklace_silver"] = {
		name = "emerald_necklace_silver",
		label = "Emerald Necklace Silver",
		weight = 200,
		type = "item",
		image = "emerald_necklace_silver.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["goldearring"] = {
		name = "goldearring",
		label = "Golden Earrings",
		weight = 200,
		type = "item",
		image = "gold_earring.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["diamond_earring"] = {
		name = "diamond_earring",
		label = "Diamond Earrings",
		weight = 200,
		type = "item",
		image = "diamond_earring.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["ruby_earring"] = {
		name = "ruby_earring",
		label = "Ruby Earrings",
		weight = 200,
		type = "item",
		image = "ruby_earring.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["sapphire_earring"] = {
		name = "sapphire_earring",
		label = "Sapphire Earrings",
		weight = 200,
		type = "item",
		image = "sapphire_earring.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["emerald_earring"] = {
		name = "emerald_earring",
		label = "Emerald Earrings",
		weight = 200,
		type = "item",
		image = "emerald_earring.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["silverearring"] = {
		name = "silverearring",
		label = "Silver Earrings",
		weight = 200,
		type = "item",
		image = "silver_earring.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["diamond_earring_silver"] = {
		name = "diamond_earring_silver",
		label = "Diamond Earrings Silver",
		weight = 200,
		type = "item",
		image = "diamond_earring_silver.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["ruby_earring_silver"] = {
		name = "ruby_earring_silver",
		label = "Ruby Earrings Silver",
		weight = 200,
		type = "item",
		image = "ruby_earring_silver.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["sapphire_earring_silver"] = {
		name = "sapphire_earring_silver",
		label = "Sapphire Earrings Silver",
		weight = 200,
		type = "item",
		image = "sapphire_earring_silver.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["emerald_earring_silver"] = {
		name = "emerald_earring_silver",
		label = "Emerald Earrings Silver",
		weight = 200,
		type = "item",
		image = "emerald_earring_silver.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["carbon"] = {
		name = "carbon",
		label = "Carbon",
		weight = 1000,
		type = "item",
		image = "carbon.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "Carbon, a base ore."
	},
	
	["ironore"] = {
		name = "ironore",
		label = "Iron Ore",
		weight = 1000,
		type = "item",
		image = "ironore.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "Iron, a base ore."
	},
	
	["copperore"] = {
		name = "copperore",
		label = "Copper Ore",
		weight = 1000,
		type = "item",
		image = "copperore.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "Copper, a base ore."
	},
	
	["goldore"] = {
		name = "goldore",
		label = "Gold Ore",
		weight = 1000,
		type = "item",
		image = "goldore.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "Gold Ore"
	},
	
	["silverore"] = {
		name = "silverore",
		label = "Silver Ore",
		weight = 1000,
		type = "item",
		image = "silverore.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "Silver Ore"
	},
	
	["goldingot"] = {
		name = "goldingot",
		label = "Gold Ingot",
		weight = 1000,
		type = "item",
		image = "goldingot.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["silveringot"] = {
		name = "silveringot",
		label = "Silver Ingot",
		weight = 1000,
		type = "item",
		image = "silveringot.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["pickaxe"] = {
		name = "pickaxe",
		label = "Pickaxe",
		weight = 1000,
		type = "item",
		image = "pickaxe.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["miningdrill"] = {
		name = "miningdrill",
		label = "Mining Drill",
		weight = 1000,
		type = "item",
		image = "miningdrill.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["mininglaser"] = {
		name = "mininglaser",
		label = "Mining Laser",
		weight = 900,
		type = "item",
		image = "mininglaser.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["drillbit"] = {
		name = "drillbit",
		label = "Drill Bit",
		weight = 10,
		type = "item",
		image = "drillbit.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["goldpan"] = {
		name = "goldpan",
		label = "Gold Panning Tray",
		weight = 10,
		type = "item",
		image = "goldpan.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = ""
	},
	
	["bottle"] = {
		name = "bottle",
		label = "Empty Bottle",
		weight = 10,
		type = "item",
		image = "bottle.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "A glass bottle"
	},
	
	["recyclablematerial"] = {
		name = "recyclablematerial",
		label = "Recycle Box",
		weight = 100,
		type = "item",
		image = "recyclablematerial.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "A box of Recyclable Materials"
	},
	
	["bottle"] = {
		name = "bottle",
		label = "Empty Bottle",
		weight = 10,
		type = "item",
		image = "bottle.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "A glass bottle"
	},
	
	["can"] = {
		name = "can",
		label = "Empty Can",
		weight = 10,
		type = "item",
		image = "can.png",
		unique = false,
		useable = false,
		shouldClose = false,
		combinable = nil,
		description = "An empty can, good for recycling"
	},
	-- mechanic script
	["mechanic_tools"] = {
		label = "Mechanic tools",
		weight = 0,
		close = true,
		description = "Needed for vehicle repairs",
		client = {
			image = "mechanic_tools.png"
		}
	},
	
	["toolbox"] = {
		label = "Toolbox",
		weight = 0,
		close = true,
		description = "Needed for Performance part removal",
		client = {
			image = "toolbox.png"
		}
	},
	
	["ducttape"] = {
		label = "Duct Tape",
		weight = 0,
		close = true,
		description = "Good for quick fixes",
		client = {
			image = "bodyrepair.png"
		}
	},
	
	["mechboard"] = {
		label = "Mechanic Sheet",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "mechboard.png"
		}
	},
	
	-- Performance
	["turbo"] = {
		label = "Supercharger Turbo",
		weight = 0,
		close = true,
		description = "Who doesn't need a 65mm Turbo??",
		client = {
			image = "turbo.png"
		}
	},
	
	["car_armor"] = {
		label = "Vehicle Armor",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "armour.png"
		}
	},
	
	["nos"] = {
		label = "NOS Bottle",
		weight = 0,
		close = true,
		description = "A full bottle of NOS",
		client = {
			image = "nos.png"
		}
	},
	
	["noscan"] = {
		label = "Empty NOS Bottle",
		weight = 0,
		close = true,
		description = "An Empty bottle of NOS",
		client = {
			image = "noscan.png"
		}
	},
	
	["noscolour"] = {
		label = "NOS Colour Injector",
		weight = 0,
		close = true,
		description = "Make that purge spray",
		client = {
			image = "noscolour.png"
		}
	},
	
	["engine1"] = {
		label = "Tier 1 Engine",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "engine1.png"
		}
	},
	
	["engine2"] = {
		label = "Tier 2 Engine",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "engine2.png"
		}
	},
	
	["engine3"] = {
		label = "Tier 3 Engine",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "engine3.png"
		}
	},
	
	["engine4"] = {
		label = "Tier 4 Engine",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "engine4.png"
		}
	},
	
	["engine5"] = {
		label = "Tier 5 Engine",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "engine5.png"
		}
	},
	
	["transmission1"] = {
		label = "Tier 1 Transmission",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "transmission1.png"
		}
	},
	
	["transmission2"] = {
		label = "Tier 2 Transmission",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "transmission2.png"
		}
	},
	
	["transmission3"] = {
		label = "Tier 3 Transmission",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "transmission3.png"
		}
	},
	
	["transmission4"] = {
		label = "Tier 4 Transmission",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "transmission4.png"
		}
	},
	
	["brakes1"] = {
		label = "Tier 1 Brakes",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "brakes1.png"
		}
	},
	
	["brakes2"] = {
		label = "Tier 2 Brakes",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "brakes2.png"
		}
	},
	
	["brakes3"] = {
		label = "Tier 3 Brakes",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "brakes3.png"
		}
	},
	
	["suspension1"] = {
		label = "Tier 1 Suspension",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "suspension1.png"
		}
	},
	
	["suspension2"] = {
		label = "Tier 2 Suspension",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "suspension2.png"
		}
	},
	
	["suspension3"] = {
		label = "Tier 3 Suspension",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "suspension3.png"
		}
	},
	
	["suspension4"] = {
		label = "Tier 4 Suspension",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "suspension4.png"
		}
	},
	
	["suspension5"] = {
		label = "Tier 5 Suspension",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "suspension5.png"
		}
	},
	
	["bprooftires"] = {
		label = "Bulletproof Tires",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "bprooftires.png"
		}
	},
	
	["drifttires"] = {
		label = "Drift Tires",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "drifttires.png"
		}
	},
	
	-- Cosmetics
	["underglow_controller"] = {
		label = "Neon Controller",
		weight = 0,
		close = true,
		description = "RGB LED Vehicle Remote",
		client = {
			image = "underglow_controller.png"
		}
	},
	
	["headlights"] = {
		label = "Xenon Headlights",
		weight = 0,
		close = true,
		description = "8k HID headlights",
		client = {
			image = "headlights.png"
		}
	},
	
	["tint_supplies"] = {
		label = "Tint Supplies",
		weight = 0,
		close = true,
		description = "Supplies for window tinting",
		client = {
			image = "tint_supplies.png"
		}
	},
	
	["customplate"] = {
		label = "Customized Plates",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "plate.png"
		}
	},
	
	["hood"] = {
		label = "Vehicle Hood",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "hood.png"
		}
	},
	
	["roof"] = {
		label = "Vehicle Roof",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "roof.png"
		}
	},
	
	["spoiler"] = {
		label = "Vehicle Spoiler",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "spoiler.png"
		}
	},
	
	["bumper"] = {
		label = "Vehicle Bumper",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "bumper.png"
		}
	},
	
	["skirts"] = {
		label = "Vehicle Skirts",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "skirts.png"
		}
	},
	
	["exhaust"] = {
		label = "Vehicle Exhaust",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "exhaust.png"
		}
	},
	
	["seat"] = {
		label = "Seat Cosmetics",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "seat.png"
		}
	},
	
	["rollcage"] = {
		label = "Roll Cage",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "rollcage.png"
		}
	},
	
	["rims"] = {
		label = "Custom Wheel Rims",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "rims.png"
		}
	},
	
	["livery"] = {
		label = "Livery Roll",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "livery.png"
		}
	},
	
	["paintcan"] = {
		label = "Vehicle Spray Can",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "spraycan.png"
		}
	},
	
	["tires"] = {
		label = "Drift Smoke Tires",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "tires.png"
		}
	},
	
	["horn"] = {
		label = "Custom Vehicle Horn",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "horn.png"
		}
	},
	
	["internals"] = {
		label = "Internal Cosmetics",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "internals.png"
		}
	},
	
	["externals"] = {
		label = "Exterior Cosmetics",
		weight = 0,
		close = true,
		description = "",
		client = {
			image = "mirror.png"
		}
	},
	
	-- Repair Parts
	["newoil"] = {
		label = "Car Oil",
		weight = 0,
		close = false,
		description = "",
		client = {
			image = "caroil.png"
		}
	},
	
	["sparkplugs"] = {
		label = "Spark Plugs",
		weight = 0,
		close = false,
		description = "",
		client = {
			image = "sparkplugs.png"
		}
	},
	
	["carbattery"] = {
		label = "Car Battery",
		weight = 0,
		close = false,
		description = "",
		client = {
			image = "carbattery.png"
		}
	},
	
	["axleparts"] = {
		label = "Axle Parts",
		weight = 0,
		close = false,
		description = "",
		client = {
			image = "axleparts.png"
		}
	},
	
	["sparetire"] = {
		label = "Spare Tire",
		weight = 0,
		close = false,
		description = "",
		client = {
			image = "sparetire.png"
		}
	},	
	['femaleseed'] = {
		label = 'Female Marijuana Seed',
		weight = 1000,
		consume = 0,
		stack = false,
		server = {
			export = 'rep-weed.femaleseed',
		},
		description = 'Surely I can just plant this, right?',
		client = {
			image = "weed-seed.png"
		}
	},
	['maleseed'] = {
		label = 'Male Marijuana Seed',
		weight = 1000,
		consume = 0,
		stack = false,
		description = 'Add this to a planted female seed to make it pregnant? You are pretty sure this seed has a penis.',
		client = {
			image = "weed-seed.png"
		}
	},
	['wateringcan'] = {
		label = 'Watering Can',
		weight = 7000,
		consume = 0,
		stack = false,
		server = {
			export = 'rep-weed.wateringcan',
		},
		description = 'Fill this at a river or lake.'
	},
	['fertilizer'] = {
		label = 'Fertilizer',
		weight = 1000,
		consume = 0,
		description = 'Cool'
	},
	['wetbud'] = {
		label = 'Wet Bud (100 grams)',
		weight = 35000,
		consume = 0,
		stack = false,
		description = 'THIS CANT BE DRIED WITHOUT STRAIN... Needs to be stored somewhere dry.'
	},
	['driedbud'] = {
		label = 'Dried Bud (100 Grams)',
		weight = 10000,
		consume = 0,
		stack = false,
		server = {
			export = 'rep-weed.driedbud',
		},
		description = 'Pack It?'
	},
	['weedpackage'] = {
		label = 'Suspicious Package',
		weight = 25000,
		consume = 0,
		stack = false,
		server = {
			export = 'rep-weed.weedpackage',
		},
		description = 'Funny smelling package (Marked for Police Seizure)'
	},
	['qualityscales'] = {
		label = 'Quality Scales',
		weight = 2000,
		consume = 0,
		stack = false,
		description = 'Weighs Baggies with no loss'
	},
	['smallscales'] = {
		label = 'Small Scales',
		weight = 1000,
		stack = false,
		description = 'Weighs Baggies with minimal loss'
	},
	['joint'] = {
		label = '2g Joint',
		weight = 1000,
		stack = false,
		consume = 0,
		server = {
			export = 'rep-weed.joint',
		},
		description = 'Its a Joint, man.'
	},
	['emptybaggies'] = {
		label = 'Empty Baggies',
		weight = 1000,
		description = 'Empty Baggies'
	},
	['weedbaggie'] = {
		label = 'Baggie (7g)',
		weight = 1000,
		stack = false,
		consume = 0,
		server = {
			export = 'rep-weed.weedbaggie',
		},
		description = 'Sold on the streets'
	},
	['rollingpaper'] = {
		label = 'Rolling Paper',
		weight = 200,
		description = 'Required to roll joints!'
	},
		-- av laptop
		['laptopav'] = {
			label = 'Laptop',
			weight = 1,
			stack = false,
			close = true,
			description = ''
		},
		['decrypter'] = {
			label = 'Decrypter',
			weight = 1,
			stack = true,
			close = true,
			description = ''
		},
		['black_usb'] = {
			label = 'Black USB',
			weight = 1,
			stack = true,
			close = true,
			description = ''
		},
		['meth_table'] = {
			label = 'Table',
			weight = 1,
			stack = false,
			close = true,
			description = 'A Table'
		},
		['lab_key'] = {
			label = 'Key',
			weight = 1,
			stack = false,
			close = true,
			description = 'A Key'
		},
		['meth_batch'] = {
			label = 'Meth Batch',
			weight = 1,
			stack = false,
			close = true,
			description = 'Meth Batch'
		},
		['meth_tray'] = {
			label = 'Meth Tray',
			weight = 1,
			stack = false,
			close = true,
			description = nil
		},
		['baggies'] = {
			label = 'Baggies',
			weight = 1,
			stack = true,
			close = true,
			description = nil
		},
		['meth1g'] = {
			label = '1g Meth',
			weight = 1,
			stack = true,
			close = true,
			description = nil
		},
		['cd'] = {
			label = 'CD',
			weight = 1,
			stack = false,
			close = true,
			description = 'Support your local artist!'
		},
		['spray'] = {
			label = 'Spray',
			weight = 1,
			stack = true,
			close = true,
			description = ''
		},
		['spray_remover'] = {
			label = 'Spray Remover',
			weight = 1,
			stack = true,
			close = true,
			description = ''
		},
		['dongle'] = {
			label = 'USB Dongle',
			weight = 1,
			stack = false,
			close = true,
			description = ''
		},
		['vpn'] = {
			label = 'VPN',
			weight = 1,
			stack = true,
			close = false,
			description = ''
		},
		['transponder'] = {
			label = 'Transponder',
			weight = 1,
			stack = true,
			close = true,
			description = ''
		},
		['hacking_device'] = {
			label = 'Hacking Device',
			weight = 1,
			stack = true,
			close = true,
			description = ''
		},



	

	["prisonslushie"] = {
		label = "Slushie",
		weight = 1000,
		close = true,
		description = "Slushie",
		client = {
			image = "prisonslushie.png"
		}
	},
	
	["prisonspoon"] = {
		label = "Spoon",
		weight = 1000,
		close = false,
		description = "Cafeteria spoon",
		client = {
			image = "prisonspoon.png"
		}
	},
	
	["prisonrock"] = {
		label = "Coarse Rock",
		weight = 1000,
		close = false,
		description = "A very big coarse rock",
		client = {
			image = "prisonrock.png"
		}
	},
	
	["prisonfruit"] = {
		label = "Fruit Mix",
		weight = 1000,
		close = false,
		description = "A mix of random fruits",
		client = {
			image = "prisonfruit.png"
		}
	},
	
	["prisonwine"] = {
		label = "Pruno Mix",
		weight = 1000,
		close = false,
		description = "You should ferment this to get a good buzz",
		client = {
			image = "prisonwine.png"
		}
	},
	
	["prisonwine_fermented"] = {
		label = "Pruno",
		weight = 1000,
		close = true,
		description = "This should give you a good buzz",
		client = {
			image = "prisonwine_fermented.png"
		}
	},
	
	["prisonsugar"] = {
		label = "Sugar Pack",
		weight = 1000,
		close = false,
		description = "Plain old sugar",
		client = {
			image = "prisonsugar.png"
		}
	},
	
	["prisonmeth"] = {
		label = "Crank",
		weight = 1000,
		close = true,
		description = "Prison made meth of low quality.",
		client = {
			image = "prisonmeth.png"
		}
	},
	
	["prisonbag"] = {
		label = "Plastic Bag",
		weight = 1000,
		close = false,
		description = "A plastic bag",
		client = {
			image = "prisonbag.png"
		}
	},
	
	["prisonjuice"] = {
		label = "Orange Juice",
		weight = 1000,
		close = false,
		description = "Regular Orange Juice",
		client = {
			image = "prisonjuice.png"
		}
	},
	
	["prisonchemicals"] = {
		label = "Chemicals",
		weight = 1000,
		close = false,
		description = "Some random chemicals",
		client = {
			image = "prisonchemicals.png"
		}
	},
	
	["prisonwateringcan"] = {
		label = "Watering Can",
		weight = 1000,
		close = false,
		description = "Watering can with a Bolingbroke Penitentiary label.",
		client = {
			image = "prisonwateringcan.png"
		}
	},
	
	["prisonfarmseeds"] = {
		label = "Plant Seeds",
		weight = 1000,
		close = false,
		description = "Seeds, water, nutrition and love make happy plants",
		client = {
			image = "prisonfarmseeds.png"
		}
	},
	
	["prisonfarmnutrition"] = {
		label = "Plant Nutrition",
		weight = 1000,
		close = false,
		description = "Plant nutrition with a Bolingbroke Penitentiary label",
		client = {
			image = "prisonfarmnutrition.png"
		}
	},

	['gopro'] = {
		label = 'GoPro Camera',
		weight = 10000,
		stack = true,
		close = true,
		description = 'Small Action camera, hm wonder what you could use it for'
	},

	['cam_jammer'] = {
	label = 'Camera Jammer',
	weight = 10000,
	stack = true,
	close = true,
	description = 'Camera Jammer, disrupts video'
	},

	['towingrope'] = {
		label = 'Rope',
		weight = 10000,
		stack = true,
		close = true,
		description = 'Rope to pull stuff'
	},

	['atmobject'] = {
		label = 'ATM',
		weight = 50000,
		stack = true,
		close = true,
		description = 'Stolen ATM, marked for police seizure'
	},
}
