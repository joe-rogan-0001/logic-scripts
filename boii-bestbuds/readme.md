----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

### BOII | DEVELOPMENT - JOBS: BEST BUDS ###

Here we have one of the most in depth dispensary script available!
You can harvest 5 different strains. 
Trim your crops into bags to sell to customers. 
Or why not roll them into joints, or prepare edibles!
Script is heavily customisable through config.lua

Script is protected by FiveM native escrow so please be aware some code you will not have access to. 
However this will not affect script functions!

All credits to † INFY †#8209 of SkylineRP for the edibles table :)

### USAGE ###

- Third-eye for all interactions
- Target board on wall in back room to clock on duty
- Target spawned laptop in back room for job management
- Target safe for boss storage
- Target storage racks for boss storage
- Target EPOS machines to take payments *(both locations are set up)*
- Target counter to purchase stock items
- Target coat rack to change outfits
- Target plants to harvest crops *(5 different strains set up)*
- Target table to trim crops into bags
- Target edibles table in back room to prepare gummies *(5 types one for each strain)*
- Target scales on counter to roll joint *(5 types one for each strain)*
- Target bong table to hit the bong *(5 types one for each strain)*
- Target snack counter to purchase snacks
- Target shelving to access job store
- Open menu to view strains

### INSTALL ###

1) Customise `config.lua` to your liking
2) Drag and drop `boii-bestbuds` into your server resources
3) Add `ensure boii-bestbuds` into your server.cfg
4) Copy images from `boii-bestbuds/html/images/*` into your `qb-inventory/html/images`
5) Follow the information noted under ### BOSS MENU ###
6) Follow the information noted under ### QB-CORE/SHARED/JOBS.LUA ###
7) Follow the information noted under ### QB-CORE/SHARED/ITEMS.LUA ###

### BOSS MENU ###
-- Add the following into your server sql `management_funds` table
-- Ensure that you place the correct job ID for your server
-- Ensure that you have named the job here the same as you Config.JobSettings.JobName

INSERT INTO `management_funds` (`id`, `job_name`, `amount`, `type`) VALUES
(13, 'bestbuds', 0, 'boss'),

### QB-CORE/SHARED/JOBS.LUA ###
-- Inset the follwing into your `qb-core/shared/jobs.lua`
-- Ensure that you have named the job here the same as you Config.JobSettings.JobName

['bestbuds'] = {
		label = 'Best Buds',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 50
            },
			['1'] = {
                name = 'Deliveries',
                payment = 75
            },
			['2'] = {
                name = 'Sales',
                payment = 100
            },
			['3'] = {
                name = 'Grower',
                payment = 125
            },
			['4'] = {
                name = 'Assistant Manager',
                payment = 150
            },
			['5'] = {
                name = 'Manager',
				isboss = true,
                payment = 175
            },
			['6'] = {
                name = 'Owner',
				isboss = true,
                payment = 200
            },
        },
	},

