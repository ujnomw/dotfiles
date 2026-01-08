# OMZ_THEME: romkatv/powerlevel10k
# OMZ_PLUGIN: zsh-users/zsh-autosuggestions
# OMZ_PLUGIN: zsh-users/zsh-syntax-highlighting

# Enable Powerlevel10k theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
