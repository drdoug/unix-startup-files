if has("autocmd")
	if has( "gui_win32")
		autocmd GUIEnter * simalt ~x
		"
		" by default, vim remaps CTRL-Y to Redo
		" to emulate windows behaviour.
		"
		unmap <C-Y>
	endif
        autocmd FileType make set noexpandtab
endif

if has( 'nvim')
        lua require( 'options')
        lua require( 'init')
        lua require( 'functions')
        lua require( 'keymaps')
endif
