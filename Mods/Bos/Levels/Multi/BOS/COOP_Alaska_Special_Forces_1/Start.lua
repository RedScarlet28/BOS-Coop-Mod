function UpdateLevel_Start()

end
------------------------------------------------------------------------
function MaVie()

	if(_bMaVie==0)then
		if not IsAlive(_idPlayer)then
		MissionFailed("HUD_MISSION_FAILED_REASON_01")
		_bMaVie=1
		end
	end
end
-------------------------------
function Vie()

if(_bVie==0)then
	if(_idMerc[0]~=nil)and not IsAlive(_idMerc[0])then
		EnableCharacterCommand(_idPlayer,false)
		RadioMessage("DIA_SPE_NIV_K_GENERAL_RADIO_08",true,100,0.0,"")
		MissionFailed ("HUD_MISSION_FAILED_REASON_02")
	_bVie=1
	end
end
end
-------------------------------
--------------------------------------------------------------------------
--Nolan reçoit les consignes de la mission :
--temps:au boutde 1 seconde,pendant 5 secondes.

--function Consigne_depart()
--_idTimer_Obj=GetTimerID("Timer_Obj")
--	if (_bConsigne_depart==0)then	
	--		RadioMessage("DIA_SPE_NIV_G_GENERAL_RADIO_01",true,100,0.0,"")
	--		SetVarValue(_idTimer_Obj,"Active",true)	
	--	_bConsigne_depart=1
--	end
--end
----------------------------------------------------------------------------
function Objectif_Principal_1()

_idObjective_Principal_1=GetObjectiveID("Obj_A")
_idTV_Camera_Client_Player=GetTV_Camera_ClientID("TV_Camera_Client_Player")

	if(_bObjectif_Principal_1==0)then
