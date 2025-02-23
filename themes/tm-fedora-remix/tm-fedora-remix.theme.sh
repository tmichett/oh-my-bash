#! bash oh-my-bash.module

# Fedora Remix Bash Prompt, inspired by theme "Axin"
# thanks to them

CLOCK_CHAR_THEME_PROMPT_PREFIX='('
CLOCK_CHAR_THEME_PROMPT_SUFFIX=')'
CLOCK_THEME_PROMPT_PREFIX='('
CLOCK_THEME_PROMPT_SUFFIX=')'

THEME_PROMPT_HOST='\H'

SCM_CHECK=${SCM_CHECK:=true}

SCM_THEME_PROMPT_DIRTY=' ✗'
SCM_THEME_PROMPT_CLEAN=' ✓'
SCM_THEME_PROMPT_PREFIX=' | '
SCM_THEME_PROMPT_SUFFIX=' | '
SCM_THEME_BRANCH_PREFIX=''
SCM_THEME_TAG_PREFIX='tag:'
SCM_THEME_DETACHED_PREFIX='detached:'
SCM_THEME_BRANCH_TRACK_PREFIX=' → '
SCM_THEME_BRANCH_GONE_PREFIX=' ⇢ '
SCM_THEME_CURRENT_USER_PREFFIX=' ☺︎ '
SCM_THEME_CURRENT_USER_SUFFIX=''
SCM_THEME_CHAR_PREFIX=''
SCM_THEME_CHAR_SUFFIX=''



if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color &>/dev/null; then
  export TERM=gnome-256color
elif [[ $TERM != dumb ]] && infocmp xterm-256color &>/dev/null; then
  export TERM=xterm-256color
fi

MAGENTA=$_omb_prompt_bold_red
WHITE=$_omb_prompt_bold_silver
ORANGE=$_omb_prompt_bold_olive
GREEN=$_omb_prompt_bold_green
PURPLE=$_omb_prompt_bold_purple
BLUE=$_omb_prompt_bold_blue

THEME_CLOCK_COLOR=$_omb_prompt_blue

function clock_prompt {
  CLOCK_COLOR=${THEME_CLOCK_COLOR:-"$_omb_prompt_normal"}
  CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"%D" @ "%H:%M"}
  [ -z $THEME_SHOW_CLOCK ] && THEME_SHOW_CLOCK=${THEME_CLOCK_CHECK:-"true"}
  SHOW_CLOCK=$THEME_SHOW_CLOCK

  if [[ "${SHOW_CLOCK}" = "true" ]]; then
    CLOCK_STRING=$(date +"${CLOCK_FORMAT}")
    echo -e "${CLOCK_COLOR}${CLOCK_THEME_PROMPT_PREFIX}${CLOCK_STRING}${CLOCK_THEME_PROMPT_SUFFIX}"
  fi
}



RESET=$_omb_prompt_normal
if ((_omb_term_colors >= 256)); then
  ORANGE=$_omb_prompt_bold'\['$(tput setaf 172)'\]'
  GREEN=$_omb_prompt_bold'\['$(tput setaf 190)'\]'
  PURPLE=$_omb_prompt_bold'\['$(tput setaf 141)'\]'
fi

OMB_PROMPT_VIRTUALENV_FORMAT='( %s ) '
OMB_PROMPT_CONDAENV_FORMAT='( %s ) '
OMB_PROMPT_CONDAENV_USE_BASENAME=true
OMB_PROMPT_SHOW_PYTHON_VENV=${OMB_PROMPT_SHOW_PYTHON_VENV:=false}

function _omb_theme_PROMPT_COMMAND() {
  local python_venv
  _omb_prompt_get_python_venv
  PS1="$python_venv${MAGENTA}\u${BLUE}@${ORANGE}\h ${BLUE}[${GREEN}\w${BLUE}]$SCM_THEME_PROMPT_PREFIX$(clock_prompt) ${PURPLE}\$(scm_prompt_info) \n\$ ${RESET}"
}

_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND
