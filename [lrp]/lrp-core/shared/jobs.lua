QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = false -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Freelancer',
                payment = 500
            },
        },
	},
    ["noodleexchange"] = {
		label = "Noodle Exchange",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Noob",
                payment = 500
            },
			['1'] = {
                name = "Butcher",
                payment = 500
            },
			['2'] = {
                name = "Prime",
                payment = 500
            },
			['3'] = {
                name = "Master",
                payment = 500
            },
			['4'] = {
                name = "The King",
				isboss = true,
                payment = 500
            },
        },
	},
    ['bestbuds'] = {
		label = 'Best Buds',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 50
            },
			['1'] = {
                name = 'Deliveries',
                payment = 75
            },
			['2'] = {
                name = 'Sales',
                payment = 100
            },
			['3'] = {
                name = 'Grower',
                payment = 125
            },
			['4'] = {
                name = 'Assistant Manager',
                payment = 150
            },
			['5'] = {
                name = 'Manager',
				isboss = true,
                payment = 175
            },
			['6'] = {
                name = 'Owner',
				isboss = true,
                payment = 200
            },
        },
	},
	['police'] = {
		label = 'Police',
		defaultDuty = true,
		grades = {
            -- Police
            ['0'] = {
                name = 'Cadet',
                payment = 3750
            },
            ['1'] = {
                name = 'Probationary Officer',
                payment = 4250
            },
			['2'] = {
                name = 'Officer',
                payment = 4750
            },
			['3'] = {
                name = 'Senior Officer',
                payment = 5750
            },
			['4'] = {
                name = 'Sergeant',
                payment = 6250
            },
			['5'] = {
                name = 'Sergeant first class',
                payment = 6750
            },
			['6'] = {
                name = 'Second Lieutenant',
                payment = 7250
            },
			['7'] = {
                name = 'First Lieutenant',
                payment = 7750
            },
			['8'] = {
                name = 'Captain',
                payment = 7750  
            },
			['9'] = {
                name = 'Commander',
                payment = 8750
            },
			['10'] = {
                name = 'Chief',
				isboss = true,
                payment = 9250
            },
            -- Rangers
            ['11'] = {
                name = 'Junior Ranger',
                payment = 4750
            },
			['12'] = {
                name = 'Ranger',
                payment = 5750
            },
			['13'] = {
                name = 'Senior Ranger',
                payment = 6250
            },
			['14'] = {
                name = 'Corporal',
                payment = 6750
            },
			['15'] = {
                name = 'Ranger Sergeant',
                payment = 7250
            },
			['16'] = {
                name = 'Ranger Lieutenant',
				isboss = true,
                payment = 9250
            },
            -- Sheriff 
            ['17'] = {
                name = 'Cadet',
                payment = 5750
            },
            ['18'] = {
                name = 'Deputy',
                payment = 6250
            },
            ['19'] = {
                name = 'Corporal',
                payment = 6750
            },
			['20'] = {
                name = 'Sergeant',
                payment = 7250
            },
			['21'] = {
                name = 'Lieutenant',
                payment = 7750
            },
			['22'] = {
                name = 'Captain',
                payment = 7750
            },
			['23'] = {
                name = 'Deputy Sheriff',
                payment = 8750
            },
			['24'] = {
                name = 'Sheriff',
				isboss = true,
                payment = 9250
            },
        },
	},
    ['tunershop'] = {
		label = 'Tuner-Shop',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 0
            },
			['1'] = {
                name = 'Novice',
                payment = 0
            },
			['2'] = {
                name = 'Experienced',
                payment = 0
            },
			['3'] = {
                name = 'Advanced',
                payment = 0
            },
			['4'] = {
                name = 'Manager',
                payment = 0
            },
			['5'] = {
                name = 'CEO',
				isboss = true,
                payment = 0
            },
        },
	},
    ['mailcarrier'] = {
		label = 'Mail Carrier',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Worker',
                payment = 50
            },
        },
	},
	['ambulance'] = {
		label = 'EMS',
		defaultDuty = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 1250
            },
			['1'] = {
                name = 'Emergency Medical Technician',
                payment = 1500
            },
			['2'] = {
                name = 'Paramedic',
                payment = 1750
            },
			['3'] = {
                name = 'Paramedic FTO',
                payment = 2000
            },
			['4'] = {
                name = 'Lieutenant',
                payment = 2250
            },
            ['5'] = {
                name = 'Assistant Chief',
                payment = 2500
            },
            ['6'] = {
                name = 'Chief',
				isboss = true,
                payment = 2750
            },
        },
	},
	['realestate'] = {
		label = 'Real Estate',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'House Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Broker',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
                payment = 150
            },
            ['5'] = {
                name = 'Boss',
				isboss = true,
                payment = 175
            },
        },
	},
    ['casino'] = {
		label = 'Casino',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Employee',
                payment = 50
            },
			['1'] = {
                name = 'Assistant Manager ',
                payment = 75
            },
			['2'] = {
                name = 'Manager',
                payment = 100
            },
			['3'] = {
                name = 'Management Head',
                payment = 125
            },
            ['4'] = {
                name = 'CEO',
				isboss = true,
                payment = 175
            },
        },
	},
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 1000
            },
			['1'] = {
                name = 'Driver',
                payment = 1250
            },
			['2'] = {
                name = 'Event Driver',
                payment = 1500
            },
			['3'] = {
                name = 'Sales',
                payment = 1750
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 2000
            },
        },
	},
    ['bus'] = {
		label = 'Bus Driver',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 1000
            },
			['1'] = {
                name = 'Driver',
                payment = 1250
            },
			['2'] = {
                name = 'Event Driver',
                payment = 1500
            },
			['3'] = {
                name = 'Sales',
                payment = 1750
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 2000
            },
        },
	},
	['cardealer'] = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Showroom Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Finance',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['mechanic'] = {
		label = 'Mechanic',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Novice',
                payment = 75
            },
			['2'] = {
                name = 'Experienced',
                payment = 100
            },
			['3'] = {
                name = 'Advanced',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
    ['harmony'] = {
		label = 'Harmony Repairs',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Mechanic',
                payment = 50
            },
			['1'] = {
                name = 'Experienced',
                payment = 75
            },
			['2'] = {
                name = 'Deputy',
                payment = 100
            },
			['3'] = {
                name = 'Boss',
                payment = 125,
                isboss = true,
            },
        },
	},
	['judge'] = {
		label = 'Honorary',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Judge',
                payment = 100
            },
        },
	},
	['lawyer'] = {
		label = 'Law Firm',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Associate',
                payment = 50
            },
        },
	},
	['reporter'] = {
		label = 'Reporter',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Journalist',
                payment = 50
            },
        },
	},
	['trucker'] = {
		label = 'Trucker',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
        },
	},
	['tow'] = {
		label = 'Towing',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
        },
	},
	['garbage'] = {
		label = 'Garbage',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Collector',
                payment = 50
            },
        },
	},
	['vineyard'] = {
		label = 'Vineyard',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Picker',
                payment = 50
            },
        },
	},
	['hotdog'] = {
		label = 'Hotdog',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Sales',
                payment = 50
            },
        },
	},
	["burgershot"] = {
		label = "Burgershot Employee",
		defaultDuty = false,
		grades = {
            ['0'] = {
                name = "Trainee",
                payment = 50
            },
			['1'] = {
                name = "Employee",
                payment = 75
            },
			['2'] = {
                name = "Burger Flipper",
                payment = 100
            },
			['3'] = {
                name = "Manager",
                payment = 125
            },
			['4'] = {
                name = "CEO",
				isboss = true,
                payment = 150
            },
        },
	},
    ["hookies"] = {
		label = "Hookies Employee",
		defaultDuty = false,
		grades = {
            ['0'] = {
                name = "Trainee",
                payment = 50
            },
			['1'] = {
                name = "Employee",
                payment = 75
            },
			['2'] = {
                name = "Manager",
                payment = 125
            },
			['3'] = {
                name = "CEO",
				isboss = true,
                payment = 150
            },
        },
	},
    ['lumberjack'] = {
		label = 'LumberJack',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Logger',
                payment = 50
            },
        },
	},
}