Config = {}

-- Time Option (Don't Forget Everything is in minutes)


Config.Minutes = 5 -- How Much Time It Should Take Before A Police Officer Can Try Again To Restore Electricity.

Config.PlaySound = true -- Plays Sounds When Electricity Is Restored Or When A Blackout Happens.

Config.ExplosionLocations = {
    vector3(691.5399, 158.6379, 84.171),
    vector3(673.8968, 148.2013, 83.555),
    vector3(678.3690, 117.4322, 84.171),
    vector3(708.9675, 116.0311, 84.165),
    vector3(703.7615, 100.7901, 84.139),
}


Config.BombSite = vector3(711.45, 164.96, 80.75)
Config.NeededPerm = 'god' -- Needed Perm For The resetblackout command
RegisterNetEvent('vC-blackout:dispatch', function()
       --- Your Dispatch Event Here
end)
