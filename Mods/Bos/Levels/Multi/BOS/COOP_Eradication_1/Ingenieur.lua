function UpdateLevel_Ingenieur()
end
------------------------------------------------------
------------------------------------------------------
function OnStay_Sector_Event_INGE_1(id)


_bAlive_idGroup_Ruine_03=IsAlive(_idGroup_Ruine_03)

	if(id==_idMerc_0)then
		CharacterPlaySpecialAction(_idMerc_0,"STAND MEDHI ORDER_GO W_NONE",true,false)
		CreationTimer(true,true,false,"Stop_Go",3.0)
		if(_bAlive_idGroup_Ruine_03~=false)then
			SetVarValue(_idTimer_dial_inge_1,"Active",true)	
		end
		if(_bAlive_idGroup_Ruine_03==false)then
			SetVarValue(_idTimer_dial_inge_1,"Active",false)
			SetVarValue(_idList_Inge,"Order",_idUse_Pathway_INGE_2,1)
			CharacterPlaySpecialAction(_idMerc_0,"STAND MEDHI ORDER_THIS_WAY W_NONE",true,false)
			CreationTimer(true,true,false,"Stop_this_way",3.0)
		end
	end
end
-----------------------------------------
function Stop_Go()

CharacterStopSpecialAction(_idMerc_0)

end
----------------------------------------
function Stop_this_way()

CharacterStopSpecialAction(_idMerc_0)

end
---------------------------------------------------------------------
function OnEnter_Sector_Event_Freeze_1(id)

	if(_bOnEnter_Sector_Event_Freeze_1==0)then
		if(id==_idMerc_0)then
			CharacterPlaySpecialAction(_idMerc_0,"STAND MEDHI ORDER_STOP W_NONE",true,false)
			CreationTimer(true,true,false,"Stop_Stop",3.0)
				_bOnEnter_Sector_Event_Freeze_1=1
		end
	end
end
----------------------------------------------
function Stop_Stop()

	CharacterStopSpecialAction(_idMerc_0)

end
-----------------------------------------------------
function Dial_INGE_1()
	
		RadioMessage("DIA_SPE_NIV_H_INGENIEUR_26",true,90,0.0,"")
		
end
----------------------------------------------------
function OnStay_Sector_Event_INGE_2(id)

_idTimer_dial_inge_2=GetTimerID("Timer_dial_inge_2")

_bAlive_idGroup_Ruine_01=IsAlive(_idGroup_Ruine_01)
_bAlive_idGroup_Ruine_03=IsAlive(_idGroup_Ruine_03)
_bAlive_idGroup_Ruine_06=IsAlive(_idGroup_Ruine_06)

	if(id==_idMerc_0)then
		if(_bAlive_idGroup_Ruine_03==false)and((_bAlive_idGroup_Ruine_01~=false)or(_bAlive_idGroup_Ruine_06~=false))then
					SetVarValue(_idTimer_dial_inge_2,"Active",true)	
		end
		if(_bAlive_idGroup_Ruine_03==false)and((_bAlive_idGroup_Ruine_01==false)or(_bAlive_idGroup_Ruine_06==false))then
			SetVarValue(_idTimer_dial_inge_2,"Active",false)	
			SetVarValue(_idList_Inge,"Order",_idUse_Pathway_INGE_3,1)
		end
	end
end
------------------------------------
function Dial_INGE_2()
	
		RadioMessage("DIA_SPE_NIV_H_INGENIEUR_31",true,100,0.0,"Suite_Dial_2")
end
---------------------------
function Suite_Dial_2()

		RadioMessage("DIA_SPE_NIV_H_INGENIEUR_24",true,100,0.0,"")
end
------------------------------
function OnStay_Sector_Event_INGE_3(id)

_idTimer_dial_inge_2=GetTimerID("Timer_dial_inge_2")

_bAlive_idGroup_Ruine_01=IsAlive(_idGroup_Ruine_01)
_bAlive_idGroup_Ruine_03=IsAlive(_idGroup_Ruine_03)
_bAlive_idGroup_Ruine_06=IsAlive(_idGroup_Ruine_06)
_bAlive_idGroup_Ruine_02=IsAlive(_idGroup_Ruine_02)

	if(id==_idMerc_0)then
		if(_bAlive_idGroup_Ruine_03==false)and(_bAlive_idGroup_Ruine_01==false)and(_bAlive_idGroup_Ruine_06==false)and(_bAlive_idGroup_Ruine_02==false)then
			SetVarValue(_idTimer_dial_inge_1,"Active",false)	
			SetVarValue(_idList_Inge,"Order",_idUse_Pathway_INGE_3,1)
		end
	end
end
------------------------------------------------------------------
















































































































































































































