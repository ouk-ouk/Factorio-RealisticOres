require("commons")

-- Nullius
if shouldSupportMod(otherMod_nullius) then
	if isItemEnabled("iron") then
		local item = data.raw.item["iron-ore"]
		if item then
			local newTexturePath,changes = string.gsub(item.icon, "^__base__", modRoot)
			item.icon = newTexturePath
		end
	end
end
