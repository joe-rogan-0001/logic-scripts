local HoldTime, LastStroke = 0

Citizen.CreateThread(function()
  while true do

    DisableControlAction(0, 200, true)

    Citizen.Wait(0)
  end
end)

Citizen.CreateThread(function()
  while true do

    if not IsPauseMenuActive() and IsDisabledControlJustReleased(0, 200) then
      local time  = GetGameTimer()

      HoldTime = (LastStroke and time - LastStroke > 1500) and 1 or HoldTime + 1

      if HoldTime >= 2 and not HasNuiFocus then
        HoldTime = 0
        ActivateFrontendMenu(`FE_MENU_VERSION_MP_PAUSE`, 0, 42)
      end

      LastStroke = time
    end

    Citizen.Wait(0)
  end
end)