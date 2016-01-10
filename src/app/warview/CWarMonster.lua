-- 防御塔基类

local CAdvanceSprite = require("app.views.CAdvanceSprite")

local DEBUG = true

local CWarMonster = class("CWarMonster", function ()
	return cc.Node:create()
end)

function CWarMonster:ctor(nID, nSID)
	self.m_nID = nID -- ID
	self.m_nSID = nSID -- 造型SID
	self.m_pData = require(string.format("app.data.monsterdata.Monster%d", nSID))
	self:InitSprite()

	if DEBUG then
		self:InitDebug()
	end
end

function CWarMonster:InitSprite()
	local sResPath = self.m_pData["sResPath"]
	self.m_pSprite = CAdvanceSprite.create(sResPath, 1, 2, 0.1)
	self:addChild(self.m_pSprite)
end

function CWarMonster:InitDebug()
	local fAttackRadius = 10

	self.m_pDrawNode = cc.DrawNode:create()
	self.m_pDrawNode:drawDot(cc.p(0,0), fAttackRadius, cc.c4f(1.0, 0.0, 0.0, 0.2))
	self:addChild(self.m_pDrawNode)
end

function CWarMonster:PlayWalkAni()
	self.m_pSprite:PlayAni()
end

function CWarMonster:PlayIdleAni( ... )
	self.m_pSprite:StopAni()
end

local CWarMonster201 = class("CWarMonster201", CWarMonster)


-- 怪物工厂
local CWarMonsterFactory = class("CWarMonsterFactory")
CWarMonsterFactory.m_pInstance = nil

function CWarMonsterFactory.getInstance()
	if CWarMonsterFactory.m_pInstance == nil then
		CWarMonsterFactory.m_pInstance = CWarMonsterFactory:new()
	end
	return CWarMonsterFactory.m_pInstance
end

function CWarMonsterFactory.CreateMonster(nID, nSID)
	if nSID == 201 then
		return CWarMonster201.new(nID, nSID)
	end
	printf("xxxx = %d, %d", nID, nSID)
	return CWarMonster.new(nID, nSID)
end

return CWarMonsterFactory