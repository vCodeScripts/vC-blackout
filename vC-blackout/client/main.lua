local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent('vC-blackout:setlightBool', function(bool)
    SetArtificialLightsState(bool)
    SetBlackout(bool)
    if not bool then
        PlaySoundFrontend(-1, "police_notification", "DLC_AS_VNT_Sounds", 1)
        TriggerEvent('chatMessage', "LS Water & Power", "warning", "The power and electricity have both been restored. LS Water & Power thanks you for your patience.")

    else
        PlaySoundFrontend(-1, "Power_Down", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
        TriggerEvent('chatMessage', "LS Water & Power", "warning", "City power is currently out, we're working on restoring it!")
	TriggerEvent('vC-blackout:dispatch')
    end

end)

exports['qb-target']:AddBoxZone("vC-blackout", vector3(712, 165.440, 80.754), 1.3, 0.35, {
	name = "vC-blackout",
	heading = 71.0,
	debugPoly = false,
}, {
	options = {
        {
            event = "vC-blackout:police",
			icon = "fa-solid fa-plug",
			label = "Restore Electricity",
            job = "police", 
		},
	},
	distance = 2.5
})

RegisterNetEvent('vC-blackout:checkifblackoutcausable', function(vector)
    local distance = GetDistanceBetweenCoords(Config.BombSite,vector, true )
    if distance < 3 then 
        ChainReaction()
    end


end)


RegisterNetEvent("vC-blackout:police", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.job.name ~= nil and PlayerData.job.name == "police" then
        QBCore.Functions.TriggerCallback('vC-blackout:checkifPossible', function(possible)
            if not possible then
                QBCore.Functions.TriggerCallback('vC-blackout:getTimeout', function(possible)
                    if not possible then
                        exports["memorygame"]:thermiteminigame(10, 3, 3, 10,
                            function() -- success
                                ClearPedTasksImmediately(PlayerPedId())    
                                TriggerServerEvent('vC-blackout:server:setLightStateForEveryone',false)
                            end,
                            function() -- failure
                                ClearPedTasksImmediately(PlayerPedId()) 
                                TriggerEvent('chatMessage', "SYSTEM", "warning", "You Couldn't Restore Electricity. The System Is Restarting. The System Restart Will Take "..Config.Minutes.." Minutes.")
                                --- 
                                TriggerServerEvent('vC-blackout:setTimeout')

                        end)
                    else
                        QBCore.Functions.Notify('Wait Before Trying Again!', 'error')
                    end
                end)
            else
                QBCore.Functions.Notify('Are you trying to cause a blackout?', 'error')
            end
        end)
    end
end)









function ChainReaction()
    for i=1, #Config.ExplosionLocations do
        Citizen.Wait(300)
        AddExplosion(Config.ExplosionLocations[i],34, 20.0, true, false, 1.0, true)
    end
    TriggerServerEvent('vC-blackout:server:setLightStateForEveryone', true)
end
