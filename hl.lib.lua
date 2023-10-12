local lib = {}

local function twn(...)
	return game:GetService('TweenService'):Create(...)
end

local _TTSERVICE = game:GetService('TextChatService')

local function chat(C_1)
	if game:GetService('ReplicatedStorage'):FindFirstChild('DefaultChatSystemChatEvents') then
		game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest:FireServer(C_1, 'All')
	else
		local _TCHANNEL = _TTSERVICE.TextChannels.RBXGeneral
		_TCHANNEL:SendAsync(C_1)
	end
end

local function breakVelocity(char)
	local isVeloBroken = false
	task.delay(1, function()
		isVeloBroken = true
	end)
	while not isVeloBroken and task.wait() do
		for i, v in next, char:GetChildren() do
			if v:IsA('BasePart') then
				v.Velocity = v.Velocity * Vector3.new(0, 1, 0)
			end
		end
	end
end

local _CFRAMETABLE = {
	{
		-30.9582253,
		1.36195695,
		100.472855
	},
	{
		13.1596403,
		0.731242418,
		152.176956
	},
	{
		69.3110199,
		0.73332727,
		150.993561
	},
	{
		92.6021729,
		0.733850241,
		130.599258
	},
	{
		96.9429169,
		0.738471866,
		75
	},
	{
		91.9788284,
		0.762879133,
		72.3707657
	},
	{
		70.7379608,
		0.737098873,
		50.9553299
	},
	{
		15.6208801,
		0.751551986,
		50.5339737
	},
	{
		-30.9582253,
		1.36195695,
		100.472855
	}
}

local n = false

local function _singsong()
	local httprequest = (syn and syn.request) or http and http.request or http_request or (fluxus and fluxus.request) or request
	local songName, plr
	local debounce = false
	getgenv().stopped = false
	game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents:WaitForChild('OnMessageDoneFiltering').OnClientEvent:Connect(function(msgdata)
		if plr ~= nil and (msgdata.FromSpeaker == plr or msgdata.FromSpeaker == game:GetService('Players').LocalPlayer.Name) then
			if string.lower(msgdata.Message) == '>stop' then
				getgenv().stopped = true
				debounce = true
				task.wait(3)
				debounce = false
			end
		end
		if debounce or game:GetService('Players')[msgdata.FromSpeaker]:GetAttribute('Don') or not string.match(msgdata.Message, '>lyrics ') or string.gsub(msgdata.Message, '>lyrics', '') == '' or game:GetService('Players')[msgdata.FromSpeaker] == game:GetService('Players').LocalPlayer then
			return
		end
		task.spawn(function()
			chat("I'm a lyrics bot. Donate me and I can sing your favorite song!")
		end)
		debounce = true
		local speaker = msgdata.FromSpeaker
		local msg = string.lower(msgdata.Message):gsub('>lyrics ', ''):gsub('"', ''):gsub(' by ', '/')
		local speakerDisplay = game:GetService('Players')[speaker].DisplayName
		plr = game:GetService('Players')[speaker].Name
		songName = string.gsub(msg, " ", ""):lower()
		local response
		local suc, er = pcall(function()
			response = httprequest({
				Url = "https://lyrist.vercel.app/api/" .. songName,
				Method = "GET",
			})
		end)
		if not suc then
			chat("Unexpected error. Please retry, you don't need to donate again.")
			task.wait(3)
			debounce = false
			return
		end
		local lyricsData = game:GetService('HttpService'):JSONDecode(response.Body)
		local lyricsTable = {}
		if lyricsData.error and lyricsData.error == "Lyrics Not found" then
			debounce = true
			chat("Lyrics were not found. Please retry, you don't need to donate again.")
			task.wait(3)
			debounce = false
			return
		end
		for line in string.gmatch(lyricsData.lyrics, "[^\n]+") do
			table.insert(lyricsTable, line)
		end
		game:GetService('Players')[msgdata.FromSpeaker]:SetAttribute('Don',false)
		chat('Fetched lyrics')
		task.wait(2)
		chat('Playing song requested by ' .. speakerDisplay .. '. They can stop it by saying ">stop"')
		task.wait(3)
		for i, line in ipairs(lyricsTable) do
			if getgenv().stopped then
				getgenv().stopped = false
				break
			end
			chat('🎙️ | ' .. line)
			task.wait(4.5)
		end
		task.wait(3)
		debounce = false
		chat('Ended. Donate me if you want me to sing a song again.')
	end)
end

function lib.HLSetup(char)
	highlightcon = task.spawn(_singsong)
end

end

function lib.HLUnload(char)
	if highlightcon then
		task.cancel(highlightcon)
		highlightcon = nil
	end
end

return lib
