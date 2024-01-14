
--[[RegisterCommand('deleteped', function()
    DeletePedByID('test')
end, false)

RegisterCommand('spawnped', function()
    SpawnPedByID('test', {
        label = 'Talk to stranger',
        icon = 'fa-solid fa-comment',
        model = "csb_avon",
        coords = vector3(165.48, 6612.81, 31.9),
        heading = 170,
        data = {
            firstname = 'John',
            lastname = 'Doe',
            text = 'Hey bud, how ya doin.',
            buttons = {
                { 
                    text = 'Im ok, how are you?',
                    data = {
                        text = 'Im cool rn, see you around!',
                        buttons = {
                            {
                                text = 'Se ya',
                                close = true
                            },
                        }
                    } 
                },
                { 
                    text = 'No sorry, im gonna leave', 
                    close = true 
                },
            }
        }
    })
end, false)

RegisterNetEvent('con:postop', function(ped)
    rep = WIP
    data = {
        firstname = 'PostOP',
        lastname = 'Boss',
        text = 'Hey bud, You looking for a job?',
        type = 'Delivery',
        rep = rep,
        buttons = {
            { text = "Yeah man!", data = {
                text = 'Alright, choose a the distance for the job, be aware that you might have to build up experience before getting access to the longer routes.',
                buttons = {
                    { text = 'Short Route', event = 'Renewed-Deliveries:client:clientChecks', args = {size = 'small',}, close = true },
                    { text = 'Medium Route', event = 'con:postop2' },
                    { text = 'Long Route', event = 'con:clockin', close = true },
                    { text = 'Nvm, I changed my mind', event = 'con:postop2' },
                }
            }},
            { text = "I'm gonna leave", close = true },
        }
    }
    OpenDialog(ped, data)
end)

RegisterNetEvent('con:postop2', function()
    data = {
        firstname = 'John',
        lastname = 'Doe',
        text = 'Hey bud, what can i do for you',
        type = 'Mechanic',
        rep = 'WIP',
        buttons = {
            { text = "Yeah man!", data = {
                text = 'Alright, choose a the distance for the job, be aware that you might have to build up experience before getting access to the longer routes.',
                    buttons = {
                        { text = 'Short Route', event = 'Renewed-Deliveries:client:clientChecks', args = {size = 'small',}, close = true },
                        { text = 'Medium Route', event = 'con:back' },
                        { text = 'Long Route', event = 'con:clockin', close = true },
                        { text = 'Nvm, I changed my mind', event = 'con:postop2' },
                    }
                }
            },
            { text = "I'm gonna leave", close = true },
        }
    }

    SetDialog(data)
end)]]--

RegisterNetEvent('con:postal', function()
    TriggerServerEvent("Renewed-Deliveries:server:CollectCheck")
end)

RegisterNetEvent('con:garbage', function()
    TriggerServerEvent("Renewed-Garbage:server:CollectCheck")
end)
