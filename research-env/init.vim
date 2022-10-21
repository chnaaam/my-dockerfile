"================================= Plugins ========================================
call plug#begin('~/.vim/plugged')

" 상태바
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" NERDTree
Plug 'preservim/nerdtree'

" 파일 탐색
Plug 'ctrlpvim/ctrlp.vim'

Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


" =================================================================================
" jk 와 kj 를 <ESC> 키로 맵핑
inoremap jk <ESC>
inoremap kj <ESC>


" <F12> 을 통해 NERDTree 와 Tagbar 열기
nnoremap <silent><F12> :NERDTreeToggle<CR><bar>:TagbarToggle <CR> 

" <Ctrl + h, l> 를 눌러서 이전, 다음 탭으로 이동
nnoremap <silent><C-[> :tabprevious<CR>
nnoremap <silent><C-]> :tabnext<CR>

" <Ctrl + j, k> 를 눌러서 이전, 다음 버퍼로 전환
nnoremap <silent><C-h> :bp<CR>
nnoremap <silent><C-l> :bn<CR>

" <Shift + h, l> 를 눌러서 현재 버퍼 삭제
nnoremap <silent><S-h> :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <silent><S-l> :bp<bar>sp<bar>bn<bar>bd<CR>

" <Ctrl + w> t 를 눌러서 커서를 NERDTree 로 옮기기
nnoremap <silent><C-w>t :NERDTreeFocus<CR>

" 탭 정지 = 8 칸마다
set tabstop=8
" 쉬프트 (<< 혹은 >>) 이동거리 8 칸
set shiftwidth=8

" 줄 번호를 표시한다.
set number

" 괄호 짝을 강조한다.
set showmatch

" 하위 디렉터리를 모두 path 에 추가한다.
" gf 명령어 사용 시 파일을 인식 가능
set path+=**

" 탐색 문자열 강조
set hlsearch

" 항상 상단에 탭 라인을 출력한다.
set showtabline=2

set ruler

if has('nvim')			" nvim 을 사용 중이라면
	set inccommand=nosplit	" nvim live %s substitute (실시간 강조)
endif

" vim 과 OS 의 클립보드 동기화
set clipboard=unnamedplus

" GUI-Color 를 사용 가능하도록 설정 (TrueColor)
" cterm 혹은 term 대신 gui 를 통해 색상을 설정할 수 있고
" 16,777,216 종류의 색상 표현 가능(기존 256)
set termguicolors

" 모든 마우스 기능을 사용
set mouse=a

" 문법이 존재하면
if has("syntax")
	" 문법 강조를 수행
	syntax on	
endif

colorschem dracula

highlight Normal guibg=NONE
highlight EndOfBuffer guibg=NONE
highlight LineNr guibg=NONE gui=bold guifg=white


" 윈도우를 나갈 때 뷰를 저장하고,
autocmd BufWinLeave *.c,*.h mkview

" 윈도우에 들어갈 땐 뷰를 로드한다. (커서위치 저장)
" silent! 는 loadview 중 발생하는 에러를 억압(suppress) 한다.
autocmd BufWinEnter *.c,*.h silent! loadview

" ------------------------------------
" vim-airline 설정
" ------------------------------------
" powerline-font 활성화
let g:airline_powerline_fonts = 1
" luna 테마 사용
let g:airline_theme = 'luna'
" tabline 에 파일명만 출력 되도록 설정
let g:airline#extensions#tabline#formatter = 'unique_tail'
" 창의 상단에 표시되도록 설정
" let g:airline_statusline_ontop = 1
" 탭라인 허용
let g:airline#extensions#tabline#enabled = 1
" 항상 tabline 을 표시
let g:airline#extensions#tabline#show_tabs = 1
" ------------------------------------
" NERDTree 설정
" ------------------------------------
" 창 크기(가로)를 20 으로 설정
let g:NERDTreeWinSize=30


" Intent Guide
let g:indent_guides_enable_on_vim_startup = 1

" NERDCommenter
let NERDSpaceDelims=1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" leader key remapping
let mapleader=" "
nnoremap <SPACE> <Nop>


" 마지막으로 수정된 곳에 커서를 위치함
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Python 실행
autocmd FileType python map <buffer> <C-S-R> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <C-S-R> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>