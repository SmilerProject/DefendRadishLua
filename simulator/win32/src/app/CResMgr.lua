
local CResMgr = class("CResMgr")

CResMgr.m_pInstance = nil

function CResMgr.getInstance()
	if CResMgr.m_pInstance == nil then
		CResMgr.m_pInstance = CResMgr:new()
	end
	return CResMgr.m_pInstance
end

function CResMgr:LoadPlistOnline()
	-- 进入游戏就加载的资源
	local pSpriteFrameCache= cc.SpriteFrameCache:getInstance()
    pSpriteFrameCache:addSpriteFrames("Res/Theme1/Items/Monsters01-hd.plist")
    pSpriteFrameCache:addSpriteFrames("Res/Items/Items02-hd.plist")
end

return CResMgr