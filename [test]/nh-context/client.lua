RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false)
    TriggerEvent(data.event, data.args)
    cb('ok')
end)

RegisterNUICallback("cancel", function()
    SetNuiFocus(false)
end)

RegisterNetEvent('nh-context:sendMenu', function(data)
    if not data then return end
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })
end)

RegisterNetEvent('arcade:buyticket:context', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Bronz Bilet",
            txt = "$15",
            params = {
                event = "rcore_arcade:client:buyTicketBronz"
            }
        },
        {
            id = 2,
            header = "Silver Bilet",
            txt = "$30",
            params = {
                event = "rcore_arcade:client:buyTicketSilver"
            }
        },
        {
            id = 3,
            header = "Gold Bilet",
            txt = "$50",
            params = {
                event = "rcore_arcade:client:buyTicketGold"
            }
        },
    })
end)

RegisterNetEvent('arcade:games:context', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Pacman",
            txt = "",
            params = {
                event = "ld-arcade:openPacman"
            }
        },
        {
            id = 2,
            header = "Tetris",
            txt = "",
            params = {
                event = "ld-arcade:openTetris"
            }
        },
        {
            id = 3,
            header = "Ping Pong",
            txt = "",
            params = {
                event = "ld-arcade:openPingPong"
            }
        },
        {
            id = 4,
            header = "DOOM",
            txt = "",
            params = {
                event = "ld-arcade:openDoom"
            }
        },
        {
            id = 5,
            header = "Duke Nukem 3D",
            txt = "",
            params = {
                event = "ld-arcade:openDukeNukem3D"
            }
        },
        {
            id = 6,
            header = "Wolfenstein 3D",
            txt = "",
            params = {
                event = "ld-arcade:openWolfen"
            }
        },
    })
end)

RegisterNetEvent('rentals:context', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Speedo",
            txt = "$450.00",
            params = {
                event = "rentals:context:speedo",
            }
        },
        {
            id = 2,
            header = "Futo",
            txt = "$600.00",
            params = {
                event = "rentals:context:futo"
            }
        },
        {
            id = 3,
            header = "Bison",
            txt = "$500.00",
            params = {
                event = "rentals:context:bison"
            }
        },
        {
            id = 4,
            header = "Buccaneer",
            txt = "$625.00",
            params = {
                event = "rentals:context:buccaneer"
            }
        },
        {
            id = 5,
            header = "Asea",
            txt = "$250.00",
            params = {
                event = "rentals:context:asea"
            }
        },
    })
end)

RegisterNetEvent('rentals:context:futo', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "< Geri Dön",
            txt = "",
            params = {
                event = "rentals:context"
            }
        },
        {
            id = 2,
            header = "Satın Almayı Onayla",
            txt = "",
            params = {
                event = "ld-rentals:rentFuto"
            }
        },
    })
end)

RegisterNetEvent('rentals:context:bison', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "< Geri Dön",
            txt = "",
            params = {
                event = "rentals:context"
            }
        },
        {
            id = 2,
            header = "Satın Almayı Onayla",
            txt = "",
            params = {
                event = "ld-rentals:rentBison"
            }
        },
    })
end)

RegisterNetEvent('rentals:context:buccaneer', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "< Geri Dön",
            txt = "",
            params = {
                event = "rentals:context"
            }
        },
        {
            id = 2,
            header = "Satın Almayı Onayla",
            txt = "",
            params = {
                event = "ld-rentals:rentBuccaneer"
            }
        },
    })
end)

RegisterNetEvent('rentals:context:asea', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "< Geri Dön",
            txt = "",
            params = {
                event = "rentals:context"
            }
        },
        {
            id = 2,
            header = "Satın Almayı Onayla",
            txt = "",
            params = {
                event = "ld-rentals:rentAsea"
            }
        },
    })
end)

RegisterNetEvent('rentals:context:speedo', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "< Geri Dön",
            txt = "",
            params = {
                event = "rentals:context"
            }
        },
        {
            id = 2,
            header = "Satın Almayı Onayla",
            txt = "",
            params = {
                event = "ld-rentals:rentSpeedo"
            }
        },
    })
end)

RegisterNetEvent('cuval', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Çuval Geçir",
            txt = "Sana en yakın kişinin kafasına çuval geçirir.",
            params = {
                event = "cuvalgecir"
            }
        },
        {
            id = 2,
            header = "Çuval Çıkar",
            txt = "Sana en yakın kişinin kafasındaki çuvalı çıkarır.",
            params = {
                event = "cuvalcikar"
            }
        },
    })
end)

RegisterNetEvent('weazelmicmenu', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Mikrofonu Aç/Kapat",
            txt = "",
            params = {
                event = "Mic:ToggleMic"
            }
        },

    })
end)

