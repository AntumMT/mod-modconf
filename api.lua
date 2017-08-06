--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin (AntumDeluge)
  
  See: LICENSE.txt
]]

--- ***modconf*** mod API.
--
-- @script api.lua


local function getModPath()
	return core.get_modpath(core.get_current_modname())
end


--- Adds fields to the main mod object.
--
-- @function modconf.readConfig
-- @param object
function modconf.readConfig(object)
	local conf_exists = false
	local conf_lines = {}
	local conf_path = getModPath() .. '/mod.conf'
	
	local conf = io.open(conf_path, 'r')
	if conf then
		conf:close()
		conf_exists = true
	end
	
	if conf_exists then
		for line in io.lines(conf_path) do
			table.insert(conf_lines, line)
		end
	end
	
	for i, line in ipairs(conf_lines) do
		-- FIXME: Remove preceding & following whitespace automatically
		local conf_key = string.split(line, ' = ')
		if #conf_key > 1 then
			-- Append field to object
			object[conf_key[1]] = conf_key[2]
		end
	end
end


if not core.get_mod_settings then
	--- Creates a settings object from the local ***mod.conf*** file.
	--
	-- @function core.get_mod_settings
	-- @treturn settings_object
	function core.get_mod_settings()
		return Settings(core.get_modpath(minetest.get_current_modname()) .. '/mod.conf')
	end
	
	--- Alias of ***core.get_mod_settings***
	--
	-- @function minetest.get_mod_settings
	-- @see core.get_mod_settings
	minetest.get_mod_settings = core.get_mod_settings
end
