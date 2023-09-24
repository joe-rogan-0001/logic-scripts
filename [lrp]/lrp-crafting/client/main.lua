-- Variables

local QBCore = exports['lrp-core']:GetCoreObject()
local itemInfos2 = {}
local inCraftingZone = false
local getname = nil
local getname2 = nil
local PlayerData = {}
local PlayerGang = {}


AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    PlayerGang = PlayerData.gang
    Config.Objects["campfire"].placed = false
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang)
    PlayerGang = gang
end)



local function SetupAttachmentItemsInfo(weapon)
    local items = {}

	for k, item in pairs(weapon["items"]) do
	

        local itemInfo = QBCore.Shared.Items[item.name:lower()]

		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = item.label, 
			label = itemInfo["label"],
			description = item.label,
			weight = itemInfo["weight"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
			costs = item.costs,
		}
	end
	weapon["items"] = items
end







RegisterNetEvent('lrp-crafting:client:weapon')
AddEventHandler('lrp-crafting:client:weapon', function(weapon)
    itemInfos2 = {}
    if weapon[2] == "ammo" then
        local itemData = weapon[1]["items"]
        local crafting = {}
        crafting.label = "Attachment Crafting"

        SetupAttachmentItemsInfo(weapon[1])
        local items = {}
        for k, item in pairs(weapon[1]["items"]) do
            items[k] = weapon[1]["items"][k]
        end


        crafting.items = items
        TriggerEvent("lrp-inventory:client:weapontype", itemData)
        TriggerServerEvent("inventory:server:OpenInventory", "attachment_crafting", math.random(1, 99), crafting)
    else
        QBCore.Functions.TriggerCallback('lrp-crafting:server:weapon', function(weapons)	
            if weapons then 
                local itemData = weapon[1]["items"]
                local crafting = {}
                crafting.label = "Attachment Crafting"

                SetupAttachmentItemsInfo(weapon[1])
                local items = {}
                for k, item in pairs(weapon[1]["items"]) do
                    items[k] = weapon[1]["items"][k]
                end

            
                crafting.items = items
                TriggerEvent("lrp-inventory:client:weapontype", itemData)
                TriggerServerEvent("inventory:server:OpenInventory", "attachment_crafting", math.random(1, 99), crafting)

            else
                QBCore.Functions.Notify('You don\'t have that blueprint!', "error")
            end
        end, weapon[2])
    end
end)




--############################--
  ---- Gambinos weapons menu -----
--############################--


RegisterNetEvent('lrp-crafting:client:dealermenu')
AddEventHandler('lrp-crafting:client:dealermenu', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Weapon Crafting",
			isMenuHeader = true
        },
        {
            header = "Craft Weapons",
            txt = 'Crafting',
            params = {
                event = "lrp-crafting:client:craftingmenu"
            }
        },
        {
            header = "Craft Ammo",
            txt = 'Crafting',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.ammo,
                    "ammo"
                }
            }
        },
		{
            header = "Weapon Blueprints",
            txt = 'Buy blueprints',
            params = {
                event = "lrp-shops:marketshop"
            }
        },
        {
            header = "Weapon Repair",
            txt = 'Repair weapons',
            params = {
                event = "weapons:client:SetWeaponQuality"
            }
        },
        {
            header = "Weapon Serial Scratch",
            txt = 'Scratch weapons serial no.',
            params = {
                event = "weapons:client:scratchweaponserial"
            }
        },
		{
            header = "⬅ Close Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)


RegisterNetEvent('lrp-crafting:client:craftingmenu')
AddEventHandler('lrp-crafting:client:craftingmenu', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Weapon Crafting",
			isMenuHeader = true
        },
        {
            header = "Pistols",
            txt = 'Craft Pistols',
            params = {
                event = "lrp-crafting:client:pistolmenu"
            }
        },
		{
            header = "Smgs",
            txt = 'Craft Smgs',
            params = {
                event = "lrp-crafting:client:smgmenu"
            }
        },
		{
            header = "Shotguns",
            txt = 'Craft Shotguns',
            params = {
                event = "lrp-crafting:client:shotgunmenu"
            }
        },
		{
            header = "Assaultrifles",
            txt = 'Craft Assaultrifles',
            params = {
                event = "lrp-crafting:client:assaultriflemenu"
            }
        },
        {
            header = "DMR's",
            txt = "Craft DMR's",
            params = {
                event = "lrp-crafting:client:dmrmenu2"
            }
        },
        {
            header = "MG's",
            txt = "Craft MG's",
            params = {
                event = "lrp-crafting:client:mgmenu2"
            }
        },

		{
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-crafting:client:dealermenu"
            }
        },
    })
