local CMonster = require("app.warserver.CMonster")
local CMonsterMgr = class("CMonsterMgr")
function CMonsterMgr:ctor(pServer)
	self.m_pServer = pServer
	self.m_dAllMonster = {}
end

function CMonsterMgr:AddMonster(nMosterID, nMosterSID, tMonsterPath)
	self.m_dAllMonster[nMosterID] = CMonster.new(nMosterID, nMosterSID, tMonsterPath)
end

function CMonsterMgr:GetAllMonster()
	return self.m_dAllMonster
end

function CMonsterMgr:MonsterReached(nMosterID)
	self.m_dAllMonster[nMosterID] = nil
	self.m_pServer:MonsterMgr_MonsterReached(nMosterID)
end

function CMonsterMgr:update(fDeltaTime)
	for nMosterID, pMoster in pairs(self.m_dAllMonster) do
		pMoster:update(fDeltaTime)
		self.m_pServer:MonsterMgr_MonsterMove(nMosterID, pMoster:GetXYPos())
		if pMoster:GetIsReached() then
			self:MonsterReached(nMosterID)
		end
	end
end



return CMonsterMgr