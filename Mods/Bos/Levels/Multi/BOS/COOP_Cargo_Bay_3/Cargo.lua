function UpdateLevel_Cargo()
end
----------------------------------------------
--quand le joueur tombe dans le conduit il defrreze 2 gars dans le niveau du dessous
--
function OnEnter_Sector_Event_Cargo_Shift(id)

_idAlarm=GetSound_ClientID("Sound_Client_Alarme")

	if(_bOnEnter_Sector_Event_Cargo_Shift==0)then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Cargo_Shift) then
		Freeze(_idChar_UAN_Cargo_lvl2_01_1,false)
	--	SetVarValue(_idMerc[0],"Position",Vector3D(-1664.111084,-194.761414,163.136169))
		--	if(_idMerc[1]~=nil)then
		--		SetVarValue(_idMerc[1],"Position",Vector3D(-1660.387085,-226.297165,153.694214))
		--	end
		_b_yetOnEnter_Sector_Event_Cargo_Shift=true
		_bOnEnter_Sector_Event_Cargo_Shift=1
		end
	end
end



---------SOUND IN ET OUT
function OnEnter_Sector_Event_Cargo_Sound_01(id)
		if(GetLocalCharacterID("Player")==id) and (_bPlayerIsInCargo ~= 1)then
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_01"),"Volume",0.0)

			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_01"),"Volume",0.4)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_02"),"Volume",0.4)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_03"),"Volume",0.4)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_04"),"Volume",0.4)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_05"),"Volume",0.4)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_06"),"Volume",0.4)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_07"),"Volume",0.4)
			SetVarValue(GetSound_ClientID("Sound_Client_Sea"),"Volume",0.6)
			SetVarValue(GetSound_ClientID("Sound_Wind"),"Volume",0.6)

			_bPlayerIsInCargo = 1
		end
end


function OnEnter_Sector_Event_Cargo_Sound_02(id)
		if(GetLocalCharacterID("Player")==id) and (_bPlayerIsInCargo ~= 2) then

			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_01"),"Volume",0.2)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_02"),"Volume",0.2)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_03"),"Volume",0.2)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_04"),"Volume",0.2)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_05"),"Volume",0.2)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_06"),"Volume",0.2)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_07"),"Volume",0.2)
			SetVarValue(GetSound_ClientID("Sound_Client_Sea"),"Volume",0.3)
			SetVarValue(GetSound_ClientID("Sound_Wind"),"Volume",0.3)		
			
			_bPlayerIsInCargo = 2
		end
end

function OnEnter_Sector_Event_Cargo_Sound_03(id)
		if(GetLocalCharacterID("Player")==id) and (_bPlayerIsInCargo ~= 3) then
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_01"),"Volume",0.0)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_02"),"Volume",0.0)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_03"),"Volume",0.0)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_04"),"Volume",0.0)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_05"),"Volume",0.0)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_06"),"Volume",0.0)
			SetVarValue(GetSound_ClientID("Sound_Client_SeaGull_07"),"Volume",0.0)
			SetVarValue(GetSound_ClientID("Sound_Client_Sea"),"Volume",0.0)
			SetVarValue(GetSound_ClientID("Sound_Wind"),"Volume",0.1)		
			_bPlayerIsInCargo = 3
		end
end


---------------------------------------------------
--defrrezze 2 ennemis 
function OnEnter_Sector_Event_Cargo_lvl3(id)
	if(_bOnEnter_Sector_Event_Cargo_lvl3==0)then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Cargo_lvl3) then
		Freeze(_idChar_UAN_Cargo_lvl3_01_4,false)
		_b_yetOnEnter_Sector_Event_Cargo_lvl3=true
		_bOnEnter_Sector_Event_Cargo_lvl3=1
		end
	end
end
----------------------------------------------------
--Quand le joueur est sur la passerelle,l'ingénieur dit un mesage et va poser la bombe un dernier garde est defrezze

function OnEnter_Sector_Event_Pass2(id)


	if(_bOnEnter_Sector_Event_Pass2==0)then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Pass2)then
			Freeze(_idChar_UAN_Pass_2_00_3,false)
			
					RadioMessage("DIA_SPE_NIV_H_INGENIEUR_15",true,95,0.0,"")
					SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Goto_Waypoint_DCA2"))
					EnableCharacterCommand(_idMerc[0],true)
					MiniMapTrack(_idObj_A_2,2,false)
			_b_yetOnEnter_Sector_Event_Pass2=true
			_bOnEnter_Sector_Event_Pass2=1
		end
	end
end
-----------------------------------------------------
--2 ennemis defreeze
--
function OnEnter_Sector_Event_Cargo_lvl1_1(id)
	if(_bOnEnter_Sector_Event_Cargo_lvl1_1==0) then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Cargo_lvl1_1) then
		Freeze(_idChar_UAN_Cargo_lvl1_01_4,false)
		Freeze(_idChar_UAN_Cargo_lvl1_01_5,false)
		MakeCharacterSpeak(_idChar_UAN_Cargo_lvl1_01_5,_idPlayer,"DIA_SPE_NIV_H_UAN_F_01",false,100,2,0.0,"",100)
		_b_yetOnEnter_Sector_Event_Cargo_lvl1_1=true
		_bOnEnter_Sector_Event_Cargo_lvl1_1=1
		end
	end
end
--------------------------------------------------------
-- 1 ennemi defreeze
function OnEnter_Sector_Event_Cargo_lvl1_2(id)
	if(_bOnEnter_Sector_Event_Cargo_lvl1_2==0) then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Cargo_lvl1_2) then
		Freeze(_idChar_UAN_Cargo_lvl1_01_2,false)
		_b_yetOnEnter_Sector_Event_Cargo_lvl1_2=true
		_bOnEnter_Sector_Event_Cargo_lvl1_2=1
		end
	end
end
-----------------------------------------------------
--1 ennemi defreeze
function OnEnter_Sector_Event_Cargo_lvl1_3(id)
	if(_bOnEnter_Sector_Event_Cargo_lvl1_3==0) then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Cargo_lvl1_3) then
		Freeze(_idChar_UAN_Cargo_lvl1_01_1,false)
		_b_yetOnEnter_Sector_Event_Cargo_lvl1_3=true
		_bOnEnter_Sector_Event_Cargo_lvl1_3=1
		end
	end
end
-----------------------------------------------------
--2 ennemi defreeze
function OnEnter_Sector_Event_Cargo_lvl1_4(id)
	if(_bOnEnter_Sector_Event_Cargo_lvl1_4==0) then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Cargo_lvl1_4) then
		Freeze(_idChar_UAN_Cargo_lvl1_01_3,false)
		Freeze(_idChar_UAN_Cargo_lvl1_01_6,false)
		_b_yetOnEnter_Sector_Event_Cargo_lvl1_4=true
		_bOnEnter_Sector_Event_Cargo_lvl1_4=1

		end
	end
end
-----------------------------------------------------
--1 ennemi defreeze
function OnEnter_Sector_Event_Cargo_lvl2_1(id)
	if(_bOnEnter_Sector_Event_Cargo_lvl2_1==0) then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Cargo_lvl2_1) then
		Freeze(_idChar_UAN_Cargo_lvl2_01_3,false)
		_b_yetOnEnter_Sector_Event_Cargo_lvl2_1=true
		_bOnEnter_Sector_Event_Cargo_lvl2_1=1
		end
	end
end
-------------------------------------------------------
--2 ennemi defreeze
function OnEnter_Sector_Event_Cargo_lvl2_2(id)
	if(_bOnEnter_Sector_Event_Cargo_lvl2_2==0) then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Cargo_lvl2_2) then
		Freeze(_idChar_UAN_Cargo_lvl2_01_3,false)
		Freeze(_idChar_UAN_Cargo_lvl2_01_5,false)
		_b_yetOnEnter_Sector_Event_Cargo_lvl2_2=true
		_bOnEnter_Sector_Event_Cargo_lvl2_2=1

		end
	end
end
---------------------------------------------------------------------
--1 ennemi defreeze
function OnEnter_Sector_Event_Cargo_lvl2_3(id)
	if(_bOnEnter_Sector_Event_Cargo_lvl2_3==0) then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Cargo_lvl2_3) then
		Freeze(_idChar_UAN_Cargo_lvl2_01_4,false)
		_b_yetOnEnter_Sector_Event_Cargo_lvl2_3=true
		_bOnEnter_Sector_Event_Cargo_lvl2_3=1

		end
	end
end
------------------------------------------------------------------------
-----3 ennemi defreeze
function OnEnter_Sector_Event_Cargo_lvl4(id)
	if(_bOnEnter_Sector_Event_Cargo_lvl4==0) then
		if(GetLocalCharacterID("Player")==id)and not(_b_yetOnEnter_Sector_Event_Cargo_lvl4) then
		Freeze(_idChar_UAN_Cargo_lvl3_01_1,false)
		Freeze(_idChar_UAN_Cargo_lvl3_01_3,false)
		Freeze(_idChar_UAN_Cargo_lvl3_01_5,false)
		NewSubObjective("Obj_B_1","Obj_B_2")
		MiniMapTrack(_idObj_B_1,2,false)
		_b_yetOnEnter_Sector_Event_Cargo_lvl4=true
		_bOnEnter_Sector_Event_Cargo_lvl4=1
		end
	end
end
---------------------------------------------------------------
--l'ingénieur a finile posage de bombe ça va péter !!
function OnEnter_Sector_Event_bombing_zone(id)

--_idTimer_bomb=GetTimerID("Timer_bomb")

--_idTimer_see_charge_planted=GetTimerID("Timer_see_charge_planted")

	if(_bOnEnter_Sector_Event_bombing_zone==0) then
		if(_idMerc[0]==id)then
			CreationTimer(true,true,false,"Inge_Anim_plant",3.0)
--			SetVarValue(_idTimer_see_charge_planted,"Active",true)
--			SetVarValue(_idTimer_bomb,"Active",true)
			_bOnEnter_Sector_Event_bombing_zone=1
		end
	end
end
--------------------------
function Inge_Anim_plant()
_idExposive_Plant_Site=GetExposive_Plant_SiteID("Exposive_Plant_Site-15")
		PlantExplosive(_idExposive_Plant_Site)

end
-------------------------------------------------------
--function See_Charge_Planted()

--	_idPickUp=GetPickUpID("PickUp-3")

--	SetVarValue(_idPickUp,"Freeze",false)

--end
----------------------------------------------------------------
--l'inge va se planquer
function O_Abris()	
		
			RadioMessage("DIA_SPE_NIV_H_INGENIEUR_25",true,100,0.0,"")
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Goto_Waypoint_Porte_Cargo"))
		
end
----------------------------------------------------------------
---message de l'inge
function OnEnter_Sector_Event_SafePlace(id)

_idExposive_Plant_Site=GetExposive_Plant_SiteID("Exposive_Plant_Site-15")
--	_idPickUp=GetPickUpID("PickUp-3")
_idParticleFX_Client_dca=GetParticleFX_ClientID("ParticleFX_Client_dca")
_idParticleFX_Client_dca1=GetParticleFX_ClientID("ParticleFX_Client_dca1")
_idDestructible_Object_31=GetDestructible_ObjectID("Destructible_Object_31")

