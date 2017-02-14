#alias ga='git add -A'
alias gap='ga -p'
#alias gau='git add -u'
#alias gbr='git branch -v'
#gc() {
#  git diff --cached | grep '\btap[ph]\b' >/dev/null &&
#    echo "\e[0;31;29mOops, there's a #tapp or similar in that diff.\e[0m" ||
#    git commit -v "$@"
#}
#alias gc!='git commit -v'
#alias gca='git commit -v -a'
#alias gcam='gca --amend'
#alias gch='git cherry-pick'
#alias gcm='git commit -v --amend'
#alias gco='git checkout'
#alias gcop='gco -p'
#alias gd='git diff -M'
#alias gd.='git diff -M --color-words="."'
#gdbr() {
#  ref="$1"
#  shift
#  git diff -M "$@" $(git merge-base HEAD "$ref").."$ref"
#}
#alias gdc='git diff --cached -M'
#alias gdc.='git diff --cached -M --color-words="."'
#alias gf='git fetch'
#git-new() {
#  [ -d "$1" ] || mkdir "$1" &&
#  cd "$1" &&
#  git init &&
#  touch .gitignore &&
#  git add .gitignore &&
#  git commit -m "Added .gitignore."
#}
#git_current_branch() {
#  cat "$(git rev-parse --git-dir 2>/dev/null)/HEAD" | sed -e 's/^.*refs\/heads\///'
#}
alias glog='git log --date-order --pretty="format:%C(yellow)%h%Cblue%d%Creset %s %C(white) %an, %ar%Creset"'
alias gl='glog --graph'
alias glh='gl | head'
#alias gla='gl --all'
#gls() {
#  query="$1"
#  shift
#  glog --pickaxe-regex "-S$query" "$@"
#}
#alias gm='git merge --no-ff'
#alias gmf='git merge --ff-only'
#alias gmfthis='gmf origin/$(git_current_branch)'
#alias gp='git push'
#alias gpthis='gp origin $(git_current_branch)'
#alias gr='git reset'
#alias grb='git rebase -p'
#alias grbthis='grb origin/$(git_current_branch)'
#alias grbc='git rebase --continue'
#alias grbi='git rebase -i'
#alias grh='git reset --hard'
#alias grp='gr --patch'
#alias grsh='git reset --soft HEAD~'
#alias grv='git remote -v'
#alias gs='git show'
#alias gs.='git show --color-words="."'
#alias gst='git stash'
#alias gstp='git stash pop'
#alias gup='git smart-pull'
#gupstation() {
#  gup
#  gf production
#  gf staging
#}
alias s='git status'
#alias d='gd $argv'
