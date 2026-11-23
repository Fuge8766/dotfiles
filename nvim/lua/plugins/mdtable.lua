return {
	'Kicamon/markdown-table-mode.nvim',
	ft = 'markdown',
	config = function()
		require('markdown-table-mode').setup({
			options = {
			    insert_leave = true,
			    alig_style = 'left',
			}
		})
		vim.cmd('silent! Mtm')
	end
}
