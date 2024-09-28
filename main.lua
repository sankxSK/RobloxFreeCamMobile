local coregui=game:GetService("Players").LocalPlayer.PlayerGui;
local ts=game:GetService("TweenService");
local uis=game:GetService("UserInputService");
local cam=game.Workspace.CurrentCamera;
local runs=game:GetService("RunService")
local tog=false;
local theme="Default"; -- Default, Retro
local THEMES={
	Default={
		ButtonImg="rbxassetid://79079069837091";
		TextFont=Enum.Font.GothamMedium;
		TextColor=Color3.new(1,1,1);
		BackColor=Color3.new(1,1,1);
		BorderColor=Color3.new(1,1,1);
		BorderPixel=1;
		ButtonBackTransparency=1;
		ButtonImgTransparency=0.5;
		ImgTransparency=0.25;
		BackTransparency=1;
	},
	Retro={
		ButtonImg="rbxassetid://79079069837091";
		TextFont=Enum.Font.Arial;
		TextColor=Color3.new(1,1,1);
		BackColor=Color3.new(0,0,0);
		BorderColor=Color3.new(1,0,0);
		BorderPixel=1;
		ButtonBackTransparency=0.5;
		ButtonImgTransparency=1;
		ImgTransparency=1;
		BackTransparency=0;
	},
}
local touch=game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TouchGui")
function rname(lenght)
	local i="";
	local c={",",".","-","§","?",":","_","!",")","/","(","=","´","%","ˇ",`"`};
	if not lenght then
		for _=1,10,1 do
			local r=math.random(1,#c);
			i=i..c[r]; end
	else
		for _=1,lenght,1 do
			local r=math.random(1,#c);
			i=i..c[r]; end end 
	return i;
end
local ui = Instance.new("ScreenGui",coregui);
local en = Instance.new("ImageButton",ui);
local la = Instance.new("TextLabel",en);
local tcont = Instance.new("ImageButton",ui);
local thumb = Instance.new("ImageLabel",tcont);
local rot = Instance.new("ImageLabel",ui);
local moving = false
local mx,my = 0,0
ui.Name=rname()
ui.ResetOnSpawn=false
ui.IgnoreGuiInset=true
local ss={x=ui.AbsoluteSize.X,y=ui.AbsoluteSize.Y};
local bs = ss.y/100*25
en.Name=rname()
en.AutoButtonColor=false
en.ScaleType=Enum.ScaleType.Slice
en.AnchorPoint=Vector2.new(0.5,0.88)
en.Position=UDim2.fromScale(0.5,0.88)
en.Size=UDim2.fromScale(0.3,0.1)
en.SliceCenter=Rect.new(768,512,768,512)
en.Image="rbxassetid://79079069837091"
en.BackgroundTransparency=1
en.ImageTransparency=0.25
la.Name=rname()
la.BackgroundTransparency=1
la.TextColor3=Color3.fromRGB(255,255,255)
la.TextScaled=true
la.Text="Freecam"
la.Size=UDim2.fromScale(1,1)
la.Font=Enum.Font.GothamMedium
tcont.Name=rname()
tcont.AutoButtonColor=false
tcont.Image="rbxassetid://79079069837091"
tcont.Size=UDim2.fromOffset(bs,bs)
tcont.AnchorPoint=Vector2.new(0.1,0.85)
tcont.Position=UDim2.fromScale(0.1,0.85)
tcont.ImageTransparency = 0.5
tcont.BackgroundTransparency=1
thumb.Name=rname()
thumb.Image="rbxassetid://79079069837091"
thumb.Size=UDim2.fromScale(0.5,0.5)
thumb.AnchorPoint=Vector2.new(0.5,0.5)
thumb.Position=UDim2.fromScale(0.5,0.5)
thumb.BackgroundTransparency=1
rot.Name=rname()
rot.Image="rbxassetid://79079069837091"
rot.Size=UDim2.fromOffset(bs,bs)
rot.AnchorPoint=Vector2.new(0.9,0.85)
rot.Position=UDim2.fromScale(0.9,0.85)
rot.BackgroundTransparency=1
rot.ImageTransparency=0.5

local Dragging = nil
function DragStick(parent,stick)
	local DragInput = nil local DragStart = nil local StartPosition = nil local function Update(input)local Delta=input.Position-DragStart local posxs=StartPosition.X.Scale local posxo=StartPosition.X.Offset+Delta.X local posys=StartPosition.Y.Scale local posyo=StartPosition.Y.Offset+Delta.Y if posxo>=stick.AbsoluteSize.X then posxo=stick.AbsoluteSize.X end if posxo<=(stick.AbsoluteSize.X-(stick.AbsoluteSize.X*2)) then posxo=-stick.AbsoluteSize.X end if posyo>=stick.AbsoluteSize.Y then posyo=stick.AbsoluteSize.Y end if posyo<=(stick.AbsoluteSize.Y-(stick.AbsoluteSize.Y*2)) then posyo=-stick.AbsoluteSize.Y end local pos=UDim2.new(posxs,posxo,posys,posyo)stick.Position=pos end
	parent.InputBegan:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then Dragging=true moving=true DragStart=input.Position StartPosition=stick.Position input.Changed:Connect(function()if input.UserInputState==Enum.UserInputState.End then Dragging=false moving=false end end)end end)
	parent.InputChanged:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then DragInput=input end end)
	uis.InputChanged:Connect(function(input) if input==DragInput and Dragging then Update(input) end end)
