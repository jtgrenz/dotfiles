iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  iterm2_set_user_var ruby_version $(echo $RUBY_VERSION)
  iterm2_set_user_var ruby_icon $(echo "\uF219")
}
