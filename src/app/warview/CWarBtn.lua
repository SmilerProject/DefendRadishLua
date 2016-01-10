
local w_defines=require("app.warview.w_defines")
local DEBUG = true
local CWarBtn = class("CWarBtn")

function CWarBtn:ctor(fWidth, fHeght, pCBFunc)
	self.m_fWidth = fWidth
	self.m_fHeight = fHeght
	self.m_pCBFunc = pCBFunc
	self.m_nRow = 0
	self.m_nCol = 0
	self.m_fPosX = 0
	self.m_fPosY = 0
	self.m_nStatus = w_defines.GRIDTYPE_CANPUTTOWER

	self.m_pWarBtn = cc.CSLoader:createNode("WarButton.csb")
	self.m_pWarBtn:setContentSize(fWidth,fHeght)

	local function OnClick(pSender)
		if self.m_pCBFunc ~= nil then
			self.m_pCBFunc(self)
		end
	end
	self.m_pWarBtn:getChildByName("Btn_0_0"):addClickEventListener(OnClick)

	self:PlayShowAni()
end

function CWarBtn:AddToParent(pParent)
	pParent:addChild(self.m_pWarBtn)
end

function CWarBtn:SetBtnPosRC(nRow, nCol)
	self.m_nRow = nRow
	self.m_nCol = nCol
	self:_updatePos()
end

function CWarBtn:GetBtnPosRC()
	return {self.m_nRow, self.m_nCol}
end

function CWarBtn:GetBtnPos()
	return self.m_fPosX, self.m_fPosY
end

function CWarBtn:_updatePos()
	self.m_fPosX = (self.m_nCol-0.5)*self.m_fWidth
	self.m_fPosY = (self.m_nRow-0.5)*self.m_fHeight
	self.m_pWarBtn:setPosition(self.m_fPosX, self.m_fPosY)
	if DEBUG then
		local pPosLabel = cc.Label:createWithTTF(string.format("(%d, %d)", self.m_nRow, self.m_nCol),
												"Res/fonts/arial.ttf", 12)
		pPosLabel:setAnchorPoint(cc.p(0.5, 0.5))
		pPosLabel:setColor(cc.c3b(255, 0, 0))
		self.m_pWarBtn:getParent():addChild(pPosLabel, 1)
		pPosLabel:setPosition(self.m_fPosX, self.m_fPosY)
	end
end

function CWarBtn:SetBtnType(nType)
	self.m_nStatus = nType
end

function CWarBtn:Clear()
	-- body
	local pParent = self.m_pWarBtn:getParent()
	if pParent then
		--printf("btn clear")
		pParent:removeChild(self.m_pWarBtn, true)
	end
	self.m_pWarBtn = nil
	self.m_pCBFunc = nil
end


function CWarBtn:IsCanPutTower()
	return self.m_nStatus == w_defines.GRIDTYPE_CANPUTTOWER
end
function CWarBtn:IsHasPutTower()
	return self.m_nStatus == w_defines.GRIDTYPE_HASPUTTOWER
end
function CWarBtn:IsForbiddenPut()
	return self.m_nStatus == w_defines.GRIDTYPE_FORBIDDENPUT
end
function CWarBtn:IsHasBlock()
	return self.m_nStatus == w_defines.WARBTN_BLOCK
end

function CWarBtn:SetCanPutTower()
	self.m_nStatus = w_defines.GRIDTYPE_CANPUTTOWER
end
function CWarBtn:SetHasPutTower()
	self.m_nStatus = w_defines.GRIDTYPE_HASPUTTOWER
end
function CWarBtn:SetForbiddenPut()
	self.m_nStatus = w_defines.GRIDTYPE_FORBIDDENPUT
end
function CWarBtn:SetHasBlock()
	self.m_nStatus = w_defines.WARBTN_BLOCK
end

function CWarBtn:PlayShowAni()
	local fFadeOutTime = 1.0
	local fFadeInTime = 1.0
	local pSequenceAct = cc.Sequence:create(cc.FadeOut:create(fFadeOutTime), cc.FadeIn:create(fFadeInTime))
	local pSprite = self.m_pWarBtn:getChildByName("Pic_Select")
	pSprite:runAction(cc.RepeatForever:create(pSequenceAct))
end

function CWarBtn:StopShowAni()
     self.m_pWarBtn:getChildByName("Pic_Select"):stopAllActions()
end


return CWarBtn