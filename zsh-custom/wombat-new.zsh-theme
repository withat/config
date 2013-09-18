# vim:ft=zsh ts=2 sw=2 sts=2 et

# powerline inspired theme to match vim's wombat256mod
# https://github.com/withat/config.git
# based on anoster's theme (https://gist.github.com/3712874)
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts.git

### Colors
BLUE='111'
GREEN='113'
RED='173'
LGREEN='192'
YELLOW='229'
GRAY='246'
WHITE='252'

### Segment drawing

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''

# Begin a segment
# Take two arguments, background and foreground. Both can be ommitted,
# rendering default background/foreground
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="$1" || bg="$GRAY" # whatever was set before
  [[ -n $2 ]] && fg="$2" || fg="$WHITE"
  if [[ $CURRENT_BG  !=  'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " $BG[$CURRENT_BG]${SEGMENT_SEPARATOR}$FG[$fg]"
  else
    echo -n "$BG[$bg]$FG[$fg]"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " $BG[$CURRENT_BG]$SEGMENT_SEPARATOR"
  fi
  echo -n "$BG[1]$FG[$WHITE]"
  CURRENT_BG=''
}


### Prompt Components
#
## Context: user@host
prompt_context() {
  local user=`whoami`
  local host=$HOST
  local context=''

  if [[ $UID -eq 0 ]]; then
    context="%{$FG[$RED]%}$user%{$reset_color%}"
  elif [[ "$user" != "$DEFAULT_USER" ]]; then
    context="$user"
  fi
  [[ "$host" != "$DEFAULT_HOST" ]] && context="${context}@$host"
  prompt_segment $GRAY $WHITE "$context"
}

# Git: branch/detached head, dirty status
prompt_git() {
  local ref dirty
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment $YELLOW $GRAY
    else
      prompt_segment $GREEN $GRAY
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
    echo -n "${¶ef/refs\/heads\// }${vcs_info_msg_0_}"
  fi
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_context
  prompt_git
  prompt_end
}
