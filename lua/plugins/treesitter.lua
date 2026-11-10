-- Needs: Neovim 0.12+, a C compiler, and the tree-sitter CLI (0.26.1+)
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local langs = {
      "c", "cpp", "python", "bash", "lua", "vim", "vimdoc", "query",
      "html", "css", "javascript", "json", "markdown", "markdown_inline",
    }

    if vim.fn.executable("tree-sitter") == 1 then
      require("nvim-treesitter").install(langs)  -- no-op for ones already installed
    else
      vim.notify("tree-sitter CLI not found: parsers won't be installed", vim.log.levels.WARN)
    end

    -- Turn on highlighting (and tree-sitter indenting) whenever a parser exists
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        if pcall(vim.treesitter.start, args.buf) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
