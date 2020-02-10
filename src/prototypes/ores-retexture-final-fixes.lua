require("commons")

local oreSettings = getOreSettings()

-- Deadlock's Stacking Beltboxes & Compact Loaders
if mods["deadlock-beltboxes-loaders"] then
	if settings.startup[deadlocksStackingBeltboxesSettingName].value then
		local function getNewStackTexturePath(oldTexturePath)
			local newTexturePath,changes = string.gsub(oldTexturePath, "^__deadlock%-beltboxes%-loaders__/graphics/icons/square/", modRoot .. "/graphics/icons/")
			local newTexturePath,changes = string.gsub(newTexturePath, "^__deadlock%-beltboxes%-loaders__/graphics/", modRoot .. "/graphics/")
			return newTexturePath
		end
		
		local function replaceStackIcon(somethingWithIcon)
			if somethingWithIcon then
				if somethingWithIcon.icon then
					somethingWithIcon.icon = getNewStackTexturePath(somethingWithIcon.icon)
				end
				if somethingWithIcon.icons then
					if somethingWithIcon.icons[1] then
						somethingWithIcon.icons[1].icon = getNewStackTexturePath(somethingWithIcon.icons[1].icon)
					end
				end
			end
		end
		
		local function replaceStackIcons(itemName)
			replaceStackIcon(data.raw.item["deadlock-stack-" .. itemName .. "-ore"])
			replaceStackIcon(data.raw.recipe["deadlock-stacks-stack-" .. itemName .. "-ore"])
			replaceStackIcon(data.raw.recipe["deadlock-stacks-unstack-" .. itemName .. "-ore"])
		end
		
		for key,oreName in ipairs(oreNames) do
			if itemsEnabled(oreSettings[oreName]) then
				replaceStackIcons(oreName)
			end
		end
	end
end
