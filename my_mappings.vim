"-------------------------------------------------------------------------------
" Filename:      my_mappings.vim
" Last modified: Mon Sep 18, 2017 00:07:48 -0400
" Version:       1.0
" Author:        Arnold Hausmann <aehjr1@gmail.com>
" License:       This program is free software; you can redistribute it
"                and/or modify it under the terms of the GNU General Public
"                License as published by the Free Software Foundation,
"                version 2 of the License.
"                This program is distributed in the hope that it will be
"                useful, but WITHOUT ANY WARRANTY; without even the implied
"                warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
"                PURPOSE.
"                See the GNU General Public License version 2 for more details.
" Configuration: This program is designed for either Linux or Windows (v. 7+).
"                It may, MAY be useful in the Mac environment; no guarantee is
"                made.
"
" Dependencies:  Global variable "g:my_os"; this is created in the vimrc script
"                (".vimrc" or "_vimrc") via script file "my_os_test.vim".
"                Global variable "g:my_vim_path", also created in the vimrc script.
"-------------------------------------------------------------------------------

" 2017-06-25: Set up Sections for Linux-specific mappings.
if g:my_os ==? "Linux"
    " Note: these are basically all the mappings I use for editing HTML files, done only at home.
    " The CSS file mappings are useless to anyone but me, however the other mappings could be.
    " The same is true with the function calls, designed for editting specific web site articles.
    " Other mappings generally replace Windows-style special characters with their HTML numeric
    " entity counterparts.
    nnoremap rcss :r ~/CSS/inline.css<CR>
    nnoremap <leader>rcss :-1r ~/CSS/inline.css<CR>
    nnoremap thcss :r ~/CSS/THinline.css<CR>
    nnoremap rpcss :r ~/CSS/Prelutsky.css<CR>
    nnoremap rsub :r ~/CSS/subset.css<CR>
    nnoremap FHE# :call MyHEFormat()<CR>
    nnoremap NTH# :call NewTHFormat()<CR>
    nnoremap sub>' :%s/’/\&#8217;/gc<CR>
    nnoremap sub<' :%s/‘/\&#8216;/gc<CR>
    nnoremap sub<" :%s/“/\&#8220;/gc<CR>
    nnoremap sub>" :%s/”/\&#8221;/gc<CR>
    nnoremap sub-- :%s/—/\&#8212;/gc<CR>
    nnoremap subdd :%s/\s\{0,1\}--\s\{0,1\}/\&#8212;/gc<CR>
    nnoremap sub-. :%s/–/\&#8211;/gc<CR>
    nnoremap sub.. :%s/…/\&#8230;/gc<CR>
    nnoremap sub.> :%s/\.\.\./\&#8230;/gc
    nnoremap sub.& :%s/ & / \&#38; /gc<CR>
    nnoremap subpp :%s/\s*<\(\/\)*\([pP]\)>\s*<\(\/\)*\([pP]\)>\s*/ <\/\2>\r\r<\4>/gc
    nnoremap subpP :%s/ *<\/P><P> */ <\/P>\r\r<P>/gc
    nnoremap subep :%s/^\(<p>.*\)$/\1 <\/p>/c
    nnoremap subeP :%s/^\(<P>.*\)$/\1 <\/P>/c
    nnoremap subsp :%s/\(<\/[pP]>\)$/ \1/c
    nnoremap subbp :., s/^\( *$\)\@!/<p>/c
    nnoremap subes :%s/\(\W\)\s*\(<\/[pP]>\)/\1 \2/cg
    nnoremap subbr :s/ *<br> *<br>/ <\/p>\r\r<p>/gc
endif

" Set up mapping to call function to toggle showing trailing white space.
nnoremap <silent> <Leader>w :call ToggleShowTS()<CR>
" mapping to delete trailing spaces.
nnoremap <silent> <Leader>dw :%s/\s\+$//c<CR>

" These mappings force searches to use "normal" regexs instead of vim regex.
nnoremap / /\v
vnoremap / /\v
" This mapping opens a new vertical split window.
nnoremap <C-S> <C-w>v
" These mappings use h/l to move left/right between split windows.
noremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" These mappings use j/k to move down/up between split windows.
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" This mapping to cycle to next split window
nnoremap <C-Right> <C-w>w
" This mapping to cycle to next split window and maximize
nnoremap <C-Left> <C-w>w<C-w>\|
" This mapping to set left/right split windows equal size
nnoremap <leader>= <C-w>=