end

function changecurpos(xo,xy)
	mx = (xo/tcont.AbsoluteSize.X) * 2
	my = (xy/tcont.AbsoluteSize.Y) * 2  
end

thumb:GetPropertyChangedSignal("Position"):Connect(function()
	changecurpos(thumb.Position.X.Offset,thumb.Position.Y.Offset)
end)

local pi    = math.pi
local abs   = math.abs
local clamp = math.clamp
local exp   = math.exp
local rad   = math.rad
local sign  = math.sign
local sqrt  = math.sqrt
local tan   = math.tan

local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Settings = UserSettings()
local GameSettings = Settings.GameSettings

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
	Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
	LocalPlayer = Players.LocalPlayer
end

local Camera = Workspace.CurrentCamera
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	local newCamera = Workspace.CurrentCamera
	if newCamera then
		Camera = newCamera
	end
end)

local FFlagUserExitFreecamBreaksWithShiftlock
do
	local success, result = pcall(function()
		return UserSettings():IsUserFeatureEnabled("UserExitFreecamBreaksWithShiftlock")
	end)
	FFlagUserExitFreecamBreaksWithShiftlock = success and result
end

local FFlagUserShowGuiHideToggles
do
	local success, result = pcall(function()
		return UserSettings():IsUserFeatureEnabled("UserShowGuiHideToggles")
	end)
	FFlagUserShowGuiHideToggles = success and result
end

------------------------------------------------------------------------

local FREECAM_ENABLED_ATTRIBUTE_NAME = "FreecamEnabled"
local TOGGLE_INPUT_PRIORITY = Enum.ContextActionPriority.Low.Value
local INPUT_PRIORITY = Enum.ContextActionPriority.High.Value

local NAV_GAIN = Vector3.new(1, 1, 1)*64
local PAN_GAIN = Vector2.new(0.75, 1)*8
local FOV_GAIN = 300

local PITCH_LIMIT = rad(90)

local VEL_STIFFNESS = 1.5
local PAN_STIFFNESS = 1.0
local FOV_STIFFNESS = 4.0

------------------------------------------------------------------------

local Spring = {} do
	Spring.__index = Spring

	function Spring.new(freq, pos)
		local self = setmetatable({}, Spring)
		self.f = freq
		self.p = pos
		self.v = pos*0
		return self
	end

	function Spring:Update(dt, goal)
		local f = self.f*2*pi
		local p0 = self.p
		local v0 = self.v

		local offset = goal - p0
		local decay = exp(-f*dt)

		local p1 = goal + (v0*dt - offset*(f*dt + 1))*decay
		local v1 = (f*dt*(offset*f - v0) + v0)*decay

		self.p = p1
		self.v = v1

		return p1
	end

	function Spring:Reset(pos)
		self.p = pos
		self.v = pos*0
	end
