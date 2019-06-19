# manage docker-based workspaces
export DNS=1.1.1.1
d() {
  local SESS="$1"
  mkdir -p ~/.workspaces/"$SESS"
  mkdir -p ~/.workspaces/.share

  if [ -z "$SESS" ]; then
    ls ~/.workspaces

  else
    shift
    exists=$(docker ps -aqf "name=$SESS")

    # create a container if it doesn't exist
    if [ -z "$exists" ]; then
      echo "Creating container..."
      exists=$(docker run \
          --dns $DNS \
          --env "http_proxy=$http_proxy" \
          --env "https_proxy=$https_proxy" \
          --env "no_proxy=$no_proxy" \
          --detach \
          --hostname "$SESS" \
          --interactive \
          --name "$SESS-workspace" \
          --rm \
          --tty \
          --volume /var/run/docker.sock:/var/run/docker.sock \
          --volume ~/.ssh/id_rsa.pub:/home/john/.ssh/id_rsa.pub \
          --volume ~/.ssh/id_rsa:/home/john/.ssh/id_rsa \
          --volume ~/.workspaces/"$SESS":/home/john/dev \
          --volume ~/.workspaces/.share:/home/john/shr \
          scizzorz/arch)

      # need to add myself to whatever group owns /var/run/docker.sock inside
      # the container. this can't be done as part of the image because the
      # permissions on the socket are set by the *host* machine, so it varies
      # from host to host. eg, on my home machine, the docker group is gid 992,
      # but on my work machine, it's 995. inside the container, those are
      # (currently) mapped to kvm and audio respectively, while the docker
      # group is gid 977. moral of the story is that user permissions are
      # hard in docker images and that's why they usually just run as root, I
      # guess.
      echo "Fixing groups..."
      docker cp ~/dots/docker/fix-groups.sh $exists:/home/john/dots/docker/fix-groups.sh
      docker exec \
        $exists \
        /usr/bin/zsh /home/john/dots/docker/fix-groups.sh
    fi

    echo "Entering container..."
    docker exec \
      --interactive \
      --tty \
      --user john \
      $exists \
      "${@:-/usr/bin/zsh}"

  fi
}

