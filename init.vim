
set nocompatible              " be iMproved, required
filetype off                  " required
set encoding=UTF-8

if !exists('g:vscode')
  " A few basics
  set mouse=a
  set number relativenumber

  set list
  set listchars=tab:›\ ,eol:¬,trail:⋅

  :nnoremap <Tab> :bnext<CR>
  :nnoremap <S-Tab> :bprevious<CR>

  " Vundle (Package manager)
  " set the runtime path to include Vundle and initialize
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  " let Vundle manage Vundle, required
  Plugin 'VundleVim/Vundle.vim' " Vim package bundler
  Plugin 'junegunn/goyo.vim' " Zen mode
  Plugin 'junegunn/limelight.vim' " Greys out areas of code you're not looking at
  Plugin 'tpope/vim-fugitive' " git support
  Plugin 'tpope/vim-commentary' " Comment stuff out!
  Plugin 'derekwyatt/vim-scala' " Syntax highlighting and import sorting
  Plugin 'vim-airline/vim-airline' " Status bar
  Plugin 'vim-airline/vim-airline-themes' " Themes for the airline status bar
  " Plugin 'scrooloose/nerdtree' " Folder tree view
  " Plugin 'Xuyuanp/nerdtree-git-plugin' " Git extension for nerdtree
  Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy finder
  Plugin 'junegunn/fzf.vim'  " General fuzzy finder
  Plugin 'joshdick/onedark.vim' " NeoVim theme
  Plugin 'sheerun/vim-polyglot' " General language support / syntax highlighting
  Plugin 'neoclide/coc.nvim', {'branch': 'release'} " 'Conquer of Completion' - the thing being used to drive Scala metals
  Plugin 'Yggdroot/indentLine'
  " Plugin 'mg979/vim-visual-multi', {'branch': 'master'} " Multi cursor support
  Plugin 'mcchrish/nnn.vim' " Alternate filemanager to NERDTree.
  Plugin 'junegunn/rainbow_parentheses.vim' " Rainbow brackets
  " All of your Plugins must be added before the following line
  call vundle#end()            " required
  filetype plugin indent on    " required

  "--------------------------------
  " nnn

  " Disable default mappings
  let g:nnn#set_default_mappings = 0

  " Opens the nnn window in a split
  " let g:nnn#layout = 'tabnew' " or vnew, tabnew etc.

  " Or pass a dictionary with window size
  " let g:nnn#layout = { 'left': '~25%' } " or right, up, down

  " Floating window (neovim latest and vim with patch 8.2.191)
  let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }
  " let g:nnn#layout = 'tabedit'

  " Start nnn in the current file's directory
  nnoremap <leader>n :NnnPicker %:p:h<CR>

  "--------------------------------
  " FZF
  let g:fzf_buffers_jump = 1 " Use existing buffers when a file is already open

  "--------------------------------
  " Aitline status and tabs
  let g:airline_theme='onedark'

  " tabs
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline#extensions#tabline#formatter = 'unique_tail'

  "--------------------------------
  " Rainbow parentheses
  autocmd FileType scala RainbowParentheses

  "--------------------------------
  " Vim Commentary
  autocmd FileType scala setlocal commentstring=//\ %s
  autocmd FileType sbt setlocal commentstring=//\ %s

  "--------------------------------
  " IndentLine
  let g:indentLine_leadingSpaceEnabled = 1
  let g:indentLine_leadingSpaceChar = '·'

  "--------------------------------
  " NerdTree settings
  " let g:NERDTreeChDirMode = 2  " Change cwd to parent node
  " let g:NERDTreeMinimalUI = 1  " Hide help text
  " let g:NERDTreeAutoDeleteBuffer = 1
  " let NERDTreeShowHidden = 1
  " nnoremap <leader>n :NERDTreeToggle<CR>
  " nnoremap <leader>N :NERDTreeFind<CR>
  " let g:NERDTreeIndicatorMapCustom = {
  "             \ "Modified"  : "✹",
  "             \ "Staged"    : "✚",
  "             \ "Untracked" : "✭",
  "             \ "Renamed"   : "➜",
  "             \ "Unmerged"  : "═",
  "             \ "Deleted"   : "✖",
  "             \ "Dirty"     : "✗",
  "             \ "Clean"     : "✔︎",
  "             \ 'Ignored'   : '☒',
  "             \ "Unknown"   : "?"
  "             \ }

  "--------------------------------
  " Netrw
  " let g:netrw_liststyle = 3
  " let g:netrw_browse_split = 3
  " let g:netrw_winsize = 25 " 25% of the page width

  "--------------------------------
  " Goyo
  let g:goyo_linenr = 1
  let g:goyo_width = 120
  let g:goyo_height = 100

  "--------------------------------
  " Line numbers
  set number
  set signcolumn=yes

  "--------------------------------
  " Configuration for vim-scala
  au BufRead,BufNewFile *.sbt set filetype=scala

  "--------------------------------
  " Syntax highlighting and theme
  let g:airline_theme='onedark'
  syntax on
  colorscheme onedark

  "Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
  "If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
  "(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
  if (empty($TMUX))
    if (has("nvim"))
      "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
      let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
      set termguicolors
    endif
  endif

  "--------------------------------
  " Scala Metals
  " Smaller updatetime for CursorHold & CursorHoldI
  set updatetime=300

  " don't give |ins-completion-menu| messages.
  set shortmess+=c

  " always show signcolumns
  set signcolumn=yes

  " Some server have issues with backup files, see #649
  set nobackup
  set nowritebackup

  " Better display for messages
  set cmdheight=2

  " Use <c-space> for trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use `[c` and `]c` for navigate diagnostics
  nmap <silent> [c <Plugin>(coc-diagnostic-prev)
  nmap <silent> ]c <Plugin>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Remap for do codeAction of current line
  nmap <leader>ac <Plug>(coc-codeaction)

  " Remap for do action format
  nnoremap <silent> F :call CocAction('format')<CR>

  " Use K for show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
  	if &filetype == 'vim'
  		execute 'h '.expand('<cword>')
  	else
  		call CocAction('doHover')
  	endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)

  " Show all diagnostics
  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " Find symbol of current document
  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

  " Notify coc.nvim that <enter> has been pressed.
  " Currently used for the formatOnType feature.
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
  			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Toggle panel with Tree Views
  nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
  " Toggle Tree View 'metalsBuild'
  nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
  " Toggle Tree View 'metalsCompile'
  nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
  " Reveal current current class (trait or object) in Tree View 'metalsBuild'
  nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsBuild<CR>

  " End of Scala Metals
  "-------------------------------------
endif
