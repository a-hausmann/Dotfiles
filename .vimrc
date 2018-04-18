" Documentation {{{1
"-------------------------------------------------------------------------------
" Filename:      .vimrc
" Last modified: Sun Oct 01, 2017 20:38:15 -0400
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
"                It may,MAY be useful in the Mac environment; no guarantee is made.
"                In Linux, this file will be: "/home/<username>/.vimrc".
"                In Windows, this file will be: "C:\Users\<username>\_vimrc"
"
" Dependencies:  File "my_os_test.vim"; should always be placed in the "base"
"                vim files directory: ".vim" or "vimfiles" (Windows). This script
"                will determine the OS under which vim is running, and populate
"                global variable "g:my_os" with that value. This variable is used
"                in subsequent branching logic, and also in building a generic 
"                path to the vim subdirectory (".vim" or "vimfiles").
"-------------------------------------------------------------------------------
set nocompatible        " MUST BE first command as other options depend on it.

" Environment {{{1
"-------------------------------------------------------------------------------
" Environment setting section: Linux or Windows, home or work, etc.
"-------------------------------------------------------------------------------
" This section of code finds script "my_os_test.vim" and sources it to populate
" the global variable "g:my_os". If this code fails, the remainder will fail as
" well. This code also populates the global generic variable "g:my_vim_path" where
" other scripts and/or directories are located, and "g:at_work", a boolean.
let g:my_os_test = globpath(&rtp, "my_os_test.vim")
execute "source " . g:my_os_test
if g:my_os ==? "Windows"
    let g:my_slash = "\\"
    let g:dts_format = '%a %b %d, %Y %H:%M:%S'
elseif g:my_os ==? "Linux"
    let g:my_slash = "/"
    let g:dts_format = '%a %b %d, %Y %H:%M:%S %z'
endif
let g:my_vim_path = fnamemodify(g:my_os_test, ":p:h") . g:my_slash

"-------------------------------------------------------------------------------
" END: Environment setting section: Linux or Windows, home or work, etc.
"-------------------------------------------------------------------------------

" Plugin Management {{{1
"-------------------------------------------------------------------------------
" Plugin management section -- Vundle (https://github.com/VundleVim/Vundle.vim)
"-------------------------------------------------------------------------------

" 2013-10-17: now using Vundle (https://github.com/gmarik/vundle) to bundle plugins
" Must set filetype off to call Vundle
" 2017-06-24: Creating generic path to Vundle by using previously set OS-dependent variables.
filetype off
let g:vundle_path = g:my_vim_path . "bundle" . g:my_slash . "Vundle.vim"
" 2017-07-03: Windows peculiarity does NOT allow me to create dot-file, but will allow Vundle
" to create it when installing, so will have ".vim" folder containing ONLY bundle folder.
if g:my_os ==? "Windows"
    let g:vundle_path = substitute(g:vundle_path, "vimfiles", ".vim", "")
endif
execute "set runtimepath+=".g:vundle_path

" let Vundle manage Vundle; required!
" 2016-02-20: Change command "Bundle" to "Plugin"
" 2016-02-20: Path on GitHub changed from "gmarik" to "VundleVim"
" How to do local git repos (when working on plugin)
" Plugin 'file:///users/arnold/path/to/plugin'
call vundle#rc()
Plugin 'VundleVim/vundle.vim'
" 2015-02-20: remove html, this does not seem to be maintained in github.
" 2016-02-25: tried again as local file, get error during PluginInstall.
" 2016-03-13: Found the hard way that I CANNOT remove this line, else the
"             plugin will not load at all. Will have to live with the error
"             during PluginInstall
if g:my_os ==? "Linux" && ! g:at_work
    Plugin 'file://home/arnold/.vim/bundle/html/ftplugin/html'
endif

" 2017-09-15: Trying EasyAlign
Plugin 'junegunn/vim-easy-align'

Plugin 'bling/vim-airline'
Plugin 'vimscript/bash-support'
Plugin 'tpope/vim-fugitive'
Plugin 'git://github.com/tomtom/tplugin_vim.git'
Plugin 'vim-ctrlspace/vim-ctrlspace'
Plugin 'kien/ctrlp.vim'
Plugin 'd11wtq/ctrlp_bdelete.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-sleuth'
" 2017-10-01: Using airline, so no need for flagship, IMO
" Plugin 'tpope/vim-flagship'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-surround'
Plugin 'jiangmiao/auto-pairs'
Plugin 'roman/golden-ratio'
Plugin 'mbbill/undotree'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'kshenoy/vim-signature'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'godlygeek/tabular'
Plugin 'zirrostig/vim-schlepp'
Plugin 'christoomey/vim-titlecase'
" See URL https://github.com/haya14busa/incsearch.vim
Plugin 'haya14busa/incsearch.vim'
Plugin 'vim-scripts/sql_iabbr.vim'
Plugin 'vim-scripts/Teradata-13.10-syntax'
Plugin 'nelstrom/vim-visual-star-search'

