
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

    local CServerBase = require("app.warserver.CServerBase")
    local pListener = require("app.warserver.CListenerBase")

    self.m_pListener = pListener.new(self)
    self.m_pServer = CServerBase.new(self.m_pListener)
    self.m_pServer:LoadMapData(1001)



    self.m_pBtnMgr = CWarBtnMgr.new(self,self.m_pServer:GetGridData())--jingjing


    self.m_tAllMonster = {}
    self.m_tAllTower = {}

    self:AddCarrot(self.m_pServer:GetCarrotPoint()[1])
end


-- 加载萝卜的动画
function WarScene:AddCarrot(rcPos)
     local pCarrot = require("app.warview.CWarCarrot")
     self.m_pCarrot = pCarrot.new()
    self.m_pCarrot:setPosition(pubfunc.RC2XY(rcPos[1], rcPos[2]))
    self.m_pWarSceneMap:addChild(self.m_pCarrot)
    self.m_pCarrot:PlayAni()
end

function WarScene:PlayCountDownAni()
    printf("播放倒计时动画")
end

function WarScene:AddMonster(nID, nSID, rcPos)
    local pWarMonsterFac = require("app.warview.CWarMonster")
    local pMonster = pWarMonsterFac.CreateMonster(nID, nSID)
    pMonster:setPosition(pubfunc.RC2XY(rcPos[1], rcPos[2]))
    self.m_tAllMonster[nID] = pMonster
    self.m_pWarSceneMap:addChild(pMonster)
    pMonster:PlayWalkAni()
    -- local sResPath = require(string.format("app.data.monsterdata.Monster%d", nSID))["sResPath"]
    -- local pMonster = CAdvanceSprite.create(sResPath, 1, 2, 0.1)
    -- pMonster:setPosition(pubfunc.RC2XY(rcPos[1], rcPos[2]))
    -- self.m_tAllMonster[nID] = pMonster
    -- self.m_pWarSceneMap:addChild(pMonster)
    -- pMonster:PlayAni()

end

function WarScene:AddTower(nID, nSID, rcPos)
    local pWarTowerFac = require("app.warview.CWarTower")
    local pTower = pWarTowerFac.CreateTower(nID, nSID, 1)
    pTower:setPosition(pubfunc.RC2XY(rcPos[1], rcPos[2]))
    self.m_tAllTower[nID] = pTower
    self.m_pWarSceneMap:addChild(pTower)
    pTower:PlayAttackAni()
    -- local nLv = 1
    -- local sResPath = require(string.format("app.data.towerdata.Tower%d", nSID))["dGradeInfo"][nLv]["sResPath"]
    -- local pTower = CAdvanceSprite.create(sResPath, tonumber(nLv..1), tonumber(nLv..3), 0.1)
    -- pTower:setPosition(pubfunc.RC2XY(rcPos[1], rcPos[2]))
    -- self.m_tAllTower[nID] = pTower
    -- self.m_pWarSceneMap:addChild(pTower)
    -- pTower:PlayAni()
    -- pTower:StopAni()
end

function WarScene:MonsterMove(nID, xyPos)
    self.m_tAllMonster[nID]:setPosition(xyPos)
end

function WarScene:MonsterReached(nID)
    self.m_tAllMonster[nID]:removeFromParent()
    self.m_tAllMonster[nID] = nil
end


function WarScene:C2SAddTower(nSID, rcPos)
    self.m_pServer:C2SAddTower(nSID, rcPos)
end

return WarScene
