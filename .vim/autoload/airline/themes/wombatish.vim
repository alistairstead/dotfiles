" vim-airline theme of wombatishish

" Normal mode
"          [ guifg, guibg, ctermfg, ctermbg, opts ]
let s:N1 = [ '#005f00' , '#afd700' , 22  , 148 ] " mode
let s:N2 = [ '#9e9e9e' , '#303030' , 247 , 239 ] " info
let s:N3 = [ '#ffffff' , '#121212' , 242 , 236 ] " statusline
let s:N4 = [ '#afd700' , 148 ]                   " mode modified

" Insert mode
let s:I1 = [ '#005f5f' , '#ffffff' , 23  , 231 ]
let s:I2 = [ '#5fafd7' , '#0087af' , 74  , 31  ]
let s:I3 = [ '#87d7ff' , '#005f87' , 117 , 24  ]
let s:I4 = [ '#ffffff' , 231 ]

" Visual mode
let s:V1 = [ '#080808' , '#ffaf00' , 232 , 214 ]
let s:V2 = [ '#9e9e9e' , '#303030' , 247 , 239 ]
let s:V3 = [ '#ffffff' , '#121212' , 242 , 236 ]
let s:V4 = [ '#7CB0E6' , 111 ]

" Replace mode
let s:R1 = [ '#ffffff' , '#d70000' , 231 , 160 ]
let s:R2 = [ '#E5786D' , '#32322F' , 173 , 236 ]
let s:R3 = [ '#E5786D' , '#242424' , 173 , 234 ]
let s:R4 = [ '#E55345' , 203 ]

" Paste mode
let s:PA = [ '#94E42C' , 47 ]

" Info modified
let s:IM = [ '#40403C' , 238 ]

" Inactive mode
let s:IA = [ '#767676' , s:N3[1] , 243 , s:N3[3] , '' ]

let g:airline#themes#wombatish#palette = {}

let g:airline#themes#wombatish#palette.accents = {
      \ 'red': [ '#E5786D' , '' , 203 , '' , '' ],
      \ }

let g:airline#themes#wombatish#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#wombatish#palette.normal_modified = {
    \ 'airline_a': [ s:N1[0] , s:N1[1] , s:N1[2] , s:N1[3] , ''     ] ,
    \ 'airline_b': [ s:N4[0] , s:IM[0] , s:N4[1] , s:IM[1] , ''     ] ,
    \ 'airline_c': [ s:N3[0] , s:N3[1] , s:N3[2] , s:N3[3] , ''     ] }


let g:airline#themes#wombatish#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)

let g:airline#themes#wombatish#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)

let g:airline#themes#wombatish#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

let g:airline#themes#wombatish#palette.insert_paste = {
    \ 'airline_a': [ s:I1[0] , s:PA[0] , s:I1[2] , s:PA[1] , ''     ] ,
    \ 'airline_b': [ s:PA[0] , s:IM[0] , s:PA[1] , s:IM[1] , ''     ] ,
    \ 'airline_c': [ s:PA[0] , s:N3[1] , s:PA[1] , s:N3[3] , ''     ] }


let g:airline#themes#wombatish#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#wombatish#palette.inactive_modified = {
    \ 'airline_c': [ s:N4[0] , ''      , s:N4[1] , ''      , ''     ] }


if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
let g:airline#themes#wombatish#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ '#DADADA' , '#242424' , 253 , 234 , ''     ] ,
      \ [ '#DADADA' , '#40403C' , 253 , 238 , ''     ] ,
      \ [ '#141413' , '#DADADA' , 232 , 253 , 'bold' ] )

