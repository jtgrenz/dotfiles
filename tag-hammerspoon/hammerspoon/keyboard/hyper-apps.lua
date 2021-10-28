-- Default keybindings for launching apps in Hyper Mode
--
-- To launch _your_ most commonly-used apps via Hyper Mode, create a copy of
-- this file, save it as `hyper-apps.lua`, and edit the table below to configure
-- your preferred shortcuts. Must use name as it appears in Activity Monitor

local openRescueTime = function ()
  hs.application.open('RescueTimeDashboard')
end


return {
  { 'a', 'Spotify' },            -- "A" for "Audio"
  { 'm', 'Spotify' },            -- "M" for "Music"
  { 'w', 'Google Chrome' },             -- "W" for "Web"
  { 'b', 'Firefox' },            -- "B" for "Browser"
  { 's', 'Slack' },              -- "S" for "Station/Slack"
  { 'e', 'Code' },               -- "E" for "Editor"
  { 'v', 'Code' },               -- "V" for "Visual Studio"
  { 'f', 'Finder' },             -- "F" fo  r "Finder"
  { 'c', 'Messages' },           -- "C" for "Chat"
  { 't', 'iTerm2' },             -- "T" for "Terminal"
  { 'p', 'Focus To-Do' },        -- "P" for "Pomodoro"
  { 'r',  openRescueTime},

  { '2', 'iTerm2' },
  { '`', 'iTerm2' },


}
