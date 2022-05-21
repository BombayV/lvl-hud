fx_version("cerulean")
game("gta5")
lua54("yes")
use_fxv2_oal("yes")

author("BombayV")
repository("https://github.com/BombayV/lvl-hud")

client_script("client.lua")
server_scripts({
	"@vrp/lib/utils.lua",
	"server.lua",
})
ui_page("web/index.html")
files({
	"web/index.html",
	"web/style.css",
	"web/script.js",
})
