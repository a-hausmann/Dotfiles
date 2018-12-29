"-------------------------------------------------------------------------------
" Filename:      my_functions.vim
" Last modified: Thu Nov 01, 2018 10:05:56
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

"-------- MyHEFormat {{{1
function! MyHEFormat()
	:%s:<\/div>:<\/div>\r:g
	:%s:<br>&nbsp;<br>: <\/p>\r<p>:ge
	:%s:<br><br>: <\/p>\r<p>:ge
" 20130424: commented moving all tags to new line as HE now has better formatting.
"	:%s:<:\r<:g
	:%g/^$/del
	:%g/<\/*script/del
	:normal 1G
	let nada = search("<head>")
	:normal o;bhhttp://www.humanevents.com
	:normal 04x
	":search('<script>',
	":s/}/}\r/g
	":cd /data/arnold/Politics
	:cd $HOME/data/arnold/Politics
	:nohlsearch
    :call MyNoNbsp()<CR>
	:echo "function MyHEFormat complete!"
endfunction
" }}}1

"-------- NewTHFormat {{{1
function! NewTHFormat()
    :normal gg
    :g/^$/ del
    :normal gg
    :.,/<body/-1 s/^\s*\(\w\)</\1\r</e
    let ln = search("<head")
    :.,/<\/head>/-1 g:<meta\_.\{-}/>: del
    :normal gg
    let ln = search("<head")
    :.,/<\/head/-1 g/<link.*"stylesheet"/ del
    :normal gg
    let ln = search("<script")
    :.,/<\/script>/ g/.*/ del
    :normal gg
    let ln = search("<head")
    :s/^\s*</</e
    :normal gg
    let ln = search("<head")
    :normal o<base href="http://townhall.com">
    :normal gg
    let ln = search("<head")
    :.,/<body/-1 s/^\s<link/<link/e
    :normal gg
    let ln = search("<head")
    :.,/<\/head/-1 s/^\s*</</
    :normal gg
    let ln = search("<body")
    :s/<body/<body class="body"/e
    :normal o<DIV id="Outline">
    :normal o</DIV> <!-- ID=Outline -->
    :normal j0
    :.,/"print-article"/-1 g/.*/ del
    :normal gg
    let ln = search("<img src")
    :s/\s*\(<img.*>\)/<A HREF="\.\/" TARGET=_BLANK>\1 <\/A>/e
    :normal gg
    :.,/<body/-1 s/^\s</</e
    :nohlsearch
endfunction
" }}}1

"-------- MyNoEms {{{1
function! MyNoEms()
	:%s/\r//eg
	nohlsearch
endfunction
" }}}1

"-------- MyNoNbsp {{{1
function! MyNoNbsp()
" This function does two passes through the entire document.
" First, replace one or more spaces followed by ASCII NBSP (octal; 240) with
" single space. This will reduce multiple spaces to a single space.
" Second, replace any remaining ASCII NBSP with a single space.
	:%s/ \+\%o240/ /egc
	:%s/\%o240/ /egc
	nohlsearch
endfunction
" }}}1

"-------- EatChar {{{1
function! EatChar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunction
" }}}1

"-------- ToggleVExplorer {{{1
function! ToggleVExplorer()
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 20131022: Make netrw work like NERDTree
" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
""""""""""""""""""""""""""""""""""""""""""""""""""""""
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction

" On select of file, replace whole window with file.
let g:netrw_browse_split = 0
" Vertical split to right
let g:netrw_altv = 1
" Default to tree mode
let g:netrw_liststyle=3
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" End of making netrw work like NERDTree.
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}1

"-------- ToggleFoldAll {{{1
function! ToggleFoldAll()
    if exists("g:myFoldedAll")
        if g:myFoldedAll ==# 1
            let g:myFoldedAll = 0
            :normal zR
        else
            let g:myFoldedAll = 1
            :normal zM
        endif
    else
        let g:myFoldedAll = 1
        :normal zM
    endif
endfunction
" }}}1

