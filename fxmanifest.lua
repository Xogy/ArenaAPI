fx_version 'adamant'
games { 'gta5' }

client_scripts {
    "client/*.lua",
}

server_script {
    "server/main.lua",
    "server/events.lua",
    "server/exports.lua",
    "server/module/*.lua",
    "server/system/*.lua",
}

shared_scripts {
    "config.lua",
}

files {
    "html/*.html",
    "html/css/*.css",
    "html/scripts/*.js",
}

ui_page "html/index.html"
