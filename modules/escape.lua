local caps_mode = hs.hotkey.modal.new()
local inputEnglish = "com.apple.keylayout.ABC"
local unicodeHexLayout = "com.apple.keylayout.UnicodeHexInput"

local on_caps_mode = function()
    caps_mode:enter()
end

local off_caps_mode = function()

    caps_mode:exit()

    local input_source = hs.keycodes.currentSourceID()

    if not (input_source == unicodeHexLayout) then
        hs.eventtap.keyStroke({}, 'right')
        hs.keycodes.currentSourceID(unicodeHexLayout)
        hs.eventtap.keyStroke({}, 'escape')
    end
    hs.eventtap.keyStroke({}, 'escape')
end

hs.hotkey.bind({}, 'f13', on_caps_mode, off_caps_mode)