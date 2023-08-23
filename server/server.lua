ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('wx_bossmenu:hireEmployee')
AddEventHandler('wx_bossmenu:hireEmployee',function (job,target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    for k,v in pairs(wx.Jobs) do
        if xPlayer.getJob().name == job and v.Permissions[xPlayer.getJob().grade].CanHire then -- Make sure player has permissions to hire players
            if source == target then
                TriggerClientEvent('ox_lib:notify', source, { title = "You cannot hire yourself!",type='error', position = 'top'})
            elseif GetPlayerName(target) ~= nil then
                xTarget.setJob(job,0)
                TriggerClientEvent('ox_lib:notify', target, { title = 'New Job', type='success', position = 'top', description = 'You have been hired in '..xPlayer.getJob().label})
                TriggerClientEvent('ox_lib:notify', source, { title = 'Success', type='success', position = 'top', description = 'You have hired '..GetPlayerName(target)})
            else
                TriggerClientEvent('ox_lib:notify', source, { title = 'This player is not online',type='error', position = 'top'})
            end
        else
            -- exports['wx_anticheat']:ban(source,"Bossmenu Exploiting")
            print('CHEATER - '..GetPlayerName(source))
        end
    end
end)

RegisterNetEvent('wx_bossmenu:kickEmployee')
AddEventHandler('wx_bossmenu:kickEmployee',function (job,target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    for k,v in pairs(wx.Jobs) do
        if xPlayer.getJob().name == job and v.Permissions[xPlayer.getJob().grade].CanKick then
            if source == target then
                TriggerClientEvent('ox_lib:notify', source, { title = "You cannot kick yourself!",type='error', position = 'top'})
            elseif GetPlayerName(target) ~= nil then
                xTarget.setJob('unemployed',0)
                TriggerClientEvent('ox_lib:notify', target, { title = 'You have lost your job in '..job, type='error', position = 'top'})
                TriggerClientEvent('ox_lib:notify', source, { title = 'Success', type='success', position = 'top', description = 'You have kicked '..GetPlayerName(target)})
            else
                TriggerClientEvent('ox_lib:notify', source, { title = 'This player is not online',type='error', position = 'top'})
            end
        else
            -- exports['wx_anticheat']:ban(source,"Bossmenu Exploiting")
            print('CHEATER - '..GetPlayerName(source))
        end
    end
end)

RegisterNetEvent('wx_bossmenu:promoteEmployee')
AddEventHandler('wx_bossmenu:promoteEmployee',function (job,target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    for k,v in pairs(wx.Jobs) do
        if xPlayer.getJob().name == job and v.Permissions[xPlayer.getJob().grade].CanPromote then
            if source == target then
                TriggerClientEvent('ox_lib:notify', source, { title = "You cannot promote yourself!",type='error', position = 'top'})
            elseif GetPlayerName(target) ~= nil then
                xTarget.setJob(job,xPlayer.getJob().grade+1)
                TriggerClientEvent('ox_lib:notify', target, { title = 'You have been promoted to '..xPlayer.getJob().grade_label, type='success', position = 'top'})
                TriggerClientEvent('ox_lib:notify', source, { title = 'Success', type='success', position = 'top', description = 'You have promoted '..GetPlayerName(target)})
            else
                TriggerClientEvent('ox_lib:notify', source, { title = 'This player is not online',type='error', position = 'top'})
            end
        else
            -- exports['wx_anticheat']:ban(source,"Bossmenu Exploiting")
            print('CHEATER - '..GetPlayerName(source))
        end
    end
end)

RegisterNetEvent('wx_bossmenu:demoteEmployee')
AddEventHandler('wx_bossmenu:demoteEmployee',function (job,target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    for k,v in pairs(wx.Jobs) do
        if xPlayer.getJob().name == job and v.Permissions[xPlayer.getJob().grade].CanPromote then
            if source == target then
                TriggerClientEvent('ox_lib:notify', source, { title = "You cannot demote yourself!",type='error', position = 'top'})
            elseif GetPlayerName(target) ~= nil then
                xTarget.setJob(job,xPlayer.getJob().grade-1)
                TriggerClientEvent('ox_lib:notify', target, { title = 'You have been demoted to '..xPlayer.getJob().grade_label, type='error', position = 'top'})
                TriggerClientEvent('ox_lib:notify', source, { title = 'Success', type='success', position = 'top', description = 'You have demoted '..GetPlayerName(target)})
            else
                TriggerClientEvent('ox_lib:notify', source, { title = 'This player is not online',type='error', position = 'top'})
            end
        else
            -- exports['wx_anticheat']:ban(source,"Bossmenu Exploiting")
            print('CHEATER - '..GetPlayerName(source))
        end
    end
end)

