fx_version 'cerulean'
game 'gta5'

name "Admin Zone"
author "Made with love by Samuel#0008"
version "1.0"


shared_scripts {
    'config.lua'
}

client_scripts {
	'client/main.lua',
	'config.lua'
}

server_scripts {
	'server/main.lua',
	'config.lua'
}

lua54 'yes'