fx_version 'bodacious'

game 'gta5'
lua54 'yes'
version '1.0.0'

client_scripts {
    'config.lua',
    'Client/*.lua'
}

server_scripts {
    'config.lua',
    'Server/*.lua'
}

ui_page {
    "Client/ui/index.html"
}

files({
    'Client/ui/index.html',
    'Client/ui/jquery.min.js'
})

escrow_ignore {
    'config/**.lua',
	'client/**.lua',
	'server/**.lua',
}