"-------- ToggleShowTS {{{1
function! ToggleShowTS()
    if !exists("g:show_trailing_spaces")
        let g:show_trailing_spaces = 'Y'
    endif
    if g:show_trailing_spaces ==# 'Y'
        match TrailingWhiteSpace /\s\+$/
        let g:show_trailing_spaces = 'N'
    else
        "echom "calling execute"
        execute "match"
        let g:show_trailing_spaces = 'Y'
    endif
endfunction
" }}}1

"-------- MyDivision {{{1
function! MyDivision()
    " Since I want "Outline", create variable to hold the double quoted string.
    let l:str = "<DIV id=\"Outline\">"
    put = l:str
    put = \"</DIV> <!-- ID=Outline -->\"
endfunction
" }}}1

"-------- RemoveTrailingWhitespace {{{1
function! RemoveTrailingWhitespace()
  for lineno in range(a:firstline, a:lastline)
    let line = getline(lineno)
    let cleanLine = substitute(line, '\(\s\| \)\+$', '', 'e')
    call setline(lineno, cleanLine)
  endfor
endfunction
command! -range RT <line1>,<line2>call RemoveTrailingWhitespace()
" }}}1

"-------- RemoveAllTrailingWhitespace {{{1
function! RemoveAllTrailingWhitespace()
  let save_cursor = getpos(".")
  :%s/[ \t]\+$\|^[ \t]\+$//e
  call setpos('.', save_cursor)
endfunction
" }}}1

"-------- Preserve {{{1
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" }}}1

"-------- ReplaceDateTag {{{1
" 2016-02-28: Add function
function! ReplaceDateTag()
    let save_cursor = getpos(".")
    ":%s/<date>/\=strftime("%a, %d %b %Y %H:%M:%S %z")/
    :%s/<date>/\=strftime("%Y-%m-%d")/
    call setpos('.', save_cursor)
endfunction
" }}}1

"-------- LastModified {{{1
" 2016-02-28: Add function
" If buffer modified, update any 'Last modified: ' in the first 20 lines.
" 'Last modified: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
" 2017-07-10: change to use global date/timestamp format variable.
" 2018-06-07: change to NOT REQUIRE a space AFTER colon; change atom to end at
"             colon, and append a space after the atom, before strftime().
function! LastModified()
    if &modified
        let save_cursor = getpos(".")
        let n = min([20, line("$")])
        keepjumps exe '1,' . n . 's#^\(.\{,10}Last modified \{,7}:\).*#\1 ' . strftime(g:dts_format) . '#e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfunction
" }}}1

"-------- MyPolitics {{{1
function! MyPolitics()
    :lcd $HOME/data/arnold/Politics
    :e .
    normal s
    normal r
endfunction
" }}}1

"-------- CtrlPPolitics {{{1
function! CtrlPPolitics()
    :lcd $HOME/data/arnold/Politics
    :CtrlP
    :CtrlPClearCache
endfunction
" }}}1

"-------- FollowSymlink {{{1
" Ref: http://inlehmansterms.net/2014/09/04/sane-vim-working-directories/
" 2016-03-12: Got some functions/autocmds to hopefully fix vim's $CWD problems
" as it relates to CtrlP, see http://inlehmansterms.net/2014/09/04/sane-vim-working-directories/
" follow symlinked file
function! FollowSymlink()
    let current_file = expand('%:p')
    " check if file type is a symlink
    if getftype(current_file) == 'link'
        " if it is a symlink resolve to the actual file path
        "   and open the actual file
        let actual_file = resolve(current_file)
        silent! execute 'file ' . actual_file
    end
endfunction
" }}}1

"-------- SetProjectRoot {{{1
" Ref: http://inlehmansterms.net/2014/09/04/sane-vim-working-directories/
" See also notes in function FollowSymlink
" set working directory to git project root
" or directory of current file if not git project
function! SetProjectRoot()
    " default to the current file's directory
    lcd %:p:h
    let git_dir = system("git rev-parse --show-toplevel")
    " See if the command output starts with 'fatal' (if it does, not in a git repo)
    let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
    " if git project, change local directory to git project root
    if empty(is_not_git_dir) && !empty(git_dir)
        lcd `=git_dir`
    endif
