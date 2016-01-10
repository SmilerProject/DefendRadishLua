
local CTowerCache = class("CTowerCache")

function CTowerCache:ctor()
	self.m_nID = 0
	self.m_nGrade = 0
	self.m_pTowerData = require("app.data.towerdata.Tower101")
end

function CTowerCache:update(fTime)
end

return CTowerCache