Config = {}

Config.Jobs = {
    ["electrician"] = "Electrician",
    ["cook"] = "Cook",
    ["janitor"] = "Janitor",
}

Config.PrisonJobs = {
    [1] = {
        name = "electrician",
        label = "Prison Electrician",
    },
    [2] = {
        name = "cook",
        label = "Prison Cook",
    },
    [3] = {
        name = "janitor",
        label = "Prison Janitor",
    },
}

Config.PrisonWage = 10

Config.Locations = {
    jobs = {
        ["electrician"] = {
            [1] = {
                coords = vector4(1761.46, 2540.41, 45.56, 272.249)
            },
            [2] = {
                coords = vector4(1718.54, 2527.802, 45.56, 272.249)
            },
            [3] = {
                coords = vector4(1700.199, 2474.811, 45.56, 272.249)
            },
            [4] = {
                coords = vector4(1664.827, 2501.58, 45.56, 272.249)
            },
            [5] = {
                coords = vector4(1621.622, 2509.302, 45.56, 272.249)
            },
            [6] = {
                coords = vector4(1627.936, 2538.393, 45.56, 272.249)
            },
            [7] = {
                coords = vector4(1625.1, 2575.988, 45.56, 272.249)
            }
        },
        ["cook"] = {
            [1] = {
                coords = vector4(1780.85, 2564.29, 45.67, 4.85),
            },
            [2] = {
                coords = vector4(1777.57, 2561.91, 45.67, 92.91),
            },
            [3] = {
                coords = vector4(1784.56, 2564.17, 45.67, 355.81),
            },
            [4] = {
                coords = vector4(1786.54, 2564.33, 45.67, 356.82),
            },
            [5] = {
                coords = vector4(1780.19, 2560.78, 45.67, 180.96),
            },
        },
        ["janitor"] = {
            [1] = {
                coords = vector4(1758.37, 2566.15, 45.55, 102.74),
            },
            [2] = {
                coords = vector4(1756.89, 2514.18, 45.55, 128.11),
            },
            [3] = {
                coords = vector4(1737.23, 2543.75, 45.55, 347.52),
            },
            [4] = {
                coords = vector4(1683.65, 2565.2, 45.55, 220.94),
            },
            [5] = {
                coords = vector4(1635.25, 2502.33, 45.55, 314.76),
            },
            [6] = {
                coords = vector4(1655.69, 2527.02, 45.55, 325.87),
            },
            [7] = {
                coords = vector4(1655.58, 2540.84, 45.55, 57.73),
            },
        },
    },
    ["freedom"] = {
        coords = vector4(1827.3, 2587.72, 46.01, 91.44)
    },
    ["outside"] = {
        coords = vector4(1848.13, 2586.05, 45.67, 269.5)
    },
    ["yard"] = {
        coords = vector4(1765.67, 2565.91, 45.56, 1.5)
    },
    ["middle"] = {
        coords = vector4(1693.33, 2569.51, 45.55, 123.5)
    },
    ["shop"] = {
        coords = vector4(1786.19, 2557.77, 45.62, 0.5)
    },
    ["work"] = {
        coords = vector4(1828.83, 2580.21, 46.01, 0.5) --coords = vector3(1828.83, 2580.21, 46.01),
    },
    spawns = {
        [1] = {
            animation = "bumsleep",
            coords = vector4(1661.046, 2524.681, 45.564, 260.545)
        },
        [2] = {
            animation = "lean",
            coords = vector4(1650.812, 2540.582, 45.564, 230.436)
        },
        [3] = {
            animation = "lean",
            coords = vector4(1654.959, 2545.535, 45.564, 230.436)
        },
        [4] = {
            animation = "lean",
            coords = vector4(1697.106, 2525.558, 45.564, 187.208)
        },
        [5] = {
            animation = "sitchair4",
            coords = vector4(1673.084, 2519.823, 45.564, 229.542)
        },
        [6] = {
            animation = "sitchair",
            coords = vector4(1666.029, 2511.367, 45.564, 233.888)
        },
        [7] = {
            animation = "sitchair4",
            coords = vector4(1691.229, 2509.635, 45.564, 52.432)
        },
        [8] = {
            animation = "finger2",
            coords = vector4(1770.59, 2536.064, 45.564, 258.113)
        },
        [9] = {
            animation = "smoke",
            coords = vector4(1792.45, 2584.37, 45.56, 276.24)
        },
        [10] = {
            animation = "smoke",
            coords = vector4(1768.33, 2566.08, 45.56, 176.83)
        },
        [11] = {
            animation = "smoke",
            coords = vector4(1696.09, 2469.4, 45.56, 1.4)
        }
    }
}

Config.CanteenItems = {
    [1] = {
        name = "sandwich",
        price = 4,
        amount = 50,
        info = {},
        type = "item",
        slot = 1
    },
    [2] = {
        name = "water_bottle",
        price = 4,
        amount = 50,
        info = {},
        type = "item",
        slot = 2
    }
}

Config.SlushyItems = {
    [1] = {
        name = "slushy",
        price = 35,
        amount = 1,
        info = {},
        type = "item",
        slot = 1
    },
}
