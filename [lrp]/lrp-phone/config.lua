Config = Config or {}
Config.BillingCommissions = { -- This is a percentage (0.10) == 10%
    mechanic = 0.10
}
Config.Linux = false -- True if linux
Config.TweetDuration = 10000000 -- How many hours to load tweets (12 will load the past 12 hours of tweets) SET TO 168 YOU APE
Config.RepeatTimeout = 4000
Config.CallRepeats = 10
Config.OpenPhone = 244
Config.PhoneApplications = {
    ["info"] = {
        app = "info",
        color = "#5db9fc",
        color2 = "#008eff",
        icon = "fas fa-info-circle",
        tooltipText = "Information",
        tooltipPos = "top",
        style = "font-size: 3.3vh";
        job = false,
        blockedjobs = {},
        slot = 1,
        Alerts = 0,
    },
    ["phone"] = {
        app = "phone",
        color = "#51da80",
        color2 = "#009436",
        icon = "fas fa-phone-volume",
        tooltipText = "Phone",
        tooltipPos = "top",
        style = "font-size: 3.3vh";
        job = false,
        blockedjobs = {},
        slot = 2,
        Alerts = 0,
    },
    ["whatsapp"] = {
        app = "whatsapp",
        color = "#8bfc76",
        color2 = "#18d016",
        icon = "fas fa-comment",
        tooltipText = "Messages",
        tooltipPos = "top",
        style = "font-size: 3.3vh";
        job = false,
        blockedjobs = {},
        slot = 3,
        Alerts = 0,
    },
    ["mail"] = {
        app = "mail",
        color = "#009ee5",
        color2 = "#87d9e7",
        icon = "fas fa-envelope",
        tooltipText = "Mail",
        style = "font-size: 3vh";
        job = false,
        blockedjobs = {},
        slot = 4,
        Alerts = 0,
    },
    ["erpinger"] = {
        app = "erpinger",
        color = "#6d10f5",
        color2 = "#4b67ef",
        icon = "fas fa-map-marker-alt",
        tooltipText = "Ping",
        tooltipPos = "top",
        style = "font-size: 3.3vh";
        job = false,
        blockedjobs = {},
        slot = 5,
        Alerts = 0,
    },
    ["twitter"] = {
        app = "twitter",
        color = "#151515",
        color2 = "#161616",
        icon = "fab fa-twitter",
        tooltipText = "Twatter",
        tooltipPos = "top",
        style = "color: #2cabe0; font-size: 3.3vh";
        job = false,
        blockedjobs = {},
        slot = 6,
        Alerts = 0,
    },
    ["advert"] = {
        app = "advert",
        color = "#ffc900",
        color2 = "#f7c816",
        icon = "fas fa-bullhorn",
        tooltipText = "Advertisements",
        style = "font-size: 2vh";
        job = false,
        blockedjobs = {},
        slot = 7,
        Alerts = 0,
    },
    ["garage"] = {
        app = "garage",
        color = "#ff8077",
        color2 = "#bb345d",
        icon = "fas fa-car",
        tooltipText = "Vehicles",
        style = "font-size: 3.3vh";
        job = false,
        blockedjobs = {},
        slot = 8,
        Alerts = 0,
    },
    ["debt"] = {
        app = "debt",
        color = "#fdfeff",
        color2 = "#d5e6fa",
        icon = "fas fa-ad",
        tooltipText = "Debt",
        job = false,
        blockedjobs = {},
        slot = 9,
        Alerts = 0,
    },
    ["wenmo"] = {
        app = "wenmo",
        color = "#151515",
        color2 = "#161616",
        icon = "fas fa-ad",
        tooltipText = "Wenmo",
        job = false,
        blockedjobs = {},
        slot = 10,
        Alerts = 0,
    },
    ["documents"] = {
        app = "documents",
        color = "#f15ac1",
        color2 = "#aa4edd",
        icon = "fas fa-sticky-note",
        tooltipText = "Notepad",
        style = "font-size: 3.3vh";
        job = false,
        blockedjobs = {},
        slot = 11,
        Alerts = 0,
    },
    ["houses"] = {
        app = "houses",
        color = "#42a042",
        color2 = "#3f9e4a",
        icon = "fas fa-house-user",
        tooltipText = "Houses",
        style = "font-size: 3vh";
        job = false,
        blockedjobs = {},
        slot = 12,
        Alerts = 0,
    },
    ["jobcenter"] = {
        app = "jobcenter",
        color = "#151515",
        color2 = "#161616",
        icon = "fas fa-id-badge",
        tooltipText = "Job Center",
        style = "color: #78bdfd; font-size: 2.7vh";
        job = false,
        blockedjobs = {},
        slot = 13,
        Alerts = 0,
    },
    ["lsbn"] = {
        app = "lsbn",
        color = "#151515",
        color2 = "#161616",
        icon = "fas fa-ad",
        tooltipText = "LSBN",
        job = false,
        blockedjobs = {},
        slot = 14,
        Alerts = 0,
    },
    ["lawyers"] = {
        app = "lawyers",
        color = "#26d4ce",
        color2 = "#1e9c98",
        icon = "fas fa-briefcase",
        tooltipText = "Services",
        tooltipPos = "bottom",
        style = "font-size: 3vh";
        job = false,
        blockedjobs = {},
        slot = 15,
        Alerts = 0,
    },
    ["casino"] = {
        app = "casino",
        color = "#000100",
        color2 = "#000100",
        icon = "fas fa-gem",
        tooltipText = "Casino",
        tooltipPos = "bottom",
        style = "font-size: 2.7vh";
        job = false,
        blockedjobs = {},
        slot = 16,
        Alerts = 0,
    },
    ["calculator"] = {
        app = "calculator",
        color = "#c94001",
        color2 = "#9c3100",
        icon = "fas fa-calculator",
        tooltipText = "Calculator",
        tooltipPos = "bottom",
        style = "font-size: 2.5vh";
        job = false,
        blockedjobs = {},
        slot = 17,
        Alerts = 0,
    },
    ["gallery"] = {
        app = "gallery",
        color = "#189ec0",
        color2 = "#14819c",
        icon = "fas fa-images",
        tooltipText = "Gallery",
        tooltipPos = "bottom",
        style = "font-size: 2.7vh";
        job = false,
        blockedjobs = {},
        slot = 18,
        Alerts = 0,
    },
    ["bank"] = {
        app = "bank",
        color = "#9c88ff",
        color2 = "#8070d5",
        icon = "fas fa-file-contract",
        tooltipText = "Invoices",
        style = "font-size: 2.7vh";
        job = false,
        blockedjobs = {},
        slot = 19,
        Alerts = 0,
    },
    ["racing"] = {
        app = "racing",
        color = "#353b48",
        color2 = "#242830",
        icon = "fas fa-flag-checkered",
        tooltipText = "Racing",
        style = "font-size: 3vh";
        job = false,
        blockedjobs = {},
        slot = 20,
        Alerts = 0,
    },
    ["settings"] = {
        app = "settings",
        color = "#636e72",
        color2 = "#4c5558",
        icon = "fas fa-cog",
        tooltipText = "Settings",
        tooltipPos = "top",
        style = "padding-right: .08vh; font-size: 3.3vh";
        job = false,
        blockedjobs = {},
        slot = 21,
        Alerts = 0,
    },
}
Config.MaxSlots = 20

