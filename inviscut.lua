
-- [ctrl + C] = save position
-- [ctrl + R] = delete saved position
-- [ctrl + H] = toggle between seeing the saved positions
-- [E]           = tp to checkpoint
-- version 2.2- fixed scroll bug
-- made by Kubalo#5620
wait(0.5)
local scriptversion = "Version 2.2"


if game.Workspace:FindFirstChild("Positions") == nil then
	local folder = Instance.new("Folder")
	folder.Name = "Positions"
	folder.Parent = game.Workspace
end

local UserInputService = game:GetService("UserInputService")
local plr = game.Players.LocalPlayer
local number = 1
local runService = game:GetService("RunService")
local camera = workspace.CurrentCamera
local trole = false

game.Workspace:WaitForChild(game.Players.LocalPlayer.Name)
game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name):WaitForChild("HumanoidRootPart")

local saveload = Instance.new("ScreenGui")
local Save = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local R = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local mouse = plr:GetMouse()

--Properties:

saveload.Name = "saveload"
saveload.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
saveload.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
saveload.ResetOnSpawn = false

Save.Name = "Save"
Save.BackgroundTransparency = 1
Save.TextTransparency = 1
Save.Parent = saveload
Save.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Save.Position = UDim2.new(1, -100, 1, -40)
Save.Size = UDim2.new(0, 100, 0, 40)
Save.Font = Enum.Font.SourceSans
Save.TextScaled = true
Save.TextStrokeTransparency = 1
Save.TextWrapped = true

UICorner.Parent = Save

R.Name = "R"
R.Parent = saveload
R.BackgroundTransparency = 1
R.TextTransparency = 1
R.TextStrokeTransparency = 1
R.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
R.Position = UDim2.new(1, -128, 1, -40)
R.Size = UDim2.new(0, 40, 0, 40)
R.ZIndex = 2
R.Font = Enum.Font.SourceSans
R.TextScaled = true
R.TextWrapped = true

UICorner_2.Parent = R
camera = workspace.CurrentCamera
local cameramin = plr.CameraMinZoomDistance
local cameramax = plr.CameraMaxZoomDistance


local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local hum = plr.Character:WaitForChild('Humanoid')
local debounce1 = true
local debounce2 = true
local debounce3 = true

