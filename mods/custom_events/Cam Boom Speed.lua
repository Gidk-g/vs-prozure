boomspeed = 4
bam = 1
songEnded = false

function onEvent(name, value1, value2)
    if name == "Cam Boom Speed" then
        boomspeed = tonumber(value1)
        bam = tonumber(value2)
    end
end

function onBeatHit(curBeat)
	if curBeat % boomspeed == 0 and not songEnded then
		triggerEvent("Add Camera Zoom", 0.015 * bam, 0.03 * bam)
		if getProperty('camGame.zoom') >= 1.35 then
			setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.025 * bam);
			setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.03 * bam);
		end
	end
end

function onEndSong()
    songEnded = true
    return Function_Continue;
end