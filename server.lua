local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')

RegisterNetEvent('lvl:getInfo', function()
	local source <const> = {source}
	local playerID = vRP.getUserId(source)
	local player = vRP.getUserSource({playerID})

	local info = {
		money = vRP.getMoney({playerID}),
		bankMoney = vRP.getBankMoney({playerID})
	}
	TriggerClientEvent('lvl:getInfo', playerID, info)
end)
