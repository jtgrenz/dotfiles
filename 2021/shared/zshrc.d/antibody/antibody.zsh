# Antibody wrapper
# ###################
# Captures the antibody command and if subcomand is 'static'
# read the antibody plugin list and write out to the static plugin file.
# otherwise run antibody as normal

antibody() {
  if [ "$1" = static ]; then
    antibody bundle < $ANTIBODY/plugins.txt >! $ANTIBODY/plugins_static.zsh
    echo Updated: $ANTIBODY/plugins_static.zsh
    echo  From  : $ANTIBODY/plugins.txt
  else
    command antibody "$@"
  fi
}
