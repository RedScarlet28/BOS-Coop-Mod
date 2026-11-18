d-- Function Parachutage
-- 	Paramètres :
-- 		_bActivation : si oui ou non le parachutage est déclenché
-- 		_idP : l'id du perso à parachuter
-- 		_nH : jusqu'à quelle hauteur le personnage doit chuter
-- 		_nV : la vitesse de chute, 20 c'est pas mal
--	Utilisation :
--		Parachutage est à mettre dans l'Update_Level
--		C'est le booléen _bActivation qui va déclencher le parachutage donc il est à mettre à true pour lancer le parachutage
--		Evidemment avant de parachuter les bonhommes faut les mettre à la bonne hauteur en les téléportant
--	Exemple :
--		Parachutage(_bJeSuisRentréDansLeCamp,_idPerso,7,20)
--		Ceci est mis dans l'Update_Level adéquat
function Parachutage(_bActivation,_idP,_nH,_nV)
	if (_bActivation) then
		pos=GetVarValue(_idP,"Position")
		h=pos:GetZ()
		if (h>=_nH) then
			SetVarValue(_idP,"Position",pos+Vector3D(0,0,-1*_nV*GetFrameTime()))
		end
	end
end


