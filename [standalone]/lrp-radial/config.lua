local QBCore = exports['lrp-core']:GetCoreObject()
local isJudge = false
local isPolice = false
local isMedic = false
local isDoctor = false
local isNews = false
local isDead = false
local hasOxygenTankOn = false
local hasweed, hasmeth, hascoke = false, false, false
local drugs = {
    "cokebaggy",
    "meth",
    "weed_bag"
}
local vehiclelist = false
local parking = false
local jobvehiclelist = false
local jobparking = false
local personaljobparking = false
local gangvehiclelist = false
local gangparking = false
local inbennys = false
local isTuner = false
local isHarmony = false


--local isInstructorMode = false
--local myJob = "unemployed"
--local isHandcuffed = false
--local isHandcuffedAndWalking = false

--local TakenOut = false
--local NearGarage = false
--local gangNum = 0
--local cuffStates = {}

--[[
local bennyLocation = vector3(-34.24, -1053.31, 28.4)
local bennyLocationBridge = vector3(727.74, -1088.95, 22.17)
local billyLocationPaleto = vector3(110.8, 6626.46, 31.89)
local bennyLocationMRPD = vector3(450.01, -976.04, 25.03)
local bennyLocationSandyPD = vector3(1882.8, 3698.27, 33.54)
]]--

--local PlayerData = QBCore.Functions.GetPlayerData()



