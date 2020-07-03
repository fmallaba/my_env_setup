set completeopt+=preview

nnoremap <S-J> <C-W><C-J>
nnoremap <S-K> <C-W><C-K>
nnoremap <S-L> <C-W><C-L>
nnoremap <S-H> <C-W><C-H>


set guioptions+=a
set clipboard=unnamedplus

set autochdir
set number

set tabstop=4

set shiftwidth=4
set softtabstop=4
set expandtab
set nocompatible

set autoindent
set cindent
set cino+=g+1

hi Normal guibg=NONE ctermbg=NONE

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'bling/vim-airline'

Plugin 'ekalinin/Dockerfile.vim'

Plugin 'majutsushi/tagbar'

Plugin 'scrooloose/nerdcommenter'

Plugin 'octol/vim-cpp-enhanced-highlight'

Plugin 'vim-scripts/highlight.vim'

Plugin 'NLKNguyen/papercolor-theme'

"Plugin 'vim-scripts/Conque-GDB'

"Plugin 'terryma/vim-multiple-cursors'

"Plugin 'scrooloose/nerdtree'

"Plugin 'flazz/vim-colorschemes'

"Plugin 'wting/rust.vim'

"Plugin 'tpope/vim-surround'
"Plugin 'tpope/vim-repeat'
"Plugin 'vim-scripts/YankRing.vim'

"Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'tomtom/tlib_vim'
"Plugin 'garbas/vim-snipmate'
"Plugin 'honza/vim-snippets'


"Plugin 'derekwyatt/vim-fswitch'

"Plugin 'Valloric/YouCompleteMe'

"Plugin 'scrooloose/syntastic'

"Plugin 'a.vim'

"Plugin 'Rip-Rip/clang_complete'

"Plugin 'tpope/vim-fugitive'

"Plugin 'kien/ctrlp.vim'


"Plugin 'xolox/vim-easytags'
"Plugin 'xolox/vim-misc'

"Plugin 'justinmk/vim-syntax-extra'
"Plugin 'tommcdo/vim-exchange'

call vundle#end()
filetype plugin indent on


syntax enable
set background=light
colorscheme PaperColor
"colorscheme monokai
"colorscheme blink
"colorscheme solarized


"let g:clang_library_path="/usr/lib/llvm-version/lib"
"let g:ycm_keep_logfiles = 1
"let g:ycm_log_level = 'debug'
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

imap <C-\> <Plug>snipMateNextOrTrigger
imap <C-\> <Plug>snipMateNextOrTrigger




vnoremap <S-Q> :set nu!<CR>
nnoremap <S-Q> :set nu!<CR>

vnoremap qg :call QuickGrep()<CR>


vnoremap <S-Y> "+y
vnoremap <S-O> "+p
nnoremap <S-O> "+p

vmap // :call VisualSearch()<CR>:hi Search ctermbg=57<CR>:set hlsearch<CR>

map <A-right> :bn<CR>
map <A-left> :bp<CR>


function! VisualSearch()
	normal gv"xy
	let var = ''.@x
	let var = EscapeSymbols(var)
	let @/ = var
    exe 'normal /'.var
endfunction


function! QuickGrep()
	normal gv"xy
	let var = ''.@x
	let var = EscapeSymbols(var)
	let var = '"'.var.'"'
    call call("GrepPlain", ['-I',var, '.'])
endfunction


vnoremap <F9> :set glsearch!<CR>
nnoremap <F9> :set hlsearch!<CR>

set t_Co=256

set tabstop=4

set guifont=Liberation_Mono_for_Powerline:h10

set guifont=Liberation\ Mono\ for\ Powerline\ 10

let g:airline_powerline_fonts = 1

let g:Powerline_symbols = 'fancy'


au BufNewFile,BufRead *.patch set filetype=patch
au BufNewFile,BufRead *.grep set filetype=grep

let g:airline#extensions#tabline#enabled = 1

function! GotoFileWithLineNum()
	" filename under the cursor
	let file_name = expand('<cfile>')
	if !strlen(file_name)
		echo 'NO FILE UNDER CURSOR'
		return
	endif

	" look for a line number separated by a :
	if search('\%#\f*:\zs[0-9]\+')
		" change the 'iskeyword' option temporarily to pick up just numbers
		let temp = &iskeyword
		set iskeyword=48-57
		let line_number = expand('<cword>')
		exe 'set iskeyword=' . temp
	endif

	" edit the file
	exe 'e '.file_name

	" if there is a line number, go to it
	if exists('line_number')
		exe line_number
	endif
endfunction

map gf :call GotoFileWithLineNum()<CR>
map gsf :sp<CR>:call GotoFileWithLineNum()<CR>


set foldmethod=syntax
set foldlevelstart=1
let xml_syntax_folding=1

au BufRead * normal zR

au FocusLost * silent! echo 3