if(_bOnEnter_Sector_Event_SafePlace==0)then
		
		if((_idMerc[0]==id)and(_bOnEnter_Sector_Event_bombing_zone==1))then

		SetVarValue(_idExposive_Plant_Site,"Explosion Delay",0.0)
			SetVarValue(_idExposive_Plant_Site,"Active",false)
--[[
			_idExplo_DCA=CreateExplosion()
			SetVarValue(_idExplo_DCA,"Type","Explosion_Rocket_Bombardement")
			SetVarValue(_idExplo_DCA,"Position",Vector3D(-1863.759033,-575.182190,420))

			_idExplo_DCA_2=CreateExplosion()
			SetVarValue(_idExplo_DCA_2,"Type","Explosion_Rocket_Bombardement")
			SetVarValue(_idExplo_DCA_2,"Position",Vector3D(-1843.910034,-541.947083,450.076019))

			_idExplo_DCA_3=CreateExplosion()
			SetVarValue(_idExplo_DCA_3,"Type","Explosion_Rocket_Bombardement")
			SetVarValue(_idExplo_DCA_3,"Position",Vector3D(-1833.601074,-528.866089,416.869690))

			_idExplo_DCA_4=CreateExplosion()
			SetVarValue(_idExplo_DCA_4,"Type","Explosion_Rocket_Bombardement")
			SetVarValue(_idExplo_DCA_4,"Position",Vector3D(-1863.759033,-575.182190,486.402710))

			_idExplo_DCA_5=CreateExplosion()
			SetVarValue(_idExplo_DCA_5,"Type","Explosion_Rocket_Bombardement")
			SetVarValue(_idExplo_DCA_5,"Position",Vector3D(-1830.583984,-529.322571,443.079803))

			_idExplo_DCA_6=CreateExplosion()
			SetVarValue(_idExplo_DCA_6,"Type","Explosion_Rocket_Bombardement")
			SetVarValue(_idExplo_DCA_6,"Position",Vector3D(-1782.941040,-555.615173,418.668488))

			_idExplo_DCA_7=CreateExplosion()
			SetVarValue(_idExplo_DCA_7,"Type","Explosion_Rocket_Bombardement")
			SetVarValue(_idExplo_DCA_7,"Position",Vector3D(-1782.941040,-555.615173,418.668488))

			_idExplo_DCA_8=CreateExplosion()
			SetVarValue(_idExplo_DCA_8,"Type","Explosion_Rocket_Bombardement")
			SetVarValue(_idExplo_DCA_8,"Position",Vector3D(-1863.759033,-575.182190,486.402710))
--]]
			SetVarValue(_idParticleFX_Client_dca,"FxState","Fx Started")
			SetVarValue(_idParticleFX_Client_dca1,"FxState","Fx Started")

		CameraShake(1.0, 0.7, 0.7, 0.7)
		_bCtrlIngenieurIsDead = false
		SetVarValue(GetSound_ClientID("Sound_Client-482"),"Playing",true)

			RadioMessage("DIA_SPE_NIV_H_INGENIEUR_23",true,100,0.0,"")
			SetVarValue(_idDestructible_Object_31,"Destroyed",true)


	--		SetVarValue(_idPickUp,"Freeze",true)
	--		SetVarValue(_idPickUp,"Icon","<NONE>")
			
		_bOnEnter_Sector_Event_SafePlace=1

		end
	end
end
-----------------------------------------------------------------
--borne
function OnEnter_Sector_Event_Recharge3(id)
	if(GetLocalCharacterID("Player")==id)then
			ReloadArmor()
	end
end
-----------------------------------------------------------------
----Refreeze des gars du camp ecore vivants

