waitUntil {!isNil "bulwarkBox"};
["Terminate"] call BIS_fnc_EGSpectator;
params ["_player", "_oldUnit"];

removeHeadgear _player:
removeGoggles _player;
removeVest _player;
removeBackpack _player;
removeAllWeapons _player:
removeAllAssignedItems _player;
//_resp = selectRandom ["G_Respirator_white_F","G_Respirator_blue_F","G_Respirator_yellow_F"];
//player addGoggles _resp;

// force player to have this uniform and gasmask
_player addGoggles "G_RegulatorMask_F";
_player addUniform  "U_C_CBRN_Suit_01_Blue_F";

_player setPosASL ([bulwarkBox] call bulwark_fnc_findPlaceAround);

if(PLAYER_STARTWEAPON) then {
    _player addMagazine "16Rnd_9x21_Mag";
    _player addMagazine "16Rnd_9x21_Mag";
    _player addWeapon "hgun_P07_F";
};

if(PLAYER_STARTMAP) then {
    _player addItem "ItemMap";
    _player assignItem "ItemMap";
};

if(PLAYER_STARTNVG) then {
    _player addItem "Integrated_NVG_F";
    _player assignItem "Integrated_NVG_F";
};

waituntil {alive _player};

_buildPhase = bulwarkBox getVariable ["buildPhase", true];

if (!_buildPhase) then { // free respawn in build phase
	_respawnTickets = [west, -1] call BIS_fnc_respawnTickets;
	if (_respawnTickets <= 0 && RESPAWN_TIME < 99999) then {
		RESPAWN_TIME = 99999;
		publicVariable "RESPAWN_TIME";
		[RESPAWN_TIME] remoteExec ["setPlayerRespawnTime", 0];
	};
};

[] remoteExec ["killPoints_fnc_updateHud", 0];
