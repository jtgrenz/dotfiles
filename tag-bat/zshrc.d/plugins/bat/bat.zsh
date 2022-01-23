# use bat instead of cat.
if type bat > /dev/null; then
  alias catt="/bin/cat"
  alias cat='bat'
fi
