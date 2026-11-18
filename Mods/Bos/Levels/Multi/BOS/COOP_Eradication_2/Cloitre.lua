function UpdateLevel_Cloitre()
end
----------------------------------------------------
--defreeze ennmis , régler par un timer.
--donne l'illusion qu'il n'y apersonne 
function Debut()
	if(_bDebut==0)then
		Freeze(_idChar_RES_1FLOOR_19,false)
		Freeze(_idChar_RES_1FLOOR_20,false)
		Freeze(_idChar_RES_1FLOOR_21,false)
		Freeze(_idChar_RES_1FLOOR_22,false)
		--SetVarValue(_idChar_SYND_allie_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_allie_4"))
	--	SetVarValue(_idChar_SYND_allie_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_allie_2"))
		_bDebut=1
		_bTime30=0
	end
end
-------------------------------------------------------------------------------
------------------------------------------
function Embush() 

_idDoor_start=GetDoorID("Door-55")

	if(_bEmbush==0)then
		if IsDoorOpened(_idDoor_start)then
			--MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_N_INGENIEUR_A_08",true,100,2,0.0,"",100)
			StartMusic("Sounds//Music//BoS - Eradication theme.wav",true)
			_bEmbush=1
		end
	end
end
----------------------------------
-----------------------------------------------------------------------------
---defreeeze ennemi à la mort d'un gars (19)
function Renforts_terrasse()

_bAliveChar_RES_1FLOOR_19=IsAlive(_idChar_RES_1FLOOR_19)

	if(_bRenforts_terrasse==0)then
		if(_bAliveChar_RES_1FLOOR_19==false)then
			Freeze(_idChar_RES_1FLOOR_28,false)
			_bRenforts_terrasse=1
		end
	end
end
----------------------------------------------------------------------------
---defreeeze ennemi à la mort d'un gars (20)
function Renforts_terrasse_1()

	_bAliveChar_RES_1FLOOR_20=IsAlive(_idChar_RES_1FLOOR_20)

	if (_bRenforts_terrasse_1==0) then
		if(_bAliveChar_RES_1FLOOR_20==false)then
			Freeze(_idChar_RES_1FLOOR_29,false)
			_bRenforts_terrasse_1=1
		end
	end
end
-----------------------------------------------------------------------------
---defreeeze ennemi à la mort d'un gars (19 ou 21)
function Renforts_terrasse_2()

		_bAliveChar_RES_1FLOOR_21=IsAlive(_idChar_RES_1FLOOR_21)
		_bAliveChar_RES_1FLOOR_22=IsAlive(_idChar_RES_1FLOOR_22)

	if (_bRenforts_terrasse_2==0) then
		if(_bAliveChar_RES_1FLOOR_21==false)or(_bAliveChar_RES_1FLOOR_19==false)then
			Freeze(_idChar_RES_1FLOOR_30,false)
			_bRenforts_terrasse_2=1
		end
	end
end
----------------------------------------------------------------------------

----------------------------------------------------------------------------

--------------------------------------------------------------------------
--donne l'ordre follow aux mercenaires,defreeze des ennemis
function OnEnter_Sector_Event_suite_allies(id)

	if(_bOnEnter_Sector_Event_suite_allies==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_suite_allies)and(_nActifBots<=8)then
			
			--SetVarValue(_idChar_SYND_allie_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_follow_player"))
			--SetVarValue(_idChar_SYND_allie_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_follow_player"))
			Freeze(_idChar_RES_RDC_01_15,false)
			Freeze(_idChar_RES_RDC_01_7,false)
			Freeze(_idChar_RES_1FLOOR_16,false)
			Freeze(_idChar_RES_RDC_01_8,false)
			_byetOnEnter_Sector_Event_suite_allies=true
			_bOnEnter_Sector_Event_suite_allies=1
		end
	end
end
------------------------------------------------------
--affiche message
function OnEnter_Sector_Event_shift(id)

	if(_bOnEnter_Sector_Event_shift==0) then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_shift) then
			MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_N_INGENIEUR_A_01",true,95,2,1,"",100)
			_bDebut=0
			NewObjectiveNewSubObjective("Obj_E","Obj_E_1")
			_byetOnEnter_Sector_Event_shift=true
			_bOnEnter_Sector_Event_shift=1
		end
	end
end
---------------------------------------------------------
------------------------------------------------------------
--declenche le timer {Debut}fais parler l'ingénieur.en sortant de la piece de depart.
function OnExit_Sector_Event_shift(id)

	if(_bOnExit_Sector_Event_shift==0)then
		
		if(GetLocalCharacterID("Player")==id)and(_bOnEnter_Sector_Event_shift==1)and not(_byetOnExit_Sector_Event_shift)then
			MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_N_INGENIEUR_A_03",true,95,2,0.0,"",100)
			_byetOnExit_Sector_Event_shift=true
			_bOnExit_Sector_Event_shift=1
		end
	end
end
-----------------------------------------------------------------------
--affcihe message
function OnEnter_Sector_Event_limit_zone_allie_1(id)

	if(_bOnEnter_Sector_Event_limit_zone_allie_1==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_limit_zone_allie_1)then
				SetVarValue(_idTimer_debut,"Active",true)
				_byetOnEnter_Sector_Event_limit_zone_allie_1=true
			_bOnEnter_Sector_Event_limit_zone_allie_1=1	
		end
	end
end
----------------------------------------------------------------------

function OnEnter_Sector_Event_cloitre_A(id)

_bAlive_idChar_RES_Snip_00_2=IsAlive(_idChar_RES_Snip_00_2)
_bAlive_idChar_RES_RDC_01_14=IsAlive(_idChar_RES_RDC_01_14)
_bAlive_idChar_RES_RDC_01_7=IsAlive(_idChar_RES_RDC_01_14)


---quand le joueur entre dans la boite de gauche et si y'a moins de 10 bots alors on defreeze des ennemis
	if(_bOnEnter_Sector_Event_cloitre_A==0)then

		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_cloitre_A)and((_nActifBots<=10))then
				Freeze(_idChar_RES_RDC_01_7,false)
				Freeze(_idChar_RES_RDC_01_14,false)
				Freeze(_idChar_RES_Snip_00_2,false)
					_byetOnEnter_Sector_Event_cloitre_A=true
		else _bOnEnter_Sector_Event_cloitre_A=0
--on active la possibilité de declenché la boite voisine(B)
			_bOnEnter_Sector_Event_cloitre_B=0
		end
			if(_bAlive_idChar_RES_RDC_01_7==false)and(_bAlive_idChar_RES_RDC_01_14==false)and(_idChar_RES_Snip_00_2==false)then
--si le joeur a éliminé 3 ennemis alors on réactive la boite B (voisine à droite) 
				
				_byetOnEnter_Sector_Event_cloitre_A=true
				_bOnEnter_Sector_Event_cloitre_A=1
				_bOnEnter_Sector_Event_cloitre_B=0

			end
	end
end
---------------------------------------------------------------------------

function OnEnter_Sector_Event_cloitre_B(id)


_bAlive_idChar_RES_RDC_01_1=IsAlive(_idChar_RES_RDC_01_1)
_bAlive_idChar_RES_RDC_01_8=IsAlive(_idChar_RES_RDC_01_8)

--si y'a moins de 6 bots on defreeze 2 gars et affiche le texte
	if(_bOnEnter_Sector_Event_cloitre_B==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_cloitre_B)and(_nActifBots<=10)then
			Freeze(_idChar_RES_RDC_01_1,false)	
			_byetOnEnter_Sector_Event_cloitre_B=true
			_bOnEnter_Sector_Event_cloitre_A=1
			else _bOnEnter_Sector_Event_cloitre_B=0
					_bOnEnter_Sector_Event_cloitre_A=0
			end
--si le joeur a éliminé 2 ennemis alors on réactive la boite A (voisine à droite) 
		if (_bAlive_idChar_RES_RDC_01_1==false)and(_bAlive_idChar_RES_RDC_01_8==false)then
			_bOnEnter_Sector_Event_cloitre_A=0
			_bOnEnter_Sector_Event_cloitre_B=1
		end
	end
end
-----------------------------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_cloitre_B1(id)

	if(_bOnEnter_Sector_Event_cloitre_B1==0)then

		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_cloitre_B1)then
			Freeze(_idChar_RES_RDC_01_18,false)
			Freeze(_idChar_RES_RDC_01_3,false)
			Freeze(_idChar_RES_RDC_01_11,false)
			_byetOnEnter_Sector_Event_cloitre_B1=true
			_bOnEnter_Sector_Event_cloitre_B1=1
		end
	end
end
----------------------------------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_cloitre_C(id)

	if(_bOnEnter_Sector_Event_cloitre_C==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_cloitre_C)and not(_nActifBots>=9)then
			Freeze(_idChar_RES_Snip_00_3,false)
			Freeze(_idChar_RES_RDC_01_13,false)
			_byetOnEnter_Sector_Event_cloitre_C=true
			_bOnEnter_Sector_Event_cloitre_C=1
		end
	end
end

----------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_cloitre_C1(id)

	if(_bOnEnter_Sector_Event_cloitre_C1==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_cloitre_C1)then
			Freeze(_idChar_RES_RDC_01_4,false)
			_byetOnEnter_Sector_Event_cloitre_C1=true
			_bOnEnter_Sector_Event_cloitre_C1=1
		end
	end
end
----------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_cloitre_D(id)

	if(_bOnEnter_Sector_Event_cloitre_D==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_cloitre_D)and(_nActifBots<=9)then
			Freeze(_idChar_RES_RDC_01_5,false)
			Freeze(_idChar_RES_Snip_00_5,false)
			Freeze(_idChar_RES_Snip_00_4,false)
			_byetOnEnter_Sector_Event_cloitre_D=true
			_bOnEnter_Sector_Event_cloitre_D=1
		end
	end
end
------------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_cloitre_A1(id)

	if(_bOnEnter_Sector_Event_cloitre_A1==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_cloitre_A1)then
			Freeze(_idChar_RES_RDC_01_15,false)
			Freeze(_idChar_RES_1FLOOR_18,false)
			_byetOnEnter_Sector_Event_cloitre_A1=true
			_bOnEnter_Sector_Event_cloitre_A1=1
		end
	end
end
---------------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_cloitre_RDC_room_top(id)

	if(_bOnEnter_Sector_Event_cloitre_RDC_room_top==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_cloitre_RDC_room_top)then
			Freeze(_idChar_RES_1FLOOR_3,false)
			Freeze(_idChar_RES_1FLOOR_11,false)
			_byetOnEnter_Sector_Event_cloitre_RDC_room_top=true
			_bOnEnter_Sector_Event_cloitre_RDC_room_top=1
			Debut()
		end
	end
end
----------------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_cloitre_bas(id)

	if(_bOnEnter_Sector_Event_cloitre_bas==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_cloitre_bas)then
			Freeze(_idChar_RES_Snip_00_1,false)
			_byetOnEnter_Sector_Event_cloitre_bas=true
			_bOnEnter_Sector_Event_cloitre_bas=1
		end
	end
end
-----------------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_cloitre_transition(id)

	if(_bOnEnter_Sector_Event_cloitre_transition==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_cloitre_transition)then
			Freeze(_idChar_RES_1FLOOR_25,false)
			Freeze(_idChar_RES_1FLOOR_27,false)
			_byetOnEnter_Sector_Event_cloitre_transition=true
			_bOnEnter_Sector_Event_cloitre_transition=1
		end
	end
end
--------------------------------------------------------------------
--defreeze des ennemis
function OnExit_Sector_Event_cloitre_terrasse_1(id)

	if(_bOnExit_Sector_Event_cloitre_terrasse_1==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_cloitre_terrasse_1)then
			Freeze(_idChar_RES_1FLOOR_8,false)
			Freeze(_idChar_RES_1FLOOR_7,false)
			Freeze(_idChar_RES_1FLOOR_12,false)
		end
			if(_byetOnEnter_Sector_Event_cloitre_B1==false)then
			Freeze(_idChar_RES_RDC_01_18,false)
			Freeze(_idChar_RES_RDC_01_3,false)
			Freeze(_idChar_RES_RDC_01_11,false)
			_byetOnExit_Sector_Event_cloitre_terrasse_1=true
			_bOnExit_Sector_Event_cloitre_terrasse_1=1
			end
	end
end
---------------------------------------------------------------------------------
--defreeze des ennemis, donne l'ordre ax alliés de suivre le joueur, messagte radio
function OnExit_Sector_Event_cloitre_rdc_right(id)

	if(_bOnExit_Sector_Event_cloitre_rdc_right==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_cloitre_rdc_right)then
			Freeze(_idChar_RES_1FLOOR_1,false)
			Freeze(_idChar_RES_1FLOOR_2,false)
		--	SetVarValue(_idChar_SYND_allie_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_follow_player"))
		--	SetVarValue(_idChar_SYND_allie_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_follow_player"))

			RadioMessage("DIA_SPE_NIV_N_GENERAL_RADIO_07",true,100,0.0,"")
			_byetOnExit_Sector_Event_cloitre_rdc_right=true
			_bOnExit_Sector_Event_cloitre_rdc_right=1
		end
	end
end
---------------------------------------------------------------------------------
--defreeze des ennemis
function OnExit_Sector_Event_cloitre_transit_2(id)

	if(_bOnExit_Sector_Event_cloitre_transit_2==0)then
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_cloitre_transit_2)then
			FreezeAll(_idGroup_2FLOOR_01,false)
				_byetOnExit_Sector_Event_cloitre_transit_2=true

			StartMusic("Sounds//Music//Bos - South theme.wav",true)
			_bOnExit_Sector_Event_cloitre_transit_2=1
		end
	end
end
--------------------------------------------------------------------------------------
--quand l'igénieur meurt on affiche le message suivant :
function DeaD_Inge()

	
	if(_bDeaD_Inge==0)then
		if not IsAlive(_idMerc[0])then
		RadioMessage("DIA_SPE_NIV_N_GENERAL_RADIO_16",true,100,0.0,"")
		EnableCharacterCommand(_idPlayer,false)
		MissionFailed ("HUD_MISSION_FAILED_REASON_02")
		_bDeaD_Inge=1
		end
	end
end
-------------------------------------------
------------------
function MaVie()

_bAlivePlayer=IsAlive(_idPlayer)
	if(_bMaVie==0)then
		if(_bAlivePlayer==false)then
		MissionFailed ("HUD_MISSION_FAILED_REASON_01")
		_bMaVie=1
		end
	end
end

-----------------------------------------
--------------------------------------------------------------------------------
--declenche le timer pour Change_terrase

function Time30()
	if(_bTime30==0)then
	SetVarValue(_idTimer_terrasse,"Active",true)
	_bTime30=1
	_b_idTimer_terrasse=1
	end
end

--------------------------------------
--Au bout de 30 secondes si ils ne sont pas morts, les gars de terrasse se barrent derriere les arcades.

function Change_terrasse()

		if(_b_idTimer_terrasse==1)then
			SetVarValue(_idChar_RES_1FLOOR_19,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_go_waypoint_repli_1"))
			SetVarValue(_idChar_RES_1FLOOR_20,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_go_waypoint_repli_2"))
			SetVarValue(_idChar_RES_1FLOOR_21,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_go_waypoint_repli_1"))
			SetVarValue(_idChar_RES_1FLOOR_22,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_go_waypoint_repli_2"))
			_bchange_terrasse=1
		end
end
---------------------------------------------
--quand le joueur est sorti de la pièce de départet que l'ingénieur est mort on freeze les gars de la terrasse et 
--en appelle d'autres
function OnEnter_Sector_Event_change_terrasse(id)

	if(_bOnEnter_Sector_Event_change_terrasse==0)then
		if(_bOnExit_Sector_Event_shift==1)and(_bchange_terrasse==1)and((_idChar_RES_1FLOOR_19==id)and(_idChar_RES_1FLOOR_20==id)and(_idChar_RES_1FLOOR_21==id)or(_idChar_RES_1FLOOR_22==id))then
			Freeze(_idChar_RES_1FLOOR_19,true)
			Freeze(_idChar_RES_1FLOOR_20,true)
			Freeze(_idChar_RES_1FLOOR_21,true)
			Freeze(_idChar_RES_1FLOOR_22,true)
			Freeze(_idChar_RES_Snip_00_3,false)
			Freeze(_idChar_RES_RDC_01_13,false)
			Freeze(_idChar_RES_1FLOOR_3,false)
			Freeze(_idChar_RES_1FLOOR_11,false)
			SetVarValue(_idChar_RES_1FLOOR_3,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_RES_RDC_01_8/16"))
			SetVarValue(_idChar_RES_1FLOOR_11,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_RES_1FLOOR_5/22/24"))
			_bOnEnter_Sector_Event_change_terrasse=1
		end
	end
end
------------------------------------------------------------------
--si le joueur est encore dans le cloitre au RDC et qu'il ya moins de 3 persos actifs alors on defreeze des gars
function OnStay_Sector_Event_PlayerBas(id)

	if (_bOnStay_Sector_Event_PlayerBas==0)then
		if(GetLocalCharacterID("Player")==id)and(_nActifBots<=3)then
			FreezeAll(_idGroup_renforts_cloitre,false)
			_bOnEnter_Sector_Event_cloitre_D=0
			_bOnStay_Sector_Event_PlayerBas=1
		end
	end
end
----------------------------------------------------------------
--si y'a presque aucun ennemis et que les gars de la terrasse sont morts on defreeze des gars 
--et remet les boite de droite et gauche à 0 (au cas ou le joueur reste dans la piece de départ
function Nothing()

_bAlive_idChar_RES_1FLOOR_19=IsAlive(_idChar_RES_1FLOOR_19)
_bAlive_idChar_RES_1FLOOR_20=IsAlive(_idChar_RES_1FLOOR_20)
_bAlive_idChar_RES_1FLOOR_21=IsAlive(_idChar_RES_1FLOOR_21)
_bAlive_idChar_RES_1FLOOR_22=IsAlive(_idChar_RES_1FLOOR_22)


	if(_bNothing==0)then
		if(_nActifBots<=3)and((_bAlive_idChar_RES_1FLOOR_19==false)and(_bAlive_idChar_RES_1FLOOR_20==false)and (_bAlive_idChar_RES_1FLOOR_21==false)and(_bAlive_idChar_RES_1FLOOR_22==false))then
		FreezeAll(_idGroup_renforts_cloitre1,false)
		_bOnEnter_Sector_Event_cloitre_A=0
		_bOnEnter_Sector_Event_cloitre_B=0
		_bNothing=1
		end
	end
end
------------------------------------------------------------
--defreeze des ennemis
function Diversion()

_bAlive_idChar_RES_RDC_01_1=IsAlive(_idChar_RES_RDC_01_1)
	if(_bDiversion==0)then
		if(_bAlive_idChar_RES_RDC_01_1==false)then
			Freeze(_idChar_RES_RDC_01_6,false)		
			Freeze(_idChar_RES_RDC_01_14,false)				
			_bDiversion=1
		end
	end
end
------------------------------------------------------------------
--defreeze des ennemis  si le joueur est toujours en bas, et qu'il ya moins de 5 persos actifs
function OnStay_Sector_Event_PlayerBas1(id)

	if (_bOnStay_Sector_Event_PlayerBas1==0)then
		if(GetLocalCharacterID("Player")==id)and(_nActifBots<=6)then
			FreezeAll(_idGroup_terrasse,false)
			_bOnStay_Sector_Event_PlayerBas1=1
		end
	end
end
------------------------------------------------------------------
--renforts apès élimination des ennemis de gauche
function Terrasse()

_bAlive_idChar_RES_RDC_01_7=IsAlive(_idChar_RES_RDC_01_7)
_bAlive_idChar_RES_RDC_01_15=IsAlive(_idChar_RES_RDC_01_15)

	if(_bTerrasse==0)then
		if(_bAlive_idChar_RES_RDC_01_7==false)and(_bAlive_idChar_RES_RDC_01_15==false)then
			FreezeAll(_idGroup_terrasse,false)
		_bTerrasse=1
		end
	end
end
---------------------------------------------------------------
--à l'étage,
--defreeze des ennemis
function OnEnter_Sector_Event_1st_Floor(id)

	if(_bOnEnter_Sector_Event_1st_Floor==0)then
		if(GetLocalCharacterID("Player")==id)then
			FreezeAll(_idGroup_terrasse_2,false)
			_bOnEnter_Sector_Event_1st_Floor=1
		end
	end
end
--------------------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_middle_terrasse(id)

	if(_bOnEnter_Sector_Event_middle_terrasse==0)then
		if(GetLocalCharacterID("Player")==id)then
			FreezeAll(_idGroup_terrasse1,false)
			_bOnEnter_Sector_Event_middle_terrasse=1
		end
	end
end
--------------------------------------------------------
--defreeze des ennemis
function OnExit_Sector_Event_Coin_Droit_terrasse(id)

_bAlive_idChar_RES_1FLOOR_17=IsAlive(_idChar_RES_1FLOOR_17)

	if(_bOnExit_Sector_Event_Coin_Droit_terrasse==0)then
		if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_RES_1FLOOR_17,false)
		end
		if(_bAlive_idChar_RES_1FLOOR_17==false)then
			Freeze(_idChar_RES_1FLOOR_18,false)
		end
		_bOnExit_Sector_Event_Coin_Droit_terrasse=1
	end
end
-------------------------------------------------------------
--lance un plan fix au debut
function Cam_debut()

_idCamTransition_63=GetCamTransitionID("CamTransition_63")

	if(_bCam_debut==0)then
		EnableCharacterCommand(_idPlayer,false)
		LaunchCameraTransition(_idCamTransition_63)
		ShowCinematicBlackStripes(true)
		RadioMessage("DIA_SPE_NIV_N_GENERAL_RADIO_04",true,100,0.0,"")
		_bCam_debut=1

	end
end
----------------------------------------------------------------
function Cam_1()

_idCamTransition_62=GetCamTransitionID("CamTransition_62")

	LaunchCameraTransition(_idCamTransition_62)

end
----------------------------------------------------------------
function Cam_2()

_idCamTransition_61=GetCamTransitionID("CamTransition_61")

	LaunchCameraTransition(_idCamTransition_61)
end
---------------------------------------------
function End_Cam()

ShowCinematicBlackStripes(false)
EnableCharacterCommand(_idPlayer,true)
end
--------------------------------------------------------------
function ClearCloitre()

_idDoor_63=GetDoorID("Door_63")

	if(_bClearCloitre==0)then
		if(_nBotsMorts==25)then
			UnLockDoor(_idDoor_63)
			OpenDoor(_idDoor_63)
			SetVarValue(_idDoor_63,"Opened Time",-1)
			NewSubObjective("Obj_E_1","Obj_E_2")
		_bClearCloitre=1
		end
	end
end
-------------------------------------------------
function Obj_3()

	if(_bObj_3==0)then
		if(_nBotsMorts==59)then
			NewSubObjective("Obj_E_3","Obj_E_4")
			_bHacking=true
			_bObj_3=1
		end
	end
end
---------------------------------------------------