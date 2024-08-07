NTEYE.ClientUpdateCooldown = 0
NTEYE.ClientUpdateInterval = 120


-- updates client effects every 0.5 seconds
Hook.Add("think", "NTEYE.updatetriggerclient", function()
    if HF.GameIsPaused() or not Level.Loaded then return end
    NTEYE.ClientUpdateCooldown = NTEYE.ClientUpdateCooldown-4
    if (NTEYE.ClientUpdateCooldown <= 0) then
        NTEYE.ClientUpdateCooldown = NTEYE.ClientUpdateInterval
        NTEYE.UpdateHumanEyeEffect(character)
    end
end)


playerHasHUD = 0
eyetype = "" --What eye does the user have
HUDitem = "" --What HUD needs to be called ex: eyethermalHUDitem
--I didnt test this, idek if this is the proper syntax,
--but what this SHOULD do is work like this;
--If I want the thermal hud, I will call the NTEYE.GetHUD("eyethermal", "eyethermalHUDitem")

--In any case if this doesn't work it should give you some idea of how to implement it

 NTEYE.GetHUD = function(eyetype, HUDitem)
		
		if playerHasHUD == 1 then return end
	
		if not HF.HasAffliction(Character.Controlled, eyetype) then return end

		if itemHUD==nil then
				for item in Item.ItemList do --make this global, when adding more eyes
				if item.Prefab.Identifier == HUDitem then
					item.Equip(Character.Controlled)
					itemHUD = item.GetComponentString("StatusHUD")
					break
				end
			end
		end
	itemHUD.DrawHUD(ptable["spriteBatch"], Character.Controlled)
end


-- infrared eye thermal effect
Hook.Patch("Barotrauma.GUI", "Draw", function(instance, ptable)

		if not HF.HasAffliction(Character.Controlled, "eyeinfrared") then return end
		
		if thermalHUD==nil then
			for item in Item.ItemList do
				if item.Prefab.Identifier == "eyethermalHUDitem" then
					thermalHUD = item.GetComponentString("StatusHUD")
					break
				end
			end
		end

		thermalHUD.DrawHUD(ptable["spriteBatch"], Character.Controlled)

end)


--Eye Effect Check Functions only runs on client
function NTEYE.UpdateHumanEyeEffect(character)
--print("debug:UpdateHumanEyeEffect")
if HF.HasAffliction(Character.Controlled, "eyebionic") then
		local parameters = Level.Loaded.LevelData.GenerationParams
		parameters.AmbientLightColor = Color(50, 50, 0, 35)
		for k, hull in pairs(Hull.HullList) do
        hull.AmbientLight = Color(60, 60, 0, 75) 
        end
  
elseif HF.HasAffliction(Character.Controlled, "eyenight") then
		local parameters = Level.Loaded.LevelData.GenerationParams
		parameters.AmbientLightColor = Color(20, 160, 30, 200)
		for k, hull in pairs(Hull.HullList) do
        hull.AmbientLight = Color(20, 160, 20, 150) 
        end
 
elseif HF.HasAffliction(Character.Controlled, "eyeinfrared") then
			--This is a test of the GetHUD function
		NTEYE.GetHUD("eyethermal", "eyethermalHUDitem")
		local parameters = Level.Loaded.LevelData.GenerationParams
		parameters.AmbientLightColor = Color(25, 0, 75, 40)
		for k, hull in pairs(Hull.HullList) do
        hull.AmbientLight = Color(50, 0, 200, 75) 
        end

elseif HF.HasAffliction(Character.Controlled, "eyeplastic") then
		local parameters = Level.Loaded.LevelData.GenerationParams
		parameters.AmbientLightColor = Color(0, 0, 255, 5)
		for k, hull in pairs(Hull.HullList) do
        hull.AmbientLight = Color(0, 0, 255, 5) 
        end
 
elseif HF.HasAffliction(Character.Controlled, "eyemonster") then
		if Game.IsMultiplayer then Character.Controlled.TeamID = 0 end
		local parameters = Level.Loaded.LevelData.GenerationParams
		parameters.AmbientLightColor = Color(50, 0, 50, 5)
		for k, hull in pairs(Hull.HullList) do
        hull.AmbientLight = Color(160, 160, 70, 25) 
        end
 
elseif HF.HasAffliction(Character.Controlled, "eyehusk") then
		if Game.IsMultiplayer then Character.Controlled.TeamID = 4 end
		local parameters = Level.Loaded.LevelData.GenerationParams
		parameters.AmbientLightColor = Color(115, 115, 20, 5)
		for k, hull in pairs(Hull.HullList) do
        hull.AmbientLight = Color(115, 115, 30, 30) 
        end
 
elseif HF.HasAffliction(Character.Controlled, "eyeterror") then
		if Game.IsMultiplayer then Character.Controlled.TeamID = 2 end
		local parameters = Level.Loaded.LevelData.GenerationParams
		parameters.AmbientLightColor = Color(255, 0, 0, 125)
		for k, hull in pairs(Hull.HullList) do
        hull.AmbientLight = Color(255, 0, 0, 125) 
        end

else	local parameters = Level.Loaded.LevelData.GenerationParams
		parameters.AmbientLightColor = Color(10, 10, 10, 25)
		for k, hull in pairs(Hull.HullList) do
        hull.AmbientLight = Color(20, 20, 20, 35) 
        end
		
		if Character.Controlled ~= nil then 
			if(Character.Controlled.IsHuman and not Character.Controlled.IsDead) then Character.Controlled.TeamID = 1 end
		end

		
	end
end


