# manage virtualenvs
venv() {
  # Deactivate any existing virtualenv
  if [ "$VIRTUAL_ENV" ]; then
    echo "Deactivating $VIRTUAL_ENV..."
    deactivate
  fi

  # By default, pick $(pwd) as the new env
  target=$(pwd)
  target=${target:1}

  # Use first argument instead if it exists
  if [ -n "$1" ]; then
    target="$1"
  fi

  # If the first argument is '-', just quit - ie, only deactivate
  if [ "$target" = "-" ]; then
    return
  fi

  # If the $target doesn't exist in the current dir, use ~/envs/$(target)
  if [ ! -f "${target}/bin/activate" ]; then
    target=~/envs/"$target"
  fi

  # Make the env if it doesn't exist
  if [ ! -f "${target}/bin/activate" ]; then
    echo "Creating ${target}"
    mkdir -p "$target"
    python3 -m venv "$target"
  fi

  # Activate the env
  echo "Activating ${target}"
  source "${target}/bin/activate"
}
