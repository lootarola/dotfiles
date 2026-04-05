-- vim-sleuth: no config needed
require('nvim-autopairs').setup {}

-- mini: A collection of small, independent Lua modules that provide various functionalities.
require('mini.ai').setup { n_lines = 500 }
require('mini.surround').setup()

local diff = require 'mini.diff'
diff.setup {
  source = diff.gen_source.none(),
}
