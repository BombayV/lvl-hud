local START_BY_DEFAULT = true

local PlayerPedId = PlayerPedId
local GetPedArmour = GetPedArmour
local GetEntityHealth = GetEntityHealth
local GetEntityMaxHealth = GetEntityMaxHealth
local CreateThread = CreateThread

local screenRes = {x, y}

-- Returns data about the minimap anchor
local function getMinimapAnchor()
	local safezone = GetSafeZoneSize()
	local safezone_x = 1.0 / 20.0
	local safezone_y = 1.0 / 20.0
	local aspect_ratio = GetAspectRatio(0)
	local res_x, res_y = GetActiveScreenResolution()
	local xscale = 1.0 / res_x
	local yscale = 1.0 / res_y
	local Minimap = {}
	Minimap.width = xscale * (res_x / (4 * aspect_ratio))
	Minimap.height = yscale * (res_y / 5.674)
	Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
	Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
	Minimap.right_x = Minimap.left_x + Minimap.width
	Minimap.top_y = Minimap.bottom_y - Minimap.height
	Minimap.x = Minimap.left_x
	Minimap.y = Minimap.top_y
	Minimap.xunit = xscale
	Minimap.yunit = yscale
	return Minimap
end

local function startHud()
	SendNUIMessage({
		action = 'updateDefaults',
		topInfo = GetPlayerName(PlayerId()) .. ' | ' .. GetPlayerServerId(PlayerId()),
	})

	-- Checks for resolution changes
	CreateThread(function()
		while true do
			local resX, resY = GetActiveScreenResolution()
			if screenRes.x == nil or screenRes.x ~= resX or screenRes.y == nil or screenRes.y ~= resY then
				SendNUIMessage({
					action = "updateResolution",
					position = getMinimapAnchor()
				})
			end
			TriggerServerEvent("lvl:getInfo")
			Wait(5000)
		end
	end)

	-- Updates the health and armour of the player
	CreateThread(function()
		while true do
			local ped = PlayerPedId()
			local shield = GetPedArmour(ped)
			local health = (GetEntityHealth(ped) - 100) * 100 / (GetEntityMaxHealth(ped) - 100)
			SendNUIMessage({
				action = "updateHud",
				health = health,
				shield = shield
			})
			Wait(350)
		end
	end)
end

-- Returns the money on the player's account
RegisterNetEvent('lvl:getInfo', function(info)
	SendNUIMessage({
		action = "status",
		cash = info.money,
		bank = info.bankMoney
	})
end)

if START_BY_DEFAULT then
	startHud()
else
	exports('startHud', startHud)
end