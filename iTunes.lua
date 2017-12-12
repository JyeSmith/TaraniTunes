-- TaraniTunes
-- http://github.com/GilDev/TaraniTunes
-- By GilDev
-- http://gildev.tk

-- CONFIG --

local specialFunctionId = 30 -- This special function will be reserved: 1 for SF1, 2 for SF2…

-- You NEED to use logical switches to manipulate TaraniTunes.

-- WARNING: If you use trims for changing songs for example (and I recommand you do),
-- you need to deactivate the "real" trim functions of the model, to do this,
-- go into "FLIGHT MODES" configuration, go to each flight mode you use for your model
-- and set the throttle "Trims" value (the third if you use the default AETR mode) to "--".

-- Here's how to setup the play switch to SD centered:
-- LOGICAL SWITCH  L61
-- Func   OR
-- V1     SD-
-- V2     SD-
-- Then set playSongLogicalSwitch to 61 below.

-- Here's how to setup the next song switch to throttle trim down:
-- LOGICAL SWITCH  L62
-- Func   OR
-- V1     tTd
-- V2     tTd
-- Then set nextSongLogicalSwitch to 62 below.

local playSongLogicalSwitch   = 61 -- Logical switch that will play the current song
local nextSongLogicalSwitch   = 62 -- Logical switch that will set the current song to the next one
local prevSongLogicalSwitch   = 63 -- Logical switch that will set the current song to the previous one
local randomSongLogicalSwitch = 64 -- Logical switch that will set the current song to a random one

