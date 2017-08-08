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


local function fileExists(file_path)
	local f_exists = false
	
	local f = io.open(file_path, 'r')
	if f then
		f:close()
		f_exists = true
	end
	
	return f_exists
end


local function getFilePath(file_name)
	local file_path = getModPath() .. '/' .. file_name
	
	if not fileExists(file_path) then
		return
	end
	
	return file_path
end


--- Adds fields to the main mod object.
--
-- @function modconf.readConfig
-- @param object
-- @treturn table
function modconf.readConfig(object)
	if object == nil then
		object = {}
	end
	
	local conf_lines = {}
	local conf_path = getFilePath('mod.conf')
	
	if conf_path then
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
	
	return object
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
