# Replace system ssh-agent
# This is typically used to replace the Mac OSX ssh-agent with the newer, FIDO aware, homebrew-installed openssh ssh-agent
# but it can be used to replace the ssh-agent on any system where you do not have root privs, or to allow ssh-agent to
# work on environments like cygwin or WSL where an ssh-agent daemon might not be setup.
#
# You should also ensure the other openssh binaries are in a high-precedence in your $PATH
#
# Note: WSL users do not need this, instead you can install keychain and add the following to your .bashrc:
# /usr/bin/keychain -q
# source $HOME/.keychain/${HOSTNAME}-sh 

NEW_SSH_AGENT=${1-$(brew --prefix openssh)/bin/ssh-agent}

SSH_ENV=${HOME}/.ssh/environment

function start_agent {
     echo -n "Initialising new SSH agent with ${NEW_SSH_AGENT}..."
     ${NEW_SSH_AGENT} | sed 's/^echo/#echo/' > ${SSH_ENV}
     echo succeeded
     touch ${SSH_ENV}
     chmod 600 ${SSH_ENV}
     . ${SSH_ENV} > /dev/null
  #   /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
     . ${SSH_ENV} > /dev/null
     #ps ${SSH_AGENT_PID} not used as it does not work in cygwin
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi

