function git_branch() {
  git symbolic-ref -q HEAD 2>/dev/null | sed 's/refs\/heads\///'
}

function git_commit_id() {
  git rev-parse --short HEAD 2>/dev/null
}

function git_mode() {
  GIT_REPO_PATH=$(git rev-parse --git-dir 2>/dev/null)
  if [[ -e "$GIT_REPO_PATH" ]]; then
    echo " +repo"
  fi
}

function git_cwd_info() {
  GIT_REPO_PATH=`git rev-parse --git-dir 2>/dev/null`
  if [[ $GIT_REPO_PATH != '' && $GIT_REPO_PATH != '~' && $GIT_REPO_PATH != "$HOME/.git" ]]; then
    GIT_BRANCH=`git symbolic-ref -q HEAD | sed 's/refs\/heads\///'`
    GIT_COMMIT_ID=`git rev-parse --short HEAD 2>/dev/null`

    GIT_MODE=""
    if [[ -e "$GIT_REPO_PATH/BISECT_LOG" ]]; then
      GIT_MODE=" +bisect"
    elif [[ -e "$GIT_REPO_PATH/MERGE_HEAD" ]]; then
      GIT_MODE=" +merge"
    elif [[ -e "$GIT_REPO_PATH/rebase" || -e "$GIT_REPO_PATH/rebase-apply" || -e "$GIT_REPO_PATH/rebase-merge" || -e "$GIT_REPO_PATH/../.dotest" ]]; then
      GIT_MODE=" +rebase"
    fi

    GIT_DIRTY=""
    if [[ "$GIT_REPO_PATH" != '.' && `git ls-files -m` != "" ]]; then
      #GIT_DIRTY=" ☠"
      GIT_DIRTY=" ✗"
    fi
    echo " %{$fg[yellow]%}[git:%{$fg[blue]%}$GIT_BRANCH%{$reset_color%}@%{$fg[magenta]%}$GIT_COMMIT_ID%{$fg[blue]%}$GIT_MODE%{$fg[red]%}$GIT_DIRTY%{$fg[yellow]%}]%{$reset_color%}"
  fi
}
if [ $SSH_TTY ]; then
    ARROW="%{$fg[blue]%}❯"
else
    ARROW="%{$fg[yellow]%}❯"
fi

tilde_or_pwd() {
  echo $PWD | sed -e "s/\/Users\/$USER/~/"
}

export PROMPT='%{$fg[magenta]%}%n@%M %{$fg[green]%}$(tilde_or_pwd)%{$reset_color%}$(git_cwd_info)
$ARROW%{$reset_color%} '
export RPROMPT=''
export LSCOLORS="exfxcxdxbxegedabagacad"
