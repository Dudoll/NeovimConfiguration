local default_config = {
  inlay_hints = {
    parameter_hints = {
      show = true,
    },
    type_hints = {
      show = true,
    },
    only_current_line = false,
    label_formatter = function(labels, kind, opts, client_name)
      if kind == 2 and not opts.parameter_hints.show then
        return ""
      elseif not opts.type_hints.show then
        return ""
      end

      return table.concat(labels or {}, ", ")
    end,
    virt_text_formatter = function(label, hint, opts, client_name)
      if client_name == "sumneko_lua" then
        if hint.kind == 2 then
          hint.paddingLeft = false
        else
          hint.paddingRight = false
        end
      end

      local virt_text = {}
      virt_text[#virt_text + 1] = hint.paddingLeft and { " ", "Normal" } or nil
      virt_text[#virt_text + 1] = { label, opts.highlight }
      virt_text[#virt_text + 1] = hint.paddingRight and { " ", "Normal" } or nil

      return virt_text
    end,

    -- highlight group
    highlight = "LspInlayHint",
  },
  enabled_at_startup = true,
  debug_mode = false,
}
require("lsp-inlayhints").setup({default_config})
