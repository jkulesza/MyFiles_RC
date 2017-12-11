" Vim syntax file
" Language: MCNP6 Input File
" Maintainer: Joel A. Kulesza
" Latest Revision: 05 June 2017

if exists("b:current_syntax")
  finish
endif

syntax case ignore

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cell keywords.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syn keyword mcnpKeywords imp tmp fill

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Surface keywords.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syn keyword mcnpKeywords p px py pz so s sx sy sz c/x c/y c/z cx cy cz k/x k/y k/z kx ky kz sq gq tx ty tz xyzp
syn keyword mcnpKeywords box rpp sph rcc rhp hex rec trc ell wed arb

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Data keywords.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syn keyword mcnpKeywords mode

" Source specification..
syn keyword mcnpKeywords sdef cel sur erg tme dir vec nrm pos rad ext axs ccc ara wgt eff par tr
syn match mcnpKeywords "si\d\+"
syn match mcnpKeywords "sp\d\+"
syn match mcnpKeywords "sb\d\+"
syn match mcnpKeywords "ds\d\+"
syn match mcnpKeywords "sc\d\+"
syn keyword mcnpKeywords ssw ssr
syn keyword mcnpKeywords kcode ksrc hsrc

" Ptrac.
syn keyword mcnpKeywords ptrac buffer file max meph write event filter type nps cell surface tally value
syn keyword mcnpConstant asc bin pos all src bnk sur col ter

syn keyword mcnpKeywords rand gen seed stride hist

syn match mcnpComment "^\s*c.*$"
syn match mcnpComment "$.*$"

syn match mcnpKeywords "m\d\+"
syn match mcnpKeywords "mt\d\+"
syn keyword mcnpConstant lwtr
syn match mcnpKeywords "xs\d\+"
syn keyword mcnpKeywords nonu totnu awtab void pikmt mgopt

" Tallies.
syn match mcnpKeywords "c\d\+"
syn match mcnpKeywords "cf\d\+"
syn match mcnpKeywords "cm\d\+"
syn match mcnpKeywords "dd\d\+"
syn match mcnpKeywords "\De\d\+"
syn match mcnpKeywords "em\d\+"
syn match mcnpKeywords "f\d\+"
syn match mcnpKeywords "fic\d\+"
syn match mcnpKeywords "fip\d\+"
syn match mcnpKeywords "fir\d\+"
syn match mcnpKeywords "fm\d\+"
syn match mcnpKeywords "fs\d\+"

syn match mcnpKeywords "ft\d\+"
syn keyword mcnpKeywords frv geb tmc inc icd scx scd ptt elc

syn match mcnpKeywords "fu\d\+"
syn match mcnpKeywords "fq\d\+"
syn match mcnpKeywords "sd\d\+"
syn match mcnpKeywords "sf\d\+"
syn match mcnpKeywords "t\d\+"
syn match mcnpKeywords "tf\d\+"
syn match mcnpKeywords "tm\d\+"

syn keyword mcnpKeywords de
syn keyword mcnpKeywords df
syn match mcnpKeywords "d[ef]\d\+"

syn match mcnpKeywords "fmesh\d\+"
syn keyword mcnpKeywords geom origin axs vec emesh imesh jmesh kmesh tmesh eints iints jints kints tints out tr
syn keyword mcnpConstant xyz rzt col cf

syn match mcnpConstant ":[enp]"

" General data cards.
syn keyword mcnpKeywords print dbcn nps prdmp cut dd wwn fcl ext dxt dxc sb esplt tsplt
syn match mcnpConstant "\d*j"

" UM data cards.
syn keyword mcnpKeywords embed meshgeo mgeoin meeout length background matcel embee

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Final actions.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let b:current_syntax = "mcnp"

hi link mcnpComment     Comment
hi link mcnpConstant    Constant
hi link mcnpKeywords    Keyword
