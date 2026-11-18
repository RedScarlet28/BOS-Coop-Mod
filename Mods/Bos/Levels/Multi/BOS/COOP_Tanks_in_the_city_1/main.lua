function InitLevel()
	CheckInitLevel_tanks_in_the_city_1()

--------------------------------------------------------------
---::::: PRECACHAGE DES DIALOGUES ::::------------------------
--------------------------------------------------------------

	Precache_Dials()
	ConfigMerc()

end


function OnMissionBegins()


-------------------------------------------------------------
-- :::: MERCENAIRES :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------

		-- Récupère les ID des Mercs actifs et leur colle une AIOL
		_idMerc={}
		number = GetMercenaryCount() 
		number = number - 1
		for i=0,number,1 do
				_idMerc[i] = GetMercenary(i) 
				_idPasDeList=GetInvalidEntityID()
				SetVarValue(_idMerc[i],"CharacterOrderList",_idPasDeList)
		end

		_bAliveGroup_UAN_PARA_01=true
		_bAliveGroup_UAN_PARA_02=true
		_bAliveGroup_UAN_PARA_03=true
				
				
	
	InitScriptVariable()
	StartMusic("Sounds//Music//BoS - Cuba Theme 1.wav",true)

--------------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires... ETC ::::::: --
--------------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	ActiveTrackingMercs()


	Cine_Debut ()


end
---------------------------------------------------
---------------------------------------------------
function UpdateLevel()


Alerte_Para_1()
Alerte_Para_2()
--Renforts()
Renforts_church()
OBJ_SUITE()
--Renforts_Paras_1()
--Show_Objective()
Go_tente()
Renforts_Rue()
Renforts_Rue_2()
Cam_intrusion()
Passage_libre()
--Show_Objective()
---DEBUG BOTactiv
   
PrintDebug("Nb.de Bots : "..GetTotalActiveCharacterCount().."\n actifs")

-------------------------------------------------------------
-- :::::::: mort Player - mort INGENIEUR - ...ETC ::::::: --
-------------------------------------------------------------
	GlobalPlayerIsDead()
	DesactiveTrackingMercs()
				

end

--[[ On initialise toutes les variables globales à un niveau
	(toutes les variables nommées _NomDeVariable) 
	dans cette fonction appelée dans InitLevel() --]]

function InitScriptVariable()
	_idPlayer = GetLocalCharacterID(Player)


	_idSound_Client_helico=GetSound_ClientID("Sound_Client_helico")
	_idTank_1=GetTankID("Tank_1")
	-----------------barricades----------------------------------
	--INVDUS--
	_idChar_WRF_barricades_Assault_1=GetCharacterID("Char_WRF_barricades_Assault_1")
	_idChar_WRF_barricades_Assault_2=GetCharacterID("Char_WRF_barricades_Assault_2")

	_idChar_WRF_kfe=GetCharacterID("Char_WRF_kfe")
	_idChar_WRF_CaissesB_Garde_1=GetCharacterID("Char_WRF_CaissesB_Garde_1")
	_idChar_WRF_Camp_00_1=GetCharacterID("Char_WRF_Camp_00_1")
	_idChar_WRF_COLONEL=GetCharacterID("Char_WRF_COLONEL")
	_idChar_WRF_barricades_Reserve_1=GetCharacterID("Char_WRF_barricades_Reserve_1")
	_idChar_WRF_barricades_Reserve_2=GetCharacterID("Char_WRF_barricades_Reserve_2")
	_idChar_WRF_barricades_Reserve_3=GetCharacterID("Char_WRF_barricades_Reserve_3")

	_idChar_UAN_PARA_01_1=GetCharacterID("Char_UAN_PARA_01_1")
	_idChar_UAN_PARA_01_2=GetCharacterID("Char_UAN_PARA_01_2")
	_idChar_UAN_PARA_01_3=GetCharacterID("Char_UAN_PARA_01_3")
	_idChar_UAN_PARA_02_1=GetCharacterID("Char_UAN_PARA_02_1")
	_idChar_UAN_PARA_02_2=GetCharacterID("Char_UAN_PARA_02_2")
	_idChar_UAN_PARA_02_3=GetCharacterID("Char_UAN_PARA_02_3")
	_idChar_UAN_PARA_03_1=GetCharacterID("Char_UAN_PARA_03_1")
	_idChar_UAN_PARA_03_2=GetCharacterID("Char_UAN_PARA_03_2")
	_idChar_UAN_PARA_03_3=GetCharacterID("Char_UAN_PARA_03_3")
	_idChar_UAN_PARA_04_1=GetCharacterID("Char_UAN_PARA_04_1")
	_idChar_UAN_PARA_04_2=GetCharacterID("Char_UAN_PARA_04_2")
	_idChar_UAN_PARA_04_3=GetCharacterID("Char_UAN_PARA_04_3")
	_idChar_WRF_Pretorian_00_1=GetCharacterID("Char_WRF_Pretorian_00_1")


	--GROUP
	_idGroup_UAN_Front_01=GetGroupID("Group_UAN_Front_01")	
	_idGroup_UAN_Front_03=GetGroupID("Group_UAN_Front_03")
	_idGroup_UAN_Front_04=GetGroupID("Group_UAN_Front_04")
	_idGroup_WRF_Reserve=GetGroupID("Group_WRF_Reserve")
	_idGroup_UAN_PARA_01=GetGroupID("Group_UAN_PARA_01")
	_bAliveGroup_UAN_PARA_01=IsAlive(_idGroup_UAN_PARA_01)
	_idGroup_UAN_PARA_02=GetGroupID("Group_UAN_PARA_02")
	_bAliveGroup_UAN_PARA_02=IsAlive(_idGroup_UAN_PARA_02)
	_idGroup_UAN_PARA_03=GetGroupID("Group_UAN_PARA_03")
	_bAliveGroup_UAN_PARA_03=IsAlive(_idGroup_UAN_PARA_03)
	_idGroup_UAN_PARA_04=GetGroupID("Group_UAN_PARA_04")
	_idGroup_WRF_Patrouille_01=GetGroupID("Group_WRF_Patrouille_01")
	_idGroup_WRF_Patrouille_02=GetGroupID("Group_WRF_Patrouille_02")

	-------------------CHURCH----------------------------

	--INVDUS
	_idChar_WRF_Church_Garde_1=GetCharacterID("Char_WRF_Church_Garde_1")
	_idChar_WRF_Church_Garde_2=GetCharacterID("Char_WRF_Church_Garde_2")
	_idChar_UAN_Intrusion_00_1=GetCharacterID("Char_UAN_Intrusion_00_1")
	_idChar_UAN_Intrusion_00_2=GetCharacterID("Char_UAN_Intrusion_00_2")
	--GROUP

	_idGroup_UAN_Intrusion_01=GetGroupID("Group_UAN_Intrusion_01")
	_idGroup_UAN_Intrusion_02=GetGroupID("Group_UAN_Intrusion_02")	
	_idGroup_UAN_Intrusion_03=GetGroupID("Group_UAN_Intrusion_03")	
	--_idGroup_WRF_Church_01=GetGroupID("Group_WRF_Church_01")

