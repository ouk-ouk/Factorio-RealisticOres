require("commons")

-- Utils
local function getNewTexturePath(oldTexturePath)
	local newTexturePath,changes = string.gsub(oldTexturePath, "^__SimpleCompress__/graphics/", modRoot .. "/graphics/icons/")
	local newTexturePath,changes = string.gsub(newTexturePath, "^__base__", modRoot)
	-- Old Ores
	if shouldSupportMod(otherMod_oldOre) then
		newTexturePath,changes = string.gsub(newTexturePath, "^(__OldOre__/.*)-[0-9]%.png$", "%1.png")
		newTexturePath,changes = string.gsub(newTexturePath, "^__OldOre__(/.*)%.png$", modRoot .. "%1_old.png")
	end
	return newTexturePath
end

-- Change ore textures and releated sprites
local function changeOreTextures(oreNameKey, oreName, doShadows, tint)
	if isItemEnabled(oreNameKey) then
		local oreItem = data.raw.item[oreName .. "-ore"]
		if oreItem then
			oreItem.icon = getNewTexturePath(oreItem.icon)
			local pics = oreItem.pictures
			if pics then
				for _, pic in ipairs(pics) do
					-- Uranium ore uses layers, the rest don't.
					if pic.layers then
						for _, layer in ipairs(pic.layers) do
							layer.filename = getNewTexturePath(layer.filename)
						end
					else
						pic.filename = getNewTexturePath(pic.filename)
					end
				end
			end
		end
	end
	
	if isPatchEnabled(oreNameKey) then
		local mapColors = mainColors
		local oreResource = data.raw.resource[oreName .. "-ore"]
		if oreResource then
			oreResource.icon = getNewTexturePath(oreResource.icon)
			oreResource.map_color = mapColors[oreNameKey]
			oreResource.mining_visualisation_tint = mapColors[oreNameKey]
			local oreResourceSheet = oreResource.stages.sheet
			oreResourceSheet.filename = getNewTexturePath(oreResourceSheet.filename)
			if oreResourceSheet.hr_version then
				oreResourceSheet.hr_version.filename = getNewTexturePath(oreResourceSheet.hr_version.filename)
			end
			if oreResource.stages_effect then
				local oreResourceEffectSheet = oreResource.stages_effect.sheet
				if isUraniumGlowEnabled() then
					oreResourceEffectSheet.filename = getNewTexturePath(oreResourceEffectSheet.filename)
					if oreResourceEffectSheet.hr_version then
						oreResourceEffectSheet.hr_version.filename = getNewTexturePath(oreResourceEffectSheet.hr_version.filename)
					end
				end
				if tint then
					oreResourceEffectSheet.tint = tint
					if oreResourceEffectSheet.hr_version then
						oreResourceEffectSheet.hr_version.tint = tint
					end
				end
			end
		end
		
		local oreParticle = data.raw['optimized-particle'][oreName .. "-ore-particle"]
		if oreParticle then
			for k,picture in pairs(oreParticle.pictures) do
				picture.filename = getNewTexturePath(picture.filename)
				if picture.hr_version then
					picture.hr_version.filename = getNewTexturePath(picture.hr_version.filename)
				end
			end
			if doShadows then
				for k,shadow in pairs(oreParticle.shadows) do
					shadow.filename = getNewTexturePath(shadow.filename)
					if shadow.hr_version then
						shadow.hr_version.filename = getNewTexturePath(shadow.hr_version.filename)
					end
				end
			end
		end
	end
end

for _,oreName in ipairs(oreNames) do
	changeOreTextures(oreName, oreName, false, nil)
end

if isItemEnabled("uranium") then
	local uraniumProcessing = data.raw.recipe["uranium-processing"]
	if uraniumProcessing then
		uraniumProcessing.icon = getNewTexturePath(uraniumProcessing.icon)
	end
	local uraniumProcessingTech = data.raw.technology["uranium-processing"]
	if uraniumProcessingTech then
		uraniumProcessingTech.icon = getNewTexturePath(uraniumProcessingTech.icon)
	end
end

-- Angel's Infinite Ores
if shouldSupportMod(otherMod_angelsInfiniteOres) then
	local infiniteTintColors = {
			iron	=	{r=0.460, g=0.260, b=0.1255},
			copper	=	{r=0.356, g=0.608, b=0.530},
			uranium	=	{r=0.718, g=0.761, b=0.200},
		}
	for _, oreName in ipairs(oreNames) do
		changeOreTextures(oreName, "infinite-" .. oreName, false, infiniteTintColors[oreName])
	end
end

-- Simple Compress
if shouldSupportMod(otherMod_simpleCompress) then
	for _, oreName in ipairs(oreNames) do
		changeOreTextures(oreName, "compressed-" .. oreName, false, nil)
	end
	for _, oreName in ipairs(oreNames) do
		local compressRecipe = data.raw.recipe["compressed-" .. oreName]
		if compressRecipe then
			compressRecipe.icon = getNewTexturePath(compressRecipe.icon)
		end
	end
	local oreCompressTech = data.raw.technology["orecompresstech"]
	if oreCompressTech then
		oreCompressTech.icon = modRoot .. "/graphics/technology/compress-ores.png"
	end
end

-- Nullius
if shouldSupportMod(otherMod_nullius) then
	if isItemEnabled("iron") then
		local tech = data.raw.technology["nullius-checkpoint-iron-ore"]
		if tech then
			icons = tech["icons"]
			if icons then
				icon = icons[1]
				if icon then
					local newTexturePath,changes = string.gsub(icon.icon, "^__base__", modRoot)
					icon.icon = newTexturePath
				end
			end
		end
	end
end
