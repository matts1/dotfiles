" CPP files use c.vim

nmap <leader>d :w<CR><leader>r:VBGkill<CR>:call vebugger#gdb#start('main', {'args': []})<CR>
imap <leader>d <ESC>:w<CR><leader>r:VBGkill<CR>:call vebugger#gdb#start('main', {'args': []})<CR>i

imap {<CR> {<CR><BACKSPACE>}<ESC>O
