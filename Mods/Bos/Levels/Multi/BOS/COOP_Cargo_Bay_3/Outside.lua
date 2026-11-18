function UpdateLevel_Outside()
end
-------------------------------------------------------
function OnEnter_Sector_Event_Entree_EXT_1(id)

	if(_bOnEnter_Sector_Event_Entree_EXT_1==0)then
		if(id == GetLocalCharacterID("Player"))then
			FreezeAll(_idGroup_UAN_Garnison_00,false)
			_byetOnEnter_Sector_Event_Entree_EXT_1=true
			_bOnEnter_Sector_Event_Entree_EXT_1=1
		end
	end
end
------------------------------------------------------------
function OnEnter_Sector_Event_EXO(id)


	if(_bOnEnter_Sector_Event_EXO==0)then
		if(id == GetLocalCharacterID("Player"))then
			EnableCharacterCommand(_idChar_UAN_EXOMAN_00_1,false)
			_bOnEnter_Sector_Event_EXO=1
		end
	end
end

-------------------------------------------------------
function OnExit_Sector_Event_Entree_EXT_1(id)

	if(_bOnExit_Sector_Event_Entree_EXT_1==0)then
		if(id == GetLocalCharacterID("Player"))then
			MakeCharacterSpeak(_idChar_UAN_Garnison_00_1,_idPlayer,"DIA_SPE_NIV_H_UAN_A_01",false,100,2,0.0,"",100.0)
			_byetOnExit_Sector_Event_Entree_EXT_1=true
			_bOnExit_Sector_Event_Entree_EXT_1=1
		end
	end
end
------------------------------------------------------------
function Garnison_1()

_idChar_UAN_Garnison_02_1=GetCharacterID("Char_UAN_Garnison_02_1")
_nRest_idGroup_UAN_Garnison_00=AliveMembersCount(_idGroup_UAN_Garnison_00)

	if(_bGarnison_1==0)then
		if(_nRest_idGroup_UAN_Garnison_00==0)then
				FreezeAll(_idGroup_UAN_Garnison_02,false)
				CharacterPlaySpecialAction(_idChar_UAN_Garnison_02_1,"STAND MEDHI ORDER_SEPARATE W_NONE",true,false)
				CreationTimer(true,true,false,"Stop_anim_02",2.0)
				EnableCharacterCommand(_idChar_UAN_EXOMAN_00_1,true)
			_bGarnison_1=1
		end
	end
end
-------------------------------------------------------------
function Stop_anim_02()

_idChar_UAN_Garnison_02_1=GetCharacterID("Char_UAN_Garnison_02_1")
		CharacterStopSpecialAction(_idChar_UAN_Garnison_02_1)

end
--------------------------------------------------------------
function Garnison_3()

_nRest_idGroup_UAN_Garnison_02=AliveMembersCount(_idGroup_UAN_Garnison_02)
	if(_bGarnison_3==0)then
		if(_nRest_idGroup_UAN_Garnison_02==0)then
				FreezeAll(_idGroup_UAN_Garnison_04,false)	
			_bGarnison_3=1
		end
	end
end
-------------------------------------------
function Garnison_4()

_nRest_idGroup_UAN_Garnison_06=AliveMembersCount(_idGroup_UAN_Garnison_06)
	if(_bGarnison_4==0)then
		if(_nRest_idGroup_UAN_Garnison_04==0)then
				FreezeAll(_idGroup_UAN_Garnison_03,false)	
			_bGarnison_4=1
		end
	end
end
---------------------------------------------------------------
function OnEnter_Sector_Event_Entree_EXT_2(id)

_idChar_UAN_Garnison_01_1=GetCharacterID("Char_UAN_Garnison_01_1")

	if(_bOnEnter_Sector_Event_Entree_EXT_2==0)then
		if(id == GetLocalCharacterID("Player"))and not(_byetOnEnter_Sector_Event_Entree_EXT_2)then
			FreezeAll(_idGroup_UAN_Garnison_03,false)
			FreezeAll(_idGroup_UAN_Garnison_01,false)
			CharacterPlaySpecialAction(_idChar_UAN_Garnison_01_1,"STAND MEDHI ORDER_FOLLOW_ME W_NONE",true,false)
			CreationTimer(true,true,false,"Stop_anim_01",3.0)
			_byetOnEnter_Sector_Event_Entree_EXT_2=true
		_bOnEnter_Sector_Event_Entree_EXT_2=1
		end
		else _bOnEnter_Sector_Event_Entree_EXT_2=0		
	end
end
-------------------------------------------------
function Stop_anim_01()
_idChar_UAN_Garnison_01_1=GetCharacterID("Char_UAN_Garnison_01_1")
		CharacterStopSpecialAction(_idChar_UAN_Garnison_01_1)
end
----------------------------------------------------
function OnExit_Sector_Event_Entree_EXT_2(id)

	if(_bOnExit_Sector_Event_Entree_EXT_2==0)then
		if(id == GetLocalCharacterID("Player"))and not(_byetOnExit_Sector_Event_Entree_EXT_2)then
			FreezeAll(_idGroup_UAN_Garnison_03,false)
			EnableCharacterCommand(_idChar_UAN_EXOMAN_00_1,true)
			--MakeCharacterSpeak(_idMerc[0],"DIA_SPE_NIV_H_INGENIEUR_26",true,1)
			--SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Use_Pathway_pose_inge"))
			_byetOnExit_Sector_Event_Entree_EXT_2=true
			_bOnExit_Sector_Event_Entree_EXT_2=1
		end	
	end
end
------------------------------------------------------
--function Come_EXO()

