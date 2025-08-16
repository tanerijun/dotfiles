return {
  {
    "gbprod/nord.nvim",
    config = function()
      require("nord").setup({
        transparent = true,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      if (vim.g.colors_name or ""):find("nord") then
        opts.highlights = require("nord.plugins.bufferline").akinsho()
      end
    end,
  },
}
