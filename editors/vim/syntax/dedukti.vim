" Vim syntax file
" Language:        Dedukti
" Maintainer:      Rodolphe Lepigre <rodolphe.lepigre@inri.fr>
" Last Change:     24/10/2017
" Version:         1.0
" Original Author: Rodolphe Lepigre <rodolphe.lepigre@inri.fr>

if exists("b:current_syntax")
  finish
endif

" Keywords
syntax keyword Type Type
syntax keyword Keyword def thm
syntax match   Keyword "\["
syntax match   Keyword "\]"
syntax match   Keyword "("
syntax match   Keyword ")"
syntax match   Keyword ":"
syntax match   Keyword "=>"
syntax match   Keyword ":="
syntax match   Keyword "->"
syntax match   Keyword "-->"
syntax match   Keyword ","
syntax match   Keyword "\."

" Commands
syntax match Include "#NAME"
syntax match Include "#EVAL"
syntax match Include "#INFER"
syntax match Indlude "#CHECK"
syntax match Indlude "#CHECKNOT"
syntax match Indlude "#ASSERT"
syntax match Indlude "#ASSERTNOT"
syntax match Include "#REQUIRE"

" Comments
syn keyword Todo contained TODO FIXME NOTE
syn region Comment start="(;" end=";)" contains=Todo


