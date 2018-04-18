"-------------------------------------------------------------------------------
" Filename:      my_os_test.vim
" Last modified: Fri Jun 30, 2017 21:52 -0400
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
" Dependencies:  n/a.
"-------------------------------------------------------------------------------
" This sets the global variable "g:my_os" to the current OS value for later
" parsing in other vim scripts.
" Execute first in vimrc file via "source": source ~/.vim/my_os_test.vim
if exists("g:my_os")
    echom g:my_os
else
    if has('win32')
        let g:my_os = "Windows"
    elseif has('win32unix')
        let g:my_os = "Cygwin"
    elseif has('win64')
        let g:my_os = "Windows"
    elseif has('win95')
        let g:my_os = "Windows"
    elseif has('unix')
        let g:my_os = substitute(system('uname'), '\n', '', '')
    elseif has('mac') || has('macunix') || has('osx')
        let g:my_os = "Mac"
    else
        let g:my_os = "UNKNOWN"
    endif
endif

" This is a test to see if vim is running in a 'work' environment (generally Windows)
" as some of my settings are different at work than at home--and I generally have
" to use a Windows in guest Virtualbox to gain VPN access to work from home. I have
" found the most effective way to test is to check the user logon account as I use
" my first name at home, and am pretty much guaranteed NEVER to have that as a 
" aork logon.  So if $USERNAME = 'arnold', I am at home.
if !exists('g:at_work')
    if exists('$USERNAME')
        if $USERNAME =~? 'arnold'
            let g:at_work = 0
        else
            let g:at_work = 1
        endif
    endif
endif
