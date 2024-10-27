return {
  {
    "VonHeikemen/lsp-zero.nvim", branch = "v4.x",
    init = function()
      local lsp_zero = require("lsp-zero")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      -- lsp_attach is where you enable features that only work
      -- if there is a language server active in the file
      ---@diagnostic disable-next-line: unused-local
      local lsp_attach = function(client, bufnr)
	local opts = {buffer = bufnr}

	vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
	vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
	vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
	vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
	vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

        -- Format on save
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end
      end

      lsp_zero.extend_lspconfig({
	sign_text = true,
	lsp_attach = lsp_attach,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })
    end
  },
  {
    "hrsh7th/nvim-cmp",
    init = function()
      local cmp = require("cmp")

      local base_config = {
	view = {
	  entries = {name = 'custom', selection_order = 'near_cursor' }
	},
	formatting = {
	  fields = { "kind", "abbr", "menu" },
	  format = require("lspkind").cmp_format({
	    mode = "symbol",
	    menu = ({
	      buffer = "[Buffer]",
	      nvim_lsp = "[LSP]",
	      luasnip = "[LuaSnip]",
	      nvim_lua = "[Lua]",
	      latex_symbols = "[Latex]",
	    })
	  })
	},
	window = {
	  completion = cmp.config.window.bordered({
	    side_padding = 1,
	    winhighlight = "Normal:Normal,FloatBorder:CmpBorder,CursorLine:CursorLine,Search:Search",
	  }),
	  documentation = cmp.config.window.bordered({
	    maxwidth = 80,
	  }),
	},
	mapping = cmp.mapping.preset.insert({
	  ['<C-n>'] = cmp.mapping.select_next_item(),
	  ['<C-p>'] = cmp.mapping.select_prev_item(),
	  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
	  ['<C-f>'] = cmp.mapping.scroll_docs(4),
	  ['<C-Space>'] = cmp.mapping.complete(),
	  ['<CR>'] = cmp.mapping.confirm {
	    behavior = cmp.ConfirmBehavior.Replace,
	    select = true,
	  },
	  ['<Tab>'] = function(fallback)
	   if cmp.visible() then
	     cmp.select_next_item()
	   else
	     fallback()
	   end
	  end,
	  ['<S-Tab>'] = function(fallback)
	   if cmp.visible() then
	     cmp.select_prev_item()
	   else
	     fallback()
	   end
	  end,
	}),
      }
      local function mkconfig(custom)
	return vim.tbl_deep_extend("keep", custom, base_config)
      end

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, mkconfig({
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
	  { name = 'buffer' }
	}
      }))

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', mkconfig({
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
	  { name = 'path' }
	}, {
	  { name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
      }))

      cmp.setup(mkconfig({
	sources = {
	  { name = "nvim_lsp" },
	  { name = "path" },
	},
	snippet = {
	  expand = function(args)
	    vim.snippet.expand(args.body)
	  end,
	},
	enabled = function()
	  -- disable completion in comments
	  local context = require 'cmp.config.context'
	  -- keep command mode completion enabled when cursor is in a comment
	  if vim.api.nvim_get_mode().mode == 'c' then
	    return true
	  else
	    return not context.in_treesitter_capture("comment")
	      and not context.in_syntax_group("Comment")
	  end
	end,
      }))
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind-nvim"
    }
  },
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {'lua_ls', 'rust_analyzer'},
      handlers = {
	function(server_name)
	  require('lspconfig')[server_name].setup({})
	end,
      },
    }
  },
  {
    "j-hui/fidget.nvim",
    opts = {}
  }
}
