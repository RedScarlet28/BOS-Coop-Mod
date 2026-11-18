------------------------------------------------------------
------------------------------------------------------------

-- ::: Update level ::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function 	UpdateHeliport()

	AliveSyndic_Court_01()

	AliveSyndic_Court_02()

--[[ Test Nb Actifs pour Respawn paras Heliport --]]

	NbActifsMax3()

--[[ Active Parachutistes Héliport --]]

	ActiveParasHeliport()

--[[ Test Nb Actifs pour Respawn paras Heliport --]]

	NbActifsMax4()

--[[ Active Parachutistes Héliport --]]

	ActiveParasHeliport2()

--[[ Teste Mort des ennemis --]]

	AliveSyndicHeli()

	--[[ Modification Order Lists Front 1 --]]

	LibererFront1()

	--[[ Modification Order Lists Front 2 --]]

	LibererFront2()

	--[[ Modification Order Lists Front 3 --]]

	LibererFront3()

	--[[ Défrise les soldats de l'étage du batiment --]]

	LibererFront4()

	--[[ Test Nb Actifs pour le 3ème respawn de paras sur l'Héliport --]]

	NbActifsMax6()

	--[[ Active le Defreese du 3ème groupe de parachutistes sur l'Héliport --]]

	ActiveParasHeliport3()

	--[[ Modifie la limit zone des alliés sur l'héliport --]]

	ProgressionHeliAllies()

	--[[ Follow Ingénieur Tortue Héliport --]]

	TestVieTortueHeli()

	UpdateFollowHuber()

end




------------------------------------------------------------
------------------------------------------------------------

-- ::: Arrivée du Player dans la cour ::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Frise les soldats du cloitre --]]

function OnEnter_Sector_Event_Heliport_0(id)

		-- Quand Huber saute dans la cour (et donc entre dans la boite)
		if ((id == _idMerc[0])) then

		SetVarValue(GetTimerID("Timer_Dialogues_Huber"),"TriggerFunction","DialoguesHuber2") 

		-- joue le nouveau dialogue de Huber : "Passons par ici ! Vite !"
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_06",true,100,2,2,"",28)

		-- Déclare que Huber est passé dans la boite et la désactive
		_nHuberHeliPasse = 99
		end

		-- Si le Player entre dans la boite pour la première fois
		if ((id == _idPlayer)) then

			-- Déclare que le Player est passé dans la boite et la désactive
			_nPlayerHeliPasse = 99

			-- Active le dialogue de Huber
			_bCtrlDialogueHuber = true
		end

end


function UpdateFollowHuber()

		if ((_nHuberHeliPasse == _nPlayerHeliPasse) and (_nHuberHeliPasse == 99)) then

			_nHuberHeliPasse = 0

			_nPlayerHeliPasse = 0

			_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_14 = true
		end
end
------------------------------------------------------------

--[[ Active les soldats d'ambiance et vérifie si le Follow Huber se passe bien --]]

function OnEnter_Sector_Event_Heliport_1(id)

	-- Si Huber entre dans la boite pour la première fois
	if ((id == _idMerc[0]) and (_nHuberHeliPasse == 0)) then

		-- Déclare que Huber est passé dans la boite et désactive la boucle
		_nHuberHeliPasse = 1
	end

	-- Si le joueur entre dans la boite pour la première fois	
	if ((id == _idPlayer) and (_nPlayerHeliPasse == 0)) then

		-- Défrise les 3 soldats d'ambiance (ceux qui traversent la cour en courant)
		Freeze(GetCharacterID("Char_Resist_Heliport_00_2"),false)
		Freeze(GetCharacterID("Char_Resist_Heliport_00_1"),false)
		Freeze(GetCharacterID("Char_Resist_Heliport_00_3"),false)

		-- Déclare que le Player est passé dans la boite et désactive la boucle
		_nPlayerHeliPasse = 1
	end

	-- Si Huber est passé mais pas le Player
	if ((_nHuberHeliPasse <=_nPlayerHeliPasse) and (_nHuberHeliPasse == 1)) then

		-- Active la fonction de dialogues en random de Huber qui appelle le Player
		_bOrdreHeliHuber1 = true
	end
end


function DesactivadinOrdreHuberHeli1()
	if (_nPlayerHeliPasse == 1) then
		return true
	else
		return false
	end
end

------------------------------------------------------------

--[[ Dialogues Huber --]]

function DialoguesHuber2()
	if ((_nHuberHeliPasse == 1) and (_nHuberHeliPasse > _nPlayerHeliPasse)) then
		RandomCloitreHuberDialogues()
	elseif ((_nHuberHeliPasse == 2) and (_nHuberHeliPasse > _nPlayerHeliPasse)) then
		RandomCloitreHuberDialogues()
	elseif ((_nHuberHeliPasse == 3) and (_nHuberHeliPasse > _nPlayerHeliPasse)) then
		RandomCloitreHuberDialogues()
	elseif ((_nHuberHeliPasse == 99) and (_nHuberHeliPasse > _nPlayerHeliPasse)) then
		RandomCloitreHuberDialogues()
	end
end 

------------------------------------------------------------
------------------------------------------------------------

-- ::: Montée/Descente vers/depuis l'Héliport ::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Passage dans la boite (Sector_Event_Heliport_3) --]]

function OnEnter_Sector_Event_Heliport_3(id)

	-- :::: Montée :::: --------------------------------------

	-- Si Huber entre dans la boite pour la première fois
	if ((id == _idMerc[0]) and (_nHuberHeliPasse == 1)) then

		-- Déclare que Huber est passé dans la boite et désactive la boucle
		_nHuberHeliPasse = 2

		-- Défrise les soldats de l'Héliport (si pas déjà défrisés par le Player)
		FreezeAll(GetGroupID("Grp_Resist_Heliport_01"), false)
		FreezeAll(GetGroupID("Grp_Syndic_Heliport_01"), false)

		-- Déclare que les ennemis de l'Héliport ont spawné
		_bGrp_Syndic_Heliport_01Unfreeze = true
	end

	-- Si le joueur entre dans la boite pour la première fois	
	if ((id == _idPlayer) and (_nPlayerHeliPasse == 1)) then

		-- Déclare que le Player est passé dans la boite et désactive la boucle
		_nPlayerHeliPasse = 2

		-- Défrise les soldats de l'Héliport (si pas déjà défrisés par Huber)
		FreezeAll(GetGroupID("Grp_Resist_Heliport_01"), false)
		FreezeAll(GetGroupID("Grp_Syndic_Heliport_01"), false)

		-- :::: OBJECTIF ::::
		--NewObjectiveNewSubObjective("Obj_B_REPRENDRE_HELIPORT","Obj_B_1_ELIMINER_PARAS")
		ObjectiveDoneNewObjectiveNewSubObjective("Obj_A_DEFENDRE_CLOITRE","Obj_B_REPRENDRE_HELIPORT","Obj_B_1_ELIMINER_PARAS")
		SetVarValue(GetObjectiveID("Obj_W_HUBER_NOT_DIE1"),"Active",true)
	--	MiniMapTrack(_idMerc[0], 2, false)

		-- Déclare que les ennemis de l'Héliport ont spawné
		_bGrp_Syndic_Heliport_01Unfreeze = true
	end


end

function OnStay_Sector_Event_Heliport_3(id)
	-- :::: Descente :::: ------------------------------------

	-- Si le Player passe dans la boite pour la première fois une fois que la descente est activée et si le Nb d'actifs est <= 15 
	if ((id == _idPlayer) and (_bReActiveSector_Event_Heliport_3 == true)) then

		_bWaypointHuberCourt2 = true

		_bReActiveSector_Event_Court_3 = true
	end
end


------------------------------------------------------------
------------------------------------------------------------

-- ::: Arrivée sur l'héliport ::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

	--[[ Passage dans la boite (Sector_Event_Heliport_2) --]]

function OnEnter_Sector_Event_Heliport_2(id)

	-- Quand Huber entre dans l'event box pour la première fois et qu'il est déjà passé par les 2 event box précédentes (n°1 et 3)
	if ((id == _idMerc[0]) and (_nHuberHeliPasse == 2) and (_bCtrlHuberHeliPasse2 == false)) then
		_nHuberHeliPasse = 3

		-- Lance les instructions d'Huber et le nouvel objectif
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_07",true,100,2,2,"",100)

		-- Déclare que Huber est passé une fois dans la boite et la désactive
		_bCtrlHuberHeliPasse2 = true
	end

	-- Quand le Player entre dans l'event box pour la première fois et qu'il est déjà passé par les 2 event box précédentes (n°1 et 3)
	if ((id == _idPlayer) and (_nPlayerHeliPasse == 2) and (_bPlayerHeliPasse2 == false)) then
		_nPlayerHeliPasse = 3

		-- Modifie l'Order List d'Huber pour lui mettre un Follow sur le Player et lance le dialogue qui avertit le Player
--		SetVarValue(_idMerc[0], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Huber"))
		SetVarValue(_idMerc[0], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Merc"))
		CreationTimer(true, true, false, "DialogueHuberFollow",5)

		-- Déclare que le Player est passé une fois dans la boite et la désactive
		_bPlayerHeliPasse2 = true

	end

	-- Quand chaque soldat d'ambiance (ceux qui traversent la palce en courant) entre dans la boite, son pathway est désactivé
	if (id == GetCharacterID("Char_Resist_Heliport_00_1")) then
		_bKillPathHeli1 = true
		SetVarValue(GetCharacterID("Char_Resist_Heliport_00_1"), "CharacterOrderList", GetAI_Order_ListID("AI_Order_List_LZ_Resist_Front_c"))
	end
	if (id == GetCharacterID("Char_Resist_Heliport_00_2")) then
		_bKillPathHeli2 = true
		SetVarValue(GetCharacterID("Char_Resist_Heliport_00_2"), "CharacterOrderList", GetAI_Order_ListID("AI_Order_List_LZ_Resist_Front_c"))
	end
	if (id == GetCharacterID("Char_Resist_Heliport_00_3")) then
		_bKillPathHeli3 = true
		SetVarValue(GetCharacterID("Char_Resist_Heliport_00_3"), "CharacterOrderList", GetAI_Order_ListID("AI_Order_List_LZ_Resist_Front_c"))
	end
end

------------------------------------------------------------

	--[[ Explosion --]]

function OnEnter_SE_Boom_1(id)
	if ((id == GetCharacterID("Char_Resist_Heliport_00_1")) or (id == GetCharacterID("Char_Resist_Heliport_00_3"))) then
--		CreationTimer(true, true, false, "Explosadin_Heli_1",1)
	end
end

function Explosadin_Heli_1()
	idExplosion = CreateExplosion()
	SetVarValue(idExplosion,"Position",	Vector3D(1252.231445,361.956421,206.001755))
	SetVarValue(idExplosion,"Type","Explosion_Rocket_Bombardement")
	SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Explosion_Heli_1"), "FxState", "Fx Started")
end

function Explosadin_Heli_2()
	idExplosion = CreateRocket()
	SetVarValue(idExplosion,"Position",	Vector3D(1096.065796,1202.180176,349.725952))
	SetVarValue(idExplosion,"Rotation",	Vector3D(1.570797,3.120011,-1.570795))
	SetVarValue(idExplosion,"Type","Projectile_Rocket_Bombardement")
	SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Explosion_Heli_2"), "FxState", "Fx Started")

	CreationTimer(true, true, false, "DialBoom",1)

				StopMusic()
				StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
	
				 -- 	PauseMusic()
				 --		StopMusic()
				 --		StartMusic()
end

function DialBoom()
	MakeCharacterSpeak(GetCharacterID("Char_Resist_Heliport_00_2"),_idPlayer,"DIA_GEN_COOL_TO_STRESS_TEAM_A_VOICE_B_1",true,100,2,2,"",28)
end


------------------------------------------------------------

	--[[ Changement du comportement des soldats du Front 1 --]]

function LibererFront1()

	-- Quand le joueur entre pour la première fois dans la zone 0
	if ((_nPlayerIsInZoneFront == 0) and (_bCtrlLibererFront1 == true)) then

		-- Change l'order list Front 1 (Priorité Waypoints 28/28)
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_1a"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_1a3"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_1b"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_1b3"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_1c"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_1c3"))

		-- Change le Character_AI des bots : passent du Simple_Attack au Smart_Attack (cause : bug IA si priorité legs trop forte avec Smart_Attack)
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_1a"), "CharacterAI", GetCharacter_AIID("Char_AI_Spe_Heli_Front_Smart"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_1b"), "CharacterAI", GetCharacter_AIID("Char_AI_Spe_Heli_Front_Smart"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_1c"), "CharacterAI", GetCharacter_AIID("Char_AI_Spe_Heli_Front_Smart"))

		-- Change l'order list Front 2 (Priorité Waypoints 35/28)
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_2a"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_2a2"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_2b"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_2b2"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_2c"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_2c2"))

		-- Baisse artificiellement le nombre de points de vie des soldats d'ambiance pour qu'ils meurent "sous les yeux" du joueur
--		SetVarValue(GetCharacterID("Char_Resist_Heliport_01_2"), "Health", 10)

		-- Change l'order list des alliés d'ambiance pour en mettre une vide (désactive le Fire at Position en fait)
--		SetVarValue(GetCharacterID("Char_Resist_Heliport_01_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Vide"))

		-- Déclare que la boucle a été exécutée et la désactive
		_bCtrlLibererFront1 = false
	end
end

------------------------------------------------------------

	--[[ Changement du comportement des soldats du Front 2 --]]

function LibererFront2()

	-- Quand le joueur entre pour la première fois dans la zone 1
	if ((_nPlayerIsInZoneFront == 1) and (_bCtrlLibererFront2 == true)) then

		-- Change l'order list (Priorité Waypoints 28/28)
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_2a"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_2a3"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_2b"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_2b3"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_2c"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_2c3"))

		-- Change le Character_AI des bots : passent du Simple_Attack au Smart_Attack (cause : bug IA si priorité legs trop forte avec Smart_Attack)
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_2a"), "CharacterAI", GetCharacter_AIID("Char_AI_Spe_Heli_Front_Smart"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_2b"), "CharacterAI", GetCharacter_AIID("Char_AI_Spe_Heli_Front_Smart"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_2c"), "CharacterAI", GetCharacter_AIID("Char_AI_Spe_Heli_Front_Smart"))

		-- Change l'order list Front 3 (Priorité Waypoints 35/28)
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_3a"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_3a2"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_3b"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_3b2"))
--		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_3c"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_3c2"))

		-- Baisse artificiellement le nombre de points de vie des soldats d'ambiance pour qu'ils meurent "sous les yeux" du joueur
