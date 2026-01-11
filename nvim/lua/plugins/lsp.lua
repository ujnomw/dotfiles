return {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason_lsp = require("mason-lspconfig")
        local mason = require("mason")

        -- 1️⃣ Setup Mason
        mason.setup()
        mason_lsp.setup({
            ensure_installed = { "lua_ls" },
            automatic_installation = true,
        })

        -- 2️⃣ LSP on_attach function
        local on_attach = function(client, bufnr)
            local bufmap = function(mode, lhs, rhs, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, lhs, rhs, opts)
            end

            -- Basic LSP keymaps
            bufmap("n", "gd", vim.lsp.buf.definition)
            bufmap("n", "gr", vim.lsp.buf.references)
            bufmap("n", "K", vim.lsp.buf.hover)

            -- Format buffer with StyLua
            if client.supports_method("textDocument/formatting") then
                bufmap("n", "<leader>f", function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end)
            end
        end

        -- 3️⃣ Setup Lua LSP
        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim" } },
                    workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
                    telemetry = { enable = false },
                    format = { enable = true }, -- StyLua
                },
            },
        })

        -- 4️⃣ Optional: format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.lua",
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
}
