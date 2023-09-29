Config = {}


-- allows for 3 different sql wrappers, mysql-async, ghmattisql, oxmysql
-- make sure you edit your fxmanifest if you plan on using somethin different than mysql-async.
-- see line 1268 for the function this relates to. everything is self explanatory.
Config.Mysql = 'oxmysql'

Config["Offences"] = {
    [1] = {
        [1] = {months = 10, class = "Misdemeanor", id = "P.C. 1001", color = "green", fine = 200, title = "Simple Assault"},
        [2] = {months = 20, class = "Misdemeanor", id = "P.C. 1002", color = "orange", fine = 450, title = "Assault"},
        [3] = {months = 30, class = "Felony", id = "P.C. 1003", color = "orange", fine = 700, title = "Aggravated Assault"},
        [4] = {months = 50, class = "Felony", id = "P.C. 1004", color = "red", fine = 2500, title = "Assault with a deadly weapon"},
        [5] = {months = 30, class = "Felony", id = "P.C. 1005", color = "red", fine = 3000, title = "Involuntary Manslaughter"},
        [6] = {months = 60, class = "Felony", id = "P.C. 1006", color = "red", fine = 10000, title = "Voluntary Manslaughter"},
        [7] = {months = 100, class = "Felony", id = "P.C. 1007", color = "red", fine = 3000, title = "Vehicular Manslaughter"},
        [8] = {months = 50, class = "Felony", id = "P.C. 1008", color = "red", fine = 5000, title = "Attempted Murder of a civilian"},
        [9] = {months = 100, class = "Felony", id = "P.C. 1009", color = "red", fine = 6000, title = "Second Degree Murder"},
        [10] = {months = 100, class = "Felony", id = "P.C. 1010", color = "red", fine = 11250, title = "Accessory to Second Degree Murder"},
        [11] = {months = 150, class = "Felony", id = "P.C. 1011", color = "red", fine = 22500, title = "First Degree Murder"},
        [12] = {months = 125, class = "Felony", id = "P.C. 1012", color = "red", fine = 11250, title = "Accessory to First Degree Murder"},
        [13] = {months = 40, class = "Felony", id = "P.C. 1013", color = "red", fine = 5000, title = "Murder of a of a Government Employee"},
        [14] = {months = 40, class = "Felony", id = "P.C. 1014", color = "red", fine = 2500, title = "Attempted Murder of a Government Employee"},
        [15] = {months = 35, class = "Felony", id = "P.C. 1015", color = "red", fine = 2000, title = "Accessory to the Murder of a Government Employee"},
        [16] = {months = 20, class = "Misdemeanor", id = "P.C. 1016", color = "green", fine = 4000, title = "Unlawful Imprisonment"},
        [17] = {months = 30, class = "Felony", id = "P.C. 1017", color = "orange", fine = 6000, title = "Kidnapping"},
        [18] = {months = 50, class = "Felony", id = "P.C. 1018", color = "orange", fine = 1000, title = "Hostage Taking"},
        [19] = {months = 50, class = "Misdemeanor", id = "P.C. 1019", color = "orange", fine = 3000, title = "Criminal Threats"},
        [20] = {months = 10, class = "Misdemeanor", id = "P.C. 1020", color = "orange", fine = 5000, title = "Reckless Endagerment"},
        [21] = {months = 60, class = "Felony", id = "P.C. 1021", color = "red", fine = 4000, title = "Gang Related Shooting"},
        [22] = {months = 100, class = "Felony", id = "P.C. 1022", color = "orange", fine = 5000, title = "Unlawful Imprisonment of a Government Employee"},
        [23] = {months = 40, class = "Felony", id = "P.C. 1023", color = "red", fine = 2000, title = "Cannibalism"},
        [24] = {months = 40, class = 'Felony', id = 'P.C. 1024', color = 'red', fine = 200, title = 'Torture'},
    },
    [2] = {
        [1] = {months = 0, class = 'Infraction', id = 'P.C. 2001', color = 'green', fine = 200, title = 'Petty Theft'},
        [2] = {months = 10, class = 'Misdemeanor', id = 'P.C. 2002', color = 'green', fine = 400, title = 'Grand Theft'},
        [3] = {months = 20, class = 'Felony', id = 'P.C. 2003', color = 'green', fine = 600, title = 'Grand Theft Auto A'},
        [4] = {months = 50, class = 'Felony', id = 'P.C. 2004', color = 'green', fine = 5000, title = 'Grand Theft Auto B'},
        [5] = {months = 20, class = 'Misdemeanor', id = 'P.C. 2005', color = 'green', fine = 300, title = 'Burglary'},
        [6] = {months = 20, class = 'Felony', id = 'P.C. 2006', color = 'green', fine = 400, title = 'Robbery (A)'},
        [7] = {months = 15, class = 'Felony', id = 'P.C. 2007', color = 'green', fine = 200, title = 'Attempted Robbery (A)'},
        [8] = {months = 5, class = 'Felony', id = 'P.C. 2008', color = 'orange', fine = 100, title = 'Accessory to Robbery (A)'},
        [9] = {months = 20, class = 'Felony', id = 'P.C. 2009', color = 'orange', fine = 600, title = 'Armed Robbery (A)'},
        [10] = {months = 15, class = 'Felony', id = 'P.C. 2010', color = 'orange', fine = 300, title = 'Attempted Armed Robbery (A)'},
        [11] = {months = 10, class = 'Felony', id = 'P.C. 2011', color = 'green', fine = 300, title = 'Accessory to Armed Robbery (A)'},
        [12] = {months = 25, class = 'Felony', id = 'P.C. 2012', color = 'green', fine = 800, title = 'Robbery (B)'},
        [13] = {months = 20, class = 'Felony', id = 'P.C. 2013', color = 'green', fine = 400, title = 'Attempted Robbery (B)'},
        [14] = {months = 15, class = 'Felony', id = 'P.C. 2014', color = 'orange', fine = 250, title = 'Accessory to Robbery (B)'},
        [15] = {months = 30, class = 'Felony', id = 'P.C. 2015', color = 'orange', fine = 1200, title = 'Armed Robbery (B)'},
        [16] = {months = 25, class = 'Felony', id = 'P.C. 2016', color = 'orange', fine = 600, title = 'Attempted Armed Robbery (B)'},
        [17] = {months = 20, class = 'Felony', id = 'P.C. 2017', color = 'orange', fine = 300, title = 'Accessory to Armed Robbery (B)'},
        [18] = {months = 35, class = 'Felony', id = 'P.C. 2018', color = 'green', fine = 1600, title = 'Robbery (C)'},
        [19] = {months = 30, class = 'Felony', id = 'P.C. 2019', color = 'green', fine = 800, title = 'Attempted Robbery (C)'},
        [20] = {months = 25, class = 'Felony', id = 'P.C. 2020', color = 'green', fine = 400, title = 'Accessory to Robbery (C)'},
        [21] = {months = 40, class = 'Felony', id = 'P.C. 2021', color = 'orange', fine = 2400, title = 'Armed Robbery (C)'},
        [22] = {months = 35, class = 'Felony', id = 'P.C. 2022', color = 'orange', fine = 1200, title = 'Attempted Armed Robbery (C)'},
        [23] = {months = 30, class = 'Felony', id = 'P.C. 2023', color = 'orange', fine = 600, title = 'Accessory to Armed Robbery (C)'},
        [24] = {months = 50, class = 'Felony', id = 'P.C. 2024', color = 'orange', fine = 1000, title = 'Grand Larceny'},
        [25] = {months = 10, class = 'Misdemeanor', id = 'P.C. 2025', color = 'green', fine = 100, title = 'Leaving Without Paying'},
        [26] = {months = 0, class = 'Misdemeanor', id = 'P.C. 2026', color = 'green', fine = 0, title = 'Possession of Nonlegal Currency (A)'},
        [27] = {months = 00, class = 'Misdemeanor', id = 'P.C. 2027', color = 'green', fine = 0, title = 'Possession of Nonlegal Currency (B)'},
        [28] = {months = 30, class = 'Misdemeanor', id = 'P.C. 2028', color = 'green', fine = 50, title = 'Possession of Nonlegal Currency (C)'},
        [29] = {months = 10, class = 'Misdemeanor', id = 'P.C. 2029', color = 'green', fine = 50, title = 'Possession of Items Used in the Commission of a Crime'},
        [30] = {months = 20, class = 'Misdemeanor', id = 'P.C. 2030', color = 'green', fine = 400, title = 'Sale of Items Used in the Commission of a Crime'},
    },
    [3] = {
        [1] = {months = 10, class = 'Misdemeanor', id = 'P.C. 3001', color = 'green', fine = 300, title = 'Impersonating'},
        [2] = {months = 50, class = 'Felony', id = 'P.C. 3002', color = 'green', fine = 3000, title = 'Impersonating a Peace Officer'},
        [3] = {months = 0, class = 'Felony', id = 'P.C. 3003', color = 'green', fine = 0, title = 'Impersonating a Judge'},
        [4] = {months = 20, class = 'Misdemeanor', id = 'P.C. 3004', color = 'green', fine = 500, title = 'Possession of Stolen Identification'},
        [5] = {months = 25, class = 'Felony', id = 'P.C. 3005', color = 'orange', fine = 600, title = 'Extortion'},
        [6] = {months = 15, class = 'Misdemeanor', id = 'P.C. 3006', color = 'green', fine = 300, title = 'Fraud'},
        [7] = {months = 10, class = 'Misdemeanor', id = 'P.C. 3007', color = 'green', fine = 500, title = 'Forgery'},
        [8] = {months = 0, class = 'Felony', id = 'P.C. 3008', color = 'red', fine = 0, title = 'Money Laundering'},
    },
    [4] = {
        [1] = {months = 10, class = 'Misdemeanor', id = 'P.C. 4001', color = 'green', fine = 300, title = 'Trespassing'},
        [2] = {months = 20, class = 'Misdemeanor', id = 'P.C. 4002', color = 'green', fine = 1000, title = 'Misdemeanor Trespassing'},
        [3] = {months = 15, class = 'Misdemeanor', id = 'P.C. 4003', color = 'orange', fine = 500, title = 'Arson'},
        [4] = {months = 0, class = 'Misdemeanor', id = 'P.C. 4004', color = 'green', fine = 200, title = 'Vandalism'},
        [5] = {months = 30, class = 'Misdemeanor', id = 'P.C. 4005', color = 'green', fine = 1000, title = 'Vandalism of Government Property'},
    },
    [5] = {
        [1] = {months = 20, class = 'Felony', id = 'P.C. 5001', color = 'green', fine = 300, title = 'Bribery of a Government Official'},
        [2] = {months = 10, class = 'Misdemeanor', id = 'P.C. 5002', color = 'green', fine = 500, title = 'Anti-Misdemeanor Law'},
        [3] = {months = 20, class = 'Felony', id = 'P.C. 5003', color = 'green', fine = 600, title = 'Possession of Contraband in a Government Facility'},
        [4] = {months = 10, class = 'Misdemeanor', id = 'P.C. 5004', color = 'green', fine = 250, title = 'Criminal Possession of Stolen Property'},
        [5] = {months = 15, class = 'Felony', id = 'P.C. 5005', color = 'green', fine = 300, title = 'Escaping'},
        [6] = {months = 30, class = 'Felony', id = 'P.C. 5006', color = 'orange', fine = 500, title = 'Jailbreak'},
        [7] = {months = 15, class = 'Felony', id = 'P.C. 5007', color = 'orange', fine = 250, title = 'Accessory to Jailbreak'},
        [8] = {months = 10, class = 'Felony', id = 'P.C. 5008', color = 'orange', fine = 150, title = 'Attempted Jailbreak'},
        [9] = {months = 0, class = 'Felony', id = 'P.C. 5009', color = 'green', fine = 0, title = 'Perjury'},
        [10] = {months = 30, class = 'Felony', id = 'P.C. 5010', color = 'green', fine = 500, title = 'Violation of a Restraining Order'},
        [11] = {months = 30, class = 'Felony', id = 'P.C. 5011', color = 'green', fine = 500, title = 'Embezzlement'},
        [12] = {months = 20, class = 'Felony', id = 'P.C. 5012', color = 'orange', fine = 1000, title = 'Unlawful Practice'},
        [13] = {months = 10, class = 'Misdemeanor', id = 'P.C. 5013', color = 'orange', fine = 400, title = 'Misuse of Emergency Systems'},
        [14] = {months = 8, class = 'Misdemeanor', id = 'P.C. 5014', color = 'green', fine = 300, title = 'Conspiracy'},
        [15] = {months = 0, class = 'Misdemeanor', id = 'P.C. 5015', color = 'orange', fine = 0, title = 'Violating a Court Order'},
        [16] = {months = 0, class = 'Misdemeanor', id = 'P.C. 5016', color = 'orange', fine = 0, title = 'Failure to Appear'},
        [17] = {months = 0, class = 'Felony', id = 'P.C. 5017', color = 'orange', fine = 0, title = 'Contempt of Court'},
    },
    [6] = {
        [1] = {months = 0, class = 'Infraction', id = 'P.C. 6001', color = 'green', fine = 500, title = 'Disobeying a Peace Officer'},
        [2] = {months = 10, class = 'Misdemeanor', id = 'P.C. 6002', color = 'green', fine = 150, title = 'Disorderly Conduct'},
        [3] = {months = 0, class = 'Infraction', id = 'P.C. 6003', color = 'green', fine = 200, title = 'Disturbing the Peace'},
        [4] = {months = 10, class = 'Misdemeanor', id = 'P.C. 6004', color = 'green', fine = 500, title = 'False Reporting'},
        [5] = {months = 10, class = 'Misdemeanor', id = 'P.C. 6005', color = 'orange', fine = 300, title = 'Harassment'},
        [6] = {months = 20, class = 'Felony', id = 'P.C. 6006', color = 'green', fine = 600, title = 'Obstruction'},
        [7] = {months = 30, class = 'Felony', id = 'P.C. 6007', color = 'orange', fine = 500, title = 'Inciting a Riot'},
        [8] = {months = 0, class = 'Infraction', id = 'P.C. 6008', color = 'green', fine = 300, title = 'Loitering on Government Properties'},
        [9] = {months = 15, class = 'Felony', id = 'P.C. 6009', color = 'green', fine = 300, title = 'Tampering'},
        [10] = {months = 25, class = 'Misdemeanor', id = 'P.C. 6010', color = 'green', fine = 100, title = 'Failure to provide Identification'},
        [11] = {months = 40, class = 'Felony', id = 'P.C. 6011', color = 'orange', fine = 100, title = 'Vigilantism'},
        [12] = {months = 10, class = 'Misdemeanor', id = 'P.C. 6012', color = 'orange', fine = 500, title = 'Unlawful Assembly'},
        [13] = {months = 0, class = 'Felony', id = 'P.C. 6013', color = 'red', fine = 000, title = 'Government Corruption'},
        [14] = {months = 60, class = 'Felony', id = 'P.C. 6014', color = 'orange', fine = 500, title = 'Stalking'},
        [15] = {months = 20, class = 'Misdemeanor', id = 'P.C. 6015', color = 'orange', fine = 300, title = 'Aiding and Abetting'},
    },
    [7] = {
        [1] = {months = 5, class = 'Misdemeanor', id = 'P.C. 7001', color = 'green', fine = 150, title = 'Misdemeanor Possession of Marijuana'},
        [2] = {months = 15, class = 'Felony', id = 'P.C. 7002', color = 'green', fine = 450, title = 'Felony Possession of Marijuana'},
        [3] = {months = 10, class = 'Misdemeanor', id = 'P.C. 7003', color = 'green', fine = 500, title = 'Cultivation of Marijuana A'},
        [4] = {months = 30, class = 'Felony', id = 'P.C. 7004', color = 'orange', fine = 200, title = 'Cultivation of Marijuana B'},
        [5] = {months = 40, class = 'Felony', id = 'P.C. 7005', color = 'orange', fine = 200, title = 'Possession of Marijuana with intent to distribute'},
        [6] = {months = 10, class = 'Misdemeanor', id = 'P.C. 7006', color = 'green', fine = 400, title = 'Misdemeanor Possession of Cocaine'},
        [7] = {months = 25, class = 'Felony', id = 'P.C. 7007', color = 'green', fine = 800, title = 'Felony Possession of Cocaine'},
        [8] = {months = 40, class = 'Felony', id = 'P.C. 7008', color = 'orange', fine = 200, title = 'Possession of Cocaine with intent to distribute'},
        [9] = {months = 10, class = 'Misdemeanor', id = 'P.C. 7009', color = 'green', fine = 800, title = 'Misdemeanor Possession of Methamphetamine'},
        [10] = {months = 25, class = 'Felony', id = 'P.C. 7010', color = 'green', fine = 800, title = 'Felony Possession of Methamphetamine'},
        [11] = {months = 40, class = 'Felony', id = 'P.C. 7011', color = 'orange', fine = 400, title = 'Possession of Methamphetamine with intent to distribute'},
        [12] = {months = 10, class = 'Felony', id = 'P.C. 7012', color = 'green', fine = 525, title = 'Misdemeanor Possession of Oxy / Vicodin'},
        [13] = {months = 25, class = 'Felony', id = 'P.C. 7013', color = 'green', fine = 100, title = 'Felony Possession of Oxy / Vicodin'},
        [14] = {months = 40, class = 'Felony', id = 'P.C. 7014', color = 'orange', fine = 150, title = 'Felony Possession of Oxy / Vicodin with intent to distribute'},
        [15] = {months = 10, class = 'Misdemeanor', id = 'P.C. 7015', color = 'green', fine = 400, title = 'Misdemeanor Possession of Ecstasy'},
        [16] = {months = 20, class = 'Felony', id = 'P.C. 7016', color = 'green', fine = 800, title = 'Misdemeanor Possession of Ecstasy'},
        [17] = {months = 40, class = 'Felony', id = 'P.C. 7017', color = 'orange', fine = 200, title = 'Possession of Ecstasy with intent to distribute'},
        [18] = {months = 10, class = 'Misdemeanor', id = 'P.C. 7018', color = 'green', fine = 400, title = 'Misdemeanor Possession of Opium'},
        [19] = {months = 25, class = 'Felony', id = 'P.C. 7019', color = 'green', fine = 800, title = 'Misdemeanor Possession of Opium'},
        [20] = {months = 40, class = 'Felony', id = 'P.C. 7020', color = 'orange', fine = 200, title = 'Possession of Opium with intent to distribute'},
        [21] = {months = 10, class = 'Felony', id = 'P.C. 7021', color = 'green', fine = 500, title = 'Sale of a controlled substance'},
        [22] = {months = 0, class = 'Felony', id = 'P.C. 7022', color = 'red', fine = 0, title = 'Drug Trafficking'},
        [23] = {months = 35, class = 'Infraction', id = 'P.C. 7023', color = 'orange', fine = 100, title = 'Desecration of a Human Corpse'},
        [24] = {months = 00, class = 'Misdemeanor', id = 'P.C. 7024', color = 'green', fine = 990, title = 'Public Intoxication'},
        [25] = {months = 10, class = 'Misdemeanor', id = 'P.C. 7025', color = 'green', fine = 500, title = 'Public Indecency'},
        [26] = {months = 10, class = 'Felony', id = 'P.C. 7026', color = 'green', fine = 400, title = 'Felony Possession of Adderall'},
        [27] = {months = 20, class = 'Felony', id = 'P.C. 7027', color = 'green', fine = 100, title = 'Misdemeanor Possession of Adderall'},
        [28] = {months = 40, class = 'Misdemeanor', id = 'P.C. 7028', color = 'orange', fine = 400, title = 'Possession of Adderall with Intent to Distribute'},
        [29] = {months = 10, class = 'Felony', id = 'P.C. 7029', color = 'green', fine = 400, title = 'Felony Possession of Xanax'},
        [30] = {months = 20, class = 'Misdemeanor', id = 'P.C. 7030', color = 'green', fine = 100, title = 'Misdemeanor Possession of Xanax'},
        [31] = {months = 40, class = 'Felony', id = 'P.C. 7031', color = 'orange', fine = 400, title = 'Possession of Xanax with Intent to Distribute'},
        [32] = {months = 5, class = 'Misdemeanor', id = 'P.C. 7032', color = 'green', fine = 200, title = 'Misdemeanor Possession of Shrooms'},
        [33] = {months = 15, class = 'Misdemeanor', id = 'P.C. 7033', color = 'green', fine = 500, title = 'Misdemeanor Possession of Shrooms'},
        [34] = {months = 40, class = 'Felony', id = 'P.C. 7034', color = 'orange', fine = 200, title = 'Possession of Shrooms with Intent to Distribute'},
        [35] = {months = 5, class = 'Misdemeanor', id = 'P.C. 7035', color = 'green', fine = 200, title = 'Misdemeanor Possession of Lean'},
        [36] = {months = 15, class = 'Misdemeanor', id = 'P.C. 7036', color = 'green', fine = 500, title = 'Felony Possession of Lean'},
        [37] = {months = 40, class = 'Felony', id = 'P.C. 7037', color = 'orange', fine = 200, title = 'Possession of Lean with Intent to Distribute'},
    },
    [8] = {
        [1] = {months = 10, class = 'Felony', id = 'P.C. 8001', color = 'green', fine = 300, title = 'Criminal Possession of Weapon Class A'},
        [2] = {months = 25, class = 'Felony', id = 'P.C. 8002', color = 'green', fine = 500, title = 'Criminal Possession of weapon class B'},
        [3] = {months = 100, class = 'Felony', id = 'P.C. 8003', color = 'green', fine = 3000, title = 'Criminal Possession of Weapon/Item Class C'},
        [4] = {months = 40, class = 'Felony', id = 'P.C. 8004', color = 'green', fine = 1000, title = 'Criminal Possession of Weapon Class D'},
        [5] = {months = 25, class = 'Felony', id = 'P.C. 8005', color = 'orange', fine = 500, title = 'Criminal Sale of Weapon Class A'},
        [6] = {months = 45, class = 'Felony', id = 'P.C. 8006', color = 'orange', fine = 1000, title = 'Criminal Sale of Weapon Class B'},
        [7] = {months = 150, class = 'Felony', id = 'P.C. 8007', color = 'orange', fine = 5000, title = 'Criminal Sale of Weapon Class C'},
        [8] = {months = 60, class = 'Felony', id = 'P.C. 8008', color = 'orange', fine = 2000, title = 'Criminal Sale of Weapon Class D'},
        [9] = {months = 10, class = 'Misdemeanor', id = 'P.C. 8009', color = 'orange', fine = 600, title = 'Criminal Use of Weapon'},
        [10] = {months = 10, class = 'Misdemeanor', id = 'P.C. 8010', color = 'green', fine = 200, title = 'Possession of Illegal Firearm Modifications'},
        [11] = {months = 0, class = 'Felony', id = 'P.C. 8011', color = 'red', fine = 0, title = 'Weapon Trafficking'},
        [12] = {months = 5, class = 'Misdemeanor', id = 'P.C. 8012', color = 'orange', fine = 100, title = 'Brandishing'},
        [13] = {months = 200, class = 'Felony', id = 'P.C. 8013', color = 'red', fine = 45000, title = 'Insurrection'},
        [14] = {months = 30, class = 'Felony', id = 'P.C. 8014', color = 'green', fine = 1000, title = 'Flying into Restricted Airspace'},
        [15] = {months = 0, class = 'Infraction', id = 'P.C. 8015', color = 'green', fine = 100, title = 'Jaywalking'},
    },
    [9] = {
        [1] = {months = 7, class = 'Misdemeanor', id = 'P.C. 9001', color = 'green', fine = 200, title = 'Driving While Intoxicated'},
        [2] = {months = 5, class = 'Misdemeanor', id = 'P.C. 9002', color = 'green', fine = 250, title = 'Evading'},
        [3] = {months = 10, class = 'Felony', id = 'P.C. 9003', color = 'orange', fine = 450, title = 'Reckless Evading'},
        [4] = {months = 0, class = 'Infraction', id = 'P.C. 9004', color = 'green', fine = 600, title = 'Failure to Yield to Emergency Vehicle'},
        [5] = {months = 0, class = 'Infraction', id = 'P.C. 9005', color = 'green', fine = 990, title = 'Failure to Obey Traffic Control Device'},
        [6] = {months = 0, class = 'Infraction', id = 'P.C. 9006', color = 'green', fine = 500, title = 'Nonfunctional Vehicle'},
        [7] = {months = 0, class = 'Infraction', id = 'P.C. 9007', color = 'green', fine = 200, title = 'Negligent Driving'},
        [8] = {months = 10, class = 'Felony', id = 'P.C. 9008', color = 'orange', fine = 500, title = 'Reckless Driving'},
        [9] = {months = 0, class = 'Infraction', id = 'P.C. 9009', color = 'green', fine = 150, title = 'Third Degree Speeding'},
        [10] = {months = 0, class = 'Infraction', id = 'P.C. 9010', color = 'green', fine = 300, title = 'Second Degree Speeding'},
        [11] = {months = 0, class = 'Infraction', id = 'P.C. 9011', color = 'green', fine = 400, title = 'First Degree Speeding'},
        [12] = {months = 0, class = 'Infraction', id = 'P.C. 9012', color = 'green', fine = 400, title = 'Unlicensed Operation of Vehicle'},
        [13] = {months = 0, class = 'Infraction', id = 'P.C. 9013', color = 'green', fine = 500, title = 'Illegal U-Turn'},
        [14] = {months = 0, class = 'Infraction', id = 'P.C. 9014', color = 'green', fine = 200, title = 'Illegal Passing'},
        [15] = {months = 0, class = 'Infraction', id = 'P.C. 9015', color = 'green', fine = 200, title = 'Failure to Maintain Lane'},
        [16] = {months = 0, class = 'Infraction', id = 'P.C. 9016', color = 'green', fine = 990, title = 'Illegal Turn'},
        [17] = {months = 0, class = 'Infraction', id = 'P.C. 9017', color = 'green', fine = 400, title = 'Failure to Stop'},
        [18] = {months = 0, class = 'Infraction', id = 'P.C. 9018', color = 'green', fine = 200, title = 'Unauthorized Parking'},
        [19] = {months = 10, class = 'Misdemeanor', id = 'P.C. 9019', color = 'green', fine = 300, title = 'Hit and Run'},
        [20] = {months = 0, class = 'Infraction', id = 'P.C. 9020', color = 'green', fine = 200, title = 'Driving without Headlights or Signals'},
        [21] = {months = 20, class = 'Misdemeanor', id = 'P.C. 9021', color = 'green', fine = 600, title = 'Street Racing'},
        [22] = {months = 30, class = 'Felony', id = 'P.C. 9022', color = 'orange', fine = 1000, title = 'Piloting without Proper Licensing'},
        [23] = {months = 10, class = 'Misdemeanor', id = 'P.C. 9023', color = 'green', fine = 500, title = 'Unlawful Use of a Motorvehicle'},
    },
    [10] = {
        [1] = {months = 00, class = 'Infraction', id = 'P.C. 1000', color = 'green', fine = 300, title = 'Hunting in Restricted Areas'},
        [2] = {months = 00, class = 'Infraction', id = 'P.C. 1000', color = 'green', fine = 300, title = 'Unlicensed Hunting'},
        [3] = {months = 10, class = 'Misdemeanor', id = 'P.C. 1000', color = 'green', fine = 500, title = 'Animal Cruelty'},
        [4] = {months = 10, class = 'Misdemeanor', id = 'P.C. 1000', color = 'green', fine = 500, title = 'Hunting with a Non-Hunting Weapon'},
        [5] = {months = 00, class = 'Infraction', id = 'P.C. 1000', color = 'green', fine = 300, title = 'Hunting outside of hunting hours'},
        [6] = {months = 20, class = 'Felony', id = 'P.C. 1000', color = 'red', fine = 700, title = 'Poaching'},
    },
}

Config["Titles"] = {
    'OFFENSES AGAINST PERSONS',
    'OFFENSES INVOLVING THEFT',
    'OFFENSES INVOLVING FRAUD',
    'OFFENSES INVOLVING DAMAGE TO PROPERTY',
    'OFFENSES AGAINST PUBLIC ADMINISTRATION',
    'OFFENSES AGAINST PUBLIC ORDER',
    'OFFENSES AGAINST HEALTH AND MORALS',
    'OFFENSES AGAINST PUBLIC SAFETY',
    'OFFENSES INVOLVING THE OPERATION OF A VEHICLE',
    'OFFENSES INVOLVING THE WELL-BEING OF WILDLIFE'
}