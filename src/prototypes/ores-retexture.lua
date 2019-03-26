local mapColors = {
		iron	=	{r=0.615, g=0.320, b=0.247},
		copper	=	{r=0.356, g=0.608, b=0.530},
		uranium	=	{r=0.718, g=0.761, b=0.200}
	}

local function getNewTexturePath(oldTexturePath)
	local newTexturePath,changes = string.gsub(oldTexturePath, "^__base__", "__RealisticOres__")
	return newTexturePath
end

local function changeOreTextures(oreName, mapColor, doShadows, tint)
	local oreItem = data.raw.item[oreName .. "-ore"]
	if oreItem then
		oreItem.icon = getNewTexturePath(oreItem.icon)
	end
	
	local oreResource = data.raw.resource[oreName .. "-ore"]
	if oreResource then
		oreResource.icon = getNewTexturePath(oreResource.icon)
		oreResource.map_color = mapColor
		local oreResourceSheet = oreResource.stages.sheet
		oreResourceSheet.filename = getNewTexturePath(oreResourceSheet.filename)
		if oreResourceSheet.hr_version then
			oreResourceSheet.hr_version.filename = getNewTexturePath(oreResourceSheet.hr_version.filename)
		end
		if oreResource.stages_effect then
			local oreResourceEffectSheet = oreResource.stages_effect.sheet
			oreResourceEffectSheet.filename = getNewTexturePath(oreResourceEffectSheet.filename)
			if oreResourceEffectSheet.hr_version then
				oreResourceEffectSheet.hr_version.filename = getNewTexturePath(oreResourceEffectSheet.hr_version.filename)
			end
			if tint then
				oreResourceEffectSheet.tint = tint
				if oreResourceEffectSheet.hr_version then
					oreResourceEffectSheet.hr_version.tint = tint
				end
			end
		end
	end
	
	local oreParticle = data.raw.particle[oreName .. "-ore-particle"]
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

changeOreTextures("iron", mapColors["iron"], false, nil)
changeOreTextures("copper", mapColors["copper"], false, nil)
changeOreTextures("uranium", mapColors["uranium"], false, nil)

local uraniumProcessing = data.raw.recipe["uranium-processing"]
if uraniumProcessing then
	uraniumProcessing.icon = getNewTexturePath(uraniumProcessing.icon)
end
local uraniumProcessingTech = data.raw.technology["uranium-processing"]
if uraniumProcessingTech then
	uraniumProcessingTech.icon = getNewTexturePath(uraniumProcessingTech.icon)
end

-- Angel's Infinite Ores
if mods["angelsinfiniteores"] then
	local infiniteTintColors = {
			iron	=	{r=0.460, g=0.260, b=0.1255},
			copper	=	{r=0.356, g=0.608, b=0.530},
			uranium	=	{r=0.718, g=0.761, b=0.200}
		}

	local function changeInfiniteOreTextures(oreName, colorIndex, doShadows)
		changeOreTextures(oreName, mapColors[colorIndex], doShadows, infiniteTintColors[colorIndex])
	end

	changeInfiniteOreTextures("infinite-iron", "iron", false)
	changeInfiniteOreTextures("infinite-copper", "copper", false)
	changeInfiniteOreTextures("infinite-uranium", "uranium", false)
end
