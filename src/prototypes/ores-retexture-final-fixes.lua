-- Deadlock's Stacking Beltboxes
-- Deadlock's Stacking Beltboxes & Compact Loaders
if mods["DeadlockStacking"] or mods["deadlock-beltboxes-loaders"] then
	local function getNewStackTexturePath(oldTexturePath)
		local newTexturePath,changes = string.gsub(oldTexturePath, "^__DeadlockStacking__/graphics/", "__RealisticOres__/graphics/icons/")
		local newTexturePath,changes = string.gsub(newTexturePath, "^__deadlock%-beltboxes%-loaders__/graphics/", "__RealisticOres__/graphics/icons/")
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
	
	replaceStackIcons("iron")
	replaceStackIcons("copper")
	replaceStackIcons("uranium")
end
