" Vim color file
" Maintainer:	Pierre-Henri Basin
" Licence:		MIT License
" Last Change:	31-07-2020

" Colors cheat sheet: https://jonasjacek.github.io/colors/

" First remove all existing highlighting.
hi clear
if exists("syntax_on")
	syntax reset
endif

let colors_name = "fancy"

hi SpecialKey								ctermfg=4
hi NonText			cterm=bold	ctermfg=4
hi Directory								ctermfg=4
hi ErrorMsg			cterm=bold	ctermfg=7		ctermbg=1
hi IncSearch		cterm=bold	ctermfg=16	ctermbg=15
hi Search				cterm=reverse,bold			ctermbg=16
hi MoreMsg									ctermfg=2
hi ModeMsg			cterm=bold
hi LineNr										ctermfg=8
hi Question									ctermfg=2
hi MatchParen														ctermbg=8
hi StatusLine		cterm=bold
hi StatusLineNC	cterm=reverse
hi VertSplit		cterm=reverse
hi Title										ctermfg=5
hi Visual				cterm=reverse
hi VisualNOS		cterm=bold
hi WarningMsg								ctermfg=1
hi WildMenu									ctermfg=0		ctermbg=3
hi PmenuSel									ctermfg=0		ctermbg=7
hi Pmenu										ctermfg=0		ctermbg=15
hi Folded										ctermfg=4		ctermbg=7
hi FoldColumn								ctermfg=4		ctermbg=7
hi DiffAdd															ctermbg=4
hi DiffChange														ctermbg=5
hi DiffDelete		cterm=bold	ctermfg=4		ctermbg=6
hi DiffText			cterm=bold							ctermbg=1

" Colors for syntax highlighting
hi Comment								ctermfg=12
hi Constant								ctermfg=127
hi String									ctermfg=196
hi Identifier							ctermfg=14
hi Operator								ctermfg=196
hi Function								ctermfg=14
hi Statement							ctermfg=3
hi PreProc								ctermfg=127
hi Type										ctermfg=2
hi Special								ctermfg=127
hi Ignore			cterm=bold	ctermfg=7
hi Error			cterm=bold	ctermfg=7			ctermbg=1
hi Todo										ctermfg=0			ctermbg=3

" Must appear at the end of the file to work around some oddities
set background=dark
