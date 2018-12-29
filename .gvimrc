"-------------------------------------------------------------------------------
" Filename:      .gvimrc
" Last modified: Tue Jun 05, 2018 22:34:10 -0400
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
"                In Linux, this file will be: "/home/<username>/.gvimrc".
"                In Windows, this file will be: "C:\Users\<username>\_gvimrc"
"
" Dependencies:  n/a
"-------------------------------------------------------------------------------

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500
  " I like highlighting strings inside C comments
    let c_comment_strings=1
  " Switch on syntax highlighting if it wasn't on yet.
    if !exists("syntax_on")
        syntax on
    endif
  " Switch on search pattern highlighting.
    set hlsearch
  " Set nice colors
    highlight Normal    guibg=white
    highlight Cursor    guibg=Green guifg=NONE
    highlight lCursor   guibg=Cyan  guifg=NONE
    highlight NonText   guibg=white
    highlight Constant  gui=NONE    guibg=white
    highlight Special   gui=NONE    guibg=grey95
endif

set mousehide                " Turn off mouse when typing
set guioptions+=T            " Include (+)/Exclude (-) toolbar
set guioptions+=c            " Use console dialogs when possible
set guioptions-=r            " Remove (-) right hand scrollbar
set guioptions-=L            " Remove (-) left-hand scrollbar (for v-split)
set visualbell t_vb=         " Turn off flashing (needs to be in gvimrc too)
" set guicursor=a:blinkon0   " turn off cursor blinking
set guicursor=a:blinkon600-blinkoff400  " Slow down cursor blinking speed

" Reference: http://vim.wikia.com/wiki/Maximize_or_set_initial_window_size
" Note: in using variable to set number ONCE, you must use "execute" command,
" quote the string  portion of command, use period to concatenate variable.
"Use global variables (g:name) 
if g:my_os ==? "Windows"
    if g:at_work
        let g:lines=50
        let g:columns=160
        set guifont=Lucida_Console:h10:cANSI
    elseif exists('$COMPUTERNAME')
        if $COMPUTERNAME ==? "MYLENOVO"
            let g:lines=50
            let g:columns=160
            set guifont=Lucida_Console:h12:cANSI
        endif
    else
        let g:lines=40
        let g:columns=150
    endif
elseif g:my_os ==? "Linux"
    set guifont=Source\ Code\ Pro\ Regular\ 11
    let g:lines=35
    let g:columns=130
else
    let g:lines=35
    let g:columns=130
endif

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
    :execute "set lines=".g:lines
    :execute "set columns=".g:columns
else
  " This is console Vim.
    if exists("+lines")
        :execute "set lines = " . g:lines
    endif
    if exists("+columns")
        :execute "set columns = " . g:columns
    endif
endif

