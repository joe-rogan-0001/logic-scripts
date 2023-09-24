local QBCore = exports['lrp-core']:GetCoreObject()
isLoggedIn = true
PlayerJob = {}

local onDuty = false

Citizen.CreateThread(function()
	exports['lrp-target']:AddBoxZone("BurgerShotDuty", vector3(-1191.3, -900.36, 13.98), 1.2, 0.9, {
		name = "BurgerShotDuty",
		heading = 32,
		debugPoly = false,
		minZ=14.0,
		maxZ=18.0,
	}, {
		options = {
		    {  
			event = "lrp-burgershot:DutyB",
			icon = "far fa-clipboard",
			label = "Clock On/Off",
			job = "burgershot",
		    },
		},
		distance = 1.5
	})

		exports['lrp-target']:AddBoxZone("burger_tray_1", vector3(-1195.96, -891.39, 13.98), 0.7, 1.0, {
			name = "burger_tray_1",
			heading = 35.0,
			debugPoly = false,
			minZ=13.8,
			maxZ=14.3,
		}, {
			options = {
			    {
				event = "lrp-burgershot:Tray1",
				icon = "far fa-clipboard",
				label = "Tray 1",
			    },
			},
			distance = 1.5
		})

	exports['lrp-target']:AddBoxZone("burger_tray_2", vector3(-1194.82, -892.73, 13.98), 0.7, 1.2, {
		name="burger_tray_2",
		heading=35,
		debugPoly=false,
		minZ=14.0,
		maxZ=14.4,
	}, {
		options = {
		    {
			event = "lrp-burgershot:Tray4",
			icon = "far fa-clipboard",
			label = "Tray 2",
		    },
		},
		distance = 1.5
	})

	exports['lrp-target']:AddBoxZone("burger_tray_3", vector3(-1193.8, -894.36, 13.98), 0.6, 1.2, {
		name="burger_tray_3",
		heading=35,
		debugPoly=false,
		minZ=13.2,
		maxZ=14.3,
	}, {
		options = {
		    {
			event = "lrp-burgershot:Tray3",
			icon = "far fa-clipboard",
			label = "Tray 3",
		    },
		},
		distance = 3.5
	})


	exports['lrp-target']:AddBoxZone("burgershotcooker", vector3(-1203.17, -896.93, 13.98), 0.7, 1.0, {
		name="burgershotcooker",
		heading=34,
		debugPoly=false,
		minZ=13.0,
		maxZ=14.4,
	}, {
		options = {
			{
				event = "lrp-burgershot:PattyFry",
				icon = "fas fa-hamburger",
				label = "Burger Cook Station",
				job = "burgershot",
			},
		},
		distance = 1.5
	})

	exports['lrp-target']:AddBoxZone("burgershotcooker2 ", vector3(-1202.64, -897.65, 13.98), 0.7, 1, {
		name="burgershotcooker2 ",
		heading=34,
		debugPoly=false,
		minZ=13.0,
		maxZ=14.3,
	}, {
		options = {
			{
				event = "lrp-burgershot:PattyFry",
				icon = "fas fa-hamburger",
				label = "Burger Cook Station 2",
				job = "burgershot",
			},
		},
		distance = 1.5
	})

		exports['lrp-target']:AddBoxZone("burgershotfryer", vector3(-1202.1, -898.79, 13.98), 1.5, 1.5, {
		name="burgershotfryer",
		heading=35,
		debugPoly=false,
		minZ=13.0,
		maxZ=14.4,
		}, {
		    options = {
			{
			    event = "lrp-burgershot:Fries",
			    icon = "fas fa-box",
			    label = "Make Fries",
			    job = "burgershot",
			},
		    },
		    distance = 1.5
		})


	exports['lrp-target']:AddBoxZone("burgershotdrinks", vector3(-1199.69, -895.27, 13.98), 2.2, 0.6, {
	    name="burgershotdrinks",
	    heading=34,
	    debugPoly=false,
	    minZ=13.8,
	    maxZ=14.8,
	    }, {
		options = {
		    {
			event = "lrp-burgershot:DrinksMenu",
			icon = "fas fa-filter",
			label = "Make Some Drinks",
			job = "burgershot",
		    },
		},
		distance = 1.5
	    })

        exports['lrp-target']:AddBoxZone("burgershotdrinks2", vector3(-1189.77, -904.17, 13.98), 2.5, 1.1, {
            name="burgershotdrinks2",
            heading=33,
            debugPoly=false,
            minZ=13.8,
            maxZ=14.8,
            }, {
                options = {
                    {
                        event = "lrp-burgershot:DrinkMenu",
                        icon = "fas fa-filter",
                        label = "Make Some Drinks",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })


         exports['lrp-target']:AddBoxZone("burgerfridge", vector3(-1203.71, -895.86, 14.0), 1.6, 1, {
            name="burgerfridge",
            heading=35,
            debugPoly=false,
            minZ=13.0,
            maxZ=15.6,
        }, {
                options = {
                    {
                        event = "lrp-burgershot:OrderMenu",
                        icon = "fas fa-laptop",
                        label = "Order Ingredients!",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })

        exports['lrp-target']:AddBoxZone("burgershotdisplay", vector3(-1197.78, -894.45, 14.0), 4.4, 1.4, {
            name="burgershotdisplay",
            heading=34,
            debugPoly=false,
            minZ=13.0,
            maxZ=14.8,
        }, {
                options = {
                    {
                        event = "lrp-burgershot:Storage",
                        icon = "fas fa-box",
                        label = "Storage",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })


        exports['lrp-target']:AddBoxZone("craftburger", vector3(-1200.42, -896.71, 13.98), 0.8, 3.7, {
            name="craftburger",
            heading=304,
            debugPoly=false,
            minZ=13.0,
            maxZ=14.4,
        }, {
                options = {
                    {
                        event = "lrp-burgershot:BurgerMenu",
                        icon = "fas fa-cheeseburger",
                        label = "Burger Work Station",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })


        exports['lrp-target']:AddBoxZone("BurgerShot_register_1", vector3(-1196.44, -890.95, 13.98), 0.8, 0.7, {
            name="BurgerShot_register_1",
            debugPoly=false,
            heading=180,
            minZ=14.0,
            maxZ=14.5,
        }, {
                options = {
                    {
                        event = "lrp-burgershot:bill",
                        parms = "1",
                        icon = "fas fa-credit-card",
                        label = "Charge Customer",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })

        exports['lrp-target']:AddBoxZone("BurgerShot_register_2", vector3(-1195.42, -892.39, 13.98), 0.5, 0.5, {
            name="BurgerShot_register_2",
            debugPoly=false,
            heading=35,
            minZ=14.1,
            maxZ=14.5,
            }, {
                    options = {
                        {
                            event = "lrp-burgershot:bill",
                            parms = "2",
                            icon = "fas fa-credit-card",
                            label = "Charge Customer",
                            job = "burgershot",
                        },
                    },
                    distance = 1.5
                })  


        exports['lrp-target']:AddBoxZone("BurgerShot_register_3", vector3(-1194.34, -893.94, 13.98), 0.6, 0.4, {
            name="BurgerShot_register_3",
            debugPoly=false,
            heading=125,
            minZ=14.0,
            maxZ=14.4,
                    }, {
                            options = {
                                {
                                    event = "lrp-burgershot:bill",
                                    parms = "3",
                                    icon = "fas fa-credit-card",
                                    label = "Charge Customer",
                                    job = "burgershot",
                                },
                            },
                            distance = 1.5
                        })  




        exports['lrp-target']:AddBoxZone("BurgerShot_register_4", vector3(-1192.73, -906.51, 13.83), 0.6, 0.6, {
            name="BurgerShot_register_4",
            heading=70,
            debugPoly=false,
            minZ=13.9,
            maxZ=14.6,
                }, {
                        options = {
                            {
                                event = "lrp-burgershot:bill",
                                parms = "4",
                                icon = "fas fa-credit-card",
                                label = "Charge Customer",
                                job = "burgershot",
                            },
                        },
                        distance = 1.5
            })

end)


-- NH - Context --
RegisterNetEvent('lrp-burgershot:BurgerMenu', function(data)
    exports['lrp-menu']:openMenu({
        {
            header = "Burger Menu",
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },

        {
            header = "Moneyshot",
            txt = "Bun , Cooked Patty , Tomato , Lettuce",
            params = {
                event = "lrp-burgershot:MoneyShot", 
                args = {
                    number = 1,
                }
            }
        },
        {
            header = "Meat Free Burger",
            txt = "Bun , Tomato , Lettuce",
            params = {
                event = "lrp-burgershot:MeatFree",
                args = {
                    number = 2,
                }
            }
        },

        {
            header = "Bleeder Burger",
            txt = "Bun , Cooked Patty , Tomato , Lettuce",
            params = {
                event = "lrp-burgershot:BleederBurger",
                args = {
                    number = 3,
                }
            }
        },
        {
            header = "Heart Stopper",
            txt = "Bun , Cooked Patty , Tomato , Lettuce",
            params = {
                event = "lrp-burgershot:HeartStopper",
                args = {
                    number = 4,
                }
            }
        },
        {
            header = "Torpedo Roll",
            txt = "Bun & Cooked Meat",
            params = {
                event = "lrp-burgershot:Torpedo",
                args = {
                    number = 5,
                }
            }
        },
        {
            header = "Murder Meal",
            txt = "The Heart Stopper, Fries and SoftDrink",
            params = {
                event = "lrp-burgershot:CreateMurderMeal",
                args = {
                    number = 6,
                }
            }
        },
    })
end)

RegisterNetEvent('lrp-burgershot:OrderMenu', function(data)

    exports['lrp-menu']:openMenu({
       {
           header = "Fridge",
           isMenuHeader = true, -- Set to true to make a nonclickable title
       },

       {
           header = "Purchase Ingredients",
           txt = "Order Items",
           params = {
               event = "lrp-burgershot:shop", 
               args = {
                   number = 0,
               }
           }
       },
       {
           header = "Fridge",
           txt = "Store items in the fridge",
           params = {
               event = "lrp-burgershot:Storage2",
               args = {
                   number = 1,
               }
           }
       },

       {
           header = "close",
           txt = "",
           params = {
               event = "",
               args = {
                   number = 2,
               }
           }
       },
   })
   end)

   RegisterNetEvent('lrp-burgershot:DrinksMenu', function(data)

    exports['lrp-menu']:openMenu({
       {
           header = "Drinks Menu",
           isMenuHeader = true, -- Set to true to make a nonclickable title
       },

       {
           header = "Soft Drink",
           txt = "Soda Syrup",
           params = {
               event = "lrp-burgershot:SoftDrink", 
               args = {
                   number = 0,
               }
           }
       },
       {
           header = "Milkshake",
           txt = "Milkshake Formula",
           params = {
               event = "lrp-burgershot:mShake",
               args = {
                   number = 1,
               }
           }
       },

       {
           header = "close",
           txt = "",
           params = {
               event = "",
               args = {
                   number = 2,
               }
           }
       },
   })
   end)



-- Till Stuff --
RegisterNetEvent("lrp-burgershot:bill", function()
    local bill = exports['lrp-input']:ShowInput({
        header = "Cash Register",
        submitText = "Charge Customer",
        inputs = {
            {
                type = 'number',
                name = 'id',
                text = 'Magic Number',
                isRequired = true

            },
            {
                type = 'number',
                name = 'amount',
                text = '$0.00',
                isRequired = true

            }
        }
    })
    if bill then
        if not bill.id or not bill.amount then return end
        TriggerServerEvent("lrp-burgershot:bill:player", bill.id, bill.amount)
    end
end)

-- Drawtext -
function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


Citizen.CreateThread(function()
    if Config.Eye == "false" then
    local PlayerData = QBCore.Functions.GetPlayerData()
    while true do
        local sleep = 100
        if isLoggedIn then
            local pos = GetEntityCoords(PlayerPedId())
            if PlayerJob.name == 'burgershot' then
                for k, v in pairs(Config.Locations["duty"]) do
                    if #(pos - vector3(v.x, v.y, v.z)) < 5 then
                        if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
                            if onDuty then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Get off duty")
                            else
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "~r~E~w~ - Get on duty")
                            end
                            if IsControlJustReleased(0, 38) then
                                onDuty = not onDuty
                                TriggerServerEvent("QBCore:ToggleDuty")
                            end
                        elseif #(pos - vector3(v.x, v.y, v.z)) < 2.5 then
                            sleep = 5
                            DrawText3D(v.x, v.y, v.z, "on/off duty")
                        end
                    end
                end

                for k, v in pairs(Config.Locations["pattycooker"]) do
                    if #(pos - vector3(v.x, v.y, v.z)) < 4.5 then
                        if onDuty then
                            if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Cook Patties")
                                if IsControlJustReleased(0, 38) then
                                    TriggerEvent("lrp-burgershot:PattyFry")
                                end
                            elseif #(pos - vector3(v.x, v.y, v.z)) < 2.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "Cook Patties")
                            end  
                        end
                    end
                end

                for k, v in pairs(Config.Locations["fryer"]) do
                    if #(pos - vector3(v.x, v.y, v.z)) < 4.5 then
                        if onDuty then
                            if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Fry Sum Fries")
                                if IsControlJustReleased(0, 38) then
                                    TriggerEvent("lrp-burgershot:Fries")
                                end
                            elseif #(pos - vector3(v.x, v.y, v.z)) < 2.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "Fry Sum Fries")
                            end  
                        end
                    end
                end

                for k, v in pairs(Config.Locations["drinks"]) do
                    if #(pos - vector3(v.x, v.y, v.z)) < 4.5 then
                        if onDuty then
                            if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ -  Make Drinks")
                                if IsControlJustReleased(0, 38) then
                                    TriggerEvent("lrp-burgershot:DrinksMenu")
                                end
                            elseif #(pos - vector3(v.x, v.y, v.z)) < 2.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "Make Drinks")
                            end  
                        end
                    end
                end

                for k, v in pairs(Config.Locations["fridge"]) do
                    if #(pos - vector3(v.x, v.y, v.z)) < 4.5 then
                        if onDuty then
                            if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ -  Open Fridge")
                                if IsControlJustReleased(0, 38) then
                                    TriggerEvent("lrp-burgershot:shop")
                                end
                            elseif #(pos - vector3(v.x, v.y, v.z)) < 2.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "Open Fridge")
                            end  
                        end
                    end
                end

                for k, v in pairs(Config.Locations["storage"]) do
                    if #(pos - vector3(v.x, v.y, v.z)) < 4.5 then
                        if onDuty then
                            if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ -  Open Storage")
                                if IsControlJustReleased(0, 38) then
                                    TriggerEvent("lrp-burgershot:Storage")
                                end
                            elseif #(pos - vector3(v.x, v.y, v.z)) < 2.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "Open Storage")
                            end  
                        end
                    end
                end

                for k, v in pairs(Config.Locations["craftburger"]) do
                    if #(pos - vector3(v.x, v.y, v.z)) < 4.5 then
                        if onDuty then
                            if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ -  Make a Meal")
                                if IsControlJustReleased(0, 38) then
                                    TriggerEvent("lrp-burgershot:BurgerMenu")
                                end
                            elseif #(pos - vector3(v.x, v.y, v.z)) < 2.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "Make a Meal")
                            end  
                        end
                    end
                end

                for k, v in pairs(Config.Locations["cashregister"]) do
                    if #(pos - vector3(v.x, v.y, v.z)) < 4.5 then
                        if onDuty then
                            if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ -  Cash Register")
                                if IsControlJustReleased(0, 38) then
                                    TriggerEvent("lrp-burgershot:bill")
                                end
                            elseif #(pos - vector3(v.x, v.y, v.z)) < 2.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "Cash Register")
                            end  
                        end
                    end
                end

                for k, v in pairs(Config.Locations["garage"]) do
                    if #(pos - vector3(v.x, v.y, v.z)) < 4.5 then
                        if onDuty then
                            if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ -  Garage")
                                if IsControlJustReleased(0, 38) then
                                    TriggerEvent("garage:BurgerShotGarage")
                                end
                            elseif #(pos - vector3(v.x, v.y, v.z)) < 2.5 then
                                sleep = 5
                                DrawText3D(v.x, v.y, v.z, "Garage")
                            end  
                        end
                    end
                end
            else
                Citizen.Wait(2000)
            end
            
            for k, v in pairs(Config.Locations["tray1"]) do
                if #(pos - vector3(v.x, v.y, v.z)) < 4.5 then
                        if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
                            sleep = 5
                            DrawText3D(v.x, v.y, v.z, "~g~E~w~ -  Tray")
                            if IsControlJustReleased(0, 38) then
                                TriggerEvent("lrp-burgershot:Tray1")
                            end
                        elseif #(pos - vector3(v.x, v.y, v.z)) < 2.5 then
                            sleep = 5
                            DrawText3D(v.x, v.y, v.z, "Tray")
                        end  
                end
            end

            for k, v in pairs(Config.Locations["tray2"]) do
                if #(pos - vector3(v.x, v.y, v.z)) < 4.5 then
                        if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
                            sleep = 5
                            DrawText3D(v.x, v.y, v.z, "~g~E~w~ -  Tray")
                            if IsControlJustReleased(0, 38) then
                                TriggerEvent("lrp-burgershot:Tray2")
                            end
                        elseif #(pos - vector3(v.x, v.y, v.z)) < 2.5 then
                            sleep = 5
                            DrawText3D(v.x, v.y, v.z, "Tray")
                        end  
                end
            end

            for k, v in pairs(Config.Locations["tray3"]) do
                if #(pos - vector3(v.x, v.y, v.z)) < 4.5 then
                        if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
                            sleep = 5
                            DrawText3D(v.x, v.y, v.z, "~g~E~w~ -  Tray")
                            if IsControlJustReleased(0, 38) then
                                TriggerEvent("lrp-burgershot:Tray3")
                            end
                        elseif #(pos - vector3(v.x, v.y, v.z)) < 2.5 then
                            sleep = 5
                            DrawText3D(v.x, v.y, v.z, "Tray")
                        end  
                end
            end
        end
        Citizen.Wait(sleep)
    end
end
end)









