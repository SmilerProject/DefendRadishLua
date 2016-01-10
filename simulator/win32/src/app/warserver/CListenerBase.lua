
local CListenerBase = class("CListenerBase")

function CListenerBase:ctor(pWar)
	self.m_pWar = pWar
end

function CListenerBase:StartWar()
	self.m_pWar:PlayCountDownAni()
end

function CListenerBase:AddMonster(nMonsterID, nMonsterSID, rcPos)
	self.m_pWar:AddMonster(nMonsterID, nMonsterSID, rcPos)
end

function CListenerBase:MonsterMove(nMonsterID, xyPos)
	self.m_pWar:MonsterMove(nMonsterID, xyPos)
end
function CListenerBase:MonsterReached(nMonsterID)
	self.m_pWar:MonsterReached(nMonsterID)
end
return CListenerBase