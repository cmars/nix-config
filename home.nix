{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "c";
  home.homeDirectory = "/home/c";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";

  home.packages = with pkgs; [
    apg
    borgbackup
    docker-compose
    gopass
    kubectl
    helm
  ];

  home.sessionPath = [
    "~/.local/bin"
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.bash = {
    enable = true;
    enableVteIntegration = true;
    historyControl = [ "erasedups" "ignoredups" ];
    initExtra = ''
      set -o vi
    '';
  };

  programs.fzf.enable = true;

  programs.git = {
    enable = true;
    userName = "Casey Marshall";
    userEmail = "git@cmars.tech";
    #extraConfig = { url = { ssh://git@github.com/ = { insteadOf "https://github.com/"; }; }; }
    ignores = [ ".*.swp" ];
    signing = {
      key = "6B787E5FB493FA4FD0095D106DEC2758ACD5A973";
      signByDefault = true;
    };
  };

  programs.gpg.enable = true;

  programs.jq.enable = true;

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nerdtree
      rust-vim
      vim-airline
      vim-go
      vim-lsp
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      set showcmd
      map <Leader>n :NERDTree<cr>
      
      " buffer magic
      map <Leader>[ :bp<cr>
      map <Leader>] :bn<cr>
      
      " splits
      map <Leader>- :split<cr>
      map <Leader><Bar> :vsplit<cr>
      
      " window magic
      noremap <C-Down> <C-W>j
      noremap <C-Up> <C-W>k
      noremap <C-Left> <C-W>h
      noremap <C-Right> <C-W>l
      noremap <C-J> <C-W>j
      noremap <C-K> <C-W>k
      noremap <C-H> <C-W>h
      noremap <C-L> <C-W>l
      
      " tab indent with 4 spaces
      set expandtab tabstop=4 shiftwidth=4
      
      " case insensitive searching, unless mixed case
      set ignorecase
      set smartcase
      
      " colors
      syntax on
      " colorscheme onedark
      " let g:airline_theme='onedark'
      
      filetype on
      filetype plugin on
      
      autocmd FileType javascript setlocal expandtab tabstop=2
      autocmd FileType typescript setlocal expandtab tabstop=2
      
      let g:rustfmt_autosave = 1
      let g:rustfmt_command = "rustup run nightly rustfmt"
      
      au BufRead,BufNewFile *.dl             set filetype=dl
      
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#buffer_nr_show = 1
      
      let g:NERDTreeHighlightCursorline = 1
      let g:nerdtree_sync_cursorline = 1
    '';
  };

  programs.ssh = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    shortcut = "a";
    escapeTime = 5;  # Default 500ms wrecks neovim
    extraConfig = ''
      # THEME
      set -g status-bg black
      set -g status-fg white
      set -g status-interval 60
      set -g status-left-length 30
      set -g status-left '#[fg=green](#S) #(whoami)@#H#[default]'
      set -g status-right '#[fg=yellow]#(cut -d " " -f 1-3 /proc/loadavg)#[default] #[fg=blue]%H:%M#[default]'
      
      #--Key-Bindings-----------------------------------------------------------------
      bind | split-window -h
      bind _ split-window -v
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      
      # l is for last window by default
      bind l select-pane -R
    '';
  };

  #programs.vscode = {
  #  enable = true;
  #};

  programs.zathura = {
    enable = true;
  };

  #services.gpg-agent = {
  #  enable = true;
  #  defaultCacheTtl = 900;
  #  enableSshSupport = true;
  #  maxCacheTtl = 900;
  #  maxCacheTtlSsh = 900;
  #  sshKeys = [ "6B787E5FB493FA4FD0095D106DEC2758ACD5A973" ];
  #};
}