RegisterNetEvent('weazelcammenu', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Kamerayı Aç/Kapat",
            txt = "",
            params = {
                event = "Cam:ToggleCam"
            }
        },

    })
end)

RegisterNetEvent('weazelboommenu', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Boom Mikrofonu Aç/Kapat",
            txt = "",
            params = {
                event = "Mic:ToggleBMic"
            }
        },

    })
end)

RegisterNetEvent('weazelnews', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Kamera",
            txt = "",
            params = {
                event = "kameraver:client"
            }
        },
        {
            id = 2,
            header = "Boom Mikrofon",
            txt = "",
            params = {
                event = "bmikver:client"
            }
        },
        {
            id = 3,
            header = "Mikrofon",
            txt = "",
            params = {
                event = "mikver:client"
            }
        },
    })
end)

RegisterNetEvent('speedo', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Speedo",
            txt = "120$",
            params = {
                event = "houseRobberies:rentcar"
            }
        },
    })
end)

RegisterNetEvent('houserob:sellitem', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Heykel",
            txt = "Miktar x 250$",
            params = {
                event = "artifacts:client"
            }
        },
        {
            id = 2,
            header = "Mikrodalga",
            txt = "Miktar x 120$",
            params = {
                event = "microwave:client"
            }
        },
        {
            id = 3,
            header = "Kahve Makinesı",
            txt = "Miktar x 110$",
            params = {
                event = "coffeemachine:client"
            }
        },
        {
            id = 4,
            header = "Bilgisayar",
            txt = "Miktar x 230$",
            params = {
                event = "computer:client"
            }
        },
        {
            id = 5,
            header = "Resim Tablosu",
            txt = "Miktar x 245$",
            params = {
                event = "tableart:client"
            }
        },
        {
            id = 6,
            header = "Televizyon",
            txt = "Miktar x 190$",
            params = {
                event = "television:client"
            }
        },
        {
            id = 7,
            header = "Müzik Radyosu",
            txt = "Miktar x 80$",
            params = {
                event = "musicradio:client"
            }
        },
    })
end)

RegisterNetEvent('towtrucks', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Çekici 1",
            txt = "0$",
            params = {
                event = "openttmenu"
            }
        },
        {
            id = 2,
            header = "Çekici 2",
            txt = "0$",
            params = {
                event = "openttmenu2"
            }
        },
    })
end)

RegisterNetEvent('taxi', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Taksi",
            txt = "0$",
            params = {
                event = "opentaximenu"
            }
        },
    })
end)

RegisterNetEvent('avcisat', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Et",
            txt = "Miktar x 100$",
            params = {
                event = "et:client"
            }
        },
        {
            id = 2,
            header = "1 Yıldız Deri",
            txt = "Miktar x 50$",
            params = {
                event = "birderi:client"
            }
        },
        {
            id = 3,
            header = "2 Yıldız Deri",
            txt = "Miktar x 80$",
            params = {
                event = "ikideri:client"
            }
        },
        {
            id = 5,
            header = "3 Yıldız Deri",
            txt = "Miktar x 160$",
            params = {
                event = "dortderi:client"
            }
        },
    })
end)

RegisterNetEvent('baliksat', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Balina",
            txt = "Miktar x 80$",
            params = {
                event = "whale:client"
            }
        },
        {
            id = 2,
            header = "Köpek Balığı",
            txt = "Miktar x 90$",
            params = {
                event = "shark:client"
            }
        },
        {
            id = 3,
            header = "Levrek",
            txt = "Miktar x 30$",
            params = {
                event = "seabass:client"
            }
        },
        {
            id = 4,
            header = "Lüfer",
            txt = "Miktar x 30$",
            params = {
                event = "bluefish:client"
            }
        },
        {
            id = 5,
            header = "Pisi Balığı",
            txt = "Miktar x 25$",
            params = {
                event = "flounder:client"
            }
        },
        {
            id = 6,
            header = "Uskumru",
            txt = "Miktar x 35$",
            params = {
                event = "mackerel:client"
            }
        },
        {
            id = 7,
            header = "Morina Balığı",
            txt = "Miktar x 35$",
            params = {
                event = "codfish:client"
            }
        },
        {
            id = 8,
            header = "Yunus Balığı ",
            txt = "Miktar x 60$",
            params = {
                event = "dolphin:client"
            }
        },
    })
end)

RegisterNetEvent('colavend', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Soda",
            txt = "5$",
            params = {
                event = "sodaver:client"
            }
        },
        {
            id = 2,
            header = "Kola",
            txt = "5$",
            params = {
                event = "kolaver:client"
            }
        },
    })
end)

RegisterNetEvent('slushyvend', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Slushy",
            txt = "5$",
            params = {
                event = "slushyver:client"
            }
        },
    })
