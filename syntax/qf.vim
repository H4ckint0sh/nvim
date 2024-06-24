if exists('b:current_syntax')
    finish
endif

syn match qfFileName /^[^│]*/ nextgroup=qfSeparatorLeft
syn match qfSeparatorLeft /│/ contained nextgroup=qfLineNr
syn match qfLineNr /[^│]*/ contained nextgroup=qfSeparatorRight
syn match qfSeparatorRight '│' contained nextgroup=qfError,qfWarning,qfInfo,qfNote
syn match qfError / E .*$/ contained
syn match qfWarning / W .*$/ contained
syn match qfInfo / I .*$/ contained
syn match qfNote / [NH] .*$/ contained

hi def link qfPreviewFloat Normal
hi def link qfPreviewBorder FloatBorder
hi def link qfPreviewTitle Title
hi def link qfPreviewThumb PmenuThumb
hi def link qfPreviewSbar PmenuSbar
hi def link qfPreviewCursor Cursor
hi def link qfPreviewCursorLine CursorLine
hi def link qfPreviewRange IncSearch
hi def link qfPreviewBufLabel BqfPreviewRange

let b:current_syntax = 'qf'
