
ESX = exports["es_extended"]:getSharedObject()

local function getRandomItem()
    local randomIndex = math.random(1, #BL_Config.DailyItems)
    return BL_Config.DailyItems[randomIndex]
end

RegisterNetEvent('bl_base:daily-item', function()
    local src = source
    local item = getRandomItem()
    local amount = BL_Config.DefaultAmount
    if BL_Config.amount[item] then
        amount =  BL_Config.amount[item] 
    end
    if exports.ox_inventory:CanCarryItem(src, item, amount) then
         exports.ox_inventory:AddItem(src, item, amount)
         ServerNotify(src, 'success', BL_Config.ServerName.. ' | DAILY', 'Du hast '..amount..'x '..item.. ' erhalten!', BL_Config.NotifyDuration)
     else
        ServerNotify(src, 'error', BL_Config.ServerName.. ' | DAILY', BL_Config.language.notify.not_enough_inv, BL_Config.NotifyDuration)
        TriggerClientEvent('bl_base:resetdaily', src)
     end
     if source == nil then 
        print('nil source')
     end
end)

RegisterCommand(BL_Config.ResetAllTimer, function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() == BL_Config.AdminGroup then 
        TriggerClientEvent('bl_base:resetdaily', -1)
    else
        ServerNotify(source, 'error', BL_Config.ServerName.. ' | ADMIN', BL_Config.language.notify.no_permission, BL_Config.NotifyDuration)
    end
end)
