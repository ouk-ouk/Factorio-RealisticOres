require("commons")

for key,oreName in ipairs(oreNames) do
	data:extend({
		{
			type = "string-setting",
			allowed_values = oreSettingValues,
			default_value = defaultOreSettingValue,
			name = getOreSettingName(oreName),
			setting_type = "startup",
			order = "aa"
		}
	})
end
data:extend({
	{
		type = "bool-setting",
		default_value = true,
		name = uraniumGlowSettingName,
		setting_type = "startup",
		order = "ab"
	}
})

if mods["angelsinfiniteores"] then
	data:extend({
		{
			type = "bool-setting",
			default_value = true,
			name = angelsInfiniteOresSettingName,
			setting_type = "startup",
			order = "b"
		}
	})
end
if mods["DeadlockStacking"] or mods["deadlock-beltboxes-loaders"] then
	data:extend({
		{
			type = "bool-setting",
			default_value = true,
			name = deadlocksStackingBeltboxesSettingName,
			setting_type = "startup",
			order = "b"
		}
	})
end