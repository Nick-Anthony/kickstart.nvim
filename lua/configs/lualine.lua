local ok, lualine = pcall(require, 'lualine')
if not ok then
  return
end

local config = {
  options = {
    theme = 'palenight',
    icons_enabled = true,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = { statusline = {}, winbar = {} },
    ignore_focus = {},
    globalstatus = true,
    always_divide_middle = true,
    always_show_tabline = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16,
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { { 'branch', icon = { '', align = 'left' }, color = { gui = 'bold' } } },
    lualine_c = {
      {
        'diff',
        symbols = { added = ' ', modified = ' ', removed = ' ' },
      },
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = '', warn = '', info = '', hint = '' },
      },
    },
    lualine_x = { 'location', 'encoding' },
    lualine_y = { 'progress' },
    lualine_z = { 'filetype' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = { 'buffers' },
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'tabs' },
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}

lualine.setup(config)
