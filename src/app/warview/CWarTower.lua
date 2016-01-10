-- 防御塔基类

local CAdvanceSprite = require("app.views.CAdvanceSprite")

local DEBUG = true

local CWarTowerBase = class("CWarTowerBase", function ()
	return cc.Node:create()
end)

function CWarTowerBase:ctor(nID, nSID, nLv)
	self.m_nID = nID -- ID
	self.m_nSID = nSID -- 造型SID
	self.m_nLv = nLv or 1
	self.m_pData = require(string.format("app.data.towerdata.Tower%d", nSID))
	self:InitSprite()
	if DEBUG then
		self:InitDebug()
	end
end

function CWarTowerBase:InitSprite()
	local sResPath = self.m_pData["dGradeInfo"][self.m_nLv]["sResPath"]
	self.m_pSprite = CAdvanceSprite.create(sResPath, tonumber(self.m_nLv..1), tonumber(self.m_nLv..3), 0.1)
	self:addChild(self.m_pSprite)
end

function CWarTowerBase:InitDebug()
	local fAttackRadius = self.m_pData["dGradeInfo"][self.m_nLv]["fAttackRadius"]

	self.m_pDrawNode = cc.DrawNode:create()
	self.m_pDrawNode:drawDot(cc.p(0,0), fAttackRadius, cc.c4f(1.0, 0.0, 0.0, 0.2))
	self:addChild(self.m_pDrawNode)
end

function CWarTowerBase:PlayAttackAni()
	self.m_pSprite:PlayAni()
end

function CWarTowerBase:PlayIdleAni( ... )
	self.m_pSprite:StopAni()
end

local CWarTower101 = class("CWarTower101", CWarTowerBase)


-- 防御塔工厂
local CWarTowerFactory = class("CWarTowerFactory")
CWarTowerFactory.m_pInstance = nil

function CWarTowerFactory.getInstance()
	if CWarTowerFactory.m_pInstance == nil then
		CWarTowerFactory.m_pInstance = CWarTowerFactory:new()
	end
	return CWarTowerFactory.m_pInstance
end

function CWarTowerFactory.CreateTower(nID, nSID, nLv)
	if nSID == 101 then
		return CWarTower101.new(nID, nSID, nLv)
	end
	return CWarTowerBase.new(nID, nSID, nLv)
end

return CWarTowerFactory