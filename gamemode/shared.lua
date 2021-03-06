GM.Name 	= "Team Jetpacks"
GM.Author 	= "Hideous and Don Andy"
GM.Email 	= ""
GM.Website 	= ""
GM.Help		= "Kill the other team and capture their flag!"
 
GM.Data = {}							//test
 
DeriveGamemode("fretta")
IncludePlayerClasses()					// Automatically includes files in "gamemode/player_class"
 
GM.TeamBased = true					// Team based game or a Free For All game?
GM.AllowAutoTeam = true
GM.AllowSpectating = true
GM.SecondsBetweenTeamSwitches = 10
GM.GameLength = 15
GM.RoundLimit = 3					// Maximum amount of rounds to be played in round based games
GM.VotingDelay = 5					// Delay between end of game, and vote. if you want to display any extra screens before the vote pops up
 
GM.NoPlayerSuicide = false
GM.NoPlayerDamage = false
GM.NoPlayerSelfDamage = false		// Allow players to hurt themselves?
GM.NoPlayerTeamDamage = true		// Allow team-members to hurt each other?
GM.NoPlayerPlayerDamage = false 	// Allow players to hurt each other?
GM.NoNonPlayerPlayerDamage = false 	// Allow damage from non players (physics, fire etc)
GM.NoPlayerFootsteps = false		// When true, all players have silent footsteps
GM.PlayerCanNoClip = false			// When true, players can use noclip without sv_cheats
GM.TakeFragOnSuicide = true			// -1 frag on suicide
 
GM.MaximumDeathLength = 10			// Player will respawn if death length > this (can be 0 to disable)
GM.MinimumDeathLength = 3			// Player has to be dead for at least this long
GM.AutomaticTeamBalance = true     // Teams will be periodically balanced 
GM.ForceJoinBalancedTeams = true	// Players won't be allowed to join a team if it has more players than another team
GM.RealisticFallDamage = false
GM.AddFragsToTeamScore = false		// Adds player's individual kills to team score (must be team based)
 
GM.NoAutomaticSpawning = false		// Players don't spawn automatically when they die, some other system spawns them
GM.RoundBased = true				// Round based, like CS
GM.RoundLength = 60 * 5					// Round length, in seconds
GM.RoundPreStartTime = 5			// Preperation time before a round starts
GM.RoundPostLength = 5				// Seconds to show the 'x team won!' screen at the end of a round
GM.RoundEndsWhenOneTeamAlive = false	// CS Style rules
 
GM.EnableFreezeCam = false			// TF2 Style Freezecam
GM.DeathLingerTime = 3				// The time between you dying and it going into spectator mode, 0 disables
 
GM.SelectModel = false               // Can players use the playermodel picker in the F1 menu?
GM.SelectColor = false				// Can players modify the colour of their name? (ie.. no teams)
GM.SelectClass = true
 
GM.PlayerRingSize = 48              // How big are the colored rings under the player's feet (if they are enabled) ?
GM.HudSkin = "SimpleSkin"
 
GM.ValidSpectatorModes = { OBS_MODE_CHASE }
GM.ValidSpectatorEntities = { "player" }	// Entities we can spectate
GM.CanOnlySpectateOwnTeam = true // you can only spectate players on your own team

TEAM_RED = 1
TEAM_BLUE = 2

CAM_DIST = 512

JETPACK_STRENGTH = 15
 
local classes = {"AssaultClass","RetrieverClass"}
 
function GM:CreateTeams()
 
	if ( !GAMEMODE.TeamBased ) then return end
 
	team.SetUp( TEAM_RED, "Red", Color( 180, 36, 0 ), true )
	team.SetSpawnPoint( TEAM_RED, { "info_player_start", "info_player_terrorist", "info_player_rebel", "info_player_deathmatch" } )
	team.SetClass( TEAM_RED, classes)
	
	
	team.SetUp( TEAM_BLUE, "Blue", Color( 6, 121, 189 ), true )
	team.SetSpawnPoint( TEAM_BLUE, { "info_player_start", "info_player_counterterrorist", "info_player_combine", "info_player_deathmatch" } )
	team.SetClass( TEAM_BLUE, classes)
 
	team.SetUp( TEAM_SPECTATOR, "Spectators", Color( 200, 200, 200 ), true )
	team.SetSpawnPoint( TEAM_SPECTATOR, { "info_player_start", "info_player_terrorist", "info_player_counterterrorist", "info_player_combine", "info_player_rebel" } ) 
 
end

function GM:PlayerSpawn(ply)
	if SERVER then return end
	gui.EnableScreenClicker(true) //In case someone manages to disable it
end

function GM:PlayerBindPress( ply, bind, down )
	
	if ( ply:Alive()) then
		if ( bind == "+forward" or bind == "+back"  ) then return true end
	end

	return false
	
end

function jetpack(ply)

	if ply:KeyDown(IN_ATTACK2) then
	
		if SERVER then
			if (ply:OnGround()) then
				local startpos = ply:GetPos()
				
				ply:SetPos(Vector(startpos.x, startpos.y, startpos.z + 1))
				
			end
		end

		local sidemove = 0
		
		if ply:KeyDown(IN_MOVELEFT) then sidemove = -JETPACK_STRENGTH / 2 end
		if ply:KeyDown(IN_MOVERIGHT) then sidemove = JETPACK_STRENGTH / 2 end
		
		ply:SetVelocity(Vector(sidemove,0,JETPACK_STRENGTH))
		
	end
end

function sharedThink()

	for k, v in pairs(player.GetAll()) do
	
		jetpack(v)//Shared because of prediction, bro. Or something.
	
	end

end
//hook.Add("Think", "sharedThink", sharedThink)

function freezeYAxis(data)
	local posdata = data:GetOrigin()

	data:SetOrigin(Vector(posdata.x, 0, posdata.y))
end

function moveJetpacks(ply, data)
	if (ply:KeyDown(IN_ATTACK2) && ply:JetpackFuel != 0) then
	
		/*if SERVER then
			if (ply:OnGround()) then
				local startpos = ply:GetPos()
				
				ply:SetPos(Vector(startpos.x, startpos.y, startpos.z + 1))
				
			end
		end*/
	
		if ply:OnGround() then data:SetUpSpeed(300) end
	
		local sidemove = 0
	
		if ply:KeyDown(IN_MOVELEFT) then sidemove = -JETPACK_STRENGTH / 2 end
		if ply:KeyDown(IN_MOVERIGHT) then sidemove = JETPACK_STRENGTH / 2 end
	
		data:SetVelocity(data:GetVelocity() + Vector(sidemove,0,JETPACK_STRENGTH))
	end
	
	//freezeYAxis(data)
end
hook.Add("Move", "moveJetpacks", moveJetpacks)