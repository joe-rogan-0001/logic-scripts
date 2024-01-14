Config = {
    FrameworkLoadinEvent = 'QBCore:Client:OnPlayerLoaded',
    peds = {
--[[         ['test'] = {
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
        }, ]]
        ['postop'] = {
            label = 'Talk to the PostOP Boss',
            icon = 'fa-solid fa-comment',
            model = "s_m_y_airworker",
            coords = vector3(-430.62, -2786.22, 6.00),
            heading =  42.43,
            data = {
                firstname = 'Jack',
                lastname = 'Hoff',
                text = 'Hey bud, You looking for a job?',
                type = 'Delivery',
                buttons = {
                    { 
                        text = 'Yeah man, what you offering?',
                        data = {
                            text = 'Alright, choose a the distance for the job, be aware that you might have to build up experience before getting access to the longer routes.',
                            buttons = {
                                {
                                    text = 'Give me the small route.',
                                    event = 'Renewed-Deliveries:client:clientChecks',
                                    args = {
                                        size = 'small',
                                    },                                    
                                    close = true, 
                                },
                                {
                                    text = 'Give me the medium route.',
                                    event = 'Renewed-Deliveries:client:clientChecks',
                                    args = {
                                        size = 'medium',
                                    },                                    
                                    close = true, 
                                },
                                {
                                    text = 'Give me the long route.',
                                    event = 'Renewed-Deliveries:client:clientChecks',
                                    args = {
                                        size = 'large',
                                    },                                    
                                    close = true, 
                                },
                                {
                                    text = 'I change my mind.',                                  
                                    close = true, 
                                },
                            }
                        } 
                    },
                    { 
                        text = 'Collect Paychecks / End Job!', 
                        close = true,
                        event = 'con:postal'
                    },
                    { 
                        text = 'No thank you!', 
                        close = true 
                    },
                }
            }
        },
        ['sanitation'] = {
            label = 'Talk to the Sanitation Boss',
            icon = 'fa-solid fa-comment',
            model = "s_m_y_garbage",
            coords = vector3(-322.25, -1545.78, 31.02),
            heading =  270.41,
            data = {
                firstname = 'Mike',
                lastname = 'Hawk',
                text = 'Hey mate, You looking to get dirty?',
                type = 'Sanitation',
                buttons = {
                    { 
                        text = 'Oh hell yeah, what you offering?',
                        data = {
                            text = 'Alright, choose a the distance for the job, be aware that you might have to build up experience before getting access to the longer routes. Have fun and remember to wear a hard hat and gloves!',
                            buttons = {
                                {
                                    text = 'Give me the small route.',
                                    event = 'Renewed-Garbage:client:clientChecks',
                                    args = {
                                        size = 'small',
                                    },                                    
                                    close = true, 
                                },
                                {
                                    text = 'Give me the medium route.',
                                    event = 'Renewed-Garbage:client:clientChecks',
                                    args = {
                                        size = 'medium',
                                    },                                    
                                    close = true, 
                                },
                                {
                                    text = 'Give me the long route.',
                                    event = 'Renewed-Garbage:client:clientChecks',
                                    args = {
                                        size = 'large',
                                    },                                    
                                    close = true, 
                                },
                                {
                                    text = 'I change my mind.',                                  
                                    close = true, 
                                },
                            }
                        } 
                    },
                    { 
                        text = 'Collect Paychecks / End Job!', 
                        close = true,
                        event = 'con:garbage'
                    },
                    { 
                        text = 'Nah Im good man!', 
                        close = true 
                    },
                }
            }
        },
    }
}