# vim:ft=zsh ts=2 sw=2 sts=2 et

#PROMPT='%{$fg_bold[blue]%}%p %{$fg[red]%}%c %{$fg_bold[green]%}$(prompt_char)$(git_prompt_info)%{$fg_bold[green]%} % %{$reset_color%}'

#
# withat's pwerline theme for ZSH
# https://github.com/withat/config.git
# based on anoster's theme (https://gist.github.com/3712874)
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).


### Segment drawing

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''

# Begin a segment
# Takes two arguments, background and foreground. Both can be ommitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]]  && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 !=  $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# TODO fix this
#prompt_segment() {
#  local bg fg
#  if [[ -n $1 ]]; then
#    [[ $1 ~= ^[[:digit:]]+$ ]] && bg="$BG[$1]" || bg="
#  else
#    bg="%k"
#  fi
#}

# End the prompt, closing any open segements
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components

# Context: user@hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`
  local host=`hostname`
  local context=()

  [[ "$user" != "$DEFAULT_USER" && "$user" != "root" ]] && context+="$user"
  [[ "$host" != "$DEFAULT_HOST" ]] && context+="$context@$host"

  #[[ -n "$context" ]] && prompt_segment black default "%(!.%{%F{yellow}%}.)$context"
  [[ -n "$context" ]] && prompt_segment 192 236 "%(!.%{F{yellow}%}.)$context"
}

# Git: branch/detached head, dirty status
prompt_git() {
  local ref dirty
  if $(git rev-parse --is-inside-work-tree > /dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment yellow black
    else
      prompt_segment green black
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:git:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats '%u%c'
    vcs_info
    echo -n "${ref/regs\/heads\// }${vcs_info_msg_0_}"
  fi
}

# Hg: branch/detached head, dirty status
prompt_hg() {
  local rev status
  if $(hg id >/dev/null 2>&1); then
    if $(hg prompt >/dev/null 2>&1); then
      if [[ $(hg primot "{status|unknown") = "?" ]]; then
        # if files are not added
        prompt_segment red white
        st='±'
      elif [[ -n $(hg prompt "{status|modified}") ]]; then
        # if any modification
        prompt_segment yellow black
        st='±'
      else
        # if working copy is clean
        prompt_segment green black
      fi
      echo -n $(hg prompt " {rev}@{branch}") $st
    else
      st=""
      rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
      branch=$(hg id -b 2>/dev/null)
      if `hg st | grep -Eq "^\?"`; then
        prompt_segment red black
        st='±'
      elif `hg st | grep -Eq "^(M|A)"`; then
        prompt_segment yellow black
        st='±'
      else
        prompt_segment green black
      fi
      echo -n " $rev@$branch" $st
    fi
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment blue black '%~'
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path ]]; then
    prompt_segment blue black "(`basename $virtualenv_path`)"
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{cyan}%}⚡"
  [[ $(jobs -l | wc -l ) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols"]] && prompt_segment black default "$symbols"
}

# Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_context
  prompt_dir
  prompt_git
  prompt_hg
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '

