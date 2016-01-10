
local CServerBase = class("CServerBase")
function CServerBase:ctor(pListener)
	self.m_nMapID = 0 -- ID
	self.m_nGoldNum = 450 -- 初始金币数量
	self.m_nWaves = 15 -- 怪物波数
	self.m_fCountDownTime = 0.1 -- 开始倒计时3秒
	self.m_bPause = false -- 是否暂停游戏
	self.m_pListener = pListener

	self.m_nID = 0
end

function CServerBase:RequestStartWar(nMapID)
	self:LoadMapData(nMapID)
end

function CServerBase:LoadMapData(nMapID)

	nMapID = nMapID or 1001
	self.m_nMapID = nMapID
	local dMapData = require("app.data.mapdata."..string.format("Map%d", nMapID))
	self.m_nMapRow = dMapData["vMapSize"][1]
	self.m_nMapCol = dMapData["vMapSize"][2]
	self.m_tBornPoint = dMapData["dBornPoint"]
	self.m_tGridData = dMapData["dGridData"]
	local pScheduler = cc.Director:getInstance():getScheduler()

	self.m_pListener:StartWar()
	pScheduler:scheduleScriptFunc(handler(self, self.update), 0, false)
	self.m_pWavesMgr = require("app.warserver.CWavesMgr").new(self)
	self.m_pWavesMgr:Start()

	self.m_pMonsterMgr = require("app.warserver.CMonsterMgr").new(self)

end

function CServerBase:GetNewID()
	self.m_nID = self.m_nID + 1
	return self.m_nID
end

function CServerBase:GetMonsterBornPoint()
	return self.m_tBornPoint[1]
end

function CServerBase:GetMonsterPath()
	return {{6,2},{5,2},{4,2},{3,2},{3,3},{3,4},{3,5},{4,5},{4,6},{4,7},{4,8},{3,8},{3,9},{3,10},{3,11},{4,11},{5,11},{6,11}}
end

function CServerBase:GetGridData()
	return self.m_tGridData
end

function CServerBase:update(fDeltaTime)
	-- body
	if self.m_bPause then
		return
	end
	if self.m_fCountDownTime > 0 then
		self.m_fCountDownTime = self.m_fCountDownTime-fDeltaTime
		-- 倒计时3秒
		return
	end
	self.m_pWavesMgr:update(fDeltaTime)
	self.m_pMonsterMgr:update(fDeltaTime)
end

--以下是在update中会回调的接口
--提供给CWavesMgr调用的接口
function CServerBase:WavesMgr_AddMoster(nMonsterSID)
	printf("出生一个小怪:"..nMonsterSID)
	local nMonsterID = self:GetNewID()
	self.m_pListener:AddMonster(nMonsterID, nMonsterSID, self:GetMonsterBornPoint())
	self.m_pMonsterMgr:AddMonster(nMonsterID, nMonsterSID, self:GetMonsterPath())
end
function CServerBase:WavesMgr_NewWaveComing(nWave, bIsLast)
	printf("波数:"..nWave)
	printf(bIsLast)
end
--提供给MonsterMgr调用的接口
function CServerBase:MonsterMgr_MonsterMove(nMonsterID, xyPos)
	self.m_pListener:MonsterMove(nMonsterID, xyPos)
end
function CServerBase:MonsterMgr_MonsterReached(nMonsterID)
	self.m_pListener:MonsterReached(nMonsterID)
end

--提供给TowerMgr调用的接口

return CServerBase