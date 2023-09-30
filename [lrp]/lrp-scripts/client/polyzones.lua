local Models = {}

Config.CircleZones = {

}

Config.BoxZones = {
    ["boxzone7"] = {
      name = "pdarmoury",
      coords = vector3(483.95, -995.33, 30.69),
      length = 2,
      width = 8,
      heading = 0,
      debugPoly = false,
      minZ = 29,
      maxZ = 35,
      options = {
          {
             type = "client",
             event = "police:client:armourything",
             icon = "fas fa-bullseye",
             label = "Open Armoury",
             job = 'police'
          },
      },
      distance = 2
  },  
  ["jewelheist"] = {
    name = "jewelheist",
    coords = vector3(-595.8919, -283.6023, 50.3237),
    length = 1.00,
    width = 1.00,
    heading = 302.7994,
    debugPoly = false,
    minZ = 50.00,
    maxZ = 51.40,
    options = {
        {
          type = "client",
          event = "lrp-jewellery:client:startheist",
          icon = "fas fa-video",
          label = "Disable Cameras",
        },
    },
    distance = 5.0
},

["jewelheistdoor"] = {
    name = "jewelheistdoor",
    coords = vector3(-619.9963, -223.90, 38.3175),
    length = 0.30,
    width = 0.40,
    heading = 38.5005,
    debugPoly = false,
    minZ = 38.50,
    maxZ = 38.80,
    options = {
        {
          type = "client",
          event = "lrp-jewellery:client:UsePinkCard",
          icon = "fas fa-id-card-alt",
          label = "Disable Doors",
        },
    },
    distance = 5.0
},  
}

Config.PolyZones = {

}

Config.TargetBones = {
}


Config.TargetEntities = {

}
 

