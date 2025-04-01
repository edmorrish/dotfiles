local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
print(lazypath)
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "user.plugins" }, { import = "user.plugins.lsp" }}, {
  checker = {
    enabled = true,
    notify = false
  },
  change_detection = {
    notify = false
  },
})
