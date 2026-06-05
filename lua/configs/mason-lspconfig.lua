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
	"vtsls",
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
	if client:supports_method("textDocument/codeLens") then
		vim.lsp.codelens.enable(true, { bufnr = bufnr })
	end
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
	kmb(bufnr, "n", "grx", vim.lsp.codelens.run)
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

local vtsls_on_attach = function(client, bufnr)
	on_attach(client, bufnr)
	-- Organize imports
	kmb(bufnr, "n", "gs", function()
		vim.lsp.buf.code_action({
			apply = true,
			filter = function(action)
				return action.kind == "source.organizeImports"
			end,
		})
	end)
	-- Add missing imports
	kmb(bufnr, "n", "gi", function()
		vim.lsp.buf.code_action({
			apply = true,
			filter = function(action)
				return action.kind == "source.addMissingImports.ts"
			end,
		})
	end)
	-- Remove unused imports
	kmb(bufnr, "n", "<leader>cu", function()
		vim.lsp.buf.code_action({
			apply = true,
			filter = function(action)
				return action.kind == "source.removeUnused.ts"
			end,
		})
	end)
	-- Fix all auto-fixable diagnostics
	kmb(bufnr, "n", "<leader>cD", function()
		vim.lsp.buf.code_action({
			apply = true,
			filter = function(action)
				return action.kind == "source.fixAll.ts"
			end,
		})
	end)
	-- Go to source definition (skips .d.ts)
	kmb(bufnr, "n", "gD", function()
		local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
		client:exec_cmd({
			command = "typescript.goToSourceDefinition",
			arguments = { params.textDocument.uri, params.position },
		})
	end)
	-- Find all file references (what imports this file)
	kmb(bufnr, "n", "gR", function()
		client:exec_cmd({
			command = "typescript.findAllFileReferences",
			arguments = { vim.uri_from_bufnr(bufnr) },
		})
	end)
	-- Select TypeScript version
	kmb(bufnr, "n", "<leader>cV", function()
		client:exec_cmd({ command = "typescript.selectTypeScriptVersion" })
	end)
end

local ts_settings = {
	updateImportsOnFileMove = { enabled = "always" },
	suggest = {
		completeFunctionCalls = true,
	},
	inlayHints = {
		enumMemberValues = { enabled = true },
		functionLikeReturnTypes = { enabled = true },
		parameterNames = { enabled = "literals" },
		parameterTypes = { enabled = true },
		propertyDeclarationTypes = { enabled = true },
		variableTypes = { enabled = false },
	},
}

vim.lsp.config("vtsls", {
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	on_attach = vtsls_on_attach,
	capabilities = capabilities,
	settings = {
		vtsls = {
			enableMoveToFileCodeAction = true,
			autoUseWorkspaceTsdk = true,
			experimental = {
				maxInlayHintLength = 30,
				completion = {
					enableServerSideFuzzyMatch = true,
				},
			},
		},
		typescript = vim.tbl_deep_extend("force", ts_settings, {
			tsserver = {
				maxTsServerMemory = 8196,
			},
		}),
		javascript = vim.tbl_deep_extend("force", ts_settings, {}),
	},
})
