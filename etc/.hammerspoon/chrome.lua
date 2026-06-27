-- Option + arrow keys in Chrome
local function chromeOnly(fn)
  return function()
    local app = hs.application.frontmostApplication()
    if app and app:bundleID() == "com.google.Chrome" then
      fn()
    end
  end
end

hs.hotkey.bind({"alt"}, "down",  chromeOnly(function() hs.eventtap.keyStroke({"cmd"},         "w"    ) end))
hs.hotkey.bind({"alt"}, "up",    chromeOnly(function() hs.eventtap.keyStroke({"cmd", "shift"}, "t"    ) end))
hs.hotkey.bind({"shift"}, "left",  chromeOnly(function() hs.eventtap.keyStroke({"cmd", "alt"},   "left" ) end))
hs.hotkey.bind({"shift"}, "right", chromeOnly(function() hs.eventtap.keyStroke({"cmd", "alt"},   "right") end))
