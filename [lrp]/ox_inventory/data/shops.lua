return {
	General = {
		name = 'Shop',
		blip = {
			id = 59, colour = 3, scale = 0.7
		}, inventory = {
			{ name = 'beer', price = 7 },
			{ name = 'whiskey', price = 10 },
			{ name = 'vodka', price = 12 },
			{ name = 'bandage', price = 100 },
			{ name = 'lighter', price = 2 },
			{ name = 'rolling_paper', price = 2 },
			{ name = 'burger', price = 10 },
			{ name = 'water', price = 10 },
			{ name = 'sandwich', price = 10 },
			{ name = 'cola', price = 10 },
		}, locations = {
			vec3(25.7, -1347.3, 29.49),
			vec3(-3038.71, 585.9, 7.9),
			vec3(-3241.47, 1001.14, 12.83),
			vec3(1728.66, 6414.16, 35.03),
			vec3(1697.99, 4924.4, 42.06),
			vec3(1961.48, 3739.96, 32.34),
			vec3(547.79, 2671.79, 42.15),
			vec3(2679.25, 3280.12, 55.24),
			vec3(2557.94, 382.05, 108.62),
			vec3(373.55, 325.56, 103.56),
		}, targets = {
			{ loc = vector3(-3242.23, 999.97, 11.85), length = 0.7, width = 0.5, heading = 0.0, minZ = 10.5, maxZ = 13.9, distance = 1.75 },
			{ loc = vector3(24.5, -1346.63, 28.60), length = 0.6, width = 0.5, heading = 15.0, minZ = 27.91, maxZ = 30.31, distance = 1.75 },
			{ loc = vector3(-47.18, -1758.46, 28.45), length = 0.6, width = 0.6, heading = 175.0, minZ = 27.83, maxZ = 30.23, distance = 1.75 },
			{ loc = vector3(-706.02, -913.9, 18.35), length = 0.6, width = 0.6, heading = 65.0, minZ = 17.04, maxZ = 20.44, distance = 1.75 },
			{ loc = vector3(-1486.75, -377.57, 39.20), length = 0.5, width = 0.5, heading = 235.0, minZ = 38.06, maxZ = 41.46, distance = 1.75 },
			{ loc = vector3(-1221.30, -907.82, 11.40), length = 0.6, width = 0.5, heading = 120.0, minZ = 10.34, maxZ = 13.74, distance = 1.75 },
			{ loc = vector3(-1819.96, 794.04, 137.10), length = 0.6, width = 0.5, heading = 10.0, minZ = 136.16, maxZ = 139.56, distance = 1.75 },
			{ loc = vector3(-3039.89, 584.21, 6.90), length = 0.6, width = 0.5, heading = 330.0, minZ = 5.24, maxZ = 8.64, distance = 1.75 },
			{ loc = vector3(-2966.41, 391.62, 14.05), length = 0.6, width = 0.5, heading = 0.0, minZ = 13.62, maxZ = 16.02, distance = 1.75 },
			{ loc = vector3(1164.72, -323.04, 68.25), length = 0.6, width = 0.5, heading = 345.0, minZ = 67.57, maxZ = 70.97, distance = 1.75 },
		}
	},

	Liquor = {
		name = 'Liquor Store',
		blip = {
			id = 59, colour = 3, scale = 0.7
		}, inventory = {
			{ name = 'beer', price = 7 },
			{ name = 'whiskey', price = 10 },
			{ name = 'vodka', price = 12 },
			{ name = 'bandage', price = 100 },
			{ name = 'lighter', price = 2 },
			{ name = 'rolling_paper', price = 2 },
			{ name = 'burger', price = 10 },
			{ name = 'water', price = 10 },
			{ name = 'sandwich', price = 10 },
			{ name = 'twerks_candy', price = 10 },
			{ name = 'snikkel_candy', price = 10 },
			{ name = 'sandwich', price = 10 },
			{ name = 'cola', price = 10 },
		}, locations = {
			vec3(1135.808, -982.281, 46.415),
			vec3(-1222.915, -906.983, 12.326),
			vec3(-1487.553, -379.107, 40.163),
			vec3(-2968.243, 390.910, 15.043),
			vec3(1166.024, 2708.930, 38.157),
			vec3(1392.562, 3604.684, 34.980),
			vec3(-1393.409, -606.624, 30.319)
		}, targets = {
			{ loc = vector3(1134.32, -983.25, 45.45), length = 0.5, width = 0.5, heading = 96.0, minZ = 43.4, maxZ = 45.8, distance = 1.75 },
			{ loc = vector3(549.24, 2670.37, 41.25), length = 0.6, width = 0.5, heading = 32.7, minZ = 39.3, maxZ = 41.7, distance = 1.75 },
			{ loc = vector3(1959.72, 3740.68, 31.40), length = 0.6, width = 0.5, heading = 133.77, minZ = 29.1, maxZ = 31.5, distance = 1.75 },
			{ loc = vector3(1165.25, 2710.80, 37.16), length = 0.7, width = 0.5, heading = 85.23, minZ = 35.0, maxZ = 37.4, distance = 1.75 },
			{ loc = vector3(1697.8, 4923.14, 41.10), length = 0.6, width = 0.5, heading = 178.84, minZ = 40.1, maxZ = 43.5, distance = 1.75 },
			{ loc = vector3(1728.33, 6416.21, 34.04), length = 0.6, width = 0.6, heading = 200.0, minZ = 32.0, maxZ = 34.4, distance = 1.75 }
		}
	},

	YouTool = {
		name = 'YouTool',
		blip = {
			id = 402, colour = 3, scale = 0.9
		}, inventory = {
			{ name = 'lockpick', price = 200 },
			{ name = 'weapon_wrench', price = 250 },
			{ name = 'weapon_hammer', price = 250 },
			{ name = 'repairkit', price = 250 },
			{ name = 'screwdriverset', price = 320 },
			{ name = 'binoculars', price = 50 },
			{ name = 'firework1', price = 50 },
			{ name = 'firework2', price = 50 },
			{ name = 'firework3', price = 50 },
			{ name = 'firework4', price = 50 },
			{ name = 'cleaningkit', price = 100 },
			{ name = 'advancedrepairkit', price = 500 },
--			{ name = 'tent', price = 1000 },
--			{ name = 'table', price = 500 },
--			{ name = 'barrel', price = 200 },
--			{ name = 'cement', price = 300 },
--			{ name = 'hydrochloricacid', price = 1200 },
--			{ name = 'hydratedlime', price = 300 },
--			{ name = 'ammonia', price = 1500 },
--			{ name = 'empty_weed_bag', price = 5 },
			{ name = 'limewater', price = 10 },
			{ name = 'campfire', price = 500 },
			{ name = 'pestle', price = 250 },
			{ name = 'advancedlockpick', price = 1200 },
			{ name = 'cleaningkit', price = 1500 },
		}, locations = {
			vec3(45.48, -1748.85, 28.55),
			vec3(2747.29, 3473.07, 54.67),
			vec3(-422.36, 6136.68, 30.88)
		}, targets = {
			{ loc = vector3(45.48, -1748.85, 28.55), length = 0.6, width = 3.0, heading = 65.0, minZ = 27.0, maxZ = 29.8, distance = 3.0 },
			{ loc = vector3(2747.29, 3473.07, 54.67), length = 0.6, width = 3.0, heading = 65.0, minZ = 53.0, maxZ = 55.8, distance = 3.0 },
			{ loc = vector3(-422.36, 6136.68, 30.88), length = 0.6, width = 3.0, heading = 65.0, minZ = 29.0, maxZ = 31.8, distance = 3.0 },
		}
	},

	Ammunation = {
		name = 'Ammunation',
		blip = {
			id = 110, colour = 3, scale = 0.7
		}, inventory = {
			{ name = 'ammo-9', price = 5, metadata = { registered = true }, license = 'weapon'  },
			{ name = 'WEAPON_KNIFE', price = 200 },
			{ name = 'WEAPON_BAT', price = 200 },
			{ name = 'WEAPON_HATCHET', price = 200 },
			{ name = 'WEAPON_SWITCHBLADE', price = 200 },
			{ name = 'WEAPON_PISTOL', price = 1000, metadata = { registered = true }, license = 'weapon' }
		}, locations = {
			vec3(-662.180, -934.961, 21.829),
			vec3(810.25, -2157.60, 29.62),
			vec3(1693.44, 3760.16, 34.71),
			vec3(-330.24, 6083.88, 31.45),
			vec3(252.63, -50.00, 69.94),
			vec3(22.56, -1109.89, 29.80),
			vec3(2567.69, 294.38, 108.73),
			vec3(-1117.58, 2698.61, 18.55),
			vec3(842.44, -1033.42, 28.19)
		}, targets = {
			{ loc = vec3(-660.92, -934.10, 21.94), length = 0.6, width = 0.5, heading = 180.0, minZ = 21.8, maxZ = 22.2, distance = 2.0 },
			{ loc = vec3(808.86, -2158.50, 29.73), length = 0.6, width = 0.5, heading = 360.0, minZ = 29.6, maxZ = 30.0, distance = 2.0 },
			{ loc = vec3(1693.57, 3761.60, 34.82), length = 0.6, width = 0.5, heading = 227.39, minZ = 34.7, maxZ = 35.1, distance = 2.0 },
			{ loc = vec3(-330.29, 6085.54, 31.57), length = 0.6, width = 0.5, heading = 225.0, minZ = 31.4, maxZ = 31.8, distance = 2.0 },
			{ loc = vec3(252.85, -51.62, 70.0), length = 0.6, width = 0.5, heading = 70.0, minZ = 69.9, maxZ = 70.3, distance = 2.0 },
			{ loc = vec3(23.68, -1106.46, 29.91), length = 0.6, width = 0.5, heading = 160.0, minZ = 29.8, maxZ = 30.2, distance = 2.0 },
			{ loc = vec3(2566.59, 293.13, 108.85), length = 0.6, width = 0.5, heading = 360.0, minZ = 108.7, maxZ = 109.1, distance = 2.0 },
			{ loc = vec3(-1117.61, 2700.26, 18.67), length = 0.6, width = 0.5, heading = 221.82, minZ = 18.5, maxZ = 18.9, distance = 2.0 },
			{ loc = vec3(841.05, -1034.76, 28.31), length = 0.6, width = 0.5, heading = 360.0, minZ = 28.2, maxZ = 28.6, distance = 2.0 }
		}
	},

	PoliceArmoury = {
		name = 'Police Armoury',
		groups = {
			police = 0
		},
		blip = {
			id = 110, colour = 84, scale = 0.0
		}, inventory = {
			{ name = 'weapon_glockpd', price = 0, metadata = {registered = true, serial = 'POL'}, license = 'weapon' },
			{ name = 'weapon_stungun', price = 0, metadata = {registered = true, serial = 'POL'}, license = 'weapon' },
			{ name = 'weapon_pumpshotgun_mk2pd', price = 1000, metadata = {registered = true, serial = 'POL'}, license = 'weapon'},
			{ name = 'weapon_m4pd', price = 1000, metadata = {registered = true, serial = 'POL'}, license = 'weapon', grade = 3 },
			{ name = 'weapon_nightstick', price = 0 },
			{ name = 'ammo-9', price = 0 },
			{ name = 'ammo-45', price = 20 },
			{ name = 'ammo-shotgun', price = 20 },
			{ name = 'ammo-rifle', price = 20 },
			{ name = 'handcuffs', price = 0 },
			{ name = 'weapon_flashlight', price = 0 },
			{ name = 'empty_evidence_bag', price = 0 },
			{ name = 'police_stormram', price = 0 },
			{ name = 'armor', price = 0 },
			{ name = 'radio', price = 0 },
			{ name = 'pdarmor', price = 0 },
			{ name = 'weapon_combatpdwpd', price = 1000, metadata = {registered = true, serial = 'POL', attachments = {}}, license = 'weapon', grade = 4 },
			{ name = 'weapon_m14', price = 1000 },
			{ name = 'weapon_scarhpd', price = 1000 },
			{ name = 'ifak', price = 0 },
			{ name = 'tazer_cartilage', price = 0 },
			{ name = 'weapon_railgun', price = 2500, metadata = {registered = true, serial = 'POL', attachments = {}}, license = 'weapon', grade = 4 },
			{ name = 'emp_cartilage', price = 500 },
			{ name = 'weapon_ltl', price = 750 },
			{ name = 'ammo-ltl', price = 20 },
			{ name = 'camera', price = 2000 },
		
		}, locations = {
			vec3(462.41, -994.64, 30.69)
		}, targets = {
			{ loc = vec3(462.49, -995.13, 30.1), length = 1.45, width = 1.6, heading = 462.46, minZ = 30.1, maxZ = 31.1, distance = 2 }
		}
	},

	Medicine = {
		name = 'Medicine Cabinet',
		groups = {
			['ambulance'] = 0
		},
		blip = {
			id = 403, colour = 69, scale = 0.7
		}, inventory = {
			{ name = 'medikit', price = 26 },
			{ name = 'bandage', price = 5 }
		}, locations = {
			vec3(306.3687, -601.5139, 43.28406)
		}, targets = {

		}
	},

	HuntingShop = {
		name = 'Hunting Shop',
		blip = {
			id = 463, colour = 3, scale = 0.8
		},
		inventory = {
			{ name = 'huntingknife', price = 350 },
			{ name = 'WEAPON_SNIPERRIFLE2', price = 15000, metadata = { registered = true }, license = 'weapon', 'hunting' },
			{ name = 'ammo-hunting', price = 20, metadata = { registered = true }, license = 'weapon', 'hunting' },
			{ name = 'huntingbait', price = 20 },	
		},
		locations = {
			vec3(-679.87, 5838.73, 16.33)
		},
		targets = {
			{ loc = vec3(-679.87, 5838.73, 16.33), length = 1, width = 3.0, heading = 270.0, minZ = 15.5, maxZ = 17.0, distance = 2 }
		}
	},

	Leisure = {
		name = 'Leisure Shop',
		blip = {
			id = 59, colour = 3, scale = 0.8
		}, inventory = {
			{ name = 'parachute', price = 10000 },
			{ name = 'binoculars', price = 1500 },
			{ name = 'diving_gear', price = 6500 },
		}, locations = {
			vec3(-1505.35, 1511.76, 115.29),
		}, targets = {
			{ loc = vec3(-1505.35, 1511.76, 115.29), length = 2.5, width = 2.5, heading = 0.0, minZ = 113.5, maxZ = 118.9, distance = 6 },
		}
	},
	

	BlackMarketArms = {
		name = 'Abraham the arms dealer',
		inventory = {
			{ name = 'WEAPON_MICROSMG3', price = 35000, metadata = { registered = false	}},
			{ name = 'WEAPON_BROWNING', price = 12500, metadata = { registered = false }},
			{ name = 'WEAPON_DBSHOTGUN', price = 12500, metadata = { registered = false }},
			{ name = 'WEAPON_PISTOL_MK2', price = 12500, metadata = { registered = false }},
			{ name = 'radioscanner', price = 9500},
			{ name = 'gatecrack', price = 7000},
		}, locations = {
			vec3(1025.95, -1852.88, 29.89)
		}, targets = {
			{ loc = vec3(1025.95, -1852.88, 30.89), length = 1.0, width = 1.0, heading = 0.0, minZ = 29.0, maxZ = 31.0, distance = 1.5 },
		}
	},

	BlackMarketArms2 = {
		name = 'Larry the laptop guy',
		inventory = {
			{ name = 'heistlaptop3', price = 1, currency = 'greendongle' },
			{ name = 'laptop_blue', price = 1, currency = 'usb_blue' },
			{ name = 'laptop_red', price = 1, currency = 'usb_red' },
			{ name = 'laptop_gold', price = 1, currency = 'usb_gold' },
		}, locations = {
			vec(-444.6, 1598.3, 358.47)
		}, targets = {
			{ loc = vec3(-444.6, 1598.3, 355.67), length = 1.0, width = 1.0, heading = 0.0, minZ = 113.5, maxZ = 118.9, distance = 1.5 },
		}
	},
	BlackMarketArms3 = {
		name = 'Pierre the Plug',
		inventory = {
			{ name = 'ammo-9', price = 10},
			{ name = 'ammo-45', price = 20},
			{ name = 'ammo-shotgun', price = 20},
			{ name = 'ammo-rifle', price = 50},
			{ name = 'ammo-rifle2', price = 50},
		}, locations = {
			vec3(-1639.18, -1017.1, 6.31)
		}, targets = {
			{ loc = vec3(-1639.18, -1017.1, 6.31), length = 1.0, width = 1.0, heading = 0.0, minZ = 5.0, maxZ = 7.0, distance = 1.5 },
		}
	},
	WeedMarket = {
		name = 'Fresher Thanever',
		inventory = {
			{ name = 'femaleseed', price = 250},
			{ name = 'maleseed', price = 250},
			{ name = 'wateringcan', price = 50},
			{ name = 'fertilizer', price = 50},
			{ name = 'qualityscales', price = 500},
			{ name = 'smallscales', price = 250},
			{ name = 'emptybaggies', price = 5},
			{ name = 'rollingpaper', price = 5},
		}, locations = {
			vec3(2510.4, 3731.21, 39.73)
		}, targets = {
			{ loc = vec3(2510.4, 3731.21, 39.73), length = 1.0, width = 1.0, heading = 0.0, minZ = 39.0, maxZ = 41.0, distance = 1.5 },
		}
	},
	VPN = {
		name = 'Vee Pienne',
		inventory = {
			{ name = 'vpn', price = 10000},
		}, locations = {
			vec3(859.03, 2877.59, 56.98),
		}, targets = {
			{ loc = vec3(859.03, 2877.59, 56.98), length = 1.0, width = 1.0, heading = 0.0, minZ = 55.0, maxZ = 57.0, distance = 1.5 },
		}
	},
	DigitalDen = {
		name = 'Digital Den',
		blip = {
			id = 521, colour = 14, scale = 0.9
		}, inventory = {
			{ name = 'phone', price = 350 },
			{ name = 'boombox', price = 250},
			{ name = 'radio', price = 500},
			{ name = 'laptopav', price = 15000},
		}, locations = {
			vector3(-660.8, -859.28, 24.52)
		}, targets = {
			{ loc = vec3(-660.55, -857.24, 23.54), length = 1.0, width = 1.0, heading = 0.0, minZ = 22.0, maxZ = 24.0, distance = 1.5 },
		}
	},
	PerformanceParts = {
		name = 'Performance Parts',
		groups = {
			wotc = 0
		},
		inventory = {
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
		}, locations = {
			vector3(773.04, -1294.28, 26.24),
		}, targets = {
			{ loc = vec3(773.04, -1294.28, 25.24), length = 0.4, width = 0.4, heading = 0.0, minZ = 24.24, maxZ = 25.84, distance = 1.5 },
		}
	},
	Tools = {
		name = 'Tools',
		groups = {
			wotc = 0
		},
		inventory = {
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
		}, locations = {
			vector3(774.36, -1294.3, 26.24),
		}, targets = {
			{ loc = vec3(774.36, -1294.3, 25.24), length = 0.4, width = 0.4, heading = 0.0, minZ = 24.24, maxZ = 25.84, distance = 1.5 },
		}
	},
	CosmeticParts = {
		name = 'Cosmetic Parts',
		groups = {
			wotc = 0
		},
		inventory = {
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
		}, locations = {
			vector3(775.98, -1294.31, 26.24),
		}, targets = {
			{ loc = vec3(775.98, -1294.31, 25.24), length = 0.4, width = 0.4, heading = 0.0, minZ = 24.24, maxZ = 25.84, distance = 1.5 },
		}
	},
	VendingMachineDrinks = {
		name = 'Vending Machine',
		inventory = {
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
			{ name = 'twerks_candy', price = 10 },
			{ name = 'snikkel_candy', price = 10 },
		},
		model = {
			`prop_vend_soda_02`, `prop_vend_fridge01`, `prop_vend_water_01`, `prop_vend_soda_01`
		}
	}
}
