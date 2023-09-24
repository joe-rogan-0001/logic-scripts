Config = {}


Config.TuneVars = {
    ['boost'] = {
        key = 'fInitialDriveForce',
        multp = 0.12,
        default = 1,
    },
    ['acceleration'] = {
        key = 'fDriveInertia',
        multp = 0.12,
        default = 1,
    },
    ['gearchange'] = {
        key = 'none',
        multp = 0.12,
        default = 1,
    },
    ['drivetrain'] = {
        key = 'fDriveBiasFront',
        multp = 1,
        default = 0.5,
    },
    ['breaking'] = {
        key = 'fDriveBiasFront',
        multp = 0.12,
        default = 1,
    }, 
}

Config.NeonVars = {
    r = 255,
    g = 255,
    b = 255,
    h = 2, 
}

Config.Stancer = {
    ['fOffset'] = 7,
    ['fRotation'] = 0,
    ['rOffset'] = 7,
    ['rRotation'] = 0,
}
