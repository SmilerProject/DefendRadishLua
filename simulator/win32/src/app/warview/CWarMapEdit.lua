
local CWarMapEdit = class("CWarMapEdit")

function CWarMapEdit:ctor()
end

function CWarMapEdit:SaveMapFile()
  local pubfunc = require("app.pubfunc")
  local w_defines = require("app.warview.w_defines")
  local nRows = 7
  local nCols = 12
  local nMapID = 1001
  local dData = {["vMapSize"]={nRows, nCols}, ["dGridData"]={},
  				["dBlockData"]={},
                ["tBornPoint"]={{6,2}},
                ["tCarrotPoint"]={{6,11}}}
  for nR = 1, nRows do
      for nC = 1, nCols do
        dData["dGridData"][string.format("%d_%d", nR, nC)] = {["nGridType"]=0}
      end
  end

  local dForbiddenPut = {{1,1}, {1,2},{1,11},{1,12},{6,12}}
  
  local dBlock = {{3,6},{3,7},{5,5},{5,8},{6,6},{6,7},{7,6},{7,7},
                  {7,4},{7,5},{6,4},{6,5},{7,8},{7,9},{6,8},{6,9},
                  {4,3},{4,10}}
  for k, v in pairs(dForbiddenPut) do
    dData["dGridData"][string.format("%d_%d", v[1], v[2])]["nGridType"] = w_defines.GRIDTYPE_FORBIDDENPUT
  end

  for k, v in pairs(dBlock) do
    dData["dGridData"][string.format("%d_%d", v[1], v[2])]["nGridType"] = w_defines.GRIDTYPE_HASBLOCK
  end


  local sPath = "../../src/app/data/mapdata/"
  pubfunc.SaveDataToLuaFile(dData, sPath..string.format("Map%d.lua", nMapID), "MapData")
end

return CWarMapEdit