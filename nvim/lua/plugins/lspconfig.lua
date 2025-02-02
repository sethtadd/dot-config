return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim', 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = { "pyright", "ts_ls", "lua_ls", "clangd" },
      }

      local lspconfig = require('lspconfig')

      -- Set up nvim-cmp capabilities with LSP
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local on_attach = function(_, bufnr)
        -- Format on save
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function() vim.lsp.buf.format() end, {})
        vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
      end

      -- Setup LSP servers with mason integration
      require('mason-lspconfig').setup_handlers {
        function(server_name)
          -- Settings for individual servers
          local settings = {}
          -- Pyright specific settings
          if server_name == "pyright" then
            settings = {
              python = {
                analysis = {
                  typeCheckingMode = "strict", -- Set strict type checking
                  reportUnusedVariable = true, -- Warn on unused variables
                  reportUnusedFunction = true, -- Warn on unused functions
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                  include = { "**/*.py" } -- Set include for all .py files
                }
              }
            }
          end
          -- Lua specific settings
          if server_name == "lua_ls" then
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                },
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                  enable = false,
                },
              },
            }
          end
          -- Clangd specific settings
          -- FIXME: Fix "iostream not found" etc. The following did not seem to work.
          if server_name == "clangd" then
            settings = {
              clangd = {
                compilationDatabasePath = "./", -- Optional: set this if you do sometimes have compile_commands.json
                fallbackFlags = {
                  "-std=c++17",                 -- Set the C++ standard you typically use
                  "-I/usr/include",             -- Add standard system include paths
                  "-I/usr/local/include",       -- Add common local include paths (optional)
                }
              }
            }
          end

          -- Setup LSP servers
          lspconfig[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
              debounce_text_changes = 150,
            },
            settings = settings,
          }
        end,
      }
    end,
  },

  {
    'williamboman/mason.nvim',
    config = function()
      -- Initialize Mason
      require('mason').setup()

      local mason_registry = require('mason-registry')
      -- Ensure clang-format is installed using Mason
      if not mason_registry.is_installed("clang-format") then
        mason_registry.get_package("clang-format"):install()
      end
      -- Ensure eslint_d is installed using Mason
      if not mason_registry.is_installed("eslint_d") then
        mason_registry.get_package("eslint_d"):install()
      end
      -- Ensure black is installed using Mason
      if not mason_registry.is_installed("black") then
        mason_registry.get_package("black"):install()
      end
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",

    config = function()
      local null_ls = require("null-ls")

      -- Register Black as a formatter for Python
      null_ls.setup({
        sources = {
          -- JavaScript/TypeScript linter
          null_ls.builtins.diagnostics.eslint_d,  -- Use eslint_d for fast linting
          null_ls.builtins.code_actions.eslint_d, -- Apply code actions (like auto-fixing)
          null_ls.builtins.formatting.prettierd,  -- Prettier for formatting (optional)
          -- Python formatter
          null_ls.builtins.formatting.black.with({
            extra_args = { "--fast" },
          }),
        },
        -- This allows for using vim.lsp.buf.format()
        on_attach = function(client, bufnr)
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = bufnr })
          end
        end,
      })
    end,
  },

  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = { "black", "eslint_d", "prettierd" }, -- Install Black automatically
      automatic_installation = true,                           -- Install any missing formatters/linters
    },
  },
}
