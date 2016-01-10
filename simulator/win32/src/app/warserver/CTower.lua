
local CTower = class("CTower")
local pubfunc = require("app.pubfunc")
function CTower:ctor(nID, nSID)
	self.m_nID = nID
	self.m_nSID = nSID
	self.m_pData = require(string.format("app.data.monsterdata.Monster%d", nSID))
end


function CTower:update(fDeltaTime)
end



return CTower