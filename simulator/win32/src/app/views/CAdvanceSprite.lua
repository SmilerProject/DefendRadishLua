
local CAdvanceSprite = class("CAdvanceSprite", function ()  
    return cc.Sprite:create()
    end)

function CAdvanceSprite.create(sSpriteName, nStartFrame, nEndFrame, fDelayPerUnit)
    local pAdvanceSprite = CAdvanceSprite.new(sSpriteName, nStartFrame, nEndFrame, fDelayPerUnit)
    return pAdvanceSprite
end

function CAdvanceSprite:ctor(sSpriteName, nStartFrame, nEndFrame, fDelayPerUnit)
    -- sSpriteName -> 动画帧名
    -- nStartFrame -> 起始帧
    -- nEndFrame -> 结束帧
    -- fDelayPerUnit -> 每帧延迟
    self.m_sSpriteName = sSpriteName
    self.m_nStartFrame = nStartFrame or 1
    self.m_nEndFrame = nEndFrame or 2
    self.m_fDelayPerUnit = fDelayPerUnit or 0.5
end

function CAdvanceSprite:_getAni()
    --[[
    如果使用 self.m_pAction 保存该Action
    在动画结束后，C++层对象就会被释放了，再次调用runAtcion(self.m_pAction) 时就会报错 nil value
    如果要保留该Action，应当使用 self.m_pAction.retain()
    释放时使用 self.m_pAction.release()
    ]]
    local pSpriteFrameCache= cc.SpriteFrameCache:getInstance()
    local pAnimation = cc.Animation:create()
    for nFrameIndex=self.m_nStartFrame, self.m_nEndFrame do
        local sName = self.m_sSpriteName..string.format("%02d.png", nFrameIndex)
        pAnimation:addSpriteFrame(pSpriteFrameCache:getSpriteFrame(sName))
    end
    pAnimation:setDelayPerUnit(self.m_fDelayPerUnit)
    pAnimation:setRestoreOriginalFrame(true)
    return cc.RepeatForever:create(cc.Animate:create(pAnimation))
end

function CAdvanceSprite:PlayAni()
    self:runAction(self:_getAni())
end

function CAdvanceSprite:StopAni()
    self:stopAllActions()
end

return CAdvanceSprite