function OnEnter_Sector_Event_Ascenseur(id)
	if(_bOnEnter_Sector_Event_Ascenseur==0) then
		if(GetLocalCharacterID("Player")==id)then --and
		--	(_bAlive_idChar_UAN_Gd_bat_lvl1_renforts_02_1==true)or
		--	(_bAlive_idChar_UAN_Gd_bat_lvl1_renforts_02_2==true)or
		--	(_bAlive_idChar_UAN_Gd_bat_lvl1_renforts_02_3==true)or
		--	(_bAlive_idChar_UAN_Gd_bat_lvl1_renforts_02_4==true)or
		--	(_bAlive_idChar_UAN_Gd_bat_lvl2_room1_01_1==true)or
			--(_bAlive_idChar_UAN_Gd_bat_lvl2_room1_01_2==true)or
			
			
--			(_bAlive_idChar_UAN_Gd_bat_lvl2_room1_01_5==true)or
		--	(_bAlive_idChar_UAN_Entrance_00_1==true)or
--			(_bAlive_idChar_UAN_Entrance_00_2==true)or
	--		(_bAlive_idChar_UAN_Entrance_00_3==true)or
		--	(_bAlive_idChar_UAN_C1_01_1==true)or
			--(_bAlive_idChar_UAN_C1_01_2==true)or
--			(_bAlive_idChar_UAN_C1_01_3==true)or
--			(_bAlive_idChar_UAN_GdBat_00_1==true)or
--			(_bAlive_idChar_UAN_GdBat_00_2==true)or
--			(_bAlive_idChar_UAN_GdBat_00_3==true)or
--			(_bAlive_idChar_UAN_GdBat_00_4==true)or
--			(_bAlive_idChar_UAN_GdBat_00_5==true)or
--			(_bAlive_idChar_UAN_GdBat_00_6==true)or
--			(_bAlive_idChar_UAN_C1_02_1==true)or
--			(_bAlive_idChar_UAN_C1_02_2==true)or
--			(_bAlive_idChar_UAN_C1_02_3==true)then
--				Freeze(_idChar_UAN_Gd_bat_lvl1_renforts_02_1,true)
--				Freeze(_idChar_UAN_Gd_bat_lvl1_renforts_02_2,true)
--				Freeze(_idChar_UAN_Gd_bat_lvl1_renforts_02_3,true)
		--		Freeze(_idChar_UAN_Gd_bat_lvl1_renforts_02_4,true)
				Freeze(_idChar_UAN_Gd_bat_lvl2_room1_01_1,true)
				Freeze(_idChar_UAN_Gd_bat_lvl2_room1_01_2,true)				
				
				
				Freeze(_idChar_UAN_Gd_bat_lvl2_room1_01_5,true)			
				Freeze(_idChar_UAN_Entrance_00_1,true)					
				Freeze(_idChar_UAN_Entrance_00_2,true)
				Freeze(_idChar_UAN_Entrance_00_3,true)				
				Freeze(_idChar_UAN_C1_01_1,true)
				Freeze(_idChar_UAN_C1_01_2,true)							
				Freeze(_idChar_UAN_C1_01_3,true)
				Freeze(_idChar_UAN_GdBat_00_1,true)
				Freeze(_idChar_UAN_GdBat_00_2,true)	
				Freeze(_idChar_UAN_GdBat_00_3,true)
				Freeze(_idChar_UAN_GdBat_00_4,true)
				Freeze(_idChar_UAN_GdBat_00_5,true)
				Freeze(_idChar_UAN_GdBat_00_6,true)
				Freeze(_idChar_UAN_C1_02_1,true)
				Freeze(_idChar_UAN_C1_02_2,true)
				Freeze(_idChar_UAN_C1_02_3,true)
				_bOnEnter_Sector_Event_Ascenseur=1

		end
	end
end
------------------------------------------------------
------------------------------------------------------------------------
--defreeze le boss
--function Boss()

--_bAlive_idChar_UAN_Cargo_lvl3_01_1=IsAlive(_idChar_UAN_Cargo_lvl3_01_1)
--_bAlive_idChar_UAN_Cargo_lvl3_01_3=IsAlive(_idChar_UAN_Cargo_lvl3_01_3)
--_bAlive_idChar_UAN_Cargo_lvl3_01_4=IsAlive(_idChar_UAN_Cargo_lvl3_01_4)
----_bAlive_idChar_UAN_Cargo_lvl3_01_5=IsAlive(_idChar_UAN_Cargo_lvl3_01_5)

