function UpdateLevel_HUBER()
end
----------------------------------------------------------------------
-----------------------------------------------------------------------------
---::::::::::::::::::::::::--Parcours du Colonel Huber :::::::::::::::::::::::
-----------------------------------------------------------------------------

---la boite dans l'entrepot lu ifait dire "suis moi" et il va sur la colline, on le track comme objectif
function OnEnter_Sector_Event_0(id)

_idTimer_Huber_Go=GetTimerID("Timer_Huber_Go")

	if(_bOnEnter_Sector_Event_0==0)then
		if(id==_idPlayer)then
				MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_19",true,100,2,0.0,"",100.0)	
				CharacterPlaySpecialAction(_idMerc[0],"STAND MEDHI ORDER_FOLLOW_ME W_NONE",true,false)
				CreationTimer(true,true,false,"Huber_anim_stop_follow",3.8)
				SetVarValue(_idTimer_Huber_Go,"Active",true)
				MiniMapTrack(_idMerc[0],2,true)			
				NewObjectiveNewSubObjective ("Obj_1","Obj_1_1")	
				SetVarValue(GetObjectiveID("Obj_1_3"),"Active",true)
		_bOnEnter_Sector_Event_0=1
		end			
	end
end
						-----------------------------
					function Huber_anim_stop_follow()
						CharacterStopSpecialAction(_idMerc[0])
					end
						----------------------------
function OnExit_Sector_Event_0(id)
		if(_bOnExit_Sector_Event_0==0)then
				if(id==_idChar_HANG)then
					_bWasHang=true
					_bOnExit_Sector_Event_0=1
				end
		end
end
						--------------------------
--Quand le joueur arrive sur la colline il rentre dans la boite "Game" quii active un timer qui renvoie à la fonction
-- si dessous : le colonel va au fond du rempart de droite et fire at position.
 
function Huber_Move()

_idAI_Order_Goto_Waypoint_Huber_colline_2=GetAI_Order_Goto_WaypointID("AI_Order_Goto_Waypoint_Huber_colline_2")
_idAI_Order_Fire_At_Position_sniper_SYND_05=GetAI_Order_Fire_At_PositionID("AI_Order_Fire_At_Position_sniper_SYND_05")
_idAI_Order_List_Huber=GetAI_Order_ListID("AI_Order_List_Huber")

	SetVarValue(_idAI_Order_List_Huber,"Order",_idAI_Order_Goto_Waypoint_Huber_colline_2,2)
	SetVarValue(_idAI_Order_List_Huber,"Order",_idAI_Order_Fire_At_Position_sniper_SYND_05,3)
end
					--------------------------

--Quand l'exo_A entre 100 et 300 de points de vie il va a colline_3
function Mort_Snip_05()

_nHealth_EXO_A=GetVarValue(GetExoskeletonID("Exoskeleton_1"),"Health")
_idAI_Order_Goto_Waypoint_Huber_colline_3=GetAI_Order_Goto_WaypointID("AI_Order_Goto_Waypoint_Huber_colline_3")
_idAI_Order_Fire_At_Position_sniper_SYND_04=GetAI_Order_Fire_At_PositionID("AI_Order_Fire_At_Position_sniper_SYND_04")
_idAI_Order_List_Huber=GetAI_Order_ListID("AI_Order_List_Huber")

		if(_bMort_Snip_05==0)then
			if(_nHealth_EXO_A<=1200)and(_nHealth_EXO_A>=900)then
			Freeze(_idChar_SYND_02,false)
			SetVarValue(_idAI_Order_List_Huber,"Order",_idAI_Order_Goto_Waypoint_Huber_colline_3,2)
			SetVarValue(_idAI_Order_List_Huber,"Order",_idAI_Order_Fire_At_Position_sniper_SYND_04,3)
			_bMort_Snip_05=1
		end
	end
end
					--------------------------

--Quand l'exo_C entre 100 et 300 de points de vie il va a colline_4
function Mort_Snip_04()

_nHealth_EXO_C=GetVarValue(GetExoskeletonID("Exoskeleton_3"),"Health")
_idAI_Order_Goto_Waypoint_Huber_colline_4=GetAI_Order_Goto_WaypointID("AI_Order_Goto_Waypoint_Huber_colline_4")
_idAI_Order_Fire_At_Position_sniper_SYND_02=GetAI_Order_Fire_At_PositionID("AI_Order_Fire_At_Position_sniper_SYND_02")
_idAI_Order_List_Huber=GetAI_Order_ListID("AI_Order_List_Huber")

	if(_bMort_Snip_04==0)then
		if(_nHealth_EXO_C<=1200)and(_nHealth_EXO_C>=900)then	
			SetVarValue(_idMerc[0],"CurrentSlot","TwoHded")
			Freeze(_idChar_SYND_02,false)
			SetVarValue(_idAI_Order_List_Huber,"Order",_idAI_Order_Goto_Waypoint_Huber_colline_4,2)
			SetVarValue(_idAI_Order_List_Huber,"Order",_idAI_Order_Fire_At_Position_sniper_SYND_02,3)
			_bMort_Snip_04=1
		end
	end
