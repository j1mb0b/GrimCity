ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local ServerConfig = {
    webhooks = "Lien de votre webhook",
    webhooksTitle = "Nom Serveur RP",
    webhooksColor = 2061822,
}

ServerToDiscord = function(name, message, color)
	date_local1 = os.date('%H:%M:%S', os.time())
	local date_local = date_local1
	local DiscordWebHook = ServerConfig.webhooks

    local embeds = {
	    {
		    ["title"]= message,
		    ["type"]="rich",
		    ["color"] =color,
		    ["footer"]=  {
			    ["text"]= "Heure : " ..date_local.. "",
		    },
	    }
    }

	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end 

AddEventHandler('chatMessage', function(source, name, message)
	CancelEvent()
  end)

RegisterCommand('twt', function(source, args, rawCommand)
    local src = source
	local msg = rawCommand:sub(5)
	local args = msg
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        ServerToDiscord(ServerConfig.webhooksTitle, ':diamond_shape_with_a_dot_inside: [Twitter] __'  ..GetPlayerName(source).. '__ vient d\'envoyer `'..msg..'` ', ServerConfig.webhooksColor)
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Twitter', ''..name..'', ''..msg..'', 'CHAR_STRETCH', 0)
        end
    end
end, false)

RegisterCommand('lspd', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "police" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
            ServerToDiscord(ServerConfig.webhooksTitle, ':man_police_officer: [LSPD] __'  ..GetPlayerName(source).. '__ vient d\'envoyer `'..msg..'` ', ServerConfig.webhooksColor)
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'LSPD', '~b~Annonce LSPD', ''..msg..'', 'CHAR_ABIGAIL', 0)

        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertissement', '~b~Tu n\'pas' , '~b~policier pour faire cette commande', 'CHAR_ABIGAIL', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertissement', '~b~Tu n\'es pas' , '~b~policier pour faire cette commande', 'CHAR_ABIGAIL', 0)
    end
 end, false)
 
RegisterCommand('mecano', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "mechanic" then
        local src = source
        local msg = rawCommand:sub(9)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
            ServerToDiscord(ServerConfig.webhooksTitle, ':mechanic: [Mécano] __'  ..GetPlayerName(source).. '__ vient d\'envoyer `'..msg..'` ', ServerConfig.webhooksColor)
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'mecano', '~b~Annonce mecano', ''..msg..'', 'CHAR_LS_CUSTOMS', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertissement', '~b~Tu n\'pas' , '~b~mecano pour faire cette commande', 'CHAR_LS_CUSTOMS', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertissement', '~b~Tu n\'es pas' , '~b~mecano pour faire cette commande', 'CHAR_LS_CUSTOMS', 0)
    end
 end, false)
 
 RegisterCommand('concess', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "cardealer" then
        local src = source
        local msg = rawCommand:sub(8)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
            ServerToDiscord(ServerConfig.webhooksTitle, ':red_car: [Concessionnaire] __'  ..GetPlayerName(source).. '__ vient d\'envoyer `'..msg..'` ', ServerConfig.webhooksColor)
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'concessionnaire', '~b~Annonce concessionnaire', ''..msg..'', 'CHAR_CARSITE', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertissement', '~b~Tu n\'pas' , '~b~concessionnaire pour faire cette commande', 'CHAR_CARSITE', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertissement', '~b~Tu n\'es pas' , '~b~concessionnaire pour faire cette commande', 'CHAR_CARSITE', 0)
    end
 end, false)
 
RegisterCommand('unicorn', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "unicorn" then
        local src = source
        local msg = rawCommand:sub(8)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
            ServerToDiscord(ServerConfig.webhooksTitle, ':high_heel: [Unicorn] __'  ..GetPlayerName(source).. '__ vient d\'envoyer `'..msg..'` ', ServerConfig.webhooksColor)
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Unicorn', '~b~Annonce Unicorn', ''..msg..'', 'CHAR_TANISHA', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertissement', '~b~Tu n\'pas' , '~b~unicorn pour faire cette commande', 'CHAR_TANISHA', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertissement', '~b~Tu n\'es pas' , '~b~unicorn pour faire cette commande', 'CHAR_TANISHA', 0)
    end
 end, false)
 

 
RegisterCommand('vigne', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "vigne" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
            ServerToDiscord(ServerConfig.webhooksTitle, ':grapes: [Vigneron] __'  ..GetPlayerName(source).. '__ vient d\'envoyer `'..msg..'` ', ServerConfig.webhooksColor)
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vignerons', '~b~Annonce Vignerons', ''..msg..'', 'CHAR_CHEF', 0)

        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertissement', '~b~Tu n\'pas' , '~b~vignerons pour faire cette commande', 'CHAR_CHEF', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertissement', '~b~Tu n\'es pas' , '~b~vignerons pour faire cette commande', 'CHAR_CHEF', 0)
    end
 end, false)
 
    RegisterCommand('ems', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "ambulance" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
            ServerToDiscord(ServerConfig.webhooksTitle, ':ambulance: [EMS] __'  ..GetPlayerName(source).. '__ vient d\'envoyer `'..msg..'` ', ServerConfig.webhooksColor)
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'EMS', '~b~Annonce EMS', ''..msg..'', 'CHAR_WENDY', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertissement', '~b~Tu n\'pas' , '~b~EMS pour faire cette commande', 'CHAR_WENDY', 0)
    end
    else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertissement', '~b~Tu n\'es pas' , '~b~EMS pour faire cette commande', 'CHAR_WENDY', 0)
    end
 end, false)

 RegisterCommand('ano', function(source, args, rawCommand)
    local source = source
	local msg = rawCommand:sub(5)
	local args = msg
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        ServerToDiscord(ServerConfig.webhooksTitle, ':ninja: [Message Anonyme] __'  ..GetPlayerName(source).. '__ vient d\'envoyer `'..msg..'` ', ServerConfig.webhooksColor)
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Twitter', 'Anonyme', ''..msg..'', 'CHAR_STRETCH', 0)
            end
        end
end, false)
