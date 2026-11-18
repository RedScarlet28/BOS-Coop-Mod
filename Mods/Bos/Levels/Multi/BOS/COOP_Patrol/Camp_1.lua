function InitLevel_Camp_1()

-- Initialisations de variables booléennes à false.
		_bFctScenarAppel_Camp_1 = false
		_bDialCap_1=false
		_bFindNolan=false
		_bGoAccesNord=false
		_bFinCap=false
		_bDeja_parti=false
		_bFreezeWRF2=false
		_bDejaCamp_1_B_01=false
		_bPlayerPasse_SE_Camp_1_Test_Tips = false
		_bDroit_de_Declencher_Tips_1b = false
	_bCtrlSE_Intro_Expl = false
		_bActivSaveTest = false
		_bCineGal = false

		_nDialCp1=0
		_vPosObj0_2=GetVarValue(_idCharacter_Teleport,"Position")
		_vRotObj0_2=GetVarValue(_idCharacter_Teleport,"Rotation")
		_vPosCapObj0_2=GetVarValue(_idCharacter_Teleport1,"Position")
		_vRotCapObj0_2=GetVarValue(_idCharacter_Teleport1,"Rotation")
		_vPosCap=GetVarValue(_idCharacter_Teleport2,"Position")
		_vRotCap=GetVarValue(_idCharacter_Teleport2,"Rotation")

end



function UpdateLevel_Camp_1()

		Renfort()										-- Va renvoyer des renforts WRF lorsqu'un certain nombres de bots sera mort.
		RenfortUAN()								-- Gère les vagues de renforts ennemis envoyées par les 2 entrées.
		AssaultEnd()								-- Regarde si l'assaut UAN est terminé, si oui, retour à l'état normal.
		PostFightCamp_1()						-- Va redonner vie au camp en faisant arriver de nouveaux bots WRF.
		InitScenar_Camp_1()					-- Fonction d'ambiance: Lorsque qu'un soldat croisera le général, un petit dialogue apparaitra.
		FindNolan()									-- le Caporal ira chercher le joueur quand un certain temps se sera écoulé (Timer_Camp_1_02).
		TalkCaporal()								-- Teste si le jouer va parler au caporal, si oui, le joueur est emmené à la porte.
		SceneAssault()							-- Scène d'arrivée des ennemis: le pauvre caporal allait ouvrir la porte quand...
		Objectif_0_2_Done()
		SaveTest()
		TrackingCamExoBoS()
end

---------------------------------- Fonctions relatives au Sector Events -----------------------------------------

function OnEnter_SE_Intro_Expl(id)
	if ((id == GetCharacterID("Char_WRF_Camp_1_01_3")) and (_bCtrlSE_Intro_Expl == false))then
		LaunchCameraTransition(GetCamTransitionID("CamTransition_Expl"))	
		ShowCinematicBlackStripes(true)
		CreationTimer(true, true, false, "SceneAssaultB",4.0)	
		EnableCharacterCommand(_idPlayer,false)
		SetGodMode(_idPlayer,true)
		CharacterPlaySpecialAction(_idPlayer,"STAND COMPLETE WAIT W_NONE COOL",true,false)

	if (IsEntityInBox(_idPlayer,"SE_Intro_Expl") == true) then
			Teletransportation("Character_Teleport6",_idPlayer)

		if (_idMerc[0] ~= nil) then 
			EnableCharacterCommand(_idMerc[0],false)
			Teletransportation("Character_Teleport7",_idMerc[0])
		end
		if (_idMerc[1] ~= nil) then 
			EnableCharacterCommand(_idMerc[1],false)
			Teletransportation("Character_Teleport8",_idMerc[1])
		end
	end
	Freeze(_idChar_WRF_Camp_1_07_1,true)
	_bCtrlSE_Intro_Expl = true
	end
end

function End_Intro_Expl_2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Expl_2"))
end

function End_Intro_Expl()
	ShowCinematicBlackStripes(false)
	EnableCharacterCommand(_idPlayer,true)
	CharacterStopSpecialAction(_idPlayer)
	SetGodMode(_idPlayer,false)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterCommand(_idMerc[0],true)
	end
	if (_idMerc[1] ~= nil) then 
		EnableCharacterCommand(_idMerc[1],true)
	end
end