rootMenuConfig =  {

    --[[
    {
        id = "general",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
            return not isDead
        end,
        subMenus = {"general:escort",  "general:checkoverself", "general:emotes", "general:putinvehicle", "general:unseatnearest", "general:givecontact"}
    },
    ]]--

    {
        id = "Escort",
        displayName = "Escort",
        icon = "#general-escort",
        functionName = "police:client:EscortPlayer",
        enableMenu = function()
            local player, distance = QBCore.Functions.GetClosestPlayer()
            if player ~= -1 and distance < 2.5 and not IsPedInAnyVehicle(PlayerPedId(), false) then
                 return (not isDead)
            end
        end
    },

    {
        id = "Sling",
        displayName = "Sling",
        icon = "#cuffs-check-inventory",
        functionName = "qb-drugs:client:cornerselling",
        enableMenu = function()
            if hasweed or hascoke or hasmeth then
                PlayerData = QBCore.Functions.GetPlayerData()
                job  = PlayerData.job.name
                if job ~= "police" then
                    return (not isDead)
                end
            end
        end
    },


    -- public garage
    {
        id = "parkcar",
        displayName = "Park Vehicle",
        icon = "#parking",
        functionName = "qb-garages:client:putinvehicle",
        enableMenu = function()
            if parking then
                return (not isDead)
            end
        end
    },

    {
        id = "takeoutcar",
        displayName = "Vehicle List",
        icon = "#warehouse",
        functionName = "qb-garages:client:takeoutvehicle",
        enableMenu = function()
            if vehiclelist then
                return (not isDead)
            end
        end
    },

    -- job garage
    {
        id = "parkcar",
        displayName = "Park Personal Vehicle",
        icon = "#parking",
        functionName = "qb-garages:client:putinpersonaljobvehicle",
        enableMenu = function()
            if personaljobparking then
                return (not isDead)
            end
        end
    },
    
    {
        id = "parkcar",
        displayName = "Park Vehicle",
        icon = "#parking",
        functionName = "qb-garages:client:putinjobvehicle",
        enableMenu = function()
            if jobparking then
                return (not isDead)
            end
        end
    },

    {
        id = "takeoutcar",
        displayName = "Vehicle List",
        icon = "#warehouse",
        functionName = "qb-garages:client:takeoutjobvehicle",
        enableMenu = function()
            if jobvehiclelist then
                return (not isDead)
            end
        end
    },


    -- gang garage 

    {
        id = "parkcar",
        displayName = "Park Vehicle",
        icon = "#parking",
        functionName = "qb-garages:client:putingangvehicle",
        enableMenu = function()
            if gangparking then
                return (not isDead)
            end
        end
    },

    {
        id = "takeoutcar",
        displayName = "Vehicle List",
        icon = "#warehouse",
        functionName = "qb-garages:client:takeoutgangvehicle",
        enableMenu = function()
            if gangvehiclelist then
                return (not isDead)
            end
        end
    },




    {
        id = "Rob",
        displayName = "Rob",
        icon = "#cuffs-check-inventory",
        functionName = "police:client:RobPlayer",
        enableMenu = function()
            local player, distance = QBCore.Functions.GetClosestPlayer()
            if player ~= -1 and distance < 1 and not IsPedInAnyVehicle(PlayerPedId(), false) then
                 return (not isDead)
            end
        end
    },

    {
        id = "Emotes",
        displayName = "Emote",
        icon = "#general-emotes",
        functionName = "emotes:OpenMenu",
        enableMenu = function()
            return (not isDead)
        end
    },

    {
        id = "Examine",
        displayName = "Examine Self",
        icon = "#general-check-over-self",
        functionName = "qb-ambulancejob:job:statuscheck",
        enableMenu = function()
            return (not isDead)
        end
    },

    {
        id = "Contact",
        displayName = "Give Contact",
        icon = "#cuffs-check-phone",
        functionName = "qb-phone:client:GiveContactDetails",
        enableMenu = function()
            local player, distance = QBCore.Functions.GetClosestPlayer()
            if player ~= -1 and distance < 2.5 then
                 return (not isDead)
            end
        end
    },

    {
        id = "Seat",
        displayName = "Seat Nearest",
        icon = "#general-put-in-veh",
        functionName = "police:client:PutPlayerInVehicle",
        enableMenu = function()
            local vehicle, distance = QBCore.Functions.GetClosestVehicle()
            if DoesEntityExist(vehicle) and distance <= 2.5 and not IsPedInAnyVehicle(PlayerPedId(), false) then 
                return (not isDead)
            end
        end
    },

    {
        id = "Unseat",
        displayName = "Unseat Nearest",
        icon = "#general-unseat-nearest",
        functionName = "police:client:SetPlayerOutVehicle",
        enableMenu = function()
            local vehicle, distance = QBCore.Functions.GetClosestVehicle()
            if DoesEntityExist(vehicle) and distance <= 2.5 and not IsPedInAnyVehicle(PlayerPedId(), false) then 
                return (not isDead)
            end
        end
    },

    {
        id = "police-radio",
        displayName = "Radio",
        icon = "#police-action",
        enableMenu = function()
            return (isPolice and not isDead)
        end,
        subMenus = {"radio1", "radio2", "radio3", "radio4", "radio5", "radio6"}
    },

    {
        id = "police-action",
        displayName = "Police Actions",
        icon = "#police-action",
        enableMenu = function()
            return (isPolice and not isDead)
        end,
        subMenus = {"cuffs:checkinventory", "police:panic", "police:gsr"}
    },
    {
        id = "police-objects",
        displayName = "Objects",
        icon = "#police-action",
        enableMenu = function()
            return (isPolice and not isDead)
        end,
        subMenus = {"police:rembarrier", "police:cone", "police:tent", "police:speedlimit", "police:light"}
    },
    {
        id = "judge-actions",
        displayName = "Judge Actions",
        icon = "#judge-actions",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "police:cuff", "cuffs:uncuff", "general:escort", "police:frisk", "cuffs:checkinventory", "police:checkbank", "doj:mdt", "police:panic"}
    },
    {
        id = "judge-license",
        displayName = "Judge license",
        icon = "#license-general",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "license:grantWeapon", "license:removeweapons"}
    },
    {
        id = "police-vehicle",
        displayName = "Police Vehicle",
        icon = "#police-vehicle",
        enableMenu = function()
            return (isPolice and not isDead and IsPedInAnyVehicle(PlayerPedId(), false) and (GetVehicleClass(GetVehiclePedIsUsing(PlayerPedId())) == 18))
        end,
        subMenus = {"police:toggleradar", "police:lockedcompartment"}
    },
    {
        id = "policeDeadA",
        displayName = "10-13A",
        icon = "#police-dead",
        functionName = "un-dispatch:tenThirteenA",
        enableMenu = function()
            return (isPolice and isDead)
        end
    },
    {
        id = "policeDeadB",
        displayName = "10-13B",
        icon = "#police-dead",
        functionName = "un-dispatch:tenThirteenB",
        enableMenu = function()
            return (isPolice and isDead)
        end
    },
    {
        id = "emsDeadA",
        displayName = "10-14A",
        icon = "#ems-dead",
        functionName = "un-dispatch:tenFourteenA",
        enableMenu = function()
            return (isMedic and isDead)
        end
    },
    {
        id = "emsDeadB",
        displayName = "10-14B",
        icon = "#ems-dead",
        functionName = "un-dispatch:tenFourteenB",
        enableMenu = function()
            return (isMedic and isDead)
        end
    },
    {
        id = "AIEMS",
        displayName = "Call Local EMS",
        icon = "#ems-dead",
        functionName = "qb-medical:client:requestai",
        enableMenu = function()
            return (isDead)
        end
    },
    {
        id = "GeneralDead",
        displayName = "Call Help",
        icon = "#ems-dead",
        functionName = "un-dispatch:persondown",
        enableMenu = function()
            return (isDead)
        end
    },

    {
        id = "animations",
        displayName = "Walking Styles",
        icon = "#walking",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "animations:business", "animations:tipsy", "animations:injured","animations:tough", "animations:default", "animations:hobo", "animations:money", "animations:swagger", "animations:shady", "animations:maneater", "animations:chichi", "animations:sassy", "animations:sad", "animations:posh", "animations:alien",
        
        --new
        "animations:arrogant","animations:casual","animations:casual2","animations:casual3","animations:casual4","animations:casual5","animations:casual6","animations:confident","animations:business2","animations:business3","animations:femme","animations:flee","animations:gangster","animations:gangster2","animations:gangster3","animations:gangster4","animations:gangster5","animations:heels","animations:heels2","animations:muscle","animations:wide","animations:scared", }
    },

    {
        id = "expressions",
        displayName = "Expressions",
        icon = "#expressions",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    },
    {
        id = "cuff",
        displayName = "Cuff Actions",
        icon = "#cuffs",
        enableMenu = function()
            return (not isDead and isPolice)
        end,
        subMenus = { "cuffs:uncuff", "cuffs:cuff"}
    },
    {
        id = "medic",
        displayName = "Medical",
        icon = "#medic",
        enableMenu = function()
            return (not isDead and isMedic)
        end,
        subMenus = {"medic:revive", "medic:heal", "general:escort", "general:putinvehicle", "general:unseatnearest", "medic:stomachpump" }
    },
     {
         id = "news",
         displayName = "News",
         icon = "#news",
         enableMenu = function()
             return (not isDead and isNews)
         end,
         subMenus = { "news:setCamera", "news:setMicrophone", "news:setBoom" }
     },
    {
        id = "vehicle",
        displayName = "Vehicle",
        icon = "#vehicle-options-vehicle",
        functionName = "veh:options",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
        end
    }, 
    {
        id = "oxygentank",
        displayName = "Remove Oxygen Tank",
        icon = "#oxygen-mask",
        functionName = "RemoveOxyTank",
        enableMenu = function()
            return not isDead and hasOxygenTankOn
        end
    },

    --[[
    {
        id = "open-garage",
        displayName = "Open Garage",
        icon = "#warehouse",
        functionName = "iconic-garages:open",
        enableMenu = function()
            if isAtGarage and not exports['ragdoll']:GetDeathStatus() then
                return true
            end
            return false
        end
    },

    {
        id = "park-vehicle-garage",
        displayName = "Park",
        icon = "#parking",
        functionName = "iconic-garages:store",
        enableMenu = function()
            if isAtGarage and exports["mechanic"]:NearVehicle("Distance") and not exports['ragdoll']:GetDeathStatus() then
                return true
            end
            return false
        end
    },

    {
        id = "open-garage-housing",
        displayName = "Open Garage",
        icon = "#warehouse",
        functionName = "iconic-garages:open",
        enableMenu = function()
            if pHouseGarages ~= nil then
                if #(vector3(pHouseGarages.x,pHouseGarages.y,pHouseGarages.z) - GetEntityCoords(PlayerPedId())) < 5.0 and not isDead and not IsPedInAnyVehicle(PlayerPedId(), false) and isAtHouseGarage then
                    return true
                end
            end
            return false
        end
    },

    {
        id = "park-vehicle-garage-housing",
        displayName = "Park",
        icon = "#parking",
        functionName = "iconic-garages:store",
        enableMenu = function()
            if pHouseGarages ~= nil then
                if #(vector3(pHouseGarages.x,pHouseGarages.y,pHouseGarages.z)  - GetEntityCoords(PlayerPedId())) < 3.0 and not isDead and not IsPedInAnyVehicle(PlayerPedId(), false) and exports["mechanic"]:NearVehicle("Distance") and not exports['ragdoll']:GetDeathStatus() and isAtHouseGarage then
                    return true
                end
            end
            return false
        end
    },
    ]]--


    {
        id = "benny:enter1",
        displayName = "Enter Benny's",
        icon = "#general-check-vehicle",
        functionName = "bennys:enter",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and inbennys)
        end,
    },

    --[[
    {
        id = "benny:enter2",
        displayName = "Enter Benny's",
        icon = "#general-check-vehicle",
        functionName = "enter:benny:bridge",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennyLocationBridge) <= 10)
        end,
    },
    {
        id = "benny:enter3",
        displayName = "Enter Benny's",
        icon = "#general-check-vehicle",
        functionName = "enter:benny:paleto",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - billyLocationPaleto) <= 10)
        end,
    },
    {
        id = "benny:enter4",
        displayName = "Enter Benny's",
        icon = "#general-check-vehicle",
        functionName = "enter:benny:mrpd",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennyLocationMRPD) <= 10)
        end,
    },

    {
        id = "benny:enter5",
        displayName = "Enter Benny's",
        icon = "#general-check-vehicle",
        functionName = "enter:benny:sandypd",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennyLocationSandyPD) <= 10)
        end,
    },
    ]]--

    {
        id = "mdt",
        displayName = "MDT",
        icon = "#mdt",
        functionName = "mdtopen:radialc",
        enableMenu = function()
            return ((isPolice or isMedic)and not isDead)
        end
    }
}