--	if(_bBoss==0) then
--		if((_bAlive_idChar_UAN_Cargo_lvl3_01_1==false)and(_bAlive_idChar_UAN_Cargo_lvl3_01_3==false)and
--				(_bAlive_idChar_UAN_Cargo_lvl3_01_4==false)and(_bAlive_idChar_UAN_Cargo_lvl3_01_5==false))then
--					if (_idChampion_0 ~= nil) then 
--					Freeze(_idChampion_0,false)		
--					end
--				LaunchBOS(0, "Disable_Merc", "Combat_BOSS", "Win", "Loose", "Win")
--				_bCombat=true
--				_bBoss=1
--		end
--	end
--end

-----------------------------------------------------------------------------
function Disable_Merc()
	if(_bDisable_Merc==0)then
		if(_bCombat==true)then
			if (_idMerc[0] ~= nil)then
			EnableCharacterCommand(_idMerc[0],false)
			end
			if(_idMerc[1] ~= nil) then
			EnableCharacterCommand(_idMerc[1],false)
			end
			if(_idChampion_0 ~= nil)then
		--	SetVarValue(_idChampion_0,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Use_Pathway_Cargo_2_lvl_4"))
			EnableCharacterCommand(_idChampion_0,false)
			end
			_bDisable_Merc=1
		end
	end
end
------------------------------------
--------------------------------------
function Loose()
	MissionFailed("HUD_MISSION_FAILED_REASON_01")
	if(_bLoose==0)then
		if(_idChampion_0 ~= nil)then
		_bLoose=1
		end
	end
end
------------------------------------
----------------------------------------------------------------------------
function Combat_BOSS()

	if(_bCombat_BOSS==0)then
	
			if(_idChampion_0 ~= nil)then
				SetVarValue(_idChampion_0,"Team","UAN")
				SetVarValue(_idChampion_0,"CharacterAI",GetCharacter_AIID("Char_AI_Champion_0_1"))
				SetVarValue(_idChampion_0,"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_champion"))
				EnableCharacterCommand(_idChampion_0,true)
				EnableCharacterCommand(_idPlayer,true)
				EnableCharacterFire(_idPlayer,true)
				EnableCharacterFire(_idChampion_0,true)
			end
				_bCombat_BOSS=1
	end
end
----------------------------------------------------------------------------
--FONCTION PROVISOIRE : affiche message si le duel est gagné
function Win()
	g_bBoSEnCours = false
	if(_bWin==0)then
			if (_idMerc[0] ~= nil)then
	--		RadioMessage("DIA_SPE_NIV_G_GENERAL_RADIO_02",true,100,0.0,"")
				EnableCharacterCommand(_idMerc[0],true)
				SetVarValue(_idMerc[0],"CharacterOrderList",_idPasdeListe)
			end
				if(_idMerc[1] ~= nil)then
					EnableCharacterCommand(_idMerc[1],true)
					SetVarValue(_idMerc[1],"CharacterOrderList",_idPasdeListe)
				end
			_bWin=1
	end
end
--------------------------------------------------------------------------------
function OnStay_Sector_Event_BOS(id)

	if(id==_idPlayer)then
		_bIs_in_BOS_BOX=true
	end
end
--------------------------------------------------------------------------------
--defreeze le champion 
function BOS()

_bAlive_idChar_UAN_Cargo_lvl3_01_1=IsAlive(_idChar_UAN_Cargo_lvl3_01_1)
_bAlive_idChar_UAN_Cargo_lvl3_01_3=IsAlive(_idChar_UAN_Cargo_lvl3_01_3)
_bAlive_idChar_UAN_Cargo_lvl3_01_4=IsAlive(_idChar_UAN_Cargo_lvl3_01_4)
_bAlive_idChar_UAN_Cargo_lvl3_01_5=IsAlive(_idChar_UAN_Cargo_lvl3_01_5)

