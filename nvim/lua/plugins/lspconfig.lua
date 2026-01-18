-- =============================================================================
-- LSP Configuration
-- =============================================================================
-- LSP servers (mason-lspconfig): pyright, ts_ls, lua_ls, clangd, eslint, jsonls, biome
-- Formatters (none-ls):          black
--
-- JS/TS linting & formatting:
--   ts_ls   -> TypeScript LSP (formatting disabled, use biome/eslint)
--   eslint  -> ESLint LSP (activates when eslint config present)
--   biome   -> Biome LSP (activates when biome.json present)
--   jsonls  -> JSON LSP with schemastore (always active for .json)
--
-- Python:
--   pyright -> type checking (strict mode)
--   black   -> formatting via none-ls
-- =============================================================================

return {
  -- ---------------------------------------------------------------------------
  -- nvim-lspconfig: Core LSP client configuration
  -- ---------------------------------------------------------------------------
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim', 'hrsh7th/cmp-nvim-lsp', 'b0o/schemastore.nvim' },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Format on save for any LSP with formatting support
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function() vim.lsp.buf.format() end, {})
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ timeout_ms = 3000 })
              end,
            })
          end
        end,
      })

      local on_attach = function(_, _) end

      -- Mason-managed LSP servers
      require('mason-lspconfig').setup {
        ensure_installed = { "pyright", "ts_ls", "lua_ls", "clangd", "eslint", "jsonls", "biome" },
        handlers = {
          -- Default handler for most servers
          function(server_name)
            local settings = {}

            -- Python: strict type checking
            if server_name == "pyright" then
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "strict",
                    reportUnusedVariable = true,
                    reportUnusedFunction = true,
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    include = { "**/*.py" }
                  }
                }
              }
            end

            -- Lua: Neovim-aware settings
            if server_name == "lua_ls" then
              settings = {
                Lua = {
                  runtime = { version = "LuaJIT" },
                  diagnostics = { globals = { "vim" } },
                  workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                  telemetry = { enable = false },
                },
              }
            end

            -- TypeScript: disable formatting (use biome/eslint instead)
            if server_name == "ts_ls" then
              lspconfig.ts_ls.setup {
                on_attach = function(client, bufnr)
                  client.server_capabilities.documentFormattingProvider = false
                  client.server_capabilities.documentRangeFormattingProvider = false
                end,
                capabilities = capabilities,
                flags = { debounce_text_changes = 150 },
              }
              return
            end

            -- JSON: schemastore integration for validation/completion
            if server_name == "jsonls" then
              lspconfig.jsonls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                flags = { debounce_text_changes = 150 },
                settings = {
                  json = {
                    schemas = require('schemastore').json.schemas(),
                    validate = { enable = true },
                  },
                },
              }
              return
            end

            -- C/C++: clangd with clang-tidy integration
            if server_name == "clangd" then
              lspconfig.clangd.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                flags = { debounce_text_changes = 150 },
                cmd = {
                  "clangd",
                  "--background-index",
                  "--clang-tidy",
                  "--compile-commands-dir=.",
                  "--query-driver=/usr/bin/g++,/usr/bin/clang++,*-gcc,*-g++",
                },
                init_options = {
                  fallbackFlags = { "-std=c++20", "-I/usr/include", "-I/usr/local/include" },
                },
              }
              return
            end

            -- All other servers: default setup
            lspconfig[server_name].setup {
              on_attach = on_attach,
              capabilities = capabilities,
              flags = { debounce_text_changes = 150 },
              settings = settings,
            }
          end,
        },
      }
    end,
  },

  -- ---------------------------------------------------------------------------
  -- mason.nvim: LSP/linter/formatter installer
  -- ---------------------------------------------------------------------------
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },

  -- ---------------------------------------------------------------------------
  -- none-ls: Formatting for tools without LSP support (currently just black)
  -- ---------------------------------------------------------------------------
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Python: black formatter
          null_ls.builtins.formatting.black.with({
            extra_args = { "--fast" },
          }),
        },
        on_attach = function(client, bufnr)
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = bufnr })
          end
        end,
      })
    end,
  },

  -- ---------------------------------------------------------------------------
  -- mason-null-ls: Auto-install none-ls sources via Mason
  -- ---------------------------------------------------------------------------
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = { "nvimtools/none-ls.nvim" },
    opts = {
      ensure_installed = { "black" },
      automatic_installation = true,
    },
  },
}
