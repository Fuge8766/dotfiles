return {
	'nvim-mini/mini.snippets',
	event = "VeryLazy",
	config = function()
		local gen_loader = require('mini.snippets').gen_loader
		require('mini.snippets').setup({
		   snippets = {
		    gen_loader.from_lang(),
		   },	
		})
	end,
}
