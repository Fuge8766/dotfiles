return {
	'eduardo-antunes/plainline',
	opts = {
		sections = {
		  left  = {
		    "mode",
		    "name",
		    "branch",
		  },
		  right = {
		    "macro",
		    "position",
		  },
		},
		inactive_sections = {
		  left  = { "name" },
		  right = { "percentage" },
		},
		separator = " ",
		name_filters = { "clean" },
		winbar = nil,
	}
}