newSubMenus = {
    -- ['open:garage'] = {
    --     title = "Open Garage",
    --     icon = "#warehouse",
    --     functionName = "garages:open"
    -- },
    -- ['park:vehicle'] = {
    --     title = "Park Vehicle",
    --     icon = "#warehouse",
    --     functionName = "garages:StoreVehicle"
    -- },

    ['general:emotes'] = {
        title = "Emotes",
        icon = "#general-emotes",
        functionName = "emotes:OpenMenu"
    },    

    ['general:checkoverself'] = {
        title = "Examine Self",
        icon = "#general-check-over-self",
        functionName = "qb-ambulancejob:job:statuscheck"
    },
    ['general:checkvehicle'] = {
        title = "Examine Vehicle",
        icon = "#general-check-vehicle",
        functionName = "veh:requestUpdate"
    },
    ['general:escort'] = {
        title = "Escort",
        icon = "#general-escort",
        functionName = "police:client:EscortPlayer"
    },
    ['general:givecontact'] = {
        title = "Give Contact Info",
        icon = "#cuffs-check-phone",
        functionName = "qb-phone:client:GiveContactDetails"
    },
    ['general:putinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:client:PutPlayerInVehicle"
    },
    ['general:unseatnearest'] = {
        title = "Unseat Nearest",
        icon = "#general-unseat-nearest",
        functionName = "police:client:SetPlayerOutVehicle"
    },    
    ['general:flipvehicle'] = {
        title = "Flip Vehicle",
        icon = "#general-flip-vehicle",
        functionName = "FlipVehicle"
    },
    ['animations:joy'] = {
        title = "Joy",
        icon = "#animation-joy",
        functionName = "AnimSet:Joy"
    },
    ['animations:sexy'] = {
        title = "Sexy",
        icon = "#animation-sexy",
        functionName = "AnimSet:Sexy"
    },
    ['animations:moon'] = {
        title = "Moon",
        icon = "#animation-moon",
        functionName = "AnimSet:Moon"
    },
    ['animations:tired'] = {
        title = "Tired",
        icon = "#animation-tired",
        functionName = "AnimSet:Tired"
    },
    ['animations:arrogant'] = {
        title = "Arrogant",
        icon = "#animation-arrogant",
        functionName = "AnimSet:Arrogant"
    },
    
    ['animations:casual'] = {
        title = "Casual",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual"
    },
    ['animations:casual2'] = {
        title = "Casual 2",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual2"
    },
    ['animations:casual3'] = {
        title = "Casual 3",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual3"
    },
    ['animations:casual4'] = {
        title = "Casual 4",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual4"
    },
    ['animations:casual5'] = {
        title = "Casual 5",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual5"
    },
    ['animations:casual6'] = {
        title = "Casual 6",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual6"
    },
    ['animations:confident'] = {
        title = "Confident",
        icon = "#animation-confident",
        functionName = "AnimSet:Confident"
    },
    
    ['animations:business2'] = {
        title = "Business 2",
        icon = "#animation-business",
        functionName = "AnimSet:Business2"
    },
    ['animations:business3'] = {
        title = "Business 3",
        icon = "#animation-business",
        functionName = "AnimSet:Business3"
    },
    
    ['animations:femme'] = {
        title = "Femme",
        icon = "#animation-female",
        functionName = "AnimSet:Femme"
    },
    ['animations:flee'] = {
        title = "Flee",
        icon = "#animation-flee",
        functionName = "AnimSet:Flee"
    },
    ['animations:gangster'] = {
        title = "Gangster",
        icon = "#animation-gangster",
        functionName = "AnimSet:Gangster"
    },
    ['animations:gangster2'] = {
        title = "Gangster 2",
        icon = "#animation-gangster",
        functionName = "AnimSet:Gangster2"
    },
    ['animations:gangster3'] = {
        title = "Gangster 3",
        icon = "#animation-gangster",
        functionName = "AnimSet:Gangster3"
    },
    ['animations:gangster4'] = {
        title = "Gangster 4",
        icon = "#animation-gangster",
        functionName = "AnimSet:Gangster4"
    },
    ['animations:gangster5'] = {
        title = "Gangster 5",
        icon = "#animation-gangster",
        functionName = "AnimSet:Gangster5"
    },
    
    ['animations:heels'] = {
        title = "Heels",
        icon = "#animation-female",
        functionName = "AnimSet:Heels"
    },
    ['animations:heels2'] = {
        title = "Heels 2",
        icon = "#animation-female",
        functionName = "AnimSet:Heels2"
    },
    
    ['animations:hipster'] = {
        title = "Hipster",
        icon = "#animation-hipster",
        functionName = "AnimSet:Hipster"
    },
    ['animations:hiking'] = {
        title = "Hiking",
        icon = "#animation-hiking",
        functionName = "AnimSet:Hiking"
    },
    
    ['animations:jog'] = {
        title = "Jog",
        icon = "#animation-jog",
        functionName = "AnimSet:Jog"
    },
    
    ['animations:muscle'] = {
        title = "Muscle",
        icon = "#animation-tough",
        functionName = "AnimSet:Muscle"
    },
    
    -- ['animations:quick'] = {
    --     title = "Quick",
    --     icon = "#animation-quick",
    --     functionName = "AnimSet:Quick"
    -- },
    ['animations:wide'] = {
        title = "Wide",
        icon = "#animation-wide",
        functionName = "AnimSet:Wide"
    },
    ['animations:scared'] = {
        title = "Scared",
        icon = "#animation-scared",
        functionName = "AnimSet:Scared"
    },
    ['animations:guard'] = {
        title = "Guard",
        icon = "#animation-guard",
        functionName = "AnimSet:Guard"
    },
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },
    -- ['animations:hurry'] = {
    --     title = "Hurry",
    --     icon = "#animation-hurry",
    --     functionName = "AnimSet:Hurry"
    -- },
    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },
    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },
    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },
    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },
    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },
    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },
    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },
    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },
    ['animations:nonchalant'] =
    {
        title = "Nonchalant",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },
    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },
    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },
    ['animations:swagger'] = {
        title = "Swagger",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },
    ['animations:shady'] = {
        title = "Shady",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },
    ['animations:maneater'] = {
        title = "Man Eater",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },
    ['animations:chichi'] = {
        title = "ChiChi",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },
    ['animations:default'] = {
        title = "Default",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },
    ['cuffs:cuff'] = {
        title = "Hard Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:client:CuffPlayerHardPD"
    },
    ['cuffs:uncuff'] = {
        title = "Soft Cuff",
        icon = "#cuffs-uncuff",
        functionName = "police:client:CuffPlayerSoft"
    },
    ['cuffs:checkinventory'] = {
        title = "Search Person",
        icon = "#cuffs-check-inventory",
        functionName = "police:client:SearchPlayer"
    },
    ['cuffs:unseat'] = {
        title = "Unseat",
        icon = "#cuffs-unseat-player",
        functionName = "unseatPlayerCiv"
    },
    ['medic:revive'] = {
        title = "Revive",
        icon = "#medic-revive",
        functionName = "hospital:client:RevivePlayer"
    },

    ['medic:heal'] = {
        title = "Heal",
        icon = "#medic-heal",
        functionName = "hospital:client:TreatWounds"
    },
    ['medic:stomachpump'] = {
        title = "Check Status",
        icon = "#medic-stomachpump",
        functionName = "hospital:client:CheckStatus"
    },
    ['police:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:cuffFromMenu"
    },

    ['police:gsr'] = {
        title = "GSR Test",
        icon = "#police-action-gsr",
        functionName = "police:client:CheckStatus"
    },

    ['police:panic'] = {
        title = "Seize Cash",
        icon = "#police-action-panic",
        functionName = "police:client:SeizeCash"
    },

    ['police:cone'] = {
        title = "Place Cones",
        icon = "#police-cone",
        functionName = "police:client:spawnCone"
    },

    ['police:barrier'] = {
        title = "Place Barrier",
        icon = "#police-cone",
        functionName = "police:client:spawnBarier"
    },

    ['police:tent'] = {
        title = "Place Tent",
        icon = "#police-cone",
        functionName = "police:client:spawnTent"
    },

    ['police:speedlimit'] = {
        title = "Place Speedlimit Sign",
        icon = "#police-cone",
        functionName = "police:client:spawnSchotten"
    },

    ['radio1'] = {
        title = "Channel 1",
        icon = "#police-vehicle-radar",
        functionName = "qb-radio:client:JoinRadioChannel1"
    },
    ['radio2'] = {
        title = "Channel 2",
        icon = "#police-vehicle-radar",
        functionName = "qb-radio:client:JoinRadioChannel2"
    },
    ['radio3'] = {
        title = "Channel 3",
        icon = "#police-vehicle-radar",
        functionName = "qb-radio:client:JoinRadioChannel3"
    },
    ['radio4'] = {
        title = "Channel 4",
        icon = "#police-vehicle-radar",
        functionName = "qb-radio:client:JoinRadioChannel4"
    },
    ['radio5'] = {
        title = "Channel 5",
        icon = "#police-vehicle-radar",
        functionName = "qb-radio:client:JoinRadioChannel5"
    },
    ['radio6'] = {
        title = "Channel 6",
        icon = "#police-vehicle-radar",
        functionName = "qb-radio:client:JoinRadioChannel6"
    },

    ['police:light'] = {
        title = "Place Light",
        icon = "#police-cone",
        functionName = "police:client:spawnLight"
    },

    ['police:rembarrier'] = {
        title = "Remove Barriers",
        icon = "#vehicle-options",
        functionName = "police:client:deleteObject"
    },

    ['police:toggleradar'] = {
        title = "Toggle Radar",
        icon = "#police-vehicle-radar",
        functionName = "startSpeedo"
    },
    ['police:lockedcompartment'] = {
        title = "Open Compartment",
        icon = "#impound-vehicle",
        functionName = "police:client:riflerack"
    },
    ['police:runplate'] = {
        title = "Run Plate",
        icon = "#police-vehicle-plate",
        functionName = "clientcheckLicensePlate"
    },
    ['news:setCamera'] = {
        title = "Camera",
        icon = "#news-job-news-camera",
        functionName = "camera:setCamera"
    },
    ['news:setMicrophone'] = {
        title = "Microphone",
        icon = "#news-job-news-microphone",
        functionName = "camera:setMic"
    },
    ['news:setBoom'] = {
        title = "Microphone Boom",
        icon = "#news-job-news-boom",
        functionName = "camera:setBoom"
    },
    ['weed:currentStatusServer'] = {
        title = "Request Status",
        icon = "#weed-cultivation-request-status",
        functionName = "weed:currentStatusServer"
    },   
    ['weed:weedCrate'] = {
        title = "Remove A Crate",
        icon = "#weed-cultivation-remove-a-crate",
        functionName = "weed:weedCrate"
    },
    ['cocaine:currentStatusServer'] = {
        title = "Request Status",
        icon = "#meth-manufacturing-request-status",
        functionName = "cocaine:currentStatusServer"
    },
    ['cocaine:methCrate'] = {
        title = "Remove A Crate",
        icon = "#meth-manufacturing-remove-a-crate",
        functionName = "cocaine:methCrate"
    },
    ["expressions:angry"] = {
        title="Angry",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },
    ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },
    ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },
    ["expressions:electrocuted"] = {
        title="Electrocuted",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },
    ["expressions:grumpy"] = {
        title="Grumpy",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },
    ["expressions:happy"] = {
        title="Happy",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },
    ["expressions:injured"] = {
        title="Injured",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },
    ["expressions:joyful"] = {
        title="Joyful",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },
    ["expressions:mouthbreather"] = {
        title="Mouthbreather",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },
    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },
    ["expressions:oneeye"]  = {
        title="One Eye",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },
    ["expressions:shocked"]  = {
        title="Shocked",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },
    ["expressions:sleeping"]  = {
        title="Sleeping",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },
    ["expressions:smug"]  = {
        title="Smug",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },
    ["expressions:speculative"]  = {
        title="Speculative",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },
    ["expressions:stressed"]  = {
        title="Stressed",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },
    ["expressions:sulking"]  = {
        title="Sulking",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },
    ["expressions:weird"]  = {
        title="Weird",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },
    ["expressions:weird2"]  = {
        title="Weird 2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
    },

    ['doj:mdt'] = {
        title = "MDT",
        icon = "#mdt",
        functionName = "mdtopen:radialc"
    },
}

