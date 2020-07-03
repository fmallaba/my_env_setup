syn match fileName "\/[^:\/]*:" 
syn match fileNameSlash "^[^:\/]*:"
syn match lineNumber "[0-9]\+:"

hi fileName ctermfg=148
hi fileNameSlash ctermfg=148
hi lineNumber ctermfg=31
