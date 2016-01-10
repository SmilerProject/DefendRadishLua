
local CWavesMgr = class("CWavesMgr")
function CWavesMgr:ctor(pServer)
	self.m_pServer = pServer

	self.m_dMosterData = {
							{{2,201}},
							-- {{2,201},{2, 201}},
							-- {{2,201},{2, 201},{1,201}},
						}
	self.m_nWavesNum = #self.m_dMosterData
	self.m_nCurWave = 0
	self.m_bFinish = true
end

function CWavesMgr:Start()
	self.m_bFinish = false
	self:InitNewWave()
end

function CWavesMgr:InitNewWave()
	self.m_nCurWave = self.m_nCurWave+1 --当前的波数
	if self.m_nCurWave > self.m_nWavesNum then
		self.m_bFinish = true
		printf("小怪出生结束")
		return
	end
	--printf("新的一波即将来临")
	local bIsLast = self.m_nCurWave == self.m_nWavesNum
	self.m_dCurWaveData = self.m_dMosterData[self.m_nCurWave]
	self.m_nCurWaveMosterNum = #self.m_dCurWaveData --当前波怪物总数
	self.m_nCurWaveMosterIndex = 0
	self:InitNewMosterCountDownTimer()
	self.m_pServer:WavesMgr_NewWaveComing(self.m_nCurWave, bIsLast)
end
function CWavesMgr:InitNewMosterCountDownTimer()
	self.m_nCurWaveMosterIndex = self.m_nCurWaveMosterIndex+1 -- 当前波第几个怪物
	if self.m_nCurWaveMosterIndex > self.m_nCurWaveMosterNum then
		self:InitNewWave()
		return
	end
	self.m_dCurWaveMosterData = self.m_dCurWaveData[self.m_nCurWaveMosterIndex]
	self.m_fCurWaveMosterTime = self.m_dCurWaveMosterData[1]
	self.m_fCurWaveMosterSID = self.m_dCurWaveMosterData[2]
end

function CWavesMgr:update(fDeltaTime)
	if self.m_bFinish then
		return
	end
	self.m_fCurWaveMosterTime = self.m_fCurWaveMosterTime-fDeltaTime
	if self.m_fCurWaveMosterTime <= 0 then
		--printf(string.format("出生一个小怪:%d",self.m_fCurWaveMosterSID))
		self.m_pServer:WavesMgr_AddMoster(self.m_fCurWaveMosterSID)
		self:InitNewMosterCountDownTimer() -- 设置新小怪的时间
	end
end



return CWavesMgr