--[[
RegisterNetEvent("menu:setCuffState")
AddEventHandler("menu:setCuffState", function(pTargetId, pState)
    cuffStates[pTargetId] = pState
end)


RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)
]]--

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    job  = PlayerData.job.name
    duty = PlayerData.job.onduty
    if isMedic and job ~= "ambulance" and duty then isMedic = false end
    if isPolice and job ~= "police" and duty then isPolice = false end
    if isJudge and job ~= "judge" and duty then isJudge = false end
    if isDoctor and job ~= "doctor" and duty then isDoctor = false end
    if isNews and job ~= "news" and duty then isNews = false end
    if job == "police" and duty then isPolice = true end
    if job == "ambulance" and duty then isMedic = true end
    if job == "news" and duty then isNews = true end
    if job == "doctor" and duty then isDoctor = true end
    if job == "judge" and duty then isJudge = true end
    myJob = job
    
    CreateThread(function()
        while true do
    
        Wait(1000)
            
        local PlayerData = QBCore.Functions.GetPlayerData()
    
        if PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"] or IsEntityDead(PlayerPedId()) then
            isDead = true
        else
            isDead = false
        end
    
        end
    end)
    
    CreateThread(function()
        while true do
                
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
            if result then
                hasweed = true
            else
                hasweed = false
            end
        end, drugs[1])
    
        Wait(2500)
        
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
            if result then
                hasmeth = true
            else
                hasmeth = false
            end
        end, drugs[2])
    
        Wait(2500)
    
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
            if result then
                hascoke = true
            else
                hascoke = false
            end
        end, drugs[3])
    
        Wait(2500)
    
        end
    end)
    