end)


RegisterNetEvent('lrp-crafting:client:pistolmenu')
AddEventHandler('lrp-crafting:client:pistolmenu', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Glock 17",
            txt = 'Craft glock',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.glock,
                    "glock"
                },
            }
        },	
        {
            header = "Glock 18c",
            txt = 'Craft glock',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.appistol,
                    "appistol"
                },
            }
        },	
        {
            header = "Doubleaction",
            txt = 'Craft doubleaction',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.doubleaction,
                    "doubleaction"
                },
            }
        },
        {
            header = "Pistol 50",
            txt = 'Craft pistol50',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.pistol50,
                    "pistol50"
                },
            }
        },
        {
            header = "Pistol mk2",
            txt = 'Craft Pistol',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.pistol_mk2,
                    "pistol_mk2"
                },
            }
        },	
		{
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-crafting:client:craftingmenu"
            }
        },
    })
end)


RegisterNetEvent('lrp-crafting:client:smgmenu')
AddEventHandler('lrp-crafting:client:smgmenu', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Microsmg",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.microsmg,
                    "microsmg"
                },
            }
        },
        {
            header = "Tommy Gun",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.gusenberg,
                    "gusenberg"
                },
            }
        },
        {
            header = "Tec-9",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.machinepistol,
                    "machinepistol"
                },
            }
        },
        {
            header = "microsmg 3",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.microsmg3,
                    "microsmg3"
                },
            }
        },
        {
            header = "SMG mk2",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.smg_mk2,
                    "smg_mk2"
                },
            }
        },
		{
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-crafting:client:craftingmenu"
            }
        },
    })
end)


RegisterNetEvent('lrp-crafting:client:shotgunmenu')
AddEventHandler('lrp-crafting:client:shotgunmenu', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Auto Shotgun",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.autoshotgun,
                    "autoshotgun"
                },
            }
        },
        {
            header = "Bullpup Shotgun",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.bullpupshotgun,
                    "bullpupshotgun"
                },
            }
        },
        {
            header = "Heavy Shotgun",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.heavyshotgun,
                    "heavyshotgun"
                },
            }
        },
        {
            header = "Pumpshotgun",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.pumpshotgun,
                    "pumpshotgun"
                },
            }
        },
        {
            header = "Sawnoff Shotgun",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.sawnoffshotgun,
                    "sawnoffshotgun"
                },
            }
        },
		{
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-crafting:client:craftingmenu"
            }
        },
    })
end)


RegisterNetEvent('lrp-crafting:client:assaultriflemenu')
AddEventHandler('lrp-crafting:client:assaultriflemenu', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Bullpup Rifle",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.bullpuprifle,
                    "bullpuprifle"
                },
            }
        },
        {
            header = "Carbine Rifle mk2",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.carbinerifle_mk2,
                    "carbinerifle_mk2"
                },
            }
        },
        {
            header = "Carbine Rifle",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.carbinerifle,
                    "carbinerifle"
                },
            }
        },
        {
            header = "Stg 44",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.specialcarbine,
                    "specialcarbine"
                },
            }
        },
        {
            header = "M4",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.m4,
                    "m4"
                },
            }
        },
		{
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-crafting:client:craftingmenu"
            }
        },
    })
end)


RegisterNetEvent('lrp-crafting:client:dmrmenu2')
AddEventHandler('lrp-crafting:client:dmrmenu2', function()
    exports['lrp-menu']:openMenu({
        {
            header = "musket",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.musket,
                    "musket"
                },
            }
        },
        {
            header = "enfield",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.enfield,
                    "enfield"
                },
            }
        },
		{
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-crafting:client:craftingmenu"
            }
        },
    })
