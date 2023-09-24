Config = {}

Config.Objects = {
    ["pestle"] = {model = `v_res_pestle`, freeze = true},
    ["campfire"] = {model = `prop_beach_fire`, freeze = true, placed = false},

}


Config.Delays = {
	territory = 300000   -- how long it takes to check the territory % for gangs to access the weapons crafting.
}


--############################--
   ---- Shared weapons  -----
--############################--


Config.glock = {
    ["items"] = {
        [1] = {
            name = "weapon_glock",
            amount = 50,
            info = {},
            costs = {        --parts    $5000   
                ["metalscrap"] = 10, -- $1000   
                ["steel"] = 10,      -- $1000   
                ["rubber"] = 20,     -- $1000
                ["pistol_barrel"] = 1,     
                ["pistol_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 10x",
                "<br>Steel: 10x",
                "<br>Rubber: 20x",
                "<br>Pistol Barrel: 1x",
                "<br>Pistol Receiver: 1x",  
            },

            type = "item",
            slot = 1,
        },
        [2] = {
            name = "glock_defaultclip",
            amount = 50,
            info = {},
            costs = {
                ["metalscrap"] = 10, -- $1000   
                ["steel"] = 10,      -- $1000 
                ["rubber"] = 20,     -- $1000
            },
            label = {        
                "Metalscrap: 10x",
                "<br>Steel: 10x",
                "<br>Rubber: 20x",
            },
            type = "item",
            slot = 2,
        },   
        [3] = { 
            name = "glock_extendedclip",
            amount = 50,
            info = {},
            costs = {
                ["metalscrap"] = 20, -- $2000   
                ["steel"] = 20,      -- $2000 
                ["rubber"] = 40,     -- $2000 
            },
            label = {        
                "Metalscrap: 20x",
                "<br>Steel: 20x",
                "<br>Rubber: 40x",
            },
            type = "item",
            slot = 3,
        }, 
        [4] = {
            name = "glock_flashlight",
            amount = 50,
            info = {},
            costs = {
                ["metalscrap"] = 10, -- $1000   
                ["steel"] = 10,      -- $1000 
                ["rubber"] = 20,     -- $1000
            },
            label = {        
                "Metalscrap: 10x",
                "<br>Steel: 10x",
                "<br>Rubber: 20x",
            },

            type = "item",
            slot = 4,
        },       
    }
}

















--############################--
	---- Gambinos weapons  -----
--############################--

-- pistols
Config.appistol = {
    ["items"] = {
        [1] = {
            name = "weapon_appistol",
            amount = 1,
            info = {},
            costs = {         
                ["metalscrap"] = 60,    
                ["steel"] = 50,       
                ["rubber"] = 50,     
                ["pistol_barrel"] = 1,     
                ["pistol_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 60x",
                "<br>Steel: 50x",
                "<br>Rubber: 50x",
                "<br>Pistol Barrel: 1x",
                "<br>Pistol Receiver: 1x",  
            },

            type = "item",
            slot = 1,
        },      
    }
}

Config.doubleaction = {
    ["items"] = {
        [1] = {
            name = "weapon_doubleaction",
            amount = 1,
            info = {},
            costs = {         
                ["metalscrap"] = 10,    
                ["steel"] = 10,       
                ["rubber"] = 20,     
                ["pistol_barrel"] = 1,     
                ["pistol_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 10x",
                "<br>Steel: 10x",
                "<br>Rubber: 20x",
                "<br>Pistol Barrel: 1x",
                "<br>Pistol Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },      
    }
}

Config.pistol50 = {
    ["items"] = {
        [1] = {
            name = "weapon_pistol50",
            amount = 1,
            info = {},
            costs = {         
                ["metalscrap"] = 30,    
                ["steel"] = 25,       
                ["rubber"] = 20,     
                ["pistol_barrel"] = 1,     
                ["pistol_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 30x",
                "<br>Steel: 25x",
                "<br>Rubber: 20x",
                "<br>Pistol Barrel: 1x",
                "<br>Pistol Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },      
    }
}

Config.pistol_mk2 = {
    ["items"] = {
        [1] = {
            name = "weapon_pistol_mk2",
            amount = 1,
            info = {},
            costs = {         
                ["metalscrap"] = 20,    
                ["steel"] = 15,       
                ["rubber"] = 20,     
                ["pistol_barrel"] = 1,     
                ["pistol_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 20x",
                "<br>Steel: 15x",
                "<br>Rubber: 20x",
                "<br>Pistol Barrel: 1x",
                "<br>Pistol Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },      
    }
}






--smg



Config.microsmg = {
    ["items"] = {
        [1] = {
            name = "weapon_microsmg",
            amount = 50,
            info = {},
            costs = {         
                ["metalscrap"] = 25,  
                ["steel"] = 20,         
                ["rubber"] = 20,     
                ["smg_barrel"] = 1,        
                ["smg_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 25x",
                "<br>Steel: 20x",
                "<br>Rubber: 20x",
                "<br>SMG Barrel: 1x",
                "<br>SMG Receiver: 1x",  
            },
            type = "item",
            slot = 1,
            threshold = "weapon_microsmg",
            points = 1,
        },
        [2] = {
            name = "microsmg_defaultclip",
            amount = 50,
            info = {},
            costs = {
                ["metalscrap"] = 10, -- $1000   
                ["steel"] = 10,      -- $1000 
                ["rubber"] = 20,     -- $1000
            },
            label = {        
                "Metalscrap: 10x",
                "<br>Steel: 10x",
                "<br>Rubber: 20x",
            },
            type = "item",
            slot = 2,
            threshold = "microsmg_defaultclip",
            points = 1,
        },   
        [3] = {
            name = "microsmg_extendedclip",
            amount = 50,
            info = {},
            costs = {
                ["metalscrap"] = 25, -- $2500   
                ["steel"] = 25,      -- $2500 
                ["rubber"] = 40,     -- $2000 
            },
            label = {        
                "Metalscrap: 25x",
                "<br>Steel: 25x",
                "<br>Rubber: 40x",
            },
            type = "item",
            slot = 3,
            threshold = "microsmg_extendedclip",
            points = 1,
        }, 
        [4] = {
            name = "microsmg_scope",
            amount = 50,
            info = {},
            costs = {
                ["metalscrap"] = 20, -- $2000   
                ["steel"] = 20,      -- $2000 
                ["rubber"] = 50,     -- $3000 
            },
            label = {        
                "Metalscrap: 20x",
                "<br>Steel: 20x",
                "<br>Rubber: 50x",
            },
            type = "item",
            slot = 4,
            threshold = "microsmg_scope",
            points = 1,
        },            
    }
}



Config.gusenberg = {
    ["items"] = {
        [1] = {
            name = "weapon_gusenberg",
            amount = 50,
            info = {},
            costs = {          
                ["metalscrap"] = 25,  
                ["steel"] = 20,         
                ["rubber"] = 20,       
                ["smg_barrel"] = 1,        
                ["smg_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 25x",
                "<br>Steel: 20x",
                "<br>Rubber: 20x",
                "<br>SMG Barrel: 1x",
                "<br>SMG Receiver: 1x",  
            },
            type = "item",
            slot = 1,
            points = 1,
        },          
    }
}


Config.machinepistol = {
    ["items"] = {
        [1] = {
            name = "weapon_machinepistol",
            amount = 50,
            info = {},
            costs = {          
                ["metalscrap"] = 25,  
                ["steel"] = 10,         
                ["rubber"] = 20,       
                ["smg_barrel"] = 1,        
                ["smg_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 25x",
                "<br>Steel: 10x",
                "<br>Rubber: 20x",
                "<br>SMG Barrel: 1x",
                "<br>SMG Receiver: 1x",  
            },
            type = "item",
            slot = 1,
            points = 1,
        },          
    }
}

Config.microsmg3 = {
    ["items"] = {
        [1] = {
            name = "weapon_microsmg3",
            amount = 50,
            info = {},
            costs = {          
                ["metalscrap"] = 35,  
                ["steel"] = 20,         
                ["rubber"] = 20,       
                ["smg_barrel"] = 1,        
                ["smg_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 35x",
                "<br>Steel: 20x",
                "<br>Rubber: 20x",
                "<br>SMG Barrel: 1x",
                "<br>SMG Receiver: 1x",  
            },
            type = "item",
            slot = 1,
            points = 1,
        },          
    }
}


Config.smg_mk2 = {
    ["items"] = {
        [1] = {
            name = "weapon_smg_mk2",
            amount = 50,
            info = {},
            costs = {          
                ["metalscrap"] = 35,  
                ["steel"] = 30,         
                ["rubber"] = 20,       
                ["smg_barrel"] = 1,        
                ["smg_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 35x",
                "<br>Steel: 30x",
                "<br>Rubber: 20x",
                "<br>SMG Barrel: 1x",
                "<br>SMG Receiver: 1x",  
            },
            type = "item",
            slot = 1,
            points = 1,
        },          
    }
}




-- AR's

Config.m4 = {
    ["items"] = {
        [1] = {
            name = "weapon_m4",
            amount = 50,
            info = {},
            costs = {          
                ["metalscrap"] = 55,  
                ["steel"] = 45,         
                ["rubber"] = 60,     
                ["assaultrifle_barrel"] = 1,        
                ["assaultrifle_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 55x",
                "<br>Steel: 45x",
                "<br>Rubber: 60x",
                "<br>Assaultrifle Barrel: 1x",
                "<br>Assaultrifle Receiver: 1x",  
            },
            type = "item",
            slot = 1,
            threshold = "weapon_m4",
            points = 1,
        }, 

        [2] = {
            name = "m4_flashlight",
            amount = 50,
            info = {},
            costs = {
                ["metalscrap"] = 20, -- $2000   
                ["steel"] = 20,      -- $2000 
                ["rubber"] = 20,     -- $1000 
            },
            label = {        
                "Metalscrap: 20x",
                "<br>Steel: 20x",
                "<br>Rubber: 20x",
            },
            type = "item",
            slot = 2,
            threshold = "m4_flashlight",
            points = 1,
        },   
        [3] = {
            name = "m4_ironsight",
            amount = 50,
            info = {},
            costs = {
                ["metalscrap"] = 10, -- $1000   
                ["steel"] = 10,      -- $1000 
                ["rubber"] = 20,     -- $1000 
            },
            label = {        
                "Metalscrap: 10x",
                "<br>Steel: 10x",
                "<br>Rubber: 20x",
            },
            type = "item",
            slot = 3,
            threshold = "m4_ironsight",
            points = 1,
        }, 
        [4] = {
            name = "m4_holographic",
            amount = 50,
            info = {},
            costs = {
                ["metalscrap"] = 30, -- $3000   
                ["steel"] = 20,      -- $2000 
                ["rubber"] = 40,     -- $2000 
            },
            label = {        
                "Metalscrap: 30x",
                "<br>Steel: 20x",
                "<br>Rubber: 40x",
            },
            type = "item",
            slot = 4,
            threshold = "m4_holographic",
            points = 1,
        },    
        [5] = {
            name = "m4_muzzle",
            amount = 50,
            info = {},
            costs = {
                ["metalscrap"] = 30, -- $3000   
                ["steel"] = 30,      -- $3000 
            },
            label = {        
                "Metalscrap: 30x",
                "<br>Steel: 30x",
            },
            type = "item",
            slot = 5,
            threshold = "m4_muzzle",
            points = 1,
        }, 
        [6] = {
            name = "m4_grip",
            amount = 50,
            info = {},
            costs = {
                ["metalscrap"] = 20, -- $2000   
                ["steel"] = 10,      -- $1000 
                ["rubber"] = 60,     -- $3000 
            },
            label = {        
                "Metalscrap: 20x",
                "<br>Steel: 10x",
                "<br>Rubber: 60x",
            },
            type = "item",
            slot = 6,
            threshold = "m4_grip",
            points = 1,
        }, 
    }
}


Config.bullpuprifle = {
    ["items"] = {
        [1] = {
            name = "weapon_bullpuprifle",
            amount = 50,
            info = {},
            costs = {          
                ["metalscrap"] = 40,  
                ["steel"] = 45,           
                ["rubber"] = 50,     
                ["assaultrifle_barrel"] = 1,        
                ["assaultrifle_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 40x",
                "<br>Steel: 45x",
                "<br>Rubber: 50x",
                "<br>Assaultrifle Barrel: 1x",
                "<br>Assaultrifle Receiver: 1x",  
            },
            type = "item",
            slot = 1,
            points = 1,
        }, 
    }
}

Config.carbinerifle_mk2 = {
    ["items"] = {
        [1] = {
            name = "weapon_carbinerifle_mk2",
            amount = 50,
            info = {},
            costs = {          
                ["metalscrap"] = 50,  
                ["steel"] = 45,           
                ["rubber"] = 60,     
                ["assaultrifle_barrel"] = 1,        
                ["assaultrifle_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 50x",
                "<br>Steel: 45x",
                "<br>Rubber: 60x",
                "<br>Assaultrifle Barrel: 1x",
                "<br>Assaultrifle Receiver: 1x",  
            },
            type = "item",
            slot = 1,
            points = 1,
        }, 
    }
}


Config.carbinerifle = {
    ["items"] = {
        [1] = {
            name = "weapon_carbinerifle",
            amount = 50,
            info = {},
            costs = {          
                ["metalscrap"] = 45,  
                ["steel"] = 50,           
                ["rubber"] = 50,     
                ["assaultrifle_barrel"] = 1,        
                ["assaultrifle_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 45x",
                "<br>Steel: 50x",
                "<br>Rubber: 50x",
                "<br>Assaultrifle Barrel: 1x",
                "<br>Assaultrifle Receiver: 1x",  
            },
            type = "item",
            slot = 1,
            points = 1,
        }, 
    }
}


Config.specialcarbine = {
    ["items"] = {
        [1] = {
            name = "weapon_specialcarbine",
            amount = 50,
            info = {},
            costs = {          
                ["metalscrap"] = 45,  
                ["steel"] = 40,           
                ["rubber"] = 50,     
                ["assaultrifle_barrel"] = 1,        
                ["assaultrifle_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 45x",
                "<br>Steel: 40x",
                "<br>Rubber: 50x",
                "<br>Assaultrifle Barrel: 1x",
                "<br>Assaultrifle Receiver: 1x",  
            },
            type = "item",
            slot = 1,
            points = 1,
        }, 
    }
}






--shotguns

Config.autoshotgun = {
    ["items"] = {
        [1] = {
            name = "weapon_autoshotgun",
            amount = 50,
            info = {},
            costs = {        
                ["metalscrap"] = 45,  
                ["steel"] = 35,       
                ["rubber"] = 30,     
                ["shotgun_barrel"] = 1,        
                ["shotgun_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 45x",
                "<br>Steel: 35x",
                "<br>Rubber: 30x",
                "<br>Shotgun Barrel: 1x",
                "<br>Shotgun Receiver: 1x",  
            },
            type = "item",
            slot = 1,
            points = 1,
        },           
    }
}


Config.bullpupshotgun = {
    ["items"] = {
        [1] = {
            name = "weapon_bullpupshotgun",
            amount = 50,
            info = {},
            costs = {        
                ["metalscrap"] = 45,  
                ["steel"] = 35,       
                ["rubber"] = 40,     
                ["shotgun_barrel"] = 1,        
                ["shotgun_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 45x",
                "<br>Steel: 35x",
                "<br>Rubber: 40x",
                "<br>Shotgun Barrel: 1x",
                "<br>Shotgun Receiver: 1x",  
            },
            type = "item",
            slot = 1,
            points = 1,
        },           
    }
}

Config.heavyshotgun = {
    ["items"] = {
        [1] = {
            name = "weapon_heavyshotgun",
            amount = 50,
            info = {},
            costs = {        
                ["metalscrap"] = 45,  
                ["steel"] = 45,       
                ["rubber"] = 50,     
                ["shotgun_barrel"] = 1,        
                ["shotgun_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 45x",
                "<br>Steel: 45x",
                "<br>Rubber: 50x",
                "<br>Shotgun Barrel: 1x",
                "<br>Shotgun Receiver: 1x",  
            },
            type = "item",
            slot = 1,
            points = 1,
        },           
    }
}


Config.sawnoffshotgun = {
    ["items"] = {
        [1] = {
            name = "weapon_sawnoffshotgun",
            amount = 50,
            info = {},
            costs = {        
                ["metalscrap"] = 35,  
                ["steel"] = 45,       
                ["rubber"] = 30,     
                ["shotgun_barrel"] = 1,        
                ["shotgun_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 35x",
                "<br>Steel: 45x",
                "<br>Rubber: 30x",
                "<br>Shotgun Barrel: 1x",
                "<br>Shotgun Receiver: 1x",  
            },
            type = "item",
            slot = 1,
            points = 1,
        },           
    }
}


Config.pumpshotgun = {
    ["items"] = {
        [1] = {
            name = "weapon_pumpshotgun",
            amount = 50,
            info = {},
            costs = {        
                ["metalscrap"] = 45,  
                ["steel"] = 35,       
                ["rubber"] = 40,     
                ["shotgun_barrel"] = 1,        
                ["shotgun_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 45x",
                "<br>Steel: 35x",
                "<br>Rubber: 40x",
                "<br>Shotgun Barrel: 1x",
                "<br>Shotgun Receiver: 1x",  
            },
            type = "item",
            slot = 1,
            points = 1,
        },           
    }
}





-- DMR's

Config.musket = {
    ["items"] = {
        [1] = {
            name = "weapon_musket",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 30,  
                ["steel"] = 30,         
                ["rubber"] = 40,     
                ["dmr_barrel"] = 1,        
                ["dmr_receiver"] = 1,      
            },
            label = {        
                "Metalscrap: 30x",
                "<br>Steel: 30x",
                "<br>Rubber: 40x",
                "<br>DMR Barrel: 1x",
                "<br>DMR Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}


Config.enfield = {
    ["items"] = {
        [1] = {
            name = "weapon_enfield",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 40,  
                ["steel"] = 45,         
                ["rubber"] = 45,     
                ["dmr_barrel"] = 1,        
                ["dmr_receiver"] = 1,      
            },
            label = {        
                "Metalscrap: 40x",
                "<br>Steel: 45x",
                "<br>Rubber: 45x",
                "<br>DMR Barrel: 1x",
                "<br>DMR Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}




-- MG's

Config.combatmg = {
    ["items"] = {
        [1] = {
            name = "weapon_combatmg",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 40,  
                ["steel"] = 40,         
                ["rubber"] = 60,     
                ["lmg_barrel"] = 1,        
                ["lmg_receiver"] = 1,      
            },
            label = {        
                "Metalscrap: 40x",
                "<br>Steel: 40x",
                "<br>Rubber: 60x",
                "<br>LMG Barrel: 1x",
                "<br>LMG Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}














--############################--
	---- ira weapons  -----
--############################--



   

-- SMG's

Config.assaultsmg = {
    ["items"] = {
        [1] = {
            name = "weapon_assaultsmg",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 25,   
                ["steel"] = 10,      
                ["rubber"] = 20,         
                ["smg_barrel"] = 1,        
                ["smg_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 25x",
                "<br>Steel: 10x",
                "<br>Rubber: 20x",
                "<br>SMG Barrel: 1x",
                "<br>SMG Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}


Config.compactrifle = {
    ["items"] = {
        [1] = {
            name = "weapon_compactrifle",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 25,   
                ["steel"] = 10,      
                ["rubber"] = 20,    
                ["smg_barrel"] = 1,        
                ["smg_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 25x",
                "<br>Steel: 10x",
                "<br>Rubber: 20x",
                "<br>SMG Barrel: 1x",
                "<br>SMG Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}


Config.microsmg2 = {
    ["items"] = {
        [1] = {
            name = "weapon_microsmg2",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 25,   
                ["steel"] = 10,      
                ["rubber"] = 20,    
                ["smg_barrel"] = 1,        
                ["smg_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 25x",
                "<br>Steel: 10x",
                "<br>Rubber: 20x",
                "<br>SMG Barrel: 1x",
                "<br>SMG Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}


Config.minismg = {
    ["items"] = {
        [1] = {
            name = "weapon_minismg",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 25,   
                ["steel"] = 10,      
                ["rubber"] = 20,    
                ["smg_barrel"] = 1,        
                ["smg_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 25x",
                "<br>Steel: 10x",
                "<br>Rubber: 20x",
                "<br>SMG Barrel: 1x",
                "<br>SMG Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}


Config.smg = {
    ["items"] = {
        [1] = {
            name = "weapon_smg",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 25,   
                ["steel"] = 10,      
                ["rubber"] = 20,    
                ["smg_barrel"] = 1,        
                ["smg_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 25x",
                "<br>Steel: 10x",
                "<br>Rubber: 20x",
                "<br>SMG Barrel: 1x",
                "<br>SMG Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}




-- AR's


Config.advancedrifle = {
    ["items"] = {
        [1] = {
            name = "weapon_advancedrifle",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 50,  
                ["steel"] = 45,          
                ["rubber"] = 60,      
                ["assaultrifle_barrel"] = 1,        
                ["assaultrifle_receiver"] = 1,      
            },
            label = {        
                "Metalscrap: 50x",
                "<br>Steel: 45x",
                "<br>Rubber: 60x",
                "<br>Assaultrifle Barrel: 1x",
                "<br>Assaultrifle Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}


Config.assaultrifle_mk2 = {
    ["items"] = {
        [1] = {
            name = "weapon_assaultrifle_mk2",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 50,  
                ["steel"] = 45,           
                ["rubber"] = 60,     
                ["assaultrifle_barrel"] = 1,        
                ["assaultrifle_receiver"] = 1,      
            },
            label = {        
                "Metalscrap: 50x",
                "<br>Steel: 45x",
                "<br>Rubber: 60x",
                "<br>Assaultrifle Barrel: 1x",
                "<br>Assaultrifle Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}


Config.assaultrifle2 = {
    ["items"] = {
        [1] = {
            name = "weapon_assaultrifle2",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 50,  
                ["steel"] = 45,           
                ["rubber"] = 60,     
                ["assaultrifle_barrel"] = 1,        
                ["assaultrifle_receiver"] = 1,      
            },
            label = {        
                "Metalscrap: 50x",
                "<br>Steel: 45x",
                "<br>Rubber: 60x",
                "<br>Assaultrifle Barrel: 1x",
                "<br>Assaultrifle Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}


Config.assaultrifle = {
    ["items"] = {
        [1] = {
            name = "weapon_assaultrifle",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 50,  
                ["steel"] = 45,            
                ["rubber"] = 60,     
                ["assaultrifle_barrel"] = 1,        
                ["assaultrifle_receiver"] = 1,      
            },
            label = {        
                "Metalscrap: 50x",
                "<br>Steel: 45x",
                "<br>Rubber: 60x",
                "<br>Assaultrifle Barrel: 1x",
                "<br>Assaultrifle Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}


Config.bullpuprifle_mk2 = {
    ["items"] = {
        [1] = {
            name = "weapon_bullpuprifle_mk2",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 50,  
                ["steel"] = 45,           
                ["rubber"] = 60,     
                ["assaultrifle_barrel"] = 1,        
                ["assaultrifle_receiver"] = 1,      
            },
            label = {        
                "Metalscrap: 50x",
                "<br>Steel: 45x",
                "<br>Rubber: 60x",
                "<br>Assaultrifle Barrel: 1x",
                "<br>Assaultrifle Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}


Config.militaryrifle = {
    ["items"] = {
        [1] = {
            name = "weapon_militaryrifle",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 50,  
                ["steel"] = 45,         
                ["rubber"] = 60,     
                ["assaultrifle_barrel"] = 1,        
                ["assaultrifle_receiver"] = 1,      
            },
            label = {        
                "Metalscrap: 50x",
                "<br>Steel: 45x",
                "<br>Rubber: 60x",
                "<br>Assaultrifle Barrel: 1x",
                "<br>Assaultrifle Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}


Config.specialcarbine_mk2 = {
    ["items"] = {
        [1] = {
            name = "weapon_specialcarbine_mk2",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 50,  
                ["steel"] = 45,           
                ["rubber"] = 60,     
                ["assaultrifle_barrel"] = 1,        
                ["assaultrifle_receiver"] = 1,      
            },
            label = {        
                "Metalscrap: 50x",
                "<br>Steel: 45x",
                "<br>Rubber: 60x",
                "<br>Assaultrifle Barrel: 1x",
                "<br>Assaultrifle Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}






-- shotguns



Config.assaultshotgun = {
    ["items"] = {
        [1] = {
            name = "weapon_assaultshotgun",
            amount = 50,
            info = {},
            costs = {          
                ["metalscrap"] = 25,  
                ["steel"] = 25,        
                ["rubber"] = 40,     
                ["shotgun_barrel"] = 1,        
                ["shotgun_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 25x",
                "<br>Steel: 25x",
                "<br>Rubber: 40x",
                "<br>Shotgun Barrel: 1x",
                "<br>Shotgun Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },           
    }
}


Config.combatshotgun = {
    ["items"] = {
        [1] = {
            name = "weapon_combatshotgun",
            amount = 50,
            info = {},
            costs = {          
                ["metalscrap"] = 25,  
                ["steel"] = 25,        
                ["rubber"] = 40,     
                ["shotgun_barrel"] = 1,        
                ["shotgun_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 25x",
                "<br>Steel: 25x",
                "<br>Rubber: 40x",
                "<br>Shotgun Barrel: 1x",
                "<br>Shotgun Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },           
    }
}


Config.dbshotgun = {
    ["items"] = {
        [1] = {
            name = "weapon_dbshotgungun",
            amount = 50,
            info = {},
            costs = {          
                ["metalscrap"] = 25,  
                ["steel"] = 25,        
                ["rubber"] = 40,     
                ["shotgun_barrel"] = 1,        
                ["shotgun_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 25x",
                "<br>Steel: 25x",
                "<br>Rubber: 40x",
                "<br>Shotgun Barrel: 1x",
                "<br>Shotgun Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },           
    }
}


Config.pumpshotgun_mk2 = {
    ["items"] = {
        [1] = {
            name = "weapon_pumpshotgun_mk2",
            amount = 50,
            info = {},
            costs = {          
                ["metalscrap"] = 25,  
                ["steel"] = 25,        
                ["rubber"] = 40,     
                ["shotgun_barrel"] = 1,        
                ["shotgun_receiver"] = 1,     
            },
            label = {        
                "Metalscrap: 25x",
                "<br>Steel: 25x",
                "<br>Rubber: 40x",
                "<br>Shotgun Barrel: 1x",
                "<br>Shotgun Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },           
    }
}







-- DMR's

Config.dragunov = {
    ["items"] = {
        [1] = {
            name = "weapon_dragunov",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 40,  
                ["steel"] = 40,         
                ["rubber"] = 60,     
                ["dmr_barrel"] = 1,        
                ["dmr_receiver"] = 1,      
            },
            label = {        
                "Metalscrap: 40x",
                "<br>Steel: 40x",
                "<br>Rubber: 60x",
                "<br>DMR Barrel: 1x",
                "<br>DMR Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}



-- MG's

Config.mg = {
    ["items"] = {
        [1] = {
            name = "weapon_mg",
            amount = 1,
            info = {},
            costs = {        
                ["metalscrap"] = 40,  
                ["steel"] = 40,         
                ["rubber"] = 60,     
                ["lmg_barrel"] = 1,        
                ["lmg_receiver"] = 1,      
            },
            label = {        
                "Metalscrap: 40x",
                "<br>Steel: 40x",
                "<br>Rubber: 60x",
                "<br>LMG Barrel: 1x",
                "<br>LMG Receiver: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}




-- explosives


Config.grenade = {
    ["items"] = {
        [1] = {
            name = "weapon_grenade",
            amount = 1,
            info = {},
            costs = {     
                ["steel"] = 40,         
                ["rubber"] = 20,         
                ["explosives"] = 1,        
                ["grenade_shell"] = 1,      
            },
            label = {        
                "Steel: 40x",
                "<br>Rubber: 20x",
                "<br>Explosives: 1x",
                "<br>Frenade Shell: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}


Config.molotov = {
    ["items"] = {
        [1] = {
            name = "weapon_molotov",
            amount = 1,
            info = {},
            costs = {         
                ["jerry_can"] = 1,         
                ["glass"] = 40,         
            },
            label = {        
                "Gas Can: 1x",
                "<br>glass: 40x",
            },
            type = "item",
            slot = 1,
        },       
    }
}



Config.pipebomb = {
    ["items"] = {
        [1] = {
            name = "weapon_pipebomb",
            amount = 1,
            info = {},
            costs = {   
                ["steel"] = 40,         
                ["rubber"] = 20,     
                ["explosives"] = 1,        
                ["detinator"] = 1,         
            },
            label = {        
                "Steel: 40x",
                "<br>Rubber: 20x",
                "<br>Explosives: 1x",
                "<br>Detinator: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}


Config.stickybomb = {
    ["items"] = {
        [1] = {
            name = "weapon_stickybomb",
            amount = 1,
            info = {},
            costs = {    
                ["steel"] = 40,         
                ["rubber"] = 20,     
                ["explosives"] = 1,        
                ["remote_detinator"] = 1,         
            },
            label = {        
                "Steel: 40x",
                "<br>Rubber: 20x",
                "<br>Explosives: 1x",
                "<br>Remote Detinator: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}


Config.rpg = {
    ["items"] = {
        [1] = {
            name = "weapon_rpg",
            amount = 1,
            info = {},
            costs = {    
                ["steel"] = 40,         
                ["explosives"] = 1,        
                ["rpg_shell"] = 1,         
            },
            label = {        
                "Steel: 40x",
                "<br>Explosives: 1x",
                "<br>RPG Shell: 1x",  
            },
            type = "item",
            slot = 1,
        },       
    }
}








Config.ammo = {
    ["items"] = {
        [1] = {
            name = "pistol_ammo",
            amount = 50,
            info = {},
            costs = {         
                ["metalscrap"] = 5,    
                ["gunpowder"] = 2,            
            },
            label = {        
                "Metalscrap: 5x",
                "<br>Gunpowder: 2x",
            },

            type = "item",
            slot = 1,
        },   
        [2] = {
            name = "smg_ammo",
            amount = 50,
            info = {},
            costs = {         
                ["metalscrap"] = 7,    
                ["gunpowder"] = 2,             
            },
            label = {        
                "Metalscrap: 7x",
                "<br>Gunpowder: 2x",
            },

            type = "item",
            slot = 2,
        },    
        [3] = {
            name = "shotgun_ammo",
            amount = 50,
            info = {},
            costs = {         
                ["metalscrap"] = 10,    
                ["gunpowder"] = 3,              
            },
            label = {        
                "Metalscrap: 10x",
                "<br>Gunpowder: 3x",
            },

            type = "item",
            slot = 3,
        },  
        [4] = {
            name = "rifle_ammo",
            amount = 50,
            info = {},
            costs = {         
                ["metalscrap"] = 12,    
                ["gunpowder"] = 5,               
            },
            label = {        
                "Metalscrap: 12x",
                "<br>Gunpowder: 5x",
            },

            type = "item",
            slot = 4,
        },
        [5] = {
            name = "snp_ammo",
            amount = 50,
            info = {},
            costs = {         
                ["metalscrap"] = 15,    
                ["gunpowder"] = 7,               
            },
            label = {        
                "Metalscrap: 15x",
                "<br>Gunpowder: 7x",
            },

            type = "item",
            slot = 5,
        },
        [6] = {
            name = "mg_ammo",
            amount = 50,
            info = {},
            costs = {         
                ["metalscrap"] = 15,    
                ["gunpowder"] = 7,               
            },
            label = {        
                "Metalscrap: 15x",
                "<br>Gunpowder: 7x",
            },

            type = "item",
            slot = 6,
        },

    }
}