Config.TargetModels = {
  ["MininigSell"] = {
		models = {
			"cs_floyd",
		},
		options = {
			{
				type = "client",
				event = "lrp-mining:client:selling",
				icon = "fas fa-hand-holding-dollar",
				label = "Sell Materials",
			},
		},
		distance = 2.0,
	},
  ["HuntingShop"] = {
		models = {
			"cs_hunter",
		},
		options = {
			{
				type = "client",
				event = "lrp-shops:marketshop",
				icon = "fas fa-circle",
				label = "Purchase Hunting Supplies",
			},
		},
		distance = 2.5,
	},
  ["Processing"] = {
		models = {
			"mp_m_counterfeit_01",
		},
		options = {
			{
				type = "client",
				event = "lrp-mining:client:processing",
				icon = "fas fa-circle",
				label = "Smelt Stone",
			},
		},
		distance = 2.5,
	},
  ["huntingprocessing"] = {
		models = {
			"cs_russiandrunk",
		},
		options = {
			{
				type = "server",
				event = "lrp-hunting:SellPelts",
				icon = "fas fa-circle",
				label = "Sell Pelts",
			},
		},
		distance = 2.5,
	},
  ["huntingselling"] = {
		models = {
			"csb_popov",
		},
		options = {
      {
        type = "client",
        event = "lrp-hunting:PeltMenu",
        icon = "fas fa-circle",
        label = "Process Pelts",
      },
		},
		distance = 2.5,
	},
  ["CarDealer"] = {
    models = {
        `np_showroom_stand`
    },
    options = {
        {
            type = "client",
            event = "lrp-cardealer:enterExperience",
            icon = "fas fa-tablet-screen-button",
            label = "View Catalog",
        },
    },
    distance = 1.5
  },
  ["VehicleRental"] = {
    models = {
        `cs_paper`,
    },
    options = {
        {
            type = "client",
            event = "lrp-rentals:MenuCar",
            icon = "fas fa-car",
            label = "Rent Vehicle",
        },
        {
          type = "client",
          event = "lrp-rentals:carreturn",
          icon = "fas fa-exchange-alt",
          label = "Return Rented Vehicle",
      },
    },
    distance = 2.0
},
["VehicleRentalSandy"] = {
  models = {
      `cs_barry`,
  },
  options = {
      {
          type = "client",
          event = "lrp-rentals:MenuCarSandy",
          icon = "fas fa-car",
          label = "Rent Vehicle",
      },
      {
        type = "client",
        event = "lrp-rentals:carreturn",
        icon = "fas fa-exchange-alt",
        label = "Return Rented Vehicle",
    },
  },
  distance = 2.0
},
["VehicleRentalPaleto"] = {
  models = {
      `cs_movpremmale`,
  },
  options = {
      {
          type = "client",
          event = "lrp-rentals:MenuCarPaleto",
          icon = "fas fa-car",
          label = "Rent Vehicle",
      },
      {
        type = "client",
        event = "lrp-rentals:carreturn",
        icon = "fas fa-exchange-alt",
        label = "Return Rented Vehicle",
    },
  },
  distance = 2.0
},
["BoatRental"] = {
  models = {
      `ig_andreas`,
  },
  options = {
      {
          type = "client",
          event = "lrp-rentals:MenuBoat",
          icon = "fas fa-anchor",
          label = "Rent Boat",
      },
      {
        type = "client",
        event = "lrp-rentals:boatreturn",
        icon = "fas fa-exchange-alt",
        label = "Return Rented Boat",
    },
  },
  distance = 2.0
},
["PlaneRental"] = {
  models = {
      `cs_solomon`,
  },
  options = {
      {
          type = "client",
          event = "lrp-rentals:MenuPlane",
          icon = "fas fa-plane",
          label = "Rent Aircraft",
      },
      {
        type = "client",
        event = "lrp-rentals:planereturn",
        icon = "fas fa-exchange-alt",
        label = "Return Rented Aircraft",
    },
  },
  distance = 2.0
},
  ["StopSign"] = {
    models = {
        `prop_sign_road_01a`
    },
    options = {
        {
            type = "client",
            event = "stopsign:client:Target",
            icon = "fas fa-user-secret",
            label = "Pick Up",
        },
    },
    distance = 2.0
  },
  ["Spikestrips"] = {
    models = {
        `p_ld_stinger_s`
    },
    options = {
        {
            type = "client",
            event = "removespike",
            icon = "fas fa-user-secret",
            label = "Pick Up",
        },
    },
    distance = 2.0
  },
  ["miningrock"] = {
    models = {
        `prop_rock_4_c`,
        `2139496847`
    },
    options = {
        {
            type = "client",
            event = "nomorerocks",
            icon = "fas fa-user-secret",
            label = "Break Rock",
        },
    },
    distance = 2.0
  },
  ["jewelboxes"] = {
    models = {
        `des_jewel_cab3_start`,
        `des_jewel_cab2_start`,
        `des_jewel_cab_start`,
        `des_jewel_cab4_start`,

    },
    options = {
        {
            type = "client",
            event = "lrp-jewellery:client:startbreakinglass",
            icon = "fas fa-gem",
            label = "Break Glass",
        },
    },
    distance = 4.0
  },
  ["24/7-SHOPS"] = {
    models = {
      "mp_m_shopkeep_01",
    },
    options = {
      {
        type = "client",
        event = "lrp-shops:marketshop",
        icon = "fas fa-circle",
        label = "Open shop",
      },
    },
    distance = 2.5,
  },
  ["ammunation shops"] = {
      models = {
          "cs_josef",
      },
      options = {
          {
              type = "client",
              event = "lrp-shops:marketshop",
              icon = "fas fa-shopping-cart",
              label = "Buy Weapons",
          },
      },
      distance = 2.5,
  },
  ["youtool shops"] = {
      models = {
          "s_m_m_lathandy_01",
      },
      options = {
          {
              type = "client",
              event = "lrp-shops:marketshop",
              icon = "fas fa-wrench",
              label = "Buy Tools",
          },
      },
      distance = 2.5,
  },
  ["smokeonthewater"] = {
    models = {
        "csb_talcc",
    },
    options = {
        {
            type = "client",
            event = "lrp-shops:marketshop",
            icon = "fas fa-cannabis",
            label = "Open Shop",
        },
    },
    distance = 2.5,
},
["beanmachine"] = {
  models = {
      "cs_debra",
  },
  options = {
      {
          type = "client",
          event = "lrp-shops:marketshop",
          icon = "fas fa-mug-hot",
          label = "Buy Coffee",
      },
  },
  distance = 2.5,
},
  ["leisure shop"] = {
    models = {
        "mp_m_forgery_01",
    },
    options = {
        {
            type = "client",
            event = "lrp-shops:marketshop",
            icon = "fas fa-shopping-cart",
            label = "Open shop",
        },
    },
    distance = 2.5,
},
["seaworld"] = {
  models = {
      "mp_m_exarmy_01",
  },
  options = {
      {
          type = "client",
          event = "lrp-shops:marketshop",
          icon = "fas fa-shopping-cart",
          label = "Open shop",
      },
  },
  distance = 2.5,
},
["blackmarket1"] = {
  models = {
      "s_m_y_dealer_01",
  },
  options = {
      {
          type = "client",
          event = "lrp-shops:marketshop",
          icon = "fas fa-comments",
          label = "Chat to Carl",
      },
  },
  distance = 1.0,
},
}

