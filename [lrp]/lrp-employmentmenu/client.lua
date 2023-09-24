local QBCore = exports['lrp-core']:GetCoreObject()
local PlayerGang = {}
local PlayerJob = {}
local sleep


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerGang = QBCore.Functions.GetPlayerData().gang
end)




RegisterNetEvent('QBCore:Client:OnGangUpdate')
AddEventHandler('QBCore:Client:OnGangUpdate', function(GangInfo)
    PlayerGang = GangInfo
end)



AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        while true do
        isLoggedIn = true
        Citizen.Wait(1000)
        PlayerGang = QBCore.Functions.GetPlayerData().gang
        PlayerJob = QBCore.Functions.GetPlayerData().job
        end
	end
end)

--######Gangs########--

RegisterNetEvent('lrp-gangmenu:client:MenuGangs')
AddEventHandler('lrp-gangmenu:client:MenuGangs', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Gang Menu",
            isMenuHeader = true
        },
        --[[
        {
            header = "Gang Society",
            txt = 'Gangs Society',
            params = {
                event = "lrp-gangmenu:client:MenuSociety"
            }
        }, 
        ]]--
        {
            header = "Boss Action",
            txt = 'Boss Managment',
            params = {
                event = "lrp-gangmenu:client:MenuBossActions"
            }
        },
        {
            header = "⬅ Leave Gang Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)



--- Gang Society

RegisterNetEvent('lrp-gangmenu:client:MenuSociety')
AddEventHandler('lrp-gangmenu:client:MenuSociety', function()
    QBCore.Functions.TriggerCallback('lrp-gangmenu:server:GetAccount', function(cb)
    exports['lrp-menu']:openMenu({
        {
            header = "Gang Society",
            txt = 'Society Amount: $' ..comma_value(cb),
            params = {
                event = "lrp-gangmenu:client:society"
            }
        },
        {
            header = "Gang Deposit",
            txt = 'Deposit Cash',
            params = {
                event = "lrp-gangmenu:client:Deposit"
            }
        },
        {
            header = "Gang Withdraw",
            txt = 'Withdraw Cash',
            params = {
                event = "lrp-gangmenu:client:WithdrawMoney"
            }
        },
        {
            header = "⬅ Back",
            txt = "",
            params = {
                event = "lrp-gangmenu:client:MenuGangs"
            }
        },
    })
    end, PlayerGang.name)
end)

RegisterNetEvent('lrp-gangmenu:client:WithdrawMoney')
AddEventHandler('lrp-gangmenu:client:WithdrawMoney', function()
    local result = LocalInput('Withdrawal Amount', 16, '')
    if result ~= nil and PlayerGang.name and PlayerGang.isboss then
        TriggerServerEvent("lrp-gangmenu:server:withdrawMoney", tonumber(result))
        UpdateSociety()
    else
        QBCore.Functions.Notify('Not High Enough Rank', "error")
    end
end)


RegisterNetEvent('lrp-gangmenu:client:Deposit')
AddEventHandler('lrp-gangmenu:client:Deposit', function()
    local result = LocalInput('Deposit Amount', 16, '')
    if result ~= nil then
        TriggerServerEvent("lrp-gangmenu:server:depositMoney", tonumber(result))
        UpdateSociety()
    end
end)


RegisterNetEvent('lrp-gangmenu:client:society')
AddEventHandler('lrp-gangmenu:client:society', function()
    QBCore.Functions.TriggerCallback('lrp-gangmenu:server:GetAccount', function(cb)
        if cb > 1000000 then
            QBCore.Functions.Notify('The police have been called, thanks for sharing your info!!', "primary")
        else
            QBCore.Functions.Notify('HAHA your broke AF!!', "error")
        end
    end, PlayerGang.name)
end)

-----





------ EmployeeList and Managment

RegisterNetEvent('lrp-gangmenu:client:MenuBossActions')
AddEventHandler('lrp-gangmenu:client:MenuBossActions', function()
    if PlayerGang.name and PlayerGang.isboss then
        exports['lrp-menu']:openMenu({
            {
                header = "Gang Menu",
                isMenuHeader = true
            },
            {
                header = "Gang Members",
                txt = 'Gangs Member Managment',
                params = {
                    event = "lrp-gangmenu:client:EmployeeList"
                }
            },
            {
                header = "Recruit Members",
                txt = 'Recruit New Gangs Members',
                params = {
                    event = "lrp-gangmenu:client:RecruitList"
                }
            },
            {
                header = "⬅ Back",
                txt = "",
                params = {
                    event = "lrp-gangmenu:client:MenuGangs"
                }
            },
        })
    else
        QBCore.Functions.Notify('Not High Enough Rank', "error")
    end
end)

RegisterNetEvent("lrp-gangmenu:client:EmployeeList", function(source, args, raw)
    QBCore.Functions.TriggerCallback('lrp-gangmenu:server:GetEmployees', function(cb)
        local MenuGangOptions = {}
        for k,v in pairs(cb) do
             local employee = v 
            MenuGangOptions[#MenuGangOptions+1] = {
                header = v.grade.name.. ' ' ..v.name,
                txt = "Employee",
                params = {   
                    event = 'lrp-gangmenu:client:MenuManageEmployees',
                    args = {
                        name = employee,
                    }  
                }
            }
        end
        MenuGangOptions[#MenuGangOptions+1] = {
            header = "⬅ Back",
            txt = "",
            params = {
                event = "lrp-gangmenu:client:MenuBossActions"
            }
        }
        exports['lrp-menu']:openMenu(MenuGangOptions)
    end,PlayerGang.name)
end)



RegisterNetEvent('lrp-gangmenu:client:MenuManageEmployees')
AddEventHandler('lrp-gangmenu:client:MenuManageEmployees', function(data, source, args, raw)
    local name = data.name
    exports['lrp-menu']:openMenu({
        {
            header = "Promote/Demote",
            txt = "Promote/Demote gang member",
            params = {
                event = "lrp-gangmenu:client:ManageEmployees", 
                args = {
                    name = name,
                } 
            }
        },
        {
            header = "Fire",
            txt = 'Fire gang member',
            params = {
                event = "lrp-gangmenu:client:FireEmployees",
                args = {
                    name = name,
                } 
            }
        },
        {
            header = "⬅ Back",
            txt = "",
            params = {
                event = "lrp-gangmenu:client:EmployeeList"
            }
        },
    })
end)

RegisterNetEvent('lrp-gangmenu:client:ManageEmployees')
AddEventHandler('lrp-gangmenu:client:ManageEmployees', function(data)
    local name = data.name
    local result = LocalInput('New Grade Level', 3, '')
    if result ~= nil then
        TriggerServerEvent('lrp-gangmenu:server:updateGrade', name.empSource, tonumber(result))
    end
end)

RegisterNetEvent('lrp-gangmenu:client:FireEmployees')
AddEventHandler('lrp-gangmenu:client:FireEmployees', function(data)
    local name = data.name
    TriggerServerEvent('lrp-gangmenu:server:fireEmployee', name.empSource)
end)

-------





----- Gang recruit player

RegisterNetEvent("lrp-gangmenu:client:RecruitList", function(source, args, raw)
    local playerPed = PlayerPedId()
    local MenuGangOptions = {}

        
        for k,v in pairs(QBCore.Functions.GetPlayersFromCoords(GetEntityCoords(playerPed), 10.0)) do
            if v and v ~= PlayerId() then
                local recruitv = GetPlayerServerId(v) 
                    MenuGangOptions[#MenuGangOptions+1] = {
                        header = GetPlayerName(v),
                        txt = "Available Recruit",
                        params = {
                            event = 'lrp-gangmenu:client:recruit', 
                            args = {
                                recruit = recruitv,
                            }
                        }
                    }
            end
        end

    MenuGangOptions[#MenuGangOptions+1] = {
        header = "⬅ Back",
        txt = "",
        params = {
            event = "lrp-gangmenu:client:MenuBossActions"
        }
    }
    exports['lrp-menu']:openMenu(MenuGangOptions)
end)

RegisterNetEvent('lrp-gangmenu:client:recruit')
AddEventHandler('lrp-gangmenu:client:recruit', function(data)
    local recruit = data.recruit
    TriggerServerEvent('lrp-gangmenu:server:giveJob', recruit )
end)

------





----- Gang Storage

RegisterNetEvent('lrp-gangmenu:client:OpenInventory')
AddEventHandler('lrp-gangmenu:client:OpenInventory', function()
    local rank = PlayerGang.grade.level

    if rank >= 1 then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. PlayerGang.name, {
            maxweight = 4000000,
            slots = 500,
        })
        TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. PlayerGang.name)
    else
        QBCore.Functions.Notify('Not High Enough Rank', "error")
    end
