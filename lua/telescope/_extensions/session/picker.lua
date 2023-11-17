local actions = require('telescope.actions')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local state = require('telescope.actions.state')

local lib = require('telescope-session')

return function(opts)
  opts = opts or {}

  pickers
    .new(opts, {
      prompt_title = 'Sessions',
      finder = finders.new_table {
        results = lib.names(),
      },
      sorter = sorters.fuzzy_with_index_bias(),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          lib.open(state.get_selected_entry().value)
        end)

        map('n', 'dd', function()
          local current_picker = state.get_current_picker(prompt_bufnr)
          current_picker:delete_selection(function(_)
            return lib.delete(state.get_selected_entry().value)
          end)
        end)
        return true
      end,
    })
    :find()
end
