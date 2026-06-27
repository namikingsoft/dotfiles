-- Triple-tap Option key to turn off display
local optionPressCount = 0
local lastOptionTime = 0
local tripleTapThreshold = 0.5 -- seconds

local function onFlagsChanged(event)
  local flags = event:getFlags()

  -- Option のみ押された瞬間（他の modifier なし）
  if flags.alt and not flags.cmd and not flags.shift and not flags.ctrl then
    local now = hs.timer.secondsSinceEpoch()

    if (now - lastOptionTime) < tripleTapThreshold then
      optionPressCount = optionPressCount + 1
    else
      optionPressCount = 1
    end

    lastOptionTime = now

    if optionPressCount >= 2 then
      optionPressCount = 0
      hs.execute("pmset displaysleepnow")
    end
  end

  return false
end

local flagsWatcher = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, onFlagsChanged)
flagsWatcher:start()
