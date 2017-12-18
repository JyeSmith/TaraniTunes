-- TaraniTunes
-- http://github.com/GilDev/TaraniTunes
-- By GilDev
-- http://gildev.tk

-- CONFIG --

-- DON'T EDIT BELOW THIS LINE --

f = assert (loadScript ("playlist.lua"))
--f = assert (loadScript ("/SOUNDS/playlist.lua"))
--f = assert (loadfile ("playlist.lua"))
f () -- execute function now

local specialFunctionId = 30 -- This special function will be reserved: 1 for SF1, 2 for SF2…

local errorOccured = false
local screenUpdate = true
local nextScreenUpdate = true

local playingSong = 3
local selection = 3
local currentSwitchChoice = 'NA'
local toggleWheelPresded = false

local timeUntilNextSong = 0

local function error(strings)
	errorStrings = strings
	errorOccured = true
end

function songStop()
	model.setCustomFunction(specialFunctionId,{switch=7}) 
end

function songChanged()
	songStop()
	model.setCustomFunction(specialFunctionId,{switch=playSongSwitchId; func=16; name=playlist[playingSong][2]}) 
	timeUntilNextSong = getTime() + playlist[playingSong][3]*100
end

local function init()
	-- Calculate indexes
	specialFunctionId  = specialFunctionId - 1 -- SF1 is at index 0 and so on

	currentSwitchChoice = getValue('sc')
end