end
local cameraPos = Vector3.new()
local cameraRot = Vector2.new()
local cameraFov = 0

local velSpring = Spring.new(VEL_STIFFNESS, Vector3.new())
local panSpring = Spring.new(PAN_STIFFNESS, Vector2.new())
local fovSpring = Spring.new(FOV_STIFFNESS, 0)
local Input = {} do
	local thumbstickCurve do
		local K_CURVATURE = 2.0
		local K_DEADZONE = 0.15

		local function fCurve(x)
			return (exp(K_CURVATURE*x) - 1)/(exp(K_CURVATURE) - 1)
		end

		local function fDeadzone(x)
			return fCurve((x - K_DEADZONE)/(1 - K_DEADZONE))
		end

		function thumbstickCurve(x)
			return sign(x)*clamp(fDeadzone(abs(x)), 0, 1)
		end
	end

	local gamepad = {
		ButtonX = 0,
		ButtonY = 0,
		DPadDown = 0,
		DPadUp = 0,
		ButtonL2 = 0,
		ButtonR2 = 0,
		Thumbstick1 = Vector2.new(),
		Thumbstick2 = Vector2.new(),
	}

	local keyboard = {
		W = 0,
		A = 0,
		S = 0,
		D = 0,
		E = 0,
		Q = 0,
		U = 0,
		H = 0,
		J = 0,
		K = 0,
		I = 0,
		Y = 0,
		Up = 0,
		Down = 0,
		LeftShift = 0,
		RightShift = 0,
	}

	local mouse = {
		Delta = Vector2.new(),
		MouseWheel = 0,
	}

	local NAV_GAMEPAD_SPEED  = Vector3.new(1, 1, 1)
	local NAV_KEYBOARD_SPEED = Vector3.new(1, 1, 1)
	local PAN_MOUSE_SPEED    = Vector2.new(1, 1)*(pi/64)
	local PAN_GAMEPAD_SPEED  = Vector2.new(1, 1)*(pi/8)
	local FOV_WHEEL_SPEED    = 1.0
	local FOV_GAMEPAD_SPEED  = 0.25
	local NAV_ADJ_SPEED      = 0.75
	local NAV_SHIFT_MUL      = 0.25

	local navSpeed = 1

	function Input.Vel(dt)
		navSpeed = clamp(navSpeed + dt*(keyboard.Up - keyboard.Down)*NAV_ADJ_SPEED, 0.01, 4)

		local kGamepad = Vector3.new(
			thumbstickCurve(mx),
			thumbstickCurve(0) - thumbstickCurve(0),
			thumbstickCurve(my)
		)*NAV_GAMEPAD_SPEED

		local kKeyboard = Vector3.new(
			keyboard.D - keyboard.A + keyboard.K - keyboard.H,
			keyboard.E - keyboard.Q + keyboard.I - keyboard.Y,
			keyboard.S - keyboard.W + keyboard.J - keyboard.U
		)*NAV_KEYBOARD_SPEED

		local shift = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)

		return (kGamepad + kKeyboard)*(navSpeed*(shift and NAV_SHIFT_MUL or 1))
	end

	function Input.Pan(dt)
		local kGamepad = Vector2.new(
			thumbstickCurve(gamepad.Thumbstick2.Y),
			thumbstickCurve(-gamepad.Thumbstick2.X)
		)*PAN_GAMEPAD_SPEED
		local kMouse = mouse.Delta*PAN_MOUSE_SPEED
		mouse.Delta = Vector2.new()
		return kGamepad + kMouse
	end

	function Input.Fov(dt)
		local kGamepad = (gamepad.ButtonX - gamepad.ButtonY)*FOV_GAMEPAD_SPEED
		local kMouse = mouse.MouseWheel*FOV_WHEEL_SPEED
		mouse.MouseWheel = 0
		return kGamepad + kMouse
	end

	do

		local function Thumb(action, state, input)
			gamepad[input.KeyCode.Name] = input.Position
			return Enum.ContextActionResult.Sink
		end


		local function Zero(t)
			for k, v in pairs(t) do
				t[k] = v*0
			end
		end

		function Input.StartCapture()
			
			
		end

		function Input.StopCapture()
			navSpeed = 1
			Zero(gamepad)
			Zero(keyboard)
			Zero(mouse)
		end
	end
