Config = {}

-- Language
Config.ReadyPlayers = "Ready for players!"
Config.Players = "players"
Config.BlueTeam = "Blue Team"
Config.Blue = "Blue"
Config.Red = "Red"
Config.GameInProgress = "Game in progress!"
Config.BumperBall = "Bumper Ball"

Config.FinalScore = function()
    TriggerEvent("DoLongHudText", "Final score" .. ": " .. "Blue" .. " " .. tostring(blueScore) .. " - " .. tostring(redScore) .. " " .. "Red", 1, 12000, { i18n = { "Final score", "Blue", "Red" }})
end

Config.GameStartsIn = function()
    TriggerEvent("DoLongHudText",  "Game starts in" .. ": " .. tostring(lc) .. " " .. "seconds!")
end

Config.GameStarted = function()
    TriggerEvent("DoLongHudText", "Game started!")
end



-- PolyZones - Targets
Citizen.CreateThread(function()
    exports["ld-polyzone"]:AddBoxZone("rc_soccer_pitch", vector3(-1624.08, -1084.72, 13.24), 21.2, 29.2, {
      heading=230,
      minZ=12.04,
      maxZ=16.64,
    })
    northGoal = BoxZone:Create(vector3(-1616.29, -1075.88, 13.24), 1.2, 5.4, {
      name="rc_soccer_pitch_goal",
      heading=320,
      minZ=12.04,
      maxZ=15.04,
    })
    southGoal = BoxZone:Create(vector3(-1631.47, -1093.8, 13.24), 1.2, 5.4, {
      name="rc_soccer_pitch_goal",
      heading=320,
      minZ=12.04,
      maxZ=15.04,
    })
  
    exports['lrp-target']:AddBoxZone("rc_soccer_entry_pad1", vector3(-1623.89, -1097.76, 13.12), 0.8, 0.6, {
      name="rc_soccer_entry_pad1",
      heading=320,
      minZ=13.12,
      maxZ=13.52,
    }, {
      options = {
          {
              event = "np-deanworld:rocketLeagueJoinGame",
              icon = "fas fa-play", 
              args = {
                id = 1,
                goalIndex = 1,
                ref = "south",
              },
              label = "Join game!", 
          },
          {
            event = "np-deanworld:rocketLeagueChangePlayers",
            icon = "fas fa-circle", 
            label = "Change Player Count", 
          },
      },
    
      job = {"all"},
      distance = 2.5
    })
  
    exports['lrp-target']:AddBoxZone("rc_soccer_entry_pad2", vector3(-1622.13, -1095.9, 13.32), 0.8, 0.6, {
      name="rc_soccer_entry_pad2",
      heading=320,
      minZ=13.12,
      maxZ=13.52,
    }, {
      options = {
          {
              event = "np-deanworld:rocketLeagueJoinGame",
              icon = "fas fa-play", 
              args = {
                id = 2,
                goalIndex = 2,
                ref = "south",
              },
              label = "Join game!", 
          },
          {
            event = "np-deanworld:rocketLeagueChangePlayers",
            icon = "fas fa-circle", 
            label = "Change Player Count", 
          },
      },
    
      job = {"all"},
      distance = 2.5
    })
  
    exports['lrp-target']:AddBoxZone("rc_soccer_entry_pad3", vector3(-1620.64, -1093.81, 13.32), 0.8, 0.6, {
      name="rc_soccer_entry_pad3",
      heading=320,
      minZ=13.12,
      maxZ=13.52,
    }, {
      options = {
          {
              event = "np-deanworld:rocketLeagueJoinGame",
              icon = "fas fa-play", 
              args = {
                id = 3,
                goalIndex = 3,
                ref = "south",
              },
              label = "Join game!", 
          },
          {
            event = "np-deanworld:rocketLeagueChangePlayers",
            icon = "fas fa-circle", 
            label = "Change Player Count", 
          },
      },
    
      job = {"all"},
      distance = 2.5
    })
  
    exports['lrp-target']:AddBoxZone("rc_soccer_entry_pad4", vector3(-1614.46, -1086.65, 13.32), 0.8, 0.6, {
      name="rc_soccer_entry_pad4",
      heading=320,
      minZ=13.12,
      maxZ=13.52,
    }, {
      options = {
          {
              event = "np-deanworld:rocketLeagueJoinGame",
              icon = "fas fa-play", 
              args = {
                id = 4,
                goalIndex = 1,
                ref = "north",
              },
              label = "Join game!", 
          },
          {
            event = "np-deanworld:rocketLeagueChangePlayers",
            icon = "fas fa-circle", 
            label = "Change Player Count", 
          },
      },
    
      job = {"all"},
      distance = 2.5
    })
  
    exports['lrp-target']:AddBoxZone("rc_soccer_entry_pad5", vector3(-1612.78, -1084.66, 13.32), 0.8, 0.6, {
      name="rc_soccer_entry_pad5",
      heading=320,
      minZ=13.12,
      maxZ=13.52,
    }, {
      options = {
          {
              event = "np-deanworld:rocketLeagueJoinGame",
              icon = "fas fa-play", 
              args = {
                id = 5,
                goalIndex = 2,
                ref = "north",
              },
              label = "Join game!", 
          },
          {
            event = "np-deanworld:rocketLeagueChangePlayers",
            icon = "fas fa-circle", 
            label = "Change Player Count", 
          },
      },
    
      job = {"all"},
      distance = 2.5
    })
  
    exports['lrp-target']:AddBoxZone("rc_soccer_entry_pad6", vector3(-1611.15, -1082.62, 13.32), 0.8, 0.6, {
      name="rc_soccer_entry_pad6",
      heading=320,
      -- debugPoly=true,
      minZ=13.12,
      maxZ=13.52,
    }, {
      options = {
          {
              event = "np-deanworld:rocketLeagueJoinGame",
              icon = "fas fa-play", 
              args = {
                id = 6,
                goalIndex = 3,
                ref = "north",
              },
              label = "Join game!", 
          },
          {
            event = "np-deanworld:rocketLeagueChangePlayers",
            icon = "fas fa-circle", 
            label = "Change Player Count", 
          },
      },
    
      job = {"all"},
      distance = 2.5
    })

  end)