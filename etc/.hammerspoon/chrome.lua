local CHROME = "com.google.Chrome"

local function chromeOnly(fn)
  return function()
    local app = hs.application.frontmostApplication()
    if app and app:bundleID() == CHROME then
      fn()
    end
  end
end

-- option + left/right to switch tabs in Chrome
hs.hotkey.bind({"option"}, "left", chromeOnly(function() hs.eventtap.keyStroke({"cmd", "alt"}, "left") end))
hs.hotkey.bind({"option"}, "right",   chromeOnly(function() hs.eventtap.keyStroke({"cmd", "alt"}, "right") end))

-- option + down/up to close/reopen tabs in Chrome
hs.hotkey.bind({"option"}, "down", chromeOnly(function() hs.eventtap.keyStroke({"cmd"},         "w") end))
hs.hotkey.bind({"option"}, "up",   chromeOnly(function() hs.eventtap.keyStroke({"cmd", "shift"}, "t") end))
