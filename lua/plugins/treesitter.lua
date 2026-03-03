return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "markdown" },
				},
				indent = { enable = true },
				rainbow = {
					enable = false,
					-- query = "rainbow-parens",
					extended_mode = true,
					strategy = require("ts-rainbow.strategy.global"),
				},
				context_commentstring = { enable = true },
				ensure_installed = {
					"latex",
					"bibtex",
					"markdown",
					"c",
					"cpp",
					"graphql",
					"rust",
					"javascript",
					"typescript",
					"tsx",
					"css",
					"scss",
					"html",
					"lua",
					"luadoc",
					"python",
					"r",
					"scala",
					"vimdoc",
					"http",
					"bash",
					"toml",
					"json",
					"prisma",
					"sql",
					"glimmer",
				},
			})
		end,
		dependencies = {
			{
				"windwp/nvim-ts-autotag",
				config = function()
					require("nvim-ts-autotag").setup({
						opts = {
							enable_close = true,
							enable_rename = true,
							enable_close_on_slash = false,
						},
					})
				end,
			},
			"HiPhish/nvim-ts-rainbow2",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost",
		opts = {},
	},
	{
		"bennypowers/template-literal-comments.nvim",
		event = "BufReadPost",
		config = true,
		ft = { "javascript", "typescript" },
	},
}
