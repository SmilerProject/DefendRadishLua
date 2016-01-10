
local WarScene = class("WarScene", cc.load("mvc").ViewBase)

local CWarMap = require("app.warview.CWarMap")

local CWarBtnMgr = require("app.warview.CWarBtnMgr")

local CAdvanceSprite = require("app.views.CAdvanceSprite")

local pubfunc = require("app.pubfunc")

WarScene.RESOURCE_FILENAME = "WarScene.csb"

function WarScene:onCreate()
    printf("resource node = %s", tostring(self:getResourceNode()))

    self.m_pWarSceneTop = nil
    self.m_pWarSceneMap = nil
    self:InitSceneTop()
    self:InitSceneMap()
end

function WarScene:InitSceneTop()
    self.m_pWarSceneTop = cc.CSLoader:createNode("WarScene_Top.csb")
    self:addChild(self.m_pWarSceneTop, 1)
end
function WarScene:InitSceneMap()
    -- 初始化地图
    self.m_pWarSceneMap = cc.CSLoader:createNode("Map1001.csb")
    self:addChild(self.m_pWarSceneMap, 0)

    local pTowerFac = require("app.warview.CWarTower")
    local s = pTowerFac.getInstance().new():CreateTower()
    local CServerBase = require("app.warserver.CServerBase")
    local pListener = require("app.warserver.CListenerBase")

    self.m_pListener = pListener.new(self)
    local pServer = CServerBase.new(self.m_pListener)
    pServer:LoadMapData(1001)

    self.m_pBtnMgr = CWarBtnMgr.new(self,pServer:GetGridData())--jingjing


    self.m_tAllMonster = {}
end

function WarScene:PlayCountDownAni()
    printf("播放倒计时动画")
end

function WarScene:AddMonster(nID, nSID, rcPos)
    local sResPath = require(string.format("app.data.monsterdata.Monster%d", nSID))["sResPath"]
    local pMonster = CAdvanceSprite.create(sResPath, 1, 2, 0.1)
    pMonster:setVisible(true)
    pMonster:setPosition(pubfunc.RC2XY(rcPos[1], rcPos[2]))
    self.m_tAllMonster[nID] = pMonster
    self.m_pWarSceneMap:addChild(pMonster)
    pMonster:PlayAni()

end

function WarScene:MonsterMove(nID, xyPos)
    self.m_tAllMonster[nID]:setPosition(xyPos)
end

function WarScene:MonsterReached(nID)
    self.m_tAllMonster[nID]:removeFromParent()
    self.m_tAllMonster[nID] = nil
end

return WarScene
