# qb-ambulancejob
EMS Job and Death/Wound Logic for QB-Core Framework :ambulance:

# License

    QBCore Framework
    Copyright (C) 2021 Joshua Eger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>


# Required

--Target--




###### Garages ######

["boxzone12"] = {
    name = "pillboxgarage",
  coords = vector3(316.22, -577.91, 29.81),
    length = 9,
      width = 4.5,
      heading = 249.99,
      debugPoly = true,
      maxZ = 39.87834,
  options = {
          {
            type = "client",
            event = "putinjobvehicle",
            icon = "fas fa-car",
            label = "Put Away",
            job = 'ambulance'
          },
          {
            type = "client",
            event = "takeoutjobvehicle",
            icon = "fas fa-car",
            label = "Take Car Out",
            job = 'ambulance'
          },

      },
      distance = 4.5
  },
  ["boxzone13"] = {
    name = "pillboxgarage2",
  coords = vector3(317.82, -573.65, 28.8),
    length = 9,
      width = 4.5,
      heading = 249.99,
      debugPoly = true,
      maxZ = 39.87834,
  options = {
          {
            type = "client",
            event = "putinjobvehicle",
            icon = "fas fa-car",
            label = "Put Away",
            job = 'ambulance'
          },
          {
            type = "client",
            event = "takeoutjobvehicle",
            icon = "fas fa-car",
            label = "Take Car Out",
            job = 'ambulance'
          },

      },
      distance = 4.5
  },
  ["boxzone14"] = {
    name = "pillboxgarage3",
  coords = vector3(319.27, -569.39, 28.8),
    length = 9,
      width = 4.5,
      heading = 249.99,
      debugPoly = true,
      maxZ = 39.87834,
  options = {
          {
            type = "client",
            event = "putinjobvehicle",
            icon = "fas fa-car",
            label = "Put Away",
            job = 'ambulance'
          },
          {
            type = "client",
            event = "takeoutjobvehicle",
            icon = "fas fa-car",
            label = "Take Car Out",
            job = 'ambulance'
          },

      },
      distance = 4.5
  },
  ["boxzone15"] = {
    name = "pillboxgarage4",
  coords = vector3(320.84, -565.33, 28.8),
    length = 9,
      width = 4.5,
      heading = 249.99,
      debugPoly = true,
      maxZ = 39.87834,
  options = {
          {
            type = "client",
            event = "putinjobvehicle",
            icon = "fas fa-car",
            label = "Put Away",
            job = 'ambulance'
          },
          {
            type = "client",
            event = "takeoutjobvehicle",
            icon = "fas fa-car",
            label = "Take Car Out",
            job = 'ambulance'
          },

      },
      distance = 4.5
  },









###### elevator #######

["boxzone7"] = {
    name = "pillbox",
    coords = vector3(330.38, -601.2, 43.28),
    length = 1,
    width = 3,
    heading = 250,
    debugPoly = false,
    minZ = 41.28,
    maxZ = 44.59,
    options = {
        {
           type = "client",
           event = "qb-ambulancejob:job:openmenu",
           icon = "fas fa-",
           label = "Elevator",
        },
    },
    distance = 1.5
  },
  ["boxzone8"] = {
    name = "pillbox2",
    coords = vector3(344.39, -586.26, 28.8),
    length = 1,
    width = 3,
    heading = 250,
    debugPoly = false,
    minZ = 26.28,
    maxZ = 30,
    options = {
        {
           type = "client",
           event = "qb-ambulancejob:job:openmenu",
           icon = "fas fa-",
           label = "Elevator",
        },
    },
    distance = 1.5
  },
  ["boxzone9"] = {
    name = "pillbox3",
    coords = vector3(338.6, -583.83, 74.16),
    length = 1,
    width = 3,
    heading = 250,
    debugPoly = false,
    minZ = 72.28,
    maxZ = 75.46,
    options = {
        {
           type = "client",
           event = "qb-ambulancejob:job:openmenu",
           icon = "fas fa-",
           label = "Elevator",
        },
    },
    distance = 1.5
  },







##### Helicopter ######