_idTimerLaunch=GetTimerID("TimerLaunch")

	if(_bBOS==0)then
		if((_bAlive_idChar_UAN_Cargo_lvl3_01_1==false)and
					(_bAlive_idChar_UAN_Cargo_lvl3_01_3==false)and
						(_bAlive_idChar_UAN_Cargo_lvl3_01_4==false)and
							(_bAlive_idChar_UAN_Cargo_lvl3_01_5==false)and
																(_bIs_in_BOS_BOX==true))then
				
					SetVarValue(_idTimerLaunch,"Active",true)
				_bCombat=true	
				_bBOS=1
		end
		_bCombat_BOSS=0	
	end
end
------------------------------------------------------------
function OnSetup()

		if(_idChampion_0 ~= nil)then
			Freeze(_idChampion_0,false)	
			
			Freeze(_idChar_SYNDICATE_1,false)
			Freeze(_idChar_SYNDICATE_2,false)
			Freeze(_idChar_SYNDICATE_3,false)

			SetGodMode(_idChar_SYNDICATE_1,true)
			SetGodMode(_idChar_SYNDICATE_2,true)
			SetGodMode(_idChar_SYNDICATE_3,true)	

			CloseDoor(_idDoor_bos_1,true)
			CloseDoor(_idDoor_bos_2,true)
			CloseDoor(_idDoor_bos_3,true)
			Teletransportation("Char_REPER_PLAYER",_idPlayer)
			EnableCharacterFire(_idPlayer,false)
			EnableCharacterCommand(_idPlayer,false)
			SetGodMode(_idPlayer,true)
			EnableCharacterFire(_idChampion_0,false)
		end
end
--------------------------------------------------------------
function LaunchBOSS()

	if(_bLaunchBOSS==0)then
		if(_idChampion_0 ~= nil)then 		
				LaunchBOS(0,"OnSetup","Disable_Merc","Combat_BOSS","Win","Loose","OnTimeOut")
				g_bBoSEnCours = true
			_bLaunchBOSS=1
		end
	end
end
---------------------------------------
function End()

_bAlive_idChampion_0=IsAlive(_idChampion_0)
_idTimerSucced=GetTimerID("Timer_succed")
	if(_bEnd==0)then
		if(_bAlive_idChampion_0==false)then
				--	_bOnEnter_Sector_Event_endoflevel=0
				--EndOfLevel()
				SetVarValue(_idTimerSucced,"Active",true)
			if (_idMerc[0] ~= nil)then
				EnableCharacterCommand(_idMerc[0],true)
				SetVarValue(_idMerc[0],"CharacterOrderList",_idPasdeListe)
			end
				if(_idMerc[1] ~= nil)then
					EnableCharacterCommand(_idMerc[1],true)
					SetVarValue(_idMerc[1],"CharacterOrderList",_idPasdeListe)
				end
					_bEnd=1
		end
	end
end
---------------------------------------------
function Mission_OK()

_idTimer_End=GetTimerID("Timer_End")

	if(_bMission_OK==0)then
					SetVarValue(_idTimer_End,"Active",true)
		_bMission_OK=1
	end
end
----------------------------------------------
-------------------------------------------------------
function OnTimeOut()
	MissionFailed("HUD_MISSION_FAILED_REASON_15")
	Freeze(_idChampion_0,true)	
	g_bBoSEnCours = false
end
---------------------------------------------
--end of level
function EndOFLevel()
		if(_bOnEnter_Sector_Event_endoflevel==0)then
			MissionSucceed ()
	--		EndOfLevel()
			_bOnEnter_Sector_Event_endoflevel=1
		end
end



