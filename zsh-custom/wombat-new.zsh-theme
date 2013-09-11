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

### Segment drawing

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''

# Begin a segment
# Take two arguments, background and foreground. Both can be ommitted,
# rendering default background/foreground
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="$1" || bg="1" # whatever was set before
  [[ -n $2 ]] && fg="$2" || fg="$GRAY"
  if [[ $CURRENT_BG  !=  'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " $BG[$CURRENT_BG]${SEGMENT_SEPARATOR}$FG[$fg]"
  else
    echo -n "$BG[$bg]$FG[$fg]"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

