local lib = require('telescope-session')

-- create user command
vim.api.nvim_create_user_command(
  'Session',
  function (args)
    local name = vim.fn.trim(args.args)

    if name == '' then
      if 1 <= #vim.v.this_session then
        vim.cmd('mksession! ' .. vim.v.this_session)
        return
      end

      name = vim.fn.input('Session name: ')
    end

    vim.cmd('mksession! ' .. lib.filepath(name))
  end,
  {
    nargs = '*',
  }
)
