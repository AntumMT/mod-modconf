## Mod Configuration Reader (*modconf*) mod for [Minetest][]


---
### **Description:**

A Minetest mod that reads data from ***mod.conf*** & ***settingtypes.txt*** files.

**NOTE:** This mod is a ***work-in-progress*** but is functional. Currently, in order to use ***modconf.getModMetaData***, key-value instances in *mod.conf* must be delimited by an equals symbol with one whitespace on both sides (e.g. " = "). In the future, trimming out whitespace will be done automatically.


---
### **Example Usage:**

*depends.txt:*
```
modconf?
```

*init.lua* (read *mod.conf* file using ***modconf.getModMetaData***):
```lua
-- Main global object table
mymod = {}

-- Create settings object from core function
if minetest.global_exists('modconf') then
	modconf.getModMetaData(mymod)
end

-- Alternatively can be called in this manner
mymod = modconf.getModMetaData()

minetest.log('action', 'Loading ' .. mymod.name .. ' version ' .. mymod.version)
```

*init.lua* (reading *settingtypes.txt* file with ***modconf.getModDefaults***):
```lua
-- Table object to read fields into
local defaults = {}

-- Read fields into table from 'settingtypes.txt'
if minetest.get_modpath('modconf') then
    modconf.getModDefaults(defaults)
end

-- Alternatively can be called in this manner
local defaults = modconf.getModDefaults()
```

---
### **Links:**

- Downloads:
  - Current: [zip][dl.current.zip] | [tarball][dl.current.tar]
- Pages:
  - [Forum](https://forum.minetest.net/viewtopic.php?t=18247)
- Documentation:
  - [API](https://antummt.github.io/mod-modconf/api.html)


[Minetest]: http://www.minetest.net/

[dl.current.zip]: https://github.com/AntumMT/mod-modconf/zipball/master
[dl.current.tar]: https://github.com/AntumMT/mod-modconf/tarball/master
