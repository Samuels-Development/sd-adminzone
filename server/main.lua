if GetResourceState('es_extended') == 'started' then
    ESX = exports['es_extended']:getSharedObject()
    Framework = 'esx'

elseif GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
    Framework = 'qb'
end

if Framework == 'qb' then
    QBCore.Commands.Add('adminzone', '', {}, false, function(source, args)
        local src = source
        TriggerClientEvent('sd-adminzone:client:spawnzone', -1, src)
    end,'admin')
else
    ESX.RegisterCommand('adminzone', 'admin', function(xPlayer, args, showError)
        args.playerId.triggerEvent('sd-adminzone:client:spawnzone', -1)
    end, true, { help = 'Test oil rig robbery', validate = true })
end