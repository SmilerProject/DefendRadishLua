-- 胡萝卜动画

local CAdvanceSprite = require("app.views.CAdvanceSprite")

local CWarCarrot = class("CWarCarrot", function ()
	return cc.Node:create()
end)

function CWarCarrot:ctor()
	self:InitSprite()

end

function CWarCarrot:InitSprite()
	self.m_pSprite = CAdvanceSprite.create("hlb", 1, 3, 0.1)
	self:addChild(self.m_pSprite)
	self.m_pSprite:setPosition(0, 20)
end


function CWarCarrot:PlayAni()
	self.m_pSprite:PlayAni()
end

function CWarCarrot:PlayIdleAni()
	self.m_pSprite:StopAni()
end

return CWarCarrot