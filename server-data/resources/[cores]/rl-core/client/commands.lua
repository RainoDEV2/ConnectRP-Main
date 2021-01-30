RegisterCommand("nui", function(source, args, raw)
    local toggle = tostring(args[1])
    if toggle == "1" then
        SetNuiFocus(true, true)
    else
        SetNuiFocus(false, false)
    end
end)