playlist = 
{{"", ""}, {"", ""},
{"Spiderbait - Calypso", "0calyp", "122"},
{"X Gonna Give It To Ya", "0xgona", "24"},
{"Grinspoon - Champion", "0champ", "163"},
{"Grinspoon - Just Ace", "0justa", "109"},
{"Flume - On Top", "0ontop", "232"},
{"System Of A Down - Aerials", "0aeria", "244"},
{"Basement Jaxx - Where's Your Head At", "0head", "238"},
{"Spiderbait - Black Betty", "0black", "205"},
{"Static-X - Push It", "0push", "155"},
{"ben lee, cigarettes will ", "005448", "228"},
{"Hole - Celebrity Skin.mp3", "03be51", "162"},
{"Girls Like That (Dont' Go", "09edf1", "197"},
{"Regurgitator - ! (The Son", "0fcb82", "218"},
{"Harpoon Jebediah.mp3", "08f317", "275"},
{"Powderfinger - The Day Yo", "0341cc", "239"},
{"You Am I - Heavy Heart.mp", "03f27e", "191"},
{"Save The Day - The Living", "050606", "176"},
{"Ben Folds Five- Brick (wi", "01602c", "283"},
{"Dr Worm (Music Video) by ", "023501", "193"},
{"Blink 182 - Josie (Everyt", "0b770b", "199"},
{"Second Solution - The Liv", "0b5456", "180"},
{"Josh Abrahams & Amiel Dae", "0faeff", "234"},
{"Grinspoon - Just Ace (HQ)", "083a89", "109"},
{"Marcy Playground - Sex An", "024815", "185"},
{"Grinspoon - Black Friday ", "027867", "151"},
{"Massive Attack - Teardrop", "02a5f6", "332"},
{"Custard - Music Is Crap.m", "003069", "183"},
{"Regurgitator - Polyester ", "0825ce", "213"},
{"Happyland - Dont You Know", "0c5744", "141"},
{"Jeff Buckley - Everybody ", "0bdfc9", "295"},
{"CAKE - Never There.mp3", "01dde7", "166"},
{"Throw Your Arms Around Me", "097d1e", "326"},
{"Regurgitator - Black Bugs", "02766a", "146"},
{"Eskimo Joe - Sweater.mp3", "0d251c", "120"},
{"Barenaked Ladies - One We", "0ee764", "174"},
{"Harvey Danger- Flagpole s", "0503fd", "216"},
{"The Whitlams - Buy Now Pa", "0a61fc", "226"},
{"The Mighty Mighty Bosston", "07267f", "201"},
{"Adam Sandler - Somebody K", "08a958", "139"},
{"Song for The Dumped- Ben ", "0b3b1e", "221"},
{"JEBEDIAH - Teflon.mp3", "0daf99", "226"},
{"The Whitlams - Melbourne.", "05a8d3", "290"},
{"Marilyn Manson - 2. The D", "08b1d5", "226"},
{"The Smashing Pumpkins - A", "064ad3", "259"},
{"PowderFinger - I Don´t W", "0a3be0", "134"},
{"Pearl Jam - Do the Evolut", "068a7b", "240"},
{"Hole - Malibu.mp3", "008a98", "232"},
{"Run DMC vs Jason Nevins -", "0cd90f", "500"},
{"Pearl Jam - Given To Fly.", "03f15e", "241"},
{"Green Day The Grouch lyri", "0bdc6f", "136"},
{"Everclear - Father Of Min", "021471", "239"},
{"Frenzal Rhomb - Mum Chang", "0156af", "118"},
{"The Whitlams - Charlie No", "0e9c37", "263"},
{"I Think I'm Paranoid - Ga", "052994", "218"},
{"Pauline Pantsdown I Don't", "068e9e", "306"},
{"untouchable face - Ani Di", "079304", "261"},
{"The Mavis's - Cry (1998).", "031c9f", "245"},
{"The Offspring - Gone Away", "00246e", "269"},
{"Antenna - Come On Spring.", "0a6d38", "272"},
{"you am i - rumble [audio ", "0e9154", "159"},
{"Metallica The Unforgiven ", "096a6d", "409"},
{"Everyday Should Be a Holi", "0d56b8", "245"},
{"Pollyanna - Cinnamon Lip.", "0d4661", "150"},
{"Happyland - Hello.mp3", "02e404", "177"},
{"Frenzal Rhomb - Mr Charis", "08e345", "140"},
{"Foo Fighters - My Hero.mp", "0b4655", "259"},
{"Rob Zombie - Dragula.mp3", "0a0f85", "228"},
{"Marcy Playground - Saint ", "0a9505", "199"},
{"Metallica - FUEL with lyr", "03b91c", "275"},
{"Fuel - Shimmer.mp3", "06beef", "214"},
{"Grinspoon - Don't Go Away", "0d811d", "175"},
{"Babybird - Bad Old Man.mp", "027eb8", "256"},
{"Bran Van 3000 - Drinking ", "01e7aa", "236"},
{"Drugstore feat. Thom York", "0e837c", "178"},
{"The Superjesus Now+Then.m", "0e2c95", "246"},
{"Green Day - Good Riddance", "0d5b5c", "153"},
{"Something For Kate - Harp", "0d28e0", "258"},
{"Ben Harper Mama's Trippin", "0a7f17", "224"},
{"Garbage - Push It.mp3", "0e3433", "250"},
{"Pearl Jam - Wishlist.mp3", "01bbf1", "206"},
{"Garbage - Special.mp3", "04d0a4", "245"},
{"JEBEDIAH Benedict..mp3", "0b1766", "243"},
{"Space ft Cerys Mathews - ", "026a84", "252"},
{"Beck - Tropicalia.mp3", "07eb34", "202"},
{"Midnight Oil - Redneck Wo", "0e74fe", "189"},
{"Even - 'Black Umbrella'.m", "036b19", "205"},
{"Foo Fighters - Baker stre", "097cbd", "348"},
{"The Superjesus - Saturati", "0a0732", "245"},
{"", ""}, {"", ""}}

-- DON'T EDIT BELOW THIS LINE --

local errorOccured = false
local screenUpdate = true
local nextScreenUpdate = false

local playingSong = 3
local selection = 3

local songChanged = false
local resetDone = false

local nextRandomSongTime = 0

local function error(strings)
	errorStrings = strings
	errorOccured = true
end

function playSong()
	model.setCustomFunction(
		specialFunctionId,
		{
			switch = playSongSwitchId,
			func = 16,
			name = playlist[playingSong][2]
		}
	)
end

function resetSong()
	model.setCustomFunction(
		specialFunctionId,
		{
			switch = -playSongSwitchId
		}
	)
end

function getPlaySongSwitchId(Switch)
	if LCD_W == 212 then -- if Taranis X9D
		return 50 + Switch
	else -- if Taranis Q X7
		return 38 + Switch
	end
end

local function init()
	-- Calculate indexes
	specialFunctionId  = specialFunctionId - 1 -- SF1 is at index 0 and so on

	playSongSwitchId = getPlaySongSwitchId(playSongLogicalSwitch)

	nextSongSwitchId   = getFieldInfo("ls" .. nextSongLogicalSwitch).id
	prevSongSwitchId   = getFieldInfo("ls" .. prevSongLogicalSwitch).id
	randomSongSwitchId = getFieldInfo("ls" .. randomSongLogicalSwitch).id
	
	nextScreenUpdate = true
	screenUpdate = true
	songChanged = true
end

nextSongSwitchPressed   = false;
prevSongSwitchPressed   = false;
randomSongSwitchPressed = false;

local function background()

	if getValue(randomSongSwitchId) > 0 then
		playSongSwitchId = getPlaySongSwitchId(randomSongLogicalSwitch)
	else
		playSongSwitchId = getPlaySongSwitchId(playSongLogicalSwitch)
		playSong()
	end

	if resetDone then
		playSong()
		resetDone = false
	end
	
	if songChanged then
		resetSong()
		songChanged = false
		resetDone = true
		nextRandomSongTime = getTime() + playlist[playingSong][3]*100
	end

		-- Next song
	if getValue(nextSongSwitchId) > 0 then
		if not nextSongSwitchPressed then
			nextSongSwitchPressed = true
			nextScreenUpdate = true
			songChanged = true
			screenUpdate = true
			if playingSong < #playlist - 2 then
				playingSong = playingSong + 1
			else
				playingSong = 3
			end
		end
	else
		nextSongSwitchPressed = false
	end

	-- Previous song
	if getValue(prevSongSwitchId) > 0 then
		if not prevSongSwitchPressed then
			prevSongSwitchPressed = true
			nextScreenUpdate = true
			songChanged = true
			screenUpdate = true
			if playingSong > 3 then
				playingSong = playingSong - 1
			else
				playingSong = #playlist - 2
			end
		end
	else
		prevSongSwitchPressed = false
	end

	-- Random song

	if getValue(randomSongSwitchId) > 0 and getTime() > nextRandomSongTime then
		if not randomSongSwitchPressed then
			randomSongSwitchPressed = true
			playingSong = math.random (3, #playlist - 2)
			songChanged = true
			screenUpdate = true
			nextScreenUpdate = true
		end
	else
		randomSongSwitchPressed = false
	end

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
		songChanged = true
		screenUpdate = true
	elseif nextScreenUpdate then
		selection = playingSong
		nextScreenUpdate = false
	end

	-- Song time remaining
	local timeRemaining = math.floor((nextRandomSongTime - getTime())/100)
	--lcd.drawText(LCD_W - 27, 9, timeRemaining .. "s", SMLSIZE)
	lcd.drawTimer(LCD_W - 27, 9, timeRemaining, SMLSIZE)

	-- DRAWING --
	if screenUpdate or event == 191 then -- 191 is the event code when entering the telemetry screen
		screenUpdate = false

		lcd.clear();

		-- Title
		lcd.drawText(1, 1, "TaraniTunes", MIDSIZE)
		-- Sorry Gil, I needed the space :(
		--lcd.drawText(LCD_W - 19, 1, "By", SMLSIZE)
		--lcd.drawText(LCD_W - 27, 9, "GilDev", SMLSIZE)
		lcd.drawTimer(LCD_W - 27, 9, timeRemaining, SMLSIZE)

		-- Separator
		lcd.drawLine(0, 16, LCD_W - 1, 16, SOLID, FORCE)

		-- Print error
		if errorOccured then
			yLine = {18, 26, 34, 42, 50}
			for i = 1, #errorStrings do
				lcd.drawText(1, yLine[i], errorStrings[i])
			end

			return
		end

		-- Now playing
		lcd.drawText(1, 18, string.char(62) .. playlist[playingSong][1])

		-- Separator
		lcd.drawLine(0, 26, LCD_W - 1, 26, DOTTED, FORCE)

		-- Song selector
		lcd.drawText(1, 28, playlist[selection - 2][1], SMLSIZE)
		lcd.drawText(3, 35, playlist[selection - 1][1], SMLSIZE)
		lcd.drawText(1, 42, string.char(126) .. playlist[selection][1], SMLSIZE)
		lcd.drawText(3, 49, playlist[selection + 1][1], SMLSIZE)
		lcd.drawText(1, 56, playlist[selection + 2][1], SMLSIZE)

	end
end

return {run = run, background = background, init = init}