" 20130907: More from Steve Losh: Learn Vimscript the Hard Way.
" split vertically, load the .vimrc into buffer
nnoremap <leader>sv :split $MYVIMRC<cr>
nnoremap <leader>vv :vsplit $MYVIMRC<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
" split vertically, load ~/.vim/my_mappings.vim into buffer
" 2017-06-25: Use generic path; must use execute to do this.
" nnoremap <leader>sm :split ~/.vim/my_mappings.vim<cr>
" nnoremap <leader>vm :vsplit ~/.vim/my_mappings.vim<cr>
" nnoremap <leader>em :e ~/.vim/my_mappings.vim<cr>
nnoremap <leader>sm :execute "split " . g:my_vim_path . "my_mappings.vim"<cr>
nnoremap <leader>vm :execute "vsplit " . g:my_vim_path . "my_mappings.vim"<cr>
nnoremap <leader>em :execute "edit " . g:my_vim_path . "my_mappings.vim"<cr>
" split vertically, load ~/.vim/my_functions.vim into buffer
" nnoremap <leader>sf :split ~/.vim/my_functions.vim<cr>
" nnoremap <leader>vf :vsplit ~/.vim/my_functions.vim<cr>
" nnoremap <leader>ef :e ~/.vim/my_functions.vim<cr>
nnoremap <leader>sf :execute "split " . g:my_vim_path . "my_functions.vim"<cr>
nnoremap <leader>vf :execute "vsplit " . g:my_vim_path . "my_functions.vim"<cr>
nnoremap <leader>ef :execute "edit " . g:my_vim_path . "my_functions.vim"<cr>
" Open Quickfix window
nnoremap <silent><leader>co :copen<CR>
" Close Quickfix window
nnoremap <silent><leader>cc :cclose<CR>
" Source current file (only)
" nnoremap <silent><leader>so :source %<CR>

" 20131021: CTRL-n to toggle NERDTree
" 2017-09-16: do NOT use NerdTree anymore
" nnoremap <silent> <C-n> :NERDTreeToggle<CR>
" 20140125: F5 to toggle spell-check
nnoremap <silent> <F5> :setlocal spell! spelllang=en_us<CR>

" 2015-11-15: <leader>at to toggle Airline status bar with regular status bar
nnoremap <leader>at :AirlineToggle<CR>

nnoremap <silent> ;/ :nohlsearch<CR>
nnoremap <silent> revim :source $MYVIMRC<CR>
" 20160328: REVISED: C-U to uppercase current word, A-U to lowercase, both have temp messages.
" 2016-04-06: changed to use new function to perform both.
nnoremap <c-u> :call ChangeWordCase("UPPER")<CR>
nnoremap <a-u> :call ChangeWordCase("lower")<CR>
" 2017-08-04: Add Insert Mode Case toggle for last word entered, leaving in Insert mode
inoremap <c-u> <esc>g~awea
nnoremap <silent> <C-F12> :set relativenumber!<cr>
nnoremap <silent> <C-F11> :set number!<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
" 2017-09-16: Use <leader> instead as "ga" to valuable to lose.
xmap <Leader>ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <Leader>ga <Plug>(EasyAlign)

"nnoremap <F2> :cd /home/arnold/winDocs <CR>
"nnoremap lp# :cd /data/arnold/Politics<CR>sr
nnoremap lp# :call MyPolitics()<CR>
" nnoremap <leader>lp :lcd $HOME/data/arnold/Politics <bar> :CtrlPDir $HOME/data/arnold/Politics<c-x>
" nnoremap <leader>lp :cd $HOME/data/arnold/Politics<CR>
nnoremap <leader>lp :call CtrlPPolitics()<CR>
" Find special characters (basically any unicode)
nnoremap fsc# /[^ -~	]<CR>
nnoremap subM  :call MyNoEms()<CR>
nnoremap subnb :%s/&nbsp;//gc
nnoremap subnbs :%s/&nbsp;/ /gc<CR>
nnoremap subNB :call MyNoNbsp()<CR>
nnoremap <silent> <C-E> :call ToggleVExplorer()<CR>
nnoremap <silent> <F11> :call ToggleFoldAll()<CR>
nnoremap <silent> <Leader><space> za
nnoremap <leader>dv :call MyDivision()<CR>
nnoremap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>
nnoremap <silent> <leader>dt "=strftime('%Y-%m-%d')<CR>p
vnoremap <silent> <leader>dt "=strftime('%Y-%m-%d')<CR>p
inoremap <silent> <leader>dt <C-R>=strftime('%Y-%m-%d')<CR>
nnoremap <silent> <leader>dts "=strftime('%Y-%m-%d %H:%M:%S')<CR>p
vnoremap <silent> <leader>dts "=strftime('%Y-%m-%d %H:%M:%S')<CR>p
inoremap <silent> <leader>dts <C-R>=strftime('%Y-%m-%d %H:%M:%S')<CR>
inoremap <leader>2day <C-R>=strftime("%A")<CR>,<space>
nnoremap <leader>2day "=strftime("%A")<CR>PA,<space>

