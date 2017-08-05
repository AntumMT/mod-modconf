--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin (AntumDeluge)
  
  See: LICENSE.txt
]]

--- @script init.lua


modconf = {}
modconf.path = core.get_modpath(core.get_current_modname())


local scripts = {
	'api',
}

for i, s in ipairs(scripts) do
	dofile(modconf.path .. '/' .. s .. '.lua')
end

modconf.readConfig(modconf)
