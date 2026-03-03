local nls = require("null-ls")

require("mason-null-ls").setup({
	ensure_installed = {
		"stylua",
		"prettierd",
		"black",
		"shfmt",
		"clang_format",
		"sqlfluff",
	},
})

require("null-ls").setup({
	sources = {
		nls.builtins.formatting.stylua,
		nls.builtins.formatting.prettierd,
		nls.builtins.formatting.black,
		nls.builtins.formatting.shfmt,
		nls.builtins.formatting.clang_format,
		nls.builtins.formatting.pg_format,
		nls.builtins.diagnostics.sqlfluff.with({
			extra_args = { "--dialect", "postgres" }, -- change to your dialect
		}),
		-- require("typescript.extensions.null-ls.code-actions"),
	},
})
