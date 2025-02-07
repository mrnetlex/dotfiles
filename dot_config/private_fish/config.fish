if status is-interactive
    # Commands to run in interactive sessions can go here

    #Remove welcome message
    set fish_greeting

    # Use Homebrew (needs to go first so things like zoxide and starship works later)

    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    
    ## Useful aliases

    # Replace ls with eza
    alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
    alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs
    alias ll='eza -l --color=always --group-directories-first --icons'  # long format
    alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
    alias l.="eza -a | egrep '^\.'"                                     # show only dotfiles
    alias ip="ip -color"
    
    # Replace some more things with better alternatives
    alias cat='bat --style header --style snip --style changes'
    [ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'
 
    # Common use
    alias grubup="sudo update-grub"
    alias fixpacman="sudo rm /var/lib/pacman/db.lck"
    alias tarnow='tar -acf '
    alias untar='tar -xvf '
    alias wget='wget -c '
    alias rmpkg="sudo pacman -Rdd"
    alias psmem='ps auxf | sort -nr -k 4'
    alias psmem10='ps auxf | sort -nr -k 4 | head -10'
    alias upd='/usr/bin/update'
    alias ..='cd ..'
    alias ...='cd ../..'
    alias ....='cd ../../..'
    alias .....='cd ../../../..'
    alias ......='cd ../../../../..'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='rg'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias hw='hwinfo --short'                                   # Hardware Info
    alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB
    alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'			# List amount of -git packages
    alias tp='trash-put'
    alias systui='systemctl-tui'
    alias lg='lazygit'
    alias cz='chezmoi'

    # Get fastest mirrors
    alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
    alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
    alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
    alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

    # Add /home/netlex/bin and all its subdirectories to PATH
    # for dir in /home/netlex/bin /home/netlex/bin/*(/)
        # if test -d $dir
            # set -x PATH $dir $PATH
        # end
    # end
    
        
    ## Functions
        # Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
        function __history_previous_command
          switch (commandline -t)
          case "!"
            commandline -t $history[1]; commandline -f repaint
          case "*"
            commandline -i !
          end
        end
        
        function __history_previous_command_arguments
          switch (commandline -t)
          case "!"
            commandline -t ""
            commandline -f history-token-search-backward
          case "*"
            commandline -i '$'
          end
        end
        
        if [ "$fish_key_bindings" = fish_vi_key_bindings ];
          bind -Minsert ! __history_previous_command
          bind -Minsert '$' __history_previous_command_arguments
        else
          bind ! __history_previous_command
          bind '$' __history_previous_command_arguments
        end
        
        # Fish command history
        function history
            builtin history --show-time='%F %T '
        end
        
        function backup --argument filename
            cp $filename $filename.bak
        end

        ########## CLI utilities        

        #micro
        set -Ux EDITOR micro
        set MICRO_TRUECOLOR 1 #better colors

        #zoxide 
        zoxide init fish | source

        #fzf
        fzf --fish | source
            
        #starship
        starship init fish | source
        enable_transience

        #atuin
        atuin init fish | source

        #iotop fix
        export TERM=xterm-256color

        #yazi
        function ya
             set tmp (mktemp -t "yazi-cwd.XXXXX")
             yazi $argv --cwd-file="$tmp"
             if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
             	cd -- "$cwd"
             end
             rm -f -- "$tmp"
        end
        
    ##  Themes
         #TokyoNight Color Palette
            set -l foreground c0caf5
            set -l selection 33467C
            set -l comment 565f89
            set -l red f7768e
            set -l orange ff9e64
            set -l yellow e0af68
            set -l green 9ece6a
            set -l purple 9d7cd8
            set -l cyan 7dcfff
            set -l pink bb9af7
            
        #Syntax Highlighting Colors
            set -g fish_color_normal $foreground
            set -g fish_color_command $cyan
            set -g fish_color_keyword $pink
            set -g fish_color_quote $yellow
            set -g fish_color_redirection $foreground
            set -g fish_color_end $orange
            set -g fish_color_error $red
            set -g fish_color_param $purple
            set -g fish_color_comment $comment
            set -g fish_color_selection --background=$selection
            set -g fish_color_search_match --background=$selection
            set -g fish_color_operator $green
            set -g fish_color_escape $pink
            set -g fish_color_autosuggestion $comment
            
        #Completion Pager Colors
            set -g fish_pager_color_progress $comment
            set -g fish_pager_color_prefix $cyan
            set -g fish_pager_color_completion $foreground
            set -g fish_pager_color_description $comment

    #run fetch    
fastfetch --config /home/netlex/.config/fastfetch/full.jsonc
    end
