modName = "RealisticOres"
modRoot = "__" .. modName .. "__"

mainColors = {
	iron	=	{r=0.615, g=0.320, b=0.247},
	copper	=	{r=0.356, g=0.608, b=0.530},
	uranium	=	{r=0.718, g=0.761, b=0.200}
}

oreNames = {"iron", "copper", "uranium"}

local oreSetting_none = "none"
local oreSetting_patches = "patches"
local oreSetting_items = "items"
local oreSetting_all = "all"

oreSettingValues = {oreSetting_none, oreSetting_patches, oreSetting_items, oreSetting_all}
defaultOreSettingValue = oreSetting_all

local settingNamePrefix = modName .. "-"
function getOreSettingName(oreName)
	return settingNamePrefix .. oreName
end
uraniumGlowSettingName = settingNamePrefix .. "uraniumGlow"
angelsInfiniteOresSettingName = settingNamePrefix .. "angelsInfiniteOres"
deadlocksStackingBeltboxesSettingName = settingNamePrefix .. "deadlocksStackingBeltboxes"
simpleCompressSettingName = settingNamePrefix .. "simpleCompress"
miningDronesSettingName = settingNamePrefix .. "miningDrones"

function getOreSettings()
	return {
			iron	=	settings.startup[getOreSettingName("iron")].value,
			copper	=	settings.startup[getOreSettingName("copper")].value,
			uranium	=	settings.startup[getOreSettingName("uranium")].value
		}
end

function patchesEnabled(oreSetting)
	return oreSetting == oreSetting_patches or oreSetting == oreSetting_all
end
function itemsEnabled(oreSetting)
	return oreSetting == oreSetting_items or oreSetting == oreSetting_all
end
