function UpdateLevel_Place()

end
--------------------------------------------------------------------
--Nolan entre dans la boite "Sector_Event_declencheur_spawn_1"
--defreeze sur la place: 4 ennemis.
function OnEnter_Sector_Event_declencheur_spawn_1(id)
	if(_bOnEnter_Sector_Event_declencheur_spawn_1==0) then
		if (GetLocalCharacterID("Player")==id) and not(_b_yet_OnEnter_Sector_Event_declencheur_spawn_1)then
			Freeze(_idChar_UAN_Place_00_1,false)
			Freeze(_idChar_UAN_Place_00_3,false)
			Freeze(_idChar_UAN_Place_00_4,false)
			Freeze(_idChar_UAN_Place_00_6,false)
			_b_yet_OnEnter_Sector_Event_declencheur_spawn_1=true
			_bOnEnter_Sector_Event_declencheur_spawn_1=1
		end
	end
end
--------------------------------------------------------------------------
--arrivée de renforts réguliers.

function Renforts_Place_1()

_nAlive_idGroup_UAN_Place_01=AliveMembersCount(_idGroup_UAN_Place_01)

	if(_bRenforts_Place_1==0) then
		if (_nAlive_idGroup_UAN_Place_01<=1)then
		FreezeAll(_idGroup_UAN_Warehouse_02,false)
		_bRenforts_Place_1=1
		end
	end
end
-------------------------------------------------------------------------

--Nolan , est pris pour cible.
-- on spawn par la porte des renforts. 

function Alerte_place()
		_nHealth_4=GetHealthPct(_idChar_UAN_Place_00_4)
	if (_bAlerte_place==0)then
		if (_nHealth_4<10)then
		Freeze(_idChar_UAN_porte_Place_02_1,false)

		SetVarValue(_idChar_UAN_porte_Place_02_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_go_place_2"))
		SetVarValue(_idChar_UAN_porte_Place_03_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_go_place_2"))
		_bAlerte_place=1
		end
	end
end
-------------------------------------------------------------------------
--quand nolan s'approche de la porte on defreeze un gars supplm. 
function OnEnter_Sector_Event_Porte_1(id)


	if(_bOnEnter_Sector_Event_Porte_1==0) then
		if (GetLocalCharacterID("Player")==id)and not(_b_yet_OnEnter_Sector_Event_Porte) then
		Freeze(_idChar_UAN_porte_Place_03_2,false)
		FreezeAll(_idGrp_UAN_Avenue_01,false)
		_b_yet_OnEnter_Sector_Event_Porte=true
		_bOnEnter_Sector_Event_Porte_1=1	
		end
	end
end
----------------------------------------------------------------------------

------------------------------------------------------------------------
--defreeze deux gars en leur donnant l'ordre de se positionner.
function OnEnter_Sector_Event_Place(id)


	if(_bOnEnter_Sector_Event_Place==0) then
		if (GetLocalCharacterID("Player")==id)and not(_b_yet_OnEnter_Sector_Event_Place) then
			Freeze(_idChar_UAN_porte_Place_02_1,false)
			Freeze(_idChar_UAN_porte_Place_03_2,false)
			SetVarValue(_idChar_UAN_porte_Place_02_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_go_place_2"))
			SetVarValue(_idChar_UAN_porte_Place_03_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_go_place_2"))
			_b_yet_OnEnter_Sector_Event_Place=true
			_bOnEnter_Sector_Event_Place=1
		end
	end
end
---------------------------------------------
--quand les deux derniers gars qui sont passés par la porte sont morts,et que le groupe de 3 aussi
-- les allés s'engagent vers la porte
--et attendent que le joueur les rejoignent
function WRF_etape_3()
_bAlive_idChar_UAN_porte_Place_02_1=IsAlive(_idChar_UAN_porte_Place_02_1)
_bAlive_idChar_UAN_porte_Place_03_2=IsAlive(_idChar_UAN_porte_Place_03_2)
_bAlive_idGroup_UAN_Warehouse_02=IsAlive(_idGroup_UAN_Warehouse_02)
_bAlive_idChar_WRF_01_1=IsAlive(_idChar_WRF_01_1)
_bAlive_idChar_WRF_01_2=IsAlive(_idChar_WRF_01_2)

	if(_bWRF_etape_3==0)then
			if(_bAlive_idChar_UAN_porte_Place_02_1==false)and(_bAlive_idChar_UAN_porte_Place_03_2==false)and(_bAlive_idGroup_UAN_Warehouse_02==false) then
				SetVarValue(_idChar_WRF_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_pathway_porte_place"))
				SetVarValue(_idChar_WRF_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_pathway_porte_place1"))
				_bWRF_etape_3=1
			end
	end
end
--------------------------------------------------------------------------

---------------------------------------------------------------------------
--Quand tous les ennemis de la place sont entre 2 et 5, on affiche un message radio(good continue)
function Exterminer()		
_n_restants_idGroup_UAN_Place_01=AliveMembersCount(_idGroup_UAN_Place_01)
	if(_bExterminer==0) then
		if(_n_restants_idGroup_UAN_Place_01>=1)and(_n_restants_idGroup_UAN_Place_01<=3)then
			if(_idMerc[0]~=nil)then
			MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_G_GENERAL_RADIO_03",true,100,2,0.0,"",100)
			end
				_bExterminer=1
		end
	end
end
-------------------------------------------------------------------

-------------------------------------------------------------------------------------------------
--dès que le joueur tente de rejoindre les alliés qui attendent devant la grande porte
--il sort d'une boite qui fait avancer les alliés dans l'Avenue.
function OnExit_Sector_Event_Entree_porte_place(id)
	if(_bOnExit_Sector_Event_Entree_porte_place==0) then
		if(GetLocalCharacterID("Player")==id)and not(_byet_OnExit_Sector_Event_Entree_porte_place)and(_bWRF_etape_3==1)then
			SetVarValue(_idChar_WRF_01_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_avenue_3"))
			SetVarValue(_idChar_WRF_01_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Pathway_avenue_5"))
			
			StartMusic("Sounds//Music//Bos - War theme.wav",true)

			if(_idMerc[0]~=nil)then
			 MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_G_MERCE_B_01",true,100,2,0.0,"",100)
			end
		_byet_OnExit_Sector_Event_Entree_porte_place=true
		_bOnExit_Sector_Event_Entree_porte_place=1
		end
	end
end
--------------------------------------------------------------------------------------







