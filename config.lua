BL_Config = {}

BL_Config.ServerName = 'BLACKLINE'
BL_Config.Key = 'O' -- key to open the menu
BL_Config.Banner = 'https://cdn.discordapp.com/attachments/1124448216100917250/1220811566539341884/oie_2220621EG5DhOUG.gif?ex=66104c5f&is=65fdd75f&hm=fdbc71f6d39405ddad9916a3e3aaa5305191e15e906c67e84f39119db0dbbc0d&' -- BANNER SIZE || 611, 344
BL_Config.AdminGroup = 'admin'


-- ADMIN COMMANDS--
BL_Config.ResetMyTimer = 'resetmytimer'
BL_Config.ResetAllTimer = 'resetalltimer'
BL_Config.GETKVP = 'getkvp' -- check your current things [lastClaimed and canClaim]



-- Language--
BL_Config.language = {
    ['menu'] = {
        ['menu_head'] = 'Daily Belohnung',
        ['menu_1'] = 'Blackline Daily Bonus',
        ['menu_2'] = 'Alle 24 Stunden',
        ['menu_button'] = 'Erhalte deine Daily Belohnung',
        ['menu_button_description'] = 'Drücke ~g~[ENTER]~s~ um deine Belohnung zu erhalten'
    },
    ['notify'] = {

       -- ['time_remaining'] = 'Du musst noch '..hour..' Stunden '..minute .. ' Minuten und ' ..second.. ' Sekunden warten!',
        ['no_permission'] = 'Du hast keine Rechte für diesen Command',
        ['reset_timer'] = 'Timer erfolgreich zurückgesetzt', 
        ['reset_all_timer'] = 'ALLE Timer erfolgreich zurückgesetzt',
        ['loading_daily_bonus'] = 'Daily Belohnungen geladen',
        ['not_enough_inv'] = 'Du hast nicht genug Platz im Inventar',
     --   ['receive_item'] = 'Du hast '..amount..'x '..item.. ' erhalten!',
 
    }
}

BL_Config.TimetoClaim = {
    day = 0,  
    hour = 24, 
    minute = 0, 
    second = 0
}

BL_Config.DailyItems = {
    "black_phone",
    "money",
    "tong",
    "burger",
    "water",
    "cola",
    "bread",
    "iron",
    "worms",
    "phone_dongle",
    "pisswasser",
    "coffee",
    "rolex",
    "powerbank",
    "repairkit",
    "graphic_card",
    "weedpot",
}

BL_Config.DefaultAmount = 1 

BL_Config.amount = {
    money = 2000,
    burger = 3,
    water = 3,
    iron = 23,
    bread = 4,
    worms = 14,
}
--Notify--
BL_Config.NotifyDuration = 5000
function ClientNotify(type, title, msg, time)
    TriggerEvent('bl_notify', type, title, msg, time) -- type [error, success]
end

function ServerNotify(source, type, title, msg, time)
    TriggerClientEvent('bl_notify', source, type, title, msg, time) -- type [error, success]
end