local CBullet = require("app.warserver.CBullet")
local CBulletMgr = class("CBulletMgr")
function CBulletMgr:ctor(pServer)
	self.m_pServer = pServer
	self.m_dBullet = {}
end

function CBulletMgr:AddBullet(nID, nSID)
	self.m_dBullet[nID] = CBullet.new(nID, nSID)
end


function CBulletMgr:update(fDeltaTime)
	for nTowerID, pTower in pairs(self.m_dAllTower) do
		self:CheckTowerCanAttack(pTower)
		pTower:update(fDeltaTime)
	end
end


return CBulletMgr