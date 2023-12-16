-- Variable pour suivre l'état de la notification
local notificationDisplayed = false

-- Fonction pour afficher une notification
function ShowNotification(text, type)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(type, false)
end

-- Gérer l'interaction avec la zone de vente
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(playerPed)

        local distance = #(playerCoords - vector3(-548.65832519531, -104.90518951416, 33.864585876465))

        if distance < 3.0 then
            -- Afficher le marqueur
            DrawMarker(1, -548.65832519531, -104.90518951416, 32.864585876465, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 1.0, 255, 0, 0, 200, false, true, 2, false, nil, nil, false)

            -- Afficher la notification uniquement si elle n'est pas déjà affichée
            if not notificationDisplayed then
                ShowNotification("Appuyez sur ~b~E ~w~pour vendre des scellées à la police.", 1)
                notificationDisplayed = true
            end

            if IsControlJustReleased(0, 38) then -- Touche E
                OpenVenteMenu()
            end
        else
            -- Si le joueur n'est pas dans la zone de vente, réinitialise la notification et le marqueur
            ESX.UI.Menu.CloseAll()  -- Ferme le menu si ouvert
            notificationDisplayed = false
        end
    end
end)

-- Fonction pour ouvrir le menu de vente
function OpenVenteMenu()
    local elements = {}

    for _, item in pairs({
        { name = 'water', label = 'Eau', price = 1000, quantity = 1 },
        { name = 'water', label = 'Eau (5x)', price = 5000, quantity = 5 },
        -- Ajoute d'autres articles ici
    }) do
        table.insert(elements, {
            label = item.label .. " - $" .. item.price,
            value = item.name,
            quantity = item.quantity  -- Ajoute la quantité à l'élément
        })
    end

    -- Ajoute une vérification du job avant d'ouvrir le menu
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'vente_menu',
            {
                title = 'Menu de vente',
                align = 'top-left',
                elements = elements
            },
            function(data, menu)
                TriggerServerEvent('vendreItem', data.current.value, data.current.quantity)  -- Passe la quantité à la fonction serveur
                menu.close()
                notificationDisplayed = false  -- Réinitialise la variable après la fermeture du menu
            end,
            function(data, menu)
                menu.close()
                notificationDisplayed = false  -- Réinitialise la variable après la fermeture du menu
            end
        )
    else
        -- Informe le joueur qu'il doit être policier pour vendre des articles dans cette zone
        TriggerEvent('esx:showNotification', 'Vous devez être policier pour vendre des scellées dans cette zone.', 'error')
    end
end