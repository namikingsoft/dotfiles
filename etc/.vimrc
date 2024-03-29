" Only iMproved
if &compatible
    set nocompatible
endif

" dein 設定 {
    " Set dein base path (required)
    let s:dein_base = $HOME . '/.cache/dein/'
    " Set dein source path (required)
    let s:dein_src = $HOME . '/.cache/dein/repos/github.com/Shougo/dein.vim'
    " Clone dein
    if !isdirectory(s:dein_src)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_src
    endif
    " Set dein runtime path (required)
    execute 'set runtimepath+=' . s:dein_src
    " Call dein initialization (required)
    call dein#begin(s:dein_base)
    call dein#add(s:dein_src)
    " プラグイン設定
    " lightline
    call dein#add('itchyny/lightline.vim')
    " Vdebug for python2
    call dein#add('joonty/vdebug', { 'rev': '1bff0b1' })
    " smooth-scroll
    call dein#add('yonchu/accelerated-smooth-scroll')
        " エイリアス
        nmap <silent> <C-s> <Plug>(ac-smooth-scroll-c-d)
        nmap <silent> <C-a> <Plug>(ac-smooth-scroll-c-u)
    " Emmet
    call dein#add('mattn/emmet-vim')
    " unite-outline
    call dein#add('Shougo/unite.vim')
    call dein#add('Shougo/unite-outline')
        let g:unite_split_rule = 'botright'
        noremap <Space>o <ESC>:Unite -vertical -winwidth=40 outline<Return>
    " Ag
    call dein#add('rking/ag.vim')
    " fugitive (git)
    call dein#add('tpope/vim-fugitive')
    " Markdown
    call dein#add('plasticboy/vim-markdown')
    call dein#add('kannokanno/previm')
    call dein#add('tyru/open-browser.vim')
        " 折りたたみ設定
        let g:vim_markdown_folding_disabled=1
        let g:vim_markdown_initial_foldlevel=3
        " md as markdown, instead of modula2
        au BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
        au BufNewFile,BufReadPost *.{md,mdwn,mkd,mkdn,mark*} setl tabstop=2 shiftwidth=2 expandtab
        " Disable highlight italic in Markdown
        autocmd FileType markdown hi! def link markdownItalic LineNr
    " PlantUML
    " call dein#add('aklt/plantuml-syntax')
    call dein#add('namikingsoft/plantuml-syntax')
        au BufNewFile,BufReadPost *.{pu,puml} setl tabstop=2 shiftwidth=2 expandtab
    " Qfreplace
    call dein#add('thinca/vim-qfreplace')
    " ctrlp
    call dein#add('kien/ctrlp.vim')
        set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png,*.gif
        let g:ctrlp_custom_ignore = '\v[\/](node_modules|build|.git|vendor)$'
        let g:ctrlp_show_hidden = 1
    " Scala
    call dein#add('derekwyatt/vim-scala')
        au BufNewFile,BufRead *.scala setf scala
        au BufNewFile,BufReadPost *.scala setl tabstop=2 shiftwidth=2 expandtab
    " Haskell
    call dein#add('dag/vim2hs')
    " Golang for vim 7.3
    call dein#add('fatih/vim-go', { 'rev' : '3030ecc' })
    " Rust
    call dein#add('rust-lang/rust.vim')
    " JavaScript
    call dein#add('namikingsoft/ts4js-vim')
    call dein#add('elzr/vim-json')
        au BufNewFile,BufReadPost *.{js,jsx,json,es6} setl tabstop=2 shiftwidth=2 expandtab
    " TypeScript
    call dein#add('https://github.com/leafgarland/typescript-vim.git')
        au BufNewFile,BufReadPost *.{ts,tsx} setl tabstop=2 shiftwidth=2 expandtab
    " Coffee-Script
    call dein#add('kchmck/vim-coffee-script')
    call dein#add('mtscout6/vim-cjsx')
        au BufRead,BufNewFile *.{coffee,cjsx}            set filetype=coffee
        au BufNewFile,BufReadPost *.{coffee,cjsx} setl tabstop=2 shiftwidth=2 expandtab
    " Jade
    call dein#add('digitaltoad/vim-jade')
        au BufRead,BufNewFile *.jade            set filetype=jade
        au BufNewFile,BufReadPost *.jade setl tabstop=2 shiftwidth=2 expandtab
    " Ace
    call dein#add('yosssi/vim-ace')
        au BufNewFile,BufReadPost *.ace setl tabstop=2 shiftwidth=2 expandtab
    " Slim
    call dein#add('slim-template/vim-slim')
        au BufNewFile,BufReadPost *.slim setl tabstop=2 shiftwidth=2 expandtab
    " Yaml
    call dein#add('roalddevries/yaml.vim')
        au BufRead,BufNewFile *.{yml,yaml}         set filetype=yaml
        au BufNewFile,BufReadPost *.{yml,yaml} setl tabstop=2 shiftwidth=2 expandtab
    " XML
        au BufNewFile,BufReadPost *.xml setl tabstop=2 shiftwidth=2 expandtab
    " Twig
    call dein#add('evidens/vim-twig')
        au BufNewFile,BufReadPost *.twig setl tabstop=2 shiftwidth=2 expandtab
    " Feature
    call dein#add('tpope/vim-cucumber')
        au BufNewFile,BufReadPost *.feature setl tabstop=2 shiftwidth=2 expandtab
    " HTML5
    call dein#add('othree/html5.vim')
        au BufNewFile,BufReadPost *.html setl tabstop=2 shiftwidth=2 expandtab
    " Shell
    au BufNewFile,BufReadPost *.sh setl tabstop=2 shiftwidth=2 expandtab
    " Sass/Scss
    call dein#add('cakebaker/scss-syntax.vim')
    au BufRead,BufNewFile *.{sass,scss,pcss,css} set filetype=scss.css
    au BufNewFile,BufReadPost *.{sass,scss,pcss,css} setl tabstop=2 shiftwidth=2 expandtab
    " less
    call dein#add('groenewege/vim-less')
        au BufNewFile,BufReadPost *.less setl tabstop=2 shiftwidth=2 expandtab
    " Stylus
    call dein#add('wavded/vim-stylus')
        au BufNewFile,BufReadPost *.styl setl tabstop=2 shiftwidth=2 expandtab
    " Dockerfile
    call dein#add('ekalinin/Dockerfile.vim')
    " Terraform
    call dein#add('hashivim/vim-terraform')
    " vim-indent-guides
    call dein#add('nathanaelkane/vim-indent-guides')
        let g:indent_guides_auto_colors=0
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=236
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=234
        let g:indent_guides_enable_on_vim_startup=1
        let g:indent_guides_guide_size=1
    " neosnippet for vim 7.3
    call dein#add('Shougo/neosnippet', { 'rev' : 'dcf2d85' })
        " Plugin key-mappings.
        imap <C-k>     <Plug>(neosnippet_expand_or_jump)
        smap <C-k>     <Plug>(neosnippet_expand_or_jump)
        xmap <C-k>     <Plug>(neosnippet_expand_target)
        " SuperTab like snippets behavior.
        imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: pumvisible() ? "\<C-n>" : "\<TAB>"
        smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: "\<TAB>"
        " For snippet_complete marker.
        if has('conceal')
        set conceallevel=2 concealcursor=i
        endif
    " Syntastic
    call dein#add('scrooloose/syntastic.git')
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*
        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 1
        let g:syntastic_check_on_open = 0
        let g:syntastic_check_on_wq = 0
        let g:syntastic_javascript_checkers = ['flow', 'eslint']
    " Default Snippets
    call dein#add('Shougo/neosnippet-snippets')
    " GitHub Actions
    call dein#add('rhysd/vim-github-actions')
    " Binary Editor
    call dein#add('Shougo/vinarise')
    " Nasm
    " autocmd BufNewFile,BufRead *.asm set filetype=nasm

    call dein#end()

    " Uncomment if you want to install not-installed plugins on startup.
    if dein#check_install()
      call dein#install()
    endif