endfunction
" }}}1

"-------- ScrollBind {{{1
function! ScrollBind(...)
  " Description: Toggle scrollbind amongst window splits
  " Arguments: 'mode' ( optional ) If not given, toggle scrollbind
  "               = 0 - Disable scrollbind
  "                 1 - Enable  scrollbind
  " From : https://gist.github.com/kshenoy/5661878
  let l:curr_bufnr = bufnr('%')
  " I've modified this so it does NOT automatically move the cursor to top of the files.
  let g:scb_status = ( a:0 > 0 ? a:1 : !exists('g:scb_status') || !g:scb_status )
  if !exists('g:scb_pos') | let g:scb_pos = {} | endif

  let l:loop_cont = 1
  while l:loop_cont
    setl noscb
    " if !g:scb_status && has_key( g:scb_pos, bufnr('%') )
      " call setpos( '.', g:scb_pos[ bufnr('%') ] )
    " endif
    execute "wincmd w"
    let l:loop_cont = !( l:curr_bufnr == bufnr('%') )
  endwhile

  if g:scb_status
    let l:loop_cont = 1
    while l:loop_cont
      let g:scb_pos[ bufnr('%') ] = getpos( '.' )
      " normal! gg
      setl scb
      execute "wincmd w"
      let l:loop_cont = !( l:curr_bufnr == bufnr('%') )
    endwhile
  else
    let g:scb_pos = {}
  endif

  if g:scb_status
    echom "Enabling scrollbind"
  else
    echom "Disabling scrollbind"
  endif
endfunction
" }}}1

"-------- SynStack {{{1
function! SynStack()
" 2016-03-25: This function returns the name of the syntax type for the word under the cursor.
" Courtesy of Drew Neil on http://vimcasts.org/episodes/creating-colorschemes-for-vim/
" 2017-09-02: Did NOT have any mapping for this, just adding it here.
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <C-S-P> :call SynStack()<cr>
" }}}1

" "-------- MyCtrlPMappings {{{1
" function! MyCtrlPMappings()
"     nnoremap <buffer> <silent> <c-@> :call <sid>DeleteBuffer()<cr>
" endfunction
" " }}}1

" "-------- DeleteBuffer {{{1
" function! s:DeleteBuffer()
"     let line = getline('.')
"     let bufid = line =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(line, '\d\+'))
"         \ : fnamemodify(line[2:], ':p')
"     exec "bd" bufid
"     exec "norm \<F5>"
" endfunction
" " }}}1

"-------- DisplayTempEcho {{{1
function! DisplayTempEcho(message, sleepfor)
    echo a:message
    execute 'sleep '.a:sleepfor
    redraw!
endfunction
" }}}1

"-------- DisplayTempMessage {{{1
function! DisplayTempMessage(message, sleepfor)
" Display message and sleep then redraw. Sleepfor in seconds unless appending "m"
" for milliseconds; e.g., "sleep 2" for two seconds, "sleep 500m" for half second.
" 2017-04-20: add check for sleepfor > 5, change to milliseconds.
    if a:sleepfor !~ 'm' && a:sleepfor > 5
        let l:sleepfor = a:sleepfor . "m"
    else
        let l:sleepfor = a:sleepfor
    endif
    echom a:message
    execute 'sleep ' . l:sleepfor
    redraw!
endfunction
" }}}1

"-------- ChangeWordCase {{{1
function! ChangeWordCase(case)
    let save_cursor = getpos(".")
    if a:case ==? "UPPER"
        :normal gUiw
        :call DisplayTempEcho("UPPER", "300m")
    else
        :normal guiw
        :call DisplayTempEcho("lower", "300m")
    endif
    call setpos('.', save_cursor)
endfunction
" }}}1

