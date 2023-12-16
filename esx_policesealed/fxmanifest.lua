fx_version 'cerulean'
game 'gta5'

author 'karagovitsh'
description 'Script de vente de drogues sous scellé pour la LSPD afin de faire de l\'argent legal en rendant des objets illegals'
version '1.0.0'

shared_script '@es_extended/imports.lua'

client_scripts {
    'client.lua'
}

server_scripts {
    '@es_extended/locale.lua',
    'server.lua'
}

dependencies {
    'es_extended'
    -- Ajoutez d'autres dépendances si nécessaires
}
