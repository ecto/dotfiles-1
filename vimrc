"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" ~/.vimrc (v7.4)

"" ┌─┐┬─┐┌┐┐┬─┐┬─┐┬─┐┬  
"" │ ┬├─ │││├─ │┬┘│─┤│  
"" └─┘┴─┘│└┘┴─┘│└┘┘ │└─┘
"""""""""""""""" GENERAL

set nocompatible                 " use vim settings, rather than vi settings
set paste                        " paste without auto indentation
set hidden                       " hide buffers, not close them
set noswapfile                   " no swap file 
set wildmode=longest,list,full   " lazy file name tab completion
set wildmenu                     " lazy file name tab completion
set wildignorecase               " lazy file name tab completion
set showcmd                      " show partial commands
set ignorecase                   " case insensitive search
set smartcase                    " case insensitive search
set gdefault                     " the /g flag on :s substitutions
set backspace=indent,eol,start   " backspace behaviour
set hlsearch                     " searching
set incsearch                    " searching
set shiftwidth=2                 " 4 spaces indents
set expandtab                    " tabs are spaces, not tabs
set tabstop=2                    " indentation every four columns
set softtabstop=2                " backspace delete indent
set nobackup                     " no backup files
set ffs=unix,dos,mac             " all filformats
set wrap linebreak nolist        " soft wrap
"set tw=78                        " hard wrap
"set formatoptions+=t             " hard wrap


"" o┌┐┐┌┐┐┬─┐┬─┐┬─┐┬─┐┌─┐┬─┐
"" ││││ │ ├─ │┬┘├─ │─┤│  ├─ 
"" ││└┘ │ ┴─┘│└┘│  ┘ │└─┘┴─┘
"""""""""""""""""" INTERFACE

set shortmess+=I                 " disable startup message
set lazyredraw                   " stop unnecessary rendering
set vb                           " visual bell
set scrolloff=1                  " One visible lines before cursor
set guioptions-=m                " remove menu bar
set guioptions-=T                " remove toolbar
set guioptions-=r                " remove right-hand scroll bar
set guioptions-=L                " remove left-hand scroll bar
set guicursor=n-v-c:block-Cursor " cursor type
set guicursor+=i-ci:block-Cursor " cursor type in insert mode
set guifont=Monospace\ 9         " default font
syntax off                       " syntax highlighting
set background=dark              " dark color
filetype off

"" ┐─┐┌┐┐o┬─┐┬─┐┬─┐┌┐┐┐─┐
"" └─┐│││││─┘│─┘├─  │ └─┐
"" ──┘ └┘││  │  ┴─┘ │ ──┘
"""""""""""""""" SNIPPETS

" Tab completion in insert mode: VERY nice.
" See ":help completion"; this function was copied from there. It makes
" the Tab key act normally if there's only whitespace to the left of it,
" but it does "tab completion" if there's anything else to the left.
" This is a very "DWIW" (Do What I Want) kind of thing :)
" Note that you can't insert a Tab in the middle of a line by pressing
" Tab any more, but you can by pressing <C-V><Tab>.
function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-N>"
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

" With this Tab option, use a dictionnary
" set complete=.,w,b,u,t,i,k~/.vim/dictionary

"" ┌─┐┌─┐┬  ┌─┐┬─┐┐─┐┌─┐┬ ┬┬─┐┌┌┐┬─┐
"" │  │ ││  │ ││┬┘└─┐│  │─┤├─ │││├─ 
"" └─┘┘─┘└─┘┘─┘│└┘──┘└─┘│ ┴┴─┘┘ │┴─┘
"""""""""""""""""""""""" COLORSCHEME

" all in monochrome colors
hi Normal guifg=#fcefba guibg=black gui=NONE
hi Text guifg=#fcefba guibg=black gui=NONE
hi NonText guifg=#fcefba guibg=black gui=NONE
hi Cursor guifg=black guibg=#fcefba gui=NONE
hi CursorLine guifg=#fcefba guibg=black gui=NONE
hi CursorLineNr guifg=#fcefba guibg=black gui=bold
hi FoldColumn guifg=#fcefba guibg=black gui=NONE
hi Folded guifg=#fcefba guibg=black gui=NONE
hi LineNr guifg=#fcefba guibg=black gui=NONE
hi Statement guifg=#fcefba guibg=black gui=bold
hi PreProc guifg=#fcefba guibg=black gui=bold
hi String guifg=#fcefba guibg=black gui=NONE
hi Comment guifg=#fcefba guibg=black gui=italic
hi Constant guifg=#fcefba guibg=black gui=NONE
hi Type guifg=#fcefba guibg=black gui=bold
hi Function guifg=#fcefba guibg=black gui=NONE
hi Identifier guifg=#fcefba guibg=black gui=NONE
hi Special guifg=#fcefba guibg=black gui=NONE
hi MatchParen guifg=black guibg=#fcefba gui=NONE
hi elixirDelimiter guifg=#fcefba guibg=black gui=NONE
hi Search guifg=#fcefba guibg=black gui=NONE
hi Visual guifg=#fcefba guibg=black gui=NONE
hi Directory guifg=#fcefba guibg=black gui=bold
hi Title guifg=#fcefba guibg=black gui=bold
hi markdownHeadingDelimiter guifg=#fcefba guibg=black gui=bold
hi markdownHeadingRule guifg=#fcefba guibg=black gui=bold
hi markdownLinkText guifg=#fcefba guibg=black gui=underline
hi Todo guifg=#fcefba guibg=black gui=bold
hi Pmenu guifg=#fcefba guibg=black gui=NONE
hi PmenuSel guifg=black guibg=#fcefba gui=NONE
hi helpSpecial guifg=#fcefba guibg=black gui=NONE
hi helpHyperTextJump guifg=#fcefba guibg=black gui=underline
hi helpNote guifg=#fcefba guibg=black gui=NONE
hi vimOption guifg=#fcefba guibg=black gui=NONE
hi vimGroup guifg=#fcefba guibg=black gui=NONE
hi vimHiClear guifg=#fcefba guibg=black gui=NONE
hi vimHiGroup guifg=#fcefba guibg=black gui=NONE
hi vimHiAttrib guifg=#fcefba guibg=black gui=NONE
hi vimHiGui guifg=#fcefba guibg=black gui=NONE
hi vimHiGuiFgBg guifg=#fcefba guibg=black gui=NONE
hi vimHiCTerm guifg=#fcefba guibg=black gui=NONE
hi vimHiCTermFgBg guifg=#fcefba guibg=black gui=NONE
hi vimSynType guifg=#fcefba guibg=black gui=NONE
hi vimCommentTitle guifg=#fcefba guibg=black gui=italic
