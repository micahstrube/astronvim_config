return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          ["}"] = { ":bnext<CR>", desc = "Next tab" },
          ["{"] = { ":bprevious<CR>", desc = "Previous tab" },
          ["<C-n>"] = {
            function()
              if vim.wo.relativenumber then
                vim.wo.relativenumber = false
              else
                vim.wo.relativenumber = true
              end
              if vim.wo.number then
                vim.wo.number = false
              else
                vim.wo.number = true
              end
              if vim.wo.signcolumn == "yes" then
                vim.wo.signcolumn = "no"
              else
                vim.wo.signcolumn = "yes"
              end
              if Snacks.indent.enabled then
                Snacks.indent.disable()
              else
                Snacks.indent.enable()
              end
              require("astrocore.toggles").foldcolumn()
            end,
            desc="Toggle line numbers and signs"
          },
          ["<C-i>"] = {
            function()
              if Snacks.indent.enabled then
                Snacks.indent.disable()
              else
                Snacks.indent.enable()
              end
            end,
            desc="Toggle indent guides"
          },
          ["<Leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(function(bufnr)
                require("astrocore.buffer").close(bufnr)
              end)
            end,
            desc = "Pick to close",
          },
          -- tables with just a `desc` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { desc = "Buffers" },
          -- quick save
          -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function()
              vim.lsp.buf.hover()
            end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function()
              vim.lsp.buf.declaration()
            end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
