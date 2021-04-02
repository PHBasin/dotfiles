" File:       monokai.vim
" Maintainer: Pierre-Henri Basin
" License:    MIT
"

" Initialisation
" --------------

if !has("gui_running") && &t_Co < 256
  finish
endif

if ! exists("g:monokai_gui_italic")
    let g:monokai_gui_italic = 0
endif

if ! exists("g:monokai_term_italic")
    let g:monokai_term_italic = 0
endif

let g:monokai_termcolors = 256 " does not support 16 color term right now.

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "monokai"

function! s:h(group, style)
  let s:ctermformat = "NONE"
  let s:guiformat = "NONE"
  if has_key(a:style, "format")
    let s:ctermformat = a:style.format
    let s:guiformat = a:style.format
  endif
  if g:monokai_term_italic == 0
    let s:ctermformat = substitute(s:ctermformat, ",italic", "", "")
    let s:ctermformat = substitute(s:ctermformat, "italic,", "", "")
    let s:ctermformat = substitute(s:ctermformat, "italic", "", "")
  endif
  if g:monokai_gui_italic == 0
    let s:guiformat = substitute(s:guiformat, ",italic", "", "")
    let s:guiformat = substitute(s:guiformat, "italic,", "", "")
    let s:guiformat = substitute(s:guiformat, "italic", "", "")
  endif
  if g:monokai_termcolors == 16
    let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm : "NONE")
    let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm : "NONE")
  end
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")      ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")      ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")      ? a:style.sp.gui   : "NONE")
    \ "gui="     (!empty(s:guiformat) ? s:guiformat   : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (!empty(s:ctermformat) ? s:ctermformat   : "NONE")
endfunction

" Palettes
" --------

let s:white       = { "gui": "#e8e8e8", "cterm": "252" }
let s:white2      = { "gui": "#d8d8d8", "cterm": "250" }
let s:black       = { "gui": "#282828", "cterm": "234" }
let s:lightblack  = { "gui": "#2d2d2d", "cterm": "235" }
let s:lightblack2 = { "gui": "#3c3c3c", "cterm": "236" }
let s:lightblack3 = { "gui": "#4b4b4b", "cterm": "237" }
let s:darkblack   = { "gui": "#1e1e1e", "cterm": "16" }
let s:grey        = { "gui": "#505050", "cterm": "59" }
let s:lightgrey   = { "gui": "#a0a0a0", "cterm": "145" }
let s:darkgrey    = { "gui": "#646464", "cterm": "239" }
let s:warmgrey    = { "gui": "#5a5a5a", "cterm": "59" }

let s:pink        = { "gui": "#e06c75", "cterm": "167" }
let s:green       = { "gui": "#75e06c", "cterm": "120" }
let s:aqua        = { "gui": "#6ce0d7", "cterm": "81" }
let s:yellow      = { "gui": "#e0d76c", "cterm": "185" }
let s:orange      = { "gui": "#e09d6c", "cterm": "208" }
let s:purple      = { "gui": "#d76ce0", "cterm": "176" }
let s:red         = { "gui": "#e64b4b", "cterm": "131" }
let s:purered     = { "gui": "#ff0000", "cterm": "52" }
let s:darkred     = { "gui": "#5f0000", "cterm": "52" }

let s:addfg       = { "gui": "#d7ffaf", "cterm": "193" }
let s:addbg       = { "gui": "#5f875f", "cterm": "65" }
let s:delfg       = { "gui": "#ff8b8b", "cterm": "210" }
let s:delbg       = { "gui": "#f75f5f", "cterm": "124" }
let s:changefg    = { "gui": "#d7d7ff", "cterm": "189" }
let s:changebg    = { "gui": "#5f5f87", "cterm": "60" }

let s:cyan        = { "gui": "#a1efe4" }
let s:br_green    = { "gui": "#9ec400" }
let s:br_yellow   = { "gui": "#e7c547" }
let s:br_blue     = { "gui": "#7aa6da" }
let s:br_purple   = { "gui": "#b77ee0" }
let s:br_cyan     = { "gui": "#54ced6" }
let s:br_white    = { "gui": "#ffffff" }

" Highlighting 
" ------------

" editor
call s:h("Normal",        { "fg": s:white })
call s:h("ColorColumn",   {                     "bg": s:lightblack })
call s:h("Cursor",        { "fg": s:black,      "bg": s:white })
call s:h("CursorColumn",  {                     "bg": s:lightblack2 })
call s:h("CursorLine",    {                     "bg": s:lightblack2 })
call s:h("NonText",       { "fg": s:grey })
call s:h("Visual",        {                     "bg": s:darkgrey })
call s:h("Search",        { "fg": s:black,      "bg": s:yellow })
call s:h("MatchParen",    { "fg": s:purple,                           "format": "bold" })
call s:h("Question",      { "fg": s:yellow })
call s:h("ModeMsg",       { "fg": s:lightgrey })
call s:h("MoreMsg",       { "fg": s:lightgrey })
call s:h("ErrorMsg",      { "fg": s:black,      "bg": s:red,          "format": "standout" })
call s:h("WarningMsg",    { "fg": s:red })
call s:h("VertSplit",     { "fg": s:darkgrey,   "bg": s:darkblack })
call s:h("LineNr",        { "fg": s:grey })
call s:h("CursorLineNr",  { "fg": s:orange,     "bg": s:lightblack })
call s:h("SignColumn",    {                     "bg": s:lightblack })

" statusline
call s:h("StatusLine",    { "fg": s:black,      "bg": s:lightgrey })
call s:h("StatusLineNC",  { "fg": s:lightgrey,  "bg": s:black })
call s:h("TabLine",       { "fg": s:lightgrey,  "bg": s:lightblack })
call s:h("TabLineSel",    { "fg": s:darkblack,  "bg": s:warmgrey,     "format": "bold" })
call s:h("TabLineFill",   { "bg": s:lightblack })
call s:h("User1",         { "fg": s:yellow,     "bg": s:lightgrey,    "format": "bold" })
call s:h("User2",         { "fg": s:orange,     "bg": s:lightgrey,    "format": "bold" })
call s:h("User3",         { "fg": s:purple,     "bg": s:lightgrey,    "format": "bold" })
call s:h("User4",         { "fg": s:aqua,       "bg": s:lightgrey,    "format": "bold" })

" spell
call s:h("SpellBad",      { "fg": s:red,                              "format": "underline" })
call s:h("SpellCap",      { "fg": s:purple,                           "format": "underline" })
call s:h("SpellRare",     { "fg": s:aqua,                             "format": "underline" })
call s:h("SpellLocal",    { "fg": s:pink,                             "format": "underline" })

" misc
call s:h("SpecialKey",    { "fg": s:pink })
call s:h("Title",         { "fg": s:yellow })
call s:h("Directory",     { "fg": s:aqua })

" diff
call s:h("DiffAdd",       { "fg": s:addfg,      "bg": s:addbg })
call s:h("DiffDelete",    { "fg": s:delfg,      "bg": s:delbg })
call s:h("DiffChange",    { "fg": s:changefg,   "bg": s:changebg })
call s:h("DiffText",      { "fg": s:black,      "bg": s:aqua })

" fold
call s:h("Folded",        { "fg": s:warmgrey,   "bg": s:darkblack })
call s:h("FoldColumn",    {                     "bg": s:darkblack })
"        Incsearch"

" popup menu
call s:h("Pmenu",         { "fg": s:white2,     "bg": s:lightblack3 })
call s:h("PmenuSel",      { "fg": s:aqua,       "bg": s:lightblack3,        "format": "reverse,bold" })
call s:h("PmenuThumb",    { "fg": s:lightblack, "bg": s:grey })
"        PmenuSbar"

" Generic Syntax Highlighting
" ---------------------------

call s:h("Constant",      { "fg": s:purple })
call s:h("Number",        { "fg": s:purple })
call s:h("Float",         { "fg": s:purple })
call s:h("Boolean",       { "fg": s:purple })
call s:h("Character",     { "fg": s:yellow })
call s:h("String",        { "fg": s:yellow })

call s:h("Type",          { "fg": s:aqua })
call s:h("Structure",     { "fg": s:aqua })
call s:h("StorageClass",  { "fg": s:aqua })
call s:h("Typedef",       { "fg": s:aqua })
    
call s:h("Identifier",    { "fg": s:green })
call s:h("Function",      { "fg": s:green })
                         
call s:h("Statement",     { "fg": s:pink })
call s:h("Operator",      { "fg": s:pink })
call s:h("Label",         { "fg": s:pink })
call s:h("Keyword",       { "fg": s:pink })
"        Conditional"
"        Repeat"
"        Exception"

call s:h("PreProc",       { "fg": s:green })
call s:h("Include",       { "fg": s:pink })
call s:h("Define",        { "fg": s:pink })
call s:h("Macro",         { "fg": s:green })
call s:h("PreCondit",     { "fg": s:green })
                           
call s:h("Special",       { "fg": s:purple })
call s:h("SpecialChar",   { "fg": s:pink })
call s:h("Delimiter",     { "fg": s:pink })
call s:h("SpecialComment",{ "fg": s:aqua })
call s:h("Tag",           { "fg": s:pink })
"        Debug"

call s:h("Todo",          { "fg": s:orange,   "format": "bold,italic" })
call s:h("Comment",       { "fg": s:warmgrey, "format": "italic" })
                         
call s:h("Underlined",    { "fg": s:green })
call s:h("Ignore",        {})
call s:h("Error",         { "fg": s:red, "bg": s:darkred })

" NerdTree
" --------

call s:h("NERDTreeOpenable",        { "fg": s:yellow })
call s:h("NERDTreeClosable",        { "fg": s:yellow })
call s:h("NERDTreeHelp",            { "fg": s:yellow })
call s:h("NERDTreeBookmarksHeader", { "fg": s:pink })
call s:h("NERDTreeBookmarksLeader", { "fg": s:black })
call s:h("NERDTreeBookmarkName",    { "fg": s:yellow })
call s:h("NERDTreeCWD",             { "fg": s:pink })
call s:h("NERDTreeUp",              { "fg": s:white })
call s:h("NERDTreeDirSlash",        { "fg": s:grey })
call s:h("NERDTreeDir",             { "fg": s:grey })

" Syntastic
" ---------

hi! link SyntasticErrorSign Error
call s:h("SyntasticWarningSign",    { "fg": s:lightblack, "bg": s:orange })

" coc
" ---

hi! link CocErrorSign Error
call s:h("CocErrorHighlight",       { "fg": s:red, "format": "underline" })
call s:h("CocErrorFloat",           { "fg": s:purered, "bg": s:lightblack3 })

call s:h("CocWarningSign",          { "fg": s:orange, "bg": s:lightblack })
call s:h("CocWarningHighlight",     { "format": "underline" })
call s:h("CocWarningFloat",         { "fg": s:orange, "bg": s:lightblack3 })

call s:h("CocInfoSign",             { "fg": s:yellow, "bg": s:lightblack3 })
call s:h("CocInfoHighlight",        { "format": "underline" })

call s:h("CocHintSign",             { "fg": s:white, "bg": s:lightblack3 })
call s:h("CocHintHighlight",        { "format": "underline" })

call s:h("CocHighlightText",        { "fg": s:aqua })
" document.renameCurrentWord cursor word highlight
call s:h("CocCursorRange",          { "fg": s:warmgrey, "bg": s:yellow })

" Language highlight
" ------------------

" Java properties
call s:h("jpropertiesIdentifier",   { "fg": s:pink })

" Vim command
call s:h("vimCommand",              { "fg": s:pink })

" Javascript
call s:h("jsClassKeyword",      { "fg": s:aqua, "format": "italic" })
call s:h("jsGlobalObjects",     { "fg": s:aqua, "format": "italic" })
call s:h("jsFuncName",          { "fg": s:green })
call s:h("jsThis",              { "fg": s:orange, "format": "italic" })
call s:h("jsObjectKey",         { "fg": s:white })
call s:h("jsFunctionKey",       { "fg": s:green })
call s:h("jsPrototype",         { "fg": s:aqua })
call s:h("jsExceptions",        { "fg": s:aqua })
call s:h("jsFutureKeys",        { "fg": s:aqua })
call s:h("jsBuiltins",          { "fg": s:aqua })
call s:h("jsStatic",            { "fg": s:aqua })
call s:h("jsSuper",             { "fg": s:orange, "format": "italic" })
call s:h("jsFuncArgRest",       { "fg": s:purple, "format": "italic" })                                 
call s:h("jsFuncArgs",          { "fg": s:orange, "format": "italic" })
call s:h("jsStorageClass",      { "fg": s:aqua, "format": "italic" })
call s:h("jsDocTags",           { "fg": s:aqua,   "format": "italic" })
call s:h("jsFunction",          { "fg": s:aqua,   "format": "italic" })

" Typescript
call s:h("typescriptBraces",              { "fg": s:white })
call s:h("typescriptParens",              { "fg": s:white })
call s:h("typescriptOperator",            { "fg": s:pink })
call s:h("typescriptEndColons",           { "fg": s:white })
call s:h("typescriptModule",              { "fg": s:aqua })
call s:h("typescriptPredefinedType",      { "fg": s:aqua })
call s:h("typescriptImport",              { "fg": s:pink })
call s:h("typescriptExport",              { "fg": s:pink })
call s:h("typescriptIdentifier",          { "fg": s:orange, "format": "italic" })
call s:h("typescriptVariable",            { "fg": s:aqua })
call s:h("typescriptCastKeyword",         { "fg": s:pink })
call s:h("typescriptAmbientDeclaration",  { "fg": s:pink })
call s:h("typescriptTestGlobal",          { "fg": s:pink })
call s:h("typescriptFuncKeyword",         { "fg": s:aqua })
call s:h("typescriptFuncTypeArrow",       { "fg": s:aqua })
call s:h("typescriptFuncType",            { "fg": s:orange, "format": "italic" })
call s:h("typescriptFuncName",            { "fg": s:green })
call s:h("typescriptArrowFuncArg",        { "fg": s:orange, "format": "italic" })
call s:h("typescriptCall",                { "fg": s:orange, "format": "italic" })
call s:h("typescriptClassKeyword",        { "fg": s:aqua,   "format": "italic" })
call s:h("typescriptClassName",           { "fg": s:white })
call s:h("typescriptClassHeritage",       { "fg": s:white })
call s:h("typescriptInterfaceKeyword",    { "fg": s:aqua,   "format": "italic" })
call s:h("typescriptInterfaceName",       { "fg": s:white })
call s:h("typescriptObjectLabel",         { "fg": s:green })
call s:h("typescriptMember",              { "fg": s:green })
call s:h("typescriptTypeReference",       { "fg": s:purple, "format": "italic" })
call s:h("typescriptTypeParameter",       { "fg": s:purple, "format": "italic" })
call s:h("typescriptOptionalMark",        { "fg": s:pink })
call s:h("tsxAttrib",                     { "fg": s:green })
call s:h("tsxTagName",                    { "fg": s:pink })

" Dart
call s:h("dartStorageClass",    { "fg": s:pink })
call s:h("dartExceptions",      { "fg": s:pink })
call s:h("dartConditional",     { "fg": s:pink })
call s:h("dartRepeat",          { "fg": s:pink })
call s:h("dartTypedef",         { "fg": s:pink })
call s:h("dartKeyword",         { "fg": s:pink })
call s:h("dartConstant",        { "fg": s:purple })
call s:h("dartBoolean",         { "fg": s:purple })
call s:h("dartCoreType",        { "fg": s:aqua })
call s:h("dartType",            { "fg": s:aqua })
                                 
" HTML
call s:h("htmlTag",             { "fg": s:white })
call s:h("htmlEndTag",          { "fg": s:white })
call s:h("htmlTagName",         { "fg": s:pink })
call s:h("htmlArg",             { "fg": s:green })
call s:h("htmlSpecialChar",     { "fg": s:purple })

" XML
call s:h("xmlTag",              { "fg": s:pink })
call s:h("xmlEndTag",           { "fg": s:pink })
call s:h("xmlTagName",          { "fg": s:orange })
call s:h("xmlAttrib",           { "fg": s:green })

" JSX
call s:h("jsxTag",              { "fg": s:white })
call s:h("jsxCloseTag",         { "fg": s:white })
call s:h("jsxCloseString",      { "fg": s:white })
call s:h("jsxPunct",            { "fg": s:white })
call s:h("jsxClosePunct",       { "fg": s:white })
call s:h("jsxTagName",          { "fg": s:pink })
call s:h("jsxComponentName",    { "fg": s:pink })
call s:h("jsxAttrib",           { "fg": s:green })
call s:h("jsxEqual",            { "fg": s:white })
call s:h("jsxBraces",           { "fg": s:white })

" CSS
call s:h("cssProp",             { "fg": s:yellow })
call s:h("cssUIAttr",           { "fg": s:yellow })
call s:h("cssFunctionName",     { "fg": s:aqua })
call s:h("cssColor",            { "fg": s:purple })
call s:h("cssPseudoClassId",    { "fg": s:purple })
call s:h("cssClassName",        { "fg": s:green })
call s:h("cssValueLength",      { "fg": s:purple })
call s:h("cssCommonAttr",       { "fg": s:pink })
call s:h("cssBraces" ,          { "fg": s:white })
call s:h("cssClassNameDot",     { "fg": s:pink })
call s:h("cssURL",              { "fg": s:orange, "format": "underline,italic" })

" LESS
call s:h("lessVariable",        { "fg": s:green })

" SASS
call s:h("sassMixing",          { "fg": s:aqua })
call s:h("sassMixin",           { "fg": s:aqua })
call s:h("sassFunctionDecl",    { "fg": s:aqua })
call s:h("sassReturn",          { "fg": s:aqua })
call s:h("sassClass",           { "fg": s:green })
call s:h("sassClassChar",       { "fg": s:pink })
call s:h("sassIdChar",          { "fg": s:pink })
call s:h("sassControl",         { "fg": s:aqua })
call s:h("sassFor",             { "fg": s:aqua })

" ruby
call s:h("rubyInterpolationDelimiter",  {})
call s:h("rubyInstanceVariable",        {})
call s:h("rubyGlobalVariable",          {})
call s:h("rubyClassVariable",           {})
call s:h("rubyPseudoVariable",          {})
call s:h("rubyFunction",                { "fg": s:green })
call s:h("rubyStringDelimiter",         { "fg": s:yellow })
call s:h("rubyRegexp",                  { "fg": s:yellow })
call s:h("rubyRegexpDelimiter",         { "fg": s:yellow })
call s:h("rubySymbol",                  { "fg": s:purple })
call s:h("rubyEscape",                  { "fg": s:purple })
call s:h("rubyInclude",                 { "fg": s:pink })
call s:h("rubyOperator",                { "fg": s:pink })
call s:h("rubyControl",                 { "fg": s:pink })
call s:h("rubyClass",                   { "fg": s:pink })
call s:h("rubyDefine",                  { "fg": s:pink })
call s:h("rubyException",               { "fg": s:pink })
call s:h("rubyRailsARAssociationMethod",{ "fg": s:orange })
call s:h("rubyRailsARMethod",           { "fg": s:orange })
call s:h("rubyRailsRenderMethod",       { "fg": s:orange })
call s:h("rubyRailsMethod",             { "fg": s:orange })
call s:h("rubyConstant",                { "fg": s:aqua })
call s:h("rubyBlockArgument",           { "fg": s:orange })
call s:h("rubyBlockParameter",          { "fg": s:orange })

" eruby
call s:h("erubyDelimiter",              {})
call s:h("erubyRailsMethod",            { "fg": s:aqua })

" c
call s:h("cLabel",                      { "fg": s:pink })
call s:h("cStructure",                  { "fg": s:aqua })
call s:h("cStorageClass",               { "fg": s:pink })
call s:h("cInclude",                    { "fg": s:pink })
call s:h("cDefine",                     { "fg": s:pink })
call s:h("cSpecial",                    { "fg": s:purple })

" Markdown
call s:h("markdownCode",       { "fg": s:purple, "format": "italic" } )
call s:h("markdownListMarker", { "fg": s:purple                     } )

" vim-notes
call s:h("notesTitle",        { "fg": s:aqua,        "format": "bold"        } )
call s:h("notesAtxMarker",    { "fg": s:pink,        "format": "italic,bold" } )
call s:h("notesShortHeading", { "fg": s:white,       "format": "bold"        } )
call s:h("notesListBullet",   { "fg": s:purple                               } )
call s:h("notesListNumber",   { "fg": s:purple,      "format": "italic"      } )
call s:h("notesBold",         {                      "format": "bold"        } )
call s:h("notesDoneMarker",   { "fg": s:green                                } )

" Terminal Colors
" ---------------
if has('nvim')
  let g:terminal_color_0  = s:black.gui
  let g:terminal_color_1  = s:red.gui
  let g:terminal_color_2  = s:green.gui
  let g:terminal_color_3  = s:yellow.gui
  let g:terminal_color_4  = s:aqua.gui
  let g:terminal_color_5  = s:purple.gui
  let g:terminal_color_6  = s:cyan.gui
  let g:terminal_color_7  = s:white.gui
  let g:terminal_color_8  = s:darkgrey.gui
  let g:terminal_color_9  = s:pink.gui
  let g:terminal_color_10 = s:br_green.gui
  let g:terminal_color_11 = s:br_yellow.gui
  let g:terminal_color_12 = s:br_blue.gui
  let g:terminal_color_13 = s:br_purple.gui
  let g:terminal_color_14 = s:br_cyan.gui
  let g:terminal_color_15 = s:br_white.gui
else
  let g:terminal_ansi_colors = [
        \ s:black.gui,
        \ s:red.gui,
        \ s:green.gui,
        \ s:yellow.gui,
        \ s:aqua.gui,
        \ s:purple.gui,
        \ s:cyan.gui,
        \ s:white.gui,
        \ s:darkgrey.gui,
        \ s:pink.gui,
        \ s:br_green.gui,
        \ s:br_yellow.gui,
        \ s:br_blue.gui,
        \ s:br_purple.gui,
        \ s:br_cyan.gui,
        \ s:br_white.gui]
endif

" Operator Highlighting (from https://github.com/Valloric/vim-operator-highlight)
" -------------------

if exists( 'g:loaded_operator_highlight' )
  finish
else
  let g:loaded_operator_highlight = 1
endif

if !exists( 'g:ophigh_color_gui' )
  let g:ophigh_color_gui = "#E06C75"
endif

if !exists( 'g:ophigh_highlight_link_group' )
  let g:ophigh_highlight_link_group = ""
endif


if !exists( 'g:ophigh_color' )
  let g:ophigh_color = "167"
endif

if !exists( 'g:ophigh_filetypes_to_ignore' )
  let g:ophigh_filetypes_to_ignore = {}
endif

fun! s:IgnoreFiletypeIfNotSet( file_type )
  if get( g:ophigh_filetypes_to_ignore, a:file_type, 1 )
    let g:ophigh_filetypes_to_ignore[ a:file_type ] = 1
  endif
endfunction

call s:IgnoreFiletypeIfNotSet('help')
call s:IgnoreFiletypeIfNotSet('markdown')
call s:IgnoreFiletypeIfNotSet('qf') " This is for the quickfix window
call s:IgnoreFiletypeIfNotSet('conque_term')
call s:IgnoreFiletypeIfNotSet('diff')
call s:IgnoreFiletypeIfNotSet('html')
call s:IgnoreFiletypeIfNotSet('css')
call s:IgnoreFiletypeIfNotSet('less')
call s:IgnoreFiletypeIfNotSet('xml')
call s:IgnoreFiletypeIfNotSet('sh')
call s:IgnoreFiletypeIfNotSet('bash')
call s:IgnoreFiletypeIfNotSet('notes')
call s:IgnoreFiletypeIfNotSet('jinja')

fun! s:HighlightOperators()
  if get( g:ophigh_filetypes_to_ignore, &filetype, 0 )
    return
  endif
  syntax match OperatorChars "?\|+\|-\|\*\|:\|<\|>\|&\||\|\^\|!\|\~\|%\|=\|/\(/\|*\)\@!"
  if g:ophigh_highlight_link_group != "" 
    exec "hi link OperatorChars " . g:ophigh_highlight_link_group
  else
    exec "hi OperatorChars guifg=" . g:ophigh_color_gui . " gui=NONE"
    exec "hi OperatorChars ctermfg=" . g:ophigh_color . " cterm=NONE"
  endif
endfunction

au Syntax * call s:HighlightOperators()
au ColorScheme * call s:HighlightOperators()
