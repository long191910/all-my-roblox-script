local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer
task.spawn(function()
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Ty for using my script",
			Text = "Please report bugs in comment",
			Duration = 6
		})
	end)
end)
local AnimationTriggers = {
	["rbxassetid://100962226150441"] = 0.18,
	["rbxassetid://95852624447551"] = 0.18,
	["rbxassetid://74145636023952"] = 0.18,
	["rbxassetid://72475960800126"] = 0.20,
}

local todo1 = "rbxassetid://100081544058065"
local todo2 = "rbxassetid://123167492985370"
local function pressKey(keyCode)
	VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
	VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
end
local function setupCharacter(character)
	local humanoid = character:WaitForChild("Humanoid", 5)
	if not humanoid then return end

	local animator = humanoid:WaitForChild("Animator", 5)
	if not animator then return end

	animator.AnimationPlayed:Connect(function(track)
		local animId = track.Animation.AnimationId
		local delayTime = AnimationTriggers[animId]
		if delayTime then
			task.delay(delayTime, function()
				if humanoid.Health > 0 then
					pressKey(Enum.KeyCode.Three)
				end
			end)
		end
		if animId == todo1 then
			task.spawn(function()
				task.wait(0.3)
				if humanoid.Health <= 0 then return end
				pressKey(Enum.KeyCode.Two)
			end)
		end

		if animId == todo2 then
			task.spawn(function()
				task.wait(0.6)
				if humanoid.Health <= 0 then return end
				pressKey(Enum.KeyCode.Two)
			end)
		end
	end)
end
if player.Character then
	setupCharacter(player.Character)
end

player.CharacterAdded:Connect(function(character)
	task.wait(0.2)
	setupCharacter(character)
end)
