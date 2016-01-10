local CTower = require("app.warserver.CTower")
local CTowerMgr = class("CTowerMgr")
function CTowerMgr:ctor(pServer)
	self.m_pServer = pServer
	self.m_dAllTower = {}
end

function CTowerMgr:AddTower(nTowerID, nTowerSID, rcPos)
	self.m_dAllTower[nTowerID] = CTower.new(nTowerID, nTowerSID, rcPos)
end

function CTowerMgr:CheckTowerCanAttack(pTower)
	if pTower:IsCoolDown() then
		return
	end
	local dMonsterID2Dis = {}
	for nMonsterID, pMonster in pairs(self.m_pServer:GetMonsterMgr():GetAllMonster()) do
		local fDis = cc.pGetDistance(pTower:GetXYPos(), pMonster:GetXYPos())
		if fDis <= pTower:GetAttackRadius() then
			dMonsterID2Dis[nMonsterID] = fDis
		end
	end
	
end

function CTowerMgr:update(fDeltaTime)
	for nTowerID, pTower in pairs(self.m_dAllTower) do
		self:CheckTowerCanAttack(pTower)
		pTower:update(fDeltaTime)
	end
end


return CTowerMgr