Config.CircleZones = {
    ["circlezone1"] = {
    name = "pillboxheli",
    coords = vector3(351.71, -588.41, 74.16),
    radius = 7,
    debugPoly = false,
    options = {
        {
           type = "client",
           event = "qb-ambulancejob:job:spawnheli",
           icon = "fas fa-helicopter",
           label = "Spawn Heli",
           job = "ambulance",
        },
        {
          type = "client",
          event = "qb-ambulancejob:job:deleteheli",
          icon = "fas fa-helicopter",
          label = "Delete Heli",
          job = "ambulance",
       },
    },
    distance = 10
  },
}


##### Check in #####
["boxzone10"] = {
    name = "pillbox4",
    coords = vector3(312.43, -592.88, 43.28),
    length = 2,
    width = 2,
    heading = 250,
    debugPoly = true,
    minZ = 41.28,
    maxZ = 44.59,
    options = {
        {
           type = "client",
           event = "qb-ambulancejob:job:checkin",
           icon = "fas fa-notes-medical",
           label = "Check In",
        },
    },
    distance = 1.5
  },
  ["boxzone11"] = {
    name = "pillbox5",
    coords = vector3(307.05, -595.2, 43.28),
    length = 2,
    width = 2,
    heading = 250,
    debugPoly = true,
    minZ = 41.28,
    maxZ = 44.59,
    options = {
        {
           type = "client",
           event = "qb-ambulancejob:main:checkin",
           icon = "fas fa-notes-medical",
           label = "Check In",
        },
    },
    distance = 1.5
  },


#### Beds #####
Config.TargetModels = {
["PillboxBeds"] = {
  models = {
      `v_med_bed1`
  },
  options = {
      {
          type = "client",
          event = "qb-ambulancejob:main:lieonbed",
          icon = "fas fa-procedures",
          label = "Lie in Bed",
      },
  },
  distance = 2.0
},
}

Config.BoxZones = {
["boxzone16"] = {
    name = "pillboxsurgery",
    coords = vector3(321.15, -568.23, 44.26),
    length = 2,
    width = 2,
    heading = 250,
    debugPoly = true,
    minZ = 41.28,
    maxZ = 44.59,
    options = {
      {
        type = "client",
        event = "qb-ambulancejob:main:putplayeronsurgerybed",
        icon = "fas fa-procedures",
        label = "Place Player on Surgery bed",
        job = "ambulance",
     },
     {
       type = "client",
       event = "qb-ambulancejob:main:lieonsurgerybed",
       icon = "fas fa-procedures",
       label = "Lie on Surgery Bed",
    },
    },
    distance = 1.5
  },
  ["boxzone17"] = {
    name = "pillboxsurgery2",
    coords = vector3(326.82, -570.96, 44.23),
    length = 2,
    width = 2,
    heading = 250,
    debugPoly = true,
    minZ = 41.28,
    maxZ = 44.59,
    options = {
      {
        type = "client",
        event = "qb-ambulancejob:main:putplayeronsurgerybed",
        icon = "fas fa-procedures",
        label = "Place Player on Surgery bed",
        job = "ambulance",
     },
     {
       type = "client",
       event = "qb-ambulancejob:main:lieonsurgerybed",
       icon = "fas fa-procedures",
       label = "Lie on Surgery Bed",
    },
    },
    distance = 1.5
  },
  ["boxzone18"] = {
    name = "pillboxsurgery3",
    coords = vector3(315.34, -566.38, 44.26),
    length = 2,
    width = 2,
    heading = 250,
    debugPoly = true,
    minZ = 41.28,
    maxZ = 44.59,
    options = {
        {
           type = "client",
           event = "qb-ambulancejob:main:putplayeronsurgerybed",
           icon = "fas fa-procedures",
           label = "Place Player on Surgery bed",
           job = "ambulance",
        },
        {
          type = "client",
          event = "qb-ambulancejob:main:lieonsurgerybed",
          icon = "fas fa-procedures",
          label = "Lie on Surgery Bed",
       },
    },
    distance = 1.5
  },
}


#### On/Off Duty ####



["boxzone35"] = {
  name = "pillboxonoffduty",
  coords = vector3(310.53, -597.72, 43.28),
  length = 2,
  width = 1,
  heading = 250,
  debugPoly = false,
  minZ = 41.28,
  maxZ = 44.59,
  options = {
      {
         type = "client",
         event = "qb-ambulancejob:Client:SetDuty",
         icon = "fas fa-notes-medical",
         label = "On/Off Duty",
         job = "ambulance",
      },
  },
  distance = 1.5
},





--Clothing--