--[[

**	Scenarion de HTP2

	Le joueur doit voler un exo pour détruire le tank qui barre le chemin.


** Déroulement

	Le joueur combat dans le tunnel. Ensuite ses alliés se rendent dans la maison.
	Après divers combats, un exo s'anime et attaque le joueur et ses alliés.
	Le joueur doit alors se cacher dans les tranchées et passer par l'héliport pour plus de sureté.
	Le joueur rejoint le hangar et vole l'exo, et revient où il se trouvait précédemment en détruisant un tank.
	Le joueur détruit le tank qui bloque le passage.

	
** Script

	* Le tunnel
	Le combat fait rage dans le tunnel. Si le joueur y reste, des spawns arrivent régulièrement.
	Si le joueur dépasse une limite, les spawns s'arrètent et les alliés rejoignent la maison.
	
	* Le champ de bataille
	Une fois dans la maison, plusieurs spawns arrivent de toute part pour attaquer le joueur et ses alliés.
	Après plusieurs spawns, l'exo attaque.
	Si le joueur s'approche trop près de l'exo avant, il se met en marche.

	* L'heliport
	Plusieurs spawns acceuillent le joueur.

	* Hangar
	En arrivant dans la zone du hangar, les bots du champ de bataille sont freezés.
	Lorsque le joueur sort du Hangar avec l'exo, l'alarme se déclenche.
	Des troupes sont parachutées à l'héliport.


** Fichiers

	* Corridor : le combat dans le premier tunnel.
	* Hide : pour gérer le champ de bataille.
	* Hangar : vol de l'exo et envoie des troupes.
	* Heliport : pour gérer l'héliport.
	* Help : fichier explicatif.



** Ce qu'il reste à faire

	* Générer l'IA avec les exos
	* Placer tanks et exo en plus
	* Créer les comportements des exos et des tanks



--]]