-- Default keybindings for launching apps in Hyper Mode
--
-- To launch _your_ most commonly-used apps via Hyper Mode, create a copy of
-- this file, save it as `hyper-apps.lua`, and edit the table below to configure
-- your preferred shortcuts. Must use name as it appears in Activity Monitor

local openRescueTime = function ()
  hs.application.open('RescueTimeDashboard')
end

local fixZoomVideo = function ()
  hs.application.open('Fix Zoom')
end


return {
  { 'a', 'Spotify' },            -- "A" for "Audio"
  { 'm', 'Spotify' },            -- "M" for "Music"
  { 'w', 'Google Chrome' },      -- "W" for "Web"
  { 'b', 'Firefox' },            -- "B" for "Browser"
  { 's', 'Slack' },              -- "S" for "Station/Slack"
  { 'e', 'Code' },               -- "E" for "Editor"
  { 'v', 'Neovide' },            -- "V" for "Vim"
  { 'f', 'Finder' },             -- "F" fo  r "Finder"
  { 'c', 'Messages' },           -- "C" for "Chat"
  { 't', 'iTerm2' },             -- "T" for "Terminal"
  { 'p', 'Pop' },                -- "P" for "Pop"
  { 'z', 'zoom.us' },            -- "Z" for "Zoom"
  { 'o', 'Obsidian' },           -- "O" for Obsidian
  { 'n', 'Notion' },             -- "N" for Notion
  { 'r',  openRescueTime},
  { '-', fixZoomVideo },          -- Opens photobooth and quits to fix zoom video

  { '2', 'iTerm2' },
  { '`', 'iTerm2' },


}