UserInputService.InputBegan:Connect(function(key, v)
  if v then return end
	if key.KeyCode == Enum.KeyCode.C then
		if debounce1 then
			debounce1 = false
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
				if hum.Health ~= 0 or plr.Character.Humanoid ~= nil then
					camera = workspace.CurrentCamera
					hrp = game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).HumanoidRootPart
					local hitbox = Instance.new("Part")
					hitbox.Name = tostring(number)
					hitbox.Parent = game.Workspace.Positions
					hitbox.Size = Vector3.new(2,2,1)
					hitbox.CanCollide = false
					hitbox.Transparency = 1
					hitbox.CFrame = hrp.CFrame
					hitbox.Anchored = true

					local cam = Instance.new("CFrameValue")
					cam.Value = camera.CFrame
					cam.Name = "camera"
					cam.Parent = hitbox
					
					local shiftlock = Instance.new("BoolValue")
					if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
						shiftlock.Value = true
					else
						shiftlock.Value = false
					end
					shiftlock.Name = "shiftlock"
					shiftlock.Parent = hitbox
					
					local zoom = Instance.new("NumberValue")
					zoom.Value = (camera.CFrame.Position - camera.Focus.Position).Magnitude
					zoom.Name = "zoom"
					zoom.Parent = hitbox

					number = number + 1
					Save.TextTransparency = 1
					Save.BackgroundTransparency = 0
					wait()
					Save.BackgroundTransparency = 1
					
				end
			end
			debounce1 = true
		end
	end

	if key.KeyCode == Enum.KeyCode.R then
		if debounce2 then
			debounce2 = false
			if number ~= 1 then
				if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
					game.Workspace.Positions:FindFirstChild(number - 1):Destroy()
					number = number - 1
					R.BackgroundTransparency = 0
					wait()
					R.BackgroundTransparency = 1
				end
			end
			debounce2 = true
		end
	end

	if key.KeyCode == Enum.KeyCode.H then
		if debounce3 then
			debounce3 = false
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
				if trole == false then
					trole = true
					for _,v in pairs(game.Workspace.Positions:GetChildren()) do
						v.Transparency = 0.75
					end
				else
					trole = false
					for _,v in pairs(game.Workspace.Positions:GetChildren()) do
						v.Transparency = 1
					end
				end
			end
			debounce3 = true
		end
	end

	if key.KeyCode == Enum.KeyCode.E then
		if plr.Character.HumanoidRootPart ~= nil then
			if number ~= 1 then
				hrp = game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).HumanoidRootPart
				hum = game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).Humanoid
				camera = workspace.CurrentCamera
				camera.CFrame = game.Workspace.Positions:FindFirstChild(tostring(number - 1)).camera.Value
				hrp.CFrame = game.Workspace.Positions:FindFirstChild(tostring(number - 1)).CFrame
				if game.Workspace.Positions:FindFirstChild(tostring(number - 1)).shiftlock.Value == true then
					if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
						Save.BackgroundTransparency = 1
						Save.TextTransparency = 1
						Save.Text = ""
					else
						Save.BackgroundTransparency = 0
						Save.TextTransparency = 0
						Save.Text = "turn on ur shiftlock and press e"
					end
				end
				plr.CameraMinZoomDistance = game.Workspace.Positions:FindFirstChild(tostring(number - 1)).zoom.Value
				plr.CameraMaxZoomDistance = game.Workspace.Positions:FindFirstChild(tostring(number - 1)).zoom.Value
				wait(0.1)
				camera.CFrame = game.Workspace.Positions:FindFirstChild(tostring(number - 1)).camera.Value
				hrp.CFrame = game.Workspace.Positions:FindFirstChild(tostring(number - 1)).CFrame
				plr.CameraMinZoomDistance = cameramin
				plr.CameraMaxZoomDistance = cameramax
				wait(0.1)
			end
		end
	end
end)

local function respawn()
	if number ~= 1 then
		repeat wait() game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name):WaitForChild("Humanoid") until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).Humanoid.Health ~= 0
		game.Workspace:WaitForChild(game.Players.LocalPlayer.Name)
		game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name):WaitForChild("HumanoidRootPart")
		hrp = game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).HumanoidRootPart
		hum = game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).Humanoid
		camera = workspace.CurrentCamera
		camera.CFrame = game.Workspace.Positions:FindFirstChild(tostring(number - 1)).camera.Value
		hrp.CFrame = game.Workspace.Positions:FindFirstChild(tostring(number - 1)).CFrame
		if game.Workspace.Positions:FindFirstChild(tostring(number - 1)).shiftlock.Value == true then
			if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
				Save.BackgroundTransparency = 1
				Save.TextTransparency = 1
				Save.Text = ""
			else
				Save.BackgroundTransparency = 0
				Save.TextTransparency = 0
				Save.Text = "turn on ur shiftlock and reset bro"
			end
		else
			print("shiftlock off")
		end
		plr.CameraMinZoomDistance = game.Workspace.Positions:FindFirstChild(tostring(number - 1)).zoom.Value
		plr.CameraMaxZoomDistance = game.Workspace.Positions:FindFirstChild(tostring(number - 1)).zoom.Value
		wait(0.1)
		camera.CFrame = game.Workspace.Positions:FindFirstChild(tostring(number - 1)).camera.Value
		hrp.CFrame = game.Workspace.Positions:FindFirstChild(tostring(number - 1)).CFrame
		plr.CameraMinZoomDistance = cameramin
		plr.CameraMaxZoomDistance = cameramax
		wait(0.1)
	end
end

hum.Died:Connect(function()
	respawn()
end)

plr.CharacterAdded:Connect(function(char)
	char:WaitForChild("Humanoid")
	local hum = char.Humanoid
	hum.Died:Connect(function()
		respawn()
	end)
end)

print("inviscut script successfully loaded!")
print(scriptversion)
