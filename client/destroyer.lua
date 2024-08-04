local lang = Config.Locale

RequestNamedPtfxAsset('core')

function startParticle(name, coords)
    UseParticleFxAssetNextCall("core")
    StartNetworkedParticleFxNonLoopedAtCoord(name, coords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
end

Citizen.CreateThread(function ()
    while true do
        local sleep = 1000

        if GlobalState.hydrant_destoryed then
            sleep = 100
            local distance = GetDistanceBetweenCoords(GlobalState.current_hydrant.x, GlobalState.current_hydrant.y, GlobalState.current_hydrant.z, GetEntityCoords(PlayerPedId()), true)

            if distance <= 50 then
                if not GlobalState.entered then
                    TriggerServerEvent('ks_hydrants:setEntered', true)
                    startParticle('exp_water', GlobalState.current_hydrant)
                end
            end

            if canRepair() then
                if distance <= 20 then
                    sleep = 0
    
                    DrawMarker(3, GlobalState.current_hydrant.x, GlobalState.current_hydrant.y, GlobalState.current_hydrant.z + 2, 0.0, 0.0, 0.0, 0.0, 180.0, 0, 0.4, 0.4, 0.4, Config.Marker.color.r, Config.Marker.color.g, Config.Marker.color.b, Config.Marker.color.a, true, true, 2, false, nil, nil, false)
                    if distance <= 1.5 then
                        HelpNotify()
    
                        if IsControlJustReleased(0, 51) then
                            local success = SkillCheck()
    
                            if success then
                                lib.hideTextUI()
                                TriggerServerEvent('ks_hydrants:setStates', false, nil)
                                Notify(Locales[lang]['notify_repair_success'], 'success', 5000)
                                TriggerServerEvent('ks_hydrants:setEntered', false)
                                Wait(5000)
                            end
                        end
                    else
                        lib.hideTextUI()
                    end
                end    
            end
        end
        Wait(sleep)
    end
end)