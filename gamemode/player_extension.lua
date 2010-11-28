local meta = FindMetaTable("Player")
if (!meta) then return end

function meta:RefuelJetpack() //Refill Jetpack Fuel to max

	local c = self:GetPlayerClass()
	self.JetpackFuel = c.MaxJetpackFuel

end

function meta:RefillJetpack(amount)

	local c = self:GetPlayerClass()
	self.JetpackFuel = self.JetpackFuel + amount
	
	if self.JetpackFuel > c.MaxJetpackFuel then self.JetpackFuel = c.MaxJetpackFuel end

end

function meta:DrainJetpack(amount)

	local c = self:GetPlayerClass()
	self.JetpackFuel = self.JetpackFuel - amount
	
	if self.JetpackFuel < 0 then self.JetpackFuel = 0 end

end