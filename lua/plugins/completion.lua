return {
	{
		"saghen/blink.cmp",
		keys = { "g", "K", "[", "]", "<leader>" },
		event = { "InsertEnter", "BufWritePre" },
		version = "1.*",
		dependencies = {
			"Kaiser-Yang/blink-cmp-dictionary",
		},
		config = function()
			require("mason").setup({})
			require("configs.mason-lspconfig")
			require("configs.mason-null-ls")
			require("configs.mason-nvim-dap")
			require("supermaven-nvim").setup({})
			require("configs.blink-cmp")
			require("lspconfig")
		end,
	},
}
