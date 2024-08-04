exports('destroyHydrant', function ()
    local hydrant = List[math.random(0, #List - 1)]
    GlobalState.hydrant_destoryed = true
    GlobalState.current_hydrant = hydrant
    dispatch(hydrant)
end)

exports('repairDestroyedHydrant', function ()
    TriggerEvent('ks_hydrants:setStates', false, nil)
end)