function Debut()
				-- Si le 1er membre de la liste correspond à une entité valide (donc s'il reste 1 mercenaire en vie au moins)
				if (_idMerc[0] ~= nil) then 
						EnableCharacterCommand(_idMerc[0],false)
						CharacterPlaySpecialAction(_idMerc[0],"STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL",true,false)
				--		SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Merc_debut"))		
				end

				-- Si le 2ème membre de la liste correspond à une entité valide (donc si les 2 mercenaires sont en vie)
				if (_idMerc[1] ~= nil) then 
						EnableCharacterCommand(_idMerc[1],false)
						CharacterPlaySpecialAction(_idMerc[1],"STAND COMPLETE WAIT W_NONE COOL",true,false)
				--		SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Goto_Waypoint_Merc_debut"))		
				end
				LaunchCameraTransition(GetCamTransitionID("CamTransition_Debut_A"))
				EnableCharacterCommand(_idPlayer,false)
				CharacterPlaySpecialAction(_idPlayer,"STAND COMPLETE WAIT W_NONE COOL",true,false)
				
				FreezeAll(_idGrp_WRF_Camp_1_1,false)
				Freeze(_idChar_WRF_Camp_1_07_1,false)
				
end

function Debut_2()
	LaunchCameraTransition(GetCamTransitionID("CamTransition_Debut_B"))	
end

function Debut_3()
				ShowCinematicBlackStripes(true)
				FreezeAll(_idGrp_WRF_Camp_1_3,false)
				_bDejaCamp_1_Nolan=true
				EnableCharacterCommand(_idPlayer,false)
				CharacterPlaySpecialAction(_idPlayer,"STAND COMPLETE WAIT W_NONE COOL",true,false)
				EnableCharacterCommand(_idChar_WRF_Camp_1_01_3, false)
				CreationTimer(true, true, false, "AIOL_Char_WRF_Camp_1_01_3",0.5)	
				CreationTimer(true, true, false, "Debut_4",5.0)	

				LaunchCameraTransition(GetCamTransitionID("CamTransition_General"))
				ShowCinematicBlackStripes(true)
end

function Debut_4()
	MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_A_01",true,110,1,0,"Dial_General",100)
	CharacterPlaySpecialAction(_idChar_WRF_Camp_1_Caporal,"STAND COMPLETE MILITARY_SALUT W_ALL_2HAND_LIGHT",true,false)
	CreationTimer(true, true, false,"ANIM_CINE_01",3.0)
end


function OnEnter_SE_Camp_1_Assaut(id)
		for i=1,4 do	
				if (not _bEnter and id==GetCharacterID("Char_UAN_Camp_1_01_" .. i )) then
						MakeCharacterSpeak(_idChar_WRF_Camp_1_Garde,GetInvalidEntityID(),"DIA_SPE_NIV_D_WRF_A_01",true,150,2,1,"",100)
						SetVarValue(GetSound_ClientID("Sound_Client_Alarme_1"),"Playing",true)
						SetVarValue(GetSound_ClientID("Sound_Client_Alarme_2"),"Playing",true)
						_bEnter=true		
				end
		end
		if(id == _idPlayer) then
			if (_idMerc[0] ~= nil) then 
				SetVarValue(_idMerc[0],"CharacterOrderList",GetInvalidEntityID())
			end
			if (_idMerc[1] ~= nil) then 
				SetVarValue(_idMerc[1],"CharacterOrderList",GetInvalidEntityID())
			end
		end
end


function OnEnter_SE_Camp_1_S_01(_idSE_Camp_1_S_01)
		if _idSE_Camp_1_S_01==_idPlayer and not _bDejaCamp_1_S_01 and IsEntityInBox(_idChar_WRF_Solberg_Camp_1, "SE_Camp_1_S_01") and _bGenDial then
				MakeCharacterSpeak(_idChar_WRF_Solberg_Camp_1,_idPlayer,"DIA_SPE_NIV_D_GENERAL_05",true,110,2,1,"",95)	
				_bDejaCamp_1_S_01=true
		end
end

function OnEnter_SE_Camp_1_B_04(_idSE_Camp_1_B_04)
		if _idSE_Camp_1_B_04==_idPlayer  then
				Freeze(_idChar_WRF_Camp_1_01_4,	false)
				Freeze(_idChar_WRF_Camp_1_01_3,	false)
				Freeze(_idChar_WRF_Solberg_Camp_1,false)
				Freeze(_idChar_WRF_Camp_1_01_2, false)
				Freeze(_idChar_WRF_Camp_1_03_5,	true)			
				if _bDejaMort then
						Freeze(_idChar_WRF_Camp_1_02_1,	true)
						Freeze(_idChar_WRF_Camp_1_02_2,	true)
				end
		end
end

--[[ Attribution des CMD au soldat 0.5 s + tard --]]

function AIOL_Char_WRF_Camp_1_01_3()
	EnableCharacterCommand(_idChar_WRF_Camp_1_01_3, true)		
end

function OnEnter_SE_Camp_1_B_05(_idSE_Camp_1_B_05)
		if _idSE_Camp_1_B_05==_idPlayer  then
				if IsEntityInBox(_idChar_WRF_Camp_1_01_4,"SE_Camp_1_B_02") and not _bDejaCamp_1_B_01 then
						Freeze(_idChar_WRF_Camp_1_01_4,	true)
				end		
				if IsEntityInBox(_idChar_WRF_Camp_1_01_3,"SE_Camp_1_B_03") then
						Freeze(_idChar_WRF_Camp_1_01_3,	true)
				end	
				if IsEntityInBox(_idChar_WRF_Solberg_Camp_1,"SE_Camp_1_B_06") then
						Freeze(_idChar_WRF_Solberg_Camp_1,true)
				end	
				if IsEntityInBox(_idChar_WRF_Camp_1_01_2,"SE_Camp_1_B_06") then
						Freeze(_idChar_WRF_Camp_1_01_2,true)
				end		
				if _bDejaMort then
						Freeze(_idChar_WRF_Camp_1_02_1,	false)
						Freeze(_idChar_WRF_Camp_1_02_2,	false)
				end
		end
end

function OnEnter_SE_Camp_1_B_09(_idSE_Camp_1_B_09)
		if _idSE_Camp_1_B_09==_idPlayer  then			
		end
end


function OnEnter_SE_Camp_1_B_15(_idSE_Camp_1_B_15)
		if _idSE_Camp_1_B_15==_idPlayer and _bDejaMort then			
				Freeze(_idChar_WRF_Camp_1_03_5,	false)	
		end
end

function OnEnter_SE_Camp_1_F_01(_idSE_Camp_1_F_01)
		if (_idSE_Camp_1_F_01==_idPlayer) then

-- DeFreeze Camp_1-------------------------		
				FreezeAll(_idGrp_WRF_Camp_1_1,false)
				FreezeAll(_idGrp_WRF_Camp_1_2,false)
				FreezeAll(_idGrp_WRF_Camp_1_5,false)
				FreezeAll(_idGrp_UAN_Camp_1_5,false)

-- Freeze Trench_1-----------------------------	
				FreezeAll(_idGrp_UAN_Trench_1_1,true)
				FreezeAll(_idGrp_UAN_Trench_1_2,true)
				FreezeAll(_idGrp_UAN_Trench_1_3,true)
				FreezeAll(_idGrp_UAN_Trench_1_4,true)
				FreezeAll(_idGrp_UAN_Trench_1_5,true)
				FreezeAll(_idGrp_UAN_Trench_1_6,true)
				_bFreezeWRF2=true
		end
end

function OnEnter_SE_Camp_1_Caporal_1(_idSE_Camp_1_Caporal_1)
		if _idSE_Camp_1_Caporal_1==_idPlayer  and not _bDialCap_1 and IsEntityInBox(_idChar_WRF_Camp_1_01_3,"SE_Camp_1_Caporal_1") and _bSE_Cap then
				_bDialCap_1=true
			
		end
end

function OnEnter_SE_Camp_1_Reload(_idSE_Camp_1_Reload)

		if _idSE_Camp_1_Reload==_idPlayer and not _bObj_Tut_1 and _bCap then
				--MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_A_04",true,110,1,2,"",100)
				RadioMessage("DIA_SPE_NIV_D_OFFICER_A_04",true,110,4,"")
				SetVarValue(GetTimerID("Timer_Objective_0_2"),"Active",true)
				EnableCharacterCommand(_idPlayer,false)
				--CharacterPlaySpecialAction(_idPlayer,"STAND COMPLETE WAIT W_NONE COOL",true,false)
				_bObj_Tut_1=true
				SetVarValue(GetTimerID("Timer_Camp_1_Radio_Tut"),"Active",false)
				_bDesactiveTips_2 = true
				_bPlayerPasse_SE_Camp_1_Test_Tips = false
		end

end

function OnEnter_SE_Camp_1_Test_Tips(id)
	if ((id == _idPlayer) and (_bPlayerPasse_SE_Camp_1_Test_Tips == false)) then
		_bDroit_de_Declencher_Tips_1b = true
		_bPlayerPasse_SE_Camp_1_Test_Tips = true
	end
end

function OnEnter_SE_Camp_1_Save(_idSE_Camp_1_Save)
		if _idSE_Camp_1_Save==_idPlayer and not _bObj_Save and _bObj0_3 then
		--	NewSubObjective ( "Obj_A_4", "Obj_A_5" )
		--	_bObj_Save=true
				SetVarValue(GetTimerID("Timer_Camp_1_Radio_Tut"),"Active",false)

		end
end

function SaveTest()
	_nNbSaveRestantes = GetVarValue(GetSave_StationID("Save_Station_01"), "Nbr Saves")
	if ((_nNbSaveRestantes <= 0) and (_bActivSaveTest == true)) then
			NewSubObjective ( "Obj_A_4", "Obj_A_5" )
			_bObj_Save=true
			_bActivSaveTest = false
	end
end

function OnEnter_SE_Camp_1_S_02(_idSE_Camp_1_S_02)

		if _idSE_Camp_1_S_02==_idPlayer and not _bSE_Camp_1_S_02 and _bObj0_4 then
				EnableCharacterCommand(_idPlayer,false)
				Freeze(_idChar_WRF_Camp_1_01_2,true)
				CharacterPlaySpecialAction(_idPlayer,"STAND COMPLETE WAIT W_NONE COOL",true,false)
			-- Télétransportation du Player en zone "sécurisée"
		 	Teletransportation("Character_Teleport3",_idPlayer)
				Freeze(GetCharacterID("Char_WRF_Camp_1_02_3"), true)
				if (_idMerc[0] ~= nil) then 
						EnableCharacterCommand(_idMerc[0],false)
						-- Télétransportation du Player en zone "sécurisée"
						Teletransportation("Character_Teleport4",_idMerc[0])
				end
				-- Si le 2ème membre de la liste correspond à une entité valide (donc si les 2 mercenaires sont en vie)
				if (_idMerc[1] ~= nil) then 
						EnableCharacterCommand(_idMerc[1],false)
						-- Télétransportation du Player en zone "sécurisée"
						Teletransportation("Character_Teleport5",_idMerc[1])
				end

				LaunchCameraTransition(GetCamTransitionID("CamTransition_Obj_0_4_1"))
				Freeze(_idChar_WRF_Camp_1_Caporal,true)
				Freeze(_idChar_WRF_Camp_1_01_5,true)
				ShowCinematicBlackStripes(true)
				_bSE_Camp_1_S_02=true
				SetVarValue(GetTimerID("Timer_Camp_1_Radio_Tut"),"Active",false)
				EnableCharacterCommand(_idChar_WRF_Camp_1_01_3,false)
				SetVarValue(_idChar_WRF_Camp_1_01_3,"Position",_vPosCap)
				SetVarValue(_idChar_WRF_Camp_1_01_3,"Rotation",_vRotCap)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Caporal1"),"PriorityTorso",70)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Caporal1"),"PriorityLegs",70)
		end

		if _idSE_Camp_1_S_02==_idChar_WRF_Solberg_Camp_1 and _bSE_Camp_1_S_02 and not _bGenDial then
				LaunchCameraTransition(GetCamTransitionID("CamTransition_Obj_0_4_2"))
				_bCineGal = true
				MakeCharacterSpeak(_idChar_WRF_Solberg_Camp_1,_idPlayer,"DIA_SPE_NIV_D_GENERAL_01",true,110,1,1,"",95)
				CharacterPlaySpecialAction(_idChar_WRF_Solberg_Camp_1,"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)
				SetVarValue(GetTimerID("Timer_Objective_1_1_Active"),"Active",true)
				SetVarValue(GetObjectiveID("Obj_A_6"),"Active",false)
				ObjectiveDoneNewObjectiveNewSubObjective ( "Obj_A", "Obj_B", "Obj_B_1" )

				_bObj1_1=true
				_bGenDial=true
		end

end

function TrackingCamExoBoS()
	if (_bCineSport == 1) then
		--CamPointTargetCharacter(GetCamPointID("CamPoint_Sport_A_01"),_idChar_WRF_Camp_1_07_1)
	--	CamPointTargetCharacter(GetCamPointID("CamPoint_Sport_A_00"),_idChar_WRF_Camp_1_07_1)
		--CamPointTargetCharacter(GetCamPointID("CamPoint_Obj_0_4_3"),GetCharacterID("Char_WRF_Camp_1_Solberg"))
	end
end

function OnEnter_SE_Camp_1_S_03(_idSE_Camp_1_S_03)

		if _idSE_Camp_1_S_03==_idPlayer and not _bSE_Cap and _bObj1_1 then
				EnableCharacterCommand(_idPlayer,false)
				CharacterPlaySpecialAction(_idPlayer,"STAND COMPLETE WAIT W_NONE COOL",true,false)
					Teletransportation("Character_Teleport9",_idPlayer)				

				if (_idMerc[0] ~= nil) then 
						EnableCharacterCommand(_idMerc[0],false)
				end
				-- Si le 2ème membre de la liste correspond à une entité valide (donc si les 2 mercenaires sont en vie)
				if (_idMerc[1] ~= nil) then 
						EnableCharacterCommand(_idMerc[1],false)
				end
				LaunchCameraTransition(GetCamTransitionID("CamTransition_Obj_1_1_1"))
				ShowCinematicBlackStripes(true)
				CharacterPlaySpecialAction(_idChar_WRF_Camp_1_01_3,"STAND COMPLETE TALK_FAR W_ALL_2HAND_LIGHT",true,false)
				MakeCharacterSpeak(_idChar_WRF_Camp_1_01_3,_idPlayer,"DIA_SPE_NIV_D_CAPORAL_02",true,110,1,1,"OnSactiveEtVite",98)
			--	SetVarValue(_idTimer_Camp_1_02,"Active",true)  -- Il vient chercher Nolan
				_bSE_Cap=true
				_bEndSpeakGen=true
		end

end

function OnSactiveEtVite()
	GoAccesNord()
end


function OnEnter_SE_Camp_1_O_01(_idSE_Camp_1_O_01)

		if _idSE_Camp_1_O_01==_idPlayer and _bObj0_2_done and not _bSE_Camp_1_O_01 then
				MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_A_08",true,110,1,1,"",100)
				MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_A_09",true,110,1,1,"",100)
				
				MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_A_10",true,110,1,1,"",95)
				MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_A_11",true,110,1,1,"",95)

				SetVarValue(GetTimerID("Timer_Objective_0_3_Active"),"Active",true)
				SetVarValue(GetAI_Order_Forbid_ZoneID("AI_O_Forbid_Zone_Camp_1"),"PriorityLegs",100)
--				SetVarValue(GetObjectiveID("Objective_Patrol_0_3"),"Active",true)
				--EnableCharacterCommand(_idPlayer,false)
				NewSubObjective ( "Obj_A_3", "Obj_A_4")
				_bObj0_3=true
				_bSE_Camp_1_O_01=true
				SetVarValue(GetSave_StationID("Save_Station_01"), "Nbr Saves", 1)
				AddPlayerMoney(800)
				EnableCharacterCommand(_idPlayer,true)
				_bActivSaveTest = true
		end
		if _bObj_Save and _idSE_Camp_1_O_01==_idPlayer and not _bSE_Camp_1_O_02 then
				MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_A_12",true,110,1,1,"",100)
				SetVarValue(GetTimerID("Timer_Objective_0_3_Dial_3"),"Active",true)
				SetVarValue(GetTimerID("Timer_Objective_0_4"),"Active",true)
				SetVarValue(GetTimerID("Timer_Objective_0_4_Active"),"Active",true)
--				SetVarValue(GetObjectiveID("Objective_Patrol_0_4"),"Active",true)
				NewSubObjective ( "Obj_A_5", "Obj_A_6")
				_bObj0_4=true
				_bSE_Camp_1_O_02=true
		end

end

-----------------------------------------------------------------------------------------------------
--[[																		OnEnter_SE_EoL_Demo()

Temporaire: Pour la Beta GDC, permet de passer directement à Patrol_2.
--]]
-----------------------------------------------------------------------------------------------------

function OnEnter_SE_EoL_Demo(_idSE_EoL_Demo)
		if (_idSE_EoL_Demo==_idPlayer) then
--				EndOfLevel()
		end
end

--------------------- Fonctions d'expiration d'ordres --------------------

function ExpGarde()
		if _bDejaMort then
				return true
		end
		return false
end


function ExpGoto_Player()
		if _bObj_Tut_1 then
				return true
		end
		return false
end


function ExpDial_Cap()
		if _bFinCap then
				return true
		end
		return false
end


function ExpUse_Pathway_Camp_1(idCharac)
		if _bEnter and idCharac~=idChar_WRF_Camp_1_02_3 then
				return true
		end
		return false
end


function ExpCap_Player()
		if _bTestP_30 then
				return true
		end
		return false
end


function ExpObjective0_2()
		if _bObj0_2 then
				return true
		end
		return false
end



function ExpGen_Player()
		if _bSE_Camp_1_S_02 then
				return true
		end
		return false
end



function ExpGen_Player2()
		if _bEndSpeakGen then
				return true
		end
		return false
end



function ExpCap_Player2()
		if _bDial_Cap_2 then
				return true
		end
		return false
end

-------------------------- Fonctions diverses ----------------------------



function InitScenar_Camp_1()
-- si on a pas deja appellé la fct
		if ( _bFctScenarAppel_Camp_1 == false ) then
 		-- est que les 2 persos sont present dans la boite à cette frame
    		if IsEntityInBox(_idChar_WRF_Solberg_Camp_1, "SE_Camp_1_S_01") and IsEntityInBox(_idChar_WRF_Camp_1_01_2, "SE_Camp_1_S_01") 
				and IsEntityInBox(_idPlayer, "SE_Camp_1_B_06") then
           	 FctScenar_Camp_1()         -- on appelle
           	 _bFctScenarAppel_Camp_1 = true      -- on met le flag a true pour ne plus rappeller
    		end
		end
end



function FctScenar_Camp_1()

-- Animation d'ordre ou de discussion
		MakeCharacterSpeak(_idChar_WRF_Solberg_Camp_1,_idPlayer,"DIA_SPE_NIV_D_GENERAL_04",true,110,1,1,"",100)
		SetVarValue(_idTimer_Camp_1_06,"Active",true)


end



function Ordre()

		if not _bDeja_parti then
				MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_A_02",true,110,1,1,"",100)
				
--				DisplaySubtitle("DIA_SPE_NIV_D_WRF_B_02",2,2)
				SetVarValue(_idTimer_Camp_1_04,"Active",true)
				_bDeja_parti=true
		end

end



function Intro()
	LaunchCameraTransition(GetCamTransitionID("CamTransition-64"))
end
			---------------------------------
			function ANIM_CINE_01()
				
				CharacterPlaySpecialAction(_idChar_WRF_Camp_1_Caporal,"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)
				CreationTimer(true, true, false,"ANIM_CINE_02",6.0)
			end
			
				function ANIM_CINE_02()
				
					CharacterPlaySpecialAction(_idChar_WRF_Camp_1_Caporal,"STAND COMPLETE SHOW_MAP W_NONE",true,false)
					CreationTimer(true, true, false,"ANIM_CINE_03",3.0)
				end
	
					function ANIM_CINE_03()
				
						CharacterPlaySpecialAction(_idChar_WRF_Camp_1_Caporal,"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)
						CreationTimer(true, true, false,"ANIM_CINE_04",5.0)
					end

						function ANIM_CINE_04()
							CharacterStopSpecialAction(_idChar_WRF_Camp_1_Caporal)
						end

				
			-----------------------------------
function Dial_General()	
	LaunchCameraTransition(GetCamTransitionID("CamTransition-65"))
	SetVarValue(_idTimer_Camp_1_01,"Active",true)
end



function FinDial_General()

		EnableCharacterCommand(_idPlayer,true)
		CharacterStopSpecialAction(_idPlayer)
--		DisplayObjective ( "HUD_OBJ_UPDATED", GetObjectiveID("Objective_Patrol_1_1"), 4, 5 )
		--ShowCinematicBlackStripes(false)
end



function Objective_0_1()

--		EnableCharacterCommand(_idPlayer,true)
--		SetVarValue(GetTimerID("Timer_Objective_0_1"),"Active",true)
		LaunchCameraTransition(GetCamTransitionID("CamTransition-66"))
		StopMusic()
end



function Objective_0_1_Active()

--		DisplayObjective ( "HUD_OBJ_UPDATED", GetObjectiveID("Objective_Patrol_0_1"), 4, 5 )
		NewObjectiveNewSubObjective ( "Obj_A", "Obj_A_1" )
		SetVarValue(GetTimerID("Timer_Camp_1_Radio_Tut"),"Active",true)
		CreationTimer(true, true, false, "Tutorial_Tips_1",3)
		EnableCharacterCommand(_idPlayer,true)
		CharacterStopSpecialAction(_idPlayer)
		-- Fin de la première cinématique 
		ShowCinematicBlackStripes(false)
end



function Objective_0_2_Active()

--_idCamTransition_Obj_0_2_4=GetCamTransitionID("CamTransition_Obj_0_2_4")

		_bObj0_2=true
--		LaunchCameraTransition(_idCamTransition_Obj_0_2_4)
		SetVarValue(GetTimerID("Timer_Camp_1_Radio_Tut"),"Active",true)
		NewSubObjective ("Obj_A_1", "Obj_A_2")
		AddPlayerMoney(170)
end



function Objective_0_3_Active()

		if not _bObj_Save then 
--				DisplayObjective ( "HUD_OBJ_UPDATED", GetObjectiveID("Objective_Patrol_0_3"), 4, 5 )
				SetVarValue(GetTimerID("Timer_Camp_1_Radio_Tut"),"Active",true)
		end
--		SetVarValue(GetObjectiveID("Objective_Patrol_0_3"),"Active",true)

end



function Objective_0_4_Active()

		if not _bSE_Camp_1_S_02 then
--				DisplayObjective ( "HUD_OBJ_UPDATED", GetObjectiveID("Objective_Patrol_0_4"), 4, 5 )
				SetVarValue(GetTimerID("Timer_Camp_1_Radio_Tut"),"Active",true)
		end

end



function Objective_1_1_Active()

		MakeCharacterSpeak(_idChar_WRF_Solberg_Camp_1,_idPlayer,"DIA_SPE_NIV_D_GENERAL_06",true,110,1,1,"",95)
--		DisplayObjective ( "HUD_OBJ_UPDATED", GetObjectiveID("Objective_Patrol_1_1"), 4, 5 )
--		SetVarValue(GetObjectiveID("Objective_Patrol_1_1"),"Active",true)
		SetVarValue(GetTimerID("Timer_Objective_1_1_Dial"),"Active",true)

end




function Objective_1_1_Dial()

				MakeCharacterSpeak(_idChar_WRF_Solberg_Camp_1,_idPlayer,"DIA_SPE_NIV_D_GENERAL_08",true,110,1,3,"",95)
				CharacterPlaySpecialAction(_idChar_WRF_Solberg_Camp_1,"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)
			--	CharacterPlaySpecialAction(_idChar_WRF_Solberg_Camp_1,"STAND COMPLETE BOS HIT_CHEST W_ALL_2HAND_LIGHT",true,false)				
				SetVarValue(GetTimerID("Timer_Objective_1_1_Dial_2"),"Active",true)

end

function Objective_1_1_Dial2()
				MakeCharacterSpeak(_idChar_WRF_Solberg_Camp_1,_idPlayer,"DIA_SPE_NIV_D_GENERAL_09",true,110,1,1,"",95)
					CharacterPlaySpecialAction(_idChar_WRF_Solberg_Camp_1,"STAND COMPLETE BOS FINGER_SHOW W_ALL_2HAND_LIGHT",true,false)				
				CreationTimer(true, true, false,"Stop_General_anim_01",1.90)
end
				--------------
			function Stop_General_anim_01()
				CharacterPlaySpecialAction(_idChar_WRF_Solberg_Camp_1,"STAND COMPLETE WAIT W_ALL_2HAND_LIGHT COOL",true,false)
--				CharacterStopSpecialAction(_idChar_WRF_Solberg_Camp_1)
			end
				--------------
function BlackStripesOff()
	Freeze(_idChar_WRF_Camp_1_01_2,false)
	ShowCinematicBlackStripes(false)
	EnableCharacterCommand(_idPlayer,true)
	CharacterStopSpecialAction(_idPlayer)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterCommand(_idMerc[0],true)
		CharacterStopSpecialAction(_idMerc[0])
		SetVarValue(_idMerc[0],"CharacterOrderList",GetInvalidEntityID())		
	end
	-- Si le 2ème membre de la liste correspond à une entité valide (donc si les 2 mercenaires sont en vie)
	if (_idMerc[1] ~= nil) then 
		EnableCharacterCommand(_idMerc[1],true)
		CharacterStopSpecialAction(_idMerc[1])	
		SetVarValue(_idMerc[1],"CharacterOrderList",GetInvalidEntityID())	
	end
	SetVarValue(GetAI_Order_Forbid_ZoneID("AI_O_Forbid_Zone_Camp_1"),"PriorityLegs",0)
end


function Objective_0_3_Dial4()

		MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_A_13",true,110,1,1,"TIPSMERCS",100)
		if (_idMerc[0] ~= nil) then 
				EnableCharacterCommand(_idMerc[0],true)
		end
		-- Si le 2ème membre de la liste correspond à une entité valide (donc si les 2 mercenaires sont en vie)
		if (_idMerc[1] ~= nil) then 
				EnableCharacterCommand(_idMerc[1],true)
		end

end




function Objective_0_4()

	MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_A_14",true,110,1,1,"anim",95)
	if (_idMerc[0] ~= nil) then 
		EnableCharacterCommand(_idMerc[0],true)
		CharacterStopSpecialAction(_idMerc[0])
		SetVarValue(_idMerc[0],"CharacterOrderList",GetInvalidEntityID())		
	end
	-- Si le 2ème membre de la liste correspond à une entité valide (donc si les 2 mercenaires sont en vie)
	if (_idMerc[1] ~= nil) then 
		EnableCharacterCommand(_idMerc[1],true)
		CharacterStopSpecialAction(_idMerc[1])	
		SetVarValue(_idMerc[0],"CharacterOrderList",GetInvalidEntityID())	
	end		
end
					-----------------
		function anim()
			CharacterPlaySpecialAction(_idChar_WRF_Camp_1_Caporal,"STAND COMPLETE MILITARY_SALUT W_ALL_2HAND_LIGHT",true,false)
			CreationTimer(true, true, false,"Stop_anim",3.50)
		end
		function Stop_anim()
			CharacterPlaySpecialAction(_idChar_WRF_Camp_1_Caporal,"STAND COMPLETE WAIT W_NONE COOL",true,false)
		end
			---------------------
function Dial_Caporal()

			if not _bCap then
					MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_A_03",true,110,1,2,"",100)
					SetVarValue(_idTimer_Camp_1_05,"Active",true)
					_bCap=true
			end

end



function Dial_Caporal_2()

			EnableCharacterCommand(_idChar_WRF_Camp_1_01_3,true)
			EnableCharacterCommand(_idPlayer,true)
			CharacterStopSpecialAction(_idPlayer)
			ShowCinematicBlackStripes(false)
			if (_idMerc[0] ~= nil) then 
					EnableCharacterCommand(_idMerc[0],true)
			end
			-- Si le 2ème membre de la liste correspond à une entité valide (donc si les 2 mercenaires sont en vie)
			if (_idMerc[1] ~= nil) then 
						EnableCharacterCommand(_idMerc[1],true)
			end
			_bDial_Cap_2=true

end



function TalkCaporal()
		if _bDialCap_1 and not _bGoAccesNord then
				GoAccesNord()
		end
end



function Dial_ScenarCamp_1()
			if _nDialCp1==0 then
					DisplaySubtitle("DIA_GEN_ACKNOWLEDGE_TEAM_A_VOICE_B_1",1,2)
					_nDialCp1=_nDialCp1+1
			elseif _nDialCp1==1 then
					DisplaySubtitle("DIA_GEN_DO_HEAR_NOISE_TEAM_A_VOICE_A_2",1,2)
					ReleaseEntity(_idTimer_Camp_1_06)
			end
end



function FinDial_Caporal()
		-- Si le 1er membre de la liste correspond à une entité valide (donc s'il reste 1 mercenaire en vie au moins)
--[[		if (_idMerc[0] ~= nil) then 
				EnableCharacterCommand(_idMerc[0],true)
		end
		-- Si le 2ème membre de la liste correspond à une entité valide (donc si les 2 mercenaires sont en vie)
		if (_idMerc[1] ~= nil) then 
				EnableCharacterCommand(_idMerc[1],true)
		end--]]
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Caporal"),"PriorityTorso",20)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Caporal"),"PriorityLegs",35)
		_bFinCap=true
end



-----------------------------------------------------------------------------------------------------
--[[																		Objectif0_2()

Lance du deuxième sous objectif du tutorial.
Téléportadin du joueur et cinématique.
--]]
-----------------------------------------------------------------------------------------------------

function Objectif_0_2()

			EnableCharacterCommand(_idPlayer,false)
			CharacterPlaySpecialAction(_idPlayer,"STAND COMPLETE WAIT W_NONE COOL",true,false)
			EnableCharacterCommand(_idChar_WRF_Camp_1_Caporal,false)
			SetVarValue(_idPlayer,"Position",_vPosObj0_2)
			SetVarValue(_idPlayer,"Rotation",_vRotObj0_2)
			SetVarValue(_idChar_WRF_Camp_1_Caporal,"Position",_vPosCapObj0_2)
			SetVarValue(_idChar_WRF_Camp_1_Caporal,"Rotation",_vRotCapObj0_2)
			LaunchCameraTransition(GetCamTransitionID("CamTransition_Obj_0_2_1"))
			ShowCinematicBlackStripes(true)
			Freeze(_idChar_WRF_Camp_1_01_5,false)
			SetVarValue(_idChar_WRF_Camp_1_Caporal,"CharacterOrderList",GetInvalidEntityID())
		--	Freeze(_idChar_WRF_Camp_1_01_6,false)
			MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_A_05",true,95,1,1,"",95)
			MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_A_06",true,95,1,1,"Objectif_0_2_Cin1",95)
			
		--			MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,"DIA_SPE_NIV_D_OFFICER_A_06",true,2)
--			SetVarValue(GetTimerID("Timer_Objective_0_2_Dial"),"Active",true)

end
------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------
--[[																		Objectif0_2_Cin1()

Lance Cinématique 1.
--]]
-----------------------------------------------------------------------------------------------------

function Objectif_0_2_Cin1()

--			CamPointTargetCharacter(GetCamPointID("CamPoint_Obj_0_2_3"),_idChar_WRF_Camp_1_Caporal)
--			CamPointTargetCharacter(GetCamPointID("CamPoint_Obj_0_2_4"),_idChar_WRF_Camp_1_Caporal)
			
			--LaunchCameraTransition(GetCamTransitionID("CamTransition_Obj_0_2_2"))
			--ShowCinematicBlackStripes(true)
			--	CharacterStopSpecialAction(_idChar_WRF_Camp_1_Caporal)
				EnableCharacterCommand(_idChar_WRF_Camp_1_Caporal,true)
				SetVarValue(_idChar_WRF_Camp_1_Caporal,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_ANIM_COME"))
				CreationTimer(true, true, false, "Soldier_Salut",5.0)
end
				function Call_Soldier()
				--MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idChar_WRF_Camp_1_01_5,"DIA_GEN_COOL_TO_STRESS_TEAM_B_VOICE_B_2",false,100,1,1,"",95)
				end
			--------------------
			function Soldier_Salut()
				SetVarValue(_idChar_WRF_Camp_1_01_5,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_ANIM_SALUT"))
			CreationTimer(true, true, false, "Soldier_Pathway",8.0)
			end
			----------------------
			function Soldier_Pathway()
				EnableCharacterCommand(_idChar_WRF_Camp_1_Caporal,false)
				SetVarValue(_idChar_WRF_Camp_1_01_5,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_pathway_Peloton"))
				--CharacterPlaySpecialAction(_idChar_WRF_Camp_1_01_5,"STAND COMPLETE WAIT W_NONE COOL",true,false)
			CreationTimer(true, true, false, "Soldier_Wait",1.0)
			end
			---------------------
			function Soldier_Wait()
				--EnableCharacterCommand(_idChar_WRF_Camp_1_01_5,false)
				CharacterPlaySpecialAction(_idChar_WRF_Camp_1_Caporal,"STAND COMPLETE SHOW_MAP W_NONE",true,false)
				SetVarValue(_idChar_WRF_Camp_1_01_5,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_pathway_Peloton"))
			--	CharacterStopSpecialAction(_idChar_WRF_Camp_1_01_5)
				CreationTimer(true, true, false,"Soldier_Shoot",1.0)
			end
			---------------------
			function Soldier_Shoot()

				EnableCharacterCommand(_idChar_WRF_Camp_1_01_5,true)
				SetVarValue(_idChar_WRF_Camp_1_01_5,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Peloton"))
				CharacterStopSpecialAction(_idChar_WRF_Camp_1_Caporal)	
				SetVarValue(_idPlayer,"BodyHitPoints",50)
				CreationTimer(true, true, false,"Soldier_Stop_Shoot",0.8)
			end
			------------------
			function Soldier_Stop_Shoot()
				CharacterStopSpecialAction(_idChar_WRF_Camp_1_Caporal)
				SetVarValue(_idChar_WRF_Camp_1_01_5,"CharacterOrderList",GetInvalidEntityID())
				CharacterPlaySpecialAction(_idChar_WRF_Camp_1_01_5,"STAND COMPLETE WAIT W_NONE COOL",true,false)
				SetVarValue(_idChar_WRF_Camp_1_Caporal,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_wp_29"))
				--EnableCharacterCommand(_idPlayer,true)
				
				EnableCharacterCommand(_idChar_WRF_Camp_1_Caporal,true)
				CreationTimer(true, true, false,"Objectif_0_2_Cin5",3.0)
				
			end
			------------------
-----------------------------------------------------------------------------------------------------
--[[																		Objectif0_2_Cin2()

Lance Cinématique 2.
--]]
-----------------------------------------------------------------------------------------------------

function Objectif_0_2_Cin2()

			--LaunchCameraTransition(GetCamTransitionID("CamTransition_Obj_0_2_3"))


end


-----------------------------------------------------------------------------------------------------
--[[																		Objectif0_2_Cin3()

Lance Cinématique 3.
--]]
-----------------------------------------------------------------------------------------------------

function Objectif_0_2_Cin3()

			--LaunchCameraTransition(GetCamTransitionID("CamTransition_Obj_0_2_4"))
			--SetVarValue(GetWaypointID("Waypoint_Camp_1_27"),"StandingType","StandSecondary")
		--	EnableCharacterCommand(_idChar_WRF_Camp_1_Caporal,true)
		--	SetVarValue(_idAI_O_Fire_At_Position_Char_WRF_Caporal,"PriorityTorso",100)
			--SetVarValue(_idPlayer,"Team","UAN")
			--SetVarValue(GetTimerID("Timer_Char_WRF_Caporal_Shoot"),"Active",true)
		--	SetVarValue(_idPlayer,"BodyHitPoints",50)

end




-----------------------------------------------------------------------------------------------------
--[[																		Objectif0_2_Cin4()

Lance Cinématique 4.
--]]
-----------------------------------------------------------------------------------------------------

function Objectif_0_2_Cin4()

			EnableCharacterCommand(_idChar_WRF_Camp_1_Caporal,false)
			SetVarValue(_idAI_O_Fire_At_Position_Char_WRF_Caporal,"PriorityTorso",0)
			SetVarValue(GetWaypointID("Waypoint_Camp_1_27"),"StandingType","StandNormal")


end



-----------------------------------------------------------------------------------------------------
--[[																		Objectif0_2_Cin5()

Lance Cinématique 5.
--]]
-----------------------------------------------------------------------------------------------------

function Objectif_0_2_Cin5()
				ShowCinematicBlackStripes(false)
				CharacterStopSpecialAction(_idPlayer)
				EnableCharacterCommand(_idPlayer,true)
				EnableCharacterCommand(_idChar_WRF_Camp_1_Caporal,false)
				--

				CharacterStopSpecialAction(_idChar_WRF_Camp_1_Caporal)
				MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_A_07",true,110,1,2,"OrderCapo1",95)
				--CharacterPlaySpecialAction(_idChar_WRF_Camp_1_Caporal,"STAND COMPLETE TALK_NEAR W_ALL_2HAND_LIGHT",true,false)
				Objective_0_2_Active()
				NewSubObjective ("Obj_A_1", "Obj_A_2")
				CreationTimer(true, true, false, "End_Objectif_0_2_Cin5",4.0)
		--	SetVarValue(GetTimerID("Timer_Objective_0_2_Active"),"Active",true)
			
		--	EnableCharacterCommand(_idChar_WRF_Camp_1_Caporal,true)
--			SetVarValue(GetObjectiveID("Objective_Patrol_0_2"),"Active",true)
		--	LaunchCameraTransition(GetCamTransitionID("CamTransition-51"))
			
end

function OrderCapo1()
	SetVarValue(_idChar_WRF_Camp_1_Caporal,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_wp_28"))
	EnableCharacterCommand(_idChar_WRF_Camp_1_Caporal,true)
end

function End_Objectif_0_2_Cin5()
--	EnableCharacterCommand(_idPlayer,true)
	CharacterStopSpecialAction(_idPlayer)
	SetVarValue(_idChar_WRF_Camp_1_Caporal,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_wp_28"))
--	ShowCinematicBlackStripes(false)
	--EnableCharacterCommand(_idChar_WRF_Camp_1_Caporal,true)
	CreationTimer(true, true, false, "Tutorial_Tips_2",1)
end

-----------------------------------------------------------------------------------------------------
--[[																		Objectif0_2_Cin6()

Lance Cinématique 6.
--]]
-----------------------------------------------------------------------------------------------------

function Objectif_0_2_Cin6()

--			CamPointTargetCharacter(GetCamPointID("CamPoint_Obj_0_2_7"),_idPlayer)
--			CamPointTargetCharacter(GetCamPointID("CamPoint_Obj_0_2_8"),_idPlayer)
			LaunchCameraTransition(GetCamTransitionID("CamTransition_Obj_0_2_5"))

end


-----------------------------------------------------------------------------------------------------
--[[																		Objectif0_2_Done()

Fonction qui teste si le joueur a repris de la vie à la borne de reload.
--]]
-----------------------------------------------------------------------------------------------------

function Objectif_0_2_Done()

		if 	(GetVarValue(GetObjectiveID("Obj_A_2"),"Active")==true) and _bObj0_2 and (GetVarValue(_idPlayer,"BodyHitPoints")==100) and not _bObj0_2_done then
					SetVarValue(_idChar_WRF_Camp_1_Caporal,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_wp_28"))
					--EnableCharacterCommand(_idChar_WRF_Camp_1_Caporal,false)
--				DisplayObjective ( "HUD_OBJ_DONE", GetObjectiveID("Objective_Patrol_0_2"), 4, 5 )
--				SetVarValue(GetObjectiveID("Objective_Patrol_0_2"),"Completed",true)
--				SetVarValue(GetObjectiveID("Objective_Patrol_0_2"),"Active",false)
					NewSubObjective ("Obj_A_2", "Obj_A_3")
--				SetVarValue(GetWaypointID("Waypoint_Camp_1_27"),"Rotation",GetVarValue(GetWaypointID("Waypoint_Camp_1_28"),"Rotation"))
					_bObj0_2_done=true
					SetVarValue(GetTimerID("Timer_Camp_1_Radio_Tut"),"Active",false)
		end

end



function Perimeter_Player(id1, id2,per)
		_vPos1=GetVarValue(id1,"Position")
		_vPos2=GetVarValue(id2,"Position")
		if (_vPos1:GetX())<=(_vPos2:GetX()+per) and (_vPos1:GetX())>=(_vPos2:GetX()-per) and (_vPos1:GetY())<=(_vPos2:GetY()+per) and (_vPos1:GetY())>=(_vPos2:GetY()-per) then
				return true
		else
				return false
		end
end



-----------------------------------------------------------------------------------------------------
--[[																		Objectif0_4_Cin1()

Lance Cinématique 1 de l'objectif 0_4.
--]]
-----------------------------------------------------------------------------------------------------

function Objectif_0_4_Cin1()

			LaunchCameraTransition(GetCamTransitionID("CamTransition_Obj_0_4_2"))

			
end



------------------------------------------------------------------------------------------------------
--[[																	FindNolan()

Le bot irai chercher le joueur quand il en recevra l'ordre (_bFindNolan=true).
--]]
------------------------------------------------------------------------------------------------------

function FindNolan()

-- On teste dans quel périmètre se trouve le joueur se trouve de Char_WRF_Camp_1_01_3

-- _bPP_30: Booléen qui renvoie true si le joueur et Char_WRF_Camp_1_01_3 sont à 3m l'un de l'autre.
		_bPP_30=Perimeter_Player(_idPlayer, _idChar_WRF_Camp_1_01_3,30)	

-- _bPP_30: Booléen qui renvoie true si le joueur et Char_WRF_Camp_1_01_3	sont à 10m l'un de l'autre.		
		_bPP_100=Perimeter_Player(_idPlayer, _idChar_WRF_Camp_1_01_3,100)

-- Si Char_WRF_Camp_1_01_3 a trouvé le joueur et qu'il se trouve à 3m au maximum, qu'il ne l'a pas déjà
-- effectué l'action (_bTestP_30), qu'il a reçu l'ordre d'aller le chercher (_bFindNolan) et que le Pj
-- n'est déjà pas venu le chercher (_bDialCap_1) alors:
		if _bPP_30 and not _bTestP_30 and _bFindNolan and not _bDialCap_1 then
--	1: Phrase affichée pendant 3s
--				DisplaySubtitle("Nolan, ça presse, suivez-moi, je vous débloque l'accès Nord!",2,3)
		--		MakeCharacterSpeak(_idChar_WRF_Camp_1_01_3,_idPlayer,"DIA_SPE_NIV_D_CAPORAL_02",true,110,1,2,"",100)
--	2: On active un timer de 3s, donc à la fin de la phrase le joueur va effectuer l'action déclencher
-- 		 par le timer: GoAccesNord(). 
				SetVarValue(_idTimer_Camp_1_03,"Active",true)				
				_bTestP_30=true
		end

-- Si Char_WRF_Camp_1_01_3 a trouvé le joueur et qu'il se trouve à 10m au maximum, qu'il ne l'a pas déjà
-- effectué l'action (_bTestP_100), qu'il a reçu l'ordre d'aller le chercher (_bFindNolan) et que le Pj
-- n'est déjà pas venu le chercher (_bDialCap_1) alors:
		if _bPP_100 and not _bTestP_100 and _bFindNolan and not _bDialCap_1 then
--				DisplaySubtitle("Nolan!!!",1,2)	
				MakeCharacterSpeak(_idChar_WRF_Camp_1_01_3,_idPlayer,"DIA_SPE_NIV_D_CAPORAL_03",true,110,2,2,"",98)	
				_bTestP_100=true
		end

end



------------------------------------------------------------------------------------------------------
--[[																	GoAccesNord()

Le bot a trouvé le joueur. Il l'emmène vers l'entrée (AI_O_Goto_Waypoint_Char_WRF_Camp_1_01_3).
--]]
------------------------------------------------------------------------------------------------------

function GoAccesNord()

		--
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_WRF_Camp_1_01_3"),"PriorityLegs",100)
--		DisplaySubtitle("Allons-y sans plus tarder!",2,3)
		MakeCharacterSpeak(_idChar_WRF_Camp_1_01_3,_idPlayer,"DIA_SPE_NIV_D_CAPORAL_04",true,110,1,2,"",98)
						
		CharacterPlaySpecialAction(_idChar_WRF_Camp_1_01_3,"STAND MEDHI ORDER_FOLLOW_ME W_NONE",true,false)
			CreationTimer(true, true, false, "Stop_Come_on",1.5)	
		_bGoAccesNord=true

end
	function Stop_Come_on()
		CharacterStopSpecialAction(_idChar_WRF_Camp_1_01_3)		
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_WRF_Camp_1_01_3"),"PriorityTorso",100)
	end

------------------------------------------------------------------------------------------------------
--[[																	Assaut()

Le bot a reçu l'ordre d'aller chercher le joueur (_bFindNolan=true), 
cela se traduit par l'augmentation de la priorité du AI_O_Follow_Player.

------------------------------------------------------------------------------------------------------

function Assaut()

		Freeze(_idChar_WRF_Camp_1_01_3,false)
		SetVarValue(_idAI_O_Follow_Player,"PriorityTorso",25)
		SetVarValue(_idAI_O_Follow_Player,"PriorityLegs",45)
		_bFindNolan=true

end

--]]

------------------------------------------------------------------------------------------------------
--[[																	AssaultBegin()

Lancement de l'assaut:
	- La porte explose.
	- On defreeze la première vague (Grp_UAN_Camp_1_1).
	- On instancie la variable "_bDejaCamp_1_B_01" à true pour indiquer que l'assaut a démarré.
--]]
------------------------------------------------------------------------------------------------------

function AssaultBegin()

-- Explosion de la porte:
		_idExplosionC1 = CreateExplosion()
		SetVarValue(_idExplosionC1,"Position",Vector3D(-(1195.5),779,18))
		SetVarValue(_idExplosionC1,"Type","Explosion_Rocket_Tank")
		SetVarValue(GetSound_ClientID("Sound_Client_Explosion_1"),"Playing",true)
		UnLockDoor(GetDoorID("Door_Camp_1_1"))
		ReleaseEntity(GetDoorID("Door_Camp_1_1"))
		--ReleaseEntity(GetDoorID("Door_Camp_1_2"))
		SetVarValue(GetParticleFX_ClientID("FX_Acces_Nord_1"),"FxState","Fx Started")
		SetVarValue(GetParticleFX_ClientID("FX_Acces_Nord_2"),"FxState","Fx Started")
		SetVarValue(GetParticleFX_ClientID("FX_Acces_Nord_3"),"FxState","Fx Started")
		SetVarValue(GetParticleFX_ClientID("FX_Acces_Nord_5"),"FxState","Fx Started")
		SetVarValue(GetParticleFX_ClientID("FX_Acces_Nord_6"),"FxState","Fx Started")
		CreationTimer(true,true,false,"Music_war",2.0)
-- Vague n°1:
		--FreezeAll(_idGrp_UAN_Camp_1_1,false)
		FreezeAll(_idGrp_UAN_Camp_1_3,false)
		_bDejaCamp_1_B_01=true

		SetVarValue(GetAI_Order_Forbid_ZoneID("AI_O_Forbid_Zone_Camp_3"),"PriorityLegs",100)

			if (_idMerc[0] ~= nil) then 
				SetVarValue(_idMerc[0],"CharacterOrderList",GetInvalidEntityID())
			end
			if (_idMerc[1] ~= nil) then 
				SetVarValue(_idMerc[1],"CharacterOrderList",GetInvalidEntityID())
			end
end

function Music_war()

	StartMusic("Sounds//Music//Bos - War theme.wav",true)
end

--------------------------------------------------------------------------------------------------------
--[[																		RenfortUAN()

Concerne les renforts pour l'UAN. Il y a 5 vagues d'assauts.
Ces vagues sont définis par ordre décroissant, pour être sur de respecter un certain ordre de défreezadin:
Grp_UAN_Camp_1_1 -> Grp_UAN_Camp_1_3 -> Grp_UAN_Camp_1_4 -> Grp_UAN_Camp_1_2 -> Grp_UAN_Camp_1_5
On teste à chaque 2 possibilités:
	- Soit il y a assez de mort pour défreezer en fonction du nombre de bot actif.
	- Soit le groupe a été suffisamment décimé pour envoyer la suite, pour ne pas couper l'assaut en cas extrème.
	- On teste aussi si la précedente vague a été defreezé, et si l'on a pas déjà défreezé celle-ci.
--]]
--------------------------------------------------------------------------------------------------------

function RenfortUAN()

--[[ Vague n°5:
		if (_nBotActive<=8) and not _bRenfOk3 then
				FreezeAll(_idGrp_UAN_Camp_1_5,false)				
--				DisplaySubtitle("Revenez par ici, Nolan!!!",2,4)
			--	MakeCharacterSpeak(_idChar_WRF_Camp_1_Garde,_idPlayer,"DIA_SPE_NIV_D_WRF_A_02",true,110,1,2,"",100)
				_bRenfOk3=true
		end
--]]
-- Vague n°4: On notera que celle-ci est accompagné de l'explosion de la porte, et du défreezage de renfort WRF.
--		if ((_nBotActive<=8) or (AliveMembersCountPct(_idGrp_UAN_Camp_1_4)<=50))  and not _bRenfortUANOk and _bRenfOk2 and _bRenfOk1 then 

		-- Explosion de la porte:
				--_idExplosionC2 = CreateExplosion()
				--SetVarValue(_idExplosionC2,"Position",Vector3D(-(1649),605,18))
				--SetVarValue(_idExplosionC2,"Type","Explosion_Rocket_A")
				--SetVarValue(GetParticleFX_ClientID("FX_Acces_Nord_4"),"FxState","Fx Started")
				--SetVarValue(GetSound_ClientID("Sound_Client_Explosion_2"),"Playing",true)
				--OpenDoor(GetDoorID("Door_Ouest"))
				--SetVarValue(GetParticleFX_ClientID("FX_Acces_Ouest_1"),"FxState","Fx Started")
				--SetVarValue(GetParticleFX_ClientID("FX_Acces_Ouest_2"),"FxState","Fx Started")

		-- Deffreezage de groupes UAN et WRF:
		--		FreezeAll(_idGrp_UAN_Camp_1_2,false)
--				FreezeAll(_idGrp_WRF_Camp_1_4,false)
--				DisplaySubtitle("Ils arrivent aussi par l'ouest! Nolan! Occupez vous en!",2,4)
--				MakeCharacterSpeak(_idChar_WRF_Camp_1_Garde,_idPlayer,"DIA_SPE_NIV_D_WRF_A_03",true,110,2,1,"",100)	
--				_bRenfortUANOk=true
--		end

-- Vague n°3:
		if ((_nBotActive<=8) or (AliveMembersCountPct(_idGrp_UAN_Camp_1_3)<=50)) and not _bRenfOk2 and _bRenfOk1 then
				FreezeAll(_idGrp_UAN_Camp_1_4,false)				
				_bRenfOk2=true
		end

-- Vague n°2:
		if ((_nBotActive<=8) or (AliveMembersCountPct(_idGrp_UAN_Camp_1_1)<=25)) and _bDejaCamp_1_B_01 
		and AliveMembersCount(_idGrp_UAN_Camp_1_1)<=3 and not _bRenfOk1 then
				FreezeAll(_idGrp_UAN_Camp_1_3,false)
				_bRenfOk1=true				
		end

end



--------------------------------------------------------------------------------------------------------
--[[																		Renfort()

Concerne les renforts pour la WRF. Dès qu'il ne reste plus qu'un nombre de bots WRF (3), et que le joueur 
se trouve pas dans le champ de visibilité du spawn, défreezadin de deux bots:
	- Char_WRF_Camp_1_1 et Char_WRF_Camp_1_01_4.
Et on leur donne l'ordre de rejoindre la bataille en augmentant la priorité du 
Goto_Waypoint_Grp_UAN_Camp_1_Assaut1
--]]
--------------------------------------------------------------------------------------------------------

function Renfort()

		if (AliveMembersCount(_idGrp_WRF_Camp_1_1)<=3) and not IsEntityInBox(_idPlayer, "SE_Camp_1_B_10")
		and not IsEntityInBox(_idPlayer, "SE_Camp_1_B_11") and not IsEntityInBox(_idPlayer, "SE_Camp_1_B_12") 
		and not _bRenfortOk then 
				Freeze(_idChar_WRF_Camp_1_1,false)
				Freeze(_idChar_WRF_Camp_1_01_4,false)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Grp_UAN_Camp_1_Assaut1"),"PriorityTorso",25)
				SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Grp_UAN_Camp_1_Assaut1"),"PriorityLegs",35)
				_bRenfortOk=true
--				DisplaySubtitle("DIA_GEN_WRF_42",2,2)
--				MakeCharacterSpeak(_idChar_WRF_Camp_1_01_4,"DIA_GEN_WRF_42",true,2)
		end

end



--------------------------------------------------------------------------------------------------------
--[[																		SceneAssault()

Le bot Char_WRF_Camp_1_01_3 est venu chercher le joueur il se dirige donc vers le porte d'entrée...
Dés que le bot arrive près de la porte (IsEntityInBox(_idChar_WRF_Camp_1_01_3, "SE_Camp_1_Acces1")) et
que le joueur peut assister à la scène (IsEntityInBox(_idPlayer, "SE_Camp_1_Acces2")), début de l'assaut
(AssaultBegin()).
--]]
--------------------------------------------------------------------------------------------------------

function SceneAssault()
	if --[[IsEntityInBox(_idPlayer, "SE_Camp_1_Acces2") and--]] IsEntityInBox(_idChar_WRF_Camp_1_01_3, "SE_Camp_1_Acces1") 
		and not _bAssaultScene then
					AssaultBegin()
					_bAssaultScene=true
		end
end



function SceneAssaultB()
	if not _bAssaultScene then
					AssaultBegin()
					_bAssaultScene=true
		end
end
-----------------------------------------------------------------------------------------------------
--[[																		AssaultEnd()

Regarde si l'assaut UAN est terminé, si oui, retour à l'état normal.
--]]
-----------------------------------------------------------------------------------------------------

function AssaultEnd()
-- Teste le nombre de bots UAN vivants, s'ils sont tous mort, retour à l'état normal.
		_nBotUANAlive=(AliveMembersCount(_idGrp_UAN_Camp_1_2)+AliveMembersCount(_idGrp_UAN_Camp_1_3)+AliveMembersCount(_idGrp_UAN_Camp_1_4)+AliveMembersCount(_idGrp_UAN_Camp_1_5))
	--	_nBotUANAlive=(AliveMembersCount(_idGrp_UAN_Camp_1_1)+AliveMembersCount(_idGrp_UAN_Camp_1_2)+AliveMembersCount(_idGrp_UAN_Camp_1_3)+AliveMembersCount(_idGrp_UAN_Camp_1_4)+AliveMembersCount(_idGrp_UAN_Camp_1_5))
		if _nBotUANAlive==0 and not _bDejaMort then
				EtatNormal()
				_bDejaMort=true
		end
end



-----------------------------------------------------------------------------------------------------
--[[																		EtatNormal()

L'assaut est fini, la voie est dégagée: 2 persos, s'ils sont vivants partent dans les tranchées:
Passage à 50 de la priorité du Goto_Waypoint_Char_WRF_Camp_1_1.
PNJs concernés: Char_WRF_Camp_1_1, Char_WRF_Camp_1_Garde.
On leur donne aussi 2 pts de vie.
--]]
-----------------------------------------------------------------------------------------------------

function EtatNormal()
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_WRF_Camp_1_1"),"PriorityTorso",50)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_WRF_Camp_1_1"),"PriorityLegs",50)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_WRF_Camp_1_1_Trench"),"PriorityTorso",26)
		SetVarValue(GetAI_Order_Goto_WaypointID("AI_O_Goto_Waypoint_Char_WRF_Camp_1_1_Trench"),"PriorityLegs",26)
		SetVarValue(GetAI_Order_Forbid_ZoneID("AI_O_Forbid_Zone_Camp_3"),"PriorityLegs",0)
--		DisplaySubtitle("La voie est libre!",2,4)	
		if IsAlive(_idChar_WRF_Camp_1_1) or IsAlive(_idChar_WRF_Camp_1_Garde) then
				MakeCharacterSpeak(_idChar_WRF_Camp_1_Garde,_idPlayer,"DIA_SPE_NIV_D_WRF_A_04",true,110,2,1,"",100)
				SetVarValue(_idChar_WRF_Camp_1_1,"Health",2)
				SetVarValue(_idChar_WRF_Camp_1_Garde,"Health",2)
		end
end



-----------------------------------------------------------------------------------------------------
--[[																		PostFightCamp_1()

Fonction qui redonne vie un camp: De nouveaux bots apparaissent, dans la cour et les 2 batiments, sachant
que le deuxième est maintenant ouvert. Ils apparaissent selon la position du joueur pour ne pas être vus,
et selon aussi le nombre de bot actif.
bots concernés: _idChar_WRF_Camp_1_02_1, _idChar_WRF_Camp_1_02_2 et _idChar_WRF_Camp_1_02_3.
On donne un nouveau l'ordre à un soldat venu en renfort: _idChar_WRF_Camp_1_1.
--]]
-----------------------------------------------------------------------------------------------------

function PostFightCamp_1()
-- _bDejaMort signale que tout les ennemis sont mort, l'assaut est terminé.
		if _bDejaMort then
				if not IsEntityInBox(_idPlayer, "SE_Camp_1_B_10") and not IsEntityInBox(_idPlayer, "SE_Camp_1_B_11") 
				and not IsEntityInBox(_idPlayer, "SE_Camp_1_B_12") and _nBotActive<=7 and not _bPFC1_1 and not _bFreezeWRF2 then
						Freeze(_idChar_WRF_Camp_1_02_1,false)
						Freeze(_idChar_WRF_Camp_1_02_2,false)
						_bPFC1_1=true
				end
				if not IsEntityInBox(_idPlayer, "SE_Camp_1_B_06") and not IsEntityInBox(_idPlayer, "SE_Camp_1_B_13") 
				and not IsEntityInBox(_idPlayer, "SE_Camp_1_B_14") and _nBotActive<=9 and not _bPFC1_2 and not _bFreezeWRF2 then
						Freeze(_idChar_WRF_Camp_1_02_3,false)
						_bPFC1_2=true
				end
				if IsAValidID(_idChar_WRF_Camp_1_1) and not _bOrder then
						SetVarValue(_idChar_WRF_Camp_1_1,"CharacterOrderList",GetAI_Order_ListID("AI_O_List_Spe_WRF_Garde")) 
						_bOrder=true
				end
		end
end



-----------------------------------------------------------------------------------------------------
--[[																		ObjectiveRappel()

Rappel au joueur de se bouger le cul d'accomplir ces putains d'objectifs du tutorial.
--]]
-----------------------------------------------------------------------------------------------------

function ObjectiveRappel()

		if (GetVarValue(GetObjectiveID("Obj_A_1"),"Active") or GetVarValue(GetObjectiveID("Obj_A_2"),"Active")
		or GetVarValue(GetObjectiveID("Obj_A_3"),"Active") or GetVarValue(GetObjectiveID("Obj_A_4"),"Active")
		or GetVarValue(GetObjectiveID("Obj_A_5"),"Active")or GetVarValue(GetObjectiveID("Obj_A_6"),"Active"))
		and not _bRadio01 then
				MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_RADIO_A_01",true,100,1,2,"",100)
				_bRadio01=true
		else 
				MakeCharacterSpeak(_idChar_WRF_Camp_1_Caporal,_idPlayer,"DIA_SPE_NIV_D_OFFICER_RADIO_A_02",true,100,1,2,"",100)
				_bRadio01=false
		end

end