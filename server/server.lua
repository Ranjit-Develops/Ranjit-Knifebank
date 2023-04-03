local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('Ranjit-KnifeBank:server:getConfig', function(source, cb)
    cb(Config)
end)

QBCore.Functions.CreateCallback('Ranjit-KnifeBank:server:getInv', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items

    cb(inventory)
end)

RegisterNetEvent('Ranjit-KnifeBank:server:SellItems', function(itemName, itemAmount, itemPrice)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalPrice = (tonumber(itemAmount) * itemPrice)

    if Player.Functions.RemoveItem(itemName, tonumber(itemAmount)) then
        Player.Functions.AddMoney('cash', totalPrice)
        TriggerClientEvent('QBCore:Notify', src,
        Lang:t('success.sold',
        { value = tonumber(itemAmount), value2 = QBCore.Shared.Items[itemName].label, value3 = totalPrice }), 'success')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_items'), 'error')
    end
end)
