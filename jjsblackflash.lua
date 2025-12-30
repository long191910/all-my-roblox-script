local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer
local funny = "rbxassetid://100962226150441"
local function hookAnimator(animator)
	animator.AnimationPlayed:Connect(function(track)
		if track.Animation.AnimationId == funny then
			task.delay(0.2, function()
				VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Three, false, game)
				VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Three, false, game)
			end)
		end
	end)
end

local function setupCharacter(character)
	local humanoid = character:WaitForChild("Humanoid")
	local animator = humanoid:FindFirstChild("Animator")
	if animator then
		hookAnimator(animator)
	end
	humanoid.ChildAdded:Connect(function(child)
		if child:IsA("Animator") then
			hookAnimator(child)
		end
	end)
end
if player.Character then
	setupCharacter(player.Character)
end
player.CharacterAdded:Connect(setupCharacter)
