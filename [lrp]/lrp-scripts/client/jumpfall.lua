Citizen.CreateThread( function()
    local resetcounter = 0
    local jumpDisabled = false
  
    while true do
      Citizen.Wait(100)
      if jumpDisabled and resetcounter > 0 and IsPedJumping(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(), 1000, 1000, 3, 0, 0, 0)
        resetcounter = 0
      end
  
      if not jumpDisabled and IsPedJumping(PlayerPedId()) then
        jumpDisabled = true
        resetcounter = 10
        Citizen.Wait(1200)
      end
  
      if resetcounter > 0 then
        resetcounter = resetcounter - 1
      else
        if jumpDisabled then
          resetcounter = 0
          jumpDisabled = false
        end
      end
    end
  end)