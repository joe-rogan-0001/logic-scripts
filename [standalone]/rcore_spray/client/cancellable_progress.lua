
local IsCancelled = false
local canCancel = false
local cancelFunction = nil
local stopped = false

Citizen.CreateThread(function()
    AddTextEntry('RC_CANCEL', "~" .. Config.Keys.CANCEL.label .. "~ " .. Config.Text.CANCEL)
end)

function LoadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 100 )
    end
end

function CancellableProgress(time, animDict, animName, flag, finish, cancel, opts)
    IsCancelled = false
    stopped = false
    local ped = PlayerPedId()
    canCancel = true
    cancelFunction = cancel
    if not opts then opts = {} end

    if animDict then
        LoadAnimDict(animDict)
        TaskPlayAnim(ped, animDict, animName, opts.speedIn or 1.0, opts.speedOut or 1.0, -1, flag, 0, 0, 0, 0 )
    end

    StartCancellableProgressBar(time)
    LastHp = GetEntityHealth(ped)

    local timeLeft = time

    while true do
        Wait(1000)
        timeLeft = timeLeft - 1000

        if timeLeft <= 0 then
            break
        end

        --DisplayHelpTextThisFrame('RC_CANCEL', true)
   
    end
    
    if animDict then
        StopAnimTask(ped, animDict, animName, 1.0)
    end

    if not stopped then
        finish()
    end


end

RegisterKeyMapping('cancelspraying', 'Cancle Spraying', 'keyboard', Config.Keys.CANCEL.code)

RegisterCommand('cancelspraying', function()   
    if canCancel then
        canCancel = false
        stopped = true
        ClearPedTasksImmediately(ped)
        StopCancellableProgressBar()
        cancelFunction()     
    end   

end)

function StartCancellableProgressBar(time)
    IsProgressbarDisplayed = true
    local maxProgressWidth = 0.2
    local curProgressWidth = 0.0

    local border = 0.007
    time = time / 1000

    local distFromTop = 0.91

    Citizen.CreateThread(function()
        while IsProgressbarDisplayed and curProgressWidth < 1.0 do
            Wait(0)
            curProgressWidth = curProgressWidth + (GetFrameTime()/time)

            DrawRect(
                0.5, distFromTop, 
                maxProgressWidth, 0.05, 
                0, 0, 0, 200
            )
            
            DrawRect(
                0.5, distFromTop-0.0005, 
                maxProgressWidth * curProgressWidth * 0.999, 0.05 - border, 
                0, 255, 255, 200
            )

            SetTextFont(0)
            SetTextScale(0.0, 0.4)
            SetTextColour(255, 255, 255, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextJustification(0)
            SetTextEntry("RC_CF_FIXING")
            DrawText(0.5, 0.883)
        end
    end)
end

function StopCancellableProgressBar()
    IsProgressbarDisplayed = false
end
