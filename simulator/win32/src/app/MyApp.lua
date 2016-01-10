
local MyApp = class("MyApp", cc.load("mvc").AppBase)
local pResMgr = require("app.CResMgr")

function MyApp:onCreate()
    math.randomseed(os.time())
    pResMgr.getInstance():LoadPlistOnline()
end

return MyApp