function! GrepFiltered(...)

	let grep_result_file = "/tmp/vim_search_".system('echo $RANDOM')
	let grep_result_file = substitute(grep_result_file,'.\{1}$' , '', "")
	let grep_result_file .= ".grep"

	exe 'silent ! touch '.grep_result_file
	exe 'silent ! chmod 777 '.grep_result_file

	let grep_cmd= 'silent ! grep -r -n '

	let prev
	let cur
	let case_sensitive = 1

	for arg in a:000
		let prev = cur
		let cur = arg
		if cur == '-i'
			let case_sensitive = 0
		endif
		let grep_cmd .= arg.' '
	endfor

	let grep_cmd .= ' | tee -a '.grep_result_file
	exe grep_cmd

	exe 'e '.grep_result_file
	exe 'redraw!'

	let pattern = 'normal /'
	if !case_sensitive
		let pattern .= '\c'
	endif
	let prev = substitute(prev,'^"' , '', "")
	let prev = substitute(prev,'"$' , '', "")
	let prev = EscapeSymbols(prev)
	let prev = substitute(prev, '\\.\\\*', '.*', "g")
	let pattern .= prev."\<CR>"
	exe pattern
	exe '"<CR>'
	exe 'set hlsearch'
	exe 'hi Search ctermbg=57'
	exe 'normal 0'
endfunction


function! MyFunc(...)
	for arg in a:000
        echo 'hello' 
        echo arg
	endfor

	exe 'normal 0'
endfunction

command! -nargs=+ MyCOM call MyFunc(<f-args>)

function! EscapeSymbols(...)
	let str = a:1
	for esc in ['\/','\^','\$','\.','\*','\~','\[...]','\[^...]','&']
		let str = substitute(str, esc, '\\'.esc, "g")
	endfor
	return str
endfunction



function! Wrand(...)
	exe 'w /tmp/vim_tmp_'.system('echo $RANDOM')
endfunction

function! Write(...)
	if a:0 == 0
		exe 'w %'
	else
		exe 'w '.a:1
	endif
endfunction


function! Qu(...)
	exe 'q!'
endfunction

command! -nargs=? W call Write(<f-args>)
command! -nargs=? WR call Wrand(<f-args>)
command! -nargs=? Q call Qu(<f-args>)
command! -nargs=? GG call GrepGrep(<f-args>)








function! GrepGrep(...)
	let lines = split(join(getline(1,'$'),"\n"),"\n")
	let dict = {}
	for l in lines
		let f = substitute(l,':.*$','',"")
		let dict[f] = ''
	endfor
	let params = [' -d skip ']
	let params = params + a:000
	let files  = join(keys(dict),' ')
	let params = params + [files]
	call call ("GrepFiltered", params)
endfunction


function! GrepPlain(...)
	call call ("GrepFiltered", a:000)
endfunction

function! GrepJava(...)
	call call ("GrepFiltered", a:000)
endfunction


function! GrepH(...)
	call call ("GrepFiltered", a:000)
endfunction


function! GrepC(...)
	call call ("GrepFiltered", a:000)
endfunction


function! GrepCpp(...)
	call call ("GrepFiltered", a:000)
endfunction

function! GrepSh(...)
	call call ("GrepFiltered", a:000)
endfunction

function! GrepSrc(...)
	call call ("GrepFiltered", a:000)
endfunction

function! GrepRust(...)
	call call ("GrepFiltered", a:000)
endfunction

function! GrepBuffer(...)
	let search = a:1
	let search = substitute(search,'^"' , '', "")
	let search = substitute(search,'"$' , '', "")
	let search = EscapeSymbols(search)
	exe 'normal! qaq'
	exe 'g/'.search.'/y A'
	exe 'e /tmp/vim_tmp_'.system('echo $RANDOM')
	normal! "ap2dk
	exe 'w'

endfunction

command! -nargs=+ GREPBuffer call GrepBuffer(<f-args>)
command! -nargs=+ GREP call GrepPlain('--exclude-dir=.hg',<f-args>)
command! -nargs=+ GREPC call GrepC('--include=*.c ', <f-args>)
command! -nargs=+ GREPSh call GrepSh('--include=*.sh ', <f-args>)
command! -nargs=+ GREPCpp call GrepCpp('--include=*.cpp ', <f-args>)
command! -nargs=+ GREPH call GrepH('--include=*.{h,hh,hpp} ', <f-args>)
command! -nargs=+ GREPSrc call GrepSrc('--include=*.{java, c, cpp, rs, h, hh, hpp} ', <f-args>)
command! -nargs=+ GREPRust call GrepRust('--include=*.rs ', <f-args>)
command! -nargs=+ GREPJava call GrepJava('--include=*.java ', <f-args>)

map <F3> :qa<CR>
map <F4> :wq<CR>
map <F6> :w<CR>

nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F5> :TagbarToggle<CR>

"set rtp+=~/.fzf
autocmd BufEnter *.cc :setlocal filetype=cpp
