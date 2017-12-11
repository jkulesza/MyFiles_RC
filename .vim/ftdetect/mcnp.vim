au BufRead,BufNewFile *.mcnp.inp set filetype=mcnp
autocmd FileType mcnp setlocal commentstring=c\ %s
