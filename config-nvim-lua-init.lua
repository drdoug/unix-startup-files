local lazypath = vim.fn.stdpath( 'data') .. '/lazy/lazy.nvim'

if not ( vim.uv or vim.loop).fs_stat( lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system( { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo(
                        {
                                {
                                'Failed to retrieve the latest version of lazy.nvim\nPlease check the init.lua file or its subordinates:',
                                'ErrorMsg',
                                },
                                { out, 'WarningMsg' },
                                { '\nPress any key to exit...' },
                        },
                        true,
                        {}
                        )
		vim.fn.getchar()
		os.exit( 1)
	end
end
vim.opt.rtp:prepend( lazypath)

require( 'lazy').setup(
        {
	spec =
                {
		{ import = 'plugins' },
                },
	defaults =
                {
		lazy = false,
		version = false, -- always use the latest git commit
                },
	checker =
                {
		enabled = true, -- check for plugin updates periodically
		notify = false, -- notify on update
                }, -- automatically check for plugin updates
	performance =
                {
		rtp =
                        {
			disabled_plugins =
                                {
				'gzip',
				'matchit',
				'netrwPlugin',
				'tarPlugin',
				'tohtml',
				'tutor',
				'zipPlugin',
                                },
                        },
                },
        })
