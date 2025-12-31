require("lazy").setup({
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  "j-hui/fidget.nvim",
  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "normal" },
      completion = { documentation = { auto_show = false } },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      fuzzy = { implementation = "lua" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = { "bash", "gitcommit", "lua" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
  },
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup()
    end,
  },
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>Rs", desc = "Send request" },
      { "<leader>Ra", desc = "Send all requests" },
      { "<leader>Rb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
      global_keymaps = false,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps_prefix = "",
    },
  },
  {
    "nvim-mini/mini.nvim",
    version = "*",
    config = function()
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.surround").setup({
        mappings = {
          find = "gs",
          add = "ys",
          delete = "ds",
          replace = "cs",
          find_left = "",
          highlight = "",
        },
      })

      local statusline = require("mini.statusline")
      statusline.setup()
      statusline.section_location = function()
        return "%2l:%-2v"
      end

      require("mini.pick").setup()
      vim.keymap.set("n", "<leader>ff", ":Pick files<CR>")
      vim.keymap.set("n", "<leader>fh", ":Pick help<CR>")
      vim.keymap.set("n", "<leader>fg", ":Pick grep<CR>")
      vim.keymap.set("n", "<leader><leader>", ":Pick buffers<CR>")

      local jump2d = require("mini.jump2d")
      jump2d.setup({
        spotter = jump2d.builtin_opts.word_start.spotter,
        labels = "asdfghjkl;qwertyuiopbnmvcxz",
        mappings = { start_jumping = "s" },
      })

      require("mini.indentscope").setup()
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        disable_italics = true,
        disable_background = true,
        transparent_mode = true,
        italic = { strings = false, emphasis = false, comments = false },
      })
      vim.cmd.colorscheme("gruvbox")
      vim.o.background = "dark"
    end,
  },
})
