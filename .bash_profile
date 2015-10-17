#docker 
export DOCKER_HOST=tcp://127.0.0.1:2376
export DOCKER_CERT_PATH=/Users/coraline/.dinghy/certs
export DOCKER_TLS_VERIFY=1
export VAGRANT_DEFAULT_PROVIDER=vmware_fusion

# core
alias www='open -a /Applications/Safari.app'
alias p='cd ~/Documents/projects/'
alias ll='ls -al'

# Git
alias git-explain='git blame'
source ~/dotfiles/git-completion.bash
alias git-cleanup='git branch | grep -v "master" | grep -v "dev"  | xargs git branch -D'


# projects
alias gh="~/scripts/git-browse"

# hints
alias tar?='echo "tar -cvf destination.tar source/";echo "tar -x archive.tar"'
alias scp?='echo "scp -C user@source:/path/to/file [user@destination]:/path/to/destination"'

# Other
alias rspec='time bundle exec rspec'
alias rpsec='time bundle exec rspec'
alias mvim='open -a /Applications/VimR.app/'
alias squash='~/scripts/squash.sh'

# paths

export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/mysql/bin:~/bin:/usr/local/sbin:/sw/bin:/sw/sbin:$PATH
export EDITOR=/usr/bin/vi
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=$PATH:node_modules/.bin


###############################################################################

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local  BLACK="\[\033[0;0m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac

PS1="\$(~/.rvm/bin/rvm-prompt)$GREEN\$(parse_git_branch)$BLACK\$ "
PS2='> '
PS4='+ '
}
proml

function directory_to_titlebar {
   local pwd_length=42  # The maximum length we want (seems to fit nicely
                        # in a default length Terminal title bar).
   # Get the current working directory.  We'll format it in $dir.
   local dir="$PWD"

   # Substitute a leading path that's in $HOME for "~"
   if [[ "$HOME" == ${dir:0:${#HOME}} ]] ; then
       dir="~${dir:${#HOME}}"
   fi

   # Append a trailing slash if it's not there already.
   if [[ ${dir:${#dir}-1} != "/" ]] ; then
       dir="$dir/"
   fi

   # Truncate if we're too long.
   # We preserve the leading '/' or '~/', and substitute
   # ellipses for some directories in the middle.
   if [[ "$dir" =~ (~){0,1}/.*(.{${pwd_length}}) ]] ; then
       local tilde=${BASH_REMATCH[1]}
       local directory=${BASH_REMATCH[2]}

       # At this point, $directory is the truncated end-section of the
       # path.  We will now make it only contain full directory names
       # (e.g. "ibrary/Mail" -> "/Mail").
       if [[ "$directory" =~ [^/]*(.*) ]] ; then
           directory=${BASH_REMATCH[1]}
       fi

       # Can't work out if it's possible to use the Unicode ellipsis,
       # '…' (Unicode 2026).  Directly embedding it in the string does not
       # seem to work, and \u escape sequences ('\u2026') are not expanded.
       #printf -v dir "$tilde/\u2026$s", $directory"
       dir="$tilde/...$directory"
   fi

   # Don't embed $dir directly in printf's first argument, because it's
   # possible it could contain printf escape sequences.
   printf "\033]0;%s\007" "$dir"
}
if [[ "$TERM" == "xterm" || "$TERM" == "xterm-color" || "$TERM" == "xterm-256color" ]] ; then
 export PROMPT_COMMAND="directory_to_titlebar"
fi

if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then source "$HOME/.rvm/scripts/rvm" ; fi

if [[ "$PWD" == "$HOME" ]]  ; then p; fi


export NVM_DIR="/Users/coraline/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