end)

RegisterNetEvent('kahvevend', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Kahve",
            txt = "3$",
            params = {
                event = "kahvever:client"
            }
        },
    })
end)

RegisterNetEvent('cipsvend', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Çikolata",
            txt = "3$",
            params = {
                event = "cikolataver:client"
            }
        },
        {
            id = 2,
            header = "Cips",
            txt = "3$",
            params = {
                event = "cipsver:client"
            }
        },
    })
end)

RegisterNetEvent('suvend', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Su",
            txt = "2$",
            params = {
                event = "suver:client"
            }
        },
    })
end)

RegisterNetEvent('garbagesat', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Geri Dönüştürülebilir Malzeme",
            txt = "Miktar x 20$",
            params = {
                event = "garbage:satkanka"
            }
        },
    })
end)

RegisterNetEvent('burger', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Bleeder",
            txt = "1 Ekmek, 1 Cheddar, 1 Marul, 1 Et | 10s",
            params = {
                event = "bleeder:client"
            }
        },
        {
            id = 2,
            header = "Heart Stopper",
            txt = "1 Ekmek, 1 Cheddar, 1 Marul, 1 Et | 10s",
            params = {
                event = "heartstopper:client"
            }
        },
        {
            id = 3,
            header = "Torpedo",
            txt = "1 Ekmek, 1 Cheddar, 1 Marul, 1 Et | 10s",
            params = {
                event = "torpedo:client"
            }
        },
        {
            id = 4,
            header = "Moneyshot",
            txt = "1 Ekmek, 1 Cheddar, 1 Marul, 1 Et | 10s",
            params = {
                event = "moneyshot:client"
            }
        },
        {
            id = 5,
            header = "Meat Free",
            txt = "1 Ekmek, 1 Marul | 10s",
            params = {
                event = "meatfree:client"
            }
        },
    })
end)

RegisterNetEvent('drink', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Su",
            txt = "- | 5s",
            params = {
                event = "tapwater:client"
            }
        },
        {
            id = 2,
            header = "İçecek",
            txt = "1 Ekmek, 1 Cheddar, 1 Marul, 1 Et | 10s",
            params = {
                event = "softdrink:client"
            }
        },
        {
            id = 3,
            header = "Milkshake",
            txt = "1 Süt, 1 Dondurma | 10s",
            params = {
                event = "milkshake:client"
            }
        },
        {
            id = 4,
            header = "Kahve",
            txt = "1 Kahve Çekirdeği | 10s",
            params = {
                event = "cheapcoffee:client"
            }
        },
    })
end)

RegisterNetEvent('donut', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Donut",
            txt = "- | 15s",
            params = {
                event = "donut:client"
            }
        },
    })
end)

RegisterNetEvent('fries', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Patates Kızartması",
            txt = "1 Patates | 10s",
            params = {
                event = "fries:client"
            }
        },
    })
end)

RegisterNetEvent('patty', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Hamburger Eti",
            txt = "1 Çiğ Et | 10s",
            params = {
                event = "patty:client"
            }
        },
    })
end)


RegisterNetEvent('casinomenu', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Üyelik Kartı Al",
            txt = "1000$",
            params = {
                event = "casinocardal:client"
            }
        },
        {
            id = 2,
            header = "Çip Al",
            txt = "",
            params = {
                event = "chipal"
            }
        },
        {
            id = 3,
            header = "Çip Sat",
            txt = "",
            params = {
                event = "chipsat"
            }
        },

    })
end)

RegisterNetEvent('chipsat', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Çip Miktarı x 1$",
            txt = "",
            params = {
                event = "chipsat:client"
            }
        },
        {
            id = 2,
            header = "Geri",
            txt = "",
            params = {
                event = "casinomenu"
            }
        },
    })
end)

RegisterNetEvent('chipal', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "1x Çip",
            txt = "2$",
            params = {
                event = "chipal:1:client"
            }
        },
        {
            id = 2,
            header = "10x Çip",
            txt = "20$",
            params = {
                event = "chipal:10:client"
            }
        },
        {
            id = 3,
            header = "100x Çip",
            txt = "200$",
            params = {
                event = "chipal:100:client"
            }
        },
        {
            id = 4,
            header = "1000x Çip",
            txt = "2000$",
            params = {
                event = "chipal:1000:client"
            }
        },
        {
            id = 5,
            header = "10000x Çip",
            txt = "20000$",
            params = {
                event = "chipal:10000:client"
            }
        },
        {
            id = 6,
            header = "100000x Çip",
            txt = "200000$",
            params = {
                event = "chipal:100000:client"
            }
        },
        {
            id = 7,
            header = "Geri",
            txt = "",
            params = {
                event = "casinomenu"
            }
        },
    })
end)










