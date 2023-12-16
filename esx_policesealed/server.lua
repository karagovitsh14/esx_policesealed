-- Fonction pour ouvrir le menu de vente
RegisterServerEvent('vendreItem')
AddEventHandler('vendreItem', function(itemName, quantity)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifie si le joueur a le job Police
    if xPlayer.job.name == 'police' then
        -- Vérifie si l'article peut être vendu
        for _, item in pairs({
            { name = 'water', label = 'Eau', price = 1000 },
            { name = 'water', label = 'Eau (5x)', price = 5000 },
            -- Ajoute d'autres articles ici
        }) do
            if item.name == itemName then
                -- Vérifie si le joueur possède l'article dans son inventaire en quantité suffisante
                if xPlayer.getInventoryItem(item.name).count >= quantity then
                    -- Retire l'article de l'inventaire du joueur en fonction de la quantité
                    xPlayer.removeInventoryItem(item.name, quantity)

                    -- Donne de l'argent au joueur en échange de la vente
                    xPlayer.addMoney(item.price * quantity)

                    -- Informe le joueur de la vente réussie
                    TriggerClientEvent('esx:showNotification', _source, 'Vous avez vendu ' .. quantity .. ' ' .. item.label .. ' pour $' .. item.price * quantity)
                else
                    -- Informe le joueur qu'il n'a pas assez de cet article dans son inventaire
                    TriggerClientEvent('esx:showNotification', _source, 'Vous ne possédez pas assez de ' .. item.label .. ' dans votre inventaire.', 'error')
                end
                break
            end
        end
    else
        -- Informe le joueur qu'il doit être policier pour vendre des articles dans cette zone
        TriggerClientEvent('esx:showNotification', _source, 'Vous devez être policier pour vendre des articles dans cette zone.', 'error')
    end
end)