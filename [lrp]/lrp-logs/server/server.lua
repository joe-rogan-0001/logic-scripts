local QBCore = exports['lrp-core']:GetCoreObject()

RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)        
    local tag = tagEveryone or false
    local webHook = Config.Webhooks[name] or Config.Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Config.Colors[color] or Config.Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c') .. ' Logic Roleplay Logs',
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'Logic Roleplay',
                ['icon_url'] = 'https://media.discordapp.net/attachments/894268155516559393/926997887756423168/lrp-transparent2.png?width=670&height=670',
            },
        }
    }
    Citizen.Wait(1000)
    PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = 'Logic Roleplay Logs', embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(500)
    if tag then
        PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = 'Logic Roleplay Logs', content = '@everyone'}), { ['Content-Type'] = 'application/json' })
    end
end)

QBCore.Commands.Add('testwebhook', 'Test Your Discord Webhook For Logs (God Only)', {}, false, function(source, args)
    TriggerEvent('qb-log:server:CreateLog', 'testwebhook', 'Test Webhook', 'default', 'Webhook setup successfully')
end, 'god')
