
local CWarBtnMgr = class("CWarBtnMgr")
local CWarBtn = require("app.warview.CWarBtn")
local CAdvanceSprite = require("app.views.CAdvanceSprite")

function CWarBtnMgr:ctor(pWar,dGridData)--jingjing
	self.m_fBtnWidth = 52
	self.m_fBtnHeight = 52
	self.m_pWar = pWar
	self.m_dAllBtn = {}


	-- 点击动画
	self.m_pCanPutAni = CAdvanceSprite.create("select_", 1, 4, 0.1)
	pWar:addChild(self.m_pCanPutAni)
	self.m_pCanPutAni:setVisible(false)
	-- local nRows, nCols = 7, 12 -- 7, 12
	-- for nR = 1, nRows do
 --    	for nC = 1, nCols do
 --    		local pWarBtn = CWarBtn.new(self.m_fBtnWidth, self.m_fBtnHeight, handler(self,self.ClickWarBtn))
 --    		pWarBtn:AddToParent(pWar)
 --    		pWarBtn:SetBtnPosRC(nR, nC)
 --    		self.m_dAllBtn[pWarBtn] = "nR = "..nR..",nC = "..nC
 --    	end
 --    end
 	-- 解析格子数据，加载type
 	local nRows,nCols,nType
 	-- printf(dGridData)
 	for i,v in pairs(dGridData) do
		local result = string.split(i,"_")
		local nR = result[1]
		local nC = result[2]
		local pWarBtn = CWarBtn.new(self.m_fBtnWidth, self.m_fBtnHeight, handler(self,self.ClickWarBtn))
    	pWarBtn:AddToParent(pWar)
    	pWarBtn:SetBtnPosRC(nR, nC)
    	self.m_dAllBtn[pWarBtn] = "nR = "..nR..",nC = "..nC
    	pWarBtn:SetBtnType(v.nGridType)

	 	printf(nR)
	 	printf(nC)
 		printf(v.nGridType)

 	end




end

function CWarBtnMgr:ClickWarBtn(pWarBtn)
	printf(self.m_dAllBtn[pWarBtn])
	printf(pWarBtn.m_nStatus)
	-- if pWarBtn:IsCanPutTower() then
	-- 	local x, y = pWarBtn:GetBtnPos()
	-- 	self.m_pCanPutAni:setPosition(x, y)
	-- 	self.m_pCanPutAni:setVisible(true)
	-- 	self.m_pCanPutAni:PlayAni()
	-- 	pWarBtn:SetHasPutTower()
	-- elseif pWarBtn:IsHasPutTower() then
	-- 	self.m_pCanPutAni:setVisible(false)
	-- 	self.m_pCanPutAni:StopAni()
	-- 	pWarBtn:SetCanPutTower()
	-- end
end

function CWarBtnMgr:Clear()
	for pWarBtn, value in pairs(self.m_dAllBtn) do
		pWarBtn:Clear()
	end
	self.m_pWar = nil
	self.m_dAllBtn = nil
	self.m_fBtnWidth = nil
	self.m_fBtnHeight = nil
end

return CWarBtnMgr