local function background()

	-- Toggle Wheel 
	if toggleWheelPresded then
		songChanged()
		toggleWheelPresded = false

	-- Stop song
	elseif getValue('sc') < 0 then
		screenUpdate = true
		timeUntilNextSong = getTime()

	-- Play song
	elseif getValue('sc') == 0 then
		playSongSwitchId = 8

		if currentSwitchChoice ~= getValue('sc') then 
			timeUntilNextSong = 0 
			currentSwitchChoice = getValue('sc')
		end

		if getTime() >= timeUntilNextSong then
			playingSong = playingSong + 1
			songStop()
			songChanged()
			screenUpdate = true
			nextScreenUpdate = true
		end

	-- Random song
	elseif getValue('sc') > 0 then
		playSongSwitchId = 9

		if currentSwitchChoice ~= getValue('sc') then
			timeUntilNextSong = 0
			currentSwitchChoice = getValue('sc')
		end

		if getTime() >= timeUntilNextSong then
			playingSong = math.random (3, #playlist - 2)
			songStop()
			songChanged()
			screenUpdate = true
			nextScreenUpdate = true
		end

	end

end

function drawDot(x, y)
	lcd.drawLine(x, y, x, y, SOLID, FORCE)
end

local function run(event)
	-- INPUT HANDLING --
	if (event == EVT_ROT_RIGHT or event == EVT_MINUS_FIRST or event == EVT_MINUS_RPT)
		and selection < #playlist - 2 then
		selection = selection + 1
		screenUpdate = true
	elseif (event == EVT_ROT_RIGHT or event == EVT_MINUS_FIRST or event == EVT_MINUS_RPT)
		and selection == #playlist - 2 then
		selection = 3
		screenUpdate = true
	elseif (event == EVT_ROT_LEFT or event == EVT_PLUS_FIRST or event == EVT_PLUS_RPT) and selection > 3 then
		selection = selection - 1
		screenUpdate = true
	elseif (event == EVT_ROT_LEFT or event == EVT_PLUS_FIRST or event == EVT_PLUS_RPT) and selection == 3 then
		selection = #playlist - 2
		screenUpdate = true
	elseif event == EVT_ROT_BREAK or event == EVT_ENTER_BREAK then -- Play selected song
		playingSong = selection
		screenUpdate = true
		toggleWheelPresded = true
		songStop()
	elseif nextScreenUpdate then
		selection = playingSong
		nextScreenUpdate = false
	end

	-- Song time remaining
	local timeRemaining = math.ceil((timeUntilNextSong - getTime())/100)
	lcd.drawTimer(LCD_W - 35, 3, timeRemaining, MIDSIZE)

	-- DRAWING --
	if screenUpdate or event == 191 then -- 191 is the event code when entering the telemetry screen
		screenUpdate = false

		lcd.clear();

		-- Symbols

		-- Stop
		for i=4,13 do lcd.drawLine(9, i, 18, i, SOLID, FORCE) end

		-- Play
		playMatrix = 
		{
		{1,1,0,0,0,0,0,0,0,0},
		{1,1,1,1,0,0,0,0,0,0},
		{1,1,1,1,1,1,0,0,0,0},
		{1,1,1,1,1,1,1,1,0,0},
		{1,1,1,1,1,1,1,1,1,1},
		{1,1,1,1,1,1,1,1,1,1},
		{1,1,1,1,1,1,1,1,0,0},
		{1,1,1,1,1,1,0,0,0,0},
		{1,1,1,1,0,0,0,0,0,0},
		{1,1,0,0,0,0,0,0,0,0}
		}

		for x=1,10 do 
			for y=1,10 do
				if playMatrix[x][y] == 1 then drawDot(y+23, x+3) end
			end
		end

		-- Random
		randomMatrix = 
		{
		{0,0,0,0,0,0,0,1,0,0},
		{1,1,0,1,1,1,1,1,1,0},
		{1,1,0,1,1,1,1,1,1,1},
		{1,1,0,1,1,0,0,1,1,0},
		{0,0,0,1,1,0,0,1,0,0},
		{0,0,0,1,1,0,0,1,0,0},
		{1,1,1,1,1,0,1,1,1,0},
		{1,1,1,1,1,0,1,1,1,1},
		{1,1,1,1,1,0,1,1,1,0},
		{0,0,0,0,0,0,0,1,0,0}
		}

		for x=1,10 do 
			for y=1,10 do
				if randomMatrix[x][y] == 1 then drawDot(y+38, x+3) end
			end
		end

		-- Draw Square
		local squareOffSet = 0
		if getValue('sc') < 0	then squareOffSet = 5 end
		if getValue('sc') == 0	then squareOffSet = 20 end
		if getValue('sc') > 0	then squareOffSet = 35 end

		lcd.drawLine(squareOffSet+2, 2, squareOffSet+2, 15, SOLID, FORCE)
		lcd.drawLine(squareOffSet+2, 15, squareOffSet+15, 15, SOLID, FORCE)
		lcd.drawLine(squareOffSet+15, 15, squareOffSet+15, 2, SOLID, FORCE)
		lcd.drawLine(squareOffSet+15, 2, squareOffSet+2, 2, SOLID, FORCE)

		-- Time
		lcd.drawTimer(LCD_W - 35, 3, timeRemaining, MIDSIZE)

		-- Print error
		if errorOccured then
			yLine = {18, 26, 34, 42, 50}
			for i = 1, #errorStrings do
				lcd.drawText(1, yLine[i], errorStrings[i])
			end

			return
		end

		-- Now playing black backround for songs that dont span the display
		for i=17,25 do lcd.drawLine(0, i, LCD_W - 1, i, SOLID, FORCE) end

		-- Now playing
		lcd.drawText(1, 18, playlist[playingSong][1], INVERS)

		-- Song selector
		lcd.drawText(1, 28, playlist[selection - 2][1], SMLSIZE)
		lcd.drawText(3, 35, playlist[selection - 1][1], SMLSIZE)
		lcd.drawText(1, 42, string.char(126) .. playlist[selection][1], SMLSIZE)
		lcd.drawText(3, 49, playlist[selection + 1][1], SMLSIZE)
		lcd.drawText(1, 56, playlist[selection + 2][1], SMLSIZE)
		
		-- Draw side bar
		lcd.drawLine(	LCD_W-1, 26+math.floor((LCD_H-31)*(selection-2)/(#playlist-4)), 
				LCD_W-1, 26+math.floor((LCD_H-31)*(selection-2)/(#playlist-4))+4, SOLID, FORCE)
		lcd.drawLine(	LCD_W-2, 26+math.floor((LCD_H-31)*(selection-2)/(#playlist-4)), 
				LCD_W-2, 26+math.floor((LCD_H-31)*(selection-2)/(#playlist-4))+4, SOLID, FORCE)

	end
end

return {run = run, background = background, init = init}
