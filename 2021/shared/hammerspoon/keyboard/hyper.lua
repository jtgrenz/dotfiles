local status, hyperModeAppMappings = pcall(require, 'keyboard.hyper-apps')

if not status then
  hyperModeAppMappings = require('keyboard.hyper-apps-defaults')
end

local switchToApp = function (app)
  local frontmostApp = hs.application.frontmostApplication()
  local appToOpen = hs.application.get(app)
  if frontmostApp:name() == appToOpen:name() then
    hs.eventtap.keyStroke({'command'}, '`', 0)
  else
    hs.application.open(appToOpen:bundleID())
  end
end

local cycleApp = function (app)
  local frontmostApp = hs.application.frontmostApplication()
  local openApp = hs.application.get(app)
  local switcher = hs.window.switcher.new(app) -- default windowfilter: only visible windows, all Spaces

  if openApp and frontmostApp:name() == openApp:name() then
    switcher:next()
  else
    hs.application.open(app)
  end
end


for i, mapping in ipairs(hyperModeAppMappings) do
  local key = mapping[1]
  local app = mapping[2]
  hs.hotkey.bind({'shift', 'ctrl', 'alt', 'cmd'}, key, function()
    if (type(app) == 'string') then
      -- hs.application.open(app)
      switchToApp(app)
      --cycleApp(app)
    elseif (type(app) == 'function') then
      app()
    else
      hs.logger.new('hyper'):e('Invalid mapping for Hyper +', key)
    end
  end)
end
