local lang = Config.Locale

-- In scan_for_hydrants.lua

local blips = {}

-- Funktion zum Erstellen eines Blips
function createBlipForCoord(x, y, z, sprite, color, scale)
    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, sprite) -- Blip Icon
    SetBlipDisplay(blip, 4) -- Blip immer anzeigen
    SetBlipScale(blip, scale) -- Blip Größe
    SetBlipColour(blip, color) -- Blip Farbe
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Locales[lang]['blip_name'])
    EndTextCommandSetBlipName(blip)
    return blip
end

local blips_on = false

function setBlips()
    if not blips_on then
        blips_on = true

        for k, v in pairs(List) do
            table.insert(blips, createBlipForCoord(v.x, v.y, v.z, Config.Blip.sprite, Config.Blip.color, Config.Blip.scale))
        end

        for k, v in pairs(Config.ExtraList) do
            table.insert(blips, createBlipForCoord(v.x, v.y, v.z, Config.Blip.sprite, Config.Blip.color, Config.Blip.scale))
        end
    else
        blips_on = false

        for k, blip in pairs(blips) do
            RemoveBlip(blip)
        end

        blips = {}
    end
end

local function map_loop()
    Citizen.CreateThread(function()
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), 0, -1)
        Wait(100)
        PauseMenuceptionGoDeeper(0)
        while true do
            Citizen.Wait(10)
            if IsControlJustPressed(0, 200) then
                SetFrontendActive(0)
                setBlips()
                break
            end
        end
    end)
end

RegisterCommand(Config.Command, function(source, args, raw)
    if not canOpenMenu() then return false end

    lib.registerContext({
        id = 'hydrants_menu',
        title = Locales[lang]['menu_title'],
        options = {
            {
                title = Locales[lang]['menu_option_map'],
                description = Locales[lang]['menu_option_map_desc'],
                icon = 'map',
                onSelect = function()
                    map_loop()
                    setBlips()
                end
            },
            {
                title = Locales[lang]['menu_option_toggle_blip'],
                description = Locales[lang]['menu_option_toggle_blip_desc'],
                icon = 'map-pin',
                onSelect = function()
                    setBlips()
                    if blips_on then
                        Notify(Locales[lang]['menu_option_toggle_blip_on'], 'info', 5000)
                    else
                        Notify(Locales[lang]['menu_option_toggle_blip_off'], 'info', 5000)
                    end
                end
            }
        }
    })
    lib.showContext('hydrants_menu')
end)
