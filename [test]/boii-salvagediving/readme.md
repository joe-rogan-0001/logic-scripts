------------------------------
--------- CASE#2506 ----------
------------------------------

### QBCORE SALVAGE DIVING ###

A fairly indepth salvage diving script for your city. 
Your citizens can search a variety of sunken containers for a wide variety of rewards.
Included is two searchable containers both with random change rewards. 
Config is highly changeable including all reward and required items.
This has been designed to work along sign qb-diving as to not replace the boat shop. 
Enjoy! <3

### USAGE ###

- Equip your diving gear and head to one of the diving locations
- Third-eye targetting for all containers
- You need a crowbar to open supply crates and tobacco crates
- You need a lockpick to open jewellery crates
- You need a medic keycard to open medical crates
- You need a advanced lockpick to open antique boxes

### INSTALL ###

1) Change the `config.lua` to your liking and remove/add any items you want as rewards. If using my other scripts uncomment out the items under `-- CTRP items`
2) Make sure you have all of the required dependencies installed or the script will not run correctly! You can find these below under `### REQUIREMENTS ###`
3) Drag and drop `case-salvagediving` into your server resources and replace `qb-diving` with my edited version provided
4) Add information provided below into your server shared; `qb-core/shared.lua` or `qb-core/shared/items.lua` depending on core version
5) Add item images into your inventory; `qb-inventory/html/images`
6) Restart your city

### REQUIREMENTS ###

QB-TARGET - https://github.com/BerkieBb/qb-target **THIRD EYE**
TGIANN-SKILLBAR - https://github.com/TGIANN/fivem-tgiann-skillbar **LOCKPICK MINIGAME**
MHACKING - https://github.com/qbcore-framework/mhacking **YOU SHOULD ALREADY HAVE THIS FROM QBCORE**
PROGRESSBAR - https://github.com/qbcore-framework/progressbar **YOU SHOULD ALREADY HAVE THIS FROM QBCORE**

### SHARED.LUA ###
-- Put the item information into either `qb-core/shared.lua` or `qb-core/shared/items.lua` depending on core version junk items are not needed in anyway for the script to function and you will have to add your own way of selling these.

	-- Main script items
	["medickeycard"] 				 = {["name"] = "medickeycard", 			  		["label"] = "Medical Keycard", 		   ["weight"] = 10, 	["type"] = "item", 		["image"] = "medickeycard.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   	["description"] =  "A medical key card? I wonder what this opens!"},
	["documenttube"] 				 = {["name"] = "documenttube", 			  		["label"] = "Document Tube", 		   ["weight"] = 1000, 	["type"] = "item", 		["image"] = "documenttube.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   	["description"] =  "A airtight document tube, could contain anything."},
	["jewellerybag"] 				 = {["name"] = "jewellerybag", 			  		["label"] = "Jewellery Bag", 		   ["weight"] = 500, 	["type"] = "item", 		["image"] = "jewellerybag.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   	["description"] =  "A jewellery bag, anything good inside?"},
	-- Junk items
	["ruineddocuments"] 			 = {["name"] = "ruineddocuments", 			  	["label"] = "Ruined Documents", 	   ["weight"] = 100, 	["type"] = "item", 		["image"] = "ruineddocuments.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   	["description"] =  "Ruined documents.. These are worthless."},
	["rolex_fake"] 			 		 = {["name"] = "rolex_fake", 			  		["label"] = "Fake Rolex", 		   	   ["weight"] = 100, 	["type"] = "item", 		["image"] = "rolex_fake.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   	["description"] =  "Would be nice if it was real.."},
	["goldchain_fake"] 			 	 = {["name"] = "goldchain_fake", 			  	["label"] = "Fake Goldchain", 		   ["weight"] = 100, 	["type"] = "item", 		["image"] = "goldchain_fake.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   	["description"] =  "Ruined documents.. These are worthless."},
	["inactivekeycard"] 			 = {["name"] = "inactivekeycard", 			  	["label"] = "De-Activated Keycar", 	   ["weight"] = 10, 	["type"] = "item", 		["image"] = "inactivekeycard.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   	["description"] =  "Ruined documents.. These are worthless."},

### PREVIEW ###
https://www.youtube.com/watch?v=V94l2JQd2pc
### SUPPORT ###
https://discord.gg/MUckUyS5Kq