--		if(_bConsigne_depart==1 then
		--	OpenDoor(_idDoor_bos_1,true)
		--	OpenDoor(_idDoor_bos_2,true)
			SetVarValue(_idTV_Camera_Client_Player,"Active",true)
			
			SetVarValue(_idChar_WRF_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Waypoint_wrf_1"))
			SetVarValue(_idChar_WRF_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Waypoint_wrf_2"))
				if(_idMerc[0]~=nil)then
				SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Mercs_Spawn_0"))
				end
					if(_idMerc[1]~=nil)then
				SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Mercs_Spawn_1"))
				end
			NewObjectiveNewSubObjective ("Obj_A","Obj_A_1")
			_bObjectif_Principal_1=1
		end
	--	end
end
------------------------------------------------------------------------------
--L'entrée du joueur dans cette boite, donne l'ordre aux alliés d'aller dans la rue 
--
function OnEnter_Sector_Event_Start_1(id)

	if (_bOnEnter_Sector_Event_Start_1==0)then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Start_1)then
			SetVarValue(_idChar_WRF_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Grp_WRF_01_go_start"))
			SetVarValue(_idChar_WRF_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_start_3"))
			_b_yetOnEnter_Sector_Event_Start_1=true
			_bOnEnter_Sector_Event_Start_1=1
		end
	end
end
----------------------------------------------------------------------
--Quand Nolan entre dans la boite "Sector_Event_start",les alliés prennent position

function OnEnter_Sector_Event_start(id)
	if (_bOnEnter_Sector_Event_start==0)then
		if (GetLocalCharacterID("Player")==id) and not(_b_yet_OnEnter_Sector_Event_start) then
		 		SetVarValue(_idChar_WRF_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_MERC_follow"))
				SetVarValue(_idChar_WRF_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_MERC_follow"))
					if(_idMerc[0]~=nil)then
				SetVarValue(_idMerc[0],"CharacterOrderList",_idPasdeListe)
				end
					if(_idMerc[1]~=nil)then
				SetVarValue(_idMerc[1],"CharacterOrderList",_idPasdeListe)
				end

			_b_yet_OnEnter_Sector_Event_start=true
			_bOnEnter_Sector_Event_start=1
		end
	end
end
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- en entrant dans cette boite Nolan declenche
-- l'alarme: les premiers ennemis arrivent

function OnEnter_Sector_Event_Alarme_rue(id)
	if (_bOnEnter_Sector_Event_Alarme_rue==0)then
		if (GetLocalCharacterID("Player")==id)and not(_b_yet_OnEnter_Sector_Event_Alarme_rue) then
			Freeze(_idChar_UAN_Rue_01_7,false)
			_b_yet_OnEnter_Sector_Event_Alarme_rue=true
			_bOnEnter_Sector_Event_Alarme_rue=1
		end
	end
end
-----------------------------------------------------------------------------------
-- A la mort de 4 ennemis, deux nouveaux arrivent par la rue
function SecondWave()			
_idAlarme=GetSound_ClientID("Sound_Client_510")
_balive_idChar_UAN_Rue_01_7=IsAlive(_idChar_UAN_Rue_01_7)

	if(_bSecondWave==0) then
		if(_balive_idChar_UAN_Rue_01_7==false)then
				SetVarValue(_idAlarme,"Playing",true)
			 Freeze(_idChar_UAN_Rue_01_5,false)
			FreezeAll(_idGrp_UAN_Rue_01,false)
			_bSecondWave=1
		end
	end
end
-----------------------------------------------------------------------------------
function OnExit_Sector_Event_Secure_Spawn(id)

	if(_bOnExit_Sector_Event_Secure_Spawn==0)then		
		if 	(GetLocalCharacterID("Player")==id)and not(_b_yet_OnExit_Sector_Event_Secure_Spawn) then
			FreezeAll(_idGrp_UAN_Rue_01,false)
	   	_b_yet_OnExit_Sector_Event_Secure_Spawn=true
			_bOnExit_Sector_Event_Secure_Spawn=1	
		end
	end
end
----------------------------------------------------------------------------------
--lorsque le joueur rejoint les alliés au coin de la rue, ceux ci ouvrent la voie sur la place
function OnEnter_Sector_Event_coin_rue(id)
	if(_bOnEnter_Sector_Event_coin_rue==0) then
		if (GetLocalCharacterID("Player")==id)and not(_b_yet_OnEnter_Sector_Event_coin_rue)then
	  	SetVarValue(_idChar_WRF_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Grp_WRF_01_go_rue"))
			SetVarValue(_idChar_WRF_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_MERC_follow"))
			if(_idMerc[0]~=nil)then	
				MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_G_MERCE_B_01",true,100,2,0.0,"",100)
			end
			_b_yet_OnEnter_Sector_Event_coin_rue=true
			_bOnEnter_Sector_Event_coin_rue=1
		end
	end
end
---------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------
--Quand les premiers ennemis, sont morts , les alliés se palcent au coin de la rue et attendent le joueur
function Parcours_WRF_1()

_bAliveChar_UAN_Rue_01_7=IsAlive(_idChar_UAN_Rue_01_7)
_bAliveChar_UAN_Rue_01_5=IsAlive(_idChar_UAN_Rue_01_5)
_bAliveChar_UAN_Rue_01_3=IsAlive(_idChar_UAN_Rue_01_3)
_bAliveChar_UAN_Rue_01_1=IsAlive(_idChar_UAN_Rue_01_1)


	if(_bParcours_WRF_1==0)then
		if (_bAliveChar_UAN_Rue_01_1==false)and(_bAliveChar_UAN_Rue_01_3==false)and(_bAliveChar_UAN_Rue_01_5==false)and(_bAliveChar_UAN_Rue_01_7==false)
				then
			SetVarValue(_idChar_WRF_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_start_5"))
			SetVarValue(_idChar_WRF_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Grp_WRF_01_go_place_1"))				
			if(_idMerc[0]~=nil)then	
			MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_G_MERCE_A_02",true,100,2,0.0,"",100)
			end
		_bParcours_WRF_1=1
		end
	end
end	
-------------------------------------------------------------
