end)

------





-- FUNCTIONS




--####################--




















--######Jobs########--

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)



RegisterNetEvent('lrp-gangmenu:client:MenuJobs')
AddEventHandler('lrp-gangmenu:client:MenuJobs', function()
    exports['lrp-menu']:openMenu({
        {
            header = "Job Menu",
            isMenuHeader = true
        },
        --[[
        {
            header = "Job Society",
            txt = 'Jobs Society',
            params = {
                event = "lrp-gangmenu:client:MenuSocietyJob"
            }
        }, 
        ]]--
        {
            header = "Boss Action",
            txt = 'Boss Managment',
            params = {
                event = "lrp-gangmenu:client:MenuBossActionsJob"
            }
        },
        {
            header = "⬅ Leave Job Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)



--- Job Society

RegisterNetEvent('lrp-gangmenu:client:MenuSocietyJob')
AddEventHandler('lrp-gangmenu:client:MenuSocietyJob', function()
    QBCore.Functions.TriggerCallback('lrp-gangmenu:server:GetAccountJob', function(cb)
    exports['lrp-menu']:openMenu({
        {
            header = "Job Society",
            txt = 'Society Amount: $' ..comma_value(cb),
            params = {
                event = "lrp-gangmenu:client:societyjob"
            }
        },
        {
            header = "Job Deposit",
            txt = 'Deposit Cash',
            params = {
                event = "lrp-gangmenu:client:DepositJob"
            }
        },
        {
            header = "Job Withdraw",
            txt = 'Withdraw Cash',
            params = {
                event = "lrp-gangmenu:client:WithdrawMoneyJob"
            }
        },
        {
            header = "⬅ Back",
            txt = "",
            params = {
                event = "lrp-gangmenu:client:MenuGangsJobs"
            }
        },
    })
    end, PlayerJob.name)
end)

RegisterNetEvent('lrp-gangmenu:client:WithdrawMoneyJob')
AddEventHandler('lrp-gangmenu:client:WithdrawMoneyJob', function()
    local result = LocalInput('Withdrawal Amount', 16, '')
    if result ~= nil and PlayerJob.name and PlayerJob.isboss then
        TriggerServerEvent("lrp-gangmenu:server:withdrawMoneyJob", tonumber(result))
        --UpdateSociety2()
    else
        QBCore.Functions.Notify('Not High Enough Rank', "error")
    end
end)


RegisterNetEvent('lrp-gangmenu:client:DepositJob')
AddEventHandler('lrp-gangmenu:client:DepositJob', function()
    local result = LocalInput('Deposit Amount', 16, '')
    if result ~= nil then
        TriggerServerEvent("lrp-gangmenu:server:depositMoneyJob", tonumber(result))
        --UpdateSociety2()
    end
end)


RegisterNetEvent('lrp-gangmenu:client:societyjob')
AddEventHandler('lrp-gangmenu:client:societyjob', function()
    QBCore.Functions.TriggerCallback('lrp-gangmenu:server:GetAccountJob', function(cb)
        if cb > 1000000 then
            QBCore.Functions.Notify('All that civ money lets go!!!', "primary")
        else
            QBCore.Functions.Notify('HAHA ye are broke AF!!', "error")
        end
    end, PlayerJob.name)
end)

-----





------ EmployeeList and Managment

RegisterNetEvent('lrp-gangmenu:client:MenuBossActionsJob')
AddEventHandler('lrp-gangmenu:client:MenuBossActionsJob', function()
    if PlayerJob.name and PlayerJob.isboss then
        exports['lrp-menu']:openMenu({
            {
                header = "Job Menu",
                isMenuHeader = true
            },
            {
                header = "Employees",
                txt = 'Employee Managment',
                params = {
                    event = "lrp-gangmenu:client:EmployeeListJob"
                }
            },
            {
                header = "Recruit Employees",
                txt = 'Recruit New Employees',
                params = {
                    event = "lrp-gangmenu:client:RecruitListJob"
                }
            },
            {
                header = "⬅ Back",
                txt = "",
                params = {
                    event = "lrp-gangmenu:client:MenuGangsJobs"
                }
            },
        })
    else
        QBCore.Functions.Notify('Not High Enough Rank', "error")
    end
end)

RegisterNetEvent("lrp-gangmenu:client:EmployeeListJob", function(source, args, raw)
    QBCore.Functions.TriggerCallback('lrp-gangmenu:server:GetEmployeesJob', function(cb)
        local MenuGangOptions = {}
        for k,v in pairs(cb) do
             local employee = v 
            MenuGangOptions[#MenuGangOptions+1] = {
                header = v.grade.name.. ' ' ..v.name,
                txt = "Employee",
                params = {   
                    event = 'lrp-gangmenu:client:MenuManageEmployeesJob',
                    args = {
                        name = employee,
                    }  
                }
            }
        end
        MenuGangOptions[#MenuGangOptions+1] = {
            header = "⬅ Back",
            txt = "",
            params = {
                event = "lrp-gangmenu:client:MenuBossActionsJob"
            }
        }
        exports['lrp-menu']:openMenu(MenuGangOptions)
    end,PlayerJob.name)
end)



RegisterNetEvent('lrp-gangmenu:client:MenuManageEmployeesJob')
AddEventHandler('lrp-gangmenu:client:MenuManageEmployeesJob', function(data, source, args, raw)
    local name = data.name
    exports['lrp-menu']:openMenu({
        {
            header = "Promote/Demote",
            txt = "Promote/Demote Employee",
            params = {
                event = "lrp-gangmenu:client:ManageEmployeesJob", 
                args = {
                    name = name,
                } 
            }
        },
        {
            header = "Fire",
            txt = 'Fire Employee',
            params = {
                event = "lrp-gangmenu:client:FireEmployeesJob",
                args = {
                    name = name,
                } 
            }
        },
        {
            header = "⬅ Back",
            txt = "",
            params = {
                event = "lrp-gangmenu:client:EmployeeListJob"
            }
        },
    })
end)

RegisterNetEvent('lrp-gangmenu:client:ManageEmployeesJob')
AddEventHandler('lrp-gangmenu:client:ManageEmployeesJob', function(data)
    local name = data.name
    local result = LocalInput('New Grade Level', 3, '')
    if result ~= nil then
        TriggerServerEvent('lrp-gangmenu:server:updateGradeJob', name.empSource, tonumber(result))
    end
end)

RegisterNetEvent('lrp-gangmenu:client:FireEmployeesJob')
AddEventHandler('lrp-gangmenu:client:FireEmployeesJob', function(data)
    local name = data.name
    TriggerServerEvent('lrp-gangmenu:server:fireEmployeeJob', name.empSource)
end)

-------





----- Job recruit player

RegisterNetEvent("lrp-gangmenu:client:RecruitListJob", function(source, args, raw)
    local playerPed = PlayerPedId()
    local MenuGangOptions = {}

        
        for k,v in pairs(QBCore.Functions.GetPlayersFromCoords(GetEntityCoords(playerPed), 10.0)) do
            if v and v ~= PlayerId() then
                local recruitv = GetPlayerServerId(v) 
                    MenuGangOptions[#MenuGangOptions+1] = {
                        header = GetPlayerName(v),
                        txt = "Available Employee",
                        params = {
                            event = 'qb-lrp-gangmenu:client:recruitJob', 
                            args = {
                                recruit = recruitv,
                            }
                        }
                    }
            end
        end

    MenuGangOptions[#MenuGangOptions+1] = {
        header = "⬅ Back",
        txt = "",
        params = {
            event = "lrp-gangmenu:client:MenuBossActionsJob"
        }
    }
    exports['lrp-menu']:openMenu(MenuGangOptions)
end)

RegisterNetEvent('qb-lrp-gangmenu:client:recruitJob')
AddEventHandler('qb-lrp-gangmenu:client:recruitJob', function(data)
    local recruit = data.recruit
    TriggerServerEvent('lrp-gangmenu:server:giveJobJob', recruit )
end)

------





----- Job Storage

RegisterNetEvent('lrp-gangmenu:client:OpenInventoryJob')
AddEventHandler('lrp-gangmenu:client:OpenInventoryJob', function()
    local rank = PlayerJob.grade.level

    if rank >= 1 then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. PlayerJob.name, {
            maxweight = 4000000,
            slots = 500,
        })
        TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. PlayerJob.name)
    else
        QBCore.Functions.Notify('Not High Enough Rank', "error")
    end
end)

------









--###########################--
















--UTIL

function LocalInput(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
        return result
    end
end

function comma_value(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end







----#### Gang Menus #####----


exports['lrp-target']:AddBoxZone("Gangmenu", vector3(-1213.62, -1321.21, 6.38), 1.5, 1.5, {
    name="Gangmenu uptr",
    heading = 19.33,
    debugPoly=false,
    minZ = 6.0,
    maxZ = 7.5,
    }, 
    {
    options = {
        {
            type = "client",
            event = "lrp-gangmenu:client:MenuGangs",
            icon = "fas fa-bars",
            label = "Open Gang Menu",
            gang = "uptr"
        },
    },
    distance = 2.5
})


exports['lrp-target']:AddBoxZone("Gangstorage1", vector3(-1213.61, -1321.03, -0.85), 1.5, 3.5, {
    name="Gangmenu uptr",
    heading = 19.33,
    debugPoly=false,
    minZ = -1.85,
    maxZ = 2.5,
    }, 
    {
    options = {
        {
            type = "client",
            event = "lrp-gangmenu:client:OpenInventory",
            icon = "fas fa-bars",
            label = "Open Storage",
            gang = "uptr"
        },
    },
    distance = 2.5
})



--IRA--

exports['lrp-target']:AddBoxZone("Gangmenu3", vector3(811.44, -2322.41, 30.46), 1.5, 1.5, {
    name="Gangmenu IRA",
    heading = 170.74,
    debugPoly=false,
    minZ = 30.4,
    maxZ = 33.5,
    }, 
    {
    options = {
        {
            type = "client",
            event = "lrp-gangmenu:client:MenuGangs",
            icon = "fas fa-bars",
            label = "Open Gang Menu",
            gang = "ira"
        },
    },
    distance = 2.5
})

exports['lrp-target']:AddBoxZone("Gangstorage3", vector3(817.6, -2312.05, 30.46), 2.5, 2.5, {
    name="Gangmenu IRA",
    heading = 353.75,
    debugPoly=false,
    minZ = 30.40,
    maxZ = 33.5,
    }, 
    {
    options = {
        {
            type = "client",
            event = "lrp-gangmenu:client:OpenInventory",
            icon = "fas fa-bars",
            label = "Open Storage",
            gang = "ira"
        },
    },
    distance = 2.5
})

exports['lrp-target']:AddBoxZone("Gangstorage4", vector3(808.81, -2310.86, 30.46), 2.5, 2.5, {
    name="Gangmenu IRA",
    heading = 357.41,
    debugPoly=false,
    minZ = 30.40,
    maxZ = 33.5,
    }, 
    {
    options = {
        {
            type = "client",
            event = "lrp-gangmenu:client:OpenInventory",
            icon = "fas fa-bars",
            label = "Open Storage",
            gang = "ira"
        },
    },
    distance = 2.5
})

--########--

--lph

exports['lrp-target']:AddBoxZone("Gangmenu2", vector3(1394.15, 1160.61, 114.37), 1.5, 1.5, {
    name="Gangmenu lph",
    heading = 342.04,
    debugPoly=false,
    minZ = 113.37,
    maxZ = 116.37,
    }, 
    {
    options = {
        {
            type = "client",
            event = "lrp-gangmenu:client:MenuGangs",
            icon = "fas fa-bars",
            label = "Open Gang Menu",
            gang = "lph"
        },
        {
            type = "client",
            event = "lrp-gangmenu:client:OpenInventory",
            icon = "fas fa-bars",
            label = "Open Storage",
            gang = "lph"
        },
    },
    distance = 2.5
})


----#### Job Menus #####----



exports['lrp-target']:AddBoxZone("jobmenuu", vector3(461.49, -986.06, 30.73), 1.5, 1.5, {
	name="pdjobmenu",
	heading = 177.76,
	debugPoly=false,
    minZ = 29.5,
    maxZ = 32.5,
	}, {
		options = {
			{
                type = "client",
                event = "lrp-gangmenu:client:MenuJobs",
                icon = "fas fa-bars",
                label = "Open Job Menu",
                job = "police"
			},
		},
		distance = 3.5
})



exports['lrp-target']:AddBoxZone("Jobmenu", vector3(335.57, -594.33, 43.28), 1.5, 1.5, {
    name="Jobmenu EMS",
    heading = 254.18,
    debugPoly=false,
    minZ = 42.5,
    maxZ = 44.5,
    }, 
    {
    options = {
        {
            type = "client",
            event = "lrp-gangmenu:client:MenuJobs",
            icon = "fas fa-bars",
            label = "Open Job Menu",
            job = "ambulance"
        },
    },
    distance = 2.5
})