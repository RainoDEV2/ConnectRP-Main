resource_manifest_version "77731fab-63ca-442c-a67b-abc70f28dfa5"

shared_script "@nevo-scripts/cl_errorlog.lua"

server_scripts {
	"server/main.lua",
	"server/commands.lua",
} 

client_scripts {
	"client/main.lua",
}

server_exports {
	'ToggleBlackout',
	'FreezeElement',
}