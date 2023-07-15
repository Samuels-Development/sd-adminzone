if GetResourceState('es_extended') == 'started' then
    ESX = exports['es_extended']:getSharedObject()
    Framework = 'esx'

elseif GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
    Framework = 'qb'
end

if Framework == 'qb' then
local src = source
    QBCore.Commands.Add('adminzone', '', {}, false, function(source, args)
        TriggerClientEvent('sd-adminzone:client:spawnzone', -1, src)
    end,'admin')
else
    ESX.RegisterCommand('adminzone', 'admin', function(xPlayer, args, showError)
        args.playerId.triggerEvent('sd-adminzone:client:spawnzone', -1, src)
    end, true, { help = 'Create Admin Zone', validate = true })
end
