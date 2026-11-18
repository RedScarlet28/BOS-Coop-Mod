function UpdateLevel_Court()
end
------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_Court_1(id)
	if(_bOnEnter_Sector_Event_Court_1==0)then		

		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_Court_1)then		
			--Freeze(_idChar_RES_COURT_15,false)
			Freeze(_idExoskeleton_RES,false)
			Freeze(_idChar_RES_COURT_8,false)

			Freeze(_idChar_RES_COURT_3,false)
			Freeze(_idChar_RES_COURT_4,false)
			Freeze(_idChar_RES_COURT_5,false)
			Freeze(_idChar_RES_COURT_6,false)
			Freeze(_idChar_RES_COURT_7,false)
			Freeze(_idChar_RES_COURT_12,false)
			_byetOnEnter_Sector_Event_Court_1=true
			_bOnEnter_Sector_Event_Court_1=1
		end
	end
end
-----------------------------------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_Court_2(id)
	if(_bOnEnter_Sector_Event_Court_2==0)then		

		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_Court_2)then

			Freeze(_idChar_RES_COURT_1,false)
			Freeze(_idChar_RES_COURT_17,false)
			Freeze(_idChar_RES_COURT_2,false)
			Freeze(_idChar_RES_COURT_15,false)
			_byetOnEnter_Sector_Event_Court_2=true
			_bOnEnter_Sector_Event_Court_2=1
		end
	end
end
-------------------------------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_Court_3(id)
	if(_bOnEnter_Sector_Event_Court_3==0)then		

		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_Court_3)then
			Freeze(_idChar_RES_COURT_11,false)
			_byetOnEnter_Sector_Event_Court_3=true
			_bOnEnter_Sector_Event_Court_3=1
		end
	end
end
----------------------------------------------------------------------------------
--defreeze des ennemis
function Renforts_Court_1()
	if(_bRenforts_Court_1==0)then

		_bAliveidChar_RES_COURT_3=IsAlive(_idChar_RES_COURT_3)
		_bAliveidChar_RES_COURT_6=IsAlive(_idChar_RES_COURT_6)

		if(_bAliveidChar_RES_COURT_3==false)or(_bAliveidChar_RES_COURT_6==false)then
			Freeze(_idChar_RES_COURT_12,false)
			Freeze(_idChar_RES_COURT_15,false)
			_bRenforts_Court_1=1
		end
	end
end
------------------------------------------------------------
function Obj_5()


_balive_idChar_RES_COURT_11=IsAlive(_idChar_RES_COURT_11)
_balive_idChar_RES_COURT_1=IsAlive(_idChar_RES_COURT_1)
_balive_idChar_RES_COURT_5=IsAlive(_idChar_RES_COURT_5)
_balive_idChar_RES_COURT_4=IsAlive(_idChar_RES_COURT_4)
_balive_idChar_RES_COURT_8=IsAlive(_idChar_RES_COURT_8)
_balive_idChar_RES_COURT_12=IsAlive(_idChar_RES_COURT_12)

	if(_bObj_5==0)then
		if((_balive_idChar_RES_COURT_11==false)and
			(_balive_idChar_RES_COURT_5==false)and
			(_balive_idChar_RES_COURT_8==false)and
			(_balive_idChar_RES_COURT_12==false))then
		_bFini=true
		NewSubObjective("Obj_E_5","Obj_E_6")
		_bObj_5=1
	end
	end
end
------------------------------------------------------------------------------------------
--defreeze des ennemis
function OnEnter_Sector_Event_COURT_place(id)
	if(_bOnEnter_Sector_Event_COURT_place==0)then
	
		if(GetLocalCharacterID("Player")==id)and not(_byetOnEnter_Sector_Event_COURT_place)then
			Freeze(_idChar_RES_COURT_11,false)
			Freeze(_idChar_RES_COURT_1,false)
			_byetOnEnter_Sector_Event_COURT_place=true
			_bOnEnter_Sector_Event_COURT_place=1
		end
	end
end
------------------------------------------------------------------------

----------------------------------------------------------------------------------------------
--fin de niveau
function OnEnter_Sector_Event_endoflevel(id)

	if(_bOnEnter_Sector_Event_endoflevel==0)then

		if(GetLocalCharacterID("Player")==id)and(_bFini==true)then
	
			_bOnEnter_Sector_Event_endoflevel=1
		end
	end
end
---------------------------------------------------
function OnExit_Sector_Event_endoflevel(id)

	if(_bOnExit_Sector_Event_endoflevel==0)then

		if(GetLocalCharacterID("Player")==id)and(_bFini==true)then
			EndOfLevel()
			_bOnExit_Sector_Event_endoflevel=1
		end
	end
end
