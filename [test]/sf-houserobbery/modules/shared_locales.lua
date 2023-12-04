Locales = {}

function _L(name, ...)
    if(not Locales[Language][name]) then
        Verbose(("Invalid locale %s"):format(tostring(name)), "error")
        return ""
    end
    return string.format(Locales[Language][name], ...)
end

function _LOCALE(name, ...)
    if(not Locales[Language][name]) then
        Verbose(("Invalid locale %s"):format(tostring(name)), "error")
        return ""
    end
    return string.format(Locales[Language][name], ...)
end