end)


RegisterNetEvent('lrp-crafting:client:mgmenu2')
AddEventHandler('lrp-crafting:client:mgmenu2', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Combat mg",
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.combatmg,
                    "combatmg"
                },
            }
        },
		{
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-crafting:client:craftingmenu"
            }
        },
    })
end)









--############################--
	---- IRA weapons menu -----
--############################--


RegisterNetEvent('lrp-crafting:client:dealermenu2')
AddEventHandler('lrp-crafting:client:dealermenu2', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Weapon Crafting",
			isMenuHeader = true
        },
        {
            header = "Craft Weapons",
            txt = 'Crafting',
            params = {
                event = "lrp-crafting:client:craftingmenu2"
            }
        },
        {
            header = "Craft Ammo",
            txt = 'Crafting',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.ammo,
                    "ammo"
                },
            }
        },
		{
            header = "Weapon Blueprints",
            txt = 'Buy blueprints',
            params = {
                event = "lrp-shops:marketshop"
            }
        },
        {
            header = "Weapon Repair",
            txt = 'Repair weapons',
            params = {
                event = "weapons:client:SetWeaponQuality"
            }
        },
        {
            header = "Weapon Serial Scratch",
            txt = 'Scratch weapons serial no.',
            params = {
                event = "weapons:client:scratchweaponserial"
            }
        },
		{
            header = "⬅ Close Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)


RegisterNetEvent('lrp-crafting:client:craftingmenu2')
AddEventHandler('lrp-crafting:client:craftingmenu2', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Weapon Crafting",
			isMenuHeader = true
        },
        {
            header = "Pistols",
            txt = 'Craft Pistols',
            params = {
                event = "lrp-crafting:client:pistolmenu2"
            }
        },
		{
            header = "Smgs",
            txt = 'Craft Smgs',
            params = {
                event = "lrp-crafting:client:smgmenu2"
            }
        },
		{
            header = "Shotguns",
            txt = 'Craft Shotguns',
            params = {
                event = "lrp-crafting:client:shotgunmenu2"
            }
        },
		{
            header = "Assaultrifles",
            txt = 'Craft Assaultrifles',
            params = {
                event = "lrp-crafting:client:assaultriflemenu2"
            }
        },
        {
            header = "DMR's",
            txt = "Craft DMR's",
            params = {
                event = "lrp-crafting:client:dmrmenu"
            }
        },
        {
            header = "MG's",
            txt = "Craft MG's",
            params = {
                event = "lrp-crafting:client:mgmenu"
            }
        },
        {
            header = "Explosives",
            txt = 'Craft Explosives',
            params = {
                event = "lrp-crafting:client:explosivesmenu"
            }
        },
		{
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-crafting:client:dealermenu"
            }
        },
    })
end)


RegisterNetEvent('lrp-crafting:client:pistolmenu2')
AddEventHandler('lrp-crafting:client:pistolmenu2', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Glock",
            txt = 'Craft glock',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.glock,
                    "glock"
                },

            }
        },		
		{
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-crafting:client:craftingmenu"
            }
        },
    })
end)


RegisterNetEvent('lrp-crafting:client:smgmenu2')
AddEventHandler('lrp-crafting:client:smgmenu2', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Assaultsmg",
            txt = 'Assaultsmg',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.assaultsmg,
                    "assaultsmg"
                },
            }
        },
        {
            header = "Compactrifle",
            txt = 'Compactrifle',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.compactrifle,
                    "compactrifle"
                },
            }
        },
        {
            header = "Microsmg 2",
            txt = 'Microsmg 2',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.compactrifle,
                    "compactrifle"
                },
            }
        },
        {
            header = "Minismg",
            txt = 'Minismg',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.minismg,
                    "minismg"
                },
            }
        },
        {
            header = "Smg",
            txt = 'Smg',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.smg,
                    "smg"
                },
            }
        },
		{
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-crafting:client:craftingmenu",
            }
        },
    })
end)


