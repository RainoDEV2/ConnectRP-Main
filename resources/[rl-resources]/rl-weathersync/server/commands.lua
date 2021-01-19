RLCore.Commands.Add("blackout", "Turn off all city lights", {}, false, function(source, args)
    ToggleBlackout()
end, "admin")

RLCore.Commands.Add("clock", "Set Time", {}, false, function(source, args)
    if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
        SetExactTime(args[1], args[2])
    end
end, "admin")

RLCore.Commands.Add("weather", "Set the Weather", {}, false, function(source, args)
    for _, v in pairs(AvailableWeatherTypes) do
        if args[1]:upper() == v then
            SetWeather(args[1])
            return
        end
    end
end, "admin")

RLCore.Commands.Add("freeze", "Freeze Weather/Time", {}, false, function(source, args)
    if args[1]:lower() == 'weather' or args[1]:lower() == 'time' then
        FreezeElement(args[1])
    end
end, "admin")