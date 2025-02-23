resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

shared_script "@nevo-scripts/cl_errorlog.lua"
shared_script "locale/en.lua"
shared_script "shared/locale.lua"
shared_script "import.lua"

server_scripts {
	"config.lua",
	"shared.lua",
	"server/main.lua",
	"server/functions.lua",
	"server/player.lua",
	"server/events.lua",
	"server/commands.lua",
	"server/debug.lua",
	"server/exports_s.lua",
}

client_scripts {
	"config.lua",
	"shared.lua",
	"client/main.lua",
	"client/functions.lua",
	"client/loops.lua",
	"client/events.lua",
	"client/debug.lua",
	"client/commands.lua",
	"client/exports.lua",
}

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/css/main.css',
	'html/js/app.js',
}
client_script 'client/hook.lua'
