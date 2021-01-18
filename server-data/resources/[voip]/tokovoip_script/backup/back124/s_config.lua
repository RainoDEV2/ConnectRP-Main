local players = {}
RegisterServerEvent("tokovoip:getid")
AddEventHandler("tokovoip:getid", function()
	if tonumber(source) then
		if not players[source] then
			local theid = -1
			local hasnext = true
			while hasnext do
				hasnext = false
				theid = math.random(0, GetConvarInt("sv_maxClients", 1000)+500)
				for a, b in next, players do
					if b == playerid then
						hasnext = true
					end
				end
			end
			TriggerClientEvent("tokovoip:getid", source, theid)
		end
	end
end)

AddEventHandler("playerDropped", function()
	players[source] = nil
end)

TokoVoipConfig = {
	channels = {
		{name = "Police Radio", subscribers = {}},
		{name = "EMS Radio", subscribers = {}},
		{name = "Police/MADA Radio", subscribers = {}},
		{name = "Operations Radio #1", subscribers = {}},
		{name = "Operations Radio #2", subscribers = {}},
		{name = "Operations Radio #3", subscribers = {}},
		{name = "Operations Radio #4", subscribers = {}},
		{name = "Operations Radio #5", subscribers = {}},
		{name = "Police Managment Radio", subscribers = {}},
		{name = "MADA Managment Radio", subscribers = {}}
	}
};
