local Translations = {
    error = {
        ["already_mission"] = "You Are Already Doing An NPC Mission",
        ["not_in_taxi"] = "You Are Not In A Taxi",
        ["missing_meter"] = "This Vehicle Has No Taxi Meter",
        ["no_vehicle"] = "You're not in a vehicle",
        ["not_active_meter"] = "The Taxi Meter Is Not Active",
        ["no_meter_sight"] = "No Taxi Meter In Sight",
        ["no_mission_active"] = "You dont have any mission to cancel"
    },
    success = {
        ["mission_cancelled"] = "Mission canceled successfully",
    },
    info = {
        ["person_was_dropped_off"] = "Person Was Dropped Off!",
        ["npc_on_gps"] = "The NPC Is Indicated On Your GPS",
        ["go_to_location"] = "Bring The NPC To The Specified Location",
        ["vehicle_parking"] = "[E] Vehicle Parking",
        ["job_vehicles"] = "[E] Job Vehicles",
        ["drop_off_npc"] = "[E] Drop Off NPC",
        ["call_npc"] = "[E] Call NPC",
        ["blip_name"] = "Downtown Cab",
        ["taxi_label_1"] = "Standard Cab",
        ["no_spawn_point"] = "Unable to find a location to bring the cab",
        ["taxi_returned"] = "Cab Parked",
        ["on_duty"] = "[E] - Go on duty",
        ["on_duty"] = "[E] - Go off duty"
    },
    menu = {
        ["taxi_menu_header"] = "Taxi Vehicles",
        ["close_menu"] = "⬅ Close Menu",
        ['boss_menu'] = "Boss Menu"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
