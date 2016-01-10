local CTower = require("app.warserver.CTower")
local CTowerMgr = class("CTowerMgr")
function CTowerMgr:ctor(pServer)
	self.m_pServer = pServer
	self.m_dAllTower = {}
end

function CTowerMgr:AddTower(nTowerID, nTowerSID)
	self.m_dAllTower[nTowerID] = CTower.new(nTowerID, nMosterSID)
end

function CTowerMgr:update(fDeltaTime)
end



return CTowerMgr