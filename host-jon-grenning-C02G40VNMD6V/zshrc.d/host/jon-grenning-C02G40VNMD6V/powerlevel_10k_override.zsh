POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator dir custom_gusto_vpn_status vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time time chruby node_version pyenv context background_jobs custom_tmux)

# Gusto VPN
gusto_vpn_status() {
  local vpn_status="$(gusto-vpn state | grep "state: Connected" | head -1)"
  if [ "$vpn_status" != "" ]; then
    echo -n "%F{green}VPN"
  fi
}

POWERLEVEL9K_CUSTOM_GUSTO_VPN_STATUS="gusto_vpn_status"
POWERLEVEL9K_CUSTOM_GUSTO_VPN_STATUS_BACKGROUND="clear"
