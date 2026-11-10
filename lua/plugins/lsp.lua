-- Needs Neovim 0.11+ (uses the built-in vim.lsp.config / vim.lsp.enable)
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    -- Show errors/warnings inline, worst first
    vim.diagnostic.config({ virtual_text = true, severity_sort = true })

    -- Keys that only exist in buffers with a language server attached.
    -- Built-in defaults also work: K hover, grr references, gri implementation,
    -- grn rename, gra code action, gO symbols, Ctrl-S signature help (insert).
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local o = { buffer = event.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, o)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, o)
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, o)
        vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, o)
        vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, o)
      end,
    })

    -- Tell every server that the completion popup supports extra features
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    -- lua_ls: stop it warning that `vim` is an unknown global
    vim.lsp.config("lua_ls", {
      settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    })

    -- Mason downloads servers; mason-lspconfig enables whatever is installed
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "pyright", "bashls" },
    })

    -- clangd (C/C++): install it with your system package manager instead of
    -- Mason (no Mason build for Linux ARM64). Enabled only if it's on PATH.
    if vim.fn.executable("clangd") == 1 then
      vim.lsp.enable("clangd")
    end
  end,
}
