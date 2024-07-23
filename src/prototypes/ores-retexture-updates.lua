require("commons")

local oreSettings = getOreSettings()

-- Nullius
if mods["nullius"] then
	if settings.startup[nulliusSettingName].value then
		if itemsEnabled(oreSettings["iron"]) then
			local item = data.raw.item["iron-ore"]
			if item then
				local newTexturePath,changes = string.gsub(item.icon, "^__base__", modRoot)
				item.icon = newTexturePath
			end
		end
	end
end
