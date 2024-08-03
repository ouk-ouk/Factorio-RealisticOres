require("commons")

-- Main
for _,oreName in ipairs(oreNames) do
	data:extend({
		{
			type = "string-setting",
			allowed_values = oreSettingValues,
			default_value = defaultOreSettingValue,
			name = getOreSettingName(oreName),
			setting_type = "startup",
			order = "aa",
		}
	})
end
data:extend({
	{
		type = "bool-setting",
		default_value = true,
		name = uraniumGlowSettingName,
		setting_type = "startup",
		order = "ab",
	}
})

-- Other mods
for _,otherMod in ipairs(otherMods) do
	if isModPresent(otherMod) then
		data:extend({
			{
				type = "bool-setting",
				default_value = true,
				name = getOtherModSettingName(otherMod),
				setting_type = "startup",
				order = "b",
			}
		})
	end
end
