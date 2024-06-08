if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
zoxide init fish | source

alias update="sudo nixos-rebuild switch"
alias config="nvim /etc/nixos/configuration.nix"
alias flake="nvim /etc/nixos/flake.nix"
alias cd="z"
alias ls="exa --icons"
alias ll="exa --icons -al"
# alias nix-shell="nix-shell --command \"$(readlink -f $(whereis fish))\""

set NNN_PLUG 'f:finder;o:fzopen;p:mocq;d:diffs;t:nmount;v:imgview'

set PRISMA_SCHEMA_ENGINE_BINARY '/nix/store/k44ixf552znp5vcchr22m9f4jwmcd45q-system-path/bin/schema-engine'
set PRISMA_QUERY_ENGINE_BINARY '/nix/store/k44ixf552znp5vcchr22m9f4jwmcd45q-system-path/bin/query-engine'
set PRISMA_QUERY_ENGINE_LIBRARY '/nix/store/k44ixf552znp5vcchr22m9f4jwmcd45q-system-path/lib/libquery_engine.node'
set PRISMA_INTROSPECTION_ENGINE_BINARY '/nix/store/k44ixf552znp5vcchr22m9f4jwmcd45q-system-path/bin/introspection-engine'
set PRISMA_FMT_BINARY '/nix/store/k44ixf552znp5vcchr22m9f4jwmcd45q-system-path/bin/prisma-fmt'

direnv hook fish | source

