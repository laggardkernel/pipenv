# Pipenv
A [Prezto](https://github.com/sorin-ionescu/prezto) module with features of pipenv support:
- Enable virtual environment created by pipenv automatically when
    1. directory is changed
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
