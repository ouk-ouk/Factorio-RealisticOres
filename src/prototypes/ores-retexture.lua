require("commons")

local mapColors = {
		iron	=	{r=0.615, g=0.320, b=0.247},
		copper	=	{r=0.356, g=0.608, b=0.530},
		uranium	=	{r=0.718, g=0.761, b=0.200}
	}

local oreSettings = getOreSettings()
local uraniumGlowSetting = settings.startup[uraniumGlowSettingName].value

local function getNewTexturePath(oldTexturePath)
	local newTexturePath,changes = string.gsub(oldTexturePath, "^__SimpleCompress__/graphics/", modRoot .. "/graphics/icons/")
	local newTexturePath,changes = string.gsub(newTexturePath, "^__base__", modRoot)
	if mods["OldOre"] then
		if settings.startup[oldOreSettingName].value then
			local newTexturePath,changes = string.gsub(newTexturePath, "^(__OldOre__/.*)-[0-9]%.png$", "%1.png")
			local newTexturePath,changes = string.gsub(newTexturePath, "^__OldOre__(/.*)%.png$", modRoot .. "%1_old.png")
		end
	end
	return newTexturePath
end

local function changeOreTextures(oreNameKey, oreName, doShadows, tint)
	if itemsEnabled(oreSettings[oreNameKey]) then
		local oreItem = data.raw.item[oreName .. "-ore"]
		if oreItem then
			oreItem.icon = getNewTexturePath(oreItem.icon)
			local pics = oreItem.pictures
			if pics then
				for i, _ in ipairs(pics) do
					pics[i].filename = getNewTexturePath(pics[i].filename)
				end
			end
		end
	end
	
	if patchesEnabled(oreSettings[oreNameKey]) then
		local oreResource = data.raw.resource[oreName .. "-ore"]
		if oreResource then
			oreResource.icon = getNewTexturePath(oreResource.icon)
			oreResource.map_color = mapColors[oreNameKey]
			local oreResourceSheet = oreResource.stages.sheet
			oreResourceSheet.filename = getNewTexturePath(oreResourceSheet.filename)
			if oreResourceSheet.hr_version then
				oreResourceSheet.hr_version.filename = getNewTexturePath(oreResourceSheet.hr_version.filename)
			end
			if oreResource.stages_effect then
				local oreResourceEffectSheet = oreResource.stages_effect.sheet
				if uraniumGlowSetting then
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
end

for key,oreName in ipairs(oreNames) do
	changeOreTextures(oreName, oreName, false, nil)
end

if itemsEnabled(oreSettings["uranium"]) then
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
if mods["angelsinfiniteores"] then
	if settings.startup[angelsInfiniteOresSettingName].value then
		local infiniteTintColors = {
				iron	=	{r=0.460, g=0.260, b=0.1255},
				copper	=	{r=0.356, g=0.608, b=0.530},
				uranium	=	{r=0.718, g=0.761, b=0.200}
			}
		for _, oreName in ipairs(oreNames) do
			changeOreTextures(oreName, "infinite-" .. oreName, false, infiniteTintColors[oreName])
		end
	end
end

-- Simple Compress
if mods["SimpleCompress"] then
	if settings.startup[simpleCompressSettingName].value then
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
end
