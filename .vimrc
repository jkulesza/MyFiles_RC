" vim:fdm=marker

                                                                                                                     " Plugins {{{
" Permit Pathogen to operate.
silent! execute pathogen#infect()
if exists('g:loaded_pathogen')
  " Change how indented lines are displayed; don't display by default.  Toggle with :IndentLinesToggle.
  let g:indentLine_enabled = 0                                                                                          " Disable indent indication
  let g:indentLine_char = '>'                                                                                           " Change character used to indicate indent depth
  let g:indentLine_indentLevel = 25                                                                                     " Set maximum indent depth indicated

endif
                                                                                                                     " }}}
                                                                                                                     " Preliminaries {{{
let mapleader=","                                                                                                       " Use a consenus 'better' leader key
syntax on                                                                                                               " Enable syntax highlighting
filetype plugin on                                                                                                      " Enable filetype-specific plugin loading (e.g., for nerdcommenter)
set nocompatible                                                                                                        " This is vim, not vi...
set fileformat=unix                                                                                                     " Set UNIX file format
set encoding=utf-8 fileencoding=utf-8 termencoding=utf-8                                                                " Set file encodings
set timeoutlen=1000 ttimeoutlen=0                                                                                       " Set timeout lengths for 'esc'
set hidden                                                                                                              " Set ability to edit multiple files with :bufdo
set lazyredraw                                                                                                          " Don't redraw the screen while executing non-typed commands
                                                                                                                     " }}}
                                                                                                                     " Backup / Swap / Undo File Behavior {{{
