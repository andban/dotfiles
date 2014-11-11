export ZSH_HOME=~/.zsh

# init auto completion
autoload -U compinit
compinit -i

# do not beep
setopt no_beep


# load config files
for f in $ZSH_HOME/lib/*.zsh; do
    source $f
done
