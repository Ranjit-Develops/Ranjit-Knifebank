local QBCore = exports['qb-core']:GetCoreObject()
local traderBuyGoods, traderSellGoods = {}, {}
local buyItems = false
local models = Config.Models
-- Functions


-- Threads
CreateThread(function()
    QBCore.Functions.TriggerCallback('Ranjit-KnifeBank:server:getConfig', function(Config)
        for k, v in pairs(Config.Traders) do
            exports['qb-target']:AddTargetModel(models, {
                options = {
                    {
                        type = 'client',
                        action = function(entity)
                            traderBuyGoods, traderSellGoods = {}, {}
                            buyItems = false
                            local traderBuy = v.items.buy

                            if v.buyItems == true then
                                buyItems = true
                                for i = 1, #traderBuy do
                                    traderBuyGoods[#traderBuyGoods + 1] = traderBuy[i]
                                end
                            end



                            TriggerEvent('Ranjit-KnifeBank:client:OpenMenu')
                        end,
                        icon = 'fas fa-sign-in-alt',
                        label = Lang:t('info.title'),
                    },
                },
                distance = 2.0
            })
        end
    end)
end)

-- Events
RegisterNetEvent('Ranjit-KnifeBank:client:OpenMenu', function()
    local openShop = {
        {
            header = Lang:t('info.title'),
            isMenuHeader = true,
        }
    }

    if buyItems then
        openShop[#openShop + 1] = {
            header = Lang:t('info.Deposit'),
            txt = Lang:t('info.Deposit_to'),
            params = {
                event = 'Ranjit-KnifeBank:client:OpenSellMenu',
                args = {
                    items = traderBuyGoods,
                }
            }
        }
    end

    openShop[#openShop + 1] = {
        header = Lang:t('info.close'),
        params = {
            event = exports['qb-menu']:closeMenu()
        }
    }

    exports['qb-menu']:openMenu(openShop)
end)

RegisterNetEvent('Ranjit-KnifeBank:client:OpenSellMenu', function(data)
    QBCore.Functions.TriggerCallback('Ranjit-KnifeBank:server:getInv', function(inventory)
        local sellMenu = {
            {
                header = Lang:t('info.Deposit'),
                isMenuHeader = true,
            }
        }

        for k, v in pairs(inventory) do
            for i = 1, #data.items do
                if v.name == data.items[i].item then
                    sellMenu[#sellMenu + 1] = {
                        header = QBCore.Shared.Items[v.name].label,
                        params = {
                            event = 'Ranjit-KnifeBank:client:SellItems',
                            args = {
                                label = QBCore.Shared.Items[v.name].label,
                                price = data.items[i].price,
                                name = v.name,
                                amount = v.amount
                            }
                        }
                    }
                end
            end
        end

        sellMenu[#sellMenu + 1] = {
            header = Lang:t('info.back'),
            params = {
                event = 'Ranjit-KnifeBank:client:OpenMenu'
            }
        }

        exports['qb-menu']:openMenu(sellMenu)
    end)
end)

RegisterNetEvent('Ranjit-KnifeBank:client:SellItems', function(item)
    local sellingItem = exports['qb-input']:ShowInput({
        header = Lang:t('info.title'),
        submitText = Lang:t('info.Deposit'),
        inputs = {
            {
                type = 'number',
                isRequired = false,
                name = 'amount',
                text = Lang:t('info.max', { value = item.amount })
            }
        }
    })

    if sellingItem then
        if not sellingItem.amount then
            return
        end

        if tonumber(sellingItem.amount) > 0 then
            TriggerServerEvent('Ranjit-KnifeBank:server:SellItems', item.name, sellingItem.amount, item.price)
        else
            QBCore.Functions.Notify(Lang:t('error.negative'), 'error')
        end
    end
end)

RegisterNetEvent('Ranjit-KnifeBank:client:OpenShop', function()
    local ShopItems = {}

    ShopItems.label = Lang:t('info.title')
    ShopItems.items = traderSellGoods
    ShopItems.slots = #traderSellGoods

    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'Trader', ShopItems)
end)
