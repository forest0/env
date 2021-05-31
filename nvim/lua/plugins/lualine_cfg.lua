-- Color table for highlights
local colors = {
  base03  =  '#002b36',
  -- base02  =  '#073642',
  base02  =  '#232b37',
  base01  =  '#586e75',
  base00  =  '#657b83',
  base0   =  '#839496',
  base1   =  '#93a1a1',
  base2   =  '#eee8d5',
  base3   =  '#fdf6e3',
  yellow  =  '#b58900',
  orange  =  '#cb4b16',
  red     =  '#dc322f',
  magenta =  '#d33682',
  violet  =  '#6c71c4',
  blue    =  '#268bd2',
  cyan    =  '#2aa198',
  green   =  '#859900',
}

local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end
}

require('lualine').setup {
  options = {
    theme = {
      normal = {
        a = {fg = colors.base03, bg = colors.blue, gui = 'bold'},
        b = {fg = colors.base1, bg = colors.base02},
        c = {fg = colors.base1, bg = colors.base02}
      },
      insert = {a = {fg = colors.base03, bg = colors.green, gui = 'bold'}},
      visual = {a = {fg = colors.base03, bg = colors.magenta, gui = 'bold'}},
      replace = {a = {fg = colors.base03, bg = colors.red, gui = 'bold'}},
      inactive = {
          a = {fg = colors.base0, bg = colors.base02, gui = 'bold'},
          b = {fg = colors.base03, bg = colors.base00},
          c = {fg = colors.base01, bg = colors.base02}
      }
    },
    section_separators = '',
    component_separators = '|'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {
        'filename',
        condition = conditions.buffer_not_empty,
      },
      {
        'branch',
        condition = conditions.check_git_workspace,
        color = {fg = colors.green}
      }
    },
    lualine_c = {
      {
        'diagnostics',
        sources = {'coc'},
        symbols = {error = '✗ ', warn = '⚠ ', info = ' '},
        color_error = colors.red,
        color_warn = colors.yellow,
        color_info = colors.blue,
        color_hint = colors.green
      },
      'g:coc_status'
    },
    lualine_x = {
      {
        'diff',
        condition = conditions.check_git_workspace,
        colored = true,
        symbols = {added = ' ', modified = '✎ ', removed = ' '},
        color_added = colors.green,
        color_modified = colors.orange,
        color_removed = colors.red
      },
      {
        'encoding',
      },
      {
        'o:fileformat',
        icons_enabled = 0
      },
      {
        'progress',
      },
      {
        'location'
      }
    },
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {'nerdtree', 'quickfix'}
}
