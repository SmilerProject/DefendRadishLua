
local BigTollgateScene = class("BigTollgateScene", cc.load("mvc").ViewBase)

BigTollgateScene.RESOURCE_FILENAME = "BigTollgateScene.csb"

function BigTollgateScene:onCreate()
    printf("resource node = %s", tostring(self:getResourceNode()))
    local function OnLeftBtn()
        printf("左翻页")
    end
    local function OnRightBtn()
        printf("右翻页")
    end
    local function OnPageView( pSender, nEventType )
        if nEventType == ccui.PageViewEventType.turning then
            local pageInfo = string.format("page %d " , pSender:getCurPageIndex() + 1)  
            printf(pageInfo)
        end
    end
    self:getResourceNode():getChildByName("Btn_LeftPage"):addClickEventListener(OnLeftBtn)
    self:getResourceNode():getChildByName("Btn_RightPage"):addClickEventListener(OnRightBtn)
    self:getResourceNode():getChildByName("PageView_Tollgate"):addEventListener(OnPageView)
    printf("xxxxxx")
    printf(self:getResourceNode():getChildByName("PageView_Tollgate"):isSwallowTouches())
    self:getResourceNode():getChildByName("PageView_Tollgate"):setSwallowTouches(false)
    self:getResourceNode():getChildByName("PageView_Tollgate"):setPropagateTouchEvents(true)
    -- self:getResourceNode():getChildByName("PageView_Tollgate"):setEnabled(false)
    -- self:getResourceNode():getChildByName("Panel_1"):setSwallowTouches(false)
    -- self:getResourceNode():getChildByName("Panel_2"):setSwallowTouches(false)
    -- self:getResourceNode():getChildByName("Panel_3"):setSwallowTouches(false)
    printf(self:getResourceNode():getChildByName("PageView_Tollgate"):isSwallowTouches())

end

return BigTollgateScene
