local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end
local nvim_lsp_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not nvim_lsp_ok then
    return
end

local rt_ok,rt = pcall(require, "rust-tools")
if not rt_ok then
    return
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities),
        on_attach = function()
            local opts = { noremap = true, silent = true }

            vim.keymap.set("n", "gD", function()
                vim.lsp.buf.declaration()
            end, opts)

            vim.keymap.set("n", "gd", function()
                vim.lsp.buf.definition()
            end, opts)

            vim.keymap.set("n", "K", function()
                vim.lsp.buf.hover()
            end, opts)

            vim.keymap.set("n", "gi", function()
                vim.lsp.buf.implementation()
            end, opts)

            vim.keymap.set("n", "<C-k>", function()
                vim.lsp.buf.signature_help()
            end, opts)

            vim.keymap.set("n", "gr", function()
                vim.lsp.buf.references()
            end, opts)

            vim.keymap.set('n', '<space>rn', function()
                vim.lsp.buf.rename()
            end, opts)

            vim.keymap.set('n', '<space>ca', function()
                vim.lsp.buf.code_action()
            end, opts)

            vim.keymap.set('n', '[d', function()
                vim.diagnostic.goto_prev({ border = "rounded" })
            end, opts)

            vim.keymap.set(
                "n",
                "gl",
                function()
                    vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })
                end, opts)
            vim.keymap.set("n", "<C-s>", function()
                vim.diagnostic.goto_next({ border = "rounded" })
            end, opts)

            vim.keymap.set("n", "<leader>q", function()
                vim.diagnostic.setloclist()
            end, opts)
        end
    }, _config or {})
end

lsp_installer.setup({
    ensure_installed = {
        "jsonls",
        "rust_analyzer",
        "tsserver",
        "astro",
        "tailwindcss",
        "bashls",
        "svelte",
    },
})

-- Format on save for rust
vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*.rs", callback = function ()
     vim.lsp.buf.format({
        timeout_ms = 3000,
        buffer = buf,
    })
end})

rt.setup({
    on_attach = function()
        -- Hover actions
        vim.keymap.set("n", "<space>rha", rt.hover_actions.hover_actions, { buffer = bufnr })
        -- Code action groups
        vim.keymap.set("n", "<space>rca", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    server = config({
      flags = {
        debounce_text_changes = 150,
      },
      -- cmd = { "rustup", "run", "nightly", "rust-analyzer" },
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
          },
          assist = {
            importGranularity = "module",
            importPrefix = "by_self",
          },
          cargo = {
            loadOutDirsFromCheck = true,
          },
          procMacro = {
            enable = true,
          },
        },
      },
    })
})

lspconfig.tsserver.setup(config(require"config.lsp.settings.tsserver"))
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- require("nlua.lsp.nvim").setup(lspconfig, config{})

-- lspconfig.jsonls.setup(config(require("config.lsp.settings.jsonls")))
lspconfig.jsonls.setup(config())

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, { pattern = "*.astro", command = "set filetype=astro"})
lspconfig.astro.setup(config{})
lspconfig.graphql.setup(config{})
lspconfig.bashls.setup(config{})
lspconfig.svelte.setup(config{})
lspconfig.bicep.setup(config{})
lspconfig.prismals.setup(config{})
lspconfig.tailwindcss.setup(config{})

require"config.lsp.jsonx".setup()

-- Setup LSP settings
require("config.lsp.handler").setup()
