local parsers = {
	"latex",
	"bibtex",
	"markdown",
	"markdown_inline",
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
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					if not pcall(vim.treesitter.start, args.buf) then
						return
					end
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					if args.match == "markdown" then
						vim.bo[args.buf].syntax = "ON"
					end
				end,
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
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost",
		opts = {
			enable = true,
			multiwindow = false,
			max_lines = 2,
			multiline_threshold = 2,
			trim_scope = "outer",
			mode = "topline",
		},
	},
	{
		"bennypowers/template-literal-comments.nvim",
		event = "BufReadPost",
		ft = { "javascript", "typescript" },
	},
}
