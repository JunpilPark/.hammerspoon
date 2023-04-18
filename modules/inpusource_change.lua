local inputSources = {
    { key = "f1", id = "com.apple.keylayout.ABC" }, -- 영어
    --{ key = "f2", id = "com.apple.inputmethod.Korean.2SetKorean" }, -- 한글
    { key = "f2", id = "org.youknowone.inputmethod.Gureum.han2" }, -- 한글
    { key = "f3", id = "com.apple.keylayout.UnicodeHexInput" }, -- UnicodeHexInput
}
local log = hs.logger.new('myLog', 'debug')

local currentSourceIndex = 1

local function changeInputSourceByNumber(key)
    for _, source in ipairs(inputSources) do
        if source.key == key then
            hs.keycodes.currentSourceID(source.id)
            break
        end
    end
end

local function cycleInputSource()
    log.d(string.format("변수의 값: %s", hs.keycodes.currentSourceID()))
    currentSourceIndex = currentSourceIndex % #inputSources + 1
    hs.keycodes.currentSourceID(inputSources[currentSourceIndex].id)
end

local f16Pressed = false

-- F16 키를 누르고 있는지 확인
hs.hotkey.bind({}, "F16", function()
    f16Pressed = true
end, function()
    f16Pressed = false
end)

-- F16 누른 상태에서 숫자 키를 누를 때 입력 소스 변경
for _, source in ipairs(inputSources) do
    hs.hotkey.bind({}, source.key, function()
        if f16Pressed then
            changeInputSourceByNumber(source.key)
        end
    end)
end

-- Cmd + F16 조합으로 순차적으로 입력 소스 변경
hs.hotkey.bind({"cmd"}, "F16", cycleInputSource)
