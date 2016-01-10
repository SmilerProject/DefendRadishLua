
local print_raw = print
local sLogFilePath = "client.log"

if io.exists(sLogFilePath) then
    --os.remove(sLogFilePath)
    --清空文件内容
    io.writefile(sLogFilePath, "", "w")
end

-- print
print = function(fmt, ...)
    local sFormatString = string.format(tostring(fmt), ...)
    print_raw(sFormatString)
    io.writefile(sLogFilePath, sFormatString.."\n", "a")
end

printf = function(fmt, ...)
    print(string.format(tostring(fmt), ...))
end

__G__TRACKBACK__ = function(msg)
    local msg = debug.traceback(msg, 3)
    print(msg)
    return msg
end