local L = require("peter.util.plugins.languages")

-- See 'https://docs.ansible.com/'.
-- See 'https://docs.ansible.com/ansible/latest/index.html'.

-- IMPORTANT: For `yaml.ansible` filetype to be set correctly and for
-- 'ansible-lint' to work properly, you MUST respect conventional Ansible
-- directory structure.

---@type peter.lang.config
return {
  lsp = { "ansiblels" },

  plugins = {
    L.treesitter({ "yaml" }),
    L.mason({ "ansiblels", "ansible-lint" }),

    -- This plugin automatically sets `filetype` to `yaml.ansible`.
    { "mfussenegger/nvim-ansible", ft = {} },
  },

  ftplugin = {
    ft = "yaml.ansible",
    callback = function(args)
      vim.keymap.set("n", "<localleader>r", function()
        require("ansible").run()
      end, { desc = "Run Ansible", buffer = args.buf })
    end,
  },
}
