local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end
local nvim_lsp_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not nvim_lsp_ok then
    return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
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
        "sumneko_lua",
        "rust_analyzer",
        "tsserver",
    },
})

lspconfig.tsserver.setup(config(require"config.lsp.settings.tsserver"))
lspconfig.rust_analyzer.setup(config(require"config.lsp.settings.rust_analyzer"))
lspconfig.sumneko_lua.setup(config(require"config.lsp.settings.sumneko_lua"))

require("nlua.lsp.nvim").setup(lspconfig, config{})

lspconfig.jsonls.setup(config(require("config.lsp.settings.jsonls")))

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, { pattern = "*.astro", command = "set filetype=astro"})
lspconfig.astro.setup(config{})

lspconfig.graphql.setup(config{})
lspconfig.bashls.setup(config{})
lspconfig.svelte.setup(config{})
lspconfig.bicep.setup(config{})
lspconfig.prismals.setup(config{})
lspconfig.tailwindcss.setup(config{})

-- Setup LSP settings
require("config.lsp.handler").setup()
