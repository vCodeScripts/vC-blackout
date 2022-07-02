local QBCore = exports['qb-core']:GetCoreObject()
local Cooldown = false
local PowerOff = false
RegisterServerEvent('vC-blackout:server:setLightStateForEveryone', function(state)
    TriggerClientEvent('vC-blackout:setlightBool', -1, state)
    if state then
        PowerOff = true
    else
        PowerOff = false
    end
end)

QBCore.Functions.CreateCallback('vC-blackout:checkifPossible', function(source,cb)

    if not Cooldown and not PowerOff then
        cb(true)
    else
        cb(false)
    end
end)

exports('elektriklerKesik', function()
    return PowerOff 
end)

RegisterCommand('resetblackout', function(source)
    local src= source
    local hasPerm = QBCore.Functions.HasPermission(src, 'god')
    if hasPerm then
        TriggerEvent('vC-blackout:server:setLightStateForEveryone',false)
    end
end)



RegisterServerEvent('vC-blackout:setTimeout', function()
    SetTimeout()
end)



local timeout = false
function SetTimeout()
    timeout = true
    local min = Config.Minutes * 60
    Citizen.SetTimeout(min * 1000, function()
        timeout = false
    end)

end

AddEventHandler('explosionEvent', function(sender, ev)
    print(sender, json.encode(ev))
    local vector = vector3(ev.posX, ev.posY, ev.posZ)
    TriggerClientEvent('vC-blackout:checkifblackoutcausable', sender, vector)
end)

QBCore.Functions.CreateCallback('vC-blackout:getTimeout', function(source,cb)
    print(timeout)
    cb(timeout)

end)
