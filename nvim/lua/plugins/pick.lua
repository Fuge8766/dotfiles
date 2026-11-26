return {
	'nvim-mini/mini.pick',
	config = function(_,opts)
		local pick = require('mini.pick')
		pick.setup({
			options = {
				use_cache = true,
			},
			window = {
				config = { border = "solid"}
			},
			source = {
				show = pick.default_show
			},
		})
		map({'n', 'v'}, "<leader>e", "<cmd>:Pick explorer<cr>", "Pick explorer")
		map({'n', 'v'}, "<leader>f", "<cmd>:Pick grep_live<cr>", "Pick grep")
		map({'n', 'v'}, "<leader>b", "<cmd>:Pick buffers<cr>", "Pick buffers")
		map({'n', 'v'}, "<leader>t", "<cmd>:Pick treesitter<cr>", "Pick treesitter")
		map({'n', 'v'}, "<leader>r", "<cmd>:Pick registers<cr>", "Pick register")
		map({'n', 'v'}, "<leader>m", "<cmd>:Pick marks<cr>", "Pick marks")
		map({'n', 'v'}, "<C-/>", "<cmd>:Pick buf_lines scope='current' preserve_order=true<cr>", "Pick lines")
	end,
}
