# Dependencies
- QBCore (latest)
- qb-target https://github.com/qbcore-framework/qb-target
- qb-inventory

# qb-inventory/html/js/app.js (Line 577 - 650) you can search for stickynote and you will see where it needs to be placed

* ```lua
} else if (itemData.name == "bounty-contract") {
            $(".item-info-title").html('<p>' + itemData.label + '</p>')
            $(".item-info-description").html('<p><strong>First Name: </strong><span>'+ itemData.info.targetname + '</span></p><p><strong>Last Name: </strong><span>'+ itemData.info.targetlastname+ '</span></p><p><strong>Last Seen: </strong><span>'+ itemData.info.lastseen+ '</span></p><p><strong>Bounty: $</strong><span>'+ itemData.info.bountyprice+ '</span></p><p><strong>Wanted For: </strong><span>'+ itemData.info.wantedfor);
            ```

# Bounty Contract Item add to your qb-core>shared>items.lua
 
 ```lua
	["bounty-contract"] 			     		 = {["name"] = "bounty-contract",				    		["label"] = "Bounty Contract",			   			["weight"] = 500,    	["type"] = "item",		["image"] = "bounty-contract.png",         			["unique"] = true,		["useable"] = false,	    ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "",								["created"] = nil, 		["decay"] = 1.0 },
  ```

# Take imange from the image folder and drop into your qb-inventory>html>images