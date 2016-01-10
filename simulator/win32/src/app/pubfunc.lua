
local pubfunc = {}

local GetSerializeString

local function SaveDataToLuaFile(dData, sFileName, sTableName)
  -- 将数据保存为lua文件
  local pFile = io.open(sFileName, "w")
  assert(pFile)
  pFile:write(string.format("local %s = \n", sTableName))
  pFile:write(GetSerializeString(dData))
  pFile:write(string.format("return %s\n", sTableName))
  pFile:close()
end

function GetSerializeString(pObj)
    local sStr = ""  
    local sType = type(pObj)  
    if sType== "number" then  
        sStr = sStr .. pObj
    elseif sType== "boolean" then
        sStr = sStr .. tostring(pObj)
    elseif sType== "string" then
        sStr = sStr .. string.format("%q", pObj)
    elseif sType== "table" then
        sStr = sStr .. "{\n"
        -- 根据key排序
        local tKey = {}
        for i in pairs(pObj) do
           table.insert(tKey,i)
        end
        table.sort(tKey)
        for i,k in pairs(tKey) do
          sStr = sStr .. "[" .. GetSerializeString(k) .. "]=" .. GetSerializeString(pObj[k]) .. ",\n"  
        end

        -- local metatable = getmetatable(pObj)  
        --     if metatable ~= nil and type(metatable.__index) == "table" then  
        --     for k, v in pairs(metatable.__index) do  
        --         sStr = sStr .. "[" .. GetSerializeString(k) .. "]=" .. GetSerializeString(v) .. ",\n"  
        --     end  
        -- end  
        sStr = sStr .. "}\n"  
    elseif sType== "nil" then  
        return nil  
    else  
        error("can not serialize a " .. sType .. " type.")  
    end  
    return sStr  
end

pubfunc.SaveDataToLuaFile = SaveDataToLuaFile


local function RC2XY(nR, nC)
  local pubdefines = require("app.pubdefines")
  return cc.p((nC-0.5)*pubdefines.GRIDSIZE.w, (nR-0.5)*pubdefines.GRIDSIZE.h)
end
pubfunc.RC2XY = RC2XY
return pubfunc