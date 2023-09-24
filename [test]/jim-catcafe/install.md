Thank you for your purchase <3 I hope you have fun with this script and that it brings jobs and RP to your server

If you need support I now have a discord available, it helps me keep track of issues and give better support.

https://discord.gg/xKgQZ6wZvS

Update v1.5.2:
	- Fixed Cat Coffee not being usable
	- Included updated dpemotes in the install.md (replace all)
	
Update v1.5.1:
	- 3 More Props and 2 more custom emotes!
		- Update the custom dpemotes that are already there
	- 4 new inventory images to fit props
	- New drink, Cat Coffee
		- Cat Cafes own Cat Coffee.
		- Don't forget to add this to the items.lua
	- Thanks again to Zenkat :D

Update v1.5:
	- Fixed only one animation when crafting items
	- Added support for the uWuCafe props and dpemotes custom emotes
		- These were provided by Zenkat <3 - https://discord.com/invite/UEqvHUHZ24

Update v1.4.1:
	- Fix Patheal not affecting anything when petting cats
		- Added RelieveStress to add customisable stress relief when petting cats
	- Fix Prepared food shelf being usable by anyone
	- Attempt to hopefully fix garage vehicles not being removed if it wasn't spawned by them
	- Added support for ps-progressbar
	
Update v1.4:
	- Added Support for CheckMarks
		- This is a toggle in the config, if it causes issues(like lag) disable it
	- Added Support for Jim-Shops
	- Optimizations and improved crafting
		- Better handling of targets and peds(cats)
		- Improved/optimized crafting systems, This fixes the issues some were having with crafting "coffee" and "nekolatte"
	- Added support for new QB-Menu in the config
	- Added Job Garage (for delivery vehicles, not parking personal vehicles)
	- Basic Support for prizes from an item
		- New config options to help set this up
	- Added 3 target locations to access bossmenu in the offices
		
Update v.1.3.1:
	- Fixed crafting calling on a nil value
	- Fixed Cash Register not working
	- Fixed watermelon from beanmachine being required

Update v1.3:
	- Changed to new versions of systems
		- Uses crafting recipes
		- Uses Icons in qb-menu now
		- Fixes any issues with making food and drinks
		- Install Checks to see if any items are missing.
	- Added image support for jim-payments cash register

Update v1.2:
	- Payment systems removed/changed in favour of support for my free payment script jim-payments: https://github.com/jimathy/jim-payments#
		- Add this script to your server and payment systems will work as normal with extra features
		- This change removes events from client.lua and server.lua
	- Fixed typo in a hand washing qb-target location
	- Several QoL fixes I've lost track of
	- Removed doubled up cat from ledge near staff door
	- Rearranged qb-menu layout
	- Added item checkmarks to qb-menu's to show if you have the required items or not
		- This adds changes to client.lua
	- Changed seat variable name in chairs.lua to reduce conflicts with my other scripts
	- After many arguements, people prefer to PET the cat not PAT the cat.
	- Fixed item requirements/removal. Messed up mochi ingredients all using mint
	- Added missing item, the orange.
	- Consumable info now stored in the shared's item info
	
UPDATE v1.1:
  - Cat Fixes/Updates
	- Added 6 cats that wander (they are dumb/blind and sometimes get stuck in corners)
	- Cats have no collision so you can walk through them (this is to stop people pushing them into corners and such)
	- ONLY sleeping cats can be petted to relieve stress (for now)
	
  - Added now food preparation location, the Hob's next to the ovens
	- These are for noodles and soups
	
  - New Food Items:
	- Bowl of Ramen
	- Bowl of Noodles
	- Paw Cakes (Pancakes)
	- Kitty Pizza (Pizza)
	- Cat Cake Pop (Cake Lolly Pops)
	- Purrito (Burrito)
  - New Drink Item:
	- Mocha Meow (Mocha Drink)
  - New Ingredient:
	- Instant Noodles

  - Complete rewrite of the payment system, now using qb-menu and qb-phone
	- Tickets are still obtainable through this change
  - Added a minimum amount to get receipts, to stop possible $1 exploits
	- If someone tries to make a payment less than this amount, no one will get a receipt. If its over this amount it will work as usual
	- This is based on the amount set in config.lua with Config.MinAmountforTicket
	- This should, in theory be set to the cheapest product you are selling.
	
  - Couple of QoL fixes
	