--	if(_bCome_EXO==0)then
--		if(_bAlive_idGroup_UAN_Garnison_00==false)and
--			(_bAlive_idGroup_UAN_Garnison_02==false)and
--			(_bAlive_idGroup_UAN_Garnison_06==false)then
--			EnableCharacterCommand(_idChar_UAN_EXOMAN_00_1,true)
--		_bCome_EXO=1
--		end
--	end
--end
-------------------------------------------------------------
function NotCome_Inge()

	if(_bNotCome_Inge==0)then
		if(_nBotsMorts<=29)and not(_byetplay_2)and not(_byetplay_1)and(_nLife_Exo_UAN>300)and(_byetOnEnter_Sector_Event_Entree_EXT_2==true)then
			RadioMessage("DIA_SPE_NIV_H_INGENIEUR_26",true,100,0.0,"")
		_byetplay_2=true	
		_bNotCome_Inge=1
		end
	end	
end
-----------------------------------------------------------		
function Come_Inge()		


	if(_bCome_Inge==0)then
		if(_nBotsMorts>=34)and not(_byetplay_1)and(_nLife_Exo_UAN<300)then 
			SetVarValue(_idMerc[0],"CharacterOrderList",GetAI_Order_ListID("AI_Order_List_Use_Pathway_inge_1"))
			SetMercenaryFollow(_idMerc[0],true)
			RadioMessage("DIA_SPE_NIV_H_INGENIEUR_28",true,100,0.0,"")
		_byetplay_1=true
		_bCome_Inge=1
		end
	end
end
-----------------------------------------------
-----------------------------------------------------
--FONCTION PROVISOIRE liée aux conditions d'échec.
--function DialA()
	
--	if(_bDialA==0)then
		--	if(_bAlive_idMerc[0]==false)then
		--		DisplaySubtitle("Votre ingénieur est mort, mission annulé",0,5)
		--		_bDialA=1
		--	end
--	end
--end
-----------------------------------------------------
function IngenieurA() 


	if(_bIngenieurA==0)then
		if(_bAlive_idGroup_UAN_Garnison_01==false)and(_bAlive_idGroup_UAN_Garnison_02==false)
																							and(_bAlive_idGroup_UAN_Garnison_03==false)
																							and(_bAlive_idGroup_UAN_Garnison_05==false)
																							and(_bAlive_idGroup_UAN_Garnison_06==false)then
					SetVarValue(_idMerc[0],"CharacterOrderList",_idPasdeListe)
				_bIngenieurA=1
		end
		else _bIngenieurA=0
	end
end
--------------------------
function OnEnter_Sector_Event_check_inge(id)

	if(_bOnEnter_Sector_Event_check_inge==0)then
		if(id ==_idMerc[0])then
			SetVarValue(_idMerc[0],"CharacterOrderList",_idPasdeListe)		
		_bOnEnter_Sector_Event_check_inge=1
		end
	end
end
----------------------------------------------------
function OnEnter_Sector_Event_Container_1(id)

	if(_bOnEnter_Sector_Event_Container_1==0)then
		if(id == GetLocalCharacterID("Player")) and not(_byetOnEnter_Sector_Event_Container_1)then
		--	FreezeAll(_idGroup_UAN_Garnison_04,false)
			FreezeAll(_idGroup_UAN_Garnison_03,false)
		_bOnEnter_Sector_Event_Container_1=1
		end
	end
end
---------------------------------------------------------
function OnStay_Sector_Event_DEBUT(id)

	if(_bOnStay_Sector_Event_DEBUT==0)then
		if(id == GetLocalCharacterID("Player"))and(_nBotsActifs<=4)then
			FreezeAll(_idGroup_UAN_Garnison_01,false)
			_bOnStay_Sector_Event_DEBUT=1
		end
	end
end
-------------------------------------------------------

------------------------------------------------------
function OnEnter_Sector_Event_ICEBERG(id)


	if(_bOnEnter_Sector_Event_ICEBERG==0)then
		if(id == GetLocalCharacterID("Player"))then
			FreezeAll(_idGroup_UAN_Garnison_05,false)
			FreezeAll(_idGroup_UAN_Garnison_01,false)
			_bOnEnter_Sector_Event_ICEBERG=1
		end
	end
end
-----------------------------------------------------
function OnExit_Sector_Event_ICEBERG(id)


	if(_bOnExit_Sector_Event_ICEBERG==0)then
		if(id == GetLocalCharacterID("Player"))then
			Freeze(_idChar_UAN_RESERVE_00_1,false)
			Freeze(_idChar_UAN_RESERVE_00_2,false)
			--Freeze(_idChar_UAN_RESERVE_00_3,false)
			--Freeze(_idChar_UAN_RESERVE_00_4,false)
			--Freeze(_idChar_UAN_RESERVE_00_5,false)
			_bOnExit_Sector_Event_ICEBERG=1
		end
	end
end
-------------------------------------------
function OnEnter_Sector_Event_Right(id)

	if(_bOnEnter_Sector_Event_Right==0)then
		if(id == GetLocalCharacterID("Player"))then
			EnableCharacterCommand(_idChar_UAN_EXOMAN_00_1,true)
			FreezeAll(_idGroup_UAN_Garnison_04,false)
			FreezeAll(_idGroup_UAN_Garnison_03,false)
--			Freeze(_idChar_UAN_Garnison_04_1,false)
--			Freeze(_idChar_UAN_Garnison_04_2,false)
			_bOnEnter_Sector_Event_Right=1
		end
	end
end
-----------------------------------------------
function Renforts_Tube()

	if(_bRenforts_Tube==0)then
		if(_nBotsMorts==20)then
			Freeze(_idChar_UAN_RESERVE_00_3,false)
			--Freeze(_idChar_UAN_RESERVE_00_4,false)
			--Freeze(_idChar_UAN_RESERVE_00_5,false)
			_bRenforts_Tube=1
		end
	end
end