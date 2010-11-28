//Gonna run our custom HUD here.

local ROUND = 8

local PADDING = 25
local BORDER = 5

local HEALTHBOX_W = 100
local HEALTHBOX_H = 75

local TOTALAMMO_W = 100
local TOTALAMMO_H = 60

local CLIPAMMO_W = 100
local CLIPAMMO_H = 75

function hidehud(name) //Gotta hide the default HUD
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "hidehud", hidehud)

function GM:HUDPaint()
	self.BaseClass:HUDPaint()

	local ply = LocalPlayer()
	
	if ply:IsObserver() then return end
	
	local col = team.GetColor(ply:Team())
	local bordercol = Color(255,255,255)
	if !ply:Alive() then return end //Don't want to draw the HUD if the player is dead
	
	//We want teamcolored boxes to hold all the info we need.
	//Health box:
	draw.RoundedBox(ROUND, PADDING, ScrH() - HEALTHBOX_H - PADDING, HEALTHBOX_W, HEALTHBOX_H, bordercol)
	draw.RoundedBox(ROUND, PADDING + BORDER, (ScrH() - HEALTHBOX_H - PADDING) + BORDER, HEALTHBOX_W - BORDER*2, HEALTHBOX_H - BORDER*2, col)
	draw.DrawText(ply:Health(), "WhiskeyHUD", PADDING + BORDER*2, ScrH() - HEALTHBOX_H - PADDING + BORDER*2, bordercol, TEXT_ALIGN_LEFT)
	
	if ply:GetActiveWeapon():IsWeapon() then
		//Total ammo:
		draw.RoundedBox(ROUND, ScrW() - TOTALAMMO_W - PADDING, ScrH() - TOTALAMMO_H - PADDING, TOTALAMMO_W, TOTALAMMO_H, bordercol)
		draw.RoundedBox(ROUND, ScrW() - TOTALAMMO_W - PADDING + BORDER, (ScrH() - TOTALAMMO_H - PADDING) + BORDER, TOTALAMMO_W - BORDER*2, TOTALAMMO_H - BORDER*2, col)
		
		//Ammo in clip:
		draw.RoundedBox(ROUND, ScrW() - CLIPAMMO_W - PADDING - TOTALAMMO_W - BORDER, ScrH() - CLIPAMMO_H - PADDING, CLIPAMMO_W, CLIPAMMO_H, bordercol)
		draw.RoundedBox(ROUND, ScrW() - CLIPAMMO_W - PADDING - TOTALAMMO_W, (ScrH() - CLIPAMMO_H - PADDING) + BORDER, CLIPAMMO_W - BORDER*2, CLIPAMMO_H - BORDER*2, col)
		
		draw.DrawText(ply:GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType()),"WhiskeyHUDSmall", ScrW() - PADDING - BORDER * 2, ScrH() - TOTALAMMO_H - PADDING + BORDER*2, bordercol, TEXT_ALIGN_RIGHT)
		draw.DrawText(ply:GetActiveWeapon():Clip1(),"WhiskeyHUD", ScrW() - PADDING - BORDER * 2 - TOTALAMMO_W - BORDER, ScrH() - CLIPAMMO_H - PADDING + BORDER*2, bordercol, TEXT_ALIGN_RIGHT)
	end
	
end
//hook.Add("HUDPaint", "clientHUD", clientHUD)