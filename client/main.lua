if GetResourceState('es_extended') == 'started' then
    ESX = exports['es_extended']:getSharedObject()
    Framework = 'esx'

elseif GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
    Framework = 'qb'
end

-- Register event
RegisterNetEvent('sd-adminzone:client:spawnzone')
AddEventHandler('sd-adminzone:client:spawnzone', function(adminSource)
    local adminPed = GetPlayerPed(GetPlayerFromServerId(adminSource))
    local adminCoords = GetEntityCoords(adminPed)

    local blip = AddBlipForCoord(adminCoords.x, adminCoords.y, adminCoords.z)
    SetBlipSprite(blip, 1)
    SetBlipColour(blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Admin Zone")
    EndTextCommandSetBlipName(blip)

    local radiusBlip = AddBlipForRadius(adminCoords.x, adminCoords.y, adminCoords.z, 100.0)
    SetBlipColour(radiusBlip, 1)
    SetBlipAlpha(radiusBlip, 128)

    -- Display a notification to all players
    if Config.Notify == 'chat' then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"[Server]", "An admin zone has been created."}
        })
    elseif Config.Notify == 'notification' then
        if Framework == 'esx' then
            ESX.ShowNotification('An Admin zone has been created.')
        elseif Framework == 'qb' then
            QBCore.Functions.Notify('An Admin zone has been created.', 'error')
        end
    end

    local timeout = Config.Timeout * 60000
    SetTimeout(timeout, function()
        RemoveBlip(blip)
        RemoveBlip(radiusBlip)
    end)
end)