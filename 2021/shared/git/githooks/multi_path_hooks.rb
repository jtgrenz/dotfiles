#!/usr/bin/ruby --disable-gems

####### MultiPathHooks #######
# Note: This method of using a global set of githooks requires git 2.9 or higher
#
# Problem: You have a set of githooks you wish to run on all repos, but also
# work on share repos that already have githooks. You don't want to force others
# to use your hooks, but you also want to use the supplied hooks in the shared repo.
#
# By setting `git config --global core.hookpath` to this directory, git will no
# longer look in the .git/hooks directory of your project. By symlinking all hooks
# in this .gitooks directory to this module, you are able to run both local repo's hooks
# as well as global hooks.
#
# This module will detect the current hook being triggered and then look for a
# directory in the global hooks directory matching the hook's name plus `.d`. It
# will then run all the files in that directory and then run any matching hook
# scripts in the repo's .git/hooks directory.
#
####### Example ########
#
# Your repo is ~/Jon/code/my_repo and you just tried to commit. This will trigger
# the pre-commit hook. Normally, git will look for a file called `
# ~/Jon/code/my_repo/.git/hooks/pre-commit` to run. But having set
# `git config --global core.hookpath ~/.githooks`, git will instead run `~/.githooks/pre-commit`.
# `~/.githooks/pre-commit` is symlinked to this ruby module and this script runs. This script will
# look for a directory called `~/.githooks/pre-commit.d` and it will execute every script in that directory,
# if it exists. Next, it will execute ~/Jon/code/my_repo/.git/hooks/pre-commit if it exists.
#
# Assuming the exit code for all scripts in ~/.githooks/pre-commit.d and
# ~/Jon/code/my_repo/.git/hooks/pre-commit were sucessful, your commit completes.
#


module MultiPathHooks
  extend self

  CURRENT_HOOK = File.basename(__FILE__)
  GLOBAL_HOOKS_PATH = File.dirname(__FILE__)
  GLOBAL_CURRENT_HOOK_SUBHOOK_PATH = GLOBAL_HOOKS_PATH + '/' + CURRENT_HOOK + '.d'
  LOCAL_HOOK_PATH = File.join([Dir.pwd, '.git', 'hooks', CURRENT_HOOK])

  def main
    run_global_hooks if Dir.exist?(GLOBAL_CURRENT_HOOK_SUBHOOK_PATH)
    run_local_hooks if File.exist?(LOCAL_HOOK_PATH)
  end

  private

  def run_global_hooks
    Dir.entries(GLOBAL_CURRENT_HOOK_SUBHOOK_PATH).each do |hook|
      next if %w(. ..).include?(hook)
      system(File.join([GLOBAL_CURRENT_HOOK_SUBHOOK_PATH, hook]))
      exit(1) if $? != 0
    end
  end

  def run_local_hooks
    system(LOCAL_HOOK_PATH)
    exit(1) if $? != 0
  end
end

MultiPathHooks.main
