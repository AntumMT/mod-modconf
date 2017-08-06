## Mod Configuration Reader (*modconf*) mod for [Minetest][]


---
### **Description:**

A Minetest mod that reads settings from 'mod.conf'.

**NOTE:** This mod is a ***work-in-progress*** but is functional. Currently, in order to use ***modconf.readConfig***, key-value instances in *mod.conf* must be delimited by an equals symbol with one whitespace on both sides (e.g. " = "). In the future, trimming out whitespace will be done automatically.


---
### **Example Usage:**

*depends.txt:*
```
modconf?
```

*init.lua* (using core object function provided by ***modconf***):
```lua
-- Main global object table
mymod = {}

-- Create settings object from core function
if minetest.global_exists('modconf') or minetest.get_modpath('modconf') then
	mymod.settings = minetest.get_mod_settings()
end

mymod.name = mymod.settings:get('name')
mymod.version = mymod.settings:get('version')

minetest.log('action', 'Loading ' .. mymod.name .. ' version ' .. mymod.version)
```

*init.lua* (using ***modconf.readConfig***):
```lua
-- Main global object table
mymod = {}

-- Read fields into table from 'mod.conf'
if minetest.global_exists('modconf') then
    modconf.readConfig(mymod)
end

minetest.log('action', 'Loading ' .. mymod.name .. ' version ' .. mymod.version)
```


---
### **Documentation:**

[API Documentation](https://antummt.github.io/mod-modconf/api.html)


[Minetest]: http://www.minetest.net/
