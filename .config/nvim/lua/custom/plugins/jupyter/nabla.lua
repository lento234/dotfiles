return { -- preview equations
	'jbyuki/nabla.nvim',
	keys = {
		{ '<leader>te', ':lua require"nabla".toggle_virt()<cr>', desc = '[t]oggle math [e]quations' },
	},
}
