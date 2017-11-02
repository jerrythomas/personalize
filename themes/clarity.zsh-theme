# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background and the font Inconsolata.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
#

# load some modules
autoload -U colors zsh/terminfo # Used in the colour alias below
colors
setopt prompt_subst

#VCS Info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable hg git bzr svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats "%{$fg[white]%}on%{$reset_color%} <%s %{$fg[blue]%}%b%{$reset_color%} %m%u%c%{$reset_color%}> "
precmd() {
    vcs_info
}
local vcs_prompt='${vcs_info_msg_0_}%'

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# vcs info
ZSH_VCS_PROMPT_ENABLE_CACHING='true'

# Git info.
#local git_info='$(git_prompt_info)'
#ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}on%{$reset_color%} git:%{$fg[blue]%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗"
#ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔"
#ZSH_THEME_GIT_PROMPT_AHEAD=" %{$fg[yellow]%}⚡"

# Svn info
#local svn_info='$(svn_prompt_info)'
#ZSH_THEME_SVN_PROMPT_DIRTY=" %{$fg[red]%}✗"
#ZSH_THEME_SVN_PROMPT_CLEAN=" %{$fg[green]%}✔"

local fg_user=''
local fg_host=''

if [[ $UID -eq 0 ]]; then
  eval fg_user='%{$fg[red]%}'
else
  eval fg_user='%{$fg[green]%}'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  eval fg_host='%{$fg[yellow]%}'
else
  eval fg_host='%{$fg[cyan]%}'
fi

#function hg_prompt_info {
#    hg prompt --angle-brackets "\
#< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
#< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
#%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
#patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
#}
local user_host='%{$fg_user%}%n%{$reset_color%}@%{$fg_host%}%M%{$fg[blue]%}'

#%{$fg[magenta]%}[%*]
PROMPT="
%{$fg[blue]%}╭─{%{$user_host%}} \
%{$fg[white]%}in \
%{$fg[yellow]%}${current_dir}%{$reset_color%} \
${vcs_prompt} 
%{$fg[blue]%}╰─❯%{$reset_color%} "
