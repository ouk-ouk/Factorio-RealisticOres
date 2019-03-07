local function parseVersionNumber(versionNumber)
	local majorVersion = tonumber(string.match(versionNumber, "^(%d+)%."))
	local minorVersion = tonumber(string.match(versionNumber, "%.(%d+)$"))
	return majorVersion, minorVersion
end

local function isTimeToRechart(oldVersionNumber, newVersionNumber)
	local oldMajorVersion, oldMinorVersion = parseVersionNumber(oldVersionNumber)
	local newMajorVersion, newMinorVersion = parseVersionNumber(newVersionNumber)
	return oldMajorVersion < newMajorVersion or (oldMajorVersion == 1 and oldMinorVersion == 0)
end

script.on_configuration_changed(
	function(data)
		if data.mod_changes == nil then return end
		local modChange = data.mod_changes["RealisticOres"]
		if modChange == nil then return end
		local oldVersion = modChange.old_version
		local newVersion = modChange.new_version
		if oldVersion == nil then
			game.print("Recharting the map upon instalation of mod 'Realistic Ores'...")
			game.forces.player.rechart()
		elseif isTimeToRechart(oldVersion, newVersion) then
			game.print("Recharting the map upon update of mod 'Realistic Ores' (" .. oldVersion .. "-->" .. newVersion .. ")...")
			game.forces.player.rechart()
		end
	end
)