### QB-CORE/SHARED/ITEMS.LUA ###
-- If you are not changing the strains insert the items provided into your `qb-core/shared/items.lua`

	--<!>-- WHITE WIDOW --<!>--
	-- Tools
	['drug_shears'] 			    = {['name'] = 'drug_shears', 		        	['label'] = 'Trimming Shears', 			['weight'] = 200, 		['type'] = 'item', 		['image'] = 'drug_shears.png', 					['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A set of high quality trimming shears.'},	
	['drug_grinder'] 			    = {['name'] = 'drug_grinder', 		        	['label'] = 'Tobacco Grinder', 		    ['weight'] = 100, 		['type'] = 'item', 		['image'] = 'drug_grinder.png', 				['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A tobacco grinder or something more..'},	
	['rollingpapers'] 				= {['name'] = 'rollingpapers', 					['label'] = 'Rolling Papers', 			['weight'] = 50, 		['type'] = 'item', 		['image'] = 'rollingpapers.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'Paper made specifically for encasing and smoking tobacco or cannabis.'},
	['lighter'] 			 		= {['name'] = 'lighter', 						['label'] = 'Lighter', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'lighter.png', 						['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A lighter, everybody has to have one of these on hand!'},
	['empty_weed_bag'] 				= {['name'] = 'empty_weed_bag', 			    ['label'] = 'Resealable Bag', 			['weight'] = 1, 		['type'] = 'item', 		['image'] = 'empty_weed_bag.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A small empty bag'},
	['gummybearmould'] 				= {['name'] = 'gummybearmould', 			    ['label'] = 'Gummy Bear Mould', 		['weight'] = 100, 		['type'] = 'item', 		['image'] = 'gummybearmould.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A BPA free mould, shaped like a bear!'},
	['bbmenu'] 						= {['name'] = 'bbmenu', 			    		['label'] = 'Best Buds Menu', 			['weight'] = 10, 		['type'] = 'item', 		['image'] = 'bbmenu.png', 						['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A menu for the best buds medical dispensary!'},

	-- Ingredients
	['gelatine'] 					= {['name'] = 'gelatine', 			    		['label'] = 'Gelatine', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'gelatine.png', 					['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A packet of gelatine, good for making sweets!'},
	['rawhoney'] 					= {['name'] = 'rawhoney', 			    		['label'] = 'Raw Honey', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'rawhoney.png', 					['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A jar of rawhoney, good for making sweets!'},

	-- Crops
	['weed_skunk_cbd_crop'] 	 	= {['name'] = 'weed_skunk_cbd_crop', 			['label'] = 'CBD Skunk Crop', 			['weight'] = 1200, 		['type'] = 'item', 		['image'] = 'weed_skunk_cbd_crop.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'A crop of CBD Skunk!'},
	['weed_og-kush_cbd_crop'] 	 	= {['name'] = 'weed_og-kush_cbd_crop', 			['label'] = 'CBD OG Kush Crop', 		['weight'] = 1200, 		['type'] = 'item', 		['image'] = 'weed_og-kush_cbd_crop.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'A crop of CBD OG Kush'},
	['weed_white-widow_cbd_crop'] 	= {['name'] = 'weed_white-widow_cbd_crop',  	['label'] = 'CBD White Widow Crop', 	['weight'] = 1200, 		['type'] = 'item', 		['image'] = 'weed_white-widow_cbd_crop.png', 	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'A crop of CBD White Widow'},
	['weed_ak47_cbd_crop'] 		 	= {['name'] = 'weed_ak47_cbd_crop', 	    	['label'] = 'CBD AK 47 Crop', 			['weight'] = 1200, 		['type'] = 'item', 		['image'] = 'weed_ak47_cbd_crop.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'A crop of CBD AK47!'},
	['weed_amnesia_cbd_crop'] 		= {['name'] = 'weed_amnesia_cbd_crop',  		['label'] = 'CBD Amnesia Crop', 		['weight'] = 1200, 		['type'] = 'item', 		['image'] = 'weed_amnesia_cbd_crop.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'A crop of CBD Amnesia!'},

	-- Bags
	['weed_skunk_cbd'] 			 	= {['name'] = 'weed_skunk_cbd', 				['label'] = 'CBD Skunk 2g', 			['weight'] = 2, 		['type'] = 'item', 		['image'] = 'weed_skunk_cbd.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'A 2g bag of CBD Skunk!'},
	['weed_og-kush_cbd'] 		 	= {['name'] = 'weed_og-kush_cbd', 				['label'] = 'CBD OGKush 2g', 			['weight'] = 2, 		['type'] = 'item', 		['image'] = 'weed_og-kush_cbd.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'A 2g bag of CBD OG Kush!'},
	['weed_white-widow_cbd'] 	 	= {['name'] = 'weed_white-widow_cbd', 	    	['label'] = 'CBD White Widow 2g', 		['weight'] = 2, 		['type'] = 'item', 		['image'] = 'weed_white-widow_cbd.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'A 2g bag of CBD White Widow!'},
	['weed_ak47_cbd'] 			 	= {['name'] = 'weed_ak47_cbd', 					['label'] = 'CBD AK47 2g', 				['weight'] = 2, 		['type'] = 'item', 		['image'] = 'weed_ak47_cbd.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'A 2g bag of CBD AK47!'},
	['weed_amnesia_cbd'] 			= {['name'] = 'weed_amnesia_cbd',  				['label'] = 'CBD Amnesia 2g', 			['weight'] = 2, 		['type'] = 'item', 		['image'] = 'weed_amnesia_cbd.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'A 2g bag of CBD Amnesia!'},
	
	-- Joints
	['weed_skunk_cbd_joint'] 	    = {['name'] = 'weed_skunk_cbd_joint', 			['label'] = 'CBD Skunk Joint', 			['weight'] = 1, 		['type'] = 'item', 		['image'] = 'weed_skunk_cbd_joint.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'Light up that skunk son!'},
	['weed_og-kush_cbd_joint'] 		= {['name'] = 'weed_og-kush_cbd_joint', 		['label'] = 'CBD OG Kush Joint', 		['weight'] = 1, 		['type'] = 'item', 		['image'] = 'weed_og-kush_cbd_joint.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'Light up that og kush son!'},
	['weed_white-widow_cbd_joint'] 	= {['name'] = 'weed_white-widow_cbd_joint', 	['label'] = 'CBD White Widow Joint', 	['weight'] = 1, 		['type'] = 'item', 		['image'] = 'weed_white-widow_cbd_joint.png', 	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'Light up that white widow son!'},
	['weed_ak47_cbd_joint'] 		= {['name'] = 'weed_ak47_cbd_joint', 			['label'] = 'CBD AK 47 Joint', 			['weight'] = 1, 		['type'] = 'item', 		['image'] = 'weed_ak47_cbd_joint.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'Light up that ak47 son!'},
	['weed_amnesia_cbd_joint'] 		= {['name'] = 'weed_amnesia_cbd_joint',  		['label'] = 'CBD Amnesia Joint', 		['weight'] = 1, 		['type'] = 'item', 		['image'] = 'weed_amnesia_cbd_joint.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   		['combinable'] = nil,   ['description'] = 'Light up that amnesia son!'},

	-- Edibles
	['gummy_skunk_cbd'] 			= {['name'] = 'gummy_skunk_cbd', 			    ['label'] = 'CBD Skunk Gummy', 			['weight'] = 4, 		['type'] = 'item', 		['image'] = 'gummy_skunk_cbd.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A edible cbd skunk gummy bear!'},
	['gummy_og-kush_cbd'] 			= {['name'] = 'gummy_og-kush_cbd', 			    ['label'] = 'CBD OG-Kush Gummy', 		['weight'] = 4, 		['type'] = 'item', 		['image'] = 'gummy_og-kush_cbd.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A edible cbd og kush gummy bear!'},
	['gummy_white-widow_cbd'] 		= {['name'] = 'gummy_white-widow_cbd', 			['label'] = 'CBD White-Widow Gummy', 	['weight'] = 4, 		['type'] = 'item', 		['image'] = 'gummy_white-widow_cbd.png', 		['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A edible cbd white widow gummy bear!'},
	['gummy_ak47_cbd'] 				= {['name'] = 'gummy_ak47_cbd', 			    ['label'] = 'CBD AK47 Gummy', 			['weight'] = 4, 		['type'] = 'item', 		['image'] = 'gummy_ak47_cbd.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A edible cbd ak47 gummy bear!'},
	['gummy_amnesia_cbd'] 			= {['name'] = 'gummy_amnesia_cbd', 			    ['label'] = 'CBD Amnesia Gummy', 		['weight'] = 4, 		['type'] = 'item', 		['image'] = 'gummy_amnesia_cbd.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = 'A edible cbd og kush gummy bear!'},
	

### PREVIEW ###
https://www.youtube.com/watch?v=c4mT9tq4mQg
### SUPPORT ###
https://discord.gg/MUckUyS5Kq
