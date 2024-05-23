local opts = {
  -- maps related defaults
  disable_maps = false, -- "true" disables default keymaps
  skip_input_prompt = true, -- "true" doesn't ask for input
  prefix = "<c-\\>", -- prefix to trigger maps

  -- cscope related defaults
  cscope = {
    -- location of cscope db file
    db_file = {
      "./cscope.out",
    }
    -- cscope executable
    exec = "gtags-cscope", -- "cscope" or "gtags-cscope"
    -- choose your fav picker
    picker = "telescope", -- "telescope", "fzf-lua" or "quickfix"
    -- size of quickfix window
    qf_window_size = 5, -- any positive integer
    -- position of quickfix window
    qf_window_pos = "bottom", -- "bottom", "right", "left" or "top"
    -- "true" does not open picker for single result, just JUMP
    skip_picker_for_single_result = false, -- "false" or "true"
    -- these args are directly passed to "cscope -f <db_file> <args>"
    db_build_cmd_args = { "-bqkv" },
    -- statusline indicator, default is cscope executable
    statusline_indicator = nil,
  }
}

require('cscope_maps').setup(opts)
