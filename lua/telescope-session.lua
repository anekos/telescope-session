local module = {}

function module.names()
  local result = {}
  local files = vim.fn.glob(module.dir() .. '*.vim', true, true)
  for _, path in ipairs(files) do
    local name = vim.fn.fnamemodify(path, ':t:r')
    table.insert(result, name)
  end
  return result
end

function module.dir ()
  local dir = vim.fn.stdpath('data') .. '/telescope-session/'
  vim.fn.mkdir(dir, 'p')
  return dir
end

function module.filepath (name)
  return module.dir() .. name .. '.vim'
end

function module.open (name)
  local fp = module.filepath(name)
  vim.cmd.source(fp)
end

function module.delete (name)
  local fp = module.filepath(name)
  if vim.fn.filereadable(fp) == 1 then
    if vim.fn.confirm('Delete: ' .. name .. '?', '&Yes\n&No', 2) ~= 1 then
      return
    end
    vim.fn.delete(fp)
    vim.notify('Deleted: ' .. name)
  end
end

return module
