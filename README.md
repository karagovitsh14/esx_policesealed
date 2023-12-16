# esx_policesealed
C'est un script qui permet aux personnes avec le job de police de vendre les scellés récupérés aux autres joueurs.

Pour changer le point de vente des scellés :
- Client.lua/ Ligne 18 // Pour le point en lui-même
- Client.lua/ Ligne 22 // Pour le marqueur du point

Pour ajouter des items :

- Client.lua / Ligne 45 //// Server.lua / Ligne 10

Exemple

{ name = 'opiumpoch', label = 'Pochon d\'opium', price = 1000, quantity = 1 }, ---- Pour vendre 1 seul pochon d'opium
{ name = 'opium', label = 'Opium Brut', price = 1000, quantity = 1 }, ---- Pour vendre 1 seul opium non traité
{ name = 'opiumpoch', label = 'Pochon d\'opium (5x)', price = 5000, quantity = 5 }, ---- Pour vendre 5 pochons d'opium directement
{ name = 'opium', label = 'Opium Brut (5x)', price = 5000, quantity = 5 }, ---- Pour vendre 5 opiums non traités directement

--{ name = 'name', label = 'label (5x)', price = 5000, quantity = 5 }, ---- Le "name" est le nom de l'objet dans votre base de données //// Le "label" est le nom qui va être affiché dans le menu en jeu
--{ name = 'name', label = 'label', price = 1000, quantity = 1 }, ---- Le prix est à changer selon vos envies et votre économie sur votre serveur
