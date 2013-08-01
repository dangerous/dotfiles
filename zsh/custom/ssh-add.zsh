# Add the first user identity if the local ssh-agent doesn't already have
# something.
#
# We silence error output for when we're sshing to a machine that we don't want
# to use ssh-agent forwarding for.
if [[ `ssh-add -L | grep "^ssh-" | wc -l` == 0 ]]; then
  ssh-add 2> /dev/null
fi
