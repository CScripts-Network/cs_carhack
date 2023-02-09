if Config.ESX then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.QBCORE then
	local QBCore = exports['qb-core']:GetCoreObject()
end

if Config.ESX then
	ESX.RegisterUsableItem('hackboy', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
	    	TriggerClientEvent("d_carhack:open", source)
		xPlayer.showNotification("~b~Turning On ~b~H~r~a~w~c~p~k~y~B~b~o~r~y!")
	end)
elseif Config.QBCORE then
	QBCore.Functions.CreateUseableItem("hackboy", function(source, item)
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)
		if Player.Functions.GetItemByName(item.name) ~= nil then
			TriggerClientEvent("d_carhack:open")
			TriggerClientEvent('QBCore:Notify', src, "~b~Turning On ~b~H~r~a~w~c~p~k~y~B~b~o~r~y!")
		end
	end)
elseif Config.Standalone then
	RegisterCommand('carhack', function()
	    	TriggerClientEvent("d_carhack:open")
	end)
end