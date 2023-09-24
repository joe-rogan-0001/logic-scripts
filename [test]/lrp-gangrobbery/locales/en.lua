local Translations = {
    error = {
        ["canceled"]                    = "Canceled",
        ["someone_recently_did_this"]   = "Someone recently did this, try again later..",
        ["cannot_do_this_right_now"]    = "Cannot do this right now...",
        ["you_failed"]                  = "You failed!",
        ["you_cannot_do_this"]          = "You cannot do this..",
        ["you_dont_have_enough_money"]  = "You Dont Have Enough Money",
    },
    success = {
        ["case_has_been_unlocked"]              = "Crate has been unlocked",
        ["you_removed_first_security_case"]     = "You removed the the first layer of security",
        ["you_got_paid"]                        = "There you go homie!",
        ["send_email_right_now"]                 = "I've sent you an email containing more info!",
        ["case_beep"]                           = "There is something beeping??",
    },
    info = {
        ["talking_to_boss"]             = "Talking to boss..",
        ["unlocking_case"]              = "Unlocking crate..",
        ["checking_quality"]            = "Checking through crate..",
    },
    mailstart = {
        ["sender"]                      = "Unknown",
        ["subject"]                     = "Vehicle Location",
        ["message"]                     = "Updated your gps with the location to a vehicle I got a tip about, vehicle contains a crate with some stuff that a local gang stole from me... Retrieve the crate and I'll let you keep the other shit they've stored inside it. I've given you a key that should unlock the crate... Make sure you bring weapons as the crate is being guarded by armed gangsters.. BE CAREFUL!",
    },
    mail = {
        ["sender"]                      = "Unknown",
        ["subject"]                     = "Delivery",
        ["message"]                     = "Good job playa, the second layer of protection should be disabled after 5 minutes. Stay away from cops and bring the crate back to me after the time is up",
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
