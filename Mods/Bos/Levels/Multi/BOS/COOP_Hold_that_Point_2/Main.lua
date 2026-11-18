--
function InitLevel()
	CheckInitLevel_hold_that_point_2()

-------------------------------------------------------------
-- :::: MERCENAIRES :::::::::::::::::::::::::::::::::::::: --
-------------------------------------------------------------
	-- Récupère les ID des Mercs actifs et leur colle une AIOL
	_idMerc={}
	number = GetMercenaryCount() 
	number = number - 1
	for i=0,number,1 do
		_idMerc[i] = GetMercenary(i) 
	--	SetVarValue(_idMerc[i],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Follow_Player"))
	end


--------------------------------------------------------------------
-- :::::::: Vie Player - Vie et Armure Mercenaires... ETC ::::::: --
--------------------------------------------------------------------

	GlobalGivePlayerHealth()
	GlobalGiveMercenaryHealth()
	ActiveTrackingMercs()


	InitScriptVariable()
	InitLevel_Corridor()
	InitLevel_Hide()
	InitLevel_Explosion()
	InitLevel_Hangar()
	InitScriptVariable_Hide()

end


--
function UpdateLevel()
	Alive()
	UpdateLevel_Hide()
	UpdateLevel_Corridor()
	UpdateLevel_Hangar()


	Change_Bot_behavior("Char_UAN_Corridor_1_1",80,50,"AI_Order_List_Force_Attack_Player")
	Change_Bot_behavior("Char_UAN_Corridor_1_3",80,50,"AI_Order_List_Force_Attack_Player")
	Change_Bot_behavior("Char_UAN_Corridor_1_4",30,30,"AI_Order_List_Force_Attack_Player")
	Change_Bot_behavior("Char_UAN_Corridor_3_2",80,50,"AI_Order_List_Force_Attack_Player")
	Change_Bot_behavior("Char_UAN_Corridor_3_1",80,50,"AI_Order_List_Force_Attack_Player")
	Change_Bot_behavior("Char_UAN_Hide_9_1",80,50,"AI_Order_List_Force_Attack_Player")
	Change_Bot_behavior("Char_UAN_Hide_9_2",80,50,"AI_Order_List_Force_Attack_Player")
	Change_Bot_behavior("Char_UAN_Heliport_4_1",80,50,"AI_Order_List_Force_Attack_Player")


-------------------------------------------------------------
-- :::::::: mort Player - mort INGENIEUR - ...ETC ::::::: --
-------------------------------------------------------------
	GlobalIngenieurIsDead()
	GlobalPlayerIsDead()
	DesactiveTrackingMercs()


	if (GetExoskeletonHealth(GetExoskeletonID("Exo_UAN_Hangar_2")) <= 0) and ( _bExoIsDestroyed == 0) then
		MissionFailed ("HUD_MISSION_FAILED_REASON_04")
		_bExoIsDestroyed = 1
	end
	
	--debug bot actif
	_nBotActifs = GetTotalActiveCharacterCount()
	--PrintDebug("_nSpawnHide = " .. 	_nSpawnHide )

end


-- 
function InitScriptVariable()
	_idMusic														= GetSound_ClientID("Sound_Client_Music")
	_idPlayer														= GetCharacterID("Player")
	-- Si l'exo a été volé ou pas
	_bVolExo														= false
	_bOnEnter_Sector_Hide_5 						= 0
	_bOnEnter_Sector_Heliport_1					= 0
	_bOnEnter_Sector_Heliport_2					= 0
	_bOnEnter_Sector_Hide_4							= 0
	_bExoIsDestroyed										= 0


	TankTargetEntity(GetTankID("Tank_01"),_idPlayer)
	TankTargetEntity(GetTankID("Tank_02"),_idPlayer)
end


--
function Alive()
	PrintDebug("\n\nActifs : "..GetTotalActiveCharacterCount().."\n\n")
end


-- Freeze des persos inutiles
function Optimisitron()
	-- Optimisadin des persos
	FreezeAll(GetGroupID("Grp_WRF_Corridor_1"),true)
--	FreezeAll(GetGroupID("Grp_WRF_Corridor_2"),true)
	FreezeAll(GetGroupID("Grp_UAN_Corridor_1"),true)
	FreezeAll(GetGroupID("Grp_UAN_Corridor_2"),true)
	FreezeAll(GetGroupID("Grp_UAN_Corridor_3"),true)
	FreezeAll(GetGroupID("Grp_UAN_Corridor_4"),true)
	FreezeAll(GetGroupID("Grp_UAN_Hide_1"),true)
	FreezeAll(GetGroupID("Grp_UAN_Hide_2"),true)
	FreezeAll(GetGroupID("Grp_UAN_Hide_3"),true)
	FreezeAll(GetGroupID("Grp_UAN_Hide_4"),true)
	FreezeAll(GetGroupID("Grp_UAN_Hide_5"),true)
	FreezeAll(GetGroupID("Grp_UAN_Hide_6"),true)
	FreezeAll(GetGroupID("Grp_UAN_Hide_7"),true)
	FreezeAll(GetGroupID("Grp_UAN_Hide_8"),true)
	FreezeAll(GetGroupID("Grp_UAN_Hide_9"),true)
	FreezeAll(GetGroupID("Grp_UAN_Hide_Sniper_1"),true)
	FreezeAll(GetGroupID("Grp_UAN_Heliport_1"),true)
	FreezeAll(GetGroupID("Grp_UAN_Heliport_2"),true)
	FreezeAll(GetGroupID("Grp_UAN_Heliport_2"),true)
	FreezeAll(GetGroupID("Grp_UAN_Heliport_4"),true)
end