set nobackup                                                                                                            " Do not create backup files
set backupskip=/tmp/*,/private/tmp/*
set noswapfile                                                                                                          " Do not create swap files
set undofile                                                                                                            " Create a persistent undo file
set undodir=$HOME/.vim_undo                                                                                             " Set persistent undo file directory
silent !mkdir ~/.vim_undo > /dev/null 2>&1
                                                                                                                     " }}}
                                                                                                                     " Linewrapping & Text Formatting {{{
set nowrap                                                                                                              " Do not wrap text (in the display) by default
set textwidth=80                                                                                                        " Wrap text after 80 columns
set formatoptions=lcroqnj                                                                                               " Wrap lines with whitespace, but do not insert line breaks
set linebreak                                                                                                           " Wrap lines with whitespace, but do not insert line breaks
set formatlistpat+=\\\|^\\*\\s*                                                                                         " Recognize asterices as list items

if exists ("set breakindent")
	set breakindent                                                                                                       " Maintain indentation with autowrapping text
endif
set noautoindent                                                                                                        " Do not unconditionally autoindent text without comment characters
set nocindent                                                                                                           " Do not indent for coding
set smartindent                                                                                                         " Anticipate indentation
"set paste                                                                                                               " Do not indent pasted text

set tabstop=2                                                                                                           " Set tab width to 2 spaces
set shiftwidth=2                                                                                                        " Set indent width to 2 spaces
set softtabstop=2                                                                                                       " Set soft tab stop to 2 spaces
set expandtab                                                                                                           " Turn tabs into spaces
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()                                                             " Automatically strip trailing whitespace from all lines upon save

let perl_fold=1                                                                                                         " Fold Perl subroutines
                                                                                                                     " }}}
                                                                                                                     " Differencing {{{
set diffopt+=iwhite                                                                                                     " Ignore whitespace within vimdiff
                                                                                                                     " }}}
                                                                                                                     " Searching & Maneuvering {{{
set hlsearch incsearch ignorecase smartcase                                                                             " Perform incremental searching and highlight results
set wildmenu                                                                                                            " Show options for command line completion
set scrolloff=999                                                                                                       " Unless at the top or bottom of the file, center cursor line
set virtualedit=all                                                                                                     " Allow cursor to roam past EOL
set backspace=indent,eol,start                                                                                          " Allow backspacing over everything in Insert mode
set clipboard=exclude:.*                                                                                                " Disable X on startup of vim
"set clipboard=unnamedplus                                                                                               " Use the system clipboard for Yank/Put/Delete
set mouse=                                                                                                              " Set mouse behavior --- scroll but don't copy
if has("gui_running")
  set mouse=a                                                                                                           " Set mouse behavior in GUI; use to select by automatically entering visual mode.
endif                                                                                                                " }}}
                                                                                                                     " GUI Toolbar {{{
set showcmd                                                                                                             " Show visual selection extent
set novisualbell                                                                                                        " Don't flash on errors
set noerrorbells                                                                                                        " Don't do anything on errors
set guioptions-=T                                                                                                       " Don't show the toolbar
set winaltkeys=no                                                                                                       " Turn off windows Alt-key shortcuts
                                                                                                                     " }}}
                                                                                                                     " Status Line {{{
set laststatus=2                                                                                                        " Always show status line
set statusline=
if exists('g:loaded_fugitive')
  set statusline+=%{fugitive#statusline()}
endif
set statusline+=[%F%m%r%h%w]
set statusline+=%=[%l,%v][%p%%][LEN=%L]
                                                                                                                     " }}}
                                                                                                                     " Printing Options {{{
set printheader=%<%F%m%=Page\ %N                                                                                        " Configure hardcopy header
set printfont=courier_new:h8:w5                                                                                         " Configure hardcopy appearance
set printoptions=paper:letter,portrait:n,left:0.25in,right:0.25in,top:0.25in,bottom:0.25in
                                                                                                                     " }}}
                                                                                                                     " netrw Behavior {{{
let g:netrw_sort_sequence=''                                                                                            " Remove file extensions from sort considerations
let g:netrw_sort_options='i'                                                                                            " Sort truly alphabetically (case insensitively)
let g:netrw_liststyle='1'                                                                                               " List with sizes / dates (long)
                                                                                                                     " }}}
                                                                                                                     " Perform Coloring of Programming Danger Zone {{{
set cursorline                                                                                                          " Highlight the current line
set nocursorcolumn                                                                                                      " Highlight the current column
if has("gui_running")
   if exists('+colorcolumn')
     let &colorcolumn="81,".join(range(81,81),",")
   else
     autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
   endif
else
     let &colorcolumn="81,".join(range(81,81),",")
endif
"autocmd FileType html,xml,cpp,fortran,python highlight OverLength ctermbg=red ctermfg=white guibg=#592929               " Highlight overlength columns.
"autocmd FileType html,xml,cpp,fortran,python match OverLength /\%81v.\+/                                                " Match columns over 80 as 'overlength'
                                                                                                                     " }}}
                                                                                                                     " Set Filetype Autocommands {{{
:let fortran_free_source=1                                                                                              " Assume free-format Fortran by default
autocmd Filetype fortran setlocal com+=n:! textwidth=80                                                                 " Recognize ! as Fortran comment
autocmd Filetype gitcommit setlocal spell textwidth=72                                                                  " Setup editing to work with git
autocmd FileType make setlocal noexpandtab                                                                              " Don't expandtab for makefiles
autocmd Filetype python setlocal shiftwidth=4 tabstop=4 softtabstop=4                                                   " Change tab behavior to accomodate Python style guidance
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown                                                        " Enable markdown behavior for .md files
autocmd BufNewFile,BufRead *.lyx set filetype=lyx
                                                                                                                     " }}}
                                                                                                                     " On-the-fly Spelling Correction {{{
iab teh the
                                                                                                                     " }}}
                                                                                                                     " Custom Key Mappings {{{
" Automatically close symbol constructs
"inoremap { {<CR>}<C-O>O
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>

" Change how tabs are navigated between in the GUI
map <D-S-Left> <Esc>:tabprev<CR>
map <D-S-Right> <Esc>:tabnext<CR>

" Navigation Mappings (c.f. .tmux.conf)
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Popup menu up/down navigation with j and k (not just Ctrl-N / Ctrl-P)
inoremap <expr> j pumvisible() ? "\<C-N>" : "j"
inoremap <expr> k pumvisible() ? "\<C-P>" : "k"

" F-Key Mappings
imap <F1> <Nop>"                                                                                                        Unmap F1 from Help
map <F1> <Nop>"                                                                                                         Unmap F1 from Help
map <F2> :call NumberToggle()<CR>"                                                                                      Toggle Line Numbers (with User-Defined Function)
map <F3> :set list!<CR>"                                                                                                Toggle Hidden Characters
map <F4> :set wrap!<CR>"                                                                                                Toggle Line Wrapping

map <F5> :e!<CR>1G0"                                                                                                    Refresh Current File
"map <F6>
map <F7> :setlocal spell! spelllang=en_us<CR>"                                                                          Enable Spellchecking (v7.0+)
set spellcapcheck=                                                                                                    " Disable Spell Checking for Capitalization
map <F8> :set makeprg=proselint\ %<CR>:silent make!\|redraw!\|cw<CR>"                                                   Run proselint on Current File and open quickfix list

map <F9> <Nop>"
"map <F10>
"map <F11>
"map <F12>

map <CR> <Nop>
                                                                                                                     " }}}
                                                                                                                     " OS-Specific GUI Customizations {{{
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12                                                                                         " Default font
  elseif has("gui_macvim")
"   set guifont=Menlo\ Regular:h11                                                                                      " Default font
    set guifont=Monaco:h12
    set lines=35                                                                                                        " Set the window height at the outset
    set columns=105                                                                                                     " Set the window width  at the outset
  elseif has("gui_win32")
    set guifont=Consolas:h12:cANSI                                                                                      " Default font
    set lines=35                                                                                                        " Set the window height at the outset
    set columns=85                                                                                                      " Set the window width  at the outset
  endif
endif
                                                                                                                     " }}}
                                                                                                                     " Custom Menus {{{
" General Functions
:10000menu Custom.Load\ \_gvimrc             :e $VIM\_gvimrc<CR>"                                                       Load _gvimrc File
:10000menu Custom.Source\ \_gvimrc           :so $VIM\_gvimrc<CR>"                                                      Source _gvimrc File
:10000menu Custom.-Sep1-                     :"                                                                         Separator

if has("gui_running")
  if has("gui_gtk2")
    :10000menu Custom.Small\ Font                :set guifont=Inconsolata\ 8<CR>"                                       Set Font To Be Smaller Than Default
    :10000menu Custom.Normal\ Font               :set guifont=Inconsolata\ 12<CR>"                                      Set Default Font
    :10000menu Custom.Large\ Font                :set guifont=Inconsolata\ 36<CR>"                                      Set Font To Be Larger Than Default
  elseif has("gui_macvim")
    :10000menu Custom.Small\ Font                :set guifont=Monaco:h8<CR>"                                            Set Font To Be Smaller Than Default
    :10000menu Custom.Normal\ Font               :set guifont=Monaco:h12<CR>"                                           Set Default Font
    :10000menu Custom.Large\ Font                :set guifont=Monaco:h36<CR>"                                           Set Font To Be Larger Than Default
  elseif has("gui_win32")
    :10000menu Custom.Small\ Font                :set guifont=Consolas:h8:cANSI<CR>"                                    Set Font To Be Smaller Than Default
    :10000menu Custom.Normal\ Font               :set guifont=Consolas:h12:cANSI<CR>"                                   Set Default Font
    :10000menu Custom.Large\ Font                :set guifont=Consolas:h36:cANSI<CR>"                                   Set Font To Be Larger Than Default
  endif
endif

:10000menu Custom.-Sep2-                     :"                                                                         Separator
:10000menu Custom.Set\ Paste\ Toggle         :set paste!<CR>"                                                           Disable Automatic Whitespace On Paste
:10000menu Custom.Reverse\ All\ Lines        :g/^/m0<CR>:noh<CR>"                                                       Reverse All Lines In The File
:10000menu Custom.-Sep3-                     :"                                                                         Separator
:10000menu Custom.Lowercase\ Line            Vu"                                                                        Lowercase Line
:10000menu Custom.Uppercase\ Line            VU"                                                                        Uppercase Line
:10000menu Custom.-Sep4-                     :"                                                                         Separator
                                                                                                                     " }}}
                                                                                                                     " Custom Functions {{{
" Toggle line numbers rotating through the options: Off, Absolute, Relative
if (v:version>=703) && (v:version<704)
  function! NumberToggle()
    if(&number == 1)
      set relativenumber
      autocmd FocusLost   * :set number
      autocmd FocusGained * :set relativenumber
      autocmd InsertEnter * :set number
      autocmd InsertLeave * :set relativenumber
    elseif(&relativenumber == 1)
      set norelativenumber
      autocmd FocusLost   * :set nonumber
      autocmd FocusGained * :set norelativenumber
      autocmd InsertEnter * :set nonumber
      autocmd InsertLeave * :set norelativenumber
    else
      set number
    endif
  endfunc
endif
if (v:version >=704)
  function! NumberToggle()
  :let [&nu, &rnu] = [!&rnu, &nu+&rnu==1]
  endfunc
endif

" Automatically toggle paste for Terminal sessions
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" Jump to last position in file (ignoring git commit messages).
autocmd BufReadPost *
  \ if expand('%:p') !~# '\m/\.git/' && line("'\"") > 0 && line("'\"") <= line("$") |
  \     exe "normal! g`\"" |
  \ endif

" Strip trailing whitespace and return cursor to previous position.
" http://stackoverflow.com/questions/35390415/cursor-jump-in-vim-after-save
function! <SID>StripTrailingWhitespaces()
  let blacklist = ['lyx']
  if index(blacklist, &filetype) == 0
    return
  else
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
    return
  endif
endfun

" View currently opened file as hex (to avoid needing to remember the command).
function! To_Hex()
  :%!xxd
endfun
                                                                                                                     " }}}
                                                                                                                     " Load Skeleton Files {{{
augroup Shebang

  " The approach is taken here rather than using something like vim-skeletons
  " because of compound extensions (e.g., .mcnp.inp).
  autocmd BufNewFile *.py       r ~/.vim/skeletons/skeleton.py       | execute "normal! ggdd$"
  autocmd BufNewFile *.sh       r ~/.vim/skeletons/skeleton.sh       | execute "normal! ggddG$"
  autocmd BufNewFile *.f90      r ~/.vim/skeletons/skeleton.f90      | execute "normal! ggdd$"
  autocmd BufNewFile *.mcnp.inp r ~/.vim/skeletons/skeleton.mcnp.inp | execute "normal! ggdd$"

augroup END
                                                                                                                     " }}}
                                                                                                                     " Colorschemes {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Color General Options

set t_Co=256
set background=dark
highlight clear
if exists("syntax on")
	syntax reset
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mine, Based on Torte Rev. 1.1
" Maintainer:  Joel Kulesza <jkulesza@lanl.gov>
"
let g:colors_name="mine"
hi Normal          guifg=#dadada       guibg=Black         gui=NONE            ctermfg=252         ctermbg=Black       cterm=NONE
hi IncSearch       guifg=Black         guibg=#d0d0d0       gui=NONE            ctermfg=Black       ctermbg=252         cterm=NONE
hi Search          guifg=Black         guibg=#d0d0d0       gui=NONE            ctermfg=Black       ctermbg=252         cterm=NONE
hi Visual          guifg=Black         guibg=#949494       gui=NONE            ctermfg=Black       ctermbg=246         cterm=NONE
hi Cursor          guifg=Black         guibg=#00ff00       gui=NONE            ctermfg=Black       ctermbg=010         cterm=NONE
hi CursorLine      guifg=NONE          guibg=NONE          gui=UNDERLINE       ctermfg=NONE        ctermbg=NONE        cterm=UNDERLINE
hi CursorColumn    guifg=NONE          guibg=#121212       gui=NONE            ctermfg=NONE        ctermbg=233         cterm=NONE
hi Special         guifg=#af5f00       guibg=NONE          gui=NONE            ctermfg=130         ctermbg=NONE        cterm=NONE
hi Comment         guifg=#0087ff       guibg=NONE          gui=NONE            ctermfg=033         ctermbg=NONE        cterm=NONE
hi Constant        guifg=#ffa0a0       guibg=NONE          gui=NONE            ctermfg=013         ctermbg=NONE        cterm=NONE
hi Identifier      guifg=#40ffff       guibg=NONE          gui=NONE            ctermfg=014         ctermbg=NONE        cterm=NONE
hi PreProc         guifg=#ff80ff       guibg=NONE          gui=NONE            ctermfg=081         ctermbg=NONE        cterm=NONE
hi Type            guifg=#60ff60       guibg=NONE          gui=NONE            ctermfg=121         ctermbg=NONE        cterm=NONE
hi StatusLine      guifg=White         guibg=#262626       gui=NONE            ctermfg=White       ctermbg=235         cterm=NONE
hi StatusLineNC    guifg=#3a3a3a       guibg=#080808       gui=NONE            ctermfg=237         ctermbg=232         cterm=NONE
hi VertSplit       guifg=#808080       guibg=#262626       gui=NONE            ctermfg=232         ctermbg=235         cterm=NONE
hi Statement       guifg=#ffff00       guibg=NONE          gui=NONE            ctermfg=226         ctermbg=NONE        cterm=NONE
hi ColorColumn     guifg=NONE          guibg=#121212       gui=NONE            ctermfg=NONE        ctermbg=233         cterm=NONE
hi Folded          guifg=NONE          guibg=#121212       gui=NONE            ctermfg=NONE        ctermbg=233         cterm=NONE
hi Pmenu           guifg=NONE          guibg=#080808       gui=NONE            ctermfg=NONE        ctermbg=232         cterm=NONE
hi PmenuSel        guifg=NONE          guibg=#262626       gui=NONE            ctermfg=NONE        ctermbg=235         cterm=NONE
hi DiffAdd         guifg=NONE          guibg=#5f0000       gui=NONE            ctermfg=NONE        ctermbg=022         cterm=NONE
hi DiffChange      guifg=NONE          guibg=#5f0000       gui=NONE            ctermfg=NONE        ctermbg=018         cterm=NONE
hi DiffText        guifg=NONE          guibg=#5f0000       gui=NONE            ctermfg=NONE        ctermbg=163         cterm=NONE
hi DiffDelete      guifg=NONE          guibg=#5f0000       gui=NONE            ctermfg=NONE        ctermbg=052         cterm=NONE
hi SpellBad        guifg=NONE          guibg=#444444       gui=UNDERCURL       ctermfg=NONE        ctermbg=124         cterm=UNDERLINE
hi SpellCap        guifg=NONE          guibg=#444444       gui=UNDERCURL       ctermfg=NONE        ctermbg=124         cterm=UNDERLINE
hi SpellRare       guifg=NONE          guibg=#444444       gui=UNDERCURL       ctermfg=NONE        ctermbg=124         cterm=UNDERLINE
hi SpellLocal      guifg=NONE          guibg=#444444       gui=UNDERCURL       ctermfg=NONE        ctermbg=124         cterm=UNDERLINE

set fillchars+=vert:\ " Remove pipes from vertical split delimiter

" Highlight the status bar when in insert mode (https://github.com/chrishunt/dot-files/blob/master/.vimrc).
"if version >= 700
"  au InsertEnter * hi StatusLine                                               ctermfg=White       ctermbg=238
"  au InsertLeave * hi StatusLine                                               ctermfg=White       ctermbg=235
"endif

" Link defined type colors to other types.
hi link String         Constant
hi link Character      Constant
hi link Number         Constant
hi link Boolean        Constant
hi link Float          Constant
hi link Function       Identifier
hi link Conditional    Statement
hi link Repeat         Statement
hi link Label          Statement
hi link Operator       Statement
hi link Keyword        Statement
hi link Exception      Statement
hi link Include        PreProc
hi link Define         PreProc
hi link Macro          PreProc
hi link PreCondit      PreProc
hi link StorageClass   Type
hi link Structure      Type
hi link TypeDef        Type
hi link SpecialChar    Special
hi link Tag            Special
hi link Delimiter      Special
hi link SpecialComment Special
hi link Debug          Special

" Make color table for easy reference.
function! PrePad(s,amt,...)
" from http://stackoverflow.com/questions/4964772/string-formatting-padding-in-vim
    if a:0 > 0
        let char = a:1
    else
        let char = ' '
    endif
    return repeat(char,a:amt - len(a:s)) . a:s
endfunction

function! ShowColors()
" modified from http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
  let num = 255
  while num >= 0
      exec 'hi col_'.PrePad(num,3,0).' ctermbg='.PrePad(num,3,0).' ctermfg=white'
      exec 'syn match col_'.PrePad(num,3,0).' "ctermbg='.PrePad(num,3,0).'" containedIn=ALL'
      call append(0, 'ctermbg='.PrePad(num,3,0).'')
      let num = num - 1
  endwhile
endfunc

function! HighlightColors()
" based on previous from http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
  let num = 255
  while num >= 0
      exec 'hi col_'.PrePad(num,3,0).' ctermbg='.PrePad(num,3,0).' ctermfg=white'
      exec 'syn match col_'.PrePad(num,3,0).' "ctermbg='.PrePad(num,3,0).'" containedIn=ALL'
      let num = num - 1
  endwhile
endfunc

function! HighlightMCNP()
" simple MCNP syntax highlighting
"  exec 'syn match Number "\v\d+:"me=e-1'
"  exec 'syn match Number "\v\=([-]*\d+\s*)+"ms=s+1'
"  exec 'syn match Number "\v\=([-]*\d+[eE][-+]*\d+\s*)+"ms=s+1'
"
"  exec 'syn match Keyword "erg"'
"  exec 'syn match Keyword "\v^\s*f"'
"  exec 'syn match Keyword "\v^\s*fmesh"'
"  exec 'syn match Keyword "geom"'
"  exec 'syn match Keyword "imp"'
"  exec 'syn match Keyword "origin"'
"  exec 'syn match Keyword "\vimesh|iints|jmesh|jints|kmesh|kints"'
"  exec 'syn match Keyword "\v^\s*m"'
"  exec 'syn match Keyword "\v^\s*mt"'
"  exec 'syn match Keyword "mode"'
"  exec 'syn match Keyword "nps"'
"  exec 'syn match Keyword "out"'
"  exec 'syn match Keyword "print"'
"  exec 'syn match Keyword "sdef"'
"
"  exec 'syn match SpecialChar "col"'
"  exec 'syn match SpecialChar "rtz"'
"  exec 'syn match SpecialChar "xyz"'
"  exec 'syn match SpecialChar "\v:(n|p|e)"'

  exec 'syn region Comment start="^\s*c " end="$"'
  exec 'syn region Comment start="^\s*c$" end="$"'
  exec 'syn region Comment start="\$"  end="$"'
endfunc

" only enable default goofy highlighting in .vimrc
autocmd VimEnter * if @% == '.vimrc' | call HighlightColors() | endif
autocmd BufNewFile,BufRead *.mcnp.inp call HighlightMCNP()

"ctermbg=000 #000000 ctermbg=001 #800000 ctermbg=002 #008000 ctermbg=003 #808000
"ctermbg=004 #000080 ctermbg=005 #800080 ctermbg=006 #008080 ctermbg=007 #c0c0c0
"ctermbg=008 #808080 ctermbg=009 #ff0000 ctermbg=010 #00ff00 ctermbg=011 #ffff00
"ctermbg=012 #0000ff ctermbg=013 #ff00ff ctermbg=014 #00ffff ctermbg=015 #ffffff
"
"ctermbg=016 #000000 ctermbg=017 #00005f ctermbg=018 #000087 ctermbg=019 #0000af ctermbg=020 #0000d7 ctermbg=021 #0000ff
"ctermbg=022 #005f00 ctermbg=023 #005f5f ctermbg=024 #005f87 ctermbg=025 #005faf ctermbg=026 #005fd7 ctermbg=027 #005fff
"ctermbg=028 #008700 ctermbg=029 #00875f ctermbg=030 #008787 ctermbg=031 #0087af ctermbg=032 #0087d7 ctermbg=033 #0087ff
"ctermbg=034 #00af00 ctermbg=035 #00af5f ctermbg=036 #00af87 ctermbg=037 #00afaf ctermbg=038 #00afd7 ctermbg=039 #00afff
"ctermbg=040 #00d700 ctermbg=041 #00d75f ctermbg=042 #00d787 ctermbg=043 #00d7af ctermbg=044 #00d7d7 ctermbg=045 #00d7ff
"ctermbg=046 #00ff00 ctermbg=047 #00ff5f ctermbg=048 #00ff87 ctermbg=049 #00ffaf ctermbg=050 #00ffd7 ctermbg=051 #00ffff
"ctermbg=052 #5f0000 ctermbg=053 #5f005f ctermbg=054 #5f0087 ctermbg=055 #5f00af ctermbg=056 #5f00d7 ctermbg=057 #5f00ff
"ctermbg=058 #5f5f00 ctermbg=059 #5f5f5f ctermbg=060 #5f5f87 ctermbg=061 #5f5faf ctermbg=062 #5f5fd7 ctermbg=063 #5f5fff
"ctermbg=064 #5f8700 ctermbg=065 #5f875f ctermbg=066 #5f8787 ctermbg=067 #5f87af ctermbg=068 #5f87d7 ctermbg=069 #5f87ff
"ctermbg=070 #5faf00 ctermbg=071 #5faf5f ctermbg=072 #5faf87 ctermbg=073 #5fafaf ctermbg=074 #5fafd7 ctermbg=075 #5fafff
"ctermbg=076 #5fd700 ctermbg=077 #5fd75f ctermbg=078 #5fd787 ctermbg=079 #5fd7af ctermbg=080 #5fd7d7 ctermbg=081 #5fd7ff
"ctermbg=082 #5fff00 ctermbg=083 #5fff5f ctermbg=084 #5fff87 ctermbg=085 #5fffaf ctermbg=086 #5fffd7 ctermbg=087 #5fffff
"ctermbg=088 #870000 ctermbg=089 #87005f ctermbg=090 #870087 ctermbg=091 #8700af ctermbg=092 #8700d7 ctermbg=093 #8700ff
"ctermbg=094 #875f00 ctermbg=095 #875f5f ctermbg=096 #875f87 ctermbg=097 #875faf ctermbg=098 #875fd7 ctermbg=099 #875fff
"ctermbg=100 #878700 ctermbg=101 #87875f ctermbg=102 #878787 ctermbg=103 #8787af ctermbg=104 #8787d7 ctermbg=105 #8787ff
"ctermbg=106 #87af00 ctermbg=107 #87af5f ctermbg=108 #87af87 ctermbg=109 #87afaf ctermbg=110 #87afd7 ctermbg=111 #87afff
"ctermbg=112 #87d700 ctermbg=113 #87d75f ctermbg=114 #87d787 ctermbg=115 #87d7af ctermbg=116 #87d7d7 ctermbg=117 #87d7ff
"ctermbg=118 #87ff00 ctermbg=119 #87ff5f ctermbg=120 #87ff87 ctermbg=121 #87ffaf ctermbg=122 #87ffd7 ctermbg=123 #87ffff
"ctermbg=124 #af0000 ctermbg=125 #af005f ctermbg=126 #af0087 ctermbg=127 #af00af ctermbg=128 #af00d7 ctermbg=129 #af00ff
"ctermbg=130 #af5f00 ctermbg=131 #af5f5f ctermbg=132 #af5f87 ctermbg=133 #af5faf ctermbg=134 #af5fd7 ctermbg=135 #af5fff
"ctermbg=136 #af8700 ctermbg=137 #af875f ctermbg=138 #af8787 ctermbg=139 #af87af ctermbg=140 #af87d7 ctermbg=141 #af87ff
"ctermbg=142 #afaf00 ctermbg=143 #afaf5f ctermbg=144 #afaf87 ctermbg=145 #afafaf ctermbg=146 #afafd7 ctermbg=147 #afafff
"ctermbg=148 #afd700 ctermbg=149 #afd75f ctermbg=150 #afd787 ctermbg=151 #afd7af ctermbg=152 #afd7d7 ctermbg=153 #afd7ff
"ctermbg=154 #afff00 ctermbg=155 #afff5f ctermbg=156 #afff87 ctermbg=157 #afffaf ctermbg=158 #afffd7 ctermbg=159 #afffff
"ctermbg=160 #d70000 ctermbg=161 #d7005f ctermbg=162 #d70087 ctermbg=163 #d700af ctermbg=164 #d700d7 ctermbg=165 #d700ff
"ctermbg=166 #d75f00 ctermbg=167 #d75f5f ctermbg=168 #d75f87 ctermbg=169 #d75faf ctermbg=170 #d75fd7 ctermbg=171 #d75fff
"ctermbg=172 #d78700 ctermbg=173 #d7875f ctermbg=174 #d78787 ctermbg=175 #d787af ctermbg=176 #d787d7 ctermbg=177 #d787ff
"ctermbg=178 #d7af00 ctermbg=179 #d7af5f ctermbg=180 #d7af87 ctermbg=181 #d7afaf ctermbg=182 #d7afd7 ctermbg=183 #d7afff
"ctermbg=184 #d7d700 ctermbg=185 #d7d75f ctermbg=186 #d7d787 ctermbg=187 #d7d7af ctermbg=188 #d7d7d7 ctermbg=189 #d7d7ff
"ctermbg=190 #d7ff00 ctermbg=191 #d7ff5f ctermbg=192 #d7ff87 ctermbg=193 #d7ffaf ctermbg=194 #d7ffd7 ctermbg=195 #d7ffff
"ctermbg=196 #ff0000 ctermbg=197 #ff005f ctermbg=198 #ff0087 ctermbg=199 #ff00af ctermbg=200 #ff00d7 ctermbg=201 #ff00ff
"ctermbg=202 #ff5f00 ctermbg=203 #ff5f5f ctermbg=204 #ff5f87 ctermbg=205 #ff5faf ctermbg=206 #ff5fd7 ctermbg=207 #ff5fff
"ctermbg=208 #ff8700 ctermbg=209 #ff875f ctermbg=210 #ff8787 ctermbg=211 #ff87af ctermbg=212 #ff87d7 ctermbg=213 #ff87ff
"ctermbg=214 #ffaf00 ctermbg=215 #ffaf5f ctermbg=216 #ffaf87 ctermbg=217 #ffafaf ctermbg=218 #ffafd7 ctermbg=219 #ffafff
"ctermbg=220 #ffd700 ctermbg=221 #ffd75f ctermbg=222 #ffd787 ctermbg=223 #ffd7af ctermbg=224 #ffd7d7 ctermbg=225 #ffd7ff
"ctermbg=226 #ffff00 ctermbg=227 #ffff5f ctermbg=228 #ffff87 ctermbg=229 #ffffaf ctermbg=230 #ffffd7 ctermbg=231 #ffffff
"
"ctermbg=232 #080808 ctermbg=233 #121212 ctermbg=234 #1c1c1c ctermbg=235 #262626 ctermbg=236 #303030 ctermbg=237 #3a3a3a
"ctermbg=238 #444444 ctermbg=239 #4e4e4e ctermbg=240 #585858 ctermbg=241 #606060 ctermbg=242 #666666 ctermbg=243 #767676
"ctermbg=244 #808080 ctermbg=245 #8a8a8a ctermbg=246 #949494 ctermbg=247 #9e9e9e ctermbg=248 #a8a8a8 ctermbg=249 #b2b2b2
"ctermbg=250 #bcbcbc ctermbg=251 #c6c6c6 ctermbg=252 #d0d0d0 ctermbg=253 #dadada ctermbg=254 #e4e4e4 ctermbg=255 #eeeeee

                                                                                                                      " }}}

