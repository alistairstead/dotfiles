local status_ok, dressing = pcall(require, 'dressing')
if not status_ok then
  return
end
-- TODO: Deprecate user ui options table with v2
local ui_opts = { nui_input = true, telescope_select = true }
dressing.setup({
  input = {
    enabled = ui_opts.nui_input,
    default_prompt = '➤ ',
    win_options = {
      winhighlight = 'Normal:Normal,NormalNC:Normal',
    },
  },
  select = {
    enabled = ui_opts.telescope_select,
    backend = { 'telescope', 'builtin' },
    builtin = {
      win_options = {
        winhighlight = 'Normal:Normal,NormalNC:Normal',
      },
    },
  },
})
