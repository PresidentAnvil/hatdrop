-- work in progresshjghjss 
limbs = {
    ["Left Arm"] = "Pretzel Friend Sitting",
    ["Right Arm"] = "UGC Monster",
    ["Right Leg"] = "",
    ["Left Leg"] = "",
    ["Torso"] = "Tommy Text logo",
    ["Head"] = "Samurai Hair",
}


players = game:GetService("Players")
p = players.LocalPlayer
local FakeCharacter
local function Align(Part1,Part0,CFrameOffset) 
    game:GetService("RunService").PostSimulation:Connect(function()
        Part1.CFrame = Part0.CFrame
    end)
end

function hatdrop(c)
    for i, v in pairs(c.Humanoid:GetPlayingAnimationTracks()) do
        v:Stop()
    end
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://35154961"
    local loadanim = c.Humanoid:LoadAnimation(anim)
    loadanim:Play()
    loadanim.TimePosition = 3
    loadanim:AdjustSpeed(0)
    local a = c.HumanoidRootPart.CFrame
    for i, v in c.Humanoid:GetAccessories() do
        sethiddenproperty(v,"BackendAccoutrementState",0)
        task.delay(1.95,function()
            local con = game:GetService"RunService".PostSimulation:Connect(function(dt)
                v.Handle.AssemblyLinearVelocity = Vector3.new(999,999,999)
            end)
            v.Handle.Destroying:Connect(function()
                con:Disconnect()
            end)
        end)
    end
    c.HumanoidRootPart.CFrame *= CFrame.Angles(math.rad(90),0,0)
    c.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    game:GetService("TweenService"):Create(c.HumanoidRootPart,TweenInfo.new(1,Enum.EasingStyle.Linear),{CFrame = CFrame.new(a.X,-500,a.Z)* CFrame.Angles(math.rad(90),0,0)}):Play()
    print(".")
    c.ChildRemoved:Connect(function(v)
        if v:IsA("BasePart") then
            print(v.Name)
        end
    end)
    coroutine.wrap(function()
        while true do
            game:GetService("RunService").PostSimulation:Wait()
            c.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            c.HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        end
    end)()
    task.wait(0.95)
    c.Humanoid.Health = 0
end

function FEScript(c,f)
    local s,e = pcall(function()
        Align(c.Black.Handle,f.Torso,CFrame.new(0,0,0))
        local thrust = Instance.new("BodyThrust",c.Black.Handle)
        thrust.Force = Vector3.new(9e9,9e9,9e9)
    end)
    if not s then print(e) end
    local s,e = pcall(function()
        Align(c.LARM.Handle,f["Left Arm"],CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),0,0))
        local thrust = Instance.new("BodyThrust",c.Black.Handle)
        thrust.Force = Vector3.new(9e9,9e9,9e9)
    end)
    if not s then print(e) end
    local s,e = pcall(function()
        Align(c.RARM.Handle,f["Right Arm"],CFrame.new(0,0,0))
    end)
    if not s then print(e) end
    
end

p.Character.Archivable = true
FakeCharacter = p.Character:Clone()
for i,v in ipairs(FakeCharacter:GetDescendants()) do
    if v:IsA("BasePart") then
        v.Transparency = 1
    end
end
FakeCharacter.Parent = workspace
workspace.Camera.CameraSubject = FakeCharacter.Humanoid
game:GetService("RunService").Heartbeat:connect(function()
	for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
		if v.Name == "Handle" then 
			v.Velocity = Vector3.new(999,999,999)
		end
	end
end)
game:GetService("RunService").PostSimulation:Connect(function()
	for i,v in ipairs(FakeCharacter:GetDescendants()) do
		if v:IsA("BasePart") then 
			v.CanCollide = false
		end
	end
end)
game:GetService("RunService").Heartbeat:Connect(function()
	for i,v in ipairs(FakeCharacter:GetDescendants()) do
		if v:IsA("BasePart") then 
			v.CanCollide = false
		end
	end
end)
hatdrop(p.Character)
task.wait(0.2)
for i,v in pairs(limbs) do
    pcall(function()
        Align(p.Character[v].Handle,FakeCharacter[i],CFrame.new(0,0,0))
    end)
