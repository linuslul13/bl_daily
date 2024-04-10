fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'BL Scripts | Linus'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

server_script {
    'server/*.lua',
}
client_scripts {
    'client/*.lua',
}