Config.GlobalPedOptions = {

}

Config.GlobalVehicleOptions = {
  options = {
  {
    type = "client",
    event = "vehicle:flipit",
    icon = 'fas fa-undo-alt',
    label = 'Flip Vehicle', 
    canInteract = function(entity)
      local model = GetDisplayNameFromVehicleModel(GetEntityModel(entity))
      if model ~= 'BMX' and model ~= 'BIMX' then
        return true
      end
    end,
  },
  {
    type = "client",
    event = "pickup:bike",
    icon = 'fas fa-bicycle',
    label = 'Pickup Bike', 
    canInteract = function(entity)
      local model = GetDisplayNameFromVehicleModel(GetEntityModel(entity))
      if model == 'BMX' or model == 'BIMX' then
        return true
      end
    end,
  },
  --[[
  {
    type = "client",
    event = "lj-fuel:client:SendMenuToServer",
    icon = "fas fa-gas-pump",
    label = "Refuel Vehicle",
    canInteract = function(entity)
      local model = GetDisplayNameFromVehicleModel(GetEntityModel(entity))
      if model ~= 'BMX' and model ~= 'BIMX' then
        return true
      end
    end,
  },
  ]]--
  {
    type = "client",
    event = "police:client:runplate",
    icon = "fas fa-address-card",
    label = "Run Plate",
    job = 'police',
    canInteract = function(entity)
      local model = GetDisplayNameFromVehicleModel(GetEntityModel(entity))
      if model ~= 'BMX' and model ~= 'BIMX' then
        return true
      end
    end,
  },
},
distance = 1.5,
}

Config.GlobalObjectOptions = {

}

Config.GlobalPlayerOptions = {
}

