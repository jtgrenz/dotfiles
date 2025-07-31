# export MISE_SHELL=zsh
# export __MISE_ORIG_PATH="$PATH"
# # if you install via homebrew, this will be under /opt/homebrew/bin/mise but the normal installer will be under $HOME/.local/bin/mise
# # get the correct path to mise before setting up the mise activate function
# local mise_bin=$(command -v mise)

# mise() {
#   local command
#   command="${1:-}"
#   if [ "$#" = 0 ]; then
#     command $mise_bin
#     return
#   fi
#   shift

#   case "$command" in
#   deactivate|s|shell)
#     # if argv doesn't contains -h,--help
#     if [[ ! " $@ " =~ " --help " ]] && [[ ! " $@ " =~ " -h " ]]; then
#       eval "$(command $mise_bin "$command" "$@")"
#       return $?
#     fi
#     ;;
#   esac
#   command $mise_bin "$command" "$@"
# }

# _mise_hook() {
#   eval "$($mise_bin hook-env -s zsh)";
# }
# typeset -ag precmd_functions;
# if [[ -z "${precmd_functions[(r)_mise_hook]+1}" ]]; then
#   precmd_functions=( _mise_hook ${precmd_functions[@]} )
# fi
# typeset -ag chpwd_functions;
# if [[ -z "${chpwd_functions[(r)_mise_hook]+1}" ]]; then
#   chpwd_functions=( _mise_hook ${chpwd_functions[@]} )
# fi

# if [ -z "${_mise_cmd_not_found:-}" ]; then
#     _mise_cmd_not_found=1
#     [ -n "$(declare -f command_not_found_handler)" ] && eval "${$(declare -f command_not_found_handler)/command_not_found_handler/_command_not_found_handler}"

#     function command_not_found_handler() {
#         if $mise_bin hook-not-found -s zsh -- "$1"; then
#           _mise_hook
#           "$@"
#         elif [ -n "$(declare -f _command_not_found_handler)" ]; then
#             _command_not_found_handler "$@"
#         else
#             echo "zsh: command not found: $1" >&2
#             return 127
#         fi
#     }
# fi

eval "$(mise activate zsh)"
eval "$(mise hook-env -s zsh)"
