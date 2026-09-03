local u = require("utils")
return {
	-- {
	-- 	"akinsho/bufferline.nvim", -- bufferline
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		options = {
	-- 			diagnostics = "nvim_lsp",
	-- 			always_show_bufferline = false,
	-- 			offsets = {
	-- 				{
	-- 					filetype = "NvimTree",
	-- 					text = "File Explorer",
	-- 					highlight = "Directory",
	-- 					text_align = "left",
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	dependencies = {
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- },
	{
		"nvim-lualine/lualine.nvim", -- status line
		event = "VeryLazy",
		opts = {
			options = {
				theme = "auto",
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					{ "diagnostics" },
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
				},
				lualine_y = {
					{ "progress", separator = "", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
				lualine_z = {
					function()
						return " " .. os.date("%R")
					end,
				},
			},
			extensions = { "nvim-tree" },
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPost",
		opts = {
			indent = {
				char = "│",
			},
			exclude = {
				buftypes = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy" },
			},
			scope = {
				show_start = false,
				show_end = false,
				show_exact_scope = false,
			},
		},
	},

	{
		"echasnovski/mini.indentscope",
		event = "BufReadPre",
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
			require("mini.indentscope").setup(opts)
		end,
	},

	{
		"nvim-zh/colorful-winsep.nvim",
		event = { "WinLeave" },
		config = true,
	},
	{
		"j-hui/fidget.nvim",
		ft = u.coding_ft,
		opts = {},
	},
	{
		"gorbit99/codewindow.nvim",
		config = function()
			require("codewindow").setup({
				minimap_width = 10,
				exclude_filetypes = { "NvimTree" },
			})
		end,
	},
}
