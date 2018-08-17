"Vundle boilerplate and plugin loading
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'ajh17/VimCompletesMe'
Plugin 'nightsense/carbonized'
Plugin 'SirVer/UltiSnips'
Plugin 'ervandew/supertab'
Plugin 'sheerun/vim-polyglot'
Plugin 'drmikehenry/vim-fontsize'
Plugin 'jiangmiao/auto-pairs'
Plugin 'AndrewRadev/switch.vim'
Plugin 'w0rp/ale'
Plugin 'wesQ3/vim-windowswap'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'sjl/badwolf'
Plugin 'tmhedberg/SimpylFold'
call vundle#end()
filetype plugin indent on

"get YCM and UltiSnips to play nice
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

"set expand trigger and tabstops for UltiSnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"ALE python linting options
let pylintrcpath="/u/nyc/limaye/.pylintrc"
let g:ale_linters = {'python' : ['flake8']}
let g:ale_python_flake8_executable = "flake8"
let g:ale_python_flake8_options = "--ignore=W,E501,E116"
let g:ale_fixers = ['autopep8', 'yapf']
let g:ale_lint_delay = 10

"some ALE movements
nnoremap <leader>aj :ALENext<cr>
nnoremap <leader>ak :ALEPrevious<cr>
nnoremap <leader>af :ALEFix<cr>
nnoremap <leader>al :ALELint<cr>

"open up my pylintrc easily
execute "nnoremap <leader>py :sp " . pylintrcpath . "<cr>"

"add a custom snippets directory to the runtimepath, UltiSnips will search
"here for a directory named UltiSnips, in which it will find the relevant
"snippets
set runtimepath+=~/.vim/custom_snippets

"convert FOO common names to their most recent FOO modules
function! MostRecentFOOLib(module)
    let mod=system('FOO av ' . shellescape(a:module) . ' | grep lib | tail -n 1')
    :put =mod
endfunction

function! MostRecentFOOBin(module)
    if a:module == 'python'
        let mod=system('FOO av BAR | grep /2. | grep bin | tail -n 1')
    else
        let mod=system('FOO av ' . shellescape(a:module) . ' | grep bin | tail -n 1')
    endif
    :put =mod
endfunction

nnoremap <leader>gb bve"0x<esc>:call MostRecentFOOBin(@0)<cr>i<bs><esc>$
nnoremap <leader>gl bve"0x<esc>:call MostRecentFOOLib(@0)<cr>i<bs><esc>$
iabbr gl garden load

"make movement map to visual lines instead of real lines
function! ScreenMovement(movement)
    if &wrap
        return "g" . a:movement
        else
    endif
endfunction

onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")

"remap colon to semicolon
nnoremap <SPACE> :

"remap split movement to ctrl-direction keys
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

"remap tab movement to ctrl-alt-direction keys
map <C-A-H> :tabprevious<CR>
map <C-A-L> :tabnext<CR>

"expand('%') is the name of current file
"expand('%:p') is the full path of the current file
"expand('%:p:h') is the dirname of the full path of the current file
"i.e. we are mapping %% to the dirname of the current file
cabbr <expr> %% expand('%:p:h')

"autoread when the executable bit is changed
set autoread

"remove trailing whitespace on writing C, Cpp, and Py files
autocmd FileType c,cpp,python autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"upon entering a tab, try to cd to the tab-local variable wd.
"this way, i can let t:wd=this_tabs_working_directory in each tab and it'll
"automagically cd to it each time i change tabs
autocmd TabEnter * if exists('t:wd') | exe "cd" t:wd | endif

"open new splits on the right and on the bottom
set splitright
set splitbelow

"set the colorscheme
let g:badwolf_darkgutter=1
colorscheme badwolf

"turn on syntax highlighting
syntax enable

"tabbing settings, this results in 4-space tabs
set tabstop=4
set expandtab
set shiftwidth=4

"number lines
set number

"make backspace delete end of lines
set backspace=indent,eol,start

"set .txx, .cu, .cuh files as C++ syntax
autocmd BufNewFile,BufRead *.txx set syntax=cpp
autocmd BufNewFile,BufRead *.cu set syntax=cpp
autocmd BufNewFile,BufRead *.cuh set syntax=cpp

"display a color column at 80 characters
set colorcolumn=80

"(recursively) map comma to leader
map , <leader>

"remap zz -> z
nnoremap z zz

"shortcuts for editing and sourcing vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>GzzA<cr>
nnoremap <leader>sv :w<cr>:source $MYVIMRC<cr>

"remove highlighting with backspace in normal mode
nnoremap <bs> :noh<cr>

"split a comment over multiple lines in python
nnoremap <leader>cm Vgqme?#<cr>j<c-v>'eI#<esc>'ej:noh<cr>
inoremap <c-c> <esc>Vgqme?#<cr>j<c-v>'eI#<esc>'ej:noh<cr>i

"split a line over multiple lines in python
nnoremap <leader>cu VgqA<esc>
inoremap <c-s> <esc>VgqA

"move lines up and down
nnoremap + ddkP
nnoremap _ ddp

"map switching boolean values to leader-s
nnoremap <leader>s :Switch<cr>

"uppercase the word i just typed in insert mode
inoremap <c-u> <esc>lgUbei

"automatically set t:wd to the directory of the current file when entering a
"buffer
autocmd BufEnter * silent! let t:wd="%:p:h"

"map <c-d> to change the current directory to that of the current file
nnoremap <c-d> :let t:wd="%:p:h"<cr>:exe "cd" t:wd<cr>

"showcmd, though this doesn't seem to be doing much...
set showcmd

"edit my snippets file
nnoremap <leader>sn :split
    \/u/nyc/limaye/.vim/custom_snippets/UltiSnips/python.snippets<cr>GzzA<cr>

"movement encapsulating the entire parameter list
onoremap pa :<c-u> execute "normal! /)\rhv?(\rl" <bar> :noh<cr>

"movement which visually selects from beginning of kwarg under cursor to the
"end of the kwarg, whether that's a paren or a comma 
onoremap kw :<c-u> execute "normal! T=v/[,)]\rh\r" <bar> :noh<cr>

"yank to X11 selection buffer (pasted with the middle mouse wheel)
nnoremap <leader>y "*y
nnoremap <leader>yy "*yy

"paste from clipboard (copied with ctrl-c)
nnoremap <leader>p "+p
nnoremap <leader>P "+P

"split a python string over a line (only works for two lines now)
nnoremap <leader>ss Vgqme?'<cr>A '<esc>'ei'<esc>:noh<cr>

"unsplit a line
nnoremap <leader>us ^d0i<bs> <esc>

"enclose a line in try...except
nnoremap <leader>tc ^itry:<cr><esc>A<cr>except:<cr>IPython.embed()<esc>
nnoremap <leader>rtc ^h<c-v>3hx<esc>kddj2dd

"add an IPython.embed() statement
nnoremap <leader>ie IIPython.embed()<cr><esc>