Config.Peds = {
  --bowling
  { 
    model = 'a_m_o_salton_01', 
    coords = vector4(756.39, -774.74, 25.34, 102.85), 
    gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
    target = { 
      options = { 
        {
          event = 'bp-bowling:client:openMenu',
          icon = 'fas fa-bowling-ball',
          label = 'View Store'
      }
      },
      distance = 3,
    },
   },
   { 
    model = 'a_m_m_indian_01', 
    coords = vector4(901.34, -170.06, 72.08, 228.81), 
    gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
    target = { 
      options = { 
        {
          event = 'qb-taxijob:client:requestcab',
          icon = "fas fa-sign-in-alt",
          label = '🚕 Request Taxi Cab'
        },
        {
          event = 'qb-taxi:client:DoTaxiNpc',
          icon = "fas fa-sign-in-alt",
          label = '🚕 Request Local Job'
        }
      },
      distance = 3,
    },
   },
--license person
{ 
  model = 'u_f_m_casinoshop_01', 
  coords = vector4(-540.53, -191.01, 37.22, 105.22), 
  gender = 'male',
  freeze = true,
  invincible = true,
  blockevents = true,
  animDict = 'abigail_mcs_1_concat-0',
  anim = 'csb_abigail_dual-0', 
  flag = 1, 
  scenario = 'WORLD_HUMAN_AA_COFFEE', 
  target = { 
    options = { 
      { 
        type = "server", 
        event = "qb-cityhall:server:requestId",
        icon = 'fas fa-id-badge', 
        label = 'Buy A ID Card',
        wantlicense = "id_card",
    },
    {
        type = "server",
        event = "qb-cityhall:server:requestId",
        icon = 'fas fa-id-badge',
        label = "Buy a Driver's License",
        wantlicense = "driver_license",
        canInteract = function()
          local Player = QBCore.Functions.GetPlayerData()
          local licenseTable = Player.metadata["licences"]
            if licenseTable.driver then
              return true
            else
              return false
            end
        end,
    },
    {
        type = "server",
        event = "qb-cityhall:server:requestId",
        icon = 'fas fa-id-badge',
        label = "Buy a Weapon License",
        wantlicense = "weaponlicense",
        canInteract = function()
          local Player = QBCore.Functions.GetPlayerData()
          local licenseTable = Player.metadata["licences"]
            if licenseTable.weapon then
              return true
            else
              return false
            end
        end,
    },
    {
      type = "server",
      event = "qb-cityhall:server:requestId",
      icon = 'fas fa-id-badge',
      label = "Buy a Commerical Drivers License",
      wantlicense = "cdl_license",
      canInteract = function()
        local Player = QBCore.Functions.GetPlayerData()
        local licenseTable = Player.metadata["licences"]
          if licenseTable.cdl then
            return true
          else
            return false
          end
      end,
    },
    {
      type = "server",
      event = "qb-cityhall:server:requestId",
      icon = 'fas fa-id-badge',
      label = "Buy a Drivers Permit",
      wantlicense = "permit",
      canInteract = function()
        local Player = QBCore.Functions.GetPlayerData()
        local licenseTable = Player.metadata["licences"]
          if licenseTable.permit then
            return true
          else
            return false
          end
      end,
    },
    {
      type = "server",
      event = "qb-cityhall:server:requestId",
      icon = 'fas fa-id-badge',
      label = "Buy a Hunting License",
      wantlicense = "huntinglicense",
      canInteract = function()
        local Player = QBCore.Functions.GetPlayerData()
        local licenseTable = Player.metadata["licences"]
          if licenseTable.hunting then
            return true
          else
            return false
          end
      end,
    },
    {
      type = "server",
      event = "qb-cityhall:server:requestId",
      icon = 'fas fa-id-badge',
      label = "Buy a Fishing License",
      wantlicense = "fishinglicense",
      canInteract = function()
        local Player = QBCore.Functions.GetPlayerData()
        local licenseTable = Player.metadata["licences"]
          if licenseTable.fishing then
            return true
          else
            return false
          end
      end,
    },
    {
      type = "server",
      event = "qb-cityhall:server:requestId",
      icon = 'fas fa-id-badge',
      label = "Buy a Pilot's License",
      wantlicense = "pilot_license",
      canInteract = function()
        local Player = QBCore.Functions.GetPlayerData()
        local licenseTable = Player.metadata["licences"]
          if licenseTable.pilot then
            return true
          else
            return false
          end
      end,
    },
    {
      type = "server",
      event = "qb-cityhall:server:requestId",
      icon = 'fas fa-id-badge',
      label = "Buy a Boating License",
      wantlicense = "boating_license",
      canInteract = function()
        local Player = QBCore.Functions.GetPlayerData()
        local licenseTable = Player.metadata["licences"]
          if licenseTable.boating then
            return true
          else
            return false
          end
      end,
    },
    },
    distance = 3,
  },
 },
--cityhall
{ 
  model = 'cs_fbisuit_01', 
  coords = vector4(-551.79, -191.22, 37.22, 220.17), 
  gender = 'male',
  freeze = true,
  invincible = true,
  blockevents = true,
  target = { 
  options = { 
    {
      event = 'mdt:civ:open',
      icon = 'fas fa-desktop',
      label = 'View MDT'
  }
  },
  distance = 3,
  },
 },
  --garbage
  {
  model = 'a_m_m_indian_01', 
  coords = vector4(-193.6, -1162.38, 22.67, 262.64), 
  gender = 'male',
  freeze = true,
  invincible = true,
  blockevents = true,
  target = { 
    options = { 
      {
        type = "client",
        event = "opendepo", 
        icon = 'fas fa-example',
        label = 'Depot', 
      },
    },
    distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
  },
  },
  {
    model = 's_m_y_construct_01',
    coords = vector4(-353.06, -1545.6, 26.72, 265.54), 
    gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  {
    model = 'cs_hunter',
    coords = vector4(-679.87, 5838.73, 16.33, 224.95),
    gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  {
    model = 'mp_m_shopkeep_01',
    coords = vector4(-3242.23, 999.97, 11.85, 351.66),
    gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  {
    model = 'mp_m_shopkeep_01',
    coords = vector4(24.5, -1346.63, 28.60, 273.18),
    gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  {
    model = 'mp_m_shopkeep_01',
    coords = vector4(-47.18, -1758.46, 28.45, 39.64),
    gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  {
    model = 'mp_m_shopkeep_01',
    coords = vector4(-706.02, -913.9, 18.35, 86.17),
    gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  {
    model = 'mp_m_shopkeep_01',
  coords = vector4(-1486.75, -377.57, 39.20, 132.60),
  gender = 'male',
  freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- San Andreas Ave Robs Liquor
  {
  model = 'mp_m_shopkeep_01',
  coords = vector4(-1221.30, -907.82, 11.40, 34.60),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Carrson Ave
  {
  model = 'mp_m_shopkeep_01',
  coords = vector4(372.6, 327.06, 102.55, 258.49),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- North Rockford
  {
  model = 'mp_m_shopkeep_01',
  coords = vector4(-1819.96, 794.04, 137.10, 126.36),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Great Ocean South
  {
  model = 'mp_m_shopkeep_01',
  coords = vector4(-3039.89, 584.21, 6.90, 16.15),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Great Ocean Robs Liquor
  {
  model = 'mp_m_shopkeep_01',
  coords = vector4(-2966.41, 391.62, 14.05, 84.40),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Mirror Park
  {
  model = 'mp_m_shopkeep_01',
  coords = vector4(1164.72, -323.04, 68.25, 93.92),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Vespucci Boulevard Robs Liquor
  {
  model = 'mp_m_shopkeep_01',
  coords = vector4(1134.32, -983.25, 45.45, 278.23),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Route 68
  {
  model = 'mp_m_shopkeep_01',
  coords = vector4(549.24, 2670.37, 41.25, 94.15),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Sandy
  {
  model = 'mp_m_shopkeep_01',
  coords = vector4(1959.72, 3740.68, 31.40, 297.43),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Sandy Shores Robs Liquor
  {
  model = 'mp_m_shopkeep_01',
  coords = vector4(1165.25, 2710.80, 38.16, 183.01),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Grape Seed
  {
  model = 'mp_m_shopkeep_01',
  coords = vector4(1697.8, 4923.14, 41.10, 321.33),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Great Ocean North
  {
  model = 'mp_m_shopkeep_01',
  coords = vector4(1728.33, 6416.21, 34.04, 241.78),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- LS Freeway
  {
  model = 'mp_m_shopkeep_01',
  coords = vector4(2677.32, 3279.69, 54.30, 323.82),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  {
    model = 'mp_m_shopkeep_01',
    coords = vector4(2555.59, 380.91, 107.62, 0.46),
    gender = 'male',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
  -- Paleto
  {
  model = 'mp_m_shopkeep_01',
  coords = vector4(162.15, 6636.66, 30.55, 129.82),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Paleto Robs Liquor
  {
  model = 'mp_m_shopkeep_01',
  coords = vector4(-156.33, 6327.15, 30.58, 318.9),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },

  -- Ammunations
  {   ----vesspuci
  model = 'cs_josef',
  coords = vector4(-661.98, -933.57, 20.80, 181.76),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Legion Square
  {
  model = 'cs_josef',
  coords = vector4(22.59, -1105.55, 28.80, 159.83),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Popular Street
  {
  model = 'cs_josef',
  coords = vector4(810.21, -2159.02, 28.60, 1.43),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Vespucci Boulevard
  {
  model = 'cs_josef',
  coords = vector4(842.42, -1035.31, 27.20, 358.67),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Vinewood Hills
  {
  model = 'cs_josef',
  coords = vector4(253.87, -50.58, 68.95, 67.39),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  {
    model = 'cs_debra',
    coords = vector4(-627.81, 239.02, 80.89, 85.18),
    gender = 'female',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
  -- Palomino Freeway
  {
  model = 'cs_josef',
  coords = vector4(2567.97, 292.64, 107.80, 358.18),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Route 68
  {
  model = 'cs_josef',
  coords = vector4(-1118.98, 2699.77, 17.60, 223.39),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Sandy Shores
  {
  model = 'cs_josef',
  coords = vector4(1692.21, 3760.91, 33.70, 229.39),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  -- Paleto
  {
  model = 'cs_josef',
  coords = vector4(-331.61, 6084.92, 30.55, 226.57),
  gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  ---------------------------------------------------------------------------------
  {  -------Youtool Shop------
    model = `s_m_m_lathandy_01`,
    coords = vector4(45.48, -1748.85, 28.55, 55.1),
    gender = 'male',
    freeze = true,
    invincible = true,
    blockevents = true,
  },
  {  -------LEISURE------
  model = `mp_m_forgery_01`,
  coords = vector4(-1506.06, 1512.0, 114.29, 256.78),
  gender = 'male',
  freeze = true,
  invincible = true,
  blockevents = true,
},
{  -------SEA WORLD-----
model = `mp_m_exarmy_01`,
coords = vector4(-1686.3107, -1072.5789, 12.1522, 43.2431),
gender = 'male',
freeze = true,
invincible = true,
blockevents = true,
},
  {  -------Youtool Shop------
  model = `s_m_m_lathandy_01`,
  coords = vector4(2747.29, 3473.07, 54.67, 246.6),
  gender = 'male',
  freeze = true,
  invincible = true,
  blockevents = true,
},
{  -------Youtool Shop------
model = `s_m_m_lathandy_01`,
coords = vector4(-422.36, 6136.68, 30.88, 229.76),
gender = 'male',
freeze = true,
invincible = true,
blockevents = true,
},
{  -------SMOKE ON THE WATER------
model = `csb_talcc`,
coords = vector4(-1171.34, -1571.09, 3.66, 123.79),
gender = 'male',
freeze = true,
invincible = true,
blockevents = true,
},
    -- AIRCRAFT RENTAL
    {
      model = 'cs_solomon',
      coords = vector4(-1621.35, -3153.0, 12.99, 51.22),
      gender = 'male',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
    -- BOAT RENTAL
    {
      model = 'ig_andreas',
      coords = vector4(-772.88, -1361.47, 4.0, 51.16),
      gender = 'male',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
    -- CAR RENTAL CITY
    {
      model = 'cs_paper',
      coords = vector4(108.75, -1089.13, 28.3, 342.82),
      gender = 'male',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
      -- CAR RENTAL SANDY
    {
      model = 'cs_barry',
      coords = vector4(1224.66, 2728.71, 37.01, 187.89),
      gender = 'male',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
      -- CAR RENTAL PALETO
    {
      model = 'cs_movpremmale',
      coords = vector4(-215.64, 6219.3, 30.49, 229.37),
      gender = 'male',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
    --dmv
    {
      model = `s_m_y_cop_01`,
      coords = vector4(214.57, -1400.24, 30.58, 311.53),
      gender = 'male', 
      animDict = 'anim@heists@prison_heiststation@cop_reactions',
      animName = 'cop_b_idle',
      freeze = false,
      invincible = true,
      blockevents = true,
    },
    --banking
  {
		model = `u_m_m_bankman`,
		coords = vector4(242.94, 226.55, 106.29, 158.52),
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle',
    freeze = false,
    invincible = true,
    blockevents = true,
	},
	{
		model = `ig_bankman`,
		coords = vector4(313.84, -280.58, 54.16, 338.31), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle',
    freeze = false,
    invincible = true,
    blockevents = true,
	},
	{
		model = `ig_bankman`, 
		coords = vector4(149.46, -1042.09, 29.37, 335.43), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle',
    freeze = false,
    invincible = true,
    blockevents = true,
	},
	{
		model = `ig_bankman`, 
		coords = vector4(-351.23, -51.28, 49.04, 341.73), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle',
    freeze = false,
    invincible = true,
    blockevents = true,
	},
	{
		model = `ig_bankman`, 
		coords = vector4(-1211.9, -331.9, 37.78, 20.07), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle',
    freeze = false,
    invincible = true,
    blockevents = true,
	},
	{
		model = `ig_bankman`, 
		coords = vector4(-2961.14, 483.09, 15.7, 83.84), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle',
    freeze = false,
    invincible = true,
    blockevents = true,
	},
	{
		model = `ig_bankman`, 
		coords = vector4(1174.8, 2708.2, 38.09, 178.52), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle',
    freeze = false,
    invincible = true,
    blockevents = true,
	},
	{
		model = `ig_bankman`, 
		coords = vector4(-112.22, 6471.01, 31.63, 134.18), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle',
    freeze = false,
    invincible = true,
    blockevents = true,
	},
  	{
		model = `ig_bankman`, 
		coords = vector4(-1311.51, -823.06, 16.15, 219.84), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle',
    freeze = false,
    invincible = true,
    blockevents = true,
	},
  {
		model = `mp_m_counterfeit_01`,
		coords = vector4(1109.95, -2008.04, 30.06, 56.74),
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle',
    freeze = true,
    invincible = true,
    blockevents = true,
	},
    --weaponsdealer1
    {
      model = `s_m_y_blackops_01`,
      coords = vector4(605.89, -3091.66, 5.05, 179.59),
      gender = 'male', 
      animDict = 'anim@heists@prison_heiststation@cop_reactions',
      animName = 'cop_b_idle',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
    {
      model = `s_m_y_blackops_01`,
      coords = vector4(2507.12, -458.33, 91.99, 344.01),
      gender = 'male', 
      animDict = 'anim@heists@prison_heiststation@cop_reactions',
      animName = 'cop_b_idle',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
    {
      model = 'cs_russiandrunk',
      coords = vector4(2554.13, 4667.93, 33.03, 28.61), 
      gender = 'male',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
    {
      model = 'csb_popov',
      coords = vector4(712.94, -962.01, 29.4, 217.57), 
      gender = 'male',
      freeze = true,
      invincible = true,
      blockevents = true,
    },



    {
      model = `cs_floyd`,
      coords = vector4(24.69, -610.84, 30.63, 343.66),
      gender = 'male', 
      animDict = 'anim@heists@prison_heiststation@cop_reactions',
      animName = 'cop_b_idle',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
    {
      model = `cs_nigel`,
      coords = vector4(2728.68, 4145.57, 43.29, 77.27),
      gender = 'male', 
      animDict = 'anim@amb@business@bgen@bgen_no_work@',
      animName = 'sit_phone_phoneputdown_idle_nowork',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
    {
      model = `mp_f_helistaff_01`,
      coords = vector4(-1299.39, -3407.8, 12.94, 327.49),
      gender = 'male', 
      animDict = 'anim@amb@business@bgen@bgen_no_work@',
      animName = 'sit_phone_phoneputdown_idle_nowork',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
    {
      model = `s_m_y_airworker`,
      coords = vector4(-1241.96, -3393.15, 12.94, 45.36),
      gender = 'male', 
      animDict = 'anim@amb@business@bgen@bgen_no_work@',
      animName = 'sit_phone_phoneputdown_idle_nowork',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
    { 
      model = `cs_old_man2`,
      coords = vector4(2340.72, 3126.48, 47.21, 345.16),
      gender = 'male', 
      animDict = 'anim@amb@business@bgen@bgen_no_work@',
      animName = 'sit_phone_phoneputdown_idle_nowork',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
    {
      model = `s_m_y_dealer_01`,
      coords = vector4(1444.98, 6333.87, 22.85, 88.69),
      gender = 'male', 
      animDict = 'anim@amb@business@bgen@bgen_no_work@',
      animName = 'sit_phone_phoneputdown_idle_nowork',
      freeze = true,
      invincible = true,
      blockevents = true,
    },
}

local function AddTargetModel(models, parameters)
	local distance, options = parameters.distance or Config.MaxDistance, parameters.options
	if type(models) == 'table' then
		for _, model in pairs(models) do
			if type(model) == 'string' then model = GetHashKey(model) end
			if not Models[model] then Models[model] = {} end
			for k, v in pairs(options) do
				if not v.distance or v.distance > distance then v.distance = distance end
				Models[model][v.label] = v
			end
		end
	else
		if type(models) == 'string' then models = GetHashKey(models) end
		if not Models[models] then Models[models] = {} end
		for k, v in pairs(options) do
			if not v.distance or v.distance > distance then v.distance = distance end
			Models[models][v.label] = v
		end
	end
end

CreateThread(function()
  for k, v in pairs(Config.Peds) do
    if not v.currentpednumber or v.currentpednumber == 0 then
      local spawnedped = 0
      RequestModel(v.model)
      while not HasModelLoaded(v.model) do
        Wait(0)
      end

      if type(v.model) == 'string' then v.model = GetHashKey(v.model) end

      if v.minusOne then
        spawnedped = CreatePed(0, v.model, v.coords.x, v.coords.y, v.coords.z - 1.0, v.coords.w, v.networked or false, false)
      else
        spawnedped = CreatePed(0, v.model, v.coords.x, v.coords.y, v.coords.z, v.coords.w, v.networked or false, false)
      end

      if v.freeze then
        FreezeEntityPosition(spawnedped, true)
      end

      if v.invincible then
        SetEntityInvincible(spawnedped, true)
      end

      if v.blockevents then
        SetBlockingOfNonTemporaryEvents(spawnedped, true)
      end

      if v.animDict and v.anim then
        RequestAnimDict(v.animDict)
        while not HasAnimDictLoaded(v.animDict) do
          Wait(0)
        end

        TaskPlayAnim(spawnedped, v.animDict, v.anim, 8.0, 0, -1, v.flag or 1, 0, 0, 0, 0)
      end

      if v.scenario then
        TaskStartScenarioInPlace(spawnedped, v.scenario, 0, true)
      end

      if v.target then
        AddTargetModel(v.model, {
          options = v.target.options,
          distance = v.target.distance
        })
      end

      Config.Peds[k].currentpednumber = spawnedped
    end
  end
  PedsReady = true

    if next(Config.CircleZones) then
        for k, v in pairs(Config.CircleZones) do
            exports['lrp-target']:AddCircleZone(v.name, v.coords, v.radius, {
                name = v.name,
                debugPoly = v.debugPoly,
            }, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.BoxZones) then
        for k, v in pairs(Config.BoxZones) do
            exports['lrp-target']:AddBoxZone(v.name, v.coords, v.length, v.width, {
                name = v.name,
                heading = v.heading,
                debugPoly = v.debugPoly,
                minZ = v.minZ,
                maxZ = v.maxZ
            }, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.PolyZones) then
        for k, v in pairs(Config.PolyZones) do
            exports['lrp-target']:AddPolyZone(v.name, v.points, {
                name = v.name,
                debugPoly = v.debugPoly,
                minZ = v.minZ,
                maxZ = v.maxZ
            }, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.TargetBones) then
        for k, v in pairs(Config.TargetBones) do
            exports['lrp-target']:AddTargetBone(v.bones, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.TargetEntities) then
        for k, v in pairs(Config.TargetEntities) do
            exports['lrp-target']:AddTargetEntity(v.entity, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.TargetModels) then
        for k, v in pairs(Config.TargetModels) do
            exports['lrp-target']:AddTargetModel(v.models, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.Peds) then 
      for k, v in pairs(Config.Peds) do
        if (v.target) then
          exports['lrp-target']:AddTargetModel(v.model, {
            options = v.target.options,
            distance = v.distance
          })
        end
      end
    end
      
    if next(Config.GlobalPedOptions) then
        exports['lrp-target']: AddGlobalPed(Config.GlobalPedOptions)
    end

    if next(Config.GlobalVehicleOptions) then
        exports['lrp-target']: AddGlobalVehicle(Config.GlobalVehicleOptions)
    end

    if next(Config.GlobalObjectOptions) then
        exports['lrp-target']:AddGlobalObject(Config.GlobalObjectOptions)
    end

    if next(Config.GlobalPlayerOptions) then
        exports['lrp-target']:AddGlobalPlayer(Config.GlobalPlayerOptions)
    end
end)

-- Events