--		SetVarValue(GetCharacterID("Char_Resist_Heliport_01_1"), "Health", 10)

		-- Change l'order list des alliés d'ambiance pour en mettre une vide (désactive le Fire at Position en fait)
--		SetVarValue(GetCharacterID("Char_Resist_Heliport_01_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Vide"))

		-- Explosion qui tue l'allié du balcon
		CreationTimer(true, true, false, "Explosadin_Heli_2",1)

		-- Déclare que la boucle a été exécutée et la désactive
		_bCtrlLibererFront2 = false
	end
end

------------------------------------------------------------

	--[[ Changement du comportement des soldats du Front 3 --]]

function LibererFront3()

	-- Quand le joueur entre pour la première fois dans la zone 2
	if ((_nPlayerIsInZoneFront == 2) and (_bCtrlLibererFront3 == true)) then

		-- Change l'order list (Priorité Waypoints 28/28)
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_3a"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_3a3"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_3b"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_3b3"))
--		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_3c"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_3c3"))

		-- Change le Character_AI des bots : passent du Simple_Attack au Smart_Attack (cause : bug IA si priorité legs trop forte avec Smart_Attack)
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_3a"), "CharacterAI", GetCharacter_AIID("Char_AI_Spe_Heli_Front_Smart"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_3b"), "CharacterAI", GetCharacter_AIID("Char_AI_Spe_Heli_Front_Smart"))
--		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_3c"), "CharacterAI", GetCharacter_AIID("Char_AI_Spe_Heli_Front_Smart"))

		-- Défrise les persos de l'étage
		Freeze(GetCharacterID("Char_Syndic_Heliport_00_1"),false)
		Freeze(GetCharacterID("Char_Syndic_Heliport_00_3"),false)

		-- Déclare que la boucle a été exécutée et la désactive
		_bCtrlLibererFront3 = false
	end
