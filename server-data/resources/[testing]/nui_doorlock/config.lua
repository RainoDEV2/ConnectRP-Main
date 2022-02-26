Config = {}

Config.ShowUnlockedText = true

Config.LockedColor = 'rgb(219 58 58)'
Config.UnlockedColor = 'rgb(19, 28, 74)' -- Old Color if you want it 'rgb(19, 28, 74)'

Config.AdminAccess = {
	enabled = false,
	permission = 'admin' -- Needs to be admin or god
}
Config.CommandPermission = 'god' -- Needs to be admin or god, if you want no permission on it you'd have to remove some code

Config.Debug = false -- Prints the closest door data

Config.DoorList = {

}

-- PD Main Doors created by Doofy Gilmore
Config.DoorList['PD Main Doors'] = {
    audioRemote = false,
    locked = true,
    doors = {
        {objHash = -1547307588, objHeading = 269.98272705078, objCoords = vec3(434.744446, -980.755554, 30.815304)},
        {objHash = -1547307588, objHeading = 90.017288208008, objCoords = vec3(434.744446, -983.078125, 30.815304)}
    },
    slides = false,
    maxDistance = 2.5,
    authorizedJobs = { ['police']=0 },
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}