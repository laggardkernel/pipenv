The repo will be archived since I get a better solution.

Using hooks to mess with `cd` is a stupid idea. Besides, using `pipenv --venv` and `pipenv shell` together causes `cd` command much slower, and gives you a perceptible delay. This may explain [why nvm chose not to support activating environment automatically](https://github.com/creationix/nvm/issues/110).

Let's get a free ride from [pyenv](https://github.com/pyenv/pyenv)

Firstly, `export WORKON_HOME="$PYENV_ROOT/versions"`, or `export WORKON_HOME="$HOME/.pyenv/versions"`. It puts virtual environments created by `pipenv` to the same place where `pyenv` holds its envs. Now, we can use `pyenv versions` to list the environments, and `pyenv uninstall` to remove them easily.

Secondly, in the directory where `Pipfile` is located, get virtual environment name from `pipenv --venv` and set the venv as a local python version using `pyenv local <venv_name>`.

Then `pyenv` will activate virtual environment for `pipenv`. Just like what it does with its other Python versions, the `python` command will be passed by a shim.

Now, we use `pipenv` to manage the package dependencies, and take advantage of the shims from `pyenv` to switch/activate the virtual environments. **No `activate`, `deactivate` commands, no subshell used to keep `PATH` clean, no dirty hooks delay `cd` command.** Shims are elegant.

# Pipenv
A [Prezto](https://github.com/sorin-ionescu/prezto) module with features of pipenv support:
- Enable virtual environment created by pipenv automatically when
    1. directory is change
    2. a new shell window is opened
- Command completion for pipenv
- Switches, `zstyle` method used by Prezto, for cherry picking features here for yourself

#### Things You Should Know
Virtual environment auto switching could be completed with a hook using detection of existence of `Pipfile` under current working directory once directory is changed in terminal, combined with `pipenv shell` to enable the venv.

Using `pipenv --venv` searches venv could be more powerful, but it takes too much time at the same time, because 1) it searches recursively to parent folders, 2) both `pipenv --venv` and `pipenv shell` tries to looks for a venv, cost doubles.

I decide to choose the first method -- it's simple and fast.

## Settings
Auto switch virtual environments is **enabled by default** once working directory is changed, new shell window is enable, and a subshell is spawned. Use the following to disable this feature:

```shell
zstyle ':prezto:module:pipenv' auto-switch "no" # or "off"
```

## Installation

### [Prezto](https://github.com/sorin-ionescu/prezto)

```shell
mkdir -p ${ZDOTDIR:-$HOME}/.zprezto/ >/dev/null 2>&1
git clone git@github.com:laggardkernel/zsh-pipenv.git ${ZDOTDIR:-$HOME}/.zprezto/contrib/pipenv
# enable 'pipenv' in `.zpreztorc`, put it before prezto module 'completion'
```

### [Zplugin](https://github.com/zdharma/zplugin)
Enabling command completion should be declared explicitly for zplugin. Zplugin doesn't load compdef files with name prefix `_` automatically.

```shell
# pipenv plugin with hook + compdef
zplugin ice pick"init.zsh"
zplugin light https://github.com/laggardkernel/zsh-pipenv
```

Another configuration for zplugin that takes advantage of **Turbo Mode** in zplugin:

```shell
zstyle ':prezto:module:pipenv' full-startup "on"
zplugin ice wait"0" pick"init.zsh" lucid \
atpull'!git reset --hard'
zplugin light https://github.com/laggardkernel/zsh-pipenv
```

**Notes** about turbo-loading completion:
- zplugin handles completions in its own way, completions are not added into `$fpath`
- More detail about turbo-loading completion is [here](https://github.com/zdharma/zplugin#calling-compinit)

Update this plugin in zplugin with

```shell
zplg update laggardkernel/zsh-pipenv
```

### Additional Options
Use `pipenv --venv` to detect the virtual environment **at startup only**, which could enable venv in the sub-folder of a project but more time consuming. It's recommended use this option with **Zplugin's Turbo Mode only**.

```shell
zstyle ':prezto:module:pipenv' full-startup "yes" # or "on"
```

**Note**: `full-startup` is invalid if `auto-switch` is disabled.

An option to explicitly `compdef` completion suggestion of `pipenv` command. This is ONLY designed for other zsh plugin manager which is not compatible with prezto module.

```shell
# invalid for prezto
zstyle -t ':prezto:module:pipenv' completion "yes"
```

##
## Authors
- [laggardkernel](https://github.com/laggardkernel/zsh-pipenv)
