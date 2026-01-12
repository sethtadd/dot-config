return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim', 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local lspconfig = require('lspconfig')

      -- Set up nvim-cmp capabilities with LSP
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local on_attach = function(_, bufnr)
        -- Format on save
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function() vim.lsp.buf.format() end, {})
        vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
      end

      -- Setup LSP servers with mason integration
      require('mason-lspconfig').setup {
        ensure_installed = { "pyright", "ts_ls", "lua_ls", "clangd", "eslint" },
        handlers = {
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
          if server_name == "clangd" then
            lspconfig.clangd.setup {
              on_attach = on_attach,
              capabilities = capabilities,
              flags = { debounce_text_changes = 150 },
              cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--compile-commands-dir=.", -- adjust if your compile_commands.json is elsewhere
                "--query-driver=/usr/bin/g++,/usr/bin/clang++,*-gcc,*-g++",
                -- Uncomment while debugging:
                -- "--log=verbose", "--pretty"
              },
              -- Optional fallback for files missing from the DB:
              init_options = {
                fallbackFlags = {
                  "-std=c++20",
                  "-I/usr/include",
                  "-I/usr/local/include",
                },
              },
            }
            return
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
        },
      }
    end,
  },

  {
    'williamboman/mason.nvim',
    config = function()
      -- Initialize Mason
      require('mason').setup()
    end,
  },

  {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.formatting.prettierd,

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

{
  "jay-babu/mason-null-ls.nvim",
  dependencies = { "nvimtools/none-ls.nvim" },
  opts = {
    ensure_installed = { "black", "eslint_d", "prettierd" },
    automatic_installation = true,
  },
},
}
