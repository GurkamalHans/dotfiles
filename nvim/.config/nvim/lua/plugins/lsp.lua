return {
	{
		"mason-org/mason.nvim",
		opts = {},
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{
				"neovim/nvim-lspconfig",
				config = function()
					vim.lsp.enable("lua_ls")
					vim.lsp.enable("gh_actions_ls")
          vim.lsp.enable("yamlls")
					vim.diagnostic.config({
						virtual_text = true,
						signs = true,
						underline = true,
						update_in_insert = true,
						severity_sort = true,
					})
				end,
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
  { -- optional blink completion source for require statements and module annotations
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
  },
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.kubelinter,
          null_ls.builtins.diagnostics.actionlint,
          null_ls.builtins.formatting.prettier,
				},
			})
			vim.keymap.set("n", "<leader>gf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", {})
		end,
	},
}
