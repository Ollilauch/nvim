local configs = require'nvim-treesitter.configs'
configs.setup {
	ensure_installed = "maintained",
	highlight = {
		enable = true,
	}
}

source $HOME/.config/nvim/vim-plug/plugins.vim

