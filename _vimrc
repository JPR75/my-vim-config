set nocompatible
source $VIMRUNTIME/vimrc_example.vim

""""""""""""""""""""""""""""""""""""""""
"" mswim.vim
""""""""""""""""""""""""""""""""""""""""
" Set options and add mapping such that Vim behaves a lot like MS-Windows
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Apr 02

" bail out if this isn't wanted (mrsvim.vim uses this).
if exists("g:skip_loading_mswin") && g:skip_loading_mswin
  finish
endif

" set the 'cpoptions' to its Vim default
if 1	" only do this when compiled with expression evaluation
  let s:save_cpo = &cpoptions
endif
set cpo&vim

" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
behave mswin

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" backspace in Visual mode deletes selection
vnoremap <BS> d

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>		"+gP
map <S-Insert>		"+gP

cmap <C-V>		<C-R>+
cmap <S-Insert>		<C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>		<C-V>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u
inoremap <C-Z> <C-O>u

" Deleted : CTRL-Y is Redo (although not repeat); not in cmdline though

" Alt-Space is System menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" Deleted : CTRL-A is Select all

" CTRL-Tab is Next window
noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w

" CTRL-F4 is Close window
noremap <C-F4> <C-W>c
inoremap <C-F4> <C-O><C-W>c
cnoremap <C-F4> <C-C><C-W>c
onoremap <C-F4> <C-C><C-W>c

" restore 'cpoptions'
set cpo&
if 1
  let &cpoptions = s:save_cpo
  unlet s:save_cpo
endif
""""""""""""""""""""""""""""""""""""""""
"" End mswim.vim
""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""
"" My config
""""""""""""""""""""""""""""""""""""""""
syntax on
set number
set autoindent
set smartindent
set bs=2
set tabstop=2
set expandtab
set shiftwidth=2
set linebreak
set showmatch
set nobackup
set lines=200 columns=120
set selectmode=
set cursorline
set comments+=:--
set formatoptions+=or
set go-=T
set fileencoding=utf-8
set ff=unix
set noundofile
let g:bufferline_echo = 0

" Move the cursor to the first non-blank character of a line
nmap <C-up> ddkP
" Move line down
nmap <C-down> ddjP
vmap <C-up> dkP
vmap <C-down> djP
imap <C-space> <C-p>

" Jump to the matching object, and you visually select all the text in between
map <F6> v%
" Toggle case
map <F7> ^
" Move line up
map <F8> ~
" Remove trailing space
map  <F9> <ESC>:%s/\s\+$//<CR>
" Remove temporally comment in selected area
map <F10> <ESC>:%s/\%V--.*\n//gc<CR>
" Capitalize word
map <F11> <ESC>:%s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g<CR>:noh<CR>
" Toggle NerdTree
map <F12> :NERDTreeToggle<CR>

:iab jpr Jean-Paul Ricaud
":iab jprmail jean-paul.ricaud@maxiv.lu.se
:iab frdate <C-R>=strftime("%d %b %Y")<CR>
:iab endate <C-R>=strftime("%b %d %Y")<CR>

filetype plugin on

set runtimepath=$VIMRUNTIME,$VIM/vimfiles,$VIM/vimfiles/after

if has("gui_running")
  if has("win32")
    let $HOME=$VIM
"    set guifont=DejaVu_Sans_Mono:h10:cANSI
    set encoding=utf-8
"    set guifont=DejaVu_Sans_Mono_for_Powerline:h10:cDEFAULT
    set guifont=DejaVuSansMono_NF:h10:cDEFAULT
    "MW
    let &showbreak="•••\ "
    ">> DC
    set list listchars=tab:»»,trail:¤
  else
    set guifont=DejaVu\ Sans\ Mono\ 10
    "Sb
    let &showbreak="âˆ™âˆ™âˆ™\ "
    ">> OS
    set list listchars=tab:>Â»,trail:â–¡
  endif
endif

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"*** Colorschemes
"high contrast
"colorscheme koehler

"Low contrast
colorscheme kingtop
"colorscheme wombat
"colorscheme inkpot2

autocmd! bufreadpost *.lib set syntax=off
let g:airline_powerline_fonts = 1