end)



RegisterNetEvent('QBCore:Client:SetDuty', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    job  = PlayerData.job.name
    duty = PlayerData.job.onduty
    if isMedic and job ~= "ambulance" and duty then isMedic = false end
    if isPolice and job ~= "police" and duty then isPolice = false end
    if isJudge and job ~= "judge" and duty then isJudge = false end
    if isDoctor and job ~= "doctor" and duty then isDoctor = false end
    if isNews and job ~= "news" and duty then isNews = false end
    if isTuner and job ~= "tunershop" and duty then isTuner = false end
    if isHarmony and job ~= "harmony" and duty then isHarmony = false end
    if job == "police" and duty then isPolice = true end
    if job == "ambulance" and duty then isMedic = true end
    if job == "news" and duty then isNews = true end
    if job == "doctor" and duty then isDoctor = true end
    if job == "judge" and duty then isJudge = true end
    if job == "tunershop" and duty then isTuner = true end
    if job == "harmony" and duty then isHarmony = true end
    myJob = job
end)


RegisterNetEvent('QBCore:Client:OnJobUpdate', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    job  = PlayerData.job.name
    duty = PlayerData.job.onduty

    if isMedic and job ~= "ambulance" and duty then isMedic = false end
    if isPolice and job ~= "police" and duty then isPolice = false end
    if isJudge and job ~= "judge" and duty then isJudge = false end
    if isDoctor and job ~= "doctor" and duty then isDoctor = false end
    if isNews and job ~= "news" and duty then isNews = false end
    if isTuner and job ~= "tunershop" and duty then isTuner = false end
    if isHarmony and job ~= "harmony" and duty then isHarmony = false end
    if job == "police" and duty then isPolice = true end
    if job == "ambulance" and duty then isMedic = true end
    if job == "news" and duty then isNews = true end
    if job == "doctor" and duty then isDoctor = true end
    if job == "judge" and duty then isJudge = true end
    if job == "tunershop" and duty then isTuner = true end
    if job == "harmony" and duty then isHarmony = true end
    myJob = job
end)

