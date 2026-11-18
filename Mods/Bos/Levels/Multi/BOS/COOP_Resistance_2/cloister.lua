------------------------------------------------------------
------------------------------------------------------------

-- ::: Update level ::::::::::::::::::::::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

function UpdateCloister()

	SpawnGrp5()

	AliveChar_Resist_Cloister_00_10_11()

	AliveTroopers_01_02()

	AliveTroopers_03()

	AliveTroopers_04()

	AliveTroopers_05_06()

	AliveTroopers_07_08()

 TrackingCamPoint_Huber_3()

 TrackingCamPoint_Huber_4()

	TrackingCamPoint_Huber_5()

	TrackingCamPoint_Huber_6()

	TrackingCamPoint_Huber_7()

	TrackingCamPoint_Huber_8()

--	AliveTroopers_09()

	TestVieHuber()

	

Change_Bot_behavior("Char_Syndic_Court_01_1",90,60,"AIO_List_FA_Player")
Change_Bot_behavior("Char_Syndic_Court_01_2",90,60,"AIO_List_FA_Player")
Change_Bot_behavior("Char_Syndic_Court_01_3",90,60,"AIO_List_FA_Player")
Change_Bot_behavior("Char_Syndic_Court_02_1",90,60,"AIO_List_FA_Player")
Change_Bot_behavior("Char_Syndic_Court_02_3",90,60,"AIO_List_FA_Player")
end




------------------------------------------------------------
------------------------------------------------------------

-- ::: Spawn du Player dans l'ascenseur ::::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Démarrage de l'action --]]

function Demarrage()

--	DisableCharCmd()

	if (_idMerc[1] ~= nil) then 
		EnableCharacterCommand(_idMerc[1],false)
	end
end

------------------------------------------------------------

--[[ Le Colonel Huber et Nolan sont dans l'ascenseur. Avant que la porte s'ouvre, le Colonel parle à Nolan --]]

function Cloister_DIA_SPE_NIV_O_HUBER_D_01()

	-- DIA_SPE_NIV_O_HUBER_D_xx
	MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_14",true,100,2,2,"StopAnimHuber1",28)
	SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_Cloister_Huber_0"),"Animation","STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT")
end

function StopAnimHuber1()
		SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_Cloister_Huber_0"),"Animation","STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL")
		CreationTimer(true, true, false, "Cloister_DIA_SPE_NIV_O_HUBER_D_02",2)
end

------------------------------------------------------------

--[[ La porte s'ouvre, Huber demande à Nolan de le suivre et sort de l'ascenseur --]]

function Cloister_DIA_SPE_NIV_O_HUBER_D_02()

	-- Défrise les soldats du RDC du Cloitre
	Freeze(GetCharacterID("Char_Resist_Cloister_00_1"),false)
	Freeze(GetCharacterID("Char_Resist_Cloister_00_2"),false)

	-- Ouverture de la porte de l'ascenseur
	-- <:::: Un jour peut-être ::::> --

	-- DIA_SPE_NIV_O_HUBER_D_02
	MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_15",true,100,2,0,"Cloister_SortieAscHuber",28)
	SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_Cloister_Huber_0"),"Animation","STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT")
end

------------------------------------------------------------

