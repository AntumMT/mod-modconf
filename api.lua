--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin (AntumDeluge)
  
  See: LICENSE.txt
]]

--- ***modconf*** mod API.
--
-- @script api.lua


local function isFloat(s_value)
	if not string.find(s_value, '.') then return false end
	
	local s_list = string.split(s_value, '.')
	local s_length = #s_list
	if s_length < 1 then
		return false
	elseif s_length == 1 then
		table.insert(s_list, '0')
	end
	
	for i, num in ipairs(s_list) do
		if tonumber(num) == nil then return false end
	end
	
	return true
end


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
-- @function modconf.getModMetaData
-- @param object
-- @treturn table
function modconf.getModMetaData(object)
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
		local conf_key = string.split(line, '=')
		if #conf_key > 1 then
			-- Append field to object
			object[conf_key[1]:trim()] = conf_key[2]:trim()
		end
	end
	
	return object
end


if not core.get_mod_metadata then
	--- Alias of ***modconf.getModMetaData***.
	--
	-- @function core.get_mod_metadata
	-- @see modconf.getModMetaData
	core.get_mod_metadata = modconf.getModMetaData
	
	--- Alias of ***modconf.getModMetaData***.
	--
	-- @function minetest.get_mod_metadata
	-- @see modconf.getModMetaData
	minetest.get_mod_metadata = modconf.getModMetaData
end


--- Reads default settings from local ***settingtypes.txt*** file.
--
-- FIXME: Unfinished
--
-- @function modconf.getModDefaults
-- @tparam table object Default settings object to be formatted (Can be a *table* or *nil*).
-- @treturn table Default settings object.
function modconf.getModDefaults(object)
	if object == nil then
		object = {}
	end
	
	local lines = {}
	local file_path = getFilePath('settingtypes.txt')
	
	if file_path then
		for line in io.lines(file_path) do
			local comment = string.find(line, '#') == 1
			if line and not comment and string.match(line, '^([a-zA-Z])') then
				table.insert(lines, line)
			end
		end
	end
	
	for i, line in ipairs(lines) do
		local key = string.split(line, ' (')
		local temp = string.split(string.split(key[2], ') ')[2], ' ')
		key = key[1]
		local value = nil
		
		if #temp >= 2 then
			local k_type = temp[1]
			local value = temp[2]
			
			if k_type == 'int' then
				-- Convert integers
				value = tonumber(value)
			elseif k_type == 'bool' then
				-- Convert booleans
				if value == 'true' then
					value = true
				else
					value = false
				end
			elseif k_type == 'float' and isFloat(value) then
				-- FIXME: How to convert to float (math.tofloat(string)?)
				--        Currently converts to table.
				value = string.split(value, '.')
				for i, v in ipairs(value) do
					value[i] = tonumber(v)
					print(type(value[i]))
				end
				--value = {value[1], value[2]}
				value = table.concat({value[1], value[2]}, '.')
			end
			
			-- Append field to object
			object[key] = value
		end
	end
	
	return object
end


if not core.get_mod_defaults then
	--- Alias of ***modconf.getModDefaults***.
	--
	-- @function minetest.get_mod_defaults
	-- @see modconf.getModDefaults
	core.get_mod_defaults = modconf.getModDefaults
	
	--- Alias of ***modconf.getModDefaults***.
	--
	-- @function minetest.get_mod_defaults
	-- @see modconf.getModDefaults
	minetest.get_mod_defaults = modconf.getModDefaults
end
