hs.urlevent.bind("review-pr", function(eventName, params)
  hs.alert.show("Whoop Whoop! \n Time To Review PRs \n And email too \n\n (Hyper + Q)",
    {['textSize'] = 120, ['atScreenEdge'] = 1 }, 'never')
end)

hs.urlevent.bind("lunch", function(eventName, params)
  hs.alert.show("Lunch Time Muthafucka", 'never')
end)

hs.urlevent.bind("workharder", function(eventName, params)
  hs.alert.show("Work Harder \n (Hyper + Q)", {['textSize'] = 120 }, 'never')
end)

hs.hotkey.bind({'shift', 'ctrl', 'alt', 'cmd'}, 'q', function()
  hs.alert.closeAll()
end)
