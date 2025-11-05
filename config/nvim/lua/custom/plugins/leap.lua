return {
  'ggandor/leap.nvim',
  config = function()
    local leap = require 'leap'
    leap.add_default_mappings() -- Set up default key mappings

    -- You can add other configurations here as needed
    -- leap.opts.case_sensitive = true -- Example: Enable case-sensitive jumping
  end,
}
