ws = game:GetService("Workspace")
G = ((getgenv and getgenv()) or _G)
if not G.fpdh then
    G.fpdh = ws.FallenPartsDestroyHeight
end
fpdh = G.fpdh or ws.FallenPartsDestroyHeight
runservice = game:GetService("RunService")
players = game:GetService("Players")
p = players.LocalPlayer
ws.FallenPartsDestroyHeight = 0/0
function fullbreakvel(instance)
    local instance = instance or p.Character
    local part = instance and (instance:IsA("BasePart") and instance or instance:IsA("Model") and (instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart")) or instance:FindFirstChildWhichIsA("BasePart"))
    if not part then
        return
    end
    part.AssemblyAngularVelocity = Vector3.new()
    part.AssemblyLinearVelocity = Vector3.new()
    for i, v in part:GetConnectedParts(true) do
        v.AssemblyAngularVelocity = Vector3.new()
        v.AssemblyLinearVelocity = Vector3.new()
    end
end
local c = p.Character
c.DescendantRemoving:Connect(function(v)
    if v:IsA("BasePart") then
        print(v.Name)
    end
end)
if c then
    local hum = c:FindFirstChildWhichIsA("Humanoid")
    local hrp = c:FindFirstChild("HumanoidRootPart")
    local head = c:FindFirstChild("Head")
    if hum and hrp and head then
        local r6 = hum.RigType == Enum.HumanoidRigType.R6
        if r6 then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://35154961"
            local loadanim = hum:LoadAnimation(anim)
            loadanim:Play(0, 100, 0)
            loadanim.TimePosition = 3.24
        end
        hum:ChangeState(Enum.HumanoidStateType.Physics)
        local old = hrp.CFrame
        fullbreakvel(hrp)
        local cf = r6 and CFrame.new(hrp.CFrame.Position.X, fpdh + 1, hrp.CFrame.Position.Z) * CFrame.Angles(math.rad(90), 0, 0) or CFrame.new(hrp.CFrame.Position.X, fpdh + 1, hrp.CFrame.Position.Z)
        hrp.CFrame = cf
        local con
        con = runservice.PostSimulation:Connect(function()
            fullbreakvel(hrp)
            hrp.CFrame = cf
        end)
        coroutine.wrap(function()
            for i, v in hum:GetAccessories() do
                local han = v:FindFirstChild("Handle")
                local weld = han and han:FindFirstChildWhichIsA("Weld")
                if weld then
                    sethiddenproperty(v, "BackendAccoutrementState", 0)
                    weld:GetPropertyChangedSignal("Parent"):Wait()
                    han.Velocity = Vector3.new(0, 30, 0)
                    han.CFrame = old
                    local con
                    con = runservice.PostSimulation:Connect(function()
                        han.Velocity = Vector3.new(0, 30, 0)
                        han.CFrame = old
                    end)
                end
            end
        end)()
        task.wait(0.4)
        con:Disconnect()
        con = nil
        hum.Health = 0
    end
end
