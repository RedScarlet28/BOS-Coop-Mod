
function Spot1 ()
	if 	(_rRotX_Spot > 0) then
	_bChangeRot = 1
	end
	if 	(_rRotX_Spot < -2.95) then
	_bChangeRot = 0
	end
	if _bChangeRot == 1 then
	_rRotX_Spot = (_rRotX_Spot - 0.01)
	else
	_rRotX_Spot = (_rRotX_Spot + 0.01)
	end
	
	SetVarValue(GetVolumeGlow_ClientID("VolumeGlow_Client_Spot_01"),"Rotation",Vector3D(-_rRotX_Spot*1.2,1.4,-1.97))
	SetVarValue(GetVolumeGlow_ClientID("VolumeGlow_Client_Spot_03"),"Rotation",Vector3D(-_rRotX_Spot,2.17,-2.1))
	SetVarValue(GetVolumeGlow_ClientID("VolumeGlow_Client_Spot_07"),"Rotation",Vector3D((-_rRotX_Spot*1.5),0.6,1.28))
end


function Spot2 ()
	if 	(_rRotX_Spot2 > 0)then
	_bChangeRot2 = 1
	end
	if 	(_rRotX_Spot2 < -2.5)then
	_bChangeRot2 = 0
	end
	if _bChangeRot2 == 1 then
	_rRotX_Spot2 = (_rRotX_Spot2 - 0.01)
	else
	_rRotX_Spot2 = (_rRotX_Spot2 + 0.01)
	end
	
	SetVarValue(GetVolumeGlow_ClientID("VolumeGlow_Client_Spot_02"),"Rotation",Vector3D((_rRotX_Spot2*0.8),0.6,1.28))
	SetVarValue(GetVolumeGlow_ClientID("VolumeGlow_Client_Spot_04"),"Rotation",Vector3D((_rRotX_Spot2)*1.1,0.6,1.28))
	SetVarValue(GetVolumeGlow_ClientID("VolumeGlow_Client_Spot_06"),"Rotation",Vector3D(-_rRotX_Spot2,2.17,-2.1))
end

function Spot3 ()
	if 	(_rRotX_Spot3 > 1.3)then
	_bChangeRot3 = 1
	end
	if 	(_rRotX_Spot3 < -0.5)then
	_bChangeRot3 = 0
	end
	if _bChangeRot3 == 1 then
	_rRotX_Spot3 = (_rRotX_Spot3 - 0.01)
	else
	_rRotX_Spot3 = (_rRotX_Spot3 + 0.01)
	end

	SetVarValue(GetVolumeGlow_ClientID("VolumeGlow_Client_Spot_08"),"Rotation",Vector3D((_rRotX_Spot3)*1.1,1.16,1.44))
end


function Spot4 ()
	if 	(_rRotX_Spot4 > 3)then
	_bChangeRot4 = 1
	end
	if 	(_rRotX_Spot < 2)then
	_bChangeRot4 = 0
	end
	if _bChangeRot4 == 1 then
	_rRotX_Spot4 = (_rRotX_Spot4 - 0.01)
	else
	_rRotX_Spot4 = (_rRotX_Spot4 + 0.01)
	end
	
	SetVarValue(GetVolumeGlow_ClientID("VolumeGlow_Client_Spot_05"),"Rotation",Vector3D((-_rRotX_Spot4),0.6,1.28))
end