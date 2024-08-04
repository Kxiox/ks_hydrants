Config = {}

Config.Locale = 'en'

Config.PrintLocationInConsole = false -- print coords of destroyed hydrant in console

Config.ExtraList = { -- extralist if some hydrants missing (vector3())

}

Config.Command = 'hydrants'

Config.Marker = { -- marker options for destroyed hydrants
    color = {r = 255, g = 255, b = 0, a = 200}
}

Config.Blip = {
    sprite = 436,
    color = 1,
    scale = 0.5
}

Config.DestroyerInterval = 1 * 45 -- time (ms) between hydrant destroy (default: 45m)

function canOpenMenu() -- permission to open menu
    return true
end

function SkillCheck() -- skillcheck for repair
    return lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'medium', 'medium'}, {'w', 'a', 's', 'd'})
end

function allowDestroy() -- when can a hydrant destroy
    return true
end

function canRepair() -- permission to repair
    return true
end

function dispatch(coords) --dispatch for destroyed hydrants
    TriggerEvent('emergencydispatch:emergencycall:new', 'fire', Locales[Config.Locale]['dispatch_description'], coords, true)
end

function Notify(text, type, time)
    lib.notify({
        title = Locales[Config.Locale]['notify_title'],
        description = text,
        type = type,
        duration = time,
        position = 'top'
    })
end

function HelpNotify(type)
    lib.showTextUI('[E] - Repair', {
        position = "top-center",
        icon = 'wrench',
        style = {
            backgroundColor = '#478611',
            color = 'white'
        }
    })
end