nnoremap <silent><leader>rdate :call ReplaceDateTag()<CR>
nnoremap <leader>lm :call LastModified()<CR>
nnoremap <leader>pb :CtrlPBuffer<CR>
nnoremap <leader>pm :CtrlPMRU<CR>
nnoremap <F7> :GoldenRatioToggle<CR>
"nnoremap <leader>sb :set scrollbind!
" 2016-03-15: Add mapping for scroll binding.
" From : https://gist.github.com/kshenoy/5661878
nnoremap <silent> <leader>sb :call ScrollBind()<CR>

"2016-03-20: Map command to display syntax highlighting settings to buffer.
nnoremap <leader>hitest :$VIMRUNTIME/syntax/hitest.vim

" 2016-03-25: Call the "sytax inspector". With cursor on word, find the syntax for the word.
nnoremap <C-S> :call SynStack()<CR>

" 2016-03-25: add code for remapping hexHighlight if exists
if exists('*HexHighlight()')
   nmap <leader>hh :call HexHighlight()<Return>
endif

" 2016-03-26: Add toggle for Undotree, Ctrl-F5
nnoremap <C-F5> :UndotreeToggle<CR>

" 2016-04-01: Add Obsession mappings
nnoremap <leader>so :OpenSession<CR>
nnoremap <leader>ss :SaveSession
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

vnoremap <expr> ++ VMATH_YankAndAnalyse()
nnoremap        ++ vip++

" 2016-11-14: Mapping for vim-schlepp, a better version of dragvisuals.
" NOTE: due to the nature of plugins, CANNOT use noremap feature, but MUST keep as "vmap".
" See:  https://github.com/zirrostig/vim-schlepp
"       http://stackoverflow.com/questions/18546533/execute-plug-commands-in-vim
" Help: ":h schlepp"
if !exists("g:loaded_schlepp")
    let g:loaded_schlepp = 1
    vmap <unique> <up> <Plug>SchleppUp
    vmap <unique> <down> <Plug>SchleppDown
    vmap <unique> <left> <Plug>SchleppLeft
    vmap <unique> <right> <Plug>SchleppRight
    vmap <unique> <S-up> <Plug>SchleppIndentUp
    vmap <unique> <S-down> <Plug>SchleppIndentDown
    vmap <unique> D <Plug>SchleppDup
endif

" 2017-01-13: Mapping to move all open buffers to tabs--finally copied from work.
nnoremap <leader>bt :tab sball<cr>
"
" 2017-01-13: Add map to simple function to toggle autowrapping text.
nnoremap <leader>aw :call AutoWrapToggle()<CR>

" 2017-04-12: Add mapping to insert absolute path of current buffer file.
inoremap <leader>path <c-r>=expand("%:p:h")<cr>
" 2017-04-14: Add mapping to toggle cursorcolumn
nnoremap <silent><c-f2> :set cursorcolumn!<cr>

" 2017-01-13: Add map to simple function to toggle autowrapping text.
nnoremap <leader>aw :call AutoWrapToggle()<CR>
inoremap <leader>aw :call AutoWrapToggle()<cr>
nnoremap <leader>sql :set ft=sql<cr>

" 2017-04-12: Add mapping to insert absolute path of current buffer file.
inoremap <leader>path <c-r>=expand("%:p:h")<cr>

" 2017-04-30: Add input mode mapping for days of the week.
inoremap <silent><leader>Mon Monday
inoremap <silent><leader>Tue Tuesday
inoremap <silent><leader>Wed Wednesday
inoremap <silent><leader>Thu Thursday
inoremap <silent><leader>Fri Friday
inoremap <silent><leader>Sat Saturday
inoremap <silent><leader>Sun Sunday

" 2017-06-25: Syncing up Windows and Linux versions of the script.
nnoremap <leader>sf :syntax on<cr><bar>:syntax sync fromstart<cr><bar>:redraw!<cr>
nnoremap <leader>mc 0R/*<esc>A */<esc>
nnoremap <silent><c-f2> :set cursorcolumn!<cr>
nnoremap <silent><leader>slc :normal 0i/*  */<esc>2hi
inoremap <silent><leader>slc <C-O>0<esc>i/*  */<esc>2hi

" 2017-07-12: Add better mapping for UltiSnipsEdit
nnoremap <silent> <leader>esnip :UltiSnipsEdit<cr>

" 2017-09-14: Suggested by Drew Neil, http://vimcasts.org/episodes/how-to-fold/
" {{{
" nnoremap <space> za
" nnoremap <expr> <s-space> foldlevel(".") > 0 ? 'za' : ':normal <Nop>'
" nnoremap <s-space> :if (foldlevel(".") > 0) | :normal za | :endif
" }}}

" 2017-09-17: F12 to toggle list settings.
nnoremap <silent><f12> :set list!<cr>
