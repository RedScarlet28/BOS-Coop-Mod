function UpdateLevel_Barricades()

end
--------------------------------------
function MaVie()

_bAlivePlayer=IsAlive(_idPlayer)
	if(_bMaVie==0)then
		if(_bAlivePlayer==false)then
		MissionFailed ("HUD_MISSION_FAILED_REASON_01")
		_bMaVie=1
		end
	end
end

--------------------------------------
-- Affiche le dialogue d'un mercenaire

function Dialogue_MERC_A()
	NewObjectiveNewSubObjective("Obj_A","Obj_A_1")		
	MiniMapTrack(_idChar_WRF_COLONEL,2,true)
	if (_idMerc[0] ~= nil) then
	MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_L_MERCE_A_01",true,100,2,0.0,"",100)
	end
	_bdial_A=true

end
----------------------------------------
-- Affiche le dialogue d'un mercenaire
function Dialogue_MERC_B()

	if(_bdial_A==true)then
		if (_idMerc[1] ~= nil) then
		MakeCharacterSpeak(_idMerc[1],_idPlayer,"DIA_SPE_NIV_L_MERCE_B_01",true,100,2,0.0,"",100)
		end
	end
end
--------------------------------------
function OnEnter_Sector_Event_Miltar_Pretorian(id)

	if(id==_idPlayer)then
		SetVarValue(_idChar_WRF_Pretorian_00_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_military_salut"))
	end
end
-----------------------------------------
-----------------------------------------
--Untimer declenche des explos vers les barricades toutes les 7 secondes

function Explo()
_idBomb1=CreateExplosion()
--_idBomb2=CreateExplosion()

	SetVarValue(_idBomb1,"Type","Explosion_Rocket_Bombardement")
	SetVarValue(_idBomb1,"Position",Vector3D(1348.0,319.0,23.0))
	--SetVarValue(_idBomb2,"Type","Explosion_Rocket_Bombardement")
--SetVarValue(_idBomb2,"Position",Vector3D(1265.852417,437.523224,78.124611))

	_rExplosion = GetFloatRandom(4,15)
	SetVarValue(GetTimerID("Timer_Explo"),"Duration",_rExplosion)

end
------------------------------------------------------------------------
--Quand le joueur entre sur la barricade côté droit on affiche le texte suivant, 
--pour lui signifier que rester là n'est pas la priorité

function OnEnter_Sector_Event_BARRICADE_1(id)

	if (GetLocalCharacterID("Player")==id)then
			if (_bTestGENERAL_RADIO_13 == 0) then
				MakeCharacterSpeak(_idChar_WRF_barricades_Assault_1,_idPlayer,"DIA_SPE_NIV_L_GENERAL_RADIO_13",true,100,2,0.0,"",25)
				_bTestGENERAL_RADIO_13 = 1
			end
		TankFireAtPosition(_idTank_1,Vector3D(1340.839111,305.400513,30.734262))		
	end
end
---------------------------------------------------------------------
--Quand le joueur entre sur la barricade côté gauche on affiche le texte suivant, 
--pour lui signifier que rester là n'est pas la priorité de la mission

function OnEnter_Sector_Event_BARRICADE_2(id)

	if (GetLocalCharacterID("Player")==id)then
			if (_bTestGENERAL_RADIO_13 == 0) then
				MakeCharacterSpeak(_idChar_WRF_barricades_Assault_1,_idPlayer,"DIA_SPE_NIV_L_GENERAL_RADIO_13",true,100,2,0.0,"",25)
				_bTestGENERAL_RADIO_13 = 1
			end
		TankFireAtPosition(_idTank_1,Vector3D(1340.839111,305.400513,30.734262))
	end
end
-------------------------------------------------------------------------

--si un perso allié est dans la boite 1 et qu'il meurt, celui de la boite baricade 2 va dans la zone RESERVE,
-- et deux gars de la reserve prennent la list barricade 
function OnStay_Sector_Event_BARRICADE_1(idbarricade1)

	_idSound_Client_russe=GetSound_ClientID("Sound_Client_russe")
	_nHP_life_idbarricade1=GetHealthPct(idbarricade1)

	if(_bInside==true)then
			SetVarValue(_idSound_Client_russe,"Playing",true)
		SetVarValue(idbarricade1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_BARRICADE_3"))
			if (_idMerc[0] ~= nil) then 
				SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_MERC"))
			end
			if (_idMerc[1] ~= nil) then 
				SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_MERC"))
			end
		if(_nHP_life_idbarricade1<=10)then
			_bdial_barik_1=true
			_bMort1=true
		else _bMort1=false	
		end
	end
end
--------------------------------------------
--Donne l'ordre à des reserviste d'aller au front
function OnStay_Sector_Event_RESERVE(idReserve)

	if(_bMort1==true)then
	SetVarValue(idReserve,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_BARRICADE_3"))
	_bMort1=false	
	elseif(_bMort2==true)then
	SetVarValue(idReserve,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_BARRICADE_4"))
	_bMort2=false		
	end
end
------------------------------------------
function OnExit_Sector_Event_RESERVE(id)
	_idSound_Client_russe=GetSound_ClientID("Sound_Client_russe")

	if(_bOnExit_Sector_Event_RESERVE==0)then
		if(id == GetLocalCharacterID("Player"))then
			SetVarValue(_idSound_Client_russe,"Playing",false)
			_bOnExit_Sector_Event_RESERVE=1
		end
	end
end
------------------------------------
-- L'inverse :
-- si un perso allié est dans la boite 2 et qu'il meurt, celui de la boite baricade 1 va dans la zone RESERVE,
-- et deux gars aléatoirement de tous ceux qui sont dans la zone reserve prennent la list barricade 
function OnStay_Sector_Event_BARRICADE_2(idbarricade2)


	_idSound_Client_russe=GetSound_ClientID("Sound_Client_russe")
	_nHP_life_idbarricade2=GetHealthPct(idbarricade2)

	if(_bInside==true)then
		SetVarValue(idbarricade2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_BARRICADE_4"))
		SetVarValue(_idSound_Client_russe,"Playing",true)
		if (_idMerc[0] ~= nil) then 
		SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_MERC"))
		end
		if (_idMerc[1] ~= nil) then 
		SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_MERC"))
		end
		if(_nHP_life_idbarricade2<=10)then
			_bMort2=true
		else _bMort2=false	
		end
	_bInside=false
	end
end

---------------------------------------

-------------------------------------------
-- si y'a moins de 2 personnes dans RESERVE, des Gars des tentes ou d'ailleurs s'y rendent.
function Renforts()

	_nMorts_Reserve=AliveMembersCount(_idGroup_WRF_Reserve)

	if(_nMorts_Reserve==2)then
		FreezeAll(_idGroup_WRF_Church_01,false)
	end
end

--------------------------------------
-- si le JOUEUR entre dans la RESERVE , Defreeze quelques ennemis

--------------------------------------
-- l'entré du joueur declenche" l'apparition d'ennemis, juske là les alliés tiraient sur des "fire at position"
-- 2 tirs de Tanks sur les barriccades
--je m'assure que les mercenaires me suivent et ne prennet pas l'ordre que l'on chope en rentrant sur les boites de la barricades.

function OnStay_Sector_Event_Player(id)

	if(_bOnStay_Sector_Event_Player==0) then
		if(GetLocalCharacterID("Player")==id)then
			_bInside=true
	
			_idExplo=CreateExplosion()
			_idExplo2=CreateExplosion()
	
			SetVarValue(_idChar_WRF_barricades_Assault_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_BARRICADE_3"))
			SetVarValue(_idChar_WRF_barricades_Assault_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_BARRICADE_4"))
			SetVarValue(_idExplo,"Type","Explosion_Rocket_Bombardement")
			SetVarValue(_idExplo,"Position",Vector3D(1302.864868,344.877075,45.846645))
			SetVarValue(_idExplo2,"Type","Explosion_Rocket_Bombardement")
			SetVarValue(_idExplo2,"Position",Vector3D(1302.864868,344.877075,45.846645))
	--	if (_idMerc[0] ~= nil) then
	---	SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_MERC"))
	--	end

	--	if (_idMerc[1] ~= nil) then
	--	SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_MERC"))
	--	end
		FreezeAll(_idGroup_UAN_Front_01,false)
		--Freeze(_idChar_WRF_Pretorian_00_1,true)

		_bOnStay_Sector_Event_Player=1
	else _bInside=false
	end
	end
end
-----------------------------------------
--tour de garde.
function OnStay_Sector_Event_CaissesA(id)
	if(_bOnStay_Sector_Event_CaissesA==0)then
		if((GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_CaissesA)and not(_byetOnStay_Sector_Event_COLONEL))then
				SetVarValue(_idChar_WRF_barricades_Reserve_3,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_CaissesA"))
				_byetOnEnter_Sector_Event_CaissesA=true
				_bOnStay_Sector_Event_CaissesA=1
		end		
	end
end
--------------------------------------
function Go_tente()
	if(_bGo_tente==0)then
		if(IsEntityInBox(_idChar_WRF_barricades_Reserve_3,"Sector_Event_CaissesA"))and(IsEntityInBox(_idPlayer,"Sector_Event_CaissesA"))then
			SetVarValue(_idChar_WRF_barricades_Reserve_3,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_military_salut"))
		_bGo_tente=1
		end
	end
end
-------------------------------------------------------
--affiche dialogue d'un garde quand on s'approche de lui	
function OnEnter_Sector_Event_CaissesA(id)
	if(_bOnEnter_Sector_Event_CaissesA==0)then
			if((_idChar_WRF_barricades_Reserve_3==id)and not(_byetOnStay_Sector_Event_COLONEL))then
					MakeCharacterSpeak(_idChar_WRF_barricades_Reserve_3,_idPlayer,"DIA_SPE_NIV_L_USWE_D_01",true,95,1,0.0,"",95)
					_bOnEnter_Sector_Event_CaissesA=1
			end
	end
end
--------------------------------------------------	
--affiche dialogue d'un garde quand on s'approche de lui	
function OnStay_Sector_Event_caissesB(id)

	if(_bOnStay_Sector_Event_caissesB==0)then
		if(GetLocalCharacterID("Player")==id)and(IsEntityInBox(_idChar_WRF_CaissesB_Garde_1,"Sector_Event_caissesB"))then
		MakeCharacterSpeak(_idChar_WRF_CaissesB_Garde_1,_idPlayer,"DIA_SPE_NIV_L_USWE_A_01",true,90,1,0.0,"",100)
		_bOnStay_Sector_Event_caissesB=1
		end
	end		
end
------------------------------------------------
--en descendant de la barricade, une explosion survient sur la barricade, je m'assure que mes mercenaires me suivront.
function OnExit_Sector_Event_Player(id)

	if(_bOnExit_Sector_Event_Player==0)then
		if(GetLocalCharacterID("Player")==id)then
		_idExplo=CreateExplosion()
		_idExplo2=CreateExplosion()
			SetVarValue(_idExplo,"Type","Explosion_Rocket_Bombardement")
			SetVarValue(_idExplo,"Position",Vector3D(1309.556274,287.536987,39.752125))
			SetVarValue(_idExplo2,"Type","Explosion_Rocket_Bombardement")
			SetVarValue(_idExplo2,"Position",Vector3D(1302.864868,344.877075,45.846645))
			if (_idMerc[0] ~= nil) then
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_MERC"))
			end
			if (_idMerc[1] ~= nil) then
			SetVarValue(_idMerc[1],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_MERC"))
			end
			--Freeze(_idChar_WRF_Pretorian_00_1,false)

		end
			_bOnExit_Sector_Event_Player=1
	end
end
-------------------------------------------------------
--si le garde de l'eglise valide ma possession d'explosifs il rentre dans l'eglise.
function Passage_libre()

	if(_bOnStay_Sector_Event_Porte_church==1)and(_bExplo_ok==true)then
			SetVarValue(_idChar_WRF_Church_Garde_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_go_waypoint_church_4"))
			
			_bPassage_libre=1
	end
end
------------------------------------------------

----------------------------------------------------
-- On freeze les gars que l'on ne voit pas depuis cette boite
function OnEnter_Sector_Event_DEPART(id)

	
		if(GetLocalCharacterID("Player")==id)then
			--FreezeAll(_idGroup_WRF_Patrouille_01,false)
			--FreezeAll(_idGroup_WRF_Patrouille_02,false)
			Freeze(_idChar_WRF_barricades_Assault_1,true)
			Freeze(_idChar_WRF_barricades_Assault_2,true)
			Freeze(_idChar_WRF_barricades_Reserve_1,true)
			Freeze(_idChar_WRF_barricades_Reserve_2,true)
			FreezeAll(_idGroup_UAN_Front_01,true)
			FreezeAll(_idGroup_UAN_Front_03,true)
			FreezeAll(_idGroup_UAN_Front_04,true)
		end
end
---------------------------------------------
-- On freeze les gars que l'on ne voit pas depuis cette boite
function OnStay_Sector_Event_DEPART(id)
	
		if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_WRF_barricades_Assault_1,true)
			Freeze(_idChar_WRF_barricades_Assault_2,true)

			Freeze(_idChar_WRF_barricades_Reserve_1,true)
			Freeze(_idChar_WRF_barricades_Reserve_2,true)
			FreezeAll(_idGroup_UAN_Front_01,true)
			FreezeAll(_idGroup_UAN_Front_03,true)
			FreezeAll(_idGroup_UAN_Front_04,true)
		end
end
----------------------------------------------------
--en sortant de la zone de barricade, je defreeze des gars et leur mets une 
--liste d'ordre :répartissez vous sur la barricade

function OnExit_Sector_Event_DEPART(id)

	if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_WRF_barricades_Reserve_1,false)
			SetVarValue(_idChar_WRF_barricades_Reserve_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_BARRICADE_1"))

			Freeze(_idChar_WRF_barricades_Reserve_2,false)
			SetVarValue(_idChar_WRF_barricades_Reserve_2,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_BARRICADE_2"))
			Freeze(_idChar_WRF_barricades_Reserve_3,false)
			Freeze(_idChar_WRF_Pretorian_00_1,false)
	end
end
--------------------------------------------------------
--je defreeze une patrouille alliée, et si j'ai les explosifs,je defreeze les paras sur le toit de l'eglise
function OnEnter_Sector_Event_Church_ext(id)

	if(_bOnEnter_Sector_Event_Church_ext==0)then
		if(GetLocalCharacterID("Player")==id)then
			FreezeAll(_idGroup_WRF_Patrouille_01,false)
		end
			if((GetLocalCharacterID("Player")==id)and(_bExplo_ok==true))then
	    FreezeAll(_idGroup_UAN_PARA_03,false)
				if not(_byetShowObj_Para)then
				--	ObjectiveDoneNewObjectiveNewSubObjective("Obj_A","Obj_B","Obj_B_1")
					_byetShowObj_Para=true
				end
					if (_idMerc[0] ~= nil)and not(_byetShowObj_Para)then
						MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_L_USWE_E_01",true,100,2,0.0,"",25)
					end
			_bOnEnter_Sector_Event_Church_ext=1
			end
	end
end
------------------------------------------------------------
--si g les explosifs alors jue lance la cinématioque montrant les ennemis passant sur la passerelle
function Cam_intrusion()

_idCam_intrusion=GetCamTransitionID("CamTransition_intrusion")

	if(_bCam_intrusion==0)then
		if(_bOnEnter_Sector_Event_Church_ext1==1)then
			--LaunchCameraTransition(_idCam_intrusion)
			_bCam_intrusion=1
		end
	end
end
-------------------------------------------------------------
-- On freeze les gars que l'on ne voit pas depuis cette boite
function OnEnter_Sector_Event_Church_ext1(id)

	if(_bOnEnter_Sector_Event_Church_ext1==0)then
		if(GetLocalCharacterID("Player")==id)and(_bExplo_ok==true)then
			FreezeAll(_idGroup_UAN_Intrusion_01,false)
			Freeze(_idChar_WRF_barricades_Assault_1,true)
			Freeze(_idChar_WRF_barricades_Assault_2,true)

			Freeze(_idChar_WRF_barricades_Reserve_1,true)
			Freeze(_idChar_WRF_barricades_Reserve_2,true)
			FreezeAll(_idGroup_UAN_Front_01,true)
			FreezeAll(_idGroup_UAN_Front_03,true)
			FreezeAll(_idGroup_UAN_Front_04,true)
			Freeze(_idChar_WRF_Pretorian_00_1,true)
			_bOnEnter_Sector_Event_Church_ext1=1
		end
	end
end
----------------------------------------------------
--je defreeze le garde de la porte de l'eglise
function OnEnter_Sector_Event_Church_Right(id)

	if(_bOnEnter_Sector_Event_Church_Right==0)then
		if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_WRF_Church_Garde_1,false)
			_bOnEnter_Sector_Event_Church_Right=1
		end
	end
end
----------------------------------------------------------
--quand les ennemis devanyt les barricades sont moins nombreux , on en fait venir d'autres.
function Renforts_Rue()

_nRestGroup_UAN_Front_01=AliveMembersCount(_idGroup_UAN_Front_01)

	if(_bRenforts_Rue==0)then
		if (_nRestGroup_UAN_Front_01<=3)then
			FreezeAll(_idGroup_UAN_Front_03,false)
			_bRenforts_Rue=1
		end
	end
end
-------------------------------------------------------
--quand les ennemis devanyt les barricades sont moins nombreux , on en fait venir d'autres.
function Renforts_Rue_2()

_nRestGroup_UAN_Front_03=AliveMembersCount(_idGroup_UAN_Front_03)

	if(_bRenforts_Rue_2==0)then
		if (_nRestGroup_UAN_Front_03<=1)then
			FreezeAll(_idGroup_UAN_Front_04,false)
			_bRenforts_Rue_2=1
		end
	end
end
-------------------------------------------------------------
--En entrant dans la lumiere rouge je prend s les explosifs.
--[[
function OnEnter_Sector_Event_explosifs(id)

_idTimer_PARA=GetTimerID("Timer_PARA") 

_idPickUp_3=GetPickUpID("PickUp_3")

	if(_bOnEnter_Sector_Event_explosifs==0)then
		if(GetLocalCharacterID("Player")==id)then
			if (_idMerc[0] ~= nil) then
			MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_L_USWE_B_01",true,100,2,0.0,"",100)
			ObjectiveDoneNewObjectiveNewSubObjective ("Obj_A", "Obj_B", "Obj_B_1" )
			end
			--Freeze(_idPickUp_3,true)
			SetVarValue(_idTimer_PARA,"Active",true)
			_bExplo_ok=true
			_bOnEnter_Sector_Event_explosifs=1
			_bOnStay_Sector_Event_Porte_church=0
			else _bExplo_ok=false
		end
	end
end
--]]

function Player_Take_explosifs()

_idTimer_PARA=GetTimerID("Timer_PARA") 

_idPickUp_3=GetPickUpID("PickUp_3")

	if(_bOnEnter_Sector_Event_explosifs==0)then
		--if(GetLocalCharacterID("Player")==id)then
			if (_idMerc[0] ~= nil) then
				MakeCharacterSpeak(_idMerc[0],_idPlayer,"DIA_SPE_NIV_L_USWE_B_01",true,100,2,0.0,"",100)	
			end
			ObjectiveDoneNewObjectiveNewSubObjective ("Obj_A", "Obj_B", "Obj_B_1" )
			--Freeze(_idPickUp_3,true)
			SetVarValue(_idTimer_PARA,"Active",true)
			_bExplo_ok=true
			_bOnEnter_Sector_Event_explosifs=1
			_bOnStay_Sector_Event_Porte_church=0
			else _bExplo_ok=false
		--end
	end
end
--------------------------------------------------------------
-- Si j'ai pris les explosifs et que je suis devant la porte de l'eglise alors
-- je peux rentrer, sinon le garde reste devant la porte et je ne peux pas passer.  
function OnStay_Sector_Event_Porte_church(id)

_idDoor_63=GetDoorID("Door_63")

	if(_bOnStay_Sector_Event_Porte_church==0)then
		if(GetLocalCharacterID("Player")==id)and(_bExplo_ok==true)then
			MakeCharacterSpeak(_idChar_WRF_Church_Garde_1,_idPlayer,"DIA_SPE_NIV_L_USWE_C_02",true,95,1,0.0,"",95)	
			SetVarValue(_idChar_WRF_Church_Garde_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_military_salut_1"))	
			UnLockDoor(_idDoor_63)
			OpenDoor(_idDoor_63)
			_bOnStay_Sector_Event_Porte_church=1
		elseif(GetLocalCharacterID("Player")==id)and(_bExplo_ok==false)then
		 MakeCharacterSpeak(_idChar_WRF_Church_Garde_1,_idPlayer,"DIA_SPE_NIV_L_USWE_G_03",true,95,1,0.0,"",95)
		SetVarValue(_idChar_WRF_Church_Garde_1,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_military_salut"))
		_bOnStay_Sector_Event_Porte_church=1
		end
	end
end

-------------------------------------------------------
-- On freeze les gars que l'on ne voit pas depuis cette boite
--je defreeze le colonel
function OnStay_Sector_Event_Tente_Colonel(id)
	
	if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_WRF_COLONEL,false)
			Freeze(_idChar_WRF_barricades_Assault_1,true)
			Freeze(_idChar_WRF_barricades_Assault_2,true)

			Freeze(_idChar_WRF_barricades_Reserve_1,true)
			Freeze(_idChar_WRF_barricades_Reserve_2,true)
			Freeze(_idChar_WRF_barricades_Reserve_3,true)

			Freeze(_idChar_WRF_kfe,true)
			Freeze(_idChar_WRF_Camp_00_1,true)
			Freeze(_idChar_WRF_CaissesB_Garde_1,true)
			FreezeAll(_idGroup_UAN_Front_01,true)
			FreezeAll(_idGroup_UAN_Front_03,true)
			FreezeAll(_idGroup_UAN_Front_04,true)
			FreezeAll(_idGroup_WRF_Patrouille_01,true)
			FreezeAll(_idGroup_WRF_Patrouille_02,true)
	end
end
------------------------------------------------------------
-- On defreeze les gars que l'on peut voir en sortant de la tente du colonel

function OnExit_Sector_Event_Tente_Colonel(id)
	
	if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_WRF_barricades_Reserve_3,false)
			Freeze(_idChar_WRF_barricades_Assault_1,false)
			Freeze(_idChar_WRF_barricades_Assault_2,false)

			Freeze(_idChar_WRF_barricades_Reserve_1,false)
			Freeze(_idChar_WRF_barricades_Reserve_2,false)

			Freeze(_idChar_WRF_kfe,false)
			Freeze(_idChar_WRF_Camp_00_1,false)
			Freeze(_idChar_WRF_CaissesB_Garde_1,false)

	end
end
------------------------------------------------------------
-- On freeze les gars que l'on ne voit pas depuis cette boite
function OnStay_Sector_Event_Tente_1(id)

		if(GetLocalCharacterID("Player")==id)then
		Freeze(_idChar_WRF_barricades_Assault_1,true)
			Freeze(_idChar_WRF_barricades_Assault_2,true)

			Freeze(_idChar_WRF_barricades_Reserve_1,true)
			Freeze(_idChar_WRF_barricades_Reserve_2,true)

			FreezeAll(_idGroup_UAN_Front_01,true)
			FreezeAll(_idGroup_UAN_Front_03,true)
			FreezeAll(_idGroup_UAN_Front_04,true)
			FreezeAll(_idGroup_WRF_Patrouille_01,true)
			FreezeAll(_idGroup_WRF_Patrouille_02,true)
		 
	end
end
--------------------------------------------------------------
--Je defreeze en sortant de cette boite les gars des barricades
--je freeze ceux que je peux pas voir
function OnExit_Sector_Event_Tente_1(id)

		if(GetLocalCharacterID("Player")==id)then
				Freeze(_idChar_WRF_barricades_Assault_1,false)
				Freeze(_idChar_WRF_barricades_Assault_2,false)

				Freeze(_idChar_WRF_barricades_Reserve_1,false)
				Freeze(_idChar_WRF_barricades_Reserve_2,false)

				FreezeAll(_idGroup_UAN_Front_01,true)
				FreezeAll(_idGroup_UAN_Front_03,true)
				FreezeAll(_idGroup_UAN_Front_04,true)
				FreezeAll(_idGroup_WRF_Patrouille_01,true)
				FreezeAll(_idGroup_WRF_Patrouille_02,true)
	end
end			
-------------------------------------------------------------------------
-- On freeze les gars que l'on ne voit pas depuis l'intérieur de l'infirmerie

function OnEnter_Sector_Event_INFIRMERIE(id)

	if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_WRF_barricades_Assault_1,true)
			Freeze(_idChar_WRF_barricades_Assault_2,true)

			Freeze(_idChar_WRF_barricades_Reserve_1,true)
			Freeze(_idChar_WRF_barricades_Reserve_2,true)
			Freeze(_idChar_WRF_barricades_Reserve_3,true)

			FreezeAll(_idGroup_UAN_Front_01,true)
			FreezeAll(_idGroup_UAN_Front_03,true)
			FreezeAll(_idGroup_UAN_Front_04,true)
			FreezeAll(_idGroup_WRF_Patrouille_01,true)
			FreezeAll(_idGroup_WRF_Patrouille_02,true)

		end
end
-----------------------------------------------------------
--je defrreeze les gars proche de la barricade
function OnExit_Sector_Event_INFIRMERIE(id)

	if(GetLocalCharacterID("Player")==id)then
				Freeze(_idChar_WRF_barricades_Assault_1,false)
				Freeze(_idChar_WRF_barricades_Assault_2,false)

				Freeze(_idChar_WRF_barricades_Reserve_1,false)
				Freeze(_idChar_WRF_barricades_Reserve_2,false)
				Freeze(_idChar_WRF_barricades_Reserve_3,false)

	end
end
---------------------------------------------------------------
-- On freeze les gars que l'on ne voit pas depuis cette boite
--et ddefreeze ceux de l'eglise : garde à la porte garde à l'intérieur.
function OnEnter_Sector_Event_Back_Church(id)


		if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_WRF_Church_Garde_1,false)
			Freeze(_idChar_WRF_Church_Garde_2,false)
			Freeze(_idChar_WRF_barricades_Assault_1,true)
			Freeze(_idChar_WRF_barricades_Assault_2,true)

			Freeze(_idChar_WRF_barricades_Reserve_1,true)
			Freeze(_idChar_WRF_barricades_Reserve_2,true)
			Freeze(_idChar_WRF_barricades_Reserve_3,true)
			Freeze(_idChar_WRF_Pretorian_00_1,true)
			FreezeAll(_idGroup_UAN_Front_01,true)
			FreezeAll(_idGroup_UAN_Front_03,true)
			FreezeAll(_idGroup_UAN_Front_04,true)
			Freeze(_idChar_WRF_kfe,true)
			Freeze(_idChar_WRF_Camp_00_1,true)
			Freeze(_idChar_WRF_CaissesB_Garde_1,true)	
			Freeze(_idChar_WRF_COLONEL,true)
			FreezeAll(_idGroup_WRF_Patrouille_01,true)
			FreezeAll(_idGroup_WRF_Patrouille_02,true)


	end
end
-----------------------------------------------------------------------
-- On freeze les gars que l'on ne voit pas depuis cette boite
function OnEnter_Sector_Event_Armurerie(id)


	if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_WRF_barricades_Assault_1,true)
			Freeze(_idChar_WRF_barricades_Assault_2,true)

			Freeze(_idChar_WRF_barricades_Reserve_1,true)
			Freeze(_idChar_WRF_barricades_Reserve_2,true)
			Freeze(_idChar_WRF_barricades_Reserve_3,true)

			FreezeAll(_idGroup_UAN_Front_01,true)
			FreezeAll(_idGroup_UAN_Front_03,true)
			FreezeAll(_idGroup_UAN_Front_04,true)
			Freeze(_idChar_WRF_Camp_00_1,true)
			Freeze(_idChar_WRF_CaissesB_Garde_1,true)	
			Freeze(_idChar_WRF_COLONEL,true)
			Freeze(_idChar_WRF_Pretorian_00_1,true)
	end
end
-----------------------------------------------------------------------
--quand je sors de l'armurerie je defreeze les gars que je suis susceptible de voir
function OnExit_Sector_Event_Armurerie(id)


	if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_WRF_barricades_Assault_1,false)
			Freeze(_idChar_WRF_barricades_Assault_2,false)

			Freeze(_idChar_WRF_barricades_Reserve_1,false)
			Freeze(_idChar_WRF_barricades_Reserve_2,false)
			Freeze(_idChar_WRF_barricades_Reserve_3,false)

			--FreezeAll(_idGroup_UAN_Front_01,false)
			--FreezeAll(_idGroup_UAN_Front_03,false)
			--FreezeAll(_idGroup_UAN_Front_04,false)
			Freeze(_idChar_WRF_Camp_00_1,false)
			Freeze(_idChar_WRF_CaissesB_Garde_1,false)	
			--Freeze(_idChar_WRF_COLONEL,false)
			Freeze(_idChar_WRF_Pretorian_00_1,false)

	end
end
----------------------------------------------------------
-- On freeze les gars que l'on ne voit pas depuis cette boite
function OnEnter_Sector_Event_stairs_church(id)

	if(_bOnEnter_Sector_Event_stairs_church==0)then
		if(GetLocalCharacterID("Player")==id)then
			FreezeAll(_idGroup_UAN_Intrusion_02,false)
			Freeze(_idChar_WRF_barricades_Assault_1,true)
			Freeze(_idChar_WRF_barricades_Assault_2,true)

			Freeze(_idChar_WRF_barricades_Reserve_1,true)
			Freeze(_idChar_WRF_barricades_Reserve_2,true)
			Freeze(_idChar_WRF_barricades_Reserve_3,true)

			FreezeAll(_idGroup_UAN_Front_01,true)
			FreezeAll(_idGroup_UAN_Front_03,true)
			FreezeAll(_idGroup_UAN_Front_04,true)
			Freeze(_idChar_WRF_Camp_00_1,true)
			Freeze(_idChar_WRF_CaissesB_Garde_1,true)	
			Freeze(_idChar_WRF_COLONEL,true)
			Freeze(_idChar_WRF_Pretorian_00_1,true)

			FreezeAll(_idGroup_WRF_Patrouille_01,true)
			FreezeAll(_idGroup_WRF_Patrouille_02,true)
		_bOnEnter_Sector_Event_stairs_church=1
		end
	end
end
-----------------------------------------------------------
--Quand je rentre dans l'église je defreeze deux ennemis qui vont tuer les alliés dans l'église
function OnEnter_Sector_Event_church(id) 

	if(_bOnEnter_Sector_Event_church==0)then
		if(id==_idChar_WRF_Church_Garde_1) then
			Freeze(_idChar_UAN_Intrusion_00_1,false)
			Freeze(_idChar_UAN_Intrusion_00_2,false)
			_bOnEnter_Sector_Event_church=1
		end
	end
end
---------------------------------------------------------------
--defreezer des ennemis quand j'auit ué les premiers ennemis dans le clocher
function Renforts_church()

_bAliveChar_UAN_Intrusion_00_1=IsAlive(_idChar_UAN_Intrusion_00_1)

	if(_bRenforts_church==0)then
		if(_bAliveChar_UAN_Intrusion_00_1==false)then
			FreezeAll(_idGroup_UAN_Intrusion_03,false)
			_bRenforts_church=1
		end
	end
end
---------------------------------------------------------------
--defreezer des ennemis quand je rentre dans le clocher
function OnEnter_Sector_Event_clocher(id)

	if(_bOnEnter_Sector_Event_clocher==0) then
		if(GetLocalCharacterID("Player")==id)then
			FreezeAll(_idGroup_UAN_Intrusion_03,false)
			_bOnEnter_Sector_Event_clocher=1
		end
	end
end
-----------------------------------------------------------------
-- On freeze les gars que l'on ne voit pas depuis cette boite
function OnStay_Sector_Event_freeze(id)


	if(GetLocalCharacterID("Player")==id)then
			Freeze(_idChar_WRF_barricades_Assault_1,true)
			Freeze(_idChar_WRF_barricades_Assault_2,true)

			Freeze(_idChar_WRF_barricades_Reserve_1,true)
			Freeze(_idChar_WRF_barricades_Reserve_2,true)
			Freeze(_idChar_WRF_barricades_Reserve_3,true)
			Freeze(_idChar_WRF_Pretorian_00_1,true)
			FreezeAll(_idGroup_UAN_Front_01,true)
			FreezeAll(_idGroup_UAN_Front_03,true)
			FreezeAll(_idGroup_UAN_Front_04,true)
			Freeze(_idChar_WRF_CaissesB_Garde_1,true)	
			Freeze(_idChar_WRF_COLONEL,true)
	end
end


-- le premier tank se réinitialise
-- Security tank
-- Si Nolan passe le tank devient très dangereux
function OnEnter_Sector_Event_Secure_Tank(idEntrant)
	_nHealth_Tank	= GetVarValue(_idTank_1,"Health")
	if (idEntrant==_idPlayer) then
		if (_nHealth_Tank > 0) then
			SetVarValue(_idTank_1,"Rotation Speed",60)
			SetVarValue(_idTank_1,"Shoot Delay",0.75)
			TankTargetEntity(_idTank_1,_idPlayer)
		end
	end
end


function OnExit_Sector_Event_Secure_Tank(idEntrant)
	_nHealth_Tank	= GetVarValue(_idTank_1,"Health")
	if (idEntrant==_idPlayer) then
		if (_nHealth_Tank > 0) then
			SetVarValue(_idTank_1,"Rotation Speed",60)
			SetVarValue(_idTank_1,"Shoot Delay",2.0)
			TankFireAtPosition(_idTank_1,Vector3D(1340.839111,305.400513,30.734262))	
		end
	end
end









