
//Select City and spawn point
if (isServer) then {
	_basepoint = [] execVM "createBase.sqf";
	waitUntil { scriptDone _basepoint };
};

//Create spawnpoint
bulMkr = createMarker ["respawn_west", BulwarkRoomPos];
bulMkr setMarkerShape "ICON";
bulMkr setMarkerType "hd_dot";
bulMkr setMarkerColor "ColorBlue";
bulMkr setMarkerText "Spawn";

if (!isServer && (player != player)) then {
	waitUntil {player == player};
	waitUntil {time > 10}; 
};
hint "Ready";

//Remove stamina and lower sway and recoil
if (!isDedicated) then {
     player setCustomAimCoef 0.2;
     player enableStamina FALSE;
     player addEventHandler ['Respawn',{player enableStamina FALSE;}];
     player addEventHandler ['Respawn',{player setCustomAimCoef 0.2;}];
     player addEventHandler ['Respawn',{player setUnitRecoilCoefficient .5;}];
};

if (isServer) then {
	[bulwarkCity] execVM "missionLoop.sqf";
};
