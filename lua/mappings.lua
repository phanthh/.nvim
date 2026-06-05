local km = require("utils").keymap
-- local kmx = require("utils").keymap_expr

-------------- NATIVES
-- motions
km("n", "j", "gj")
km("n", "k", "gk")
km("n", "<leader>a", "ggVG")
km("v", "<c-p>", ":m-2<CR>gv=gv")
km("v", "<c-n>", ":m'>+<CR>gv=gv")
km("v", "p", '"_dP')
km("n", "\\\\", "<cmd>wqa<cr>")
km("i", "<c-c>", "<esc>")
km("i", "<c-f>", "<esc>")
km("i", "jj", "<esc>")
km("n", "<leader>q", "<cmd>q!<cr>")
km("n", "s", "<Plug>(leap-forward)")
km("n", "S", "<Plug>(leap-backward)")

local format_blacklist = {
	bashls = true,
	pyright = true,
	lua_ls = true,
	vtsls = true,
	rust_analyzer = true,
}

local function format_save_func()
	vim.lsp.buf.format({
		filter = function(client)
			return not format_blacklist[client.name]
		end,
	})
end

-- saving
km("n", "<c-s>", format_save_func)
km("i", "<c-s>", format_save_func)

-- buffers
km("n", "<c-w>i", "<cmd>bnext<cr>")
km("n", "<c-w>u", "<cmd>bprev<cr>")
km("n", "<c-w>0", "<cmd>bfirst<cr")
km("n", "<c-w>$", "<cmd>blast<cr>")

-------------- PLUGINS

-- telescope
km("n", "<leader>fw", "<cmd>wa<bar>Telescope egrepify<cr>")
km("n", "<leader>fe", "<cmd>wa<bar>Telescope env<cr>")
km("n", "<leader>ff", "<cmd>wa<bar>Telescope find_files<cr>")
km("n", "<leader>fg", "<cmd>wa<bar>Telescope git_files<cr>")
km("n", "<leader>fb", "<cmd>wa<bar>Telescope buffers<cr>")
km("n", "<leader>fh", "<cmd>wa<bar>Telescope help_tags<cr>")
km("n", "<leader>fu", "<cmd>wa<bar>Telescope undo<cr>")

-- nvim-tree
km("n", "<c-n>", "<cmd>NvimTreeToggle<cr>")
km("n", "<leader>r", "<cmd>NvimTreeRefresh<cr>")

-- oil
km("n", "-", "<cmd>Oil<cr>")

-- vim dadbod
km("n", "<c-b>", "<cmd>DBUIToggle<cr>")

-- grapple
km("n", "<leader>a", "<cmd>Grapple toggle<cr>")
km("n", "<leader>h", "<cmd>Grapple toggle_tags<cr>")
km("n", "<leader>n", "<cmd>Grapple cycle_tags next<cr>")
km("n", "<leader>p", "<cmd>Grapple cycle_tags prev<cr>")

-- git
km("n", "<leader>g", "<cmd>vertical Git<cr>")
km("n", "<leader>gb", "<cmd>Telescope git_branches<cr>")
km("n", "<leader>gc", "<cmd>Telescope git_commits<cr>")
km("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>")
km("n", "<leader>gX", "<cmd>Gitsigns reset_buffer<cr>")
km("n", "<leader>gf", "<cmd>DiffviewOpen<cr>")
km("n", "<leader>gF", "<cmd>DiffviewClose<cr>")
km("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>")
km({ "n", "v" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>")
km({ "n", "v" }, "<leader>gv", "<cmd>Gitsigns preview_hunk<cr>")
km({ "n", "v" }, "<leader>gx", "<cmd>Gitsigns reset_hunk<cr>")
km({ "n", "v" }, "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>")
km({ "n", "v" }, "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>")

-- minimap
km("n", "<leader>m", "<cmd>lua require('codewindow').toggle_minimap()<cr>")

-- repl
km("n", "<leader>rs", "<cmd>IronRepl<cr>")
km("n", "<leader>rr", "<cmd>IronRestart<cr>")
km("n", "<leader>rf", "<cmd>IronFocus<cr>")
km("n", "<leader>rh", "<cmd>IronHide<cr>")

-- telekasten
-- km("n", "<leader>z", "<cmd>Telekasten panel<cr>")
-- km("n", "<leader>zf", "<cmd>Telekasten find_notes<cr>")
-- km("n", "<leader>zg", "<cmd>Telekasten search_notes<cr>")
-- km("n", "<leader>zp", "<cmd>Telekasten paste_img_and_link<cr>")
-- km("i", "<c-l>", "<esc><cmd>Telekasten insert_link<cr>")
-- km("n", "<Tab>", "<esc><cmd>Telekasten follow_link<cr>")

-- trouble (v3 syntax)
km("n", "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
km("n", "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>")
km("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>")
km("n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>")

-- dap
km("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>")
km("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>")
km("n", "<leader>do", "<cmd>lua require('dap').step_over()<cr>")
km("n", "<leader>di", "<cmd>lua require('dap').step_into()<cr>")

-- misc
km("n", "<leader>d", "<cmd>Neogen<cr>")
km("n", "<leader>dm", "<cmd>Neogen file<cr>")
km("n", "<leader>df", "<cmd>Neogen func<cr>")
km("n", "<leader>dc", "<cmd>Neogen class<cr>")
km("n", "<leader>dt", "<cmd>Neogen type<cr>")
km("n", "<leader>t", "<cmd>lua require('toggle-checkbox').toggle()<cr>")
km("n", "<leader>b", "<cmd>GitBlameToggle<cr>")
km("", "<leader>l", "<cmd>lua require('lsp_lines').toggle()<cr>")
km("n", "<leader>s", "<cmd>lua require('spectre').toggle()<cr>")
