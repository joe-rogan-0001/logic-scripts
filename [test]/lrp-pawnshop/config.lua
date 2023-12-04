Config = {}

Config.Currency = "money"
Config.Distance = 3

Config.PedProps = {
    ['location'] = vector4(-308.55, 6193.22, 31.56, 134.71),
    ['hash'] = `ig_siemonyetarian`
}

Config.Target = {
    pos = vec3(-308.55, 6193.22, 31.56),
    size = vec3(1.0, 1.0, 2.0),
    heading = 134.71,
    icon = "fas fa-cart-shopping",
    debug = false
}

Config.MenuSellItems = {
    ["rolex"] = {
        price = 40,
        label = "Rolex",
        icon = "fas fa-clock"
    },
    ["goldchain"] = {
        price = 40,
        label = "Gold Chain",
        icon = "fa-solid fa-link"
    },
    ["10kgoldchain"] = {
        price = 40,
        label = "10k Gold Chain",
        icon = "fa-solid fa-link"
    },
    ["diamond_ring"] = {
        price = 40,
        label = "Diamond Ring",
        icon = "fa-solid fa-ring"
    },
    ["hr_pan"] = {
        price = 50,
        label = "Pan",
        icon = "fa-solid fa-kitchen-set"
    },
    ["hr_vinyl"] = {
        price = 80,
        label = "Vinyl",
        icon = "fa-solid fa-compact-disc"
    },
    ["hr_pendrive"] = {
        price = 150,
        label = "Pendrive",
        icon = "fa-brands fa-usb"
    },
    ["hr_pliers"] = {
        price = 75,
        label = "Pliers",
        icon = "fa-solid fa-screwdriver-wrench"
    },
    ["hr_mixer"] = {
        price = 75,
        label = "Mixer",
        icon = "fa-solid fa-blender"
    },
    ["hr_headphones"] = {
        price = 25,
        label = "Headphones",
        icon = "fa-solid fa-headphones"
    },
    ["hr_phone"] = {
        price = 200,
        label = "Phone",
        icon = "fa-solid fa-mobile-screen-button"
    },
    ["hr_toaster"] = {
        price = 400,
        label = "Toaster",
        icon = "fa-solid fa-bread-slice"
    },
    ["hr_toaster2"] = {
        price = 400,
        label = "Broken Toaster",
        icon = "fa-solid fa-bread-slice"
    },
    ["hr_microwave"] = {
        price = 500,
        label = "Microwave",
        icon = "fa-solid fa-temperature-high"
    },
    ["hr_microwave2"] = {
        price = 500,
        label = "Broken Microwave",
        icon = "fa-solid fa-temperature-high"
    },
    ["hr_boombox"] = {
        price = 300,
        label = "Boombox",
        icon = "fa-solid fa-radio"
    },
    ["hr_tv3"] = {
        price = 500,
        label = "TV",
        icon = "fa-solid fa-tv"
    },
    ["hr_flattv3"] = {
        price = 700,
        label = "Flat TV",
        icon = "fa-solid fa-tv"
    },
    ["hr_console"] = {
        price = 600,
        label = "Console",
        icon = "fa-brands fa-xbox"
    },
    ["hr_bigtv"] = {
        price = 700,
        label = "Big TV",
        icon = "fa-solid fa-tv"
    },
    ["hr_coffeemaker"] = {
        price = 400,
        label = "Coffee Maker",
        icon = "fa-solid fa-mug-ho"
    },
    ["hr_printer"] = {
        price = 500,
        label = "Printer",
        icon = "fa-solid fa-print"
    },
    ["hr_telescope"] = {
        price = 800,
        label = "Telescope",
        icon = "fa-solid fa-microscope"
    },
    ["hr_laptop"] = {
        price = 800,
        label = "Laptop",
        icon = "fa-solid fa-laptop"
    },
}

Config.MenuIcons = {
    buy = "fas fa-cart-plus",
    sell = "fas fa-cart-arrow-down"
}

Config.MenuBuyItems = {
    ["nil"] = {
        price = 0,
        label = "(WIP) Maybe in the future",
        icon = "fa-solid fa-x"
    },
}

Config.Blip = {
	Enable = true,
	Location = vector3(-314.51, 6192.91, 31.56),
	Sprite = 605,
	Display = 2,
	Scale = 1.0,
	Colour = 46,
	Name = "Pawn Shop",
}