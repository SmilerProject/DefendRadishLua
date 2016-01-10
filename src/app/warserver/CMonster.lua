
local CMonster = class("CMonster")
local pubfunc = require("app.pubfunc")

local DIR_UP = 0x01
local DIR_RIGHT = 0x02
local DIR_DOWN = 0x03
local DIR_LEFT = 0x04


function CMonster:ctor(nID, nSID, tRCPath)
	self.m_nID = nID
	self.m_nSID = nSID
	self.m_tRCPath = tRCPath
	self.m_pData = require(string.format("app.data.monsterdata.Monster%d", nSID))

	self.m_fMoveSpeed = self.m_pData["fMoveSpeed"]


	self.m_nPathPosNum = #self.m_tRCPath

	self.m_bHasReached = false
	self.m_nCurPathIdx = 1
	self.m_rcPos = self.m_tRCPath[1]
	self.m_xyPos = pubfunc.RC2XY(self.m_rcPos[1], self.m_rcPos[2])

	-- 移动距离
	self.m_xyMoveDis = 0
	self.m_xyHasMoveTime = 0
	-- 移动方向
	self.m_nDir = DIR_UP

	self:UpdateNextDestPos()
end

function CMonster:UpdateNextDestPos()
	-- 获取下一个目标点
	self.m_xyHasMoveTime = 0
	self.m_nCurPathIdx = self.m_nCurPathIdx + 1
	if self.m_nCurPathIdx > self.m_nPathPosNum then
		self.m_bHasReached = true
		return
	end
	local rcNextPos = self.m_tRCPath[self.m_nCurPathIdx]
	local xyNextPos = pubfunc.RC2XY(rcNextPos[1], rcNextPos[2])
	local fMoveDis = 0
	if rcNextPos[2] == self.m_rcPos[2] then
		fMoveDis = xyNextPos.y-self.m_xyPos.y
		if fMoveDis > 0 then
			self.m_nDir = DIR_UP
		else
			self.m_nDir = DIR_DOWN
		end
	else
		fMoveDis = xyNextPos.x-self.m_xyPos.x
		if fMoveDis > 0 then
			self.m_nDir = DIR_RIGHT
		else
			self.m_nDir = DIR_LEFT
		end
	end
	self.m_rcPos = rcNextPos
	self.m_xyMoveDis = math.abs(fMoveDis)
end

function CMonster:GetXYPos()
	return self.m_xyPos
end

function CMonster:GetIsReached()
	return self.m_bHasReached
end

function CMonster:update(fDeltaTime)
	if self.m_bHasReached then
		return
	end
	local bIsNeedUpdate = false -- 是否到达目的地，更新下一个目标点
	local fMoveDis = fDeltaTime*self.m_fMoveSpeed
	self.m_xyMoveDis = self.m_xyMoveDis - fMoveDis
	if self.m_xyMoveDis <= 0 then
		bIsNeedUpdate = true
		if self.m_xyMoveDis < 0 then
			fMoveDis = self.m_xyMoveDis + fMoveDis
		end
	end

	if self.m_nDir == DIR_UP then
		self.m_xyPos.y = self.m_xyPos.y + fMoveDis
	elseif self.m_nDir == DIR_DOWN then
		self.m_xyPos.y = self.m_xyPos.y - fMoveDis
	elseif self.m_nDir == DIR_LEFT then
		self.m_xyPos.x = self.m_xyPos.x - fMoveDis
	elseif self.m_nDir == DIR_RIGHT then
		self.m_xyPos.x = self.m_xyPos.x + fMoveDis
	end

	if bIsNeedUpdate then
		self:UpdateNextDestPos()
	end
end



return CMonster