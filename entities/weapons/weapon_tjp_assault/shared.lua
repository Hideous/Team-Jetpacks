
if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.Base				=	"weapon_tjp_base"

SWEP.PrintName			=	"Assault Rifle"

SWEP.WorldModel			=	"models/weapons/w_rif_m4a1.mdl"

SWEP.HoldType			=	"ar2"

//Primary fire settings
SWEP.Primary.Sound		=	"weapons/m4a1/m4a1-1.wav"
SWEP.Primary.Damage		=	8
SWEP.Primary.TakeAmmo	=	1
SWEP.Primary.ClipSize	=	300
SWEP.Primary.DefaultClip = 	300
SWEP.Primary.Automatic	=	true
SWEP.Primary.Recoil		=	10 //Not relevant while view-punch doesn't work
SWEP.Primary.Delay		= 0.1
SWEP.Primary.Force		= 260
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Spread		= 0.05

function SWEP:PrimaryAttack()

	if !self:CanPrimaryAttack() then return end
	
	
	local bullet = {}
	
	bullet.Num	=	self.Primary.NumberofShots
	bullet.Src	=	self.Owner:GetShootPos()
	
	bullet.Spread = vector_origin;
	bullet.Dir = self.Owner:GetAimVector( ) + math.Rand( -1, 1 ) * Vector( 0, 0, self.Primary.Spread )
	bullet.Tracer = 1
	bullet.TracerName = "Tracer"
	bullet.Damage = self.Primary.Damage
	bullet.AmmoType = self.Primary.Ammo
	bullet.Force = self.Primary.Force
	
	
	self:ShootEffects()
	
	self.Owner:FireBullets(bullet) //Pow!
	self:EmitSound(Sound(self.Primary.Sound))
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

	
end