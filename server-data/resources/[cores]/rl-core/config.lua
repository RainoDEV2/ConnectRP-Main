RLConfig = {}

RLConfig.MaxPlayers = GetConvarInt('sv_maxclients', 128) -- Gets max players from config file, default 32
RLConfig.IdentifierType = "steam" -- Set the identifier type (can be: steam, license)
RLConfig.DefaultSpawn = {x=-1035.71,y=-2731.87,z=12.86,a=0.0}

RLConfig.Money = {}
RLConfig.Money.MoneyTypes = {['cash'] = 1000, ['bank'] = 5000, ['crypto'] = 0 } -- ['type']=startamount - Add or remove money types for your server (for ex. ['blackmoney']=0), remember once added it will not be removed from the database!
RLConfig.Money.DontAllowMinus = {'cash', 'crypto'} -- Money that is not allowed going in minus

RLConfig.Player = {}
RLConfig.Player.MaxWeight = 250000 -- Max weight a player can carry (currently 120kg, written in grams)
RLConfig.Player.MaxInvSlots = 41 -- Max inventory slots for a player
RLConfig.Player.Bloodtypes = {
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
}

RLConfig.Server = {} -- General server config
RLConfig.Server.closed = false -- Set server closed (no one can join except people with ace permission 'RLadmin.join')
RLConfig.Server.closedReason = "Closed for testing." -- Reason message to display when people can't join the server
RLConfig.Server.uptime = 0 -- Time the server has been up.
RLConfig.Server.discord = "https://discord.gg/v6vGMbymeV" -- Discord invite link [GreatBritishRP]
RLConfig.Server.PermissionList = {} -- permission list