RegisterNetEvent('lrp-crafting:client:shotgunmenu2')
AddEventHandler('lrp-crafting:client:shotgunmenu2', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Assault Shotgun",
            txt = 'Assault Shotgun',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.assaultshotgun,
                    "assaultshotgun"
                },
            }
        },
        {
            header = "Combat Shotgun",
            txt = 'Combat Shotgun',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.combatshotgun,
                    "combatshotgun"
                },
            }
        },
        {
            header = "DB Shotgun",
            txt = 'DB Shotgun',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.dbshotgun,
                    "dbshotgun"
                },
            }
        },
        {
            header = "Pumpshotgun mk2",
            txt = 'Pumpshotgun mk2',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.pumpshotgun_mk2,
                    "pumpshotgun_mk2"
                },
            }
        },
		{
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-crafting:client:craftingmenu"
            }
        },
    })
end)


RegisterNetEvent('lrp-crafting:client:assaultriflemenu2')
AddEventHandler('lrp-crafting:client:assaultriflemenu2', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Advanced Rifle",
            txt = 'Advanced Rifle',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.advancedrifle,
                    "advancedrifle"
                },
            }
        },
        {
            header = "Assault Rifle mk2",
            txt = 'Assault Rifle mk2',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.assaultrifle_mk2,
                    "assaultrifle_mk2"
                },
            }
        },
        {
            header = "Assault Rifle 2",
            txt = 'Assault Rifle 2',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.assaultrifle2,
                    "assaultrifle2"
                },
            }
        },
        {
            header = "Assault Rifle",
            txt = 'Assault Rifle',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.assaultrifle,
                    "assaultrifle"
                },
            }
        },
        {
            header = "Bullpup Rifle mk2",
            txt = 'Bullpup Rifle mk2',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.bullpuprifle_mk2,
                    "bullpuprifle_mk2"
                },
            }
        },
        {
            header = "Military Rifle",
            txt = 'Military Rifle',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.militaryrifle,
                    "militaryrifle"
                },
            }
        },
        {
            header = "Scar-h",
            txt = 'Scar-h',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.specialcarbine_mk2,
                    "specialcarbine_mk2"
                },
            }
        },
        {
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-crafting:client:craftingmenu"
            }
        },
    })
end)


RegisterNetEvent('lrp-crafting:client:dmrmenu')
AddEventHandler('lrp-crafting:client:dmrmenu', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Dragunov",
            txt = 'Dragunov',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.dragunov,
                    "dragunov"
                },
            }
        },
		{
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-crafting:client:craftingmenu"
            }
        },
    })
end)


RegisterNetEvent('lrp-crafting:client:mgmenu')
AddEventHandler('lrp-crafting:client:mgmenu', function()
    exports['lrp-menu']:openMenu({
        {
            header = "MG",
            txt = 'MG',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.mg,
                    "mg"
                }
            }
        },
		{
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-crafting:client:craftingmenu"
            }
        },
    })
end)


RegisterNetEvent('lrp-crafting:client:explosivesmenu')
AddEventHandler('lrp-crafting:client:explosivesmenu', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Grenade",
            txt = 'Grenade',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.grenade,
                    "grenade"
                }
            }
        },
        {
            header = "Molotov",
            txt = 'Molotov',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.molotov,
                    "molotov"
                }
            }
        },
        {
            header = "Pipebomb",
            txt = 'Pipebomb',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.pipebomb,
                    "pipebomb"
                }
            }
        },
        {
            header = "Sticky Bomb",
            txt = 'Sticky Bomb',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.stickybomb,
                    "stickybomb"
                }
            }
        },
        {
            header = "RPG",
            txt = 'RPG',
            params = {
                event = "lrp-crafting:client:weapon",
                args = {
                    Config.rpg,
                    "rpg"
                }
            }
        },
		{
            header = "⬅ Go Back",
            txt = "",
            params = {
                event = "lrp-crafting:client:craftingmenu"
            }
        },
    })
end)


















CreateThread(function() 
    local weapons = BoxZone:Create(vector3(-312.49, -1311.06, 31.65), 1.1, 2.5, {
        name="Gambino Crafting",
        heading = 178.02,
        debugPoly=false,
        minZ = 31.5,
        maxZ = 33.9,
    }) 
    weapons:onPlayerInOut(function(isPointInside)
        if isPointInside and getname == PlayerGang.name then
            exports['textUi']:DrawTextUi('show', "Press [E] to craft")  
            inCraftingZone = true
        else
            exports['textUi']:HideTextUi('hide')
            inCraftingZone = false
        end
    end)
end)

