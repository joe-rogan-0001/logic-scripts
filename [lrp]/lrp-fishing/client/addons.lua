
local QBCore = exports['lrp-core']:GetCoreObject()

function BoatMenuLaPuerta()
    exports['lrp-menu']:openMenu({
        {
            header = "La Puerta Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Boat: "..Config.RentalBoat,
            txt = "Price: $"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
				args = 1
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function BoatMenuPaletoCove()
    exports['lrp-menu']:openMenu({
        {
            header = "Paleto Cove Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Boat: "..Config.RentalBoat,
            txt = "Price: $"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
				args = 2
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function BoatMenuElGordo()
    exports['lrp-menu']:openMenu({
        {
            header = "El Gordo Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Boat: "..Config.RentalBoat,
            txt = "Price: $"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
				args = 3
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 


function BoatMenuActDam()
    exports['lrp-menu']:openMenu({
        {
            header = "Act Dam Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Boat: "..Config.RentalBoat,
            txt = "Price: $"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
				args = 4
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function BoatMenuAlamoSea()
    exports['lrp-menu']:openMenu({
        {
            header = "Alamo Sea Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Boat: "..Config.RentalBoat,
            txt = "Price: $"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
				args = 5
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 
--============================================================== ReturnMenus

function ReturnBoatLaPuerta()
    exports['lrp-menu']:openMenu({
		{
            header = "Fishing Boat Rental",
            isMenuHeader = true
        },
		{
            header = "Return Boat",
            txt = "return and get $"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
				args = 1
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatPaletoCove()
    exports['lrp-menu']:openMenu({
		{
            header = "Fishing Boat Rental",
            isMenuHeader = true
        },
		{
            header = "Return Boat",
            txt = "return and get $"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
				args = 2
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatElGordo()
    exports['lrp-menu']:openMenu({
		{
            header = "Fishing Boat Rental",
            isMenuHeader = true
        },
		{
            header = "Return Boat",
            txt = "return and get $"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
				args = 3
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatActDam()
    exports['lrp-menu']:openMenu({
		{
            header = "Fishing Boat Rental",
            isMenuHeader = true
        },
		{
            header = "Return Boat",
            txt = "return and get $"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
				args = 4
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatAlamoSea()
    exports['lrp-menu']:openMenu({
		{
            header = "Fishing Boat Rental",
            isMenuHeader = true
        },
		{
            header = "Return Boat",
            txt = "return and get $"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
				args = 5
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

--============================================================== Sell/Gear Menus

RegisterNetEvent('doj:client:SellLegalFish')
AddEventHandler('doj:client:SellLegalFish', function()
    exports['lrp-menu']:openMenu({
		{
            header = "Pearl's Seafood Restaurant",
            isMenuHeader = true
        },
        {
            header = "Sell Mackerel",
            txt = "Current Price: $"..Config.mackerelPrice.." each",
            params = {
				isServer = true,
                event = "lrp-fishing:server:mackerel",
				args = 1
            }
        },
        {
            header = "Sell Codfish",
            txt = "Current Price: $"..Config.codfishPrice.." each",
            params = {
				isServer = true,
                event = "lrp-fishing:server:codfish",
				args = 2
            }
        },
		{
            header = "Sell Bass",
            txt = "Current Price: $"..Config.bassPrice.." each",
            params = {
				isServer = true,
                event = "lrp-fishing:server:bass",
				args = 3 
            }
        },
        {
            header = "Sell Flounder",
            txt = "Current Price: $"..Config.flounderPrice.." each",
            params = {
				isServer = true,
                event = "lrp-fishing:server:flounder",
				args = 4
            }
        },
		{
            header = "Sell Stingray",
            txt = "Current Price: $"..Config.stingrayPrice.." each",
            params = {
				isServer = true,
                event = "lrp-fishing:server:stingray",
				args = 5
            }
        },		
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)




RegisterNetEvent('doj:client:buyFishingGear')
AddEventHandler('doj:client:buyFishingGear', function() 
    exports['lrp-menu']:openMenu({
		{
            header = "Purchase Fishing Gear",
            isMenuHeader = true
        },
        {
            header = "Buy Fishing Bait",
            txt = "$"..Config.fishingBaitPrice,
            params = {
				isServer = true,
                event = "fishing:server:BuyFishingGear",
				args = 1
            }
        },
		{
            header = "Buy Fishing Rod",
            txt = "$"..Config.fishingRodPrice,
            params = {
				isServer = true,
                event = "fishing:server:BuyFishingGear",
				args = 2
            }
        },
        {
            header = "Buy Boat Anchor",
            txt = "$"..Config.BoatAnchorPrice,
            params = {
				isServer = true,
                event = "fishing:server:BuyFishingGear",
				args = 3
            }
        },
        --[[
        {
            header = "Buy Fishing Box",
            txt = "$"..Config.FishingBoxPrice,
            params = {
				isServer = true,
                event = "fishing:server:BuyFishingGear",
				args = 4
            }
        },
        ]]--
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('doj:client:SellillegalFish')
AddEventHandler('doj:client:SellillegalFish', function() 
	--QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
		--if HasItem then
			local charinfo = QBCore.Functions.GetPlayerData().charinfo
			--QBCore.Functions.Notify('Welcome, '..charinfo.firstname..' '..charinfo.lastname)
			exports['lrp-menu']:openMenu({
				{
					header = "Pearl's Seafood Restaurant",
					isMenuHeader = true
				},
				{
					header = "Sell Dolphin",
					txt = "Current Price: $"..Config.dolphinPrice.." each",
					params = {
						isServer = true,
						event = "lrp-fishing:server:dolphin",
						args = 1
					}
				},
				{
					header = "Sell Tiger Shark",
					txt = "Current Price: $"..Config.sharktigerPrice.." each",
					params = {
						isServer = true,
						event = "lrp-fishing:server:sharktiger",
						args = 2
					}
				},
				{
					header = "Sell Hammerhead Shark",
					txt = "Current Price: $"..Config.sharkhammerPrice.." each",
					params = {
						isServer = true,
						event = "lrp-fishing:server:sharkhammer",
						args = 3
					}
				},
				{
					header = "Sell Orca",
					txt = "Current Price: $"..Config.killerwhalePrice.." each",
					params = {
						isServer = true,
						event = "lrp-fishing:server:killerwhale",
						args = 4
					}
				},
				{
					header = "Close",
					txt = "",
					params = {
						event = "qb-menu:closeMenu"
					}
				},
			})
		--else
			--QBCore.Functions.Notify('You cannot sell to us at the moment, sorry for the inconvenience', 'error', 3500)
		--end
	--end, "pearlscard")
end)
