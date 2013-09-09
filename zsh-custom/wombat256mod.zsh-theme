function prompt_char {
	git branch >/dev/null 2>/dev/null && echo '±' && return
	hg root >/dev/null 2>/dev/null && echo '☿' && return
	echo '➜'
}

BLUE="$FG[111]"
LBLUE="$FG[251]"
RED="$FG[173]"
GREEN="$FG[113]"
LGREEN="$FG[192]"
OLIVE="$FG[186]"
BEIGE="$FG[229]"
GRAY="$FG[246]"
YEYLLOW="$FG[228]"


PROMPT='%{$fg_bold[blue]%}%p %{$fg[red]%}%c %{$fg_bold[green]%}$(prompt_char)$(git_prompt_info)%{$fg_bold[green]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%!"
ZSH_THEME_GIT_PROMPT_CLEAN=""
