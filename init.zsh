#
# Enables virtual environment created by pipenv
#
# Authors:
#   laggardkernel <laggardkernel@qq.com>
#

# Return if requirements are not found.
if (( ! $+commands[pipenv] )); then
  return 1
fi

function _pipenv_workon_cwd {
  if [ ! -n "${PIPENV_ACTIVE+1}" ]; then
    if [ -f "Pipfile" ] ; then
        pipenv shell
    fi
  fi
}

# Load auto workon cwd hook
if zstyle -T ':prezto:module:pipenv' auto-switch; then
  # Auto workon when changing directory
  autoload -Uz add-zsh-hook
  add-zsh-hook -D chpwd _pipenv_workon_cwd
  add-zsh-hook chpwd _pipenv_workon_cwd

  if zstyle -t ':prezto:module:pipenv' full-startup "yes"; then
    # The switch is designed to use with Turbo Mode of zplugin.
    # Longer time is taken, and you'll be back at the root of the project
    [ ! -n "${PIPENV_ACTIVE+1}" ] && pipenv --venv >/dev/null 2>&1 && pipenv shell
  else
    [ ! -n "${PIPENV_ACTIVE+1}" ] && _pipenv_workon_cwd
  fi
fi

# A switch to declare compdef of pipenv explicitly,
# designed for those doesn't support modules for prezto
if zstyle -t ':prezto:module:pipenv' completion "yes"; then
  # eval "$(pipenv --completion)"
  if [[ "$(basename -- ${(%):-%x})" != "_pipenv" ]]; then
    source "${0:h}/functions/_pipenv"
    # autoload -U compinit && compinit
    compdef _pipenv pipenv
  fi
fi