Plugin 'a-hausmann/hexHighlight'
" 2017-07-09: Got UltiSnips working the way I do, see triggers below. Now load
" if directory exists.
" if g:my_os ==? "Linux"
if !empty(globpath(fnamemodify(g:vundle_path, ":h"), "ultisnips"))
    Plugin 'SirVer/ultisnips'
else
    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'tomtom/tlib_vim'
    Plugin 'garbas/vim-snipmate'
    Plugin 'honza/vim-snippets'
endif

" END OF VUNDLE
"call vundle#end()
" Turn filetype plugin back on
filetype plugin indent on

"-------------------------------------------------------------------------------
" END: Plugin management section -- Vundle (https://github.com/VundleVim/Vundle.vim)
"-------------------------------------------------------------------------------

" General Settings {{{1
"-------------------------------------------------------------------------------
" General vim settings
"-------------------------------------------------------------------------------
" use "visual bell" instead of beeping
set visualbell t_vb=
" Quickly time out on keycode, but never time out on mappings.
" Shut this one down too...kills performance on next processing in searches.
"set notimeout ttimeout ttimeoutlen=200
" Lines of history vim has to remember
set history=700         " keep lots of command history
" Don't redraw while executing macros (better performance)
" DO NOT DO THIS! Set lazyredraw nasty side-effect is not performing next/Next
" on searches well.
"set lazyredraw
" Regular expression magic
set magic                   " Can skip '\' sometimes.
set showmatch               " show matching brackets
set matchtime=2             " match blink rate (in .1 seconds)
" Text, tabs and indents
set tabstop=4               " # characters to show when Tab
set shiftwidth=4            " # characters to shift with "<", ">"
set softtabstop=4           " <BS> will backspace four spaces
set expandtab               " Replace tabs with spaces
set smarttab                " Use shiftwidth setting for inserting tabs
set linebreak               " Wrap lone lines at char in &breakat
set textwidth=500			" Insert newline after 500 characters
set autoindent              " Copy indentation from prev. line
set smartindent             " Will use syntax rules in indenting.
set wrap					" Wrap lines at end of window
set cmdheight=2             " Make command line two lines high
set mousehide               " Hides the mouse arrow when typing text
set hidden              " Hide buffer, required by Ctrl-Space.
set ignorecase          " ignore case for searching
set smartcase           " do not ignore if search mixed case
set showmode            " display INSERT/REPLACE modes
set incsearch           " show incremental search hits
set hlsearch            " high-light search results
" 2016-09-03: Use listchars to show tabs and trailing white space
set listchars=tab:>~,trail:.
set list
set autochdir               " cd to current buffer on file open
" 20130907: several based on Steve Losh blog page,
" http://stevelosh.com/blog/2010/09/coming-home-to-vim
set formatoptions=qrn1      " check :help fo-table
set colorcolumn=80          " visible line at column 85 for warning.
set ttyfast                 " improves smoothness of redrawing screen
set cursorline              " visibly shows line cursor is on
set showcmd                 " shows last command on status line
set ruler                   " shows line#,column# in status line
set relativenumber          " current line=0, others relative to that
set number                  " NOW, current line is absolute number and others relative
set laststatus=2            " ALWAYS have a status line on last window
set backspace=indent,eol,start  " Enforce correct backspace behavior fro tty.
set nobackup                " Do NOT create backup file.
set pastetoggle=<F2>        " Use <F2> to toggle INSERT-paste mode
set writebackup             " Use backup file until file save successful
set undofile                " create <filename>.un~ for undos after close/reopen.
execute "set undodir=".g:my_vim_path."undofiles"
set undolevels=1000         " How may undos
set undoreload=10000        "Number of lines to save for undo
set spell spelllang=en_us   " Switch on spell checking
" 2016-02-26: See http://vim.wikia.com/wiki/Omni_completion
" Useful?  Not sure yet.
"set omnifunc=syntaxcomplete#Complete

