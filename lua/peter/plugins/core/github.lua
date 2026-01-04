---@module "octo"

return {
  {
    "pwntester/octo.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
    },
    cmd = "Octo",
    ---@type OctoConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      picker = "snacks",
      enable_builtin = true,
    },
    keys = {
      {
        "<leader>oi",
        "<CMD>Octo issue list<CR>",
        desc = "List GitHub Issues",
      },
      {
        "<leader>op",
        "<CMD>Octo pr list<CR>",
        desc = "List GitHub PullRequests",
      },
      {
        "<leader>od",
        "<CMD>Octo discussion list<CR>",
        desc = "List GitHub Discussions",
      },
      {
        "<leader>on",
        "<CMD>Octo notification list<CR>",
        desc = "List GitHub Notifications",
      },
      {
        "<leader>os",
        function()
          require("octo.utils").create_base_search_command({
            include_current_repo = true,
          })
        end,
        desc = "Search GitHub",
      },
    },
    config = function(_, opts)
      require("peter.util.icons").try_mock_nvim_web_devicons()
      require("octo").setup(opts)
    end,
  },
}
