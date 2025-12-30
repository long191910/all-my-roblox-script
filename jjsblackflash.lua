local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local funny = "rbxassetid://100962226150441"
local currentConnection
local function main(character)
	local humanoid = character:WaitForChild("Humanoid", 10)
	if not humanoid then return end

	local animator = humanoid:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end
	if currentConnection then
		currentConnection:Disconnect()
	end
	currentConnection = animator.AnimationPlayed:Connect(function(track)
		if track.Animation.AnimationId == funny then
			task.delay(0.1, function()
				VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Three, false, game)
				VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Three, false, game)
			end)
		end
	end)
end
if player.Character then
	main(player.Character)
end
player.CharacterAdded:Connect(function(character)
	task.wait(0.1)
	main(character)
end)
