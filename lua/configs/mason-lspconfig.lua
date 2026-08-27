local km = require("utils").keymap
local kmb = require("utils").keymap_buf

local lsps = {
	"lua_ls",
	"pyright",
	"cssls",
	"tailwindcss",
	"bashls",
	"clangd",
	"rust_analyzer",
	"gopls",
	"ltex",
	"tsc",
}

-- mason-lspconfig
require("mason-lspconfig").setup({
	ensure_installed = lsps,
	automatic_enable = {
		exclude = { "stylua" },
	},
})

km("n", "<leader>e", vim.diagnostic.open_float)
km("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
km("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
km("n", "<leader>q", vim.diagnostic.setloclist)

vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
	virtual_text = false,
	virtual_lines = { current_line = true },
})

local on_attach = function(client, bufnr)
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
	if client:supports_method("textDocument/documentColor") then
		vim.lsp.document_color.enable(true, { bufnr = bufnr })
	end
	kmb(bufnr, "n", "gD", vim.lsp.buf.declaration)
	kmb(bufnr, "n", "gd", vim.lsp.buf.definition)
	kmb(bufnr, "n", "K", function()
		vim.lsp.buf.hover({ border = "rounded", max_height = 25, max_width = 200 })
	end)
	kmb(bufnr, "n", "gi", vim.lsp.buf.implementation)
	kmb(bufnr, "n", "<C-k>", vim.lsp.buf.signature_help)
	kmb(bufnr, "n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
	kmb(bufnr, "n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
	kmb(bufnr, "n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end)
	kmb(bufnr, "n", "<leader>D", vim.lsp.buf.type_definition)
	kmb(bufnr, "n", "<leader>rn", vim.lsp.buf.rename)
	-- kmb(bufnr, "n", "<leader>ca", vim.lsp.buf.code_action)
	kmb(bufnr, "n", "<leader>ca", require("actions-preview").code_actions)
	kmb(bufnr, "n", "gr", vim.lsp.buf.references)
	kmb(bufnr, "n", "<leader>wd", vim.lsp.buf.workspace_diagnostics)
	kmb(bufnr, "n", "<leader>f", function()
		vim.lsp.buf.format({ async = false })
	end)
end

local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

for i = 1, #lsps do
	local lsp = lsps[i]
	vim.lsp.config(lsp, {
		on_attach = on_attach,
		capabilities = capabilities,
	})
	vim.lsp.enable(lsp)
end

local ts_settings = {
	updateImportsOnFileMove = { enabled = "always" },
	suggest = {
		completeFunctionCalls = true,
	},
}

vim.lsp.config("tsc", {
	settings = {
		typescript = ts_settings,
		javascript = ts_settings,
		["js/ts"] = {
			inlayHints = {
				variableTypes = { enabled = false },
			},
		},
	},
})
