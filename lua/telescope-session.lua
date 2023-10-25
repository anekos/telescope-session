local module = {}

function module.dir ()
  local dir = vim.fn.stdpath('data') .. '/telescope-session/'
  vim.fn.mkdir(dir, 'p')
  return dir
end


function module.filepath (name)
  return module.dir() .. name .. '.vim'
end


return module
