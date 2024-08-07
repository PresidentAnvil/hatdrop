local genv = (getgenv and getgenv()) or _G
if not genv.fpdh then
    genv.fpdh = workspace.FallenPartsDestroyHeight
end

local fpdh = genv.fpdh or workspace.FallenPartsDestroyHeight
local rs = game:GetService("RunService")
local lp = game:GetService("Players").LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")
local head = char:WaitForChild("Head")
local bigHat = char:FindFirstChild("Accessory (kitty)")
if not (hum and hrp and head and bigHat) then return end

local oldPos = hrp.CFrame
local isR6 = hum.RigType == Enum.HumanoidRigType.R6
local newPos = CFrame.new(hrp.CFrame.Position.X, fpdh + 1, hrp.CFrame.Position.Z) 
if isR6 then newPos *= CFrame.Angles(math.rad(90), 0, 0) end

local function removeVelocity(instance)
    local instance = instance or lp.Character
    local part = instance:IsA("BasePart") and instance or instance:IsA("Model") and (instance.PrimaryPart or instance:FindFirstChildOfClass("BasePart"))
    if not part then return end

    part.AssemblyAngularVelocity = Vector3.new()
    part.AssemblyLinearVelocity = Vector3.new()

    for i, v in part:GetConnectedParts(true) do
        v.AssemblyAngularVelocity = Vector3.new()
        v.AssemblyLinearVelocity = Vector3.new()
    end
end

local function createFlinger(hat)
    local handle = hat:FindFirstChild("Handle")
    local weld = handle and handle:FindFirstChildOfClass("Weld")
    if not weld then return end

    sethiddenproperty(hat, "BackendAccoutrementState", 0)

    local box = Instance.new("SelectionBox")
    box.Adornee = handle
    box.Parent = handle

    handle:BreakJoints()
    handle.AssemblyLinearVelocity = Vector3.new(0, 30, 0)
    handle.CFrame = CFrame.new(oldPos.Position) * CFrame.new(0, 0, 0)
        
    local alignCon
    alignCon = rs.PostSimulation:Connect(function()
        handle.AssemblyLinearVelocity = Vector3.new(0, 30, 0)
        handle.AssemblyAngularVelocity = Vector3.new(9e9,0,9e9)
        handle.Position = oldPos.Position + Vector3.new(0,handle.Size.Y/2 - 5,0)
    end)
end

char.DescendantRemoving:Connect(function(v)
    if not v:IsA("BasePart") then return end
    if v.Name == "Handle" then 
        return warn(`accessory lost ({v.Parent.Name})`)
    end
    print(v.Name)
end)

if isR6 then
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://35154961"
    local loadanim = hum:LoadAnimation(anim)
    loadanim:Play(0, 100, 0)
    loadanim.TimePosition = 3.24
end

workspace.FallenPartsDestroyHeight = 0/0
removeVelocity(hrp)
hrp.CFrame = newPos

local velocityCon
velocityCon = rs.PostSimulation:Connect(function()
    removeVelocity(hrp)
    hrp.CFrame = newPos
end)

task.spawn(createFlinger,bigHat)
task.wait(0.33)
velocityCon:Disconnect()
velocityCon = nil
hum.Health = 0
local newChar = lp.CharacterAdded:Wait()
local newHrp = newChar:WaitForChild("HumanoidRootPart")
newHrp.CFrame = oldPos
