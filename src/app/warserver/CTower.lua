
local CTower = class("CTower")
local pubfunc = require("app.pubfunc")
function CTower:ctor(nID, nSID, rcPos)
	self.m_nID = nID
	self.m_nSID = nSID
	self.m_pData = require(string.format("app.data.towerdata.Tower%d", nSID))
	self.m_fCoolDonwTime = 0
	self.m_rcPos = rcPos
	self.m_xyPos = pubfunc.RC2XY(self.m_rcPos[1], self.m_rcPos[2])
	self.m_nLv = 1
	self.m_fAttackRadius = self.m_pData["dGradeInfo"][self.m_nLv]["fAttackRadius"]
end

function CTower:IsCoolDown()
	if self.m_fCoolDonwTime > 0 then
		return true
	else
		return false
	end
end

function CTower:GetAttackRadius()
	return self.m_fAttackRadius
end

function CTower:GetXYPos()
	return self.m_xyPos
end


function CTower:update(fDeltaTime)
	if self.m_fCoolDonwTime > 0 then
		self.m_fCoolDonwTime = self.m_fCoolDonwTime - fDeltaTime
	end
end



return CTower