end
					--------------------------
---Déclenche le message Radio "suis moi" puis 
function Dial_Steal()

		RadioMessage("DIA_SPE_NIV_O_HUBER_D_03",true,100,0.0,"")
		--CharacterPlaySpecialAction(_idMerc[0],"STAND MEDHI ORDER_FOLLOW_ME W_NONE",true,false)
	_bDial_Steal=true	

end

					-------------------------------

					---------------------------

--Quand tous les exos sont morts, il demande de le suivre et fais un pathway

function Huber_Passage()

_nHealth_EXO_A=GetVarValue(GetExoskeletonID("Exoskeleton_1"),"Health")
_nHealth_EXO_B=GetVarValue(GetExoskeletonID("Exoskeleton_2"),"Health")
_nHealth_EXO_C=GetVarValue(GetExoskeletonID("Exoskeleton_3"),"Health")

_idAI_Order_List_Huber=GetAI_Order_ListID("AI_Order_List_Huber")
_idAI_Order_Play_Animation_127=GetAI_Order_Play_AnimationID("AI_Order_Play_Animation_127")
_idAI_Order_Use_Pathway_AVT_Passage=GetAI_Order_Use_PathwayID("AI_Order_Use_Pathway_AVT_Passage")


	if(_bHuber_Passage==0)then
		if((_nHealth_EXO_A==0)and(_nHealth_EXO_B==0)and(_nHealth_EXO_C==0))and(_bDial_Steal==true)then
			SetVarValue(_idAI_Order_List_Huber,"Order",_idAI_Order_Use_Pathway_AVT_Passage,2)
			SetVarValue(_idAI_Order_List_Huber,"Order",GetInvalidEntityID(),3)
			StartMusic("Sounds//Music//Bos - South theme.wav",true)
			_bHuber_Passage=1
		end
	end
end
					------------------------------------------------

--Quand le dial est lancé que le joueur est dans la boite et que Huber aussi alors lance camera et enleve les commande sau joueur
-- 
function OnEnter_Sector_Event_Check_Dial(id)

_idCamTransition_dial=GetCamTransitionID("CamTransition_dial")

	if(_bonEnter_Sector_Event_Check_Dial==0)and(_bDial_Steal==true)and(IsEntityInBox(_idPlayer,"Sector_Event_Check_Dial"))and(IsEntityInBox(_idMerc[0],"Sector_Event_Check_Dial"))then
		CharacterPlaySpecialAction(_idMerc[0],"STAND COMPLETE WAIT W_ALL_2HAND_HEAVY COOL",true,false)
		MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_RESIS_A_RADIO_4",true,100,2,0.0,"Huber_Gallery",100.0)		--RadioMessage("DIA_SPE_NIV_O_RESIS_A_RADIO_4",true,100,0.0,"")
		SetVarValue(_idMerc[0],"CharacterAI",GetCharacter_AIID("Character_AI_ZEN"))
		EnableCharacterCommand(_idPlayer,false)
		LaunchCameraTransition(_idCamTransition_dial,true)
		Teletransportation("Char_REPERE",_idPlayer)
		SetGodMode(_idMerc[0],true)
		if(_idMerc[1]~=nil)then
		SetGodMode(_idMerc[1],true)
		end
		SetGodMode(_idPlayer,true)
		ShowCinematicBlackStripes(true)
		_bonEnter_Sector_Event_Check_Dial=1
	end
end
						-------------------------------------------
--huber se dirige vers la porte du BOYAU

function Huber_Gallery()

_idAI_Order_List_Huber=GetAI_Order_ListID("AI_Order_List_Huber")
_idAI_Order_Goto_Waypoint_grenadier_2=GetAI_Order_Goto_WaypointID("AI_Order_Goto_Waypoint_grenadier_2")

			EnableCharacterCommand(_idPlayer,true)
			Freeze(_idChar_RES_ENGINEER_00_1,false)
			CharacterStopSpecialAction(_idMerc[0])
			EnableCharacterCommand(_idChar_RES_ENGINEER_00_1,false)
			SetVarValue(_idAI_Order_List_Huber,"Order",_idAI_Order_Goto_Waypoint_grenadier_2,2)
			SetVarValue(_idAI_Order_List_Huber,"Order",GetInvalidEntityID(),3)
			if(_idMerc[1]~=nil)then
			SetGodMode(_idMerc[1],false)
			end
			SetGodMode(_idPlayer,false)
			ShowCinematicBlackStripes(false)			
end
						----------------------------------------------
						----------------------------------------------
