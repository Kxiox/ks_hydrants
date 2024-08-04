exports('openHydrantMenu', function()
    ExecuteCommand(Config.Command)
end)

exports('toggleBlips', function ()
    setBlips()
end)

exports('openMap', function ()
    map_loop()
    setBlips()
end)