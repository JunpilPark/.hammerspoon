local obj = {}

function obj:init()
    hs.loadSpoon('Caffeine')

    spoon.Caffeine:bindHotkeys({
        toggle = {{'control', 'shift', 'command'}, 'c'},
    })

    spoon.Caffeine:start()
    spoon.Caffeine:setState(true)
end

return obj