--Si au bout de 240 secondes(4 minutes), l'EXO A (exo1) n'a pas été buté alors on enleve le god mode de Huber, et l'exo s'occupe de lui
	
function EXO_A_VS_HUBER()

_idAI_Order_List_EXO_A=GetAI_Order_ListID("AI_Order_List_EXO_A")


	if(_bEXO_A_VS_HUBER==0)then
		if(IsAlive(_idChar_SYND_Exoman_01,true))then
		SetGodMode(_idMerc[0],false)
		--SetVarValue(_idAI_Order_List_EXO_A,"Order",GetInvalidEntityID(),7)
		--SetVarValue(_idAI_Order_List_EXO_A,"Order",GetAI_Order_Force_TargetID("AI_Order_Force_Target_HUBER"),3)
		_bEXO_A_VS_HUBER=1
		elseif not(IsAlive(_idChar_SYND_Exoman_01,true))then
			_bEXO_A_VS_HUBER=1
		end
	end
end
							--------------------------------------
							--------------------------------------
function Cpar_la()
	if(_bCpar_la==0)then
		if(IsEntityInBox(_idPlayer,"Sector_Event_WAY")and IsEntityInBox(_idMerc[0],"Sector_Event_WAY"))then
			CharacterPlaySpecialAction(_idChar_RES_ENGINEER_00_1,"STAND COMPLETE MILITARY_SALUT W_ALL_2HAND_LIGHT",true,false)
			MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_O_HUBER_D_06",true,100,2,0.0,"Cpar_la_suite",95.0)
			--CharacterPlaySpecialAction(_idMerc[0],"STAND MEDHI ORDER_THIS_WAY W_NONE",true,false)
			SetVarValue(_idMerc[0],"CharacterAI",GetCharacter_AIID("Character_AI_ZEN"))
			
			_bCpar_la=1
		end
	end
end
----------------------------------------------------------
function Cpar_la_suite()
_idTimer_huber_gallery_1=GetTimerID("Timer_huber_gallery_1")
_idDoor_porte_boyau1=GetDoorID("Door_porte_boyau1")
_idDoor_porte_boyau=GetDoorID("Door_porte_boyau")
	
	SetVarValue(_idTimer_huber_gallery_1,"Active",true)
	MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_GEN_MERCE_STOP_VOICE_A_3",true,100,2,0.0,"",100.0)
	CharacterPlaySpecialAction(_idMerc[0],"STAND COMPLETE WAIT W_ALL_2HAND_HEAVY COOL",true,false)
	CharacterStopSpecialAction(_idChar_RES_ENGINEER_00_1)
	UnLockDoor(_idDoor_porte_boyau1,true)
	OpenDoor(_idDoor_porte_boyau1,true)
	UnLockDoor(_idDoor_porte_boyau,true)
	OpenDoor(_idDoor_porte_boyau,true)
	NewSubObjective("Obj_2_1","Obj_2_2")
	MiniMapTrack(_idExoskeleton_4,2,true)
	MiniMapTrack(_idMerc[0],2,false)
end
-------------------------------------------------------
function Huber_Gallery_1()

_idAI_Order_List_Huber=GetAI_Order_ListID("AI_Order_List_Huber")
_idAI_Order_Goto_Waypoint_grenadier_3=GetAI_Order_Goto_WaypointID("AI_Order_Goto_Waypoint_grenadier_3")
	if(_bHuber_Gallery_1==0)then
				EnableCharacterCommand(_idChar_RES_ENGINEER_00_1,true)
				CharacterStopSpecialAction(_idMerc[0])
				SetGodMode(_idChar_RES_ENGINEER_00_1,true)
			SetVarValue(_idAI_Order_List_Huber,"Order",_idAI_Order_Goto_Waypoint_grenadier_3,2)
			SetVarValue(_idAI_Order_List_Huber,"Order",GetInvalidEntityID(),3)
		_bHuber_Gallery_1=1
	end
end

-------------------------------------------------------
function Block_Grotte()

	if(_bBlock_Grotte==0)then
		if(IsEntityInBox(_idMerc[0],"Sector_Event_grotte"))then
			EnableCharacterCommand(_idMerc[0],false)
			SetVarValue(_idMerc[0],"Position",Vector3D(-1042.721069,303.235809,35.780048))
			SetVarValue(_idMerc[0],"Rotation",Vector3D(0.000000,0.000000,-1.583185))
			_bBlock_Grotte=1
		end
	end

	if(_bBlock_Grotte_Player==0)then
		if(IsEntityInBox(_idPlayer,"Sector_Event_grotte"))then
			if (_bOnDeath_Tank_SYND_01 == 1)then
				EnableCharacterCommand(_idMerc[0],true)
				_bBlock_Grotte_Player=1
			end
		end
	end
end 


-----------------------------------------------------------------------------
---:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
---:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-----------------------------------------------------------------------------