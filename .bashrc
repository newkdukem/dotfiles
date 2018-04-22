# A two-line colored Bash prompt (PS1) with Git branch and a line decoration
# which adjusts automatically to the width of the terminal.
# Recognizes and shows Git, SVN and Fossil branch/revision.
# Screenshot: http://img194.imageshack.us/img194/2154/twolineprompt.png
# Michal Kottman, 2012
 
RESET="\[\033[0m\]"
PURPLE="\033[38;5;127m"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\033[0;33m\]"
 
function parse_git_branch {
  PS_BRANCH=''
  if [ -d .svn ]; then
    PS_BRANCH="(svn r$(svn info|awk '/Revision/{print $2}'))"
    return
  elif [ -f _FOSSIL_ -o -f .fslckout ]; then
    PS_BRANCH="(fossil $(fossil status|awk '/tags/{print $2}')) "
    return
  fi
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  PS_BRANCH="(${ref#refs/heads/}) "
}
PROMPT_COMMAND=parse_git_branch
PS_TIME="$PURPLE[\t]"
PS_INFO="$GREEN\u@\h$RESET:$BLUE\w"
PS_GIT="$YELLOW\$PS_BRANCH"
export PS1="${PS_TIME} ${PS_INFO} ${PS_GIT}\n${RESET}\\$\[$(tput sgr0)\]> "

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
alias ls='ls -ahl --color=auto'
alias i3lock='i3lock -c 000000'
alias cancerise='. /usr/lib/ckan/cancer/bin/activate && cp ~/solr-5.5.1/server/solr/ckan/conf/schema.xml.hp ~/solr-5.5.1/server/solr/ckan/conf/schema.xml && ~/solr-5.5.1/bin/solr restart'
alias bluedotise='. /usr/lib/ckan/bluedot/bin/activate && cp /usr/lib/ckan/bluedot/src/ckan/ckan/config/solr/schema.xml ~/solr-5.5.1/server/solr/ckan/conf/schema.xml && ~/solr-5.5.1/bin/solr restart'
alias defaultise='. /usr/lib/ckan/default/bin/activate cp ~/solr-5.5.1/server/solr/ckan/conf/schema_2.7.xml ~/solr-5.5.1/server/solr/ckan/conf/schema.xml && ~/solr-5.5.1/bin/solr restart'