"-------- AutoWrapToggle {{{1
function! AutoWrapToggle()
" In 'formatoptions', 't' sets auto-wrap text using textwidth value
" and 'c' sets auto-wrap comments using textwidth value.
" This script checks for the existence of 't' in 'formatoptions', and
" if it exists turns off ("-=") the options, else sets textwidth=colorcolumn
" and turns on the options ("+=").
    if &formatoptions =~ 't'
        execute 'set textwidth='. g:TextWidth
        set formatoptions-=tc
        call DisplayTempMessage("AutoWrap OFF", 1)
    else
        let g:TextWidth = &tw
        " 2017-01-13: had hard-coded limit, use colorcolumn setting instead
        " execute 'set textwidth=' . 80
        execute 'set textwidth=' . &colorcolumn
        set formatoptions+=tc
        call DisplayTempMessage("AutoWrap ON", 1)
    endif
endfunction
" }}}1

"-------- FlowerBox {{{1
function! FlowerBox()
" 2017-04-20: new function to create flowerbox based on settings of colorcolumn
" (for length of box) and file type (for comment markers). Check the vimrc file
" for autocmd by filetype of b:comment_leader/b:comment_end; note that the
" comment_end is only set for those filetypes which require it, like SQL.
" The function checks the current formatoptions to see if autowrap is on and if
" not sets it. ERGO: must remember to turn off the option at the end of flower
" box notes.
    let cb = b:comment_leader
    let ce = b:comment_end
    let l:sl = strlen(b:comment_leader . b:comment_end)
    execute "let l:cl =" . &colorcolumn
    let l:cl=l:cl - l:sl
    " echom "local cl=" . l:cl
    normal o
    execute "normal 0i" . cb
    execute "normal " . l:cl . "A-"
    execute "normal A" . ce
    normal yyp
    execute "normal O" . cb . "  "
    if &formatoptions !~ 't'
        call AutoWrapToggle()
    endif
    startinsert
endfunction
"}}}1

"-------- AddFoldMarks {{{1
function! AddFoldMarks()
    " 2018-09-11: fix tendency to place second line anywhere;
    " first, capture current point, then "put" 2nd line, reposition to mark,
    " finally "put" 1st line. This sets the beginning fold marker last, and in
    " the right place.
    let l = line(".")
    let c = col(".")
    :call inputsave()
    let l:mynbr = input('Enter fold level: ')
    let l:mytext = input('Enter fold description: ')
    :call inputrestore()
    if &filetype == "sql"
        let l:cmnt = "--"
    elseif &filetype == "vim"
        let l:cmnt = "\""
    else
        let l:cmnt = "# "
    end
    let l:str1 = cmnt . "-- " . mytext . " {{{" . mynbr
    let l:str2 = cmnt . " }}}" . mynbr
    " 2017-07-20: too simple to fix; put str1 then str2, fold automatically
    " collapses, so "normal zo" to open with cursor at end marker, then
    " "normal k" to move to beginning marker.
    put = l:str2
    call cursor(l, c)
    put = l:str1
    " normal zo
    " normal k
    " echon ""
endfunction
nnoremap <silent>AFM :call AddFoldMarks()<cr>
" }}}1

"-------- Preserve {{{1
function! Preserve(command)
    " 2017-09-09: Ref.: http://vimcasts.org/episodes/tidying-whitespace/?success#comment-37459247
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction 
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>
" }}}1


"-------- ToggleHexEdit {{{1
function! ToggleHexEdit()
    " 2017-09-09: Ref.: http://vimcasts.org/episodes/tidying-whitespace/?success#comment-37459247
    " Preparation: save last search, and cursor position.
    if !exists("g:myHexEditInd")
        let g:myHexEditInd = 'Y'
        :%!xxd
    elseif g:myHexEditInd == 'Y'
        let g:myHexEditInd = 'N'
        :%!xxd -r
    else
        let g:myHexEditInd = 'Y'
        :%!xxd
    endif
endfunction 
nnoremap <localleader>hex :call ToggleHexEdit()<CR>
" }}}1