--[[
RegisterNetEvent("police:currentHandCuffedState")
AddEventHandler("police:currentHandCuffedState", function(pIsHandcuffed, pIsHandcuffedAndWalking)
    isHandcuffedAndWalking = pIsHandcuffedAndWalking
    isHandcuffed = pIsHandcuffed
end)
]]--

--[[
RegisterNetEvent("menu:hasOxygenTank")
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)
]]--

--[[
RegisterNetEvent('enablegangmember')
AddEventHandler('enablegangmember', function(pGangNum)
    gangNum = pGangNum
end)
]]--

--[[
RegisterNetEvent("makenews")
AddEventHandler("makenews", function()
    isNews = true
end)
]]--

--- Garage Shit ---

--[[
local approvedGarages = {
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "Richman",
    "casino",
    "Repo",
    "Impound Lot",
    "Perro",
    "Police Department",
    "Pillbox",
    "Harmony",
    "Winery",
}

local pCurrentGarage = "None"
]]--

--replace with polyzonehelper
--[[
function polyZoneEnter(zoneName, zoneData)
    currentZone = zoneName
    for k, v in pairs (approvedGarages) do
        if zoneName == v then
            pCurrentGarage = zoneName
            isAtGarage = true
        end
    end
end

function polyZoneExit(zoneName)
    if currentZone == zoneName then
        isAtGarage = false
        pCurrentGarage = "None"
    end
end

exports("currentGarage", function()
    if isAtGarage then
        return pCurrentGarage
    elseif isAtHouseGarage then
        return pHouseNameGarage
    end
end)

exports("houseGarageCoords", function()
    return pHouseGarages
end)

exports("NearHouseGarage", function()
    return isAtHouseGarage
end)

RegisterNetEvent("menu:send:house:garages", function(pCoords, pGarageName)
    pHouseGarages = pCoords
    isAtHouseGarage = true
    pHouseNameGarage = pGarageName
end)

RegisterNetEvent("menu:housing", function(pState)
    isAtHouseGarage = pState
end)


AddEventHandler('iconic-polyzone:entered:garages', polyZoneEnter)
AddEventHandler('iconic-polyzone:exited:garages', polyZoneExit)
]]--



