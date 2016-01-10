
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

MainScene.RESOURCE_FILENAME = "MainScene.csb"

function MainScene:onCreate()
    printf("resource node = %s", tostring(self:getResourceNode()))
    local function OnPlayAdventure()
    	-- 冒险模式
    	--self:getApp():enterScene("BigTollgateScene")
    	self:getApp():enterScene("WarScene")
    end
    self:getResourceNode():getChildByName("Btn_Advanture"):addClickEventListener(OnPlayAdventure)
end

return MainScene