CreateThread(function()                 
    local weapons = BoxZone:Create(vector3(824.07, -2315.74, 30.46), 2.5, 3.5, {
        name="IRA Crafting",
        heading = 81.4,
        debugPoly=false,
        minZ = 27.5,
        maxZ = 33.9,
    }) 
    weapons:onPlayerInOut(function(isPointInside)
        if isPointInside and getname2 == PlayerGang.name then
            exports['textUi']:DrawTextUi('show', "Press [E] to craft")  
            inCraftingZone = true
        else
            exports['textUi']:HideTextUi('hide')
            inCraftingZone = false
        end
    end)
end)

CreateThread(function() 
    local weapons = BoxZone:Create(vector3(826.56, -2312.37, 30.46), 2.5, 3.5, {
        name="IRA Crafting 2",
        heading = 356.26,
        debugPoly=false,
        minZ = 29.5,
        maxZ = 33.9,
    }) 
    weapons:onPlayerInOut(function(isPointInside)
        if isPointInside and getname2 == PlayerGang.name then
            exports['textUi']:DrawTextUi('show', "Press [E] to craft")  
            inCraftingZone = true
        else
            exports['textUi']:HideTextUi('hide')
            inCraftingZone = false
        end
    end)
end)

Citizen.CreateThread(function()
	while true do
        sleep = 1000	    
		if inCraftingZone then
            sleep = 5
            if IsControlJustReleased(0, 38) then
                sleep = 1000
                inCraftingZone = false
                exports['textUi']:HideTextUi('hide')
                if getname2 == PlayerGang.name then
                    TriggerEvent("lrp-crafting:client:dealermenu2")  
                elseif getname == PlayerGang.name then
                    TriggerEvent("lrp-crafting:client:dealermenu")  
                end       
            end
		end
		Citizen.Wait(sleep)
	end
end)

exports['lrp-target']:AddTargetModel(`s_m_y_blackops_01`, {
    options = {
        {
            event = "lrp-shops:marketshop",
            icon = "fas fa-tools",
            label = "Buy weapon parts",
            gang = "gambino",
			canInteract = function()
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)
    			local pedpos2 = #(pos - vector3(605.89, -3091.66, 5.05))

				if pedpos2 <= 5.0 then
				return true
				else
				return false
				end
			end,
        },
    },
    distance = 5.0
})

exports['lrp-target']:AddTargetModel(`s_m_y_blackops_01`, {
    options = {
        {
            event = "lrp-shops:marketshop",
            icon = "fas fa-tools",
            label = "Buy weapon parts",
            gang = "ira",
			canInteract = function()
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)
    			local pedpos2 = #(pos - vector3(2507.12, -458.33, 92.99))

				if pedpos2 <= 5.0 then
				return true
				else
				return false
				end
			end,
        },
    },
    distance = 5.0
})

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		getname = exports['lrp-territories']:IsTerritoryDominationMoreThanZero('Docs')
		Wait(Config.Delays.territory)
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		getname2 = exports['lrp-territories']:IsTerritoryDominationMoreThanZero('Vespucci')
		Wait(Config.Delays.territory)
	end
end)















Citizen.CreateThread(function()
    local models = {
    'v_res_pestle',
    }
    exports['lrp-target']:AddTargetModel(models, { 
        options = {
            {
                type = "client",
                event = "lrp-crafting:client:gunpowder",
                icon = "fas fa-mortar-pestle",
                label = "Make gun powder",
            },
            {
                type = "client",
                event = "lrp-crafting:client:deleteObject",
                icon = "fas fa-hand",
                label = "Pick up pestle",
            }
        },
        distance = 5.0, 
    })		
end)

Citizen.CreateThread(function()
    local models = {
    'prop_beach_fire',
    }
    exports['lrp-target']:AddTargetModel(models, { 
        options = {
            {
                type = "client",
                event = "lrp-crafting:client:charcoal",
                icon = "fas fa-mortar-pestle",
                label = "Make charcoal",
            },
            {
                type = "client",
                event = "lrp-crafting:client:deleteObject",
                icon = "fas fa-hand",
                label = "Pick up campfire",
            }
        },
        distance = 5.0, 
    })		
end)

