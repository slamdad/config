return {
  "saghen/blink.cmp",
  version = "1.*",   -- stay on v1: v2 is still changing
  event = "InsertEnter",
  opts = {
    -- Enter accepts, Up/Down select, Ctrl-Space opens, Ctrl-e closes
    keymap = { preset = "enter" },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 300 },
    },
  },
}
