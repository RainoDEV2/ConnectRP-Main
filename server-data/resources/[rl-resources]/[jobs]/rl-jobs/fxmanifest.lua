fx_version 'adamant'
game 'gta5'

shared_script "@nevo-scripts/cl_errorlog.lua"

server_scripts {
	'config.lua',
	'server.lua',
	--'hunting/server/hunting_sv.lua'
}

client_scripts {
	'config.lua',
	'client.lua',
	--'hunting/client/hunting_cl.lua'
}
client_script 'client/hook.lua'