title = 'Mod Configuration Reader for Minetest mods'
project = 'ModConf'
format = 'markdown'
not_luadoc = true

local function italic(value)
	return '<i>' .. value .. '</i>'
end

new_type('setting', 'Settings')
new_type('chatcmd', 'Chat Commands', false)
custom_tags = {
	{'chatparam',
		title = 'Parameters',
	},
	{'settype',
		title = 'Type',
		format = italic,
	},
	{'default',
		title = 'Default',
		format = italic,
	},
}

custom_display_name_handler = function(item, default_handler)
	if item.type == 'chatcmd' and item.tags.chatparam then
		return item.name .. ' [option]'
	end
	return default_handler(item)
end