RegisterNetEvent('lrp-crafting:client:charcoal', function()
	local ped = PlayerPedId()	
	local pos = GetEntityCoords(ped)

    QBCore.Functions.Progressbar("charcoal", "Making Charcoal", 45000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("lrp-crafting:server:charcoal")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)


RegisterNetEvent('lrp-crafting:client:gunpowder', function()
	local ped = PlayerPedId()	
	local pos = GetEntityCoords(ped)

    QBCore.Functions.Progressbar("charcoal", "Making Gun Powder", 25000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("lrp-crafting:server:gunpowder")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)









RegisterNetEvent('lrp-crafting:client:spawnpestle', function()
	local ped = PlayerPedId()	
	local pos = GetEntityCoords(ped)

    QBCore.Functions.Progressbar("spawn_object", "Place object..", 2500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("lrp-crafting:server:spawnObject", "pestle")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('lrp-crafting:client:spawncampfire', function()
	local ped = PlayerPedId()	
	local pos = GetEntityCoords(ped)

    QBCore.Functions.Progressbar("spawn_object", "Place object..", 2500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("lrp-crafting:server:spawnObject", "campfire")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)

end)



--object control

RegisterNetEvent('lrp-crafting:client:spawnObject', function(objectId, type, player)
    if type == "campfire" then
        Config.Objects["campfire"].placed = true
        local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(player)))
        local heading = GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(player)))
        local forward = GetEntityForwardVector(PlayerPedId())
        local x, y, z = table.unpack(coords + forward * 1.5)
        local spawnedObj = CreateObject(Config.Objects[type].model, x, y, z-1.6, true, true, false)
        -- PlaceObjectOnGroundProperly(spawnedObj)
        SetEntityHeading(spawnedObj, heading)
        FreezeEntityPosition(spawnedObj, Config.Objects[type].freeze)
        TriggerServerEvent("lrp-crafting:server:updateobjects", objectId, spawnedObj, x, y, z)
    else
        print("here4")
        local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(player)))
        local heading = GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(player)))
        local forward = GetEntityForwardVector(PlayerPedId())
        local x, y, z = table.unpack(coords + forward * 1.5)
        local spawnedObj = CreateObject(Config.Objects[type].model, x, y, z, true, true, false)
        coords = GetEntityCoords(spawnedObj)
        PlaceObjectOnGroundProperly(spawnedObj)
        SetEntityHeading(spawnedObj, heading)
        FreezeEntityPosition(spawnedObj, Config.Objects[type].freeze)
        TriggerServerEvent("lrp-crafting:server:updateobjects", objectId, spawnedObj, x, y, z)
    end
end)






RegisterNetEvent('lrp-crafting:client:deleteObject', function()
    local ped = PlayerPedId()	
	local pos = GetEntityCoords(ped)
    QBCore.Functions.TriggerCallback('lrp-crafting:server:deleteObject', function(objectId, dist)	
        print(objectId)
        if objectId == nil then 
            QBCore.Functions.Notify("Cannot pick this item up!", "error")
        else    
            if dist < 5.0 then
                QBCore.Functions.Progressbar("remove_object", "Removing object..", 2500, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
                    anim = "plant_floor",
                    flags = 16,
                }, {}, {}, function() -- Done
                    StopAnimTask(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
                    TriggerServerEvent("lrp-crafting:server:deleteObject", objectId)
                end, function() -- Cancel
                    StopAnimTask(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
                    QBCore.Functions.Notify("Canceled..", "error")
                end)
            end       
        end
            
    end, pos)
end)







RegisterNetEvent('lrp-crafting:client:removeObject', function(objectId, ObjectLists)
    local model = GetEntityModel(ObjectLists.object)
    print(model)
    NetworkRequestControlOfEntity(ObjectLists.object)
    DeleteObject(ObjectLists.object)
    TriggerServerEvent("lrp-crafting:server:givebackitem", model)    
end)