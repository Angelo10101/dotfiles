return{
    {
        "williamboman/mason.nvim",
        config = function()
          require('mason').setup()
        end
    },
    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require('mason-lspconfig').setup({
          ensure_installed = {'lua_ls'},
          ensure_installed = {'jdtls'},
--          ensure_installed = {'java_language_server'},    
        })
      end
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({})
        lspconfig.jdtls.setup({})
--lspconfig.jdtls.setup({
--  cmd = {
--    '/usr/lib/jvm/java-17-openjdk-amd64/bin/java',
--    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--    '-Dosgi.bundles.defaultStartLevel=4',
--    '-Declipse.product=org.eclipse.jdt.ls.core.product',
--  '-Dlog.protocol=true',
--    '-Dlog.level=ALL',
--    '-Xms2g',
--    '-Xmx4g',
--    '-jar', vim.fn.expand('~/.local/share/java-lsp/plugins/org.eclipse.equinox.launcher_1.6.1000.v20250131-0606.jar'),
--    '-configuration', vim.fn.expand('~/.local/share/java-lsp/config_linux'),
--    '-data', vim.fn.expand('~/.cache/jdtls/workspace')
--  },
--  settings = {
--          java = {
--        configuration = {
--        runtimes = {
--      {
--        name = "JavaSE-17",
--        path = "/usr/lib/jvm/java-17-openjdk-amd64/bin/java"
--        }
--        }
--        },
--        project = {
--        referencedlLibraries = {
--        "~/.local/share/stellies-java-libs/"
--        }
--        }
--          }
--         }
--})

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      end
    },
    {
      'mfussenegger/nvim-jdtls',
      ft = 'java',
      config = function() end
    },
    {
       "L3MON4D3/LuaSnip",
       dependencies = { "rafamadriz/friendly-snippets" },
       config = function()
         require("luasnip.loaders.from_vscode").lazy_load()
        local ls = require("luasnip")

        vim.keymap.set({"i", "s"}, "<Tab>", function()
          if ls.expand_or_jumpable() then
            ls.expand_or_jump()
          else
             vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", false)
          end
        end, { silent = true })
      end
    },
    {
       "rafamadriz/friendly-snippets"
    }
}