--[[ Huber sort de l'ascenseur --]]

function Cloister_SortieAscHuber()

	-- Attribue une Order_List à Huber
	SetVarValue(_idMerc[0], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Cloister_Follow_Huber_1"))
		if (_idMerc[1] ~= nil) then 
	SetVarValue(_idMerc[1],"CharacterOrderList",GetInvalidEntityID())
		end
	-- :::: OBJECTIF ::::
	NewObjectiveNewSubObjective("Obj_A_DEFENDRE_CLOITRE","Obj_A_1_SUIVRE_HUBER")
--	MiniMapTrack(_idMerc[0], 2, true) 

	-- Active les cmd du Player
--	EnableCharCmd()

	if (_idMerc[1] ~= nil) then 
		EnableCharacterCommand(_idMerc[1],true)
	end

			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
				StartMusic("Sounds//Music//Bos - South theme.wav", true)
	
				 -- 	PauseMusic()
				 --		StopMusic()
				 --		StartMusic()
end






------------------------------------------------------------
------------------------------------------------------------

-- ::: Parcours de Huber suivit par Nolan ::::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Teste si Nolan suit Huber - Boite d'évènement n°1 --]]

function OnEnter_Sector_Event_Cloister_Follow_Huber_1(id)

		-- Si Huber entre dans la boite pour la première fois
		if ((id == _idMerc[0]) and (_nHuberPasse == 0)) then

			-- Déclare que Huber est passé dans la boite et la désactive
			_nHuberPasse = 1
		end

		-- Si le Player entre dans la boite pour la première fois
		if ((id == _idPlayer) and (_nPlayerPasse == 0)) then

			-- Déclare que le Player est passé dans la boite et la désactive
			_nPlayerPasse = 1
		end

		-- Si Huber est entré dans la boite mais pas le Player
		if ((_nHuberPasse <= _nPlayerPasse) and (_nHuberPasse == 1)) then

			-- Active le random de dialogues de Huber qui appelle le Player
			_bOrdreHuber1 = true
		
			_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_2 = true
		end
end

------------------------------------------------------------

--[[ Teste si Nolan suit Huber - Boite d'évènement n°2 --]]

function OnEnter_Sector_Event_Cloister_Follow_Huber_2(id)

	if (_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_2 == true) then

		-- Si Huber entre dans la boite pour la première fois
		if ((id == _idMerc[0]) and (_nHuberPasse <= 1)) then

			-- Déclare que Huber est passé dans la boite et la désactive
			_nHuberPasse = 2
	
			-- Change l'Order_List du "caporal" (Char_Resist_Cloister_00_1) qui se lève et fait son rapport
			SetVarValue(GetCharacterID("Char_Resist_Cloister_00_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Char_Resist_Cloister_00_2b"))
	 end

		-- Si le Player entre dans la boite pour la première fois
		if ((id == _idPlayer) and (_nPlayerPasse <= 1)) then

			-- Déclare que le Player est passé dans la boite et la désactive
			_nPlayerPasse = 2

			-- Change l'Order_List des Mercs qui vont se poser à un endroit où ils ne gènent pas
			if (_idMerc[1] ~= nil) then 			
				SetVarValue(_idMerc[1], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Merc_Cloister_1_1"))
			end
		end

		-- Si Huber est entré dans la boite mais pas le Player
		if ((_nHuberPasse == _nPlayerPasse) and (_nHuberPasse == 2)) then

			-- Lance le dialogue du "caporal"
			Cloister_DIA_SPE_NIV_O_RESIS_G_01()

			_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_3 = true
		end
	end
end

------------------------------------------------------------

--[[ Joue le dialogue du "caporal" --]]

function Cloister_DIA_SPE_NIV_O_RESIS_G_01()

	-- Si la boucle n'a pas déjà été jouée
	if (_bCtrlDialogCaporal == false) then

		-- DIA_SPE_NIV_O_RESIS_G_01
		MakeCharacterSpeak(GetCharacterID("Char_Resist_Cloister_00_2"),_idMerc[0],"DIA_SPE_NIV_O_SERGENT_01",true,100,2,0,"StopAnimHuber2",28)
		SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_Char_Resist_Cloister_00_2"),"Animation","STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT")

		-- Déclare que la boucle a été jouée
		_bCtrlDialogCaporal = true
	end
end


function StopAnimHuber2()
		SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_Char_Resist_Cloister_00_2"),"Animation","STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL")
		CreationTimer(true, true, false, "Cloister_DIA_SPE_NIV_O_HUBER_D_03",2)
end


------------------------------------------------------------

--[[ Huber demande au "Caporal" de se remettre en place et poursuit sa route --]]

function Cloister_DIA_SPE_NIV_O_HUBER_D_03()

	-- Si la boucle n'a pas déjà été jouée
	if (_bCtrlDialogHuber1 == false) then

		-- DIA_SPE_NIV_O_HUBER_D_03
		MakeCharacterSpeak(_idMerc[0],GetCharacterID("Char_Resist_Cloister_00_2"),"DIA_SPE_NIV_O_HUBER_D_16",true,100,2,0,"Cloister_Caporal",28)
		SetVarValue(GetAI_Order_Play_AnimationID("AIOPA_Cloister_Huber_2"),"Animation","STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT")

		-- Déclare que la boucle a été jouée
		_bCtrlDialogHuber1 = true
	end
end

------------------------------------------------------------

--[[ Le "Caporal" se remet en place --]]

function Cloister_Caporal()

		-- Change l'Order_List du "caporal" (Char_Resist_Cloister_00_1) qui se replace
		SetVarValue(GetCharacterID("Char_Resist_Cloister_00_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Char_Resist_Cloister_00_2"))

		-- Crée le Timer qui donne l'ordre à Huber de continuer son chemin
		Cloister_InspecHuber1()

end

------------------------------------------------------------

--[[ Huber poursuit son chemin --]]

function Cloister_InspecHuber1()

	-- Attribue une Order_List à Huber
	_bOrdreHuber2 = true

	if (_idMerc[1] ~= nil) then 
		-- Change l'Order_List des Mercs qui retrouvent leur follow sur le Player
		SetVarValue(_idMerc[1], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Merc"))
	end
end

------------------------------------------------------------

--[[ Teste si Nolan suit Huber - Boite d'évènement n°3 --]]

function OnEnter_Sector_Event_Cloister_Follow_Huber_3(id)

	if (_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_3 == true) then

		-- Si Huber entre dans la boite pour la première fois
		if ((id == _idMerc[0]) and (_nHuberPasse <= 2)) then

			-- Déclare que Huber est passé dans la boite et la désactive
			_nHuberPasse = 3
		end
	
		-- Si le Player entre dans la boite pour la première fois
		if ((id == _idPlayer) and (_nPlayerPasse <= 2)) then

			-- Déclare que le Player est passé dans la boite et la désactive
			_nPlayerPasse = 3
		end

		-- Si Huber est entré dans la boite mais pas le Player
		if ((_nHuberPasse <= _nPlayerPasse) and (_nHuberPasse == 3)) then

			-- Active le random de dialogues de Huber qui appelle le Player
			_bOrdreHuber3 = true

			_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_4 = true

		end
	end
end

------------------------------------------------------------

--[[ Entrage pièce Reload Station RDC --]]

function OnEnter_Sector_Event_Cloister_1_int(id)

	-- Si Nolan entre dans la boite
	if ((id == _idPlayer) and (_bCtrlReloadRoom == true)) then

	-- Défrise les soldats de la pièce Reload Station RDC
	Freeze(GetCharacterID("Char_Resist_Cloister_00_3"),false)
	Freeze(GetCharacterID("Char_Resist_Cloister_00_4"),false)

	end

		-- Si Huber entre dans la boite pour la première fois
		if ((id == _idMerc[0]) and (_nHuberPasse == 3)) then

			_bOrdreHuber3b = true

		end
end

-----------------------------------------------------------

--[[ Entrage pièce Reload Station RDC --]]

function OnEnter_Sector_Event_Cloister_1_ext(id)

	-- Si Nolan entre dans la boite
	if ((id == _idPlayer) and (_bCtrlReloadRoom == true)) then

	-- Défrise les soldats de la pièce Reload Station RDC
	Freeze(GetCharacterID("Char_Resist_Cloister_00_3"),true)
	Freeze(GetCharacterID("Char_Resist_Cloister_00_4"),true)
	end
end

------------------------------------------------------------

--[[ Teste si Nolan suit Huber - Boite d'évènement n°4 --]]

function OnEnter_Sector_Event_Cloister_Follow_Huber_4(id)

	if (_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_4 == true) then

		-- Si Huber entre dans la boite pour la première fois
		if ((id == _idMerc[0]) and (_nHuberPasse <= 3)) then

			-- Déclare que Huber est passé dans la boite et la désactive
			_nHuberPasse = 4
		end

		-- Si le Player entre dans la boite pour la première fois
		if ((id == _idPlayer) and (_nPlayerPasse <= 3)) then

			-- Déclare que le Player est passé dans la boite et la désactive
			_nPlayerPasse = 4
		end

		if ((_nHuberPasse == _nPlayerPasse) and (_nHuberPasse == 4)) then
			if (_CtrlDialogHuber04 == false) then

				-- Lance le dialogue de Huber dans la pièce de la Reload Station du RDC
				Cloister_DIA_SPE_NIV_O_HUBER_D_04()

				-- Déclare que la boucle a été jouée
				_CtrlDialogHuber04 = true
			end
		end
	end
end

------------------------------------------------------------

--[[ Joue le dialogue 1 de Huber dans le pièce Reload Station du RDC --]]

function Cloister_DIA_SPE_NIV_O_HUBER_D_04()

	-- DIA_SPE_NIV_O_HUBER_D_04
	MakeCharacterSpeak(_idMerc[0],GetCharacterID("Char_Resist_Cloister_00_4"),"DIA_SPE_NIV_O_HUBER_D_17",true,100,2,0,"Answer",28)
	CharacterPlaySpecialAction(_idMerc[0],"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)
end

------------------------------------------------------------

function Answer()
	MakeCharacterSpeak(GetCharacterID("Char_Resist_Cloister_00_4"),_idMerc[0],"DIA_GEN_ACKNOWLEDGE_TEAM_B_VOICE_A_1",true,100,2,0,"",28)
	CharacterPlaySpecialAction(GetCharacterID("Char_Resist_Cloister_00_4"),"STAND COMPLETE MILITARY_SALUT W_ALL_2HAND_LIGHT",false,false)

	CharacterStopSpecialAction(_idMerc[0])
	-- Crée le Timer qui donne relance Huber dans sa course folle
	CreationTimer(true, true, false, "Cloister_DIA_SPE_NIV_O_HUBER_D_05",2)
end

--[[ Joue le dialogue 2 de Huber dans le pièce Reload Station du RDC --]]

function Cloister_DIA_SPE_NIV_O_HUBER_D_05()

	-- DIA_SPE_NIV_O_HUBER_D_05
	MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_18",true,100,2,0,"Cloister_InspecHuber2",28)
	CharacterPlaySpecialAction(_idMerc[0],"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)

	CharacterStopSpecialAction(GetCharacterID("Char_Resist_Cloister_00_4"))
end

------------------------------------------------------------

--[[ Huber poursuit son chemin --]]

function Cloister_InspecHuber2()

	CharacterStopSpecialAction(_idMerc[0])

	-- Attribue une Order_List à Huber
	_bOrdreHuber4 = true

	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_5 = true
end

------------------------------------------------------------

--[[ Teste si Nolan suit Huber - Boite d'évènement n°5 --]]

function OnEnter_Sector_Event_Cloister_Follow_Huber_5(id)

	if (_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_5 == true) then

		-- Si Huber entre dans la boite pour la première fois
		if ((id == _idMerc[0]) and (_nHuberPasse <= 4)) then

			-- Déclare que Huber est passé dans la boite et la désactive
			_nHuberPasse = 5

		end

		-- Si le Player entre dans la boite pour la première fois
		if ((id == _idPlayer) and (_nPlayerPasse <= 4)) then

			-- Déclare que le Player est passé dans la boite et la désactive
			_nPlayerPasse = 5

		end

		if ((_nHuberPasse == _nPlayerPasse) and (_nHuberPasse == 5)) then

			-- Active le random de dialogues de Huber qui appelle le Player
			_bOrdreHuber5 = true

			_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_6 = true
		end
	end
end


------------------------------------------------------------

--[[ Teste si Nolan suit Huber - Boite d'évènement n°6 --]]

function OnEnter_Sector_Event_Cloister_Follow_Huber_6(id)

	if (_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_6 == true) then

		-- Si Huber entre dans la boite pour la première fois
		if ((id == _idMerc[0]) and (_nHuberPasse <= 5)) then

			-- Déclare que Huber est passé dans la boite et la désactive
			_nHuberPasse = 6
		end

		-- Si le Player entre dans la boite pour la première fois
		if ((id == _idPlayer) and (_nPlayerPasse <= 5)) then

			-- Déclare que le Player est passé dans la boite et la désactive
			_nPlayerPasse = 6

			-- Active le dialogue de Huber
			_bCtrlDialogueHuber = true
		end

		-- Si Huber est entré dans la boite et le Player aussi
		if ((_nHuberPasse <= _nPlayerPasse) and (_nHuberPasse == 6)) then

			-- Active le random de dialogues de Huber qui appelle le Player
			_bOrdreHuber6 = true

			_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_7 = true

			-- Défrise les soldats de la pièce Reload Station RDC
			Freeze(GetCharacterID("Char_Resist_Cloister_00_6"),false)
			Freeze(GetCharacterID("Char_Resist_Cloister_00_7"),false)
		end
	end
end

------------------------------------------------------------

--[[ Teste si Nolan suit Huber - Boite d'évènement n°7 --]]

function OnEnter_Sector_Event_Cloister_Follow_Huber_7(id)

	if (_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_7 == true) then

		-- Si Huber entre dans la boite pour la première fois
		if ((id == _idMerc[0]) and (_nHuberPasse <= 6)) then

			-- Déclare que Huber est passé dans la boite et la désactive
			_nHuberPasse = 7
		end

		-- Si le Player entre dans la boite pour la première fois
		if ((id == _idPlayer) and (_nPlayerPasse <= 6)) then

			-- Déclare que le Player est passé dans la boite et la désactive
			_nPlayerPasse = 7

			-- Active le dialogue de Huber
			_bCtrlDialogueHuber = true
		end

		-- Si Huber est entré dans la boite et le Player aussi
		if ((_nHuberPasse <= _nPlayerPasse) and (_nHuberPasse == 7) and (_bDjaJoue1 == false)) then

			-- MakeCharacterSpeak(_idMerc[0],"DIA_SPE_NIV_O_HUBER_D_22",true,3)
			MakeCharacterSpeak(_idMerc[0],GetCharacterID("Char_Resist_Cloister_00_6"),"DIA_SPE_NIV_O_HUBER_D_22",true,100,2,0,"Answer2",28)
			CharacterPlaySpecialAction(_idMerc[0],"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)


			_bDjaJoue1 = true
		end
	end
end

------------------------------------------------------------

function Answer2()
	MakeCharacterSpeak(GetCharacterID("Char_Resist_Cloister_00_6"),_idMerc[0],"DIA_GEN_ACKNOWLEDGE_TEAM_A_VOICE_B_3",true,100,2,1,"StopAnimHuber3",28)
	CharacterPlaySpecialAction(GetCharacterID("Char_Resist_Cloister_00_6"),"STAND COMPLETE MILITARY_SALUT W_ALL_2HAND_LIGHT",false,false)
	CharacterStopSpecialAction(_idMerc[0])
	--CharacterStopSpecialAction(GetCharacterID("Char_Resist_Cloister_00_6"))
end


function StopAnimHuber3()
	CharacterStopSpecialAction(GetCharacterID("Char_Resist_Cloister_00_6"))
		-- Crée le Timer qui donne relance Huber dans sa course folle
	CreationTimer(true, true, false, "DitesLeAvekDesFleurs",2)
end

function DitesLeAvekDesFleurs()

	-- Active le random de dialogues de Huber qui appelle le Player
	_bOrdreHuber7 = true

	-- Attribue une Order_List à Huber
	SetVarValue(_idMerc[0], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Cloister_Follow_Huber_2"))

	_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_8 = true

end

------------------------------------------------------------

--[[ Teste si Nolan suit Huber - Boite d'évènement n°8 --]]

function OnEnter_Sector_Event_Cloister_Follow_Huber_8(id)

	if (_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_8 == true) then

		-- Si Huber entre dans la boite pour la première fois
		if ((id == _idMerc[0]) and (_nHuberPasse <= 7)) then

			-- Déclare que Huber est passé dans la boite et la désactive
			_nHuberPasse = 8

			_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_8b = true
		end

		-- Si le Player entre dans la boite pour la première fois
		if ((id == _idPlayer) and (_nPlayerPasse <= 7)) then

			-- Déclare que le Player est passé dans la boite et la désactive
			_nPlayerPasse = 8

			-- Active le dialogue de Huber
			_bCtrlDialogueHuber = true

			-- Défrise les soldats de la pièce Reload Station RDC
			Freeze(GetCharacterID("Char_Resist_Cloister_00_8"),false)
			Freeze(GetCharacterID("Char_Resist_Cloister_00_9"),false)

		end

		-- Si Huber est entré dans la boite mais pas le Player
		if ((_nHuberPasse == _nPlayerPasse) and (_nHuberPasse == 8) and (_bDjaJoue2 == false)) then


			_bDjaJoue2 = true
		end
	end
end

------------------------------------------------------------

--[[ Teste si Nolan suit Huber - Boite d'évènement n°8 --]]

function OnEnter_Sector_Event_Cloister_Follow_Huber_8b(id)

	if (_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_8b == true) then

		-- Si Huber entre dans la boite pour la première fois
		if ((id == _idMerc[0]) and (_nHuberPasse <= 8)) then

			-- Déclare que Huber est passé dans la boite et la désactive
			_nHuberPasse = 8.5
		end

		-- Si le Player entre dans la boite pour la première fois
		if ((id == _idPlayer) and (_nPlayerPasse <= 8)) then

			-- Déclare que le Player est passé dans la boite et la désactive
			_nPlayerPasse = 8.5

			-- Active le dialogue de Huber
			_bCtrlDialogueHuber = true
		end

		-- Si Huber est entré dans la boite et le Player aussi
		if ((_nHuberPasse == _nPlayerPasse) and (_nHuberPasse == 8.5) and (_bDjaJoue3 == false)) then

			_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_9 = true

			-- MakeCharacterSpeak(_idMerc[0],"DIA_SPE_NIV_O_HUBER_D_23",true,3)
			MakeCharacterSpeak(_idMerc[0],GetCharacterID("Char_Resist_Cloister_00_9"),"DIA_SPE_NIV_O_HUBER_D_23",true,100,2,0,"Answer3",28)
			CharacterPlaySpecialAction(_idMerc[0],"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)
			_bDjaJoue3 = true
		end
	end
end

------------------------------------------------------------

function DitesLeAvekDesFleurs2()

	-- Active le random de dialogues de Huber qui appelle le Player
	_bOrdreHuber8 = true
end

function Answer3()
	MakeCharacterSpeak(GetCharacterID("Char_Resist_Cloister_00_9"),_idMerc[0],"DIA_GEN_ACKNOWLEDGE_TEAM_A_VOICE_B_1",true,100,2,1,"StopAnimHuber4",28)
	CharacterPlaySpecialAction(GetCharacterID("Char_Resist_Cloister_00_9"),"STAND COMPLETE MILITARY_SALUT W_ALL_2HAND_LIGHT",false,false)
	CharacterStopSpecialAction(_idMerc[0])

end

function StopAnimHuber4()
	CharacterStopSpecialAction(GetCharacterID("Char_Resist_Cloister_00_9"))
	-- Crée le Timer qui donne relance Huber dans sa course folle
	CreationTimer(true, true, false, "DitesLeAvekDesFleurs2",2)
end
------------------------------------------------------------

--[[ Teste si Nolan suit Huber - Boite d'évènement n°9 --]]

function OnEnter_Sector_Event_Cloister_Follow_Huber_9(id)

	if (_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_9 == true) then

		-- Si Huber entre dans la boite pour la première fois
		if ((id == _idMerc[0]) and (_nHuberPasse <= 8.5)) then

			-- Déclare que Huber est passé dans la boite et la désactive
			_nHuberPasse = 9
		end

		-- Si le Player entre dans la boite pour la première fois
		if ((id == _idPlayer) and (_nPlayerPasse <= 8.5)) then

			-- Déclare que le Player est passé dans la boite et la désactive
			_nPlayerPasse = 9

			-- Active le dialogue de Huber
			_bCtrlDialogueHuber = true
		end

		-- Si Huber est entré dans la boite mais pas le Player
		if ((_nHuberPasse == _nPlayerPasse) and (_nHuberPasse == 9)) then

			-- Active le random de dialogues de Huber qui appelle le Player
			_bOrdreHuber9 = true

			_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_10 = true
		end
	end
end

------------------------------------------------------------

function OnEnter_Sector_Event_Cloister_Follow_Huber_10(id)

	if (_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_10 == true) then

		-- Si Huber entre dans la boite pour la première fois
		if ((id == _idMerc[0]) and (_nHuberPasse <= 9)) then

			-- Déclare que Huber est passé dans la boite et la désactive
			_nHuberPasse = 10
		end

		-- Si le Player entre dans la boite pour la première fois
		if ((id == _idPlayer) and (_nPlayerPasse <= 9)) then

			-- Déclare que le Player est passé dans la boite et la désactive
			_nPlayerPasse = 10

			-- Active le dialogue de Huber
			_bCtrlDialogueHuber = true
		end

		-- Si Huber et le Player st entrés dans la boite 
		if ((_nHuberPasse == _nPlayerPasse) and (_nHuberPasse == 10)) then

			-- Active le random de dialogues de Huber qui appelle le Player
			_bOrdreHuber10 = true

			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
	
				 -- 	PauseMusic()
				 		StopMusic()
				 --		StartMusic()

			CamHuber0()
			ShowCinematicBlackStripes(true)

			_nPlayerPasse = 11
			_nHuberPasse = 11

			DisableCharCmd()
			Freeze(GetCharacterID("Char_Resist_Cloister_00_10"), true)
			Freeze(GetCharacterID("Char_Resist_Cloister_00_11"), true)

			-- Télétransportation des Mercs en zone "sécurisée"
			Teletransportation("Repere_Cloister_Player",_idPlayer)

			if (_idMerc[1] ~= nil) then 

				-- Télétransportation des Mercs en zone "sécurisée"
				Teletransportation("Repere_Cloister_Merc",_idMerc[1])

				-- Attribue une Order_List à Huber
				SetVarValue(_idMerc[1], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Merc_Cinema_1"))
			end

			-- Refrise les soldats de la pièce du RDC et de la pièce du haut
			Freeze(GetCharacterID("Char_Resist_Cloister_00_6"),true)
			Freeze(GetCharacterID("Char_Resist_Cloister_00_7"),true)
			Freeze(GetCharacterID("Char_Resist_Cloister_00_8"),true)
			Freeze(GetCharacterID("Char_Resist_Cloister_00_9"),true)

			-- DIA_SPE_NIV_O_HUBER_D_24
			MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_24",true,100,2,0,"",28)
			CharacterStopSpecialAction(_idMerc[0])
		end
	end
end

function ActivFX_FLM()
	idExplosion = CreateExplosion()
	SetVarValue(idExplosion,"Position",	Vector3D(2121.422119,444.773407,208.463104))
	SetVarValue(idExplosion,"Type","Explosion_Rocket_Bombardement")
	SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Explosion"), "FxState", "Fx Started")	SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Explosion"), "FxState", "Fx Started")
	

--	SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Explosion"), "FxState", "Fx Started")

	DisableTroopers_Cloister_01()

	-- Fait disparadin la porte
	ReleaseEntity(GetDoorID("Door_PieceAsc-Cloister"))

				StartMusic("Sounds//Music//BoS - Resistance theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Resistance theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Eradication theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Twilight theme.wav", true)
			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 1.wav", true)
			--	StartMusic("Sounds//Music//BoS - Cuba Theme 2.wav", true)
	
				 -- 	PauseMusic()
				 --		StopMusic()
				 --		StartMusic()
end

------------------------------------------------------------

--[[ Fonctions appelées par Huber pour désactiver ses ordres --]]

function OrdreHuber1()
	if (_bOrdreHuber1 == true) then
		return true
	else
		return false
	end
end

function OrdreHuber2()
	if (_bOrdreHuber2 == true) then
		return true
	else
		return false
	end
end

function OrdreHuber3()
	if (_bOrdreHuber3 == true) then
		return true
	else
		return false
	end
end

function OrdreHuber3b()
	if (_bOrdreHuber3b == true) then
		return true
	else
		return false
	end
end

function OrdreHuber4()
	if (_bOrdreHuber4 == true) then
		return true
	else
		return false
	end
end

function OrdreHuber5()
	if (_bOrdreHuber5 == true) then
		return true
	else
		return false
	end
end

function OrdreHuber6()
	if (_bOrdreHuber6 == true) then
		return true
	else
		return false
	end
end

function OrdreHuber7()
	if (_bOrdreHuber7 == true) then
		return true
	else
		return false
	end
end

function OrdreHuber8()
	if (_bOrdreHuber8 == true) then
		return true
	else
		return false
	end
end

function OrdreHuber9()
	if (_bOrdreHuber9 == true) then
		return true
	else
		return false
	end
end

function OrdreHuber10()
	if (_bOrdreHuber10 == true) then
		return true
	else
		return false
	end
end

function OrdreHuber11()
	if (_bOrdreHuber11 == true) then
		return true
	else
		return false
	end
end


function OrdreHuber12()
	if (_bOrdreHuber12 == true) then
		return true
	else
		return false
	end
end


function OrdreHuber13()
	if (_bOrdreHuber13 == true) then
		return true
	else
		return false
	end
end

function OrdreHuber14()
	if (_bOrdreHuber14 == true) then
		return true
	else
		return false
	end
end

function OrdrePlayer_Cinema_1()
	if (_bOrdrePlayer_Cinema_1 == true) then
		return true
	else
		return false
	end
end

function OrdrePlayer_Cinema_2()
	if (_bOrdrePlayer_Cinema_2 == true) then
		return true
	else
		return false
	end
end

------------------------------------------------------------

--[[ Dialogues Huber --]]

function DialoguesHuber()
	if ((_nHuberPasse == 1) and (_nHuberPasse > _nPlayerPasse)) then
		RandomCloitreHuberDialogues()
	elseif ((_nHuberPasse == 2) and (_nHuberPasse > _nPlayerPasse)) then
		RandomCloitreHuberDialogues()
	elseif ((_nHuberPasse == 3) and (_nHuberPasse > _nPlayerPasse)) then
		RandomCloitreHuberDialogues()
	elseif ((_nHuberPasse == 4) and (_nHuberPasse > _nPlayerPasse)) then
		RandomCloitreHuberDialogues()
	elseif ((_nHuberPasse == 5) and (_nHuberPasse > _nPlayerPasse)) then
		RandomCloitreHuberDialogues()
	elseif ((_nHuberPasse == 6) and (_nHuberPasse > _nPlayerPasse)) then
		RandomCloitreHuberDialogues()
	elseif ((_nHuberPasse == 7) and (_nHuberPasse > _nPlayerPasse)) then
		RandomCloitreHuberDialogues()
	elseif ((_nHuberPasse == 8) and (_nHuberPasse > _nPlayerPasse)) then
		RandomCloitreHuberDialogues()
	elseif ((_nHuberPasse == 9) and (_nHuberPasse > _nPlayerPasse)) then
		RandomCloitreHuberDialogues()
	elseif ((_nHuberPasse == 10) and (_nHuberPasse > _nPlayerPasse)) then
		RandomCloitreHuberDialogues()
	elseif ((_nHuberPasse == 11) and (_nHuberPasse > _nPlayerPasse)) then
		RandomCloitreHuberDialogues()
	elseif ((_nHuberPasse == 12) and (_nHuberPasse > _nPlayerPasse)) then
		RandomCloitreHuberDialogues()
	elseif ((_nHuberPasse == 13) and (_nHuberPasse > _nPlayerPasse)) then
		RandomCloitreHuberDialogues()
	--elseif ((_nHuberPasse == 14) and (_nHuberPasse > _nPlayerPasse)) then
	--	RandomCloitreHuberDialogues()
--	elseif ((_nHuberPasse == 15) and (_nHuberPasse > _nPlayerPasse)) then
--		RandomCloitreHuberDialogues()
--	elseif ((_nHuberPasse == 16) and (_nHuberPasse > _nPlayerPasse)) then
--		RandomCloitreHuberDialogues()
	end
end 

------------------------------------------------------------
------------------------------------------------------------

-- ::: Spawn des 2 1ers groupes de Troopers ::::::::::::: --

------------------------------------------------------------
------------------------------------------------------------

--[[ Défrise & Disable les cmd des Troopers --]]

function DisableTroopers_Cloister_01()
	FreezeAll(GetGroupID("Grp_Syndic_Cloister_01"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cloister_01_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cloister_01_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cloister_01_3"), false)
	CreationTimer(true, true, false, "AIOL_Cloister_Troopers_01_1", 2)

	SetGodMode(_idMerc[0], true)
	if (_idMerc[1] ~= nil) then 
		SetGodMode(_idMerc[1], true)
	end

	SetGodMode(GetCharacterID("Char_Syndic_Cloister_01_1"), true)
	SetGodMode(GetCharacterID("Char_Syndic_Cloister_01_2"), true)
	SetGodMode(GetCharacterID("Char_Syndic_Cloister_01_3"), true)
end

--[[ Attribution des CMD toutes les 0.5 secondes --]]

function AIOL_Cloister_Troopers_01_1()
	CreationTimer(true, true, false, "AIOL_Cloister_Troopers_01_2", 0.5)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cloister_01_1"), true)	
end
function AIOL_Cloister_Troopers_01_2()
	CreationTimer(true, true, false, "AIOL_Cloister_Troopers_01_3", 0.5)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cloister_01_2"), true)	
end
function AIOL_Cloister_Troopers_01_3()
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cloister_01_3"), true)
end

------------------------------------------------------------

--[[ Défrise & Disable les cmd des Troopers --]]

function DisableTroopers_Cloister_02()
	FreezeAll(GetGroupID("Grp_Syndic_Cloister_02"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cloister_02_1"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cloister_02_2"), false)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cloister_02_3"), false)
	CreationTimer(true, true, false, "AIOL_Cloister_Troopers_02_1", 0.5)
	CamHuber5()

	SetGodMode(GetCharacterID("Char_Syndic_Cloister_02_1"), true)
	SetGodMode(GetCharacterID("Char_Syndic_Cloister_02_2"), true)
	SetGodMode(GetCharacterID("Char_Syndic_Cloister_02_3"), true)
end

--[[ Attribution des CMD toutes les 0.5 secondes --]]

function AIOL_Cloister_Troopers_02_1()
	CreationTimer(true, true, false, "AIOL_Cloister_Troopers_02_2", 0.5)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cloister_02_1"), true)	
end
function AIOL_Cloister_Troopers_02_2()
	CreationTimer(true, true, false, "AIOL_Cloister_Troopers_02_3", 0.5)
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cloister_02_2"), true)	
end
function AIOL_Cloister_Troopers_02_3()
	EnableCharacterCommand(GetCharacterID("Char_Syndic_Cloister_02_3"), true)	
--	CreationTimer(true, true, false, "LZ_Cloister_Troopers_01_02", 2)	
end

------------------------------------------------------------

--[[ Zoom sur chef ennemi --]]

function Zoom_Trooper_02_3()
	CamHuber7()
end

------------------------------------------------------------

--[[ Redonne les cmd au Player et attribue des LZ aux Troopers --]]

function LZ_Cloister_Troopers_01_02()
	CharacterStopSpecialAction(GetCharacterID("Char_Syndic_Cloister_02_1"))
	-- Desactive les alliés de la pièce de reload au rdc
	_bCtrlReloadRoom = false

	EnableCharCmd()

	ShowCinematicBlackStripes(false)

	SetGodMode(_idMerc[0], false)
	if (_idMerc[1] ~= nil) then 
	SetGodMode(_idMerc[1], false)
	end
	SetVarValue(GetCharacterID("Char_Syndic_Cloister_01_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Char_Syndic_Cloister_01_1b"))
	SetVarValue(GetCharacterID("Char_Syndic_Cloister_01_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Char_Syndic_Cloister_01_2b"))
	SetVarValue(GetCharacterID("Char_Syndic_Cloister_01_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Char_Syndic_Cloister_01_3b"))
	SetVarValue(GetCharacterID("Char_Syndic_Cloister_02_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Char_Syndic_Cloister_02_1b"))
	SetVarValue(GetCharacterID("Char_Syndic_Cloister_02_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Char_Syndic_Cloister_02_2b"))
	SetVarValue(GetCharacterID("Char_Syndic_Cloister_02_3"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Char_Syndic_Cloister_02_3b"))

	EnableCharacterCommand(_idMerc[0], true)	
	SetVarValue(GetCharacterID("Char_Resist_Cloister_00_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Char_Resist_Cloister_00_1b"))

	SetGodMode(GetCharacterID("Char_Syndic_Cloister_01_1"), false)
	SetGodMode(GetCharacterID("Char_Syndic_Cloister_01_2"), false)
	SetGodMode(GetCharacterID("Char_Syndic_Cloister_01_3"), false)

	SetGodMode(GetCharacterID("Char_Syndic_Cloister_02_1"), false)
	SetGodMode(GetCharacterID("Char_Syndic_Cloister_02_2"), false)
	SetGodMode(GetCharacterID("Char_Syndic_Cloister_02_3"), false)
	_bOrdreHuber11 = true

	-- :::: OBJECTIF ::::
	NewSubObjective ("Obj_A_1_SUIVRE_HUBER","Obj_A_2_ELIMINER_TROOPERS")
	-- MiniMapTrack(_idMerc[0], 2, false) 

	if (_idMerc[1] ~= nil) then 
		-- Attribue une Order_List à Huber
		SetVarValue(_idMerc[1], "CharacterOrderList", GetInvalidEntityID())
	end

	SetVarValue(GetCharacterID("Char_Resist_Cloister_00_1"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Char_Resist_Cloister_00_1b"))
	SetVarValue(GetCharacterID("Char_Resist_Cloister_00_2"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Char_Resist_Cloister_00_2c"))
	SetVarValue(GetCharacterID("Char_Resist_Cloister_00_10"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Char_Resist_Cloister_00_10b"))
	SetVarValue(GetCharacterID("Char_Resist_Cloister_00_11"), "CharacterOrderList", GetAI_Order_ListID("AIO_List_Char_Resist_Cloister_00_11b"))
end

------------------------------------------------------------

--[[ Retourne true qd le perso est mort --]]

function AliveChar_Resist_Cloister_00_10_11()
	_bTestVieChar_Resist_Cloister_00_10 = IsAlive(GetCharacterID("Char_Resist_Cloister_00_10"))
	_bTestVieChar_Resist_Cloister_00_11 = IsAlive(GetCharacterID("Char_Resist_Cloister_00_11"))
	if (_bTestVieChar_Resist_Cloister_00_10 == false) then
		_bOrdreTroopers_FT_Resist_Cloister_00_10 = true
	end
	if (_bTestVieChar_Resist_Cloister_00_11 == false) then
		_bOrdreTroopers_FT_Resist_Cloister_00_11 = true
	end
end

function OrdreTroopers_FT_Resist_Cloister_00_10()
	if (_bOrdreTroopers_FT_Resist_Cloister_00_10 == true) then
		return true
	else
		return false
	end
end

function OrdreTroopers_FT_Resist_Cloister_00_11()
	if (_bOrdreTroopers_FT_Resist_Cloister_00_11 == true) then
		return true
	else
		return false
	end
end

------------------------------------------------------------

--[[ Test vie ennemis --]]

function AliveTroopers_01_02()
	_nAliveTroopers_01 = AliveMembersCount(GetGroupID("Grp_Syndic_Cloister_01"))
	_nAliveTroopers_02 = AliveMembersCount(GetGroupID("Grp_Syndic_Cloister_02"))

	_nAliveTroopers_01_02 = (_nAliveTroopers_01 + _nAliveTroopers_02)

	if ((_nAliveTroopers_01_02 <= 2) and (_bPlayerIci == false) and (_bCtrlAliveTroopers_01_02 == false))  then
		FreezeAll(GetGroupID("Grp_Syndic_Cloister_03"), false)

		_bCtrlAliveTroopers_01_02 = true
	end
end

------------------------------------------------------------

--[[ Test vie ennemis --]]

function AliveTroopers_03()
	_nAliveTroopers_03 = AliveMembersCount(GetGroupID("Grp_Syndic_Cloister_03"))

	if ((_nAliveTroopers_03 <= 0) and (_bCtrlAliveTroopers_03 == false)) then

		-- Crée le Timer qui lance le défrise des ennemis suivants
		CreationTimer(true, true, false, "DefriseGrp_Syndic_Cloister_04",4)

		_bCtrlAliveTroopers_03 = true
	end
end

------------------------------------------------------------

--[[ Défrise ennemis --]]

function DefriseGrp_Syndic_Cloister_04()
	FreezeAll(GetGroupID("Grp_Syndic_Cloister_04"), false)
	_bPathway = true
	if (_bCtrlDIA_SPE_NIV_O_HUBER_D_26 == false) then
		MakeCharacterSpeak(_idMerc[0],GetInvalidEntityID(),"DIA_SPE_NIV_O_HUBER_D_26",true,100,2,0,"",28)
		_bCtrlDIA_SPE_NIV_O_HUBER_D_26 = true
		-- :::: OBJECTIF ::::
--		NewSubObjective("Obj_A_2_ELIMINER_TROOPERS","Obj_A_3_ELIMINER_PARAS_ET_TROOPERS")
	end
end

------------------------------------------------------------

--[[ Test vie ennemis --]]

function AliveTroopers_04()
	_nAliveTroopers_04 = AliveMembersCount(GetGroupID("Grp_Syndic_Cloister_04"))

	if ((_nAliveTroopers_04 <= 0) and (_bCtrlAliveTroopers_04 == false)) then

		-- Crée le Timer qui lance le défrise des ennemis suivants
		CreationTimer(true, true, false, "DefriseGrp_Syndic_Cloister_05",30)
		CreationTimer(true, true, false, "DIA_GEN_DO_GROUP_FEAR_TEAM_B_VOICE_B_1",15)

		_bCtrlAliveTroopers_04 = true
	end
end

------------------------------------------------------------

--[[ Phrase pour meubler de l'ingénieur --]]

function DIA_GEN_DO_GROUP_FEAR_TEAM_B_VOICE_B_1()
--	MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_19",true,100,2,0,"",28)
	if (_idMerc[1] ~= nil) then 
		MakeCharacterSpeak(_idMerc[1],_idPlayer,"DIA_GEN_DO_GROUP_FEAR_TEAM_B_VOICE_B_1",true,100,2,0,"",28)
	end
--	SetVarValue(_idMerc[0], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Cloister_Follow_Huber_3_RDC"))
--	_PathHuberActiv = false
end

------------------------------------------------------------

--[[ Défrise ennemis --]]

function DefriseGrp_Syndic_Cloister_05()
	_bActiveSpawnGrp5 = true

	FreezeAll(GetGroupID("Grp_Syndic_Cloister_06"), false)
	if (_bCtrlDIA_SPE_NIV_O_HUBER_D_04 == false) then
		--MakeCharacterSpeak(_idMerc[0],GetInvalidEntityID(),"DIA_SPE_NIV_O_HUBER_D_04",true,100,2,0,"",28)
		_bCtrlDIA_SPE_NIV_O_HUBER_D_04 = true
	end
end

function SpawnGrp5()
	if ((_bActiveSpawnGrp5 == true) and (_bPlayerIci == false)) then
		FreezeAll(GetGroupID("Grp_Syndic_Cloister_05"), false)
		_bActiveSpawnGrp5 = false
	end
end
------------------------------------------------------------

--[[ Modifie le pathway de Huber suivant l'endroit ou il se trouve --]]

function AlternanceDePathwaysHuber()
	if ((_bHuberEtage == false) and (_bPathway == true)) then
		SetVarValue(_idMerc[0], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Cloister_Follow_Huber_3_RDC"))
	else
		SetVarValue(_idMerc[0], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Cloister_Follow_Huber_3"))
	end
end

------------------------------------------------------------

--[[ Test vie ennemis --]]

function AliveTroopers_05_06()
	_nAliveTroopers_05 = AliveMembersCount(GetGroupID("Grp_Syndic_Cloister_05"))
	_nAliveTroopers_06 = AliveMembersCount(GetGroupID("Grp_Syndic_Cloister_06"))

	_nAliveTroopers_05_06 = (_nAliveTroopers_05 + _nAliveTroopers_06)

	if ((_nAliveTroopers_05_06 <= 3) and (_bCtrlAliveTroopers_05_06a == false) and (_bPlayerIci == false))  then
		FreezeAll(GetGroupID("Grp_Syndic_Cloister_07"), false)

		_bCtrlAliveTroopers_05_06a = true
	end
	if ((_nAliveTroopers_05_06 <= 0) and (_bCtrlAliveTroopers_05_06b == false))  then
		FreezeAll(GetGroupID("Grp_Syndic_Cloister_08"), false)

		_nAliveTroopers_05_06b = true
	end
end

------------------------------------------------------------

--[[ Test vie ennemis --]]

function AliveTroopers_07_08()
	_nAliveTroopers_07 = AliveMembersCount(GetGroupID("Grp_Syndic_Cloister_07"))
	_nAliveTroopers_08 = AliveMembersCount(GetGroupID("Grp_Syndic_Cloister_08"))

	_nAliveTroopers_07_08 = (_nAliveTroopers_07 + _nAliveTroopers_08)

	if ((_nAliveTroopers_07_08 <= 0) and (_bCtrlAliveTroopers_07_08 == false))  then
	--	FreezeAll(GetGroupID("Grp_Syndic_Cloister_09"), false)
		SetVarValue(_idMerc[0], "CharacterOrderList", GetAI_Order_ListID("AIO_List_Cloister_Follow_Huber_4"))
		--MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_05",false,100,2,0,"",28)
		RadioMessage("DIA_SPE_NIV_O_HUBER_D_05",true,100,4,"ObjectifCloisterHeliport")
		_bCtrlAliveTroopers_07_08 = true
		_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_11 = true
		_nHuberPasse = 11
		_nPlayerPasse = 11
	end

end

------------------------------------------------------------

--[[ Test vie ennemis --]]

function AliveTroopers_09()
	_nAliveTroopers_09 = AliveMembersCount(GetGroupID("Grp_Syndic_Cloister_09"))

	if ((_nAliveTroopers_09 <= 0) and (_bCtrlAliveTroopers_09 == false) and (_nAliveTroopers_07_08 <= 0))  then

		_nAliveTroopers_09 = true
	end
end


function TestVieHuber()

	_nArmorHuber = GetArmorGlobalHPPct(_idMerc[0])

	if ((_nArmorHuber <= 90) and (_nHuberPasse < 12) and (_bCtrlTestVieHuber == false)) then

		SetVarValue(_idMerc[0], "CharacterOrderList", GetAI_Order_ListID("AIOL_Huber_Pathway_en_cas_de_pbm"))

		_bCtrlTestVieHuber = true
	end

end


------------------------------------------------------------

--[[ Met à jour les objectifs --]]

function ObjectifCloisterHeliport()
		-- :::: OBJECTIF ::::
		NewSubObjective("Obj_A_2_ELIMINER_TROOPERS","Obj_A_4_SUIVRE_HUBER")
	--	MiniMapTrack(_idMerc[0], 2, true) 

			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
			--	StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
	
				 -- 	PauseMusic()
				 		StopMusic()
				 --		StartMusic()
end

------------------------------------------------------------

--[[ Teste si Nolan suit Huber - Boite d'évènement n°11 --]]

function OnStay_Sector_Event_Cloister_Follow_Huber_11(id)

	if (_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_11 == true) then

		-- Si Huber entre dans la boite pour la première fois
		if ((id == _idMerc[0]) and (_nHuberPasse <= 11)) then

			-- Déclare que Huber est passé dans la boite et la désactive
			_nHuberPasse = 12
		end

		-- Si le Player entre dans la boite pour la première fois
		if ((id == _idPlayer) and (_nPlayerPasse <= 11)) then

			-- Déclare que le Player est passé dans la boite et la désactive
			_nPlayerPasse = 12

			-- Active le dialogue de Huber
			_bCtrlDialogueHuber = true
		end

		-- Si Huber est entré dans la boite mais pas le Player
		if ((_nHuberPasse == _nPlayerPasse) and (_nHuberPasse == 12)) then

			-- Active le random de dialogues de Huber qui appelle le Player
			_bOrdreHuber12 = true

			_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_12 = true
		end
	end
end

------------------------------------------------------------

--[[ Teste si Nolan suit Huber - Boite d'évènement n°12 --]]

function OnEnter_Sector_Event_Cloister_Follow_Huber_12(id)

	if (_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_12 == true) then

		-- Si Huber entre dans la boite pour la première fois
		if ((id == _idMerc[0]) and (_nHuberPasse <= 12)) then

			-- Déclare que Huber est passé dans la boite et la désactive
			_nHuberPasse = 13
		end

		-- Si le Player entre dans la boite pour la première fois
		if ((id == _idPlayer) and (_nPlayerPasse <= 12)) then

			-- Déclare que le Player est passé dans la boite et la désactive
			_nPlayerPasse = 13

			-- Active le dialogue de Huber
			_bCtrlDialogueHuber = true
		end

		-- Si Huber est entré dans la boite mais pas le Player
		if ((_nHuberPasse == _nPlayerPasse) and (_nHuberPasse == 13)) then

			-- Active le random de dialogues de Huber qui appelle le Player
			_bOrdreHuber13 = true

			_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_13 = true
		end
	end
end

------------------------------------------------------------

--[[ Teste si Nolan suit Huber - Boite d'évènement n°13 --]]

function OnEnter_Sector_Event_Cloister_Follow_Huber_13(id)

	if (_bActiveEventBox_Sector_Event_Cloister_Follow_Huber_13 == true) then

		-- Si Huber entre dans la boite pour la première fois
		if ((id == _idMerc[0]) and (_nHuberPasse <= 13)) then
			-- Déclare que Huber est passé dans la boite et la désactive
			_nHuberPasse = 14

		CreationTimer(true, true, false, "UnlockHeliDoor", 3)

		SetVarValue(GetSound_ClientID("Sound_Client_Keyboard1"), "Playing", true)	

			--	StartMusic("Sounds//Music//Bos - War theme.wav", true)
				StartMusic("Sounds//Music//BoS - Big Boy theme.wav", true)
	
				 -- 	PauseMusic()
				 --		StopMusic()
				 --		StartMusic()
		end

	end
end

function UnlockHeliDoor()
	-- Unlock et ouvre la porte
	UnLockDoor(GetDoorID("Door_Cloister-Heli"))
	OpenDoor(GetDoorID("Door_Cloister-Heli"))

--	SetVarValue(GetSound_ClientID("Sound_Client_Clavier"), "Playing", false)

	-- Active le random de dialogues de Huber qui appelle le Player
	_bOrdreHuber14 = true
	SetVarValue(GetSound_ClientID("Sound_Client_Keyboard1"),"Playing",false)
end


function OrdreHuber12()
	if (_bOrdreHuber12 == true) then
		return true
	else
		return false
	end
end

function OrdreHuber13()
	if (_bOrdreHuber13 == true) then
		return true
	else
		return false
	end
end

function OrdreHuber14()
	if (_bOrdreHuber14 == true) then
		return true
	else
		return false
	end
end

function KeyboardPlaying1()
	SetVarValue(GetSound_ClientID("Sound_Client_Keyboard1"),"Playing",true)
end

function OrdreHuber15()
	if (_bOrdreHuber15 == true) then
		return true
	else
		return false
	end
end


function OnEnter_Sector_Event_Cloister_LZ_2(id)
	if ((id == GetCharacterID("Char_Syndic_Cloister_01_1")) and (_bCtrlSector_Event_Cloister_LZ_2 == false)) then
		CharacterPlaySpecialAction(GetCharacterID("Char_Syndic_Cloister_01_1"),"STAND MEDHI ORDER_GO W_NONE",false,false)
		_bCtrlSector_Event_Cloister_LZ_2 = true
	end
end




function OnEnter_SE_Ici_true(id)
	if (id == _idPlayer) then
		_bPlayerIci = true
	end
end

function OnEnter_SE_Ici_false(id)
	if (id == _idPlayer) then
		_bPlayerIci = false
	end
end