end
local function StepFreecam(dt)
	if not moving then return end
	
	local vel = velSpring:Update(dt, Input.Vel(dt))
	local pan = panSpring:Update(dt, Input.Pan(dt))
	local fov = fovSpring:Update(dt, Input.Fov(dt))

	local zoomFactor = sqrt(tan(rad(70/2))/tan(rad(cameraFov/2)))

	cameraFov = clamp(cameraFov + fov*FOV_GAIN*(dt/zoomFactor), 1, 120)
	cameraRot = cameraRot + pan*PAN_GAIN*(dt/zoomFactor)
	cameraRot = Vector2.new(clamp(cameraRot.x, -PITCH_LIMIT, PITCH_LIMIT), cameraRot.y%(2*pi))

	--*CFrame.fromOrientation(cameraRot.x, cameraRot.y, 0)

	local cameraCFrame = CFrame.new(cameraPos)*Camera.CFrame.Rotation*CFrame.new(vel*NAV_GAIN*dt)
	cameraPos = cameraCFrame.p

	Camera.CFrame = cameraCFrame
	Camera.Focus = cameraCFrame 
	Camera.FieldOfView = cameraFov
end

local function CheckMouseLockAvailability()
	local devAllowsMouseLock = Players.LocalPlayer.DevEnableMouseLock
	local devMovementModeIsScriptable = Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable
	local userHasMouseLockModeEnabled = GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch
	local userHasClickToMoveEnabled =  GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove
	local MouseLockAvailable = devAllowsMouseLock and userHasMouseLockModeEnabled and not userHasClickToMoveEnabled and not devMovementModeIsScriptable

	return MouseLockAvailable
end
local PlayerState = {} do
	local mouseBehavior
	local cameraType
	local cameraFocus
	local cameraCFrame
	local cameraFieldOfView
	local screenGuis = {}
	local coreGuis = {
		Backpack = true,
		Chat = true,
		Health = true,
		PlayerList = true,
	}
	local setCores = {
		BadgesNotificationsActive = true,
		PointsNotificationsActive = true,
	}

	-- Save state and set up for freecam
	function PlayerState.Push()
		cameraFieldOfView = Camera.FieldOfView
		Camera.FieldOfView = 70

		cameraType = Camera.CameraType
		Camera.CameraType = Enum.CameraType.Custom

		cameraCFrame = Camera.CFrame
		cameraFocus = Camera.Focus

		if FFlagUserExitFreecamBreaksWithShiftlock and CheckMouseLockAvailability() then
			mouseBehavior = Enum.MouseBehavior.Default
		else
			mouseBehavior = UserInputService.MouseBehavior
		end
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	end
	function PlayerState.Pop()
		Camera.FieldOfView = cameraFieldOfView
		cameraFieldOfView = nil

		Camera.CameraType = cameraType
		cameraType = nil

		Camera.CFrame = cameraCFrame
		cameraCFrame = nil

		Camera.Focus = cameraFocus
		cameraFocus = nil

		UserInputService.MouseBehavior = mouseBehavior
		mouseBehavior = nil
	end
end
local function StartFreecam()
	if FFlagUserShowGuiHideToggles then
		script:SetAttribute(FREECAM_ENABLED_ATTRIBUTE_NAME, true)
	end

	local cameraCFrame = Camera.CFrame
	cameraRot = Vector2.new(cameraCFrame:toEulerAnglesYXZ())
	cameraPos = cameraCFrame.p
	cameraFov = Camera.FieldOfView

	velSpring:Reset(Vector3.new())
	panSpring:Reset(Vector2.new())
	fovSpring:Reset(0)

	PlayerState.Push()
	RunService:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, StepFreecam)
	Input.StartCapture()
end

