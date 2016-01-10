-- 防御塔基类
local CWarTowerBase = class("CWarTowerBase")

function CWarTowerBase:ctor()
	self.m_nID = 0 -- ID
	self.m_nSID = 0 -- 造型SID
	self.m_fAttackSpeed = 0 -- 攻击速度(根据SID读表)
	self.m_fAttackRadius = 0 -- 攻击半径(根据SID读表)
	self.m_nBuildCostGold = 0 -- 建造花费的价格(根据SID读表)
	self.m_nDelGainGold = 0 -- 铲除获得的价格(根据SID读表)
	self.m_pSprite = nil -- 图片对象(根据SID读资源路径)
end


-- 防御塔工厂
local CWarTowerFactory = class("CWarTowerFactory")
CWarTowerFactory.m_pInstance = nil

function CWarTowerFactory.getInstance()
	if CWarTowerFactory.m_pInstance == nil then
		CWarTowerFactory.m_pInstance = CWarTowerFactory:new()
	end
	return CWarTowerFactory.m_pInstance
end

function CWarTowerFactory:CreateTower()
	-- body
	return CWarTowerBase.new()
end

return CWarTowerFactory