require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },
		["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "cancel", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "snippet_forward", "show", "fallback" },
		["<C-k>"] = { "snippet_backward", "select_prev", "fallback" },
	},

	appearance = {
		nerd_font_variant = "mono",
	},

	snippets = { preset = "luasnip" },

	cmdline = {
		sources = function()
			local type = vim.fn.getcmdtype()
			if type == "/" or type == "?" then
				return { "buffer" }
			end
			if type == ":" then
				return { "cmdline", "path" }
			end
			return {}
		end,
	},

	sources = {
		default = {
			"lsp",
			"path",
			"snippets",
			"buffer",
			-- "dictionary"
		},
		per_filetype = {
			sql = { "dadbod", "buffer" },
			mysql = { "dadbod", "buffer" },
			plsql = { "dadbod", "buffer" },
		},
		providers = {
			-- dictionary = {
			-- 	module = "blink-cmp-dictionary",
			-- 	name = "Dict",
			-- 	min_keyword_length = 2,
			-- 	max_items = 5,
			-- 	opts = {
			-- 		dictionary_files = { "/usr/share/dict/american-english" },
			-- 	},
			-- },
			dadbod = {
				name = "Dadbod",
				module = "vim_dadbod_completion.blink",
			},
		},
	},

	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = { border = "rounded" },
		},
		menu = {
			border = "rounded",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			draw = {
				columns = {
					{ "kind_icon", gap = 1 },
					{ "label", "label_description", gap = 1 },
					{ "kind" },
				},
				components = {
					label = {
						text = function(ctx)
							return ctx.label:sub(1, 20)
						end,
					},
				},
			},
		},
		ghost_text = { enabled = true },
	},

	signature = { enabled = true },
})