local function StopFreecam()
	if FFlagUserShowGuiHideToggles then
		script:SetAttribute(FREECAM_ENABLED_ATTRIBUTE_NAME, false)
	end

	Input.StopCapture()
	RunService:UnbindFromRenderStep("Freecam")
	PlayerState.Pop()
end
local camera = workspace.CurrentCamera
local dragging = false
local lastPosition = nil
local xrotationSpeed = 0.05
local yrotationSpeed = 0.2
local function onInputBegan(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		lastPosition = input.Position
	end
end
local function onInputEnded(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
		lastPosition = nil
	end
end
local function onInputChanged(input)
	if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local delta = input.Position - lastPosition
		lastPosition = input.Position
		local xRotation = delta.Y * xrotationSpeed
		local yRotation = delta.X * yrotationSpeed
		local cameraCFrame = camera.CFrame
		camera.CFrame = cameraCFrame * CFrame.Angles(math.rad(-xRotation), math.rad(-yRotation), 0)
	end
end
rot.InputBegan:Connect(onInputBegan)
rot.InputEnded:Connect(onInputEnded)
rot.InputChanged:Connect(onInputChanged)
en.MouseButton1Click:Connect(function()
	tog = not tog
	if tog then
		StartFreecam()
		touch.Enabled = false
	else
		StopFreecam()
		touch.Enabled = true
	end
end)
DragStick(tcont,thumb)
local wasdisabled = true
local oldtype = cam.CameraType.Name
runs.RenderStepped:Connect(function(delta)
	if tog then
		if wasdisabled then
			wasdisabled = false
			oldtype = cam.CameraType.Name
		end
		cam.CameraType = Enum.CameraType.Scriptable
		tcont.Visible = true
		rot.Visible = true
		if moving then

		else
			thumb.Position = UDim2.new(0.5,0,0.5,0)
		end
	else
		tcont.Visible = false
		rot.Visible = false
		thumb.Position = UDim2.new(0.5,0,0.5,0)
		if not wasdisabled then
			wasdisabled = true
			cam.CameraType = Enum.CameraType[oldtype]
		end
	end
	local ys = ui.AbsoluteSize.Y
	local ns = ys/100*25
	rot.Size=UDim2.fromOffset(ns,ns)
	tcont.Size=UDim2.fromOffset(ns,ns)
	--Theme Refresher
	en.Image=THEMES[theme]["ButtonImg"]
	en.BackgroundTransparency=THEMES[theme]["ButtonBackTransparency"]
	en.ImageTransparency=THEMES[theme]["ImgTransparency"]
	en.BorderColor3=THEMES[theme]["BorderColor"]
	en.BackgroundColor3=THEMES[theme]["BackColor"]
	la.Font=THEMES[theme]["TextFont"]
	la.TextColor3=THEMES[theme]["TextColor"]
	tcont.BackgroundTransparency=THEMES[theme]["ButtonBackTransparency"]
	tcont.ImageTransparency=THEMES[theme]["ButtonImgTransparency"]
	tcont.Image=THEMES[theme]["ButtonImg"]
	tcont.BorderColor3=THEMES[theme]["BorderColor"]
	tcont.BackgroundColor3=THEMES[theme]["BackColor"]
	tcont.BorderSizePixel=THEMES[theme]["BorderPixel"]
	rot.BackgroundTransparency=THEMES[theme]["ButtonBackTransparency"]
	rot.ImageTransparency=THEMES[theme]["ButtonImgTransparency"]
	rot.Image=THEMES[theme]["ButtonImg"]
	rot.BorderColor3=THEMES[theme]["BorderColor"]
	rot.BackgroundColor3=THEMES[theme]["BackColor"]
	rot.BorderSizePixel=THEMES[theme]["BorderPixel"]
	thumb.BackgroundTransparency=THEMES[theme]["BackTransparency"]
	thumb.ImageTransparency=THEMES[theme]["ImgTransparency"]
	thumb.Image=THEMES[theme]["ButtonImg"]
	thumb.BorderColor3=THEMES[theme]["BorderColor"]
	thumb.BackgroundColor3=THEMES[theme]["BackColor"]
	thumb.BorderSizePixel=THEMES[theme]["BorderPixel"]
end)
