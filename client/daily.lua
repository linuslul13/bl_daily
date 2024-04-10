ESX = exports["es_extended"]:getSharedObject()


local uiInitialized = false
local userData = {
    lastClaimed = 0,
    canClaim = false,
}

function TimeToDate(time)
	local day = math.floor(time / 86400)
	local hour = math.floor(time / 60 / 60) % 24
	local minute = math.floor(time / 60) % 60
	local second = time % 60

	return day, hour, minute, second
end

function DateToTime(day, hour, minute, second)
	return day * 86400 + hour * 3600 + minute * 60 + second
end

local timeToClaim = DateToTime(BL_Config.TimetoClaim.day, BL_Config.TimetoClaim.hour, BL_Config.TimetoClaim.minute, BL_Config.TimetoClaim.second) 

local function loadData(data)
    for k, v in pairs(data) do
        userData[k] = v
    end
end

local function saveData()
    SetResourceKvp('bl:daily', json.encode(userData))
end

local function initializeUi()
    local data = GetResourceKvpString('bl:daily')
    if data then loadData(json.decode(data)) end
    Citizen.Wait(500)
    
    uiInitialized = true
    ClientNotify('success', BL_Config.ServerName..' | DAILY', BL_Config.language.notify.loading_daily_bonus, BL_Config.NotifyDuration)
end

Citizen.CreateThread(function()
    while true do
        if ESX.IsPlayerLoaded() then
            initializeUi()
            break
        end
        Citizen.Wait(200)
    end
end)

local isDead = false
AddEventHandler('esx:onPlayerDeath', function() isDead = true end)
AddEventHandler('esx:onPlayerSpawn', function(spawn) isDead = false end)

local DailyMain = RageUI.CreateMenu('', BL_Config.language.menu.menu_head)
DailyMain.X = 0
DailyMain.Y = 75


Citizen.CreateThread(function()
    function RageUI.PoolMenus:Daily()
        DailyMain:IsVisible(function(Items)
            Items:AddSeparator(BL_Config.language.menu.menu_1)
            Items:AddSeparator(BL_Config.language.menu.menu_2)
            Items:AddButton(BL_Config.language.menu.menu_button, BL_Config.language.menu.menu_button_description, { isDisabled = false}, function(onSelected)
                if onSelected then
                    local year, month, day, hour, minute, second = GetLocalTime()
                    local currentTime = DateToTime(day, hour, minute, second)
                    local lastClaimed = userData.lastClaimed
                    
                    local timeDifference = lastClaimed - currentTime + timeToClaim
                    local day, hour, minute, second = TimeToDate(timeDifference)
                    if userData.canClaim then
            
                        if timeDifference <= 0 then
                            local year, month, day, hour, minute, second = GetLocalTime()
                            userData.lastClaimed = DateToTime(day, hour, minute, second)
                            userData.canClaim = false
                            local source = PlayerPedId()
                            TriggerServerEvent('bl_base:daily-item')
                            saveData()
                        end
                    else                
                        if hour < 10 then hour = '0' .. hour end
                        if minute < 10 then minute = '0' .. minute end
                        if second < 10 then second = '0' .. second end
        
                        --ClientNotify('error', BL_Config.ServerName..' | DAILY', BL_Config.language.notify.time_remaining, BL_Config.NotifyDuration)
                        ClientNotify('error', BL_Config.ServerName..' | DAILY', 'Du musst noch '..hour..' Stunden '..minute .. ' Minuten und '..second..' Sekunden warten!', 5000)
                    end
                end
            end, DailyMain)
        end, function(Panels)
        end)
    end
end)

Keys.Register(BL_Config.Key, BL_Config.Key, BL_Config.language.menu.menu_head, function()
    if not isDead then 
        RageUI.UpdateHeader(BL_Config.Banner, 611, 344)
        RageUI.Visible(DailyMain, true)
    end
end)


RegisterCommand(BL_Config.GETKVP, function()
    if ESX.GetPlayerData().group == BL_Config.AdminGroup then 
        print(GetResourceKvpString('bl:daily'))
    else
        ClientNotify('error', BL_Config.ServerName..' | Admin', BL_Config.language.notify.no_permission, BL_Config.NotifyDuration)
    end
end)

RegisterCommand(BL_Config.ResetMyTimer, function()
    if ESX.GetPlayerData().group == BL_Config.AdminGroup then 
        userData.canClaim = true
        userData.lastClaimed = 0
        SetResourceKvp('bl:daily', json.encode(userData))
        print(GetResourceKvpString('bl:daily'))
        ClientNotify('success', BL_Config.ServerName..' | DAILY', BL_Config.language.notify.reset_timer, BL_Config.NotifyDuration)
    else
        ClientNotify('error', BL_Config.ServerName..' | Admin', BL_Config.language.notify.no_permission, BL_Config.NotifyDuration)
    end
end)

RegisterNetEvent('bl_base:resetdaily', function(src)
    userData.canClaim = true
    userData.lastClaimed = 0
    SetResourceKvp('bl:daily', json.encode(userData))
    print(GetResourceKvpString('bl:daily'))
    ClientNotify('success', BL_Config.ServerName..' | DAILY', BL_Config.language.notify.reset_all_timer, BL_Config.NotifyDuration)
end)