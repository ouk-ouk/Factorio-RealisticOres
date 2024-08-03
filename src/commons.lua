-- General
modName = "RealisticOres"
modRoot = "__" .. modName .. "__"

-- Colors
mainColors = {
	iron	=	{r=0.615, g=0.320, b=0.247},
	copper	=	{r=0.356, g=0.608, b=0.530},
	uranium	=	{r=0.718, g=0.761, b=0.200},
}

-- Ores
oreNames = {"iron", "copper", "uranium"}

-- Other supported mods
otherMod_angelsInfiniteOres			=	"angelsInfiniteOres"
otherMod_deadlocksStackingBeltboxes	=	"deadlocksStackingBeltboxes"
otherMod_simpleCompress				=	"simpleCompress"
otherMod_miningDrones				=	"miningDrones"
otherMod_oldOre						=	"oldOre"
otherMod_nullius					=	"nullius"
otherMod_asteroidMining				=	"asteroidMining"
otherMods = {otherMod_angelsInfiniteOres, otherMod_deadlocksStackingBeltboxes, otherMod_simpleCompress, otherMod_miningDrones, otherMod_oldOre, otherMod_nullius, otherMod_asteroidMining}
otherModsRealNames = {
	[otherMod_angelsInfiniteOres]			=	"angelsinfiniteores",
	[otherMod_deadlocksStackingBeltboxes]	=	"deadlock-beltboxes-loaders",
	[otherMod_simpleCompress]				=	"SimpleCompress",
	[otherMod_miningDrones]					=	"Mining_Drones",
	[otherMod_oldOre]						=	"OldOre",
	[otherMod_nullius]						=	"nullius",
	[otherMod_asteroidMining]				=	"Asteroid_Mining",
}


-- Settings names
local oreSetting_none		=	"none"
local oreSetting_patches	=	"patches"
local oreSetting_items		=	"items"
local oreSetting_all		=	"all"

oreSettingValues = {oreSetting_none, oreSetting_patches, oreSetting_items, oreSetting_all}
defaultOreSettingValue = oreSetting_all

local settingNamePrefix = modName .. "-"
function getOreSettingName(oreName)
	return settingNamePrefix .. oreName
end
uraniumGlowSettingName = settingNamePrefix .. "uraniumGlow"
function getOtherModSettingName(otherMod)
	return settingNamePrefix .. otherMod
end


-- Utils
function getOreSetting(oreName)
	return settings.startup[getOreSettingName(oreName)].value
end
function isPatchEnabled(oreName)
	local oreSetting = getOreSetting(oreName)
	return oreSetting == oreSetting_patches or oreSetting == oreSetting_all
end
function isItemEnabled(oreName)
	local oreSetting = getOreSetting(oreName)
	return oreSetting == oreSetting_items or oreSetting == oreSetting_all
end

function isUraniumGlowEnabled()
	return settings.startup[uraniumGlowSettingName].value
end

function isModPresent(otherMod)
	return mods[otherModsRealNames[otherMod]]
end
function isModSupportEnabled(otherMod)
	return settings.startup[getOtherModSettingName(otherMod)].value
end
function shouldSupportMod(otherMod)
	return isModPresent(otherMod) and isModSupportEnabled(otherMod)
end