-- public garage

RegisterNetEvent('qb-radial:client:vehiclelist', function(type)
    vehiclelist = type
end)

RegisterNetEvent('qb-radial:client:parking', function(type)
    parking = type
end)

RegisterNetEvent('qb-radial:client:outgarage', function()
    vehiclelist = false
    parking = false
end)






-- job garage


RegisterNetEvent('qb-radial:client:jobvehiclelist', function(type)
    jobvehiclelist = type
end)

RegisterNetEvent('qb-radial:client:jobparking', function(type)
    jobparking = type
end)

RegisterNetEvent('qb-radial:client:personaljobparking', function(type)
    personaljobparking = type
end)

RegisterNetEvent('qb-radial:client:joboutgarage', function()
    jobvehiclelist = false
    jobparking = false
    personaljobparking = false
end)




-- gang garage


RegisterNetEvent('qb-radial:client:gangvehiclelist', function(type)
    gangvehiclelist = type
end)

RegisterNetEvent('qb-radial:client:gangparking', function(type)
    gangparking = type
end)

RegisterNetEvent('qb-radial:client:gangoutgarage', function()
    gangvehiclelist = false
    gangparking = false
end)

-- bennys wicked
Citizen.CreateThread(function()
    exports["polyzonehelper"]:AddBoxZone("bennysPD", vector3(452.12, -975.34, 25.7), 5.4, 13.2, {
      minZ = 24.7,
      maxZ = 27.7,
    }) -- MRPD
   
    -- exports["polyzonehelper"]:AddBoxZone("bennys", vector3(-34.12, -1054.31, 28.4), 6.0, 12.4, {
    --   minZ = 27.4,
    --   maxZ = 33.0,
    --   heading = 312,
    -- }) -- Hub
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(-211.5, -1324.55, 30.37), 7.4, 8, {
        minZ = 30.0,
        maxZ = 36.0,
        heading = 44.0,
      }) -- Paleto
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(110.8, 6626.46, 31.89), 7.4, 8, {
      minZ = 30.0,
      maxZ = 36.0,
      heading = 44.0,
    }) -- Paleto
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(-458.6, 5980.71, 31.33), 9.8, 5.4, {
      heading=314,
      minZ=29.93,
      maxZ=33.33,
    }) -- Paleto PD
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(-809.83, -1507.21, 14.4), 14.2, 13.4, {
      minZ = -0.4,
      maxZ = 6.8,
      heading = 291,
      data = { type = "boats" },
    }) -- Boats
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(-1652.52, -3143.0, 13.99), 10, 10, {
      minZ = 12.99,
      maxZ = 16.99,
      heading = 240,
      data = { type = "planes" },
    }) -- Planes
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(2522.64, 2621.78, 37.96), 7.4, 5.8, {
      minZ = 36.96,
      maxZ = 39.96,
      heading = 270,
    }) -- Rex
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(340.39, -570.6, 28.8), 8.4, 4.4, {
      minZ=27.8,
      maxZ=31.8,
      heading = 340,
    }) -- Pillbox
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(-1818.56, 2966.05, 32.81), 14.6, 15.6, {
      minZ=31.61,
      maxZ=35.61,
      heading = 330,
      data = { type = "planes" },
    }) 
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(-1117.81, -826.58, 3.75), 6.25, 4.0, {
      minZ=2.75,
      maxZ=5.95,
      heading = 36
    })
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(1865.55, 3700.5, 33.37), 13.4, 8, {
      heading=30,
      minZ=32.37,
      maxZ=37.57
    })
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(145.01, -3030.59, 7.04), 6.8, 4.4, {
      heading=0,
      minZ=6.04,
      maxZ=9.24
    })
    --pdm preview bennys
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(-33.2, -1053.37, 28.4), 8.0, 9.4, {
      heading=340,
      minZ=25.72,
      maxZ=29.52
    })

    -- tuner catalog
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(135.88, -3030.43, 7.04), 6.4, 4.0, {
      heading = 0,
      minZ = 6.04,
      maxZ = 9.04
    })

    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(124.54, -3047.26, 7.04), 6.4, 4.0, {
      heading = 90,
      minZ = 6.04,
      maxZ = 9.04
    })

    -- Park Rangers PD
    exports["polyzonehelper"]:AddBoxZone("bennysPD", vector3(373.04, 787.57, 186.81), 6.8, 4.6, {
      heading=0,
      minZ=185.31,
      maxZ=189.91
    })

    -- Bogg Bikes
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(-1114.66, -1686.83, 4.37), 5.0, 4.2, {
      heading=35,
      minZ=3.17,
      maxZ=6.57
    })

    -- Davis PD
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(378.69, -1626.95, 28.77), 8.4, 6.4, {
      heading=139,
      minZ=27.97,
      maxZ=31.97
    })

    -- Harmony Repairs
    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(1174.42, 2641.53, 36.93), 7.5, 5.5, {
        heading=180,
        minZ=36.5,
        maxZ=40.0,
      })

    exports["polyzonehelper"]:AddBoxZone("bennys", vector3(1181.89, 2640.92, 36.93), 7.5, 5.5, {
        heading=180,
        minZ=36.5,
        maxZ=40.0,
      })

    -- Flight school
    -- disabled the below in favor of civ hub
    -- exports["polyzonehelper"]:AddBoxZone("bennys", vector3(-211.88, -1323.91, 30.89), 8.4, 6.6, {minZ=29.0, maxZ=35.0}) -- pdm
    -- exports["polyzonehelper"]:AddBoxZone("bennys", vector3(731.57, -1088.78, 22.17), 5.0, 11.2, {minZ=21.0, maxZ=28.0}) -- bridge
    -- exports["polyzonehelper"]:AddBoxZone("bennys", vector3(938.14, -970.93, 39.51), 6, 8, {minZ=37.0, maxZ=43.0}) -- tuner
    -- exports["polyzonehelper"]:AddBoxZone("bennys", vector3(-771.46, -233.66, 37.08), 7.4, 8, {minZ=36.0, maxZ=42.0}) -- import
end)

AddEventHandler("polyzonehelper:enter", function(zone, data)
    print("yo")
    print(isHarmony)
    if zone == "bennys" and (isTuner or isHarmony) then 
        local plyPed = PlayerPedId()
        local plyVeh = GetVehiclePedIsIn(plyPed, false)

        if plyVeh ~= 0 and GetPedInVehicleSeat(plyVeh, -1) == plyPed then
            inbennys = true
            exports['textUi']:DrawTextUi('show', "Bennys")  
        end
    elseif zone == "bennysPD" and isPolice then
        local plyPed = PlayerPedId()
        local plyVeh = GetVehiclePedIsIn(plyPed, false)
        if plyVeh ~= 0 and GetPedInVehicleSeat(plyVeh, -1) == plyPed then
            inbennys = true
            exports['textUi']:DrawTextUi('show', "Bennys")
        end
    end
end)

AddEventHandler("polyzonehelper:exit", function(zone)
    if zone == "bennys" or zone == "tunershop" or zone == "bennysPD" then 
        inbennys = false
        exports['textUi']:HideTextUi('hide')
    end
end)