end

------------------------------------------------------------

	--[[ Défrise les soldats de l'étage du batiment --]]

function LibererFront4()

	-- Quand le joueur entre pour la première fois dans la zone 3
	if ((_nPlayerIsInZoneFront == 3) and (_bCtrlLibererFront4 == true)) then

		-- Défrise les persos de l'étage
	--	Freeze(GetCharacterID("Char_Syndic_Heliport_00_1"),false)
	--	Freeze(GetCharacterID("Char_Syndic_Heliport_00_3"),false)

		-- Déclare que la boucle a été exécutée et la désactive
		_bCtrlLibererFront4 = false
	end
end

------------------------------------------------------------

	--[[ Dialogue de Huber qui indique au Player qu'il le suit désormais --]]

function DialogueHuberFollow()
	MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_25",true,100,2,2,"",28)

end

------------------------------------------------------------
---::: encore utilisé ? :::---
	--[[ Désactivation du Follow de Huber sur le Joueur --]]

function KillFollowHuber()
	if (_bKillFollowHuber == true) then
		return true
	else
		return false
	end
end

------------------------------------------------------------

--[[ Fonctions appelées par Huber pour changer les ordres sur l'Héliport --]]

function OrdreHuberHeli1()
	if (_bOrdreHeliHuber1 == true) then
		return true
	else
		return false
	end
end

function OrdreHuberHeli2()
	if (_bOrdreHeliHuber2 == true) then
		return true
	else
		return false
	end
end

function OrdreHuberHeli3()
	if (_bOrdreHeliHuber3 == true) then
		return true
	else
		return false
	end
end

------------------------------------------------------------

--[[ Kill l'ordre des soldats d'ambiance lorsqu'ils arrivent sur l'Héliport --]]

function KillPathHeli1()
	if (_bKillPathHeli1 == true) then
		return true
	else
		return false
	end
end

function KillPathHeli2()
	if (_bKillPathHeli2 == true) then
		return true
	else
		return false
	end
end

function KillPathHeli3()
	if (_bKillPathHeli3 == true) then
		return true
	else
		return false
	end
end

------------------------------------------------------------

--[[ Kill l'ordre des soldats du groupe Grp_Syndic_Heliport_01 --]]

function KillGrp_Syndic_Heliport_01()
	if (_bKillGrp_Syndic_Heliport_01 == true) then
		return true
	else
		return false
	end
end

--[[ Dialogues en random de Huber qui appelle le joueur si celui-ci ne le suit pas --]]

function DialoguesHuber1()
	if ((_nHuberHeliPasse == 1) and (_nHuberHeliPasse > _nPlayerHeliPasse)) then
		RandomHuberDialogues1()
	end
end 






------------------------------------------------------------
------------------------------------------------------------

-- ::: Organisation des Fronts sur l'Héliport ::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

	--[[ Entrée dans le Front 0 --]]

function OnEnter_Sector_Event_Heliport_Front_0(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 0
		_nPlayerIsInZoneFront = 0

		-- Baisse artificiellement le nombre de points de vie des soldats d'ambiance pour qu'ils meurent "sous les yeux" du joueur
--		SetVarValue(GetCharacterID("Char_Resist_Heliport_01_1"), "Health", 10)

	end
end

	--[[ Entrée dans le Front 1 par l'accès A --]]

function OnEnter_Sector_Event_Heliport_Front_1a1(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 1
		_nPlayerIsInZoneFront = 1
	end
end

	--[[ Entrée dans le Front 1 par l'accès B --]]

function OnEnter_Sector_Event_Heliport_Front_1b1(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 1
		_nPlayerIsInZoneFront = 1
	end
end

	--[[ Entrée dans le Front 1 par l'accès C --]]

function OnEnter_Sector_Event_Heliport_Front_1c1(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 1
		_nPlayerIsInZoneFront = 1
	end
end

------------------------------------------------------------

	--[[ Retour dans le Front 0 par l'accès A --]]

function OnEnter_Sector_Event_Heliport_Front_1a2(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 0
		_nPlayerIsInZoneFront = 0
	end
end

	--[[ Retour dans le Front 0 par l'accès B --]]

function OnEnter_Sector_Event_Heliport_Front_1b2(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 0
		_nPlayerIsInZoneFront = 0
	end
end

	--[[ Retour dans le Front 0 par l'accès C --]]

function OnEnter_Sector_Event_Heliport_Front_1c2(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 0
		_nPlayerIsInZoneFront = 0
	end
end

------------------------------------------------------------

	--[[ Entrée dans le Front 2 par l'accès A --]]

function OnEnter_Sector_Event_Heliport_Front_2a1(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 2
		_nPlayerIsInZoneFront = 2
	end
end

	--[[ Entrée dans le Front 2 par l'accès B --]]

function OnEnter_Sector_Event_Heliport_Front_2b1(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 2
		_nPlayerIsInZoneFront = 2
	end
end

	--[[ Entrée dans le Front 2 par l'accès C --]]

function OnEnter_Sector_Event_Heliport_Front_2c1(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 2
		_nPlayerIsInZoneFront = 2
	end
end

------------------------------------------------------------

	--[[ Retour dans le Front 1 par l'accès A --]]

function OnEnter_Sector_Event_Heliport_Front_2a2(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 1
		_nPlayerIsInZoneFront = 1
	end
end

	--[[ Retour dans le Front 1 par l'accès B --]]

function OnEnter_Sector_Event_Heliport_Front_2b2(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 1
		_nPlayerIsInZoneFront = 1
	end
end

	--[[ Retour dans le Front 1 par l'accès C --]]

function OnEnter_Sector_Event_Heliport_Front_2c2(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 1
		_nPlayerIsInZoneFront = 1
	end
end

------------------------------------------------------------

	--[[ Entrée dans le Front 3 par l'accès A --]]

function OnEnter_Sector_Event_Heliport_Front_3a1(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 3
		_nPlayerIsInZoneFront = 3
	end
end

	--[[ Entrée dans le Front 3 par l'accès B --]]

function OnEnter_Sector_Event_Heliport_Front_3b1(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 3
		_nPlayerIsInZoneFront = 3
	end
end

	--[[ Entrée dans le Front 3 par l'accès C --]]

function OnEnter_Sector_Event_Heliport_Front_3c1(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 3
		_nPlayerIsInZoneFront = 3
	end
end

------------------------------------------------------------

	--[[ Retour dans le Front 2 par l'accès A --]]

function OnEnter_Sector_Event_Heliport_Front_3a2(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 2
		_nPlayerIsInZoneFront = 2
	end
end

	--[[ Retour dans le Front 2 par l'accès B --]]

function OnEnter_Sector_Event_Heliport_Front_3b2(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 2
		_nPlayerIsInZoneFront = 2
	end
end

	--[[ Retour dans le Front 2 par l'accès C --]]

function OnEnter_Sector_Event_Heliport_Front_3c2(id)

	-- Quand le Player entre dans l'event box
	if (id == _idPlayer) then

		-- Déclare que le Player est dans la zone de front 2
		_nPlayerIsInZoneFront = 2
	end
end





------------------------------------------------------------
------------------------------------------------------------

-- ::: Progression des alliés sur l'Héliport :::::::::::: --

------------------------------------------------------------
------------------------------------------------------------


	--[[ Modifie la limit zone des alliés sur l'héliport --]]

function ProgressionHeliAllies()
	if (_nPlayerIsInZoneFront == 1) then
		-- Quand le joueur est ds la zone 0 les soldats vont ds la limite zone 0b
		SetVarValue(GetCharacterID("Char_Resist_Heliport_00_1"), "CharacterOrderList", GetAI_Order_ListID("AI_Order_List_LZ_Resist_Front_0a"))
		SetVarValue(GetCharacterID("Char_Resist_Heliport_00_2"), "CharacterOrderList", GetAI_Order_ListID("AI_Order_List_LZ_Resist_Front_0b"))
		SetVarValue(GetCharacterID("Char_Resist_Heliport_00_3"), "CharacterOrderList", GetAI_Order_ListID("AI_Order_List_LZ_Resist_Front_0c"))
	elseif (_nPlayerIsInZoneFront == 2) then
		-- Quand le joueur est ds la zone 0 les soldats vont ds la limite zone 1
		SetVarValue(GetCharacterID("Char_Resist_Heliport_00_1"), "CharacterOrderList", GetAI_Order_ListID("AI_Order_List_LZ_Resist_Front_1a"))
		SetVarValue(GetCharacterID("Char_Resist_Heliport_00_2"), "CharacterOrderList", GetAI_Order_ListID("AI_Order_List_LZ_Resist_Front_1b"))
		SetVarValue(GetCharacterID("Char_Resist_Heliport_00_3"), "CharacterOrderList", GetAI_Order_ListID("AI_Order_List_LZ_Resist_Front_1c"))
	elseif (_nPlayerIsInZoneFront == 3) then
		-- Quand le joueur est ds la zone 0 les soldats vont ds la limite zone 1
		SetVarValue(GetCharacterID("Char_Resist_Heliport_00_1"), "CharacterOrderList", GetAI_Order_ListID("AI_Order_List_LZ_Resist_Front_2a"))
		SetVarValue(GetCharacterID("Char_Resist_Heliport_00_2"), "CharacterOrderList", GetAI_Order_ListID("AI_Order_List_LZ_Resist_Front_2b"))
		SetVarValue(GetCharacterID("Char_Resist_Heliport_00_3"), "CharacterOrderList", GetAI_Order_ListID("AI_Order_List_LZ_Resist_Front_2c"))
	end
end





------------------------------------------------------------
------------------------------------------------------------

-- ::: Paras Héliport 1 ::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Test Nb Actifs pour le 1er respawn de paras sur l'Héliport --]]

function NbActifsMax3()
	if (_nActiveBots <= 5) then
		_bNbActifsMax3 = false
	else 
		_bNbActifsMax3 = true
	end
end

-----------------------------------------------------------

--[[ Active le Defreese du 1er groupe de parachutistes sur l'Héliport --]]

function ActiveParasHeliport()
	_nGrp_Syndic_Heliport_01 = AliveMembersCount(GetGroupID("Grp_Syndic_Heliport_01")) 
	if ((_bGrp_Syndic_Heliport_01Unfreeze == true) and (_nGrp_Syndic_Heliport_01 <= 2) and (_bNbActifsMax3 == false) and (_bCtrlParasHeliport1 == false)) then
		ParasHeliport1()
		_bCtrlParasHeliport1 = true
	end
end

-----------------------------------------------------------

--[[ Télétransportation des Paras sur l'Héliport suivant la position du joueur --]]

function ParasHeliport1()

	-- Défrise le groupe de paras
	FreezeAll(GetGroupID("Grp_Syndic_Heliport_03"), false)
	_bGrp_Syndic_Heliport_03Unfreeze = true

		_idPara_01_1 = GetCharacterID("Char_Syndic_Heliport_03_1")
		_idPara_01_2 = GetCharacterID("Char_Syndic_Heliport_03_2")
		_idPara_01_3 = GetCharacterID("Char_Syndic_Heliport_03_3")

		-- Si le joueur se trouve dans la zone de Front 0
		if ((_nPlayerIsInZoneFront == 0) and (_bCtrlSpawnParasHeliport1 == false)) then

			Teletransportation("Repere_1_1",_idPara_01_1)

			Teletransportation("Repere_3_2",_idPara_01_2)

			Teletransportation("Repere_2_3",_idPara_01_3)

			-- Déclare que le spawn a été effectué et désactive les boucles
			_bCtrlSpawnParasHeliport1 = true

		-- Si le joueur se trouve dans la zone de Front 1
		elseif ((_nPlayerIsInZoneFront == 1) and (_bCtrlSpawnParasHeliport1 == false)) then

			-- Téléporte les paras sur les persos repères
			Teletransportation("Repere_0_1",_idPara_01_1)

			Teletransportation("Repere_3_2",_idPara_01_2)

			Teletransportation("Repere_2_3",_idPara_01_3)

			-- Déclare que le spawn a été effectué et désactive les boucles
			_bCtrlSpawnParasHeliport1 = true

		-- Si le joueur se trouve dans la zone de Front 2
		elseif ((_nPlayerIsInZoneFront == 2) and (_bCtrlSpawnParasHeliport1 == false)) then

			Teletransportation("Repere_0_1",_idPara_01_1)

			Teletransportation("Repere_3_2",_idPara_01_2)

			Teletransportation("Repere_2_3",_idPara_01_3)

			-- Déclare que le spawn a été effectué et désactive les boucles
			_bCtrlSpawnParasHeliport1 = true

		-- Si le joueur se trouve dans la zone de Front 3
		elseif ((_nPlayerIsInZoneFront == 3) and (_bCtrlSpawnParasHeliport1 == false)) then

			-- Téléporte les paras sur les persos repères
			Teletransportation("Repere_0_1",_idPara_01_1)

			Teletransportation("Repere_2_2",_idPara_01_2)

			Teletransportation("Repere_1_3",_idPara_01_3)

			-- Déclare que le spawn a été effectué et désactive les boucles
			_bCtrlSpawnParasHeliport1 = true
		end

		-- Dialogue du colonel Huber qui alerte ses hommes (et donc le joueur)
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_26",true,100,2,2,"",100)

end









------------------------------------------------------------
------------------------------------------------------------

-- ::: Paras Héliport 2 ::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Test Nb Actifs pour le 2ème respawn de paras sur l'Héliport --]]

function NbActifsMax4()
	_bNbActifsGrp_Syndic_Heliport_03 = AliveMembersCount(GetGroupID("Grp_Syndic_Heliport_03"))
	if ((_nActiveBots <= 5) and (_bNbActifsGrp_Syndic_Heliport_03 <= 1)) then
		_bNbActifsMax4 = false
	else 
		_bNbActifsMax4 = true
	end
end

-----------------------------------------------------------

--[[ Active le Defreese du 2ème groupe de parachutistes sur l'Héliport --]]

function ActiveParasHeliport2()
	if ((_bGrp_Syndic_Heliport_03Unfreeze == true) and (_bNbActifsMax4 == false) and (_bCtrlParasHeliport2 == false)) then
		ParasHeliport2()
		_bCtrlParasHeliport2 = true
	end
end

-----------------------------------------------------------

--[[ Télétransportation des Paras sur l'Héliport suivant la position du joueur --]]

function ParasHeliport2()

			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
	
				 -- 	PauseMusic()
				 		StopMusic()
				 --		StartMusic()

	-- Défrise le groupe de paras
	FreezeAll(GetGroupID("Grp_Syndic_Heliport_02"), false)

	_idPara_02_1 = GetCharacterID("Char_Syndic_Heliport_02_1")
	_idPara_02_2 = GetCharacterID("Char_Syndic_Heliport_02_2")
	_idPara_02_3 = GetCharacterID("Char_Syndic_Heliport_02_3")

		-- Si le joueur se trouve dans la zone de Front 0
		if ((_nPlayerIsInZoneFront == 0) and (_bCtrlSpawnParasHeliport2 == false)) then

			-- Téléporte les paras sur les persos repères
			Teletransportation("Repere_1_2",_idPara_02_1)

			Teletransportation("Repere_3_3",_idPara_02_2)

			Teletransportation("Repere_2_1",_idPara_02_3)

			-- Déclare que le spawn a été effectué et désactive les boucles
			_bCtrlSpawnParasHeliport2 = true

		-- Si le joueur se trouve dans la zone de Front 1
		elseif ((_nPlayerIsInZoneFront == 1) and (_bCtrlSpawnParasHeliport2 == false)) then

			-- Téléporte les paras sur les persos repères
			Teletransportation("Repere_0_2",_idPara_02_1)

			Teletransportation("Repere_3_3",_idPara_02_2)

			Teletransportation("Repere_2_1",_idPara_02_3)

			-- Déclare que le spawn a été effectué et désactive les boucles
			_bCtrlSpawnParasHeliport2 = true

		-- Si le joueur se trouve dans la zone de Front 2
		elseif ((_nPlayerIsInZoneFront == 2) and (_bCtrlSpawnParasHeliport2 == false)) then

			-- Téléporte les paras sur les persos repères
			Teletransportation("Repere_0_2",_idPara_02_1)

			Teletransportation("Repere_3_3",_idPara_02_2)

			Teletransportation("Repere_1_1",_idPara_02_3)

			-- Déclare que le spawn a été effectué et désactive les boucles
			_bCtrlSpawnParasHeliport2 = true

		-- Si le joueur se trouve dans la zone de Front 3
		elseif ((_nPlayerIsInZoneFront == 3) and (_bCtrlSpawnParasHeliport2 == false)) then

			-- Téléporte les paras sur les persos repères
			Teletransportation("Repere_0_2",_idPara_02_1)

			Teletransportation("Repere_2_3",_idPara_02_2)

			Teletransportation("Repere_1_1",_idPara_02_3)

			-- Déclare que le spawn a été effectué et désactive les boucles
			_bCtrlSpawnParasHeliport2 = true
		end

	-- Dialogue du colonel Huber qui alerte ses hommes (et donc le joueur)
	MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_27",true,100,2,2,"",100)

	_bGrp_Syndic_Heliport_02Unfreeze = true
end





------------------------------------------------------------
------------------------------------------------------------

-- ::: Paras Héliport 3 ::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Test Nb Actifs pour le 3ème respawn de paras sur l'Héliport --]]

function NbActifsMax6()
	_bNbActifsGrp_Syndic_Heliport_02 = AliveMembersCount(GetGroupID("Grp_Syndic_Heliport_02"))
	if ((_nActiveBots <= 5) and (_bNbActifsGrp_Syndic_Heliport_02 <= 1)) then
		_bNbActifsMax6 = false
	else 
		_bNbActifsMax6 = true
	end
end

-----------------------------------------------------------

--[[ Active le Defreese du 3ème groupe de parachutistes sur l'Héliport --]]

function ActiveParasHeliport3()
	if ((_bGrp_Syndic_Heliport_02Unfreeze == true) and (_bNbActifsMax6 == false) and (_bCtrlParasHeliport3 == false)) then
		ParasHeliport3()
		_bCtrlParasHeliport3 = true
	end
end

-----------------------------------------------------------

--[[ Télétransportation des Paras sur l'Héliport suivant la position du joueur --]]

function ParasHeliport3()

	-- Défrise le groupe de paras
	FreezeAll(GetGroupID("Grp_Syndic_Heliport_05"), false)

	_idPara_03_1 = GetCharacterID("Char_Syndic_Heliport_05_1")
	_idPara_03_2 = GetCharacterID("Char_Syndic_Heliport_05_2")
	_idPara_03_3 = GetCharacterID("Char_Syndic_Heliport_05_3")

		-- Si le joueur se trouve dans la zone de Front 0
		if ((_nPlayerIsInZoneFront == 0) and (_bCtrlSpawnParasHeliport3 == false)) then

			-- Téléporte les paras sur les persos repères
			Teletransportation("Repere_1_3",_idPara_03_1)

			Teletransportation("Repere_3_1",_idPara_03_2)

			Teletransportation("Repere_2_2",_idPara_03_2)

			-- Déclare que le spawn a été effectué et désactive les boucles
			_bCtrlSpawnParasHeliport3 = true

		-- Si le joueur se trouve dans la zone de Front 1
		elseif ((_nPlayerIsInZoneFront == 1) and (_bCtrlSpawnParasHeliport3 == false)) then

			-- Téléporte les paras sur les persos repères
			Teletransportation("Repere_0_3",_idPara_03_1)

			Teletransportation("Repere_3_1",_idPara_03_2)

			Teletransportation("Repere_2_2",_idPara_03_2)

			-- Déclare que le spawn a été effectué et désactive les boucles
			_bCtrlSpawnParasHeliport3 = true

		-- Si le joueur se trouve dans la zone de Front 2
		elseif ((_nPlayerIsInZoneFront == 2) and (_bCtrlSpawnParasHeliport3 == false)) then

			-- Téléporte les paras sur les persos repères
			Teletransportation("Repere_0_3",_idPara_03_1)

			Teletransportation("Repere_3_1",_idPara_03_2)

			Teletransportation("Repere_1_2",_idPara_03_2)

			-- Déclare que le spawn a été effectué et désactive les boucles
			_bCtrlSpawnParasHeliport3 = true

		-- Si le joueur se trouve dans la zone de Front 3
		elseif ((_nPlayerIsInZoneFront == 3) and (_bCtrlSpawnParasHeliport3 == false)) then

			-- Téléporte les paras sur les persos repères
			Teletransportation("Repere_0_3",_idPara_03_1)

			Teletransportation("Repere_2_1",_idPara_03_2)

			Teletransportation("Repere_1_2",_idPara_03_2)

			-- Déclare que le spawn a été effectué et désactive les boucles
			_bCtrlSpawnParasHeliport3 = true
		end
end





------------------------------------------------------------
------------------------------------------------------------

-- ::: Paras batiment Héliport :::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Défrise le soldat du rdc du batiment de l'Héliport si le Nb d'actifs est <= 6 --]]

function OnEnter_Sector_Event_Heliport_4(id)

	-- Si le Player entre dans la 1ère boite (entrée batiment) pour la première fois et que le Nb d'actif est <= 16
	if ((id == _idPlayer) and (_bCtrlSector_Event_Heliport_4 == false)) then

		if (_nActiveBots <= 6) then

			-- Défrise le perso du rdc
			Freeze(GetCharacterID("Char_Syndic_Heliport_00_2"),false)
		end

		-- Déclare que le Player est entré et désactive la fonction
		_bCtrlSector_Event_Heliport_4 = true
	end
end

------------------------------------------------------------

--[[ Change l'order list des soldats de l'étage pour qu'ils ne soient plus figés à leurs waypoints --]]

function OnEnter_Sector_Event_Heliport_5(id)

	-- Si le Player entre dans la 1ère boite (entrée batiment) pour la première fois et que le Nb d'actif est <= 16
	if ((id == _idPlayer) and (_bCtrl_Sector_Event_Heliport_5 == false)) then

		-- Change l'order list
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_00_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Batiment_1b"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_00_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Batiment_2b"))

		-- Déclare que le Player est entré et désactive la fonction
		_bCtrl_Sector_Event_Heliport_5 = true
	end
end





------------------------------------------------------------
------------------------------------------------------------

-- ::: Paras Héliport 3 (Attaque par derrière) :::::::::: --
-- ::: et 1er Paras de la Cour :::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Teste si tous les Syndic de l'Héliport sont morts --]]

function AliveSyndicHeli()

	-- Test si tous les membres des 3 groupes de paras présents sur l'Héliport sont bien morts
	_nAliveGrp_Syndic_Heliport_01 = AliveMembersCount(GetGroupID("Grp_Syndic_Heliport_01"))
	_nAliveGrp_Syndic_Heliport_02 = AliveMembersCount(GetGroupID("Grp_Syndic_Heliport_02"))
	_nAliveGrp_Syndic_Heliport_03 = AliveMembersCount(GetGroupID("Grp_Syndic_Heliport_03"))
	_nAliveGrp_Syndic_Heliport_05 = AliveMembersCount(GetGroupID("Grp_Syndic_Heliport_05"))

	-- Teste la mort des 2 snipers ds la baraque de l'Héliport
	_bAliveSniper_1 = IsAlive(GetCharacterID("Char_Syndic_Heliport_00_1"))
	_bAliveSniper_2 = IsAlive(GetCharacterID("Char_Syndic_Heliport_00_3"))

	-- Si le sniper est mort, déclare la variable à 0
	if (_bAliveSniper_1 == false) then
		_nAliveSniper_1 = 0
	end

	-- Si le sniper est mort, déclare la variable à 0
	if (_bAliveSniper_2 == false) then
		_nAliveSniper_2 = 0
	end

	-- Addition du nombre de bots du Syndic encore vivants
	_nAliveSyndicHeli = (_nAliveGrp_Syndic_Heliport_01 + _nAliveGrp_Syndic_Heliport_02 + _nAliveGrp_Syndic_Heliport_03 +	_nAliveGrp_Syndic_Heliport_05 + _nAliveSniper_1 + _nAliveSniper_2)

	-- S'il ne reste aucun survivant et que la boucle n'a pas déjà été jouée 1 fois
	if ((_nAliveSyndicHeli <= 0) and (_bCtrlAliveSyndicHeli == true)) then

		-- Défrise les paras qui se précipitent vers l'Héliport
		FreezeAll(GetGroupID("Grp_Syndic_Heliport_04"), false)

			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
				StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
	
				 -- 	PauseMusic()
				 --		StopMusic()
				 --		StartMusic()

		-- Déclare que la boucle a déjà été jouée une fois et la désactive
		_bCtrlAliveSyndicHeli = false

		-- Réactive la boite d'évènement Sector_Event_Heliport_3 pour le retour du Player et de Huber
		_nPlayerCourtPasse = false
		_nHuberCourtPasse = false

		-- Crée le Timer qui appelera la fonction DIA_SPE_NIV_O_HUBER_D_08 dans 3 secondes histoire de laisser le temps aux paras de monter un peu la pente
		CreationTimer(true, true, false, "DIA_SPE_NIV_O_HUBER_D_08", 3)

		-- Désactive la Limit Zone de Huber
		_bKillLimitZoneHuber = true
	end
end 

------------------------------------------------------------

--[[ Attaque surprise : dialogue, chgt d'objectif et d'order list pour Huber --]]

function DIA_SPE_NIV_O_HUBER_D_08()

	-- Lance le dialogue de Huber qui prévient le joueur de l'attaque surprise des paras
	MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_08",true,100,2,2,"",100)

	-- :::: OBJECTIF ::::
	NewSubObjective("Obj_B_1_ELIMINER_PARAS","Obj_B_2_REPOUSSER_ENNEMI")

	-- Changement de l'order list d'Huber qui se précipite vers les assaillants (waypoint)
--	SetVarValue(_idMerc[0], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Court_Huber_0"))

--Sector_Event_Heliport_3
--Waypoint_Heliport_13



end

-----------------------------------------------------------

--[[ Nouvel objectif : débusquer les paras cachés dans la cour --]]

function AliveSyndic_Court_01()

	-- Teste le nb de vivants parmi les Paras Héliport 3 (attaque par derrière)
	_nGrp_Syndic_Court_01 = AliveMembersCount(GetGroupID("Grp_Syndic_Heliport_04"))

	-- S'ils sont tous morts et que la boucle n'a jamais été jouée
	if (_nGrp_Syndic_Court_01 <= 0) and (_bCtrlAliveSyndic_Court_01 == true) then

		-- Huber donne ses nouveaux ordres : "Ils se cachent dans les batiments ! Débusquez-les ! Je ne veux aucun survivant !"
	--	MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_28",true,100,2,2,"",100)

		_bWaypointHuberCourt1 = true

		-- :::: OBJECTIF ::::
		--NewObjectiveNewSubObjective("Obj_C_REACH_MONASTERY","Obj_C_1_FOLLOW_HUBER")
		ObjectiveDoneNewObjectiveNewSubObjective("Obj_B_REPRENDRE_HELIPORT","Obj_C_REACH_MONASTERY","Obj_C_1_FOLLOW_HUBER")
		SetVarValue(GetObjectiveID("Obj_W_HUBER_NOT_DIE2"),"Active",true)

		-- Changement de l'order list d'Huber qui se précipite vers les assaillants (waypoint)
		SetVarValue(_idMerc[0], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Court_Huber_0"))

		-- Lance le dialogue d'Huber qui conduit au Monastère
		--MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_09_B",true,100,2,2,"",28)

		RadioMessage("DIA_SPE_NIV_O_HUBER_D_09_B",true,100,4,"")

		-- Déclare que la boucle a été jouée et la désactive
		_bCtrlAliveSyndic_Court_01 = false

		_bReActiveSector_Event_Heliport_3 = true

		_bActiveSector_Event_Heliport_8 = true
	end
end

------------------------------------------------------------

function OnEnter_Sector_Event_Court_3(id)
	if ((id == _idMerc[0]) and (_bReActiveSector_Event_Court_3 == true) and (_bCtrlSector_Event_Court_3 == false)) then

		FreezeAll(GetGroupID("Grp_Syndic_Heliport_06"),false)

		CreationTimer(true, true, false, "ActiveWaypointHuberCourt3", 2)

		-- Lance le dialogue d'Huber qui signale l'arrivée des paras
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_26",true,100,2,2,"",28)

		_bCtrlSector_Event_Court_3 = true

	end
end

-----------------------------------------------------------

function ActiveWaypointHuberCourt3()

	SetVarValue(GetAI_Order_Goto_WaypointID("AIO_Goto_Waypoint_Court_Huber_2"),"PriorityTorso",28.0)	
end

-----------------------------------------------------------

--[[ Vague de paras Court n°2 --]]

function AliveSyndic_Court_02()

	-- Teste le nb de vivants parmi les Paras Héliport 3 (attaque par derrière)
	_nGrp_Syndic_Court_02 = AliveMembersCount(GetGroupID("Grp_Syndic_Heliport_06"))

	-- S'ils sont tous morts et que la boucle n'a jamais été jouée
	if (_nGrp_Syndic_Court_02 <= 0) and (_bCtrlAliveSyndic_Court_02 == true) then

		_bWaypointHuberCourt4 = true

		-- Déclare que la boucle a été jouée et la désactive
		_bCtrlAliveSyndic_Court_02 = false

		_bReActiveSector_Event_Court_4 = true

		-- Lance le dialogue d'Huber qui signale l'arrivée des paras
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_03",true,100,2,2,"",28)


			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
	
				 -- 	PauseMusic()
				 		StopMusic()
				 --		StartMusic()
	end
end


------------------------------------------------------------

function OnEnter_Sector_Event_Court_4(id)
	if ((id == _idMerc[0]) and (_bReActiveSector_Event_Court_4 == true) and (_bCtrlSector_Event_Court_4 == false)) then

		CreationTimer(true, true, false, "UnlockCourtDoor", 3)

		SetVarValue(GetSound_ClientID("Sound_Client_Keyboard2"), "Playing", true)
		_bCtrlSector_Event_Court_4 = true
	end
end

function UnlockCourtDoor()

	-- Unlock et ouvre la porte
	UnLockDoor(GetDoorID("Door_Heli-Court"))
	OpenDoor(GetDoorID("Door_Heli-Court"))

	SetVarValue(GetSound_ClientID("Sound_Client_Keyboard2"), "Playing", false)

	SetVarValue(GetCharacterID("Char_Resist_Renfort_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Merc"))
	SetVarValue(GetCharacterID("Char_Resist_Renfort_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Merc"))

	-- Active le random de dialogues de Huber qui appelle le Player
--	_bOrdreHuber14 = true
end


------------------------------------------------------------

--[[ Kill les Waypoints de Huber pour la phase post heliport --]]

function WaypointHuberCourt1()
	if (_bWaypointHuberCourt1 == true) then
		return true
	else
		return false
	end
end

function WaypointHuberCourt2()
	if (_bWaypointHuberCourt2 == true) then
		return true
	else
		return false
	end
end

function WaypointHuberCourt4()
	if (_bWaypointHuberCourt4 == true) then
		return true
	else
		return false
	end
end


function OnEnter_Sector_Event_Heliport_LZ_Resist_Front_c(id)

	if (id == _idPlayer) then
		-- Modifie l'Order List de Char_Syndic_Heliport_01_1b pour lui mettre un Go_To_Waypoint avec une priorité < en Torso
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_1a"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_1a2"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_1b"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_1b2"))
		SetVarValue(GetCharacterID("Char_Syndic_Heliport_01_1c"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Heliport_Front_1c2"))
	end
end


function OnEnter_Sector_Event_Heliport_8(id)
	if ((id == _idMerc[0]) and (_bActiveSector_Event_Heliport_8 == true) and (_bCtrlSector_Event_Heliport_8 == true)) then
		_bHuberPasseSector_Event_Heliport_8 = true
	end
	if ((id == _idPlayer) and (_bActiveSector_Event_Heliport_8 == true) and (_bCtrlSector_Event_Heliport_8 == true)) then
		_bPlayerPasseSector_Event_Heliport_8 = true
	end
	if ((id == _idPlayer) and (_bPlayerPasseSector_Event_Heliport_8 == true) and (_bHuberPasseSector_Event_Heliport_8 == true) and (_bCtrlSector_Event_Heliport_8 == true)) then
		_bCtrlSector_Event_Heliport_8 = false
		FreezeAll(GetGroupID("Grp_Court_Renforts"), false)
	end
end

----------------------------------------------------------------

function FollowIngeTortue1()
	if (_bFollowIngeTortue1 == true) then
		return true
	else
		return false
	end
end


function FollowIngeTortue2()
	if (_bFollowIngeTortue2 == true) then
		return true
	else
		return false
	end
end


function FollowIngeTortue3()
	if (_bFollowIngeTortue3 == true) then
		return true
	else
		return false
	end
end


function FollowIngeTortue4()
	if (_bFollowIngeTortue4 == true) then
		return true
	else
		return false
	end
end


function FollowIngeTortue5()
	if (_bFollowIngeTortue5 == true) then
		return true
	else
		return false
	end
end

function TestVieTortueHeli()

	_bVieTortue1 = IsAlive(GetCharacterID("Char_Syndic_Heliport_04_1"))
	_bVieTortue2 = IsAlive(GetCharacterID("Char_Syndic_Heliport_04_2"))
	_bVieTortue3 = IsAlive(GetCharacterID("Char_Syndic_Heliport_04_3"))
	_bVieTortue4 = IsAlive(GetCharacterID("Char_Syndic_Heliport_04_4"))
	_bVieTortue5 = IsAlive(GetCharacterID("Char_Syndic_Heliport_04_5"))

	if ((_bVieTortue1 == false) and (_bCtrlVieTortue1 == true)) then
		_bFollowIngeTortue1 = true
		_bCtrlVieTortue1 = false
	elseif ((_bVieTortue2 == false) and (_bCtrlVieTortue2 == true)) then
		_bFollowIngeTortue2 = true
		_bCtrlVieTortue2 = false
	elseif ((_bVieTortue3 == false) and (_bCtrlVieTortue3 == true)) then
		_bFollowIngeTortue3 = true
		_bCtrlVieTortue3 = false
	elseif ((_bVieTortue4 == false) and (_bCtrlVieTortue4 == true)) then
		_bFollowIngeTortue4 = true
		_bCtrlVieTortue4 = false
	elseif ((_bVieTortue5 == false) and (_bCtrlVieTortue5 == true)) then
		_bFollowIngeTortue5 = true
		_bCtrlVieTortue5 = false
	end
end