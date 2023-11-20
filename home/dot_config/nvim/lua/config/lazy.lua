local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- Bootstrap lazy.nvim.
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
	spec = {
		-- Add LazyVIM and import its plugins.
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		-- Import/Override with my plugins.
		{ import = "plugins" },
	},
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to have leave version=false for now, since a lot the plugins that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- Always use the latest git commit
		-- version = "*", -- Try installing the latest stable version for plugins that support semver
	},
	checker = { enabled = true },
	performance = {
		rtp = {
			-- Disable some rtp plugins.
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