end
FakeCharacter.Parent = workspace
local LVecPart = Instance.new("Part", workspace) 
LVecPart.CanCollide = false 
LVecPart.Transparency = 1
local walk = Instance.new("Animation",FakeCharacter)
walk.AnimationId = "http://www.roblox.com/asset/?id=180426354"
local walka = FakeCharacter.Humanoid:LoadAnimation(walk)
local jump = Instance.new("Animation",FakeCharacter)
jump.AnimationId = "http://www.roblox.com/asset/?id=125750702"
local jumpa = FakeCharacter.Humanoid:LoadAnimation(jump)
local CONVEC
local function VECTORUNIT()
    if HumanDied then CONVEC:Disconnect(); return end
    local lookVec = workspace.Camera.CFrame.lookVector
    local Root = FakeCharacter["HumanoidRootPart"]
    LVecPart.Position = Root.Position
    LVecPart.CFrame = CFrame.new(LVecPart.Position, Vector3.new(lookVec.X * 9999, lookVec.Y, lookVec.Z * 9999))
end
CONVEC = game:GetService("RunService").Heartbeat:Connect(VECTORUNIT)
local CONDOWN
local WDown, ADown, SDown, DDown, SpaceDown = false, false, false, false, false
local function KEYDOWN(_,Processed) 
    if HumanDied then CONDOWN:Disconnect(); return end
    if Processed ~= true then
        local Key = _.KeyCode
        if Key == Enum.KeyCode.W then
            WDown = true end
        if Key == Enum.KeyCode.A then
            ADown = true end
        if Key == Enum.KeyCode.S then
            SDown = true end
        if Key == Enum.KeyCode.D then
            DDown = true end
        if Key == Enum.KeyCode.Space then
            SpaceDown = true 
        end 
    end 
end
CONDOWN = game:GetService("UserInputService").InputBegan:Connect(KEYDOWN)

local CONUP
local function KEYUP(_)
if HumanDied then CONUP:Disconnect(); return end
local Key = _.KeyCode
if Key == Enum.KeyCode.W then
WDown = false end
if Key == Enum.KeyCode.A then
ADown = false end
if Key == Enum.KeyCode.S then
SDown = false end
if Key == Enum.KeyCode.D then
DDown = false end
if Key == Enum.KeyCode.Space then
SpaceDown = false end 
end
CONUP = game:GetService("UserInputService").InputEnded:Connect(KEYUP)

local function MoveClone(X,Y,Z)
    LVecPart.CFrame = LVecPart.CFrame * CFrame.new(-X,Y,-Z)
    FakeCharacter.Humanoid.WalkToPoint = LVecPart.Position
end

coroutine.wrap(function() 
while true do game:GetService("RunService").RenderStepped:Wait()
if HumanDied then break end
if WDown then  MoveClone(0,0,1e4) if walka.IsPlaying ~= true then walka:Play() end end
if ADown then MoveClone(1e4,0,0) if walka.IsPlaying ~= true then walka:Play() end end
if SDown then MoveClone(0,0,-1e4) if walka.IsPlaying ~= true then walka:Play() end end
if DDown then MoveClone(-1e4,0,0) if walka.IsPlaying ~= true then walka:Play() end end
if SpaceDown then FakeCharacter["Humanoid"].Jump = true if jumpa.IsPlaying ~= true then jumpa:Play() end end
if WDown ~= true and ADown ~= true and SDown ~= true and DDown ~= true and SpaceDown ~= true then
    walka:Stop()
    FakeCharacter.Humanoid.WalkToPoint = FakeCharacter.HumanoidRootPart.Position end
    end 
end)()
p.CharacterAdded:Connect(function(char)
    workspace.Camera.CameraSubject = FakeCharacter.Humanoid
    char:WaitForChild("HumanoidRootPart")
    char:WaitForChild("Head")
    workspace.Camera.CameraSubject = FakeCharacter.Humanoid
    wait(0.3)
    hatdrop(char)
    task.wait(0.4)
    workspace.Camera.CameraSubject = FakeCharacter.Humanoid
    for i,v in pairs(limbs) do
        if v == "" then continue end
        coroutine.wrap(function()
            local a = char:WaitForChild(v)
            local s,e = pcall(function()
                Align(a.Handle,FakeCharacter[i],CFrame.new(0,0,0))
            end)
            if not s then print(e) end
        end)()
    end
    
    --Align(char["Meshes/headAccessory"].Handle,FakeCharacter.Torso,CFrame.new(0,0,0))
    --Align(char.MeshPartAccessory.Handle,FakeCharacter["Left Arm"],CFrame.Angles(0,0,math.rad(90)))
    --Align(char["Unloaded head"].Handle,FakeCharacter["Right Arm"],CFrame.Angles(0,0,math.rad(90)))
end)
