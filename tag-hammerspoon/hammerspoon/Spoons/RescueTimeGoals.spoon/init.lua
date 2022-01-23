--- === RescueTime Menubar Goals ===
---
--- Adds a menubar to show the current status of RescueTime goals
---

local obj = {}
obj.__index = obj
obj.name = "RescueTimeGoals"
obj.version = "0.1"
obj.menu_goal_state = {}
obj.show_goal_by_default = false

local config = {}
config.interval = 1800

local onInterval, updateMenu

local function deepCopy(original)
  local copy = {}
  for k, v in pairs(original) do
    if type(v) == "table" then
      v = deepCopy(v)
    end
    copy[k] = v
  end
  return copy
end


local function openRescueTime()
  local rect = hs.geometry.rect(900, 200, 1000, 1000)
  webview = hs.webview.newBrowser(rect):url("https://www.rescuetime.com/browse/goals/by/day"):show()
end

local function toggleShowInMenuBar(_keyboardMods, item)
  if item.checked == true then
    obj.menu_goal_state[item.goal_name].checked = false
  else
    obj.menu_goal_state[item.goal_name].checked = true
  end
  updateMenu()
end

function hideAll()
  for goal_name, goal in pairs(obj.menu_goal_state) do
    obj.menu_goal_state[goal_name].checked = false
  end
  updateMenu()
end

function showAll()
  for goal_name, goal in pairs(obj.menu_goal_state) do
    obj.menu_goal_state[goal_name].checked = true
  end
  updateMenu()
end

-- update the menu bar
function updateMenu()
  local title = ""
  local menutable = deepCopy(obj.menutable)

  for goal_name, goal in pairs(obj.menu_goal_state) do
    if goal.checked == true then
      title = title .. goal.menu_message.menu .. '    '
    end
    table.insert(menutable, {
      title = goal.menu_message.menu_msg,
      checked = goal.checked,
      goal_name = goal_name,
      fn = toggleShowInMenuBar
    })
  end

    obj.menu:setMenu(menutable):setTitle(title)
end

local function format_time(time, unit)
  if time < 1 and unit == 'h' then
    return math.floor(time * 60) .. "m"
  elseif time > 1 and unit == 'h' then
    return math.floor(time) .. "h " .. math.floor(math.fmod(time, 1) * 60) .. "m"
  elseif time < 1 and unit == 'm' then
    return math.floor(time * 60) .. "s"
  elseif time > 1 and unit == 'm' then
    return math.floor(time) .. "m"
  end
end

local function build_goal_response(name, sum_time)
 local greater_less, goal_time, unit, short_name = string.match(name, '([><])(%s%d)([hm])%son%s(.*)')
 local time_remaining = 0

  -- convert time unit back to seconds
  if unit == "h" then
    goal_time = goal_time * 60 * 60
    time_remaining = (goal_time - sum_time) / 60 / 60
    time_remaining = format_time(time_remaining, 'h')
  elseif unit == "m" then
    goal_time = goal_time * 60
     time_remaining = (goal_time - sum_time) / 60
     time_remaining = format_time(time_remaining, 'm')
  end

  local menu_messages = {}
  if sum_time > goal_time  and greater_less == ">" then
    -- positive goal reached
    menu_messages.menu = short_name .. ": [✅]"
    menu_messages.menu_msg = '✅ ' .. format_time(sum_time / 60 / 60, unit) .. ' ' .. name
  elseif sum_time > goal_time and greater_less == "<" then
    -- negative goal failed
    menu_messages.menu= short_name .. ": [❌]"
    menu_messages.menu_msg = '❌ ' .. format_time(sum_time / 60 / 60, unit) .. ' ' .. name
  else
    -- goal pending
    menu_messages.menu = short_name .. ": [" .. time_remaining .. " left]"
    menu_messages.menu_msg = '⏳ ' .. format_time(sum_time / 60 / 60, unit) .. ' ' .. name
  end

  return menu_messages
end

-- process the response
local function onResponse(status, body)
	if status > 400 then
		openRescueTime()
	end

	-- parse json response
   json = hs.json.decode(body)


  -- local menu_messages = {}
  for _, goal in pairs(json) do
    menu_message = build_goal_response(goal.name, goal.sum_durations)
    --  table.insert(menu_messages, menu_message)
    if obj.menu_goal_state[goal.name] then
      obj.menu_goal_state[goal.name].menu_message = menu_message
    else
      obj.menu_goal_state[goal.name] = {
        checked = obj.show_goal_by_default,
        menu_message = menu_message
      }
    end
   end
   updateMenu()
end

-- timer callback, fetch response
onInterval = function ()
  print("Fetching from " .. obj.fetchUrl)
	hs.http.asyncGet(obj.fetchUrl, nil, onResponse)
end

local function refresh(mods, item)
  if mods.cmd == true then
    obj.menu_goal_state = {}
  end
  onInterval()
end


function obj:start()
  print('loaded')
  local interval = config.interval or 60
  self.menutable = {
    { title = "Open RescueTime", fn = openRescueTime },
    { title = "Refresh", fn = refresh },
    { title = "Hide All", fn = hideAll },
    { title = "Show All", fn = showAll }
  }

	self.fetchUrl = 'https://www.rescuetime.com/browse/goals/by/day.json'

  if self.menu then
		self.menu:returnToMenuBar()
  else

    self.menu = hs.menubar.new():setClickCallback(onClick):setIcon(hs.spoons.resourcePath('rescuetime-logo-icon-active.tiff'), false)
    self.menu:setMenu(obj.menutable)
  end

  self.timer = hs.timer.new(interval, onInterval)
  self.timer:start()
  onInterval()

  return self
end


return obj
