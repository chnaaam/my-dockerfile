" =========================================================================
" Plugin
call plug#begin('~/.vim/plugged')


Plug 'preservim/nerdtree'	" NERDTree
Plug 'vim-airline/vim-airline' " 상태바
Plug 'vim-airline/vim-airline-themes' " 상태바 테마
Plug 'sainnhe/sonokai' "테마
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/syntastic'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


" =================================================================================
" jk 와 kj 를 <ESC> 키로 맵핑
inoremap jk <ESC>
inoremap kj <ESC>

" <F12> 을 통해 NERDTree 열기
nnoremap <silent><F12> :NERDTreeToggle<CR>

" <Ctrl + j, k> 를 눌러서 이전, 다음 버퍼로 전환
function! PrevBufferTab()
    bprev
    if &buftype == 'terminal'
        bprev
    endif
endfunction

function! NextBufferTab()
    bnext
    if &buftype == 'terminal'
        bnext
    endif
endfunction

let mapleader=" "
nnoremap <silent><Leader>q :call PrevBufferTab()<CR>
nnoremap <silent><Leader>w :call NextBufferTab()<CR>
map <silent><C-s> :w<CR>
set number	"줄번호
set hlsearch	" 탐색 문자열 강조
set showtabline=2	" 항상 상단에 탭 라인을 출력한다.
set ruler
set clipboard=unnamedplus	" vim 과 OS 의 클립보드 동기화
set showmatch	" 괄호 짝을 강조한다.
set mouse=a	" 모든 마우스 기능을 사용
if has("syntax")
	syntax on	" 문법 강조
endif

set t_Co=256        "구문강조 색 변경
set tabstop=4
set shiftwidth=4
set expandtab
filetype indent on
set autoindent
set encoding=utf-8
set termguicolors
set cursorline
set splitbelow
let mapleader=" "
nnoremap <SPACE> <Nop>

highlight Normal guibg=NONE
highlight EndOfBuffer guibg=NONE

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent! loadview

autocmd CursorHold * silent call CocActionAsync('highlight')

" =================================================================================
" Theme
colorscheme sonokai
let g:sonokai_style = 'atlantis'
let g:sonokai_better_performance = 1

" =================================================================================
" NERDTree
let NERDTreeShowHidden = 1
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeWinSize=30
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <silent><F12> :NERDTreeToggle<CR><bar>:TagbarToggle <CR>

" =================================================================================
" airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_highlighting_cache = 1
let g:airline_powerline_fonts = 1
let g:airline_theme= 'powerline'
let g:airline_section_y = '' 
let g:airline_section_warning= '' "마지막 status창 사용 안함
set hidden

" ==================================================================================
" coc
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"


" ==================================================================================
" terminal
"autocmd VimEnter * terminal ++rows=10
"autocmd VimEnter * wincmd k

" ==================================================================================
" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
map <Leader>cc <plug>NERDComToggleComment
map <Leader>c<space> <plug>NERDComComment

" ==================================================================================
" python
au FileType python nmap <buffer> <F5> :!python3 %<CR>
