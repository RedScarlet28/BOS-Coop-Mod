function UpdateLevel_Avenue()
end
-------------------------------------------------------------------
--arrivée d'ennemis
function Renforts_avenue_1()

_bAlive_idChar_UAN_porte_Place_03_2=IsAlive(_idChar_UAN_porte_Place_03_2)

	if(_bRenforts_avenue_1==0)then	
		if (_bAlive_idChar_UAN_porte_Place_03_2==false)then
			FreezeAll(_idGrp_UAN_Avenue_03,false)
			_bRenforts_avenue_1=1
		end
	end
end
-----------------------------------------------------
--arrivée d'ennemis
function Renforts_Avenue_2()

_bAlive_idChar_UAN_Avenue_00_3=IsAlive(_idChar_UAN_Avenue_00_3)

	if(_bRenforts_avenue_2==0)then	
		if (_bAlive_idChar_UAN_Avenue_00_3==false)then
			--FreezeAll(_idGrp_UAN_Avenue_04,false)
			_bRenforts_avenue_2=1
		end
	end
end
--------------------------------------------
function Renforts_Avenue_2bis()

_bAlive_idGrp_UAN_Avenue_04=IsAlive(_idGrp_UAN_Avenue_04)

	if(_bAlive_idGrp_UAN_Avenue_04==false)then
		FreezeAll(_idGrp_UAN_Avenue_05,false)
	end
end
------------------------------------------------------------------
--en avançant le joueur déclenche un spawn d'ennemis
function OnExit_Sector_Event_Porte_2(id)
		if(_bOnExit_Sector_Event_Porte_2==0) then
			if (GetLocalCharacterID("Player")==id)and not(_b_yet_OnExit_Sector_Event_Porte_2) then
			--	Freeze(_idChar_UAN_Avenue_00_1,false)
				Freeze(_idChar_UAN_Avenue_00_3,false)
				_b_yet_OnExit_Sector_Event_Porte_2=true
				_bOnExit_Sector_Event_Porte_2=1
			end
		end
end
-------------------------------------------------------------------
--En se cach	ant derriere la pallissade 
--arrivé d'ennemis +positionnement d'un des gars
function OnEnter_Sector_Event_Barricade_Avenue(id)
		if(_bOnEnter_Sector_Event_Barricade_Avenue==0) then
			if (GetLocalCharacterID("Player")==id)and not(_b_yet_OnEnter_Sector_Event_Barricade_Avenue)then
			--	FreezeAll(_idGrp_UAN_Avenue_02,false)
			--	SetVarValue(_idChar_UAN_Avenue_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_go_Avenue_1"))
				_b_yet_OnEnter_Sector_Event_Barricade_Avenue=true
				_bOnEnter_Sector_Event_Barricade_Avenue=1
			end
		end
end
----------------------------------------------------------------
--arrivée d'ennemis
function OnEnter_Sector_Event_Avenue_Milieu(id)
	if(_bOnEnter_Sector_Event_Avenue_Milieu==0) then
		if (GetLocalCharacterID("Player")==id)and not(_b_yet_OnEnter_Sector_Event_Avenue_Milieu)then
			--	FreezeAll(_idGrp_UAN_Avenue_02,false)
				Freeze(_idChar_UAN_Place_00_1,true)
				_b_yet_OnEnter_Sector_Event_Avenue_Milieu=true
				_bOnEnter_Sector_Event_Avenue_Milieu=1
		end
	end		
end
---------------------------------------------------------------
--s'il reste plus qu'un ennmis dans le groupe 02 alors on defreeze le groupe 01
-- message radio
function Renforts_Avenue()

_n_restants_idGrp_UAN_Avenue_01=AliveMembersCount(_idGrp_UAN_Avenue_01)
	if(_bRenforts_Avenue==0) then
		if (_n_restants_idGrp_UAN_Avenue_01==0)then
			FreezeAll(_idGrp_UAN_Avenue_02,false)
			
			RadioMessage("DIA_SPE_NIV_G_GENERAL_RADIO_03",true,100,0.0,"")
		_bRenforts_Avenue=1
		end
	end
end
-----------------------------------------------------------------
--defreeze les enemis dans la chaudiere
function OnEnter_Sector_Event_Avenue_Reserve(id)
	if(_bOnEnter_Sector_Event_Avenue_Reserve==0) then
		if (GetLocalCharacterID("Player")==id)and not (_b_yet_OnEnter_Sector_Event_Avenue_Reserve)then
	
			StartMusic("Sounds//Music//BoS - Twilight theme.wav",true)

			Freeze(_idChar_UAN_Chaudiere_03_1,false)
			Freeze(_idChar_UAN_Chaudiere_03_2,false)
			_bOnEnter_Sector_Event_Avenue_Reserve=1
			_b_yet_OnEnter_Sector_Event_Avenue_Reserve=true
		end
	end
end
------------------------------------------------------------
--Les alliés avançent vers la chaudiere, un son d'ambiance est déclenché
function OnEnter_Sector_Event_Entree_chaudiere(id)

_idSonChaudiere=GetSound_ClientID("Sound_Client_509")
	if(_bOnEnter_Sector_Event_Entree_chaudiere==0) then
		if(GetLocalCharacterID("Player")==id)and not(_b_yet_OnEnter_Sector_Event_Entree_chaudiere)then
		FreezeAll(_idGrp_UAN_Avenue_03,false)
		SetVarValue(_idSonChaudiere,"Playing",true)
		SetVarValue(_idChar_WRF_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_MERC_follow"))
		SetVarValue(_idChar_WRF_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_MERC_follow"))
		_bOnEnter_Sector_Event_Entree_chaudiere=1
		end
	end
end
----------------------------------------------------------------
--fais avancer les alliés
function WRF_etape_4()

	_bAliveChar_UAN_porte_Place_03_2=IsAlive(_idChar_UAN_porte_Place_03_2)
--	_bAliveChar_UAN_Avenue_00_1=IsAlive(_idChar_UAN_Avenue_00_1)
	_bAliveChar_UAN_Avenue_00_3=IsAlive(_idChar_UAN_Avenue_00_3)
	if(_bWRF_etape_4==0)then
		if(_bAliveChar_UAN_porte_Place_03_2==false)then		
			SetVarValue(_idChar_WRF_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_avenue_2"))
			SetVarValue(_idChar_WRF_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_avenue_2"))
			_bWRF_etape_4=1
		end
	end
end
-----------------------------------------------------------------------------
--fais avancer les alliés
function WRF_etape_5()

	_bAliveChar_UAN_Avenuecour_00_4=(_idChar_UAN_Avenuecour_00_4)

	if(_bWRF_etape_5==0)then
		if(_bAliveChar_UAN_Avenuecour_00_4==false)then
			SetVarValue(_idChar_WRF_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_WRF_follow_player"))
			SetVarValue(_idChar_WRF_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_WRF_follow_player"))
			_bWRF_etape_5=1
		end
	end
end










