" NeoBundle {
    " 初期化
    if has('vim_starting')
        set nocompatible " Viとの互換性なし
        set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif
    call neobundle#rc(expand('~/.vim/bundle/'))
    " NeoBundle
    NeoBundleFetch 'Shougo/neobundle.vim'
    " Vdebug
    "NeoBundle 'joonty/vdebug'
    NeoBundle 'namikingsoft/vdebug'
    " Emmet
    NeoBundle 'mattn/emmet-vim'
    " Ag
    NeoBundle 'rking/ag.vim'
    " Qfreplace
    NeoBundle 'thinca/vim-qfreplace'
    " ctrlp
    NeoBundle 'kien/ctrlp.vim'
    " Coffee-Script
    NeoBundle 'kchmck/vim-coffee-script'
        au BufRead,BufNewFile *.coffee            set filetype=coffee
        au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
    " Jade
    NeoBundle 'digitaltoad/vim-jade'
        au BufRead,BufNewFile *.jade            set filetype=jade
        au BufNewFile,BufReadPost *.jade setl shiftwidth=2 expandtab
    " JS BDDツール
    NeoBundle 'claco/jasmine.vim'
    " nerdtree
    NeoBundle 'scrooloose/nerdtree'
        nmap <silent> <C-e>      :NERDTreeToggle<CR>
        vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
        omap <silent> <C-e>      :NERDTreeToggle<CR>
        imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
        cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>
        "autocmd vimenter * if !argc() | NERDTree | endif "起動時にNerdTreeを開く
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
        let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']
        let g:NERDTreeShowHidden=1
        let g:NERDTreeQuitOnOpen=1
        let g:NERDTreeMinimalUI=1
        let g:NERDTreeDirArrows=0
        let g:NERDTreeMouseMode=2
    " neocompicache
    NeoBundle 'Shougo/neocomplcache.vim'
        " Disable AutoComplPop.
        let g:acp_enableAtStartup = 0
        " Use neocomplcache.
        let g:neocomplcache_enable_at_startup = 1
        " Use smartcase.
        let g:neocomplcache_enable_smart_case = 1
        " Set minimum syntax keyword length.
        let g:neocomplcache_min_syntax_length = 3
        let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
        " Define dictionary.
        let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : ''
            \ }
        " Plugin key-mappings.
        inoremap <expr><C-g>     neocomplcache#undo_completion()
        inoremap <expr><C-l>     neocomplcache#complete_common_string()
        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
          return neocomplcache#smart_close_popup() . "\<CR>"
        endfunction
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplcache#close_popup()
        inoremap <expr><C-e>  neocomplcache#cancel_popup()
    " neosnippet
    NeoBundle 'Shougo/neosnippet'
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
    " Default Snippets
    NeoBundle 'Shougo/neosnippet-snippets'

    " ファイルタイプ有効化
    filetype plugin indent on
    " バンドルチェック
    NeoBundleCheck
" }

" キーバインド {
    " 設定ファイル編集(Space + .)
    nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>
    " 設定ファイル適用(Space + r)
    nnoremap <Space>r :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
    " Esc代替(Ctrl + c)
    inoremap <C-c> <Esc>
" }

" 基本設定 {
    " バックアップ/スワップファイルなし
    set nowritebackup
    set nobackup
    set noswapfile
    " 行数表示
    set number
    " 自動改行しない
    set formatoptions=q
    " 改行時のコメント挿入を無効化
    autocmd FileType * setlocal formatoptions-=ro
    " タブを半角空白４つにする
    set expandtab
    set tabstop=4
    set shiftwidth=4
    " 自動インデント
    set autoindent
    " vim でタブや全角スペースを表示する
    set lcs=tab:>.,trail:_,extends:\
    set list
    highlight SpecialKey cterm=NONE ctermfg=7 guifg=7
    highlight JpSpace cterm=underline ctermfg=7 guifg=7
    au BufRead,BufNew * match JpSpace /　/
    " 保存時に行末の空白を除去する
    autocmd BufWritePre * :%s/\s\+$//ge
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
    " w,bの移動で認識する文字
    "set iskeyword=a-z,A-Z,48-57,_,.,-,>
    " vimgrep をデフォルトのgrepとする場合internal
    "set grepprg=internal
" }
