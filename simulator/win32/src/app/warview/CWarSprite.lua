
local CWarMap = class("CWarMap")

function CWarMap:ctor(nRows, nCols, pParent)
	-- 参数说明: nRows  nCols
	-- 7 * 12

	-- (R7, C0) (R7, C1) (R7, C2) ... (R7, C12)
	-- ...      ...      ...
	-- (R2, C0) (R2, C1) (R2, C2) ... (R2, C12)
	-- (R1, C0) (R1, C1) (R1, C2) ... (R1, C12)
	-- (R0, C0) (R0, C1) (R0, C2) ... (R0, C12)
	
	printf("yy = "..nRows..nCols)
	self.m_nRows = nRows
	self.m_nCols = nCols
	self.m_pParent = pParent
	printf("xxx")
end

return CWarMap