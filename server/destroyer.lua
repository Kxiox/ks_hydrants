GlobalState.hydrant_destoryed = false
GlobalState.current_hydrant = nil
GlobalState.entered = false

Citizen.CreateThread(function ()
    while true do
        Wait(Config.DestroyerInterval)
        if allowDestroy() then
            if not GlobalState.hydrant_destoryed then
                local hydrant = List[math.random(0, #List - 1)]
                if Config.PrintLocationInConsole then print(hydrant) end
                GlobalState.hydrant_destoryed = true
                GlobalState.current_hydrant = hydrant
                dispatch(hydrant)
            end
        end
    end
end)

RegisterServerEvent('ks_hydrants:setStates')
AddEventHandler('ks_hydrants:setStates', function (bool, coords)
    GlobalState.hydrant_destoryed = bool
    GlobalState.current_hydrant = coords
end)

RegisterServerEvent('ks_hydrants:setEntered')
AddEventHandler('ks_hydrants:setEntered', function (bool)
    GlobalState.entered = bool
end)

