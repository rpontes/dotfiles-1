fg_blue="\033[0;34m"
fg_reset="\e[0m"
fg_gray="\033[1;30m"
fg_green="\033[0;32m"
fg_light_gray="\033[0;37m"
fg_light_green="\033[1;32m"
fg_light_red="\033[1;31m"
fg_red="\033[0;31m"
fg_white="\033[1;37m"
fg_yellow="\033[0;33m"

__hellobits_git_branch () {
  branch=$(git branch 2> /dev/null | grep \* | sed 's/* //')

  if [[ "$branch" = "" ]]; then
    branch=$(git status 2> /dev/null | grep "On branch" | sed -E 's/^.*On branch //')
  fi

  branch=$(echo $branch | sed -E 's/[)(]//g')

  echo $branch
}

__hellobits_git_status () {
  nothing_to_commit="# Initial commit"
  behind="Your branch is behind"
  ahead="Your branch is ahead"
  untracked="Untracked files"
  diverged="have diverged"
  changed="Changed but not updated"
  to_be_commited="Changes to be committed"
  changes_not_staged="Changes not staged for commit"

  git_branch=$(__hellobits_git_branch)
  git_status=$(git status 2> /dev/null | tr "\\n" " ")

  if [[ "$git_branch" = "" ]]; then
    return
  fi

  if [[ "$git_status" =~ "$changes_not_staged" ]]; then
    prompt_color="${fg_red}"
    state=""
  elif [[ "$git_status" =~ "$nothing_to_commit" ]]; then
    prompt_color="${fg_red}"
    state=""
  elif [[ "$git_status" =~ "$diverged" ]]; then
    prompt_color="${fg_red}"
    state="${state}${fg_red}↕${fg_reset}"
  elif [[ "$git_status" =~ "$behind" ]]; then
    prompt_color="${fg_red}"
    state="${state}${fg_red}↓${fg_reset}"
  elif [[ "$git_status" =~ "$ahead" ]]; then
    prompt_color="${fg_red}"
    state="${state}${fg_red}↑${fg_reset}"
  elif [[ "$git_status" =~ "$changed" ]]; then
    prompt_color="${fg_red}"
    state=""
  elif [[ "$git_status" =~ "$to_be_commited" ]]; then
    prompt_color="${fg_red}"
    state=""
  else
    prompt_color="${fg_green}"
    state=""
  fi

  if [[ "$git_status" =~ "$untracked" ]]; then
    state="${state}${fg_yellow}*${fg_reset}"
  fi

  echo "± ${fg_reset}${prompt_color}${git_branch}${fg_reset}${state}"
}

__hellobits_ruby () {
  if [ -f Gemfile.lock ]; then
    ruby_version=$(ruby -e "puts RUBY_VERSION")
    echo " ruby=${ruby_version}"
  fi
}

__hellobits_rails () {
  if [ -f Gemfile.lock ]; then
    rails_version=$(cat Gemfile.lock | grep -E " +rails \([0-9]+" | sed 's/ *rails (\(.*\))/\1/')
    [ "$rails_version" != "" ] && echo " rails=${rails_version}"
  fi
}

__hellobits_node () {
  if [ -f package.json  ] && [ -x "$(which node)" ]; then
    node_version=$(node -v | sed -E 's/v//')
    echo " node=${node_version}"
  fi
}

__hellobits_blocks () {
  blocks="$(__hellobits_ruby)$(__hellobits_rails)$(__hellobits_node)"
  blocks=$(echo $blocks | sed -E 's/^ +//' | sed -E 's/ /|/')

  if [[ "$blocks" != "" ]]; then
    blocks="${fg_blue}[${blocks}]${fg_reset} "
  fi

  echo $blocks
}

__hellobits_path () {
  current_path="${PWD/#$HOME/~}"
  echo "in ${fg_yellow}${current_path}${fg_reset}"
}

__hellobits_prompt() {
  prompt="\n$(__hellobits_blocks)$(__hellobits_path) $(__hellobits_git_status)\n$ "
  echo $prompt
}

PROMPT='$(__hellobits_prompt)'
