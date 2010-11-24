local CLASS = {}
 
CLASS.DisplayName			= "Retriever"
CLASS.WalkSpeed 			= 380
CLASS.CrouchedWalkSpeed 	= 0.2
CLASS.RunSpeed				= 380
CLASS.DuckSpeed				= 0.2
CLASS.JumpPower				= 260
CLASS.PlayerModel			= "models/player/combine_super_soldier.mdl"
CLASS.MaxHealth				= 80
CLASS.StartHealth			= 80
CLASS.DropWeaponOnDie		= false
CLASS.TeammateNoCollide 	= false
CLASS.AvoidPlayers			= false // Automatically avoid players that we're no colliding
CLASS.Selectable			= true // When false, this disables all the team checking
CLASS.FullRotation			= false // Allow the player's model to rotate upwards, etc etc
CLASS.Base					= "BasicClass"
 
function CLASS:Loadout( pl )
	
	pl:GiveAmmo(120, "pistol")
	pl:Give( "weapon_tjp_assault" )
 
end
 
function CLASS:OnSpawn( pl )
end
 
function CLASS:OnDeath( pl, attacker, dmginfo )
end
 
function CLASS:Think( pl )
end
 
function CLASS:Move( pl, mv )
end
 
function CLASS:OnKeyPress( pl, key )
end
 
function CLASS:OnKeyRelease( pl, key )
end
 
function CLASS:ShouldDrawLocalPlayer( pl )
	return true
end
 
player_class.Register( "RetrieverClass", CLASS )