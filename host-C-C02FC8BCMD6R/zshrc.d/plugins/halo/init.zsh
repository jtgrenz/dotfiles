# # eval "$(halo completion zsh)"; compdef _halo halo
source $ZSH_CONFIG/plugins/halo/_halo.zsh
compdef _halo halo

if type halo > /dev/null; then
  alias local_halo="/usr/local/bin/halo"

  halo() {
    if [ -d .git ]; then
      REPO=$(basename `git rev-parse --show-toplevel`)
      case $1 in
        attach)
         command halo attach $REPO ${@:2}
        ;;

        exec)
        command halo exec $REPO -- ${@:2}
        ;;

        test)
        command halo test $REPO ${@:2}
        ;;

        link)
        command halo link $REPO ${@:2}
        ;;

        unlink)
        command halo unlink $REPO ${@:2}
        ;;

        *)
        command halo "$@"
        ;;
      esac
    else
      command halo "$@"
    fi
  }
fi