-------------------------------------------------------------------------------------------------

THESE GO IN YOUR SHARED.LUA IN qb-core:

Under the QBShared.Items = {
	--CATCAFE
	["bmochi"] 						= {["name"] = "bmochi",  	     			["label"] = "Blue Mochi",	 			["weight"] = 100, 		["type"] = "item", 		["image"] = "mochiblue.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["pmochi"] 						= {["name"] = "pmochi",  	     			["label"] = "Pink Mochi",	 			["weight"] = 100, 		["type"] = "item", 		["image"] = "mochipink.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["gmochi"] 						= {["name"] = "gmochi",  	     			["label"] = "Green Mochi",	 			["weight"] = 100, 		["type"] = "item", 		["image"] = "mochigreen.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["omochi"] 						= {["name"] = "omochi",  	     			["label"] = "Orange Mochi",	 			["weight"] = 100, 		["type"] = "item", 		["image"] = "mochiorange.png",		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },

	--Drinks
	["bobatea"] 					= {["name"] = "bobatea",  	     			["label"] = "Boba Tea",	 				["weight"] = 100, 		["type"] = "item", 		["image"] = "bubbletea.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['thirst'] = math.random(40, 50) },
	["bbobatea"] 					= {["name"] = "bbobatea",  	     			["label"] = "Blue Boba Tea",	 		["weight"] = 100, 		["type"] = "item", 		["image"] = "bubbleteablue.png",	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['thirst'] = math.random(40, 50) },
	["gbobatea"] 					= {["name"] = "gbobatea",  	     			["label"] = "Green Boba Tea",	 		["weight"] = 100, 		["type"] = "item", 		["image"] = "bubbleteagreen.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['thirst'] = math.random(40, 50) },
	["pbobatea"] 					= {["name"] = "pbobatea",  	     			["label"] = "Pink Boba Tea",	 		["weight"] = 100, 		["type"] = "item", 		["image"] = "bubbleteapink.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['thirst'] = math.random(40, 50) },
	["obobatea"] 					= {["name"] = "obobatea",  	     			["label"] = "Orange Boba Tea",	 		["weight"] = 100, 		["type"] = "item", 		["image"] = "bubbleteaorange.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['thirst'] = math.random(40, 50) },

	["nekolatte"] 					= {["name"] = "nekolatte",  	     		["label"] = "Neko Latte",	 			["weight"] = 100, 		["type"] = "item", 		["image"] = "latte.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['thirst'] = math.random(40, 50) },
	["catcoffee"] 					= {["name"] = "catcoffee",  	     		["label"] = "Cat Coffee",	 			["weight"] = 100, 		["type"] = "item", 		["image"] = "catcoffee.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['thirst'] = math.random(10, 20) },

	["sake"] 						= {["name"] = "sake",  	     				["label"] = "Sake",	 					["weight"] = 100, 		["type"] = "item", 		["image"] = "sake.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['thirst'] = math.random(40, 50) },
	
	["miso"] 						= {["name"] = "miso",  	    	 			["label"] = "Miso Soup",		 		["weight"] = 100, 		["type"] = "item", 		["image"] = "miso.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["cake"] 						= {["name"] = "cake",  	     				["label"] = "Strawberry Cake",	 		["weight"] = 100, 		["type"] = "item", 		["image"] = "cake.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["bento"] 						= {["name"] = "bento",  	     			["label"] = "Bento Box",		 		["weight"] = 500, 		["type"] = "item", 		["image"] = "bento.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },

	["riceball"] 					= {["name"] = "riceball",  	     			["label"] = "Neko Onigiri",	 			["weight"] = 100, 		["type"] = "item", 		["image"] = "catrice.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	
	["nekocookie"] 					= {["name"] = "nekocookie",  	     		["label"] = "Neko Cookie",	 			["weight"] = 100, 		["type"] = "item", 		["image"] = "catcookie.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["nekodonut"] 					= {["name"] = "nekodonut",  	     		["label"] = "Neko Donut",	 			["weight"] = 100, 		["type"] = "item", 		["image"] = "catdonut.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	
	--Ingredients
	["boba"] 						= {["name"] = "boba",  			     		["label"] = "Boba",	 					["weight"] = 100, 		["type"] = "item", 		["image"] = "boba.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["flour"] 						= {["name"] = "flour",  			     	["label"] = "Flour",					["weight"] = 100, 		["type"] = "item", 		["image"] = "flour.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["rice"] 						= {["name"] = "rice",  			     		["label"] = "Bowl of Rice",	 			["weight"] = 100, 		["type"] = "item", 		["image"] = "rice.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["sugar"] 						= {["name"] = "sugar",  			     	["label"] = "Sugar",	 				["weight"] = 100, 		["type"] = "item", 		["image"] = "sugar.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["nori"] 						= {["name"] = "nori",  			    	 	["label"] = "Nori",		 				["weight"] = 100, 		["type"] = "item", 		["image"] = "nori.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "" },
	["blueberry"] 					= {["name"] = "blueberry",  			    ["label"] = "Blueberry",		 		["weight"] = 100, 		["type"] = "item", 		["image"] = "blueberry.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["strawberry"] 					= {["name"] = "strawberry",  			    ["label"] = "Strawberry",		 		["weight"] = 100, 		["type"] = "item", 		["image"] = "strawberry.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["orange"] 				 		= {["name"] = "orange",  	     			["label"] = "Orange",	 				["weight"] = 200, 		["type"] = "item", 		["image"] = "orange.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   	["combinable"] = nil,   ["description"] = "An Orange." },
	["mint"] 						= {["name"] = "mint",  			    	 	["label"] = "Matcha",		 			["weight"] = 100, 		["type"] = "item", 		["image"] = "matcha.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "" },
	["tofu"] 						= {["name"] = "tofu",  			    	 	["label"] = "Tofu",		 				["weight"] = 100, 		["type"] = "item", 		["image"] = "tofu.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },

	["mocha"] 						= {["name"] = "mocha",  	     			["label"] = "Mocha Meow",	 			["weight"] = 100, 		["type"] = "item", 		["image"] = "mochameow.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['thirst'] = math.random(40, 50) },

	["cakepop"] 					= {["name"] = "cakepop",  	    	 		["label"] = "Cat Cake-Pop",		 		["weight"] = 100, 		["type"] = "item", 		["image"] = "cakepop.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["pancake"] 					= {["name"] = "pancake",  	     			["label"] = "PawCake",	 				["weight"] = 100, 		["type"] = "item", 		["image"] = "pawcakes.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["pizza"] 						= {["name"] = "pizza",  	     			["label"] = "Kitty Pizza",		 		["weight"] = 100, 		["type"] = "item", 		["image"] = "catpizza.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["purrito"] 					= {["name"] = "purrito",  	     			["label"] = "Purrito",	 				["weight"] = 100, 		["type"] = "item", 		["image"] = "purrito.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	
	["noodlebowl"] 					= {["name"] = "noodlebowl",  	     		["label"] = "Bowl of Noodles",	 		["weight"] = 100, 		["type"] = "item", 		["image"] = "noodlebowl.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },
	["noodles"] 					= {["name"] = "noodles",  	     			["label"] = "Instant Noodles",	 		["weight"] = 100, 		["type"] = "item", 		["image"] = "noodles.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "" },
	["ramen"]						= {["name"] = "ramen",  	     			["label"] = "Bowl of Ramen",	 		["weight"] = 100, 		["type"] = "item", 		["image"] = "ramen.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "", ['hunger'] = math.random(40, 50) },

    ["milk"]                        = {["name"] = "milk",                       ["label"] = "Milk",                     ["weight"] = 300,       ["type"] = "item",      ["image"] = "burger-milk.png",  ["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,     ["combinable"] = nil,    ["description"] = "Carton of Milk", ['thirst'] = math.random(35, 54) },
    ["onion"]                       = {["name"] = "onion",                      ["label"] = "Onion",                    ["weight"] = 500,       ["type"] = "item",      ["image"] = "burger-onion.png", ["unique"] = false,     ["useable"] = false,    ["shouldClose"] = false,    ["combinable"] = nil,    ["description"] = "An onion"},

Under the QBShared.Jobs = {

	['catcafe'] = {
		label = 'Cat Cafe',
		defaultDuty = true,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
        },
	},

	
--------------------------------------------------------------------------------------------------

QB-Bossmenu:
	Within the config.lua:
	This adds the boss menu location in the downstairs office:
		['catcafe'] = vector3(-596.26, -1053.52, 21.85),

	This adds it to the furthest upstairs office:
		['catcafe'] = vector3(-578.23, -1067.65, 26.12),
		
	This adds it to the closest upstairs office:
		['catcafe'] = vector3(-579.1, -1061.28, 26.11),
			
QB-Management:
	Update to the latest github version
	Make sure the job "catcafe" has been added to the database
	The menu's targets should be accessible to bosses in the offices

--------------------------------------------------------------------------------------------------

Custom emotes currently run through dpemotes, its the easier option and adds extra emotes for you to use :)

These go in your [standalone] > dpemotes > client > AnimationList.lua
At about line 1666, place these under DP.PropEmotes = {


	--Jim-CatCafe
	["uwu1"] = { "amb@world_human_drinking@coffee@male@idle_a", "idle_c", "", AnimationOptions =
	{    Prop = 'uwu_sml_drink', PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		EmoteLoop = true, EmoteMoving = true, }},
	["uwu2"] = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "", AnimationOptions =
	{    Prop = 'uwu_pastry', PropBone = 18905, PropPlacement = {0.15, 0.06, -0.02, -50.0, 16.0, 60.0},
		EmoteMoving = true, }},
	["uwu3"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "", AnimationOptions =
	{    Prop = 'uwu_sushi', PropBone = 18905, PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
		EmoteMoving = true, }},
	["uwu4"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp", "", AnimationOptions =
	{    Prop = 'uwu_eggroll', PropBone = 18905, PropPlacement = {0.13, 0.05, 0.02, -50.0, 50.0, 0.0},
		EmoteMoving = true, }},
	["uwu5"] = {"anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", "base_idle", "", AnimationOptions =
	{    Prop = "uwu_salad_bowl", PropBone = 60309, PropPlacement = {-0.015, 0.03, 0.01, 0.0, 0.0, 0.0},
		SecondProp = 'uwu_salad_spoon', SecondPropBone = 28422, SecondPropPlacement = {0.0, 0.0 ,0.0, 0.0, 0.0, 0.0},
		EmoteLoop = true, EmoteMoving = true, }},
	["uwu6"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Iced Latte", AnimationOptions =
	{    Prop = 'uwu_cup_straw',PropBone = 28422,PropPlacement = {0.0, 0.0, -0.03, 0.0, 0.0, 270.0},
		EmoteLoop = true,EmoteMoving = true,}},
	["uwu7"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "", AnimationOptions =
	{    Prop = 'apa_prop_cs_plastic_cup_01',PropBone = 28422,PropPlacement = {0.0, 0.0, -0.06, 0.0, 0.0, 90.0},
		EmoteLoop = true, EmoteMoving = true, }},
	["uwu8"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "", AnimationOptions =
	{    Prop = 'uwu_miso', PropBone = 28422, PropPlacement = {0.025, 0.0, -0.02, 0.0, 10.0, 0.0},
		EmoteLoop = true, EmoteMoving = true, }},
	["uwu9"] = {"anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", "base_idle", "", AnimationOptions =
	{    Prop = "prop_cs_bowl_01b", PropBone = 60309, PropPlacement = {0.0, 0.03, 0.01, 0.0, 0.0, 0.0}, SecondProp = 'uwu_salad_spoon',
		SecondPropBone = 28422,    SecondPropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
		EmoteLoop = true, EmoteMoving = true, }},
	["uwu10"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "", AnimationOptions =
	{    Prop = 'uwu_lrg_drink', PropBone = 28422, PropPlacement = {0.02, 0.0, -0.06, 0.0, 0.0, 90.0},
		EmoteLoop = true, EmoteMoving = true, }},        
	["uwu11"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "", AnimationOptions =
	{    Prop = 'uwu_mug', PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
		EmoteLoop = true, EmoteMoving = true, }}, 
	["uwu12"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "", AnimationOptions =
	{    Prop = 'uwu_cookie', PropBone = 18905, PropPlacement = {0.16, 0.08, -0.01, -225.0, 20.0, 60.0},
		EmoteMoving = true, }},