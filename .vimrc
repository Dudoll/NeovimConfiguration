filetype plugin indent on
syntax enable


call plug#begin()
Plug 'lervag/vimtex', {'for':'tex'}
Plug 'vim-latex/vim-latex', {'for':'tex'}
call plug#end()

"======================================vimtex===========================
"LaTeX配置
let g:tex_flavor='latex'
let g:vimtex_texcount_custom_arg=' -ch -total'
"映射VimtexCountWords！\lw 在命令模式下enter此命令可统计中英文字符的个数
au FileType tex map <buffer> <silent>  <leader>lw :VimtexCountWords!  <CR><CR>
let g:Tex_ViewRule_pdf = '/mnt/f/SumatraPDF/SumatraPDF.exe -reuse-instance -inverse-search "gvim -c \":RemoteOpen +\%l \%f\""'

"这里是LaTeX编译引擎的设置，这里默认LaTeX编译方式为-pdf(pdfLaTeX),
"vimtex提供了magic comments来为文件设置编译方式
"例如，我在tex文件开头输入 % !TEX program = xelatex   即指定-xelatex （xelatex）编译文件
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-pdf',
    \ 'pdflatex'         : '-pdf',
    \ 'dvipdfex'         : '-pdfdvi',
    \ 'lualatex'         : '-lualatex',
    \ 'xelatex'          : '-xelatex',
    \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
    \ 'context (luatex)' : '-pdf -pdflatex=context',
    \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
    \}
"这里是设置latexmk工具的可选参数
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-shell-escape',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

" 阅读器相关的配置 包含正反向查找功能 仅供参考
let g:vimtex_view_general_viewer = '/mnt/f/SumatraPDF/SumatraPDF.exe' "这里放置你的sumatrapdf 安装路径
"let g:vimtex_view_general_options_latexmk = '-reuse-instance'
let g:vimtex_view_general_options
\ = '-reuse-instance -forward-search @tex @line @pdf'
\ . ' -inverse-search "' . exepath(v:progpath)
\ . ' --servername ' . v:servername
\ . ' --remote-send \"^<C-\^>^<C-n^>'
\ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
\ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
\ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'


"编译过程中忽略警告信息
let g:vimtex_quickfix_open_on_warning=0
"======================================vimtex end===========================

