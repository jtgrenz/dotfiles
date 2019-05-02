#!/usr/bin/ruby --disable-gems

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
