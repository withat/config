function prompt_char {
	git branch >/dev/null 2>/dev/null && echo '
±' && return
	hg root >/dev/null 2>/dev/null && echo '
☿' && return
	echo '○'
}

PROMPT='%{$fg[red]%} %?%{$reset_color%}%#%{$fg[blue]%}%n%{$reset_color%}@%{$fg[cyan]%}%m %{$reset_color%}in %{$fg[yellow]%}%c%{$reset_color%}$(git_prompt_info) $(prompt_char) '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

