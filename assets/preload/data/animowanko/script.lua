function onCreatePost()
	makeLuaSprite('bgThing', '', -500, 255)
    makeGraphic('bgThing', 1300, 250, '000000')
    scaleObject('bgThing', 0.35, 0.43)
    setProperty("bgThing.alpha", 0.7)
	setObjectCamera('bgThing', 'other')
    setScrollFactor('bgThing', 0, 0)

	makeLuaSprite('Icon', 'icon-prozure', -150, 225)
    scaleObject('Icon', 0.70, 0.70)
	setObjectCamera('Icon', 'other')
    setProperty('Icon.angle', 10)
    setScrollFactor('Icon', 0, 0)

    makeLuaText('songText', "Wipek - Animowanko", 400, getProperty('bgThing.x') + 180, 320)
    setObjectCamera("songText", 'other');
    setTextColor('songText', '0xffffff')
    setTextSize('songText', 30);
    setTextFont('songText', "vcr.ttf")
    setTextAlignment('songText', 'left')

    makeLuaText('beforeSongText', "Now Playing... ", 300, getProperty('bgThing.x') + 30 - 40, 290)
    setObjectCamera("beforeSongText", 'other');
    setTextColor('beforeSongText', '0xffffff')
    setTextSize('beforeSongText', 25);
    setTextFont('beforeSongText', "vcr.ttf")
    setTextAlignment('beforeSongText', 'left')

    setObjectOrder('beforeSongText', 3)
    setObjectOrder('songText', 3)
    setObjectOrder('bgThing', 2)

    addLuaSprite('bgThing', true)
    addLuaSprite('Icon', true)
    addLuaText("songText", true);
    addLuaText("beforeSongText", true);
end

function onSongStart()
    doTweenX('bgThingMoveIn', 'bgThing', -50, 0.6, 'linear')
    doTweenX('bgThingText', 'songText', 70, 0.6, 'linear')
    doTweenX('bgThingTextBleb', 'beforeSongText', 20, 0.6, 'linear') 
    doTweenX('bgThingTextBlebe', 'Icon', 310, 0.6, 'linear')
    runTimer('moveOut', 3.7, 1)
end

function onTimerCompleted(tag)
    if tag == 'moveOut' then
        doTweenX('bgThingLeave', 'bgThing', -700, 0.6, 'linear')
        doTweenX('bgThingLeaveText', 'songText', -500, 0.6, 'linear')
        doTweenX('bgThingLeavePreText', 'beforeSongText', -400, 0.6, 'linear')
        doTweenX('bgThingLeavePreIcon', 'Icon', -300, 0.6, 'linear')
    end
end

function onTweenCompleted(tag)
    if tag == 'bgThingLeave' then
        removeLuaSprite('bgThing', true)
        removeLuaText('songText', true)
        removeLuaText('beforeSongText', true)
        removeLuaText('Icon', true)
    end
end