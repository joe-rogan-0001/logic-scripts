QBCore = exports['lrp-core']:GetCoreObject()

-------------
-- Variables --
-------------
local src = source
local CurrentTest = nil
local LastCheckPoint = -1
local CurrentCheckPoint = 0
local CurrentZoneType   = nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    Player = QBCore.Functions.GetPlayerData()
end)

-- Opens qb-menu to select dmv options
function OpenMenu()
    exports['lrp-menu']:openMenu({
      {
        header = "DMV School",
        isMenuHeader = true,
      },
      {
        header = "Start Theoretical Test",
        txt = "$"..Config.Amount['theoretical'].."",
        params = {
          event = 'qb-dmv:startquiz',
          args = {
            CurrentTest = 'theory'
          }
        }
      }
    })
end

function OpenMenu2()
  exports['lrp-menu']:openMenu({
    {
      header = "DMV School",
      isMenuHeader = true,
    },
    {
      header = "Start Driving Test",
      txt = "$"..Config.Amount['driving'].."",
      params = {
        event = 'qb-dmv:startdriver',
        args = {
          CurrentTest = 'drive'
        }
      }
    },
    {
      header = "Start CDL Drving Test",
      txt = "$"..Config.Amount['cdl'].."",
      params = {
        event = 'qb-dmv:startcdl'
      }
    }
  })
end



function OpenMenuDriving()
  exports['lrp-menu']:openMenu({
    {
      header = "DMV School",
      isMenuHeader = true,
    },
    {
      header = "Start Driving Test",
      txt = "$"..Config.Amount['driving'].."",
      params = {
        event = 'qb-dmv:startdriver',
        args = {
          CurrentTest = 'drive'
        }
      }
    },
  })
end



function OpenMenuCDL()
  exports['lrp-menu']:openMenu({
    {
      header = "DMV School",
      isMenuHeader = true,
    },
    {
      header = "Start CDL Drving Test",
      txt = "$"..Config.Amount['cdl'].."",
      params = {
        event = 'qb-dmv:startcdl'
      }
    }
  })
end





-- Event to put in qb-menu to start driving test
RegisterNetEvent('qb-dmv:startdriver', function()
        CurrentTest = 'drive'
        DriveErrors = 0
        LastCheckPoint = -1
        CurrentCheckPoint = 0
        IsAboveSpeedLimit = false
        CurrentZoneType = 'residence'
        local prevCoords = GetEntityCoords(PlayerPedId())
        QBCore.Functions.SpawnVehicle(Config.VehicleModels.driver, function(veh)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            exports['lj-fuel']:SetFuel(veh, 100)
            SetVehicleNumberPlateText(veh, 'DMV')
            SetEntityAsMissionEntity(veh, true, true)
            SetEntityHeading(veh, Config.Location['spawn'].w)
            TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
            TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', QBCore.Functions.GetVehicleProperties(veh))
            LastVehicleHealth = GetVehicleBodyHealth(veh)
            CurrentVehicle = veh
            QBCore.Functions.Notify('You are taking the Driving test')
        end, Config.Location['spawn'], false)
end)


-- Event to put in qb-menu to start cdl test
RegisterNetEvent('qb-dmv:startcdl', function()
  CurrentTest = 'cdl'
  DriveErrors = 0
  LastCheckPoint = -1
  CurrentCheckPoint = 0
  IsAboveSpeedLimit = false
  CurrentZoneType = 'residence'
  local prevCoords = GetEntityCoords(PlayerPedId())
  QBCore.Functions.SpawnVehicle(Config.VehicleModels.cdl, function(veh)
      TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
      exports['lj-fuel']:SetFuel(veh, 100)
      SetVehicleNumberPlateText(veh, 'DMV')
      SetEntityAsMissionEntity(veh, true, true)
      SetEntityHeading(veh, Config.Location['spawn'].w)
      TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
      TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', QBCore.Functions.GetVehicleProperties(veh))
      LastVehicleHealth = GetVehicleBodyHealth(veh)
      CurrentVehicle = veh
      QBCore.Functions.Notify('You are taking the CDL test')
  end, Config.Location['spawn'], false)
end)


-- Event for qb-menu to run to start quiz
RegisterNetEvent('qb-dmv:startquiz')
AddEventHandler('qb-dmv:startquiz', function ()
    CurrentTest = 'theory'
    SendNUIMessage({
      Wait(10),
      openQuestion = true
    })

    SetTimeout(200, function ()
        SetNuiFocus(true, true)
    end)

end)

-- When stopping/finishing theoritical test
function StopTheoryTest(success) 
    CurrentTest = nil
    SendNUIMessage({
      openQuestion = false
    })
    SetNuiFocus(false)
    if success then
      QBCore.Functions.Notify('You passed your test!', 'success')
      TriggerServerEvent('qb-dmv:theorypaymentpassed')
    else
      QBCore.Functions.Notify('You failed the test!', 'error')
      TriggerServerEvent('qb-dmv:theorypaymentfailed')
    end
end

--Stop Drive Test
function StopDriveTest(success)
  local playerPed = PlayerPedId()
  local veh = GetVehiclePedIsIn(playerPed)
  if CurrentTest == 'drive' then
    if success then
      TriggerServerEvent('qb-dmv:driverpaymentpassed')
      QBCore.Functions.Notify('You passed the Drving Test!')
      QBCore.Functions.DeleteVehicle(veh)
      CurrentTest = nil
    elseif success == false then
      TriggerServerEvent('qb-dmv:driverpaymentfailed')
      QBCore.Functions.Notify('You Failed the Driving Test!')
      CurrentTest = nil
      RemoveBlip(CurrentBlip)
      QBCore.Functions.DeleteVehicle(veh)
      Wait(1000)
      SetEntityCoords(playerPed, Config.Location['marker'].x+1, Config.Location['marker'].y+1, Config.Location['marker'].z)
    end
  elseif CurrentTest == 'cdl' then
    if success then
      TriggerServerEvent('qb-dmv:cdlpaymentpassed')
      QBCore.Functions.Notify('You passed the CDL Test!')
      QBCore.Functions.DeleteVehicle(veh)
      CurrentTest = nil
    elseif success == false then
      TriggerServerEvent('qb-dmv:driverpaymentfailed')
      QBCore.Functions.Notify('You Failed the CDL Test!')
      CurrentTest = nil
      RemoveBlip(CurrentBlip)
      QBCore.Functions.DeleteVehicle(veh)
      Wait(1000)
      SetEntityCoords(playerPed, Config.Location['marker'].x+1, Config.Location['marker'].y+1, Config.Location['marker'].z)
    end
  end

  CurrentTest     = nil
  CurrentTestType = nil
end




-- Drive test
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(300)
    if CurrentTest == 'drive' then
      local marker = Config.Location['marker']
      local playerPed      = PlayerPedId()
      local coords         = GetEntityCoords(playerPed)
      local nextCheckPoint = CurrentCheckPoint + 1
      if Config.CheckPoints[nextCheckPoint] == nil then
        if DoesBlipExist(CurrentBlip) then
          RemoveBlip(CurrentBlip)
        end
        StopDriveTest(true)
      else
        if CurrentCheckPoint ~= LastCheckPoint then
          if DoesBlipExist(CurrentBlip) then
            RemoveBlip(CurrentBlip)
          end
          CurrentBlip = AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z)
          SetBlipRoute(CurrentBlip, 1)
          LastCheckPoint = CurrentCheckPoint
        end
        local distance = GetDistanceBetweenCoords(coords, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, true)
        if distance <= 7.0 then
          Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
          CurrentCheckPoint = CurrentCheckPoint + 1
        end
      end
    elseif CurrentTest == 'cdl' then
        local marker = Config.Location['marker']
        local playerPed      = PlayerPedId()
        local coords         = GetEntityCoords(playerPed)
        local nextCheckPoint = CurrentCheckPoint + 1
        if Config.CheckPoints[nextCheckPoint] == nil then
          if DoesBlipExist(CurrentBlip) then
            RemoveBlip(CurrentBlip)
          end
          StopDriveTest(true)
        else
          if CurrentCheckPoint ~= LastCheckPoint then
            if DoesBlipExist(CurrentBlip) then
              RemoveBlip(CurrentBlip)
            end
            CurrentBlip = AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z)
            SetBlipRoute(CurrentBlip, 1)
            LastCheckPoint = CurrentCheckPoint
          end
          local distance = GetDistanceBetweenCoords(coords, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, true)
          if distance <= 7.0 then
            Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
            CurrentCheckPoint = CurrentCheckPoint + 1
          end
        end
    end
  end
end)


-- Speed / Damage control
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(2500)
      if CurrentTest == 'drive' then
          local playerPed = PlayerPedId()
          if IsPedInAnyVehicle(playerPed,  false) then
              local vehicle      = GetVehiclePedIsIn(playerPed,  false)
              local speed        = GetEntitySpeed(vehicle) * Config.SpeedMultiplier
              local tooMuchSpeed = false
              for k,v in pairs(Config.SpeedLimits) do
                  if CurrentZoneType == k and speed > v then
                  tooMuchSpeed = true
                      if not IsAboveSpeedLimit then
                          DriveErrors       = DriveErrors + 1
                          IsAboveSpeedLimit = true
                          QBCore.Functions.Notify('Driving too fast',"error")
                          QBCore.Functions.Notify("Errors:"..tostring(DriveErrors).."/" ..Config.MaxErrors, "error")
                      end
                  end
              end
              if not tooMuchSpeed then
                  IsAboveSpeedLimit = false
              end
              local health = GetVehicleBodyHealth(vehicle)
              if health < LastVehicleHealth then
                  DriveErrors = DriveErrors + 1
                  QBCore.Functions.Notify('You Damaged the Vehicle')
                  QBCore.Functions.Notify("Errors:"..tostring(DriveErrors).."/" ..Config.MaxErrors, "error")
                  LastVehicleHealth = health
              end
              if DriveErrors >= Config.MaxErrors then
                Wait(10)
                StopDriveTest(false)
              end
          end
        elseif CurrentTest == 'cdl' then
            local playerPed = PlayerPedId()
            if IsPedInAnyVehicle(playerPed,  false) then
                local vehicle      = GetVehiclePedIsIn(playerPed,  false)
                local speed        = GetEntitySpeed(vehicle) * Config.SpeedMultiplier
                local tooMuchSpeed = false
                for k,v in pairs(Config.SpeedLimits) do
                    if CurrentZoneType == k and speed > v then
                    tooMuchSpeed = true
                        if not IsAboveSpeedLimit then
                            DriveErrors       = DriveErrors + 1
                            IsAboveSpeedLimit = true
                            QBCore.Functions.Notify('Driving too fast',"error")
                            QBCore.Functions.Notify("Errors:"..tostring(DriveErrors).."/" ..Config.MaxErrors, "error")
                        end
                    end
                end
                if not tooMuchSpeed then
                    IsAboveSpeedLimit = false
                end
                local health = GetVehicleBodyHealth(vehicle)
                if health < LastVehicleHealth then
                    DriveErrors = DriveErrors + 1
                    QBCore.Functions.Notify('You Damaged the Vehicle')
                    QBCore.Functions.Notify("Errors:"..tostring(DriveErrors).."/" ..Config.MaxErrors, "error")
                    LastVehicleHealth = health
                end
                if DriveErrors >= Config.MaxErrors then
                  Wait(10)
                  StopDriveTest(false)
                end
            end
      end
  end
end)


--Page Selections changing to different page of UI for theoritical quiz
RegisterNUICallback('question', function(data, cb)
    SendNUIMessage({
      openSection = 'question'
    })
    cb()
end)

RegisterNUICallback('close', function(data, cb)
    StopTheoryTest(true)
    cb()
end)

RegisterNUICallback('kick', function(data, cb)
    StopTheoryTest(false)
    cb()
end)





--Blips
Citizen.CreateThread(function ()
    blip = AddBlipForCoord(Config.Location['marker'].x, Config.Location['marker'].y, Config.Location['marker'].z)
    SetBlipSprite(blip, Config.Blip.Sprite)
    SetBlipDisplay(blip, Config.Blip.Display)
    SetBlipColour(blip, Config.Blip.Color)
    SetBlipScale(blip, Config.Blip.Scale)
    SetBlipAsShortRange(blip, Config.Blip.ShortRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blip.BlipName)
    EndTextCommandSetBlipName(blip)
end)















-----------------DrawMissionText Function-------------------
function DrawMissionText(msg, time)
    ClearPrints()
    SetTextEntry_2('STRING')
    AddTextComponentString(msg)
    DrawSubtitleTimed(time, 1)
end
-----------------SetCurrentZoneType Function-------------------
function SetCurrentZoneType(type)
    CurrentZoneType = type
  end

-----------------Ped Spawner-------------------
Citizen.CreateThread(function ()
--[[
  Citizen.Wait(10)
  if Config.UseTarget then
    SpawnPed = Config.Ped
    
    exports['lrp-target']:SpawnPed({
      model = SpawnPed,
      coords = vector4(214.57, -1400.24, 30.58, 311.53),
      minusOne = true,
      freeze = true,
      invincible = true,
      blockevents = true,
      scenario = 'WORLD_HUMAN_CLIPBOARD',
      target = {
        options = {}
      }
    })
  else
    DeletePed(SpawnPed)
  end
]]--

  --if Config.UseTarget then
--[[
        exports['lrp-target']:AddTargetModel(SpawnPed, {       --Drivers Test Menu
          options = {
              {
                type = "client",
                event = "qb-dmv:dmvmenu",
                icon = 'fas fa-example',
                label = 'Speak to Officer',
              },
          },
            distance = 2.5,
        })
  end
]]--

  exports['lrp-target']:AddTargetModel(`s_m_y_cop_01`, {
    options = {
        {
            type = "client",
            event = "qb-dmv:dmvmenu",
            icon = "fas fa-money-check",
            label = "Speak to DMV officer",
        },
    },
    distance = 10.0
})

end)


RegisterNetEvent('qb-dmv:dmvmenu')
AddEventHandler('qb-dmv:dmvmenu', function ()
   dmvmenu()
end)




function dmvmenu()
  local drive = Config.DriversTest

  QBCore.Functions.TriggerCallback('qb-dmv:server:menu', function (permit)
    if permit == false then

        QBCore.Functions.TriggerCallback('qb-dmv:server:menu2', function (license)
            if license == 0 then
              if drive then
                QBCore.Functions.Notify("You\'ve already taken all the Drivers Test, Go to the city hall to buy drivers licence")
              end
            elseif license == 1 then
                if drive then
                    Wait(10)
                    OpenMenu2()
                end
            elseif license == 2 then
                  if drive then
                      Wait(10)
                      OpenMenuCDL()
                  end
            elseif license == 3 then
                  if drive then
                      Wait(10)
                      OpenMenuDriving()
                  end
            end
         end)
    else
      Wait(10)
      OpenMenu()
    end
  end)
end