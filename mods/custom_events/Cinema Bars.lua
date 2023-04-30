local thing = {'Top', 'Bot'}

function onCreate()
    for i = 1, #thing do
        makeLuaSprite('bar' .. thing[i])
        makeGraphic('bar' .. thing[i], screenWidth, screenHeight, '000000')
        addLuaSprite('bar' .. thing[i], false)
        setObjectCamera('bar' .. thing[i], 'hud')
        setProperty('bar' .. thing[i] .. '.antialiasing', false)
        setProperty('bar' .. thing[i] .. '.y', false)
    end
    setProperty('barTop.y', getProperty('barTop.y') - (screenHeight / 1))
end

function onUpdate()
    setProperty('barBot.y', (getProperty('barTop.y') - (getProperty('barTop.y') * 2)))
    for i = 1, #thing do
        setObjectOrder('bar' .. thing[i], 0)
        screenCenter('bar' .. thing[i], 'X')
        setProperty('bar' .. thing[i] .. '.width', screenWidth)
        setProperty('bar' .. thing[i] .. '.height', screenHeight)
    end
end

function onEvent(name, value1, value2)
    if name == 'Cinema Bars' then
	    Speed = tonumber(value1)
        Ylevel = tonumber(value2)

        if Ylevel == nil or Ylevel == '' then
            Ylevel = 95
        elseif Ylevel < 0 then
            Ylevel = 0
        elseif Ylevel > 360 then
            Ylevel = 360
        end

        doTweenY('moveBar', 'barTop', Ylevel - screenHeight, Speed, 'QuadOut')
    end
end

function onGameOverStart()
    for i = 1, #thing do
        removeLuaSprite('bar' .. thing[i], true)
    end
end

function Split(s, delimiter)
	result = {}
	for match in (s..delimiter):gmatch('(.-)'..delimiter) do
		table.insert(result, tostring(match))
	end
	return result
end