vim.api.nvim_create_augroup("global", { clear = true })

-- autocompile rmd
vim.b.pdfcompile = 0
vim.api.nvim_create_autocmd("BufWritePre", {
	group = "global",
	pattern = { "*.rmd", "*.tex" },
	callback = function()
		if vim.b.pdfcompile == 1 then
			if vim.bo.filetype == "rmd" then
				vim.fn.jobstart(
					string.format(
						[[rm compile.log; Rscript -e "library(rmarkdown); rmarkdown::render('%s', 'pdf_document')" > compile.log 2>&1]],
						vim.fn.expand("%:p")
					)
				)
			elseif vim.bo.filetype == "tex" then
				local filename = vim.fn.expand("%:r")
				vim.fn.jobstart(
					string.format(
						"pdflatex %s.tex > compile.log 2>&1 && bibtex %s.aux && pdflatex %s.tex && pdflatex %s.tex",
						filename,
						filename,
						filename,
						filename
					)
				)
			end
		end
	end,
})

-- tsc
-- vim.cmd([[
--   augroup strdr4605
--     autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc
--   augroup END
-- ]])

-- term options
vim.api.nvim_create_autocmd("TermOpen", {
	group = "global",
	pattern = "*",
	command = "setlocal nonumber nospell",
})
