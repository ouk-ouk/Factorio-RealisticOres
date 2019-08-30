modName = "RealisticOres"
modRoot = "__" .. modName .. "__"

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
oldOreSettingName = settingNamePrefix .. "oldOre"
liquifyRawMaterialsSettingName = settingNamePrefix .. "liquifyRawMaterials"

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
