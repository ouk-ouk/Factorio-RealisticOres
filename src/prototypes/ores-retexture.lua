local function getNewTexturePath(oldTexturePath)
	local newTexturePath,changes = string.gsub(oldTexturePath, "^__base__", "__RealisticOres__")
	return newTexturePath
end

local function changeOreTextures(oreName, mapColor, doShadows)
	local oreItem = data.raw.item[oreName .. "-ore"]
	oreItem.icon = getNewTexturePath(oreItem.icon)
	
	local oreResource = data.raw.resource[oreName .. "-ore"]
	oreResource.icon = getNewTexturePath(oreResource.icon)
	oreResource.map_color = mapColor
	local oreResourceSheet = oreResource.stages.sheet
	oreResourceSheet.filename = getNewTexturePath(oreResourceSheet.filename)
	oreResourceSheet.hr_version.filename = getNewTexturePath(oreResourceSheet.hr_version.filename)
	if oreResource.stages_effect ~= nil then
		local oreResourceEffectSheet = oreResource.stages_effect.sheet
		oreResourceEffectSheet.filename = getNewTexturePath(oreResourceEffectSheet.filename)
		oreResourceEffectSheet.hr_version.filename = getNewTexturePath(oreResourceEffectSheet.hr_version.filename)
	end
	
	local oreParticle = data.raw.particle[oreName .. "-ore-particle"]
	if oreParticle ~= nil then
		for k,picture in pairs(oreParticle.pictures) do
			picture.filename = getNewTexturePath(picture.filename)
			picture.hr_version.filename = getNewTexturePath(picture.hr_version.filename)
		end
		if doShadows then
			for k,shadow in pairs(oreParticle.shadows) do
				shadow.filename = getNewTexturePath(shadow.filename)
				shadow.hr_version.filename = getNewTexturePath(shadow.hr_version.filename)
			end
		end
	end
end

changeOreTextures("iron", {r=0.920, g=0.520, b=0.251}, false)
changeOreTextures("copper", {r=0.356, g=0.608, b=0.530}, false)
changeOreTextures("uranium", {r=0.718, g=0.761, b=0.200}, false)

local uraniumProcessing = data.raw.recipe["uranium-processing"]
uraniumProcessing.icon = getNewTexturePath(uraniumProcessing.icon)
