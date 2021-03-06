" Vim color file : arnold.vim
" Generated by   : http://bytefluent.com/vivify 2016-03-19
" Maintainer     : Arnold Hausmann
" Version        : 1.0.0
" Last modified  : Tue Jun 19, 2018 22:12:52 -0400
" Installation   : Install in directory: g:my_vim_path . "colors"
" 2017-09-11     : Set foreground Error to white (#ffffff).

set background=light
if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

set t_Co=256
let g:colors_name = "arnold"

" Key syntax groups; note that many syntaxes can be folded into a single group:
" Colorcolumn:  line used to denote the desired end of text in a line
" Comment:      text within comment markers or after comment-line markers.
" Cursor:       text underneath the cursor.
" Cursorline:   denotes which line contains the cursor.
" Error:        for known error conditions.
" Keyword:      keyword for any language; separate languages can map their keywords to Keyword
" Normal:       normal text
" Operator:     ordinarily operator characters (+, -, etc.); SQL syntax includes: IF, AND, END, BETWEEN, CASE, etc.
" Search:       used to highlight search terms, IncSearch can be the same, or different, and only for incremental.
" Special:      any special symbol/text. SQL syntax includes sqlKeyword
" String:       strings are enclosed within single- or double-quotes.

" hi Attribute        gui=NONE        guifg=#1b41ff   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=21      ctermbg=NONE 
hi Boolean          gui=NONE        guifg=#ff680a   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=202     ctermbg=NONE
" hi Cformat          gui=NONE        guifg=#eb9dff   guibg=#404040   guisp=#404040   cterm=NONE          ctermfg=219     ctermbg=238 
hi Character        gui=NONE        guifg=#00a2ff   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=40      ctermbg=NONE
" hi Colorcolumn      gui=NONE        guifg=NONE      guibg=#444444   guisp=#444444   cterm=NONE          ctermfg=NONE    ctermbg=238
hi Colorcolumn      gui=NONE        guifg=NONE      guibg=#F5CBA7    guisp=#444444   cterm=NONE          ctermfg=NONE    ctermbg=238
" hi Comment          gui=italic,bold guifg=#3333cc   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=40      ctermbg=NONE
hi Comment          gui=NONE        guifg=#ffffff   guibg=#3360FF   guisp=NONE      cterm=NONE          ctermfg=40      ctermbg=NONE
hi Conditional      gui=bold        guifg=blue      guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=40      ctermbg=NONE
hi Constant         gui=NONE        guifg=#00a2ff   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=39      ctermbg=NONE
" hi Cursor           gui=NONE        guifg=NONE      guibg=#153cff   guisp=#153cff   cterm=NONE          ctermfg=NONE    ctermbg=21 
hi Cursor           gui=NONE        guifg=NONE      guibg=white     guisp=#153cff   cterm=NONE          ctermfg=NONE    ctermbg=21 
hi CursorLine       gui=bold        guifg=NONE      guibg=#c0d9eb   guisp=#c0d9eb   cterm=NONE          ctermfg=NONE    ctermbg=152
hi Debug            gui=NONE        guifg=#ff8800   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=209     ctermbg=NONE
hi Error            gui=NONE        guifg=#ffffff   guibg=#d40000   guisp=#d40000   cterm=NONE          ctermfg=15      ctermbg=160 
hi Float            gui=NONE        guifg=#008cff   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=33      ctermbg=NONE 
hi Folded           gui=NONE        guifg=#000000   guibg=#c3daea   guisp=#c3daea   cterm=NONE          ctermfg=74      ctermbg=152  
hi Gutter           gui=NONE        guifg=#000082   guibg=#bebebe   guisp=#bebebe   cterm=NONE          ctermfg=8       ctermbg=7     
hi Identifier       gui=BOLD        guifg=#ff0088   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=198     ctermbg=NONE
hi IncSearch        gui=NONE        guifg=#b60000   guibg=#ffae00   guisp=#ffae00   cterm=NONE          ctermfg=124     ctermbg=214 
hi Keyword          gui=bold        guifg=#cc3300   guibg=NONE      guisp=NONE      cterm=bold          ctermfg=65      ctermbg=NONE 
hi Label            gui=NONE        guifg=#ff0088   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=198     ctermbg=NONE
" hi Lcursor          gui=NONE        guifg=#828282   guibg=#ffffff   guisp=#ffffff   cterm=NONE          ctermfg=8       ctermbg=15    
hi LineNr           gui=NONE        guifg=#000000   guibg=#efefef   guisp=#438ec3   cterm=NONE          ctermfg=15      ctermbg=74   
hi NonText          gui=NONE        guifg=#53b4f9   guibg=NONE      guisp=#b7dce8   cterm=NONE          ctermfg=75      ctermbg=152  
hi Normal           gui=NONE        guifg=black     guibg=NONE      guisp=#ffffff   cterm=NONE          ctermfg=8       ctermbg=15    
hi Number           gui=NONE        guifg=#008cff   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=33      ctermbg=NONE 
hi Operator         gui=NONE        guifg=#ff0044   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=108     ctermbg=NONE
hi PMenuSbar        gui=NONE        guifg=NONE      guibg=#848688   guisp=#848688   cterm=NONE          ctermfg=NONE    ctermbg=102
hi PreProc          gui=NONE        guifg=#ff0009   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=196     ctermbg=NONE
" hi Rcursor          gui=NONE        guifg=#7f5bff   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=99      ctermbg=NONE 
hi Search           gui=BOLD        guifg=#b00000   guibg=#ffef00   guisp=#ffae00   cterm=NONE          ctermfg=124     ctermbg=214 
" hi SignColumn       gui=NONE        guifg=#0099cc   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=208     ctermbg=NONE
hi SignColumn       gui=NONE        guifg=DarkBlue  guibg=#0099cc   guisp=NONE      cterm=NONE          ctermfg=208     ctermbg=NONE
hi Special          gui=bold        guifg=#ff0044   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=208     ctermbg=NONE
hi SpecialChar      gui=NONE        guifg=#ff5500   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=208     ctermbg=NONE
hi SpecialComment   gui=italic      guifg=#ff5500   guibg=NONE      guisp=NONE      cterm=bold,italic   ctermfg=208     ctermbg=NONE
hi Spelllocale      gui=NONE        guifg=NONE      guibg=#ff153c   guisp=#ff153c   cterm=NONE          ctermfg=NONE    ctermbg=196
hi Statement        gui=bold        guifg=#c00000   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=202     ctermbg=NONE
hi Statementu       gui=NONE        guifg=#ff1b1b   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=196     ctermbg=NONE
hi StatusLine       gui=NONE        guifg=black     guibg=NONE      guisp=#43c464   cterm=NONE          ctermfg=15      ctermbg=78   
" hi StatusLineNC     gui=NONE        guifg=#ffffff   guibg=#ffff00   guisp=#51b069   cterm=NONE          ctermfg=157     ctermbg=72  
hi StatusLineNC     gui=NONE        guifg=#b9ffc9   guibg=#51b069   guisp=#51b069   cterm=NONE          ctermfg=157     ctermbg=72
hi String           gui=NONE        guifg=blue      guibg=#ffffff   guisp=NONE      cterm=NONE          ctermfg=39      ctermbg=NONE 
hi Todo             gui=NONE        guifg=#ff0909   guibg=#dbf3cd   guisp=#dbf3cd   cterm=NONE          ctermfg=196     ctermbg=194 
hi Type             gui=BOLD        guifg=#a2af9b   guibg=NONE      guisp=NONE      cterm=NONE          ctermfg=108     ctermbg=NONE

hi htmlArg          gui=BOLD        guifg=red       guibg=NONE
