local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:WaitForChild("Animator")
local funny = "rbxassetid://100962226150441"
animator.AnimationPlayed:Connect(function(animationTrack)
	if animationTrack.Animation.AnimationId == funny then
		task.delay(0.2, function()
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Three, false, game)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Three, false, game)
		end)
	end
end)
if player.Character then
	setupCharacter(player.Character)
end
player.CharacterAdded:Connect(function(character)
	setupCharacter(character)
end)
