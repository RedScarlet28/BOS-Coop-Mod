------------------------------------------------------------
------------------------------------------------------------

-- ::: Update level ::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function UpdateCourt()

	OpenDoor_HeliCourt()

	JoueurApprocheFin()

--	OpenDoor_CourtMonastery()

	Fin()

end




------------------------------------------------------------
------------------------------------------------------------

-- ::: Le Player franchit la porte :::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Qd le joueur entre ds la Cour --]]

function OpenDoor_HeliCourt()

	_bOpenDoor_HeliCourt = IsDoorOpened(GetDoorID("Door_Heli-Court"))

	if ((_bOpenDoor_HeliCourt == true) and (_bCtrlOpenDoor_HeliCourt == false)) then


						StartMusic("Sounds//Music//BoS - Resistance theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
	
				 -- 	PauseMusic()
				 --		StopMusic()
				 --		StartMusic()

		-- Défrise la 1ère vague d'ennemis
		FreezeAll(GetGroupID("Grp_Syndic_Court_01"),false)
		FreezeAll(GetGroupID("Grp_Syndic_Court_02"),false)

		-- Modifie l'Order List d'Huber pour lui mettre un Follow sur le Player et lance le dialogue qui avertit le Player
		SetVarValue(_idMerc[0], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Merc"))
		DialogueHuberFollow()

		-- :::: OBJECTIF ::::
		NewSubObjective("Obj_C_1_FOLLOW_HUBER","Obj_C_2_ELIMINER_PARAS_ET_TROOPERS")

		-- Disable la fonction
		_bCtrlOpenDoor_HeliCourt = true

	end
end

------------------------------------------------------------

function OnEnter_Sector_Event_Court_7(id)
	if (id == _idPlayer) then
		_bWaypointSyndicCourt1 = true
	end
end

------------------------------------------------------------

function OnEnter_Sector_Event_Court_8(id)
	if (id == _idPlayer) then
		_bWaypointSyndicCourt1 = true
	end
end

------------------------------------------------------------

--[[ Kill les Waypoints des Syndic --]]

function WaypointSyndicCourt1()
	if (_bWaypointSyndicCourt1 == true) then
		return true
	else
		return false
	end
end

------------------------------------------------------------

function OnEnter_Sector_Event_Court_9(id)
	if (id == _idPlayer) then
		_bWaypointSyndicCourt2 = true
	end
end

------------------------------------------------------------

--[[ Kill les Waypoints des Syndic --]]

function WaypointSyndicCourt2()
	if (_bWaypointSyndicCourt2 == true) then
		return true
	else
		return false
	end
end

------------------------------------------------------------

function OnEnter_Sector_Event_Court_10(id)
	if (id == _idPlayer) then
		_bPlayerPasseSector_Event_Court_10 = true
	end
end

------------------------------------------------------------

--[[ Qd le joueur entre ds la Cour --]]

function JoueurApprocheFin()

		-- Teste le nb de vivants parmi les Paras Héliport 3 (attaque par derrière)
	_nGrp_Syndic_Court_Vrai_01 = AliveMembersCount(GetGroupID("Grp_Syndic_Court_01"))

		-- Teste le nb de vivants parmi les Paras Héliport 3 (attaque par derrière)
	_nGrp_Syndic_Court_Vrai_02 = AliveMembersCount(GetGroupID("Grp_Syndic_Court_02"))

	_nTotal_Grp_Syndic_Court_Vrai = _nGrp_Syndic_Court_Vrai_01 + _nGrp_Syndic_Court_Vrai_02

	-- S'ils sont tous morts et que la boucle n'a jamais été jouée
	if ((_nTotal_Grp_Syndic_Court_Vrai <= 0) and (_bPlayerPasseSector_Event_Court_10 == true) and (_bCtrlJoueurApprocheFin == false)) then

		-- Défrise la 2ème vague d'ennemis
		FreezeAll(GetGroupID("Grp_Syndic_Court_03"),false)

		-- Lance le dialogue d'Huber qui signale l'arrivée des paras
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_26",true,100,2,2,"",28)

			-- StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
	
				 -- 	PauseMusic()
				 		StopMusic()
				 --		StartMusic()

		_bCtrlJoueurApprocheFin = true
	end
end

------------------------------------------------------------

--[[ Qd les derniers ennemis st morts --]]

function Fin()

	-- Teste le nb de vivants parmi les Paras Héliport 3 (attaque par derrière)
	_nGrp_Syndic_Court_Vrai_03 = AliveMembersCount(GetGroupID("Grp_Syndic_Court_03"))

	-- S'ils sont tous morts et que la boucle n'a jamais été jouée
	if ((_nGrp_Syndic_Court_Vrai_03 <= 0) and (_bCtrlGrp_Syndic_Court_Vrai_03 == false)) then

		-- :::: OBJECTIF ::::
		NewSubObjective("Obj_C_2_ELIMINER_PARAS_ET_TROOPERS","Obj_C_3_FOLLOW_HUBER")

		-- Attribue une Order_List à Huber
		SetVarValue(_idMerc[0], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Loading_Huber"))

		-- Lance le dialogue d'Huber qui signale l'arrivée des paras
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_03",true,100,2,2,"",28)

		_bReActiveSector_Event_Court_11 = true

		_bCtrlGrp_Syndic_Court_Vrai_03 = true
	end
end

------------------------------------------------------------

function OnEnter_Sector_Event_Court_11(id)
	if ((id == _idPlayer) and (_bReActiveSector_Event_Court_11 == true)) then
		EndOfLevel()
	end
end



------------------------------------------------------------

function WaypointDoor_CourtMonastery()
	if (_bWaypointDoor_CourtMonastery == true) then
		return true
	else
		return false
	end
end

