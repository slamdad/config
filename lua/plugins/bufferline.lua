return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>" },
    { "<leader>x", "<cmd>bdelete<cr>" },
  },
  opts = {},
}
