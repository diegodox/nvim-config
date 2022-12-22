---@alias LualineModule LualineModuleTable|fun(table):string|string

--[[```lua
lualine_a = {
    {
        'mode',
        icons_enabled = true, -- Enables the display of icons alongside the component.
        -- Defines the icon to be displayed in front of the component.
        -- Can be string|table
        -- As table it must contain the icon as first entry and can use
        -- color option to custom color the icon. Example:
        -- {'branch', icon = ''} / {'branch', icon = {'', color={fg='green'}}}

        -- icon position can also be set to the right side from table. Example:
        -- {'branch', icon = {'', align='right', color={fg='green'}}}
        icon = nil,

        separator = nil, -- Determines what separator to use for the component.
                         -- Note:
                         --  When a string is provided it's treated as component_separator.
                         --  When a table is provided it's treated as section_separator.
                         --  Passing an empty string disables the separator.
                         --
                         -- These options can be used to set colored separators
                         -- around a component.
                         --
                         -- The options need to be set as such:
                         --   separator = { left = '', right = ''}
                         --
                         -- Where left will be placed on left side of component,
                         -- and right will be placed on its right.
                         --

      cond = nil,        -- Condition function, the component is loaded when the function returns `true`.

      -- Defines a custom color for the component:
      --
      -- 'highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' } | function
      -- Note:
      --  '|' is synonymous with 'or', meaning a different acceptable format for that placeholder.
      -- color function has to return one of other color types ('highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' })
      -- color functions can be used to have different colors based on state as shown below.
      --
      -- Examples:
      --   color = { fg = '#ffaa88', bg = 'grey', gui='italic,bold' },
      --   color = { fg = 204 }   -- When fg/bg are omitted, they default to the your theme's fg/bg.
      --   color = 'WarningMsg'   -- Highlight groups can also be used.
      --   color = function(section)
      --      return { fg = vim.bo.modified and '#aa3355' or '#33aa88' }
      --   end,
      color = nil, -- The default is your theme's color for that section and mode.

      -- Specify what type a component is, if omitted, lualine will guess it for you.
      --
      -- Available types are:
      --   [format: type_name(example)], mod(branch/filename),
      --   stl(%f/%m), var(g:coc_status/bo:modifiable),
      --   lua_expr(lua expressions), vim_fun(viml function name)
      --
      -- Note:
      -- lua_expr is short for lua-expression and vim_fun is short for vim-function.
      type = nil,

      padding = 1, -- Adds padding to the left and right of components.
                   -- Padding can be specified to left or right independently, e.g.:
                   --   padding = { left = left_padding, right = right_padding }

      fmt = nil,   -- Format function, formats the component's output.
      on_click = nil, -- takes a function that is called when component is clicked with mouse.
                   -- the function receives several arguments
                   -- - number of clicks incase of multiple clicks
                   -- - mouse button used (l(left)/r(right)/m(middle)/...)
                   -- - modifiers pressed (s(shift)/c(ctrl)/a(alt)/m(meta)...)
    }
  }
}
-- ```]]
---@class LualineModuleTable
---@field color table|fun():table Color table
---@field fmt fun(str:string):string? Format string
---@field separator string|LualineSeparatorTable Determines what separator to use for the component.
---@field padding integer|LualinePaddingTable Adds padding to the left and right of components.
---@field cond fun():boolean Condition function, the component is loaded when the function returns `true`.
---@field on_click LualineOnClickFunction takes a function that is called when component is clicked with mouse.

---@class LualinePaddingTable
---@field left integer
---@field right integer

---@class LualineSeparatorTable
---@field left integer
---@field right integer

---@alias LualineOnClickFunction fun(num_click: integer, button: 'l'|'r'|'m', modifiers: 's'|'c'|'m')