" This Vim setting also affects CtrlP; here we tell both to ignore files in /tmp
" and also three file types: *.so, *.swp, and *.zip
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

if g:my_os ==? "Linux"
    setlocal makeprg=/usr/bin/tidy\ -quiet\ -config\ ~/.vim/Tidy.cfg\ -errors\ %
    setlocal errorformat=/usr/bin/line\ %l\ column\ %v\ -\ %m
endif
if has('gui_running')
    "colorscheme "g:my_colorscheme_gui"
    colorscheme arnold
    set background=light
else
    " Tell vim to use 256 colors
    set t_Co=256
    colorscheme default
    set background=light
    setlocal nospell spelllang=en_us
endif

" Set up highlighting with "match" command; create highlight group
" named "TrailingWhiteSpace" (always explicitly name groups) to regexp.
highlight TrailingWhitespace ctermbg=lightred guibg=lightred
highlight SpellBad term=standout ctermbg=yellow ctermfg=15 term=underline cterm=underline

"-------------------------------------------------------------------------------
" END: General vim settings
"-------------------------------------------------------------------------------

" Configure Plugin Variables {{{1
"-------------------------------------------------------------------------------
" Configure Plugin variables.
"-------------------------------------------------------------------------------

" PLUGIN: Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" 2017-06-24: Update UltiSnipsSnippetsDir to use generic path, which has trailing slash.
" 2017-07-09: Update triggers to use more natural <tab> and <s-tab> for all triggers.
let g:UltiSnipsSnippetsDir        = g:my_vim_path . 'UltiSnips/'
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-l>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" PLUGIN: CtrlP
" 2016-03-07: CtrlP settings
" Variable g:ctrlp_working_path_mode settings
" 'c' = the directory of the current file
" 'r' = the nearest ancestor that contains one of these directories/files:
"       .git, .hg, .svn, .bzr, _darcs, or defined in "g:ctrlp_root_markers"
" 'a' = like 'c' but only applies when the $CWD outside of CtrlP is not a direct
"       ancestor of the directory of the current file.
" '0' = disables the feature.
let g:ctrlp_working_path_mode = ''
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:15,results:15'
let g:ctrlp_max_files = 10000
" 2016-03-26: This allows for personal function mappings in CtrlP
" let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }

" 2016-03-12: MUST put CtrlP_bdelete call AFTER all other CtrlP setups
call ctrlp_bdelete#init()

" PLUGIN: BASH
" Setting variables for use by BASH plugin.
let g:BASH_AuthorName	= 'Arnold Hausmann'
let g:BASH_Email	= 'arnoldh@comcast.net'
let g:BASH_Company	= ''

" PLUGIN: HTML
" Setting variables for use by HTML plugin.
let g:html_authorname	= 'Arnold Hausmann'
let g:html_authoremail	= 'arnoldh@comcast.net'

" PLUGIN: Airline
" 2016-03-10: Airline plugin setups.
" enable/disable enhanced tabline.
let g:airline#extensions#tabline#enabled = 1
" enable/disable displaying buffers with a single tab.
let g:airline#extensions#tabline#show_buffers = 1
" enable/disable display preview window buffer in the tabline.
let g:airline#extensions#tabline#exclude_preview = 1

" PLUGIN: Sessions
" 2017-06-24: Make Sessions directory generic path.
" let g:session_dir = '~/.vim/my_session'
let g:session_dir = g:my_vim_path . 'my_session'
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"-------------------------------------------------------------------------------
" END: Configure Plugin variables.
"-------------------------------------------------------------------------------

" Auto Groups/Commands {{{1
"------------------------------------------------------
" Auto groups/Auto commands
"------------------------------------------------------
" 20130915: Group all autocommands together in a GROUP to enable
" clearing of the command when re-executing .vimrc; each execution
" will create a new command otherwise.
" Common setting abbreviations:
" ts    tabstop
" sts   softtabstop
" sw    shiftwidth
" fo    formatoptions
" ai    autoindent
" si    smartindent
" inde  indentexpr
" et    expandtab
" fdm   foldmethod
" cms   commentstring

if has("autocmd")
    " Enable file type detection (if previously disabled)
    filetype on
    augroup MyAutoCmds
        " This command clears the group.
        autocmd!
        " This autocmd saves the file when focus is lost
        "autocmd FocusLost * :wa
        " Set Autocommands for different filetypes
        " 2017-04-20: before autogroups, set b:comment_leader default and filetypes
        let b:comment_leader ='#'
        let b:comment_end = ''
        autocmd FileType c,cpp,java,scala,php       let b:comment_leader = '//'
        autocmd FileType pascal,delphi              let b:comment_leader = '//'
        autocmd FileType dosbatch                   let b:comment_leader = '::'
        autocmd FileType autohotkey                 let b:comment_leader = ';;'
        autocmd FileType sh,ruby,python,perl        let b:comment_leader = '#'
        autocmd FileType conf,fstab,gtkrc           let b:comment_leader = '#'
        autocmd FileType gitconfig                  let b:comment_leader = '#'
        autocmd FileType make,apache                let b:comment_leader = '#'
        autocmd FileType text                       let b:comment_leader = '#'
        autocmd FileType fortran                    let b:comment_leader = '!'
        autocmd FileType tex,matlab,bib             let b:comment_leader = '%'
        autocmd FileType mail                       let b:comment_leader = '>'
        autocmd FileType vim                        let b:comment_leader = '"'
        autocmd FileType markdown                   let b:comment_leader = '<---'
        autocmd FileType htc                        let b:comment_leader = ';'
        autocmd FileType oin                        let b:comment_leader = '!'
        autocmd FileType sql                        let b:comment_leader = '--'

        autocmd FileType css                        setlocal si noet ts=2 sts=2 sw=2
        autocmd FileType html,css                   setlocal si noet ts=2 sts=2 sw=2
        autocmd FileType javascript                 setlocal si noet ts=4 sts=4 sw=4
        " This allows code folding in vim files. Folds begin with 3 left braces
        " and end with 3 right braces; both are 'comments'
        autocmd FileType vim                        setlocal fdm=marker
        autocmd FileType sql,sh                     setlocal fdm=marker
        " Treat .rss files as XML
        autocmd BufNewFile,BufRead *.rxx setfiletype xml

        " Call function to update "Last modified: " if text found in file.
        autocmd BufWritePre *                       call LastModified()
        " follow symlink and set working directory
        " 2017-09-11: causes issues with Fugitive, so comment out calls to SetProjectRoot.
        " autocmd BufRead *                           call FollowSymlink() | call SetProjectRoot()
        " netrw: follow symlink and set working directory; short circuit for non-netrw files 
        " autocmd CursorMoved * if &filetype == 'netrw' | call FollowSymlink() | call SetProjectRoot() | endif
    augroup END

    augroup php
        autocmd FileType php                        setlocal si noet ts=4 sts=4 sw=4 nolist
    augroup END

    augroup javascript
        autocmd FileType javascript                 setlocal si noet ts=4 sts=4 sw=4 nolist
    augroup END

    augroup html
        autocmd!
        " Set formatting option for HTML files (:h formatoptions)
        autocmd FileType html                       setlocal fo+=tl
        " Map insertion of "Return key" symbol in HTML code.
        autocmd FileType html                       inoremap <buffer> <leader>ret <C-V>&#x21a9;
    augroup END

    augroup sql
        autocmd!
        " Set SQL files to let Surround use "*" to do C-style comments.
        autocmd FileType sql                        let b:surround_42 = "/* \r */"
        " And setlocal the commentstring variable to allow Commentary to use "--" for commenting.
        autocmd FileType sql                        setlocal cms=--%s
        autocmd FileType sql                        setlocal noai nosi inde undofile
        autocmd FileType sql                        autocmd BufWritePre <buffer> :%s/\(\S\+\)\@<=\s\+$//e
    augroup END

    " 2016-03-26: Source the vimrc file after saving it
    " 2017-04-20: Comment this out as a plugin has destroyed the usefulness.
    " if has("autocmd")
    "     autocmd BufWritePost .vimrc source $MYVIMRC
    " endif

endif
"------------------------------------------------------
" END: Auto groups/Auto commands
"------------------------------------------------------

" Finale - Source externals {{{1
"------------------------------------------------------
" Final touches, source external scripts.
"------------------------------------------------------
" Use separate files for general mappings and general functions; this keeps the 
" .vimrc file cleaner, containing only settings, variable declarations, and sourcing
" of other scripts. Have included file "testing.vim" which is my test-bed script.
execute "source " . globpath(&rtp, 'my_functions.vim')
execute "source " . globpath(&rtp, 'my_mappings.vim')
execute "source " . globpath(&rtp, 'testing.vim')
