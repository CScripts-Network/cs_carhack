local tablet = false
local tabletDict = "amb@code_human_in_bus_passenger_idles@female@tablet@base"
local tabletAnim = "base"
local tabletProp = `prop_cs_tablet`
local tabletBone = 60309
local tabletOffset = vector3(0.03, 0.002, -0.0)
local tabletRot = vector3(10.0, 160.0, 0.0)

if Config.ESX then
	ESX = nil
	Citizen.CreateThread(function()
    		while ESX == nil do
        		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        		Citizen.Wait(0)
    		end
	end)
elseif Config.QBCORE then
	local QBCore = exports['qb-core']:GetCoreObject()
end

RegisterNUICallback('select', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "close",
    })
ToggleTablet(not tablet)
end)
RegisterNUICallback('hackmode', function(data)
TriggerEvent("d_carhack:hack", data.mode)
SetNuiFocus(false, false)
    SendNUIMessage({
        action = "close",
    })
ToggleTablet(not tablet)
end)

RegisterNetEvent('d_carhack:open')
AddEventHandler('d_carhack:open', function(source)
   	SendNUIMessage({
        	action = "open",
    	})
   	SetNuiFocus(true, true)
ToggleTablet(not tablet)
end)

RegisterNetEvent('d_carhack:hack')
AddEventHandler('d_carhack:hack', function(mode)
local ped = PlayerPedId()
local coords = GetEntityCoords(ped)
local closestveh = GetClosestVehicle(coords, 15.0, 0, 231807)
local src = source

  if mode == 1 then
	TriggerEvent('d_carhack:hack2', closestveh)
  elseif mode == 2 then
	SetVehicleEngineOn(closestveh, true, true, true)
  elseif mode == 3 then
	SetVehicleEngineOn(closestveh, false, true, true)
  elseif mode == 4 then
	SetVehicleDoorsLocked(closestveh, 1)
  end
end)

function ToggleTablet(toggle)
    if toggle and not tablet then
        tablet = true

        Citizen.CreateThread(function()
            RequestAnimDict(tabletDict)

            while not HasAnimDictLoaded(tabletDict) do
                Citizen.Wait(150)
            end

            RequestModel(tabletProp)

            while not HasModelLoaded(tabletProp) do
                Citizen.Wait(150)
            end

            local playerPed = PlayerPedId()
            local tabletObj = CreateObject(tabletProp, 0.0, 0.0, 0.0, true, true, false)
            local tabletBoneIndex = GetPedBoneIndex(playerPed, tabletBone)

            SetCurrentPedWeapon(playerPed, `weapon_unarmed`, true)
            AttachEntityToEntity(tabletObj, playerPed, tabletBoneIndex, tabletOffset.x, tabletOffset.y, tabletOffset.z, tabletRot.x, tabletRot.y, tabletRot.z, true, false, false, false, 2, true)
            SetModelAsNoLongerNeeded(tabletProp)

            while tablet do
                Citizen.Wait(100)
                playerPed = PlayerPedId()

                if not IsEntityPlayingAnim(playerPed, tabletDict, tabletAnim, 3) then
                    TaskPlayAnim(playerPed, tabletDict, tabletAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
                end
            end

            ClearPedSecondaryTask(playerPed)

            Citizen.Wait(450)

            DetachEntity(tabletObj, true, false)
            DeleteEntity(tabletObj)
        end)
    elseif not toggle and tablet then
        tablet = false
    end
end