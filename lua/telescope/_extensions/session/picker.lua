local actions = require('telescope.actions')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local state = require('telescope.actions.state')

local lib = require('telescope-session')

return function (opts)
  opts = opts or {}

  local files = vim.fn.glob(lib.dir() .. '*.vim', true, true)

  pickers.new(opts, {
    prompt_title = 'Sessions',
    finder = finders.new_table {
      results = files,
      entry_maker = function (path)
        local name = vim.fn.fnamemodify(path, ':t:r')
        return {
          value = path,
          display = name,
          ordinal = name,
        }
      end
    },
    sorter = sorters.fuzzy_with_index_bias(),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = state.get_selected_entry()
        vim.cmd('source ' .. selection.value)
      end)
      return true
    end,
  }):find()
end
