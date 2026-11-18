function UpdateLevel_FX_CARS()
CAR_1()
CAR_2()
CAR_3()
CAR_4()
CAR_5()
CAR_6()
CAR_7()
TRUCK_1()
TRUCK_2()
TRUCK_3()
TRUCK_4()
end

---------------------------------------------------------
function CAR_1()
ISDESTROYEDDestructible_Car_1=GetVarValue(GetDestructible_ObjectID("Destructible_Car_1"),"Destroyed")
	if(_bCAR_1==0)then
		if(ISDESTROYEDDestructible_Car_1==true)then
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Fire_Car_1"),"FxState","Fx Started")
			_bCAR_1=1
		end
	end
end

---------------------------------------------------------
function CAR_2()
ISDESTROYEDDestructible_Car_2=GetVarValue(GetDestructible_ObjectID("Destructible_Car_2"),"Destroyed")
	if(_bCAR_2==0)then
		if(ISDESTROYEDDestructible_Car_2==true)then
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Fire_Car_2"),"FxState","Fx Started")
			_bCAR_2=1
		end
	end
end

---------------------------------------------------------
function CAR_3()
ISDESTROYEDDestructible_Car_3=GetVarValue(GetDestructible_ObjectID("Destructible_Car_3"),"Destroyed")
	if(_bCAR_3==0)then
		if(ISDESTROYEDDestructible_Car_3==true)then
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Fire_Car_3"),"FxState","Fx Started")
			_bCAR_3=1
		end
	end
end

---------------------------------------------------------
function CAR_4()
ISDESTROYEDDestructible_Car_4=GetVarValue(GetDestructible_ObjectID("Destructible_Car_4"),"Destroyed")
	if(_bCAR_4==0)then
		if(ISDESTROYEDDestructible_Car_4==true)then
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Fire_Car_4"),"FxState","Fx Started")
			_bCAR_4=1
		end
	end
end

---------------------------------------------------------
function CAR_5()
ISDESTROYEDDestructible_Car_5=GetVarValue(GetDestructible_ObjectID("Destructible_Car_5"),"Destroyed")
	if(_bCAR_5==0)then
		if(ISDESTROYEDDestructible_Car_5==true)then
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Fire_Car_5"),"FxState","Fx Started")
			_bCAR_5=1
		end
	end
end

---------------------------------------------------------
function CAR_6()
ISDESTROYEDDestructible_Car_6=GetVarValue(GetDestructible_ObjectID("Destructible_Car_6"),"Destroyed")
	if(_bCAR_6==0)then
		if(ISDESTROYEDDestructible_Car_6==true)then
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Fire_Car_6"),"FxState","Fx Started")
			_bCAR_6=1
		end
	end
end

---------------------------------------------------------
function CAR_7()
ISDESTROYEDDestructible_Car_7=GetVarValue(GetDestructible_ObjectID("Destructible_Car_7"),"Destroyed")
	if(_bCAR_7==0)then
		if(ISDESTROYEDDestructible_Car_7==true)then
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Fire_Car_7"),"FxState","Fx Started")
			_bCAR_7=1
		end
	end
end

---------------------------------------------------------
function TRUCK_1()
ISDESTROYEDDestructible_Truck_1=GetVarValue(GetDestructible_ObjectID("Destructible_Truck_1"),"Destroyed")
	if(_bTRUCK_1==0)then
		if(ISDESTROYEDDestructible_Truck_1==true)then
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Fire_Truck_1"),"FxState","Fx Started")
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Fire_Truck_1b"),"FxState","Fx Started")

			_bTRUCK_1=1
		end
	end
end

---------------------------------------------------------
function TRUCK_2()
ISDESTROYEDDestructible_Truck_2=GetVarValue(GetDestructible_ObjectID("Destructible_Truck_2"),"Destroyed")
	if(_bTRUCK_2==0)then
		if(ISDESTROYEDDestructible_Truck_2==true)then
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Fire_Truck_2"),"FxState","Fx Started")
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Fire_Truck_2b"),"FxState","Fx Started")

			_bTRUCK_2=1
		end
	end
end

---------------------------------------------------------
function TRUCK_3()
ISDESTROYEDDestructible_Truck_3=GetVarValue(GetDestructible_ObjectID("Destructible_Truck_3"),"Destroyed")
	if(_bTRUCK_3==0)then
		if(ISDESTROYEDDestructible_Truck_3==true)then
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Fire_Truck_3"),"FxState","Fx Started")
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Fire_Truck_3b"),"FxState","Fx Started")

			_bTRUCK_3=1
		end
	end
end

---------------------------------------------------------
function TRUCK_4()
ISDESTROYEDDestructible_Truck_4=GetVarValue(GetDestructible_ObjectID("Destructible_Truck_4"),"Destroyed")
	if(_bTRUCK_4==0)then
		if(ISDESTROYEDDestructible_Truck_4==true)then
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Fire_Truck_4"),"FxState","Fx Started")
			SetVarValue(GetParticleFX_ClientID("ParticleFX_Client_Fire_Truck_4b"),"FxState","Fx Started")
			_bTRUCK_4=1
		end
	end
end