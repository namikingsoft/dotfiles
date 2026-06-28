local function chromeOnly(fn)
  return function()
    local app = hs.application.frontmostApplication()
    if app and app:bundleID() == "com.google.Chrome" then
      fn()
    end
  end
end

hs.hotkey.bind({"option"}, "m", chromeOnly(function() hs.eventtap.keyStroke({"cmd"}, "w") end))
hs.hotkey.bind({"option"}, "n", chromeOnly(function() hs.eventtap.keyStroke({"cmd", "shift"}, "t") end))
hs.hotkey.bind({"option"}, ",", chromeOnly(function() hs.eventtap.keyStroke({"cmd", "alt"}, "left") end))
hs.hotkey.bind({"option"}, ".", chromeOnly(function() hs.eventtap.keyStroke({"cmd", "alt"}, "right") end))
