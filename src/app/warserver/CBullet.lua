
local CBullet = class("CBullet")
local pubfunc = require("app.pubfunc")
function CBullet:ctor(nID, nSID, rcPos)
	self.m_nID = nID
	self.m_nSID = nSID
	self.m_xyPos = pubfunc.RC2XY(rcPos[1], rcPos[2])
end

function CBullet:GetXYPos()
	return self.m_xyPos
end


function CBullet:update(fDeltaTime)
end


return CBullet