" }

" 標準プラグイン設定 {
    " ファイルタイプ有効化
    filetype plugin indent on

    " Netrw - 標準ファイラ
    " :e . - カレントバッファで開く
    " :tabe . - 新タブで開く
    " :Lex . - カレントタブの左側で開く
    " ツリー表示
    let g:netrw_liststyle = 3
    " 開いた位置を current dir として扱う
    let g:netrw_keepdir = 0
    " トップバナー非表示
    let g:netrw_banner = 0
    " window サイズ
    let g:netrw_winsize = 20
    " Ctrl + e で Lexplore をトグルする
    " https://www.reddit.com/r/vim/comments/6jcyfj/comment/djdmsal/
    let g:netrw_fastbrowse = 0
    autocmd FileType netrw setl bufhidden=wipe
    let g:NetrwIsOpen=0
    function! ToggleNetrw()
        if g:NetrwIsOpen
            let i = bufnr("$")
            while (i >= 1)
                if (getbufvar(i, "&filetype") == "netrw")
                    silent exe "bwipeout " . i
                endif
                let i-=1
            endwhile
            let g:NetrwIsOpen=0
        else
            let g:NetrwIsOpen=1
            silent Lexplore
        endif
    endfunction
    noremap <silent> <C-E> :call ToggleNetrw()<CR>
    " Lexplore などで選択後、netrw バッファを閉じるように
    " Close after opening a file (which gets opened in another window):
    " https://stackoverflow.com/questions/61766814/close-netrw-explorer-after-opening-a-new-file
    let g:netrw_fastbrowse = 0
    autocmd FileType netrw setl bufhidden=wipe
    function! CloseNetrw() abort
      for bufn in range(1, bufnr('$'))
        if bufexists(bufn) && getbufvar(bufn, '&filetype') ==# 'netrw'
          silent! execute 'bwipeout ' . bufn
          if getline(2) =~# '^" Netrw '
            silent! bwipeout
          endif
          return
        endif
      endfor
    endfunction
    augroup closeOnOpen
      autocmd!
      autocmd BufWinEnter * if getbufvar(winbufnr(winnr()), "&filetype") != "netrw"|call CloseNetrw()|endif
    aug END
