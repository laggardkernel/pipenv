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

I decide to choose the simple.

## Settings
Auto switch virtual environments is **enabled by default** once working directory is changed, new shell window is enable, and a subshell is spawned. Use the following to disable this feature:

```shell
zstyle ':prezto:module:pipenv' auto-switch "no" # or "off"
```

## Installation
#### Prezto

```shell
mkdir -p ${ZDOTDIR:-$HOME}/.zprezto/ >/dev/null 2>&1
git clone git@github.com:laggardkernel/pipenv.git ${ZDOTDIR:-$HOME}/.zprezto/contrib/pipenv
# enable 'pipenv' in `.zpreztorc`, put it before prezto module 'completion'
```

## Authors
- [laggardkernel](https://github.com/laggardkernel/pipenv)
