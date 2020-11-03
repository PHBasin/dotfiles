" Vim color file
" Maintainer:	Pierre-Henri Basin
" Licence:	MIT License
" Last Change:	31-07-2020

" First remove all existing highlighting.
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "fancy"

hi SpecialKey term=bold ctermfg=4
hi NonText term=bold cterm=bold ctermfg=4
hi Directory term=bold ctermfg=4
hi ErrorMsg term=standout cterm=bold ctermfg=7 ctermbg=1
hi IncSearch term=reverse cterm=reverse
hi Search term=reverse ctermbg=7
hi MoreMsg term=bold ctermfg=2
hi ModeMsg term=bold cterm=bold
hi LineNr term=underline ctermfg=8
hi Question term=standout ctermfg=2
hi StatusLine term=bold,reverse cterm=bold,reverse
hi StatusLineNC term=reverse cterm=reverse
hi VertSplit term=reverse cterm=reverse
hi Title term=bold ctermfg=5
hi Visual term=reverse cterm=reverse
hi VisualNOS term=bold,underline cterm=bold,underline
hi WarningMsg term=standout ctermfg=1
hi WildMenu term=standout ctermfg=0 ctermbg=3
hi Folded term=standout ctermfg=4 ctermbg=7
hi FoldColumn term=standout ctermfg=4 ctermbg=7
hi DiffAdd term=bold ctermbg=4
hi DiffChange term=bold ctermbg=5
hi DiffDelete term=bold cterm=bold ctermfg=4 ctermbg=6
hi DiffText term=reverse cterm=bold ctermbg=1

" Colors for syntax highlighting
hi Comment term=bold ctermfg=darkblue
hi Constant term=underline ctermfg=127
hi String term=underline ctermfg=196
hi Identifier term=underline ctermfg=lightblue
hi Operator term=bold ctermfg=196
hi Function term=bold ctermfg=45
hi Statement term=bold ctermfg=3
hi PreProc term=underline ctermfg=127
hi Type term=underline ctermfg=2
hi Special term=bold ctermfg=127
hi Ignore cterm=bold ctermfg=7
hi Error term=reverse cterm=bold ctermfg=7 ctermbg=1
hi Todo term=standout ctermfg=0 ctermbg=3

" Must appear at the end of the file to work around some oddities
set background=dark