" }

" キーバインド {
    " 設定ファイル編集(Space + .)
    nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>
    " 設定ファイル適用(Space + r)
    nnoremap <Space>r :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
    " Esc代替(Ctrl + c)
    inoremap <C-c> <Esc>
    "カーソルを表示行で移動する。物理行移動は<C-n>,<C-p>
    nnoremap j gj
    nnoremap k gk
    nnoremap <Down> gj
    nnoremap <Up>   gk
" }

" 基本設定 {
    " カーソル設定
    set cursorline
    set nocursorcolumn
    " ステータスタブラインを常に表示
    set laststatus=2
    set showtabline=2
    " バックアップ/スワップファイルなし
    set nowritebackup
    set nobackup
    set noswapfile
    " 色表示
    set t_Co=256
    colorscheme desert
    syntax on
    " 色設定(行番号)
    highlight LineNr ctermfg=130 ctermbg=234
    " 色設定(変換候補)
    highlight Pmenu ctermbg=16 ctermfg=8 guifg=#000000 guibg=#999999
    highlight PmenuSel ctermbg=blue ctermfg=black
    highlight PmenuSbar ctermbg=0 ctermfg=9
    highlight PmenuSbar ctermbg=255 ctermfg=0 guifg=#000000 guibg=#FFFFFF
    " 色設定(vimdiff)
    hi DiffAdd    ctermfg=black ctermbg=2
    hi DiffChange ctermfg=black ctermbg=3
    hi DiffDelete ctermfg=black ctermbg=6
    hi DiffText   ctermfg=black ctermbg=7
    " 行数表示
    set number
    " 自動改行しない
    set formatoptions=q
    " 折りたたみ設定 (マーカー有効)
    set foldmethod=marker
    " 折りたたみ無効
    set nofoldenable
    " 改行時のコメント挿入を無効化
    autocmd FileType * setlocal formatoptions-=ro
    " タブを半角空白2つにする
    set expandtab
    set tabstop=2
    set shiftwidth=2
    " 自動インデント
    set autoindent
    " use `vim-indent-guides` instead of
    " vim でタブや全角スペースを表示する
    " set list listchars=tab:¦_
    " highlight SpecialKey ctermfg=darkmagenta
    highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
    au BufRead,BufNew * match JpSpace /　/
    " 保存時に行末の空白を除去する
    "autocmd BufEnter * autocmd BufWritePre * :%s/\s\+$//ge
    " Markdownの場合は行末の空白を除去しない
    "autocmd BufEnter *.{md,mdwn,mkd,mkdn,mark*} autocmd! BufWritePre *
    " 全角記号を入力しても、ずれないようにする
    set ambiwidth=double
" }

" 検索設定 {
    " 検索の時に大文字小文字を区別しない
    set ignorecase
    " ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
    set smartcase
    " 検索時にファイルの最後まで行ったら最初に戻る
    set wrapscan
    " インクリメンタルサーチ
    set incsearch
    " 検索文字の強調表示
    set hlsearch
    " grepコマンドでQuickFixを開くように
    autocmd QuickFixCmdPost vimgrep copen
" }