-----------------------------------------------------------------------
	_bOnEnter_Sector_Event_Church_ext=0
	_bGo_tente=0
	_bOnEnter_Sector_Event_Church_ext1=0
	_bOnStay_Sector_Event_Player=0
	_bOnStay_Sector_Event_COLONEL=0
	_bOnStay_Sector_Event_CaissesA=0
	_bOnStay_Sector_Event_caissesB=0
	_bOnExit_Sector_Event_Player=0
	_bOnEnter_Sector_Event_CaissesA=0
	_bOnExit_Sector_Event_RESERVE=0
	_bAlerte_Para_1=0
	_bAlerte_Para_2=0
	_bOnEnter_Sector_Event_church=0
	_bOnEnter_Sector_Event_Church_Right=0
	_bRenforts_Rue=0
	_bRenforts_Rue_2=0
	_bCam_intrusion=0
	_bOnEnter_Sector_Event_explosifs=0
	_bOnStay_Sector_Event_Porte_church=0
	_bPassage_libre=0
	_bRenforts_Paras_1=0
	_bParas=0
	_bRenforts_Paras_2=0
	_bOnEnter_Sector_Event_stairs_church=0
	_bRenforts_church=0
	_bOnEnter_Sector_Event_clocher=0
	_bShow_Objective=0
	_bOnExit_Sector_Event_COLONEL=0
	_bOnEnter_Sector_Event_COLONEL=0
	_bOBJ_SUITE=0
	_bMaVie=0
	_bTestGENERAL_RADIO_13=0
end
-------------------------------------------------------------------------
function Precache_Dials()

PrecacheSentence("DIA_SPE_NIV_L_MERCE_A_01")
PrecacheSentence("DIA_SPE_NIV_L_MERCE_B_01")

PrecacheSentence("DIA_SPE_NIV_D_GENERAL_09")
PrecacheSentence("DIA_SPE_NIV_L_GENERAL_RADIO_12")
PrecacheSentence("DIA_SPE_NIV_L_GENERAL_RADIO_13")

PrecacheSentence("DIA_SPE_NIV_L_USWE_A_01")
PrecacheSentence("DIA_SPE_NIV_L_USWE_B_01")
PrecacheSentence("DIA_SPE_NIV_L_USWE_C_02")
PrecacheSentence("DIA_SPE_NIV_L_USWE_D_01")
PrecacheSentence("DIA_SPE_NIV_L_USWE_D_02")
PrecacheSentence("DIA_SPE_NIV_L_USWE_E_01")
PrecacheSentence("DIA_SPE_NIV_L_USWE_F_02")
PrecacheSentence("DIA_SPE_NIV_L_USWE_G_03")

PrecacheSentence("DIA_SPE_NIV_L_MORIS_01")
PrecacheSentence("DIA_SPE_NIV_L_MORIS_01_C")
end