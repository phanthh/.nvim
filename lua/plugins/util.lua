return {
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},
	{
		"ellisonleao/glow.nvim",
		cmd = "Glow",
		opts = {
			border = "single",
			style = "dark",
			pager = false,
			width_ratio = 0.9,
			height_ratio = 0.9,
		},
	},
	-- {
	-- 	"rest-nvim/rest.nvim",
	-- 	ft = { "http" },
	-- 	config = function()
	-- 		require("rest-nvim").setup({
	-- 			result_split_horizontal = true,
	-- 		})
	-- 	end,
	-- 	dependencies = { "vhyrro/luarocks.nvim" },
	-- },

	{
		"numToStr/Navigator.nvim",
		cmd = { "NavigatorLeft", "NavigatorRight", "NavigatorUp", "Navigatordown" },
		config = true,
	},

	{
		"NvChad/nvim-colorizer.lua",
		event = "VeryLazy",
		opts = {
			options = {
				names = false,
				hsl_fn = true,
			},
		},
	},

	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
	},
	{
		"cbochs/grapple.nvim",
		opts = {
			scope = "git", -- also try out "git_branch"
		},
		event = { "BufReadPost", "BufNewFile" },
		cmd = "Grapple",
	},
	{ "tpope/vim-fugitive", cmd = { "Git", "G" } },
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{ "PHSix/faster.nvim", lazy = false },
	{ "mcauley-penney/tidy.nvim", event = "BufWritePre", config = true },
	{
		"https://codeberg.org/andyg/leap.nvim",
		lazy = false,
		dependencies = { "tpope/vim-repeat" },
	},
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	{ "kylechui/nvim-surround", event = "InsertEnter", config = true },
	{
		"danymat/neogen",
		cmd = "Neogen",
		config = true,
		opts = {
			snippet_engine = "luasnip",
		},
	},
	{ "chrisgrieser/nvim-early-retirement", config = true, event = "VeryLazy" },
	{ "f-person/git-blame.nvim", cmd = "GitBlameToggle" },
	{ "nacro90/numb.nvim", event = "CmdlineEnter", config = true },
	{ "opdavies/toggle-checkbox.nvim" },
	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
		config = function()
			require("diffview").setup({
				enhanced_diff_hl = true,
				view = {
					merge_tool = {
						-- Config for conflicted files in diff views during a merge or rebase.
						layout = "diff3_mixed",
						disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
						winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
					},
				},
			})
		end,
	},
	"nvim-lua/plenary.nvim",
{ "mechatroner/rainbow_csv", ft = { "csv" } },
}
