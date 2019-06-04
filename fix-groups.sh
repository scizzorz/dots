#!/usr/bin/zsh
# this is used to fix the permissions of the `john` user
# to be in whatever group owns /var/run/docker.sock
group=$(exa -lg /var/run/docker.sock | cut -d" " -f4)
echo "Identified $group as group of /var/run/docker.sock"

if [[ $group =~ '^[0-9]+$' ]] ; then
  echo "Unclaimed gid; creating new group..."
  groupadd -g $group dockeroo
  group=dockeroo
fi

usermod john -a -G $group
echo -n "Current groups: "
groups john