Config.StoreApps = {
    ["territory"] = {
        app = "territory",
        color = "#353b48",
        icon = "fas fa-globe-europe",
        tooltipText = "Territorium",
        tooltipPos = "right",
        style = "";
        job = false,
        blockedjobs = {},
        slot = 15,
        Alerts = 0,
        password = true,
        creator = "QBCore",
        title = "Territory",
    },
}


--PING CONFIG

-- How Long Does The Player Have To Accept The Ping - This Is In Seconds, Set To 0 To Disable
-- NOTE: Notification For Accepting Will Break With This Set To 0 | Will Be Fixed In The Near Future
Config.Timeout = 30

-- How Far Away From Blip Do They Need To Be For Blip To Be Removed - Set To 0 To Disable
Config.DeleteDistance = 10

-- Do you want to try to create a GPS route to ping once accepted?
Config.RouteToPing = true

-- How Long Does The Blip Remain On The Map - This Is In Seconds, Set To 0 To Disable
Config.BlipDuration = 300

-- Blipg Settings - See More @ https://wiki.gtanet.work/index.php?title=Blips
Config.BlipColor = 4
Config.BlipIcon = 280
Config.BlipScale = 0.75

Config.JobCenter = {
    [1] = {
        job = "trucker",
        label = "Trucker",
        Coords = {1204.27, -3106.89, 5.56},
        setjob = false
    },
    [2] = {
        job = "garbage",
        label = "Trash Collector",
        Coords = {-352.32, -1545.52, 27.72},
        setjob = false
    },
    [3] = {
        job = "bus",
        label = "Bus Driver",
        Coords = {462.22, -641.15},
        setjob = true
    },
    [4] = {
        job = "tow",
        label = "Towing [WIP]",
        Coords = {489.67, -1331.82},
        setjob = true
    },
    [5] = {
        job = "taxi",
        label = "Taxi Driver [WIP]",
        Coords = {909.49, -177.24},
        setjob = true
    },
    [6] = {
        job = "lumberjack",
        label = "Logger",
        Coords = {1167.73, -1347.27},
    },
}