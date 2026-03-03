return {
	{
		"nvim-tree/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		opts = {
			renderer = {
				indent_markers = {
					enable = true,
				},
				highlight_opened_files = "all",
			},
			update_focused_file = {
				enable = true,
			},
			view = {
				side = "right",
				width = {
					min = 30,
					max = -1,
					padding = 1,
				},
			},
			git = {
				enable = true,
				timeout = 10000,
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules",
						".git",
						".cache",
						".turbo",
						".venv",
						"__pycache__",
					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					egrepify = {},
					buffers = {
						mappings = {
							i = {
								["<c-x>"] = "delete_buffer",
							},
						},
					},
				},
			})
		end,
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
			{
				"fdschmidt93/telescope-egrepify.nvim",
				config = function()
					require("telescope").load_extension("egrepify")
				end,
			},
			{
				"xiyaowong/telescope-emoji.nvim",
				config = function()
					require("telescope").load_extension("emoji")
				end,
			},
			{
				"LinArcX/telescope-env.nvim",
				config = function()
					require("telescope").load_extension("env")
				end,
			},
		},
	},
	{ "lewis6991/gitsigns.nvim", event = "VeryLazy", config = true },
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
	},

	{ "echasnovski/mini.bufremove", version = false, config = true },
	{ "windwp/nvim-spectre", cmd = "Spectre" },
	{
		"stevearc/oil.nvim",
		opt = {},
		cmd = "Oil",
		config = function()
			require("oil").setup({})
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"LunarVim/bigfile.nvim",
		lazy = false,
		opt = {
			filesize = 1, -- size of the file in MiB, the plugin round file sizes to the closest MiB
			pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
			features = { -- features to disable
				"indent_blankline",
				"illuminate",
				"lsp",
				"treesitter",
				"syntax",
				"matchparen",
				"vimopts",
				"filetype",
			},
		},
	},
}
