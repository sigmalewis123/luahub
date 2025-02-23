local a = game.Players.LocalPlayer
local b = a:GetMouse()
local d = game:GetService("Players")
local e = d.LocalPlayer
local f = false
local hasFlung = {}

-- Function to handle the fling of each player
local function flingPlayer(l)
    local i = e.Character
    local j = i and i:FindFirstChildOfClass("Humanoid")
    local k = j and j.RootPart
    local m
    local n
    local o
    local p
    local q

    if l:FindFirstChildOfClass("Humanoid") then
        m = l:FindFirstChildOfClass("Humanoid")
    end
    if m and m.RootPart then
        n = m.RootPart
    end
    if l:FindFirstChild("Head") then
        o = l.Head
    end
    if l:FindFirstChildOfClass("Accessory") then
        p = l:FindFirstChildOfClass("Accessory")
    end
    if p and p:FindFirstChild("Handle") then
        q = p.Handle
    end

    if i and j and k then
        if k.Velocity.Magnitude < 50 then
            getgenv().OldPos = k.CFrame
        end
    end
    if m and m.Sit and not f then
    end

    -- Ensure the player is not already flung
    if o then
        if o.Velocity.Magnitude > 500 then
            if not hasFlung[l] then
                hasFlung[l] = true
                -- Print that player is already flung and ask if we should fling again
                print("Player flung: " .. l.Name .. " - Player is already flung. Fling again?")
                -- Simulate the dialog with a "Yes" choice automatically
                -- Replace with logic if you want actual user interaction.
                print("Flinging again...")
            end
        end
    elseif not o and q then
        if q.Velocity.Magnitude > 500 then
            if not hasFlung[l] then
                hasFlung[l] = true
                -- Print that player is already flung and ask if we should fling again
                print("Player flung: " .. l.Name .. " - Player is already flung. Fling again?")
                -- Simulate the dialog with a "Yes" choice automatically
                -- Replace with logic if you want actual user interaction.
                print("Flinging again...")
            end
        end
    end

    -- Set camera to the target player part
    if o then
        workspace.CurrentCamera.CameraSubject = o
    elseif not o and q then
        workspace.CurrentCamera.CameraSubject = q
    elseif m and n then
        workspace.CurrentCamera.CameraSubject = m
    end

    -- Proceed to fling
    if not l:FindFirstChildWhichIsA("BasePart") then return end

    local r = function(s, t, u)
        k.CFrame = CFrame.new(s.Position) * t * u
        i:SetPrimaryPartCFrame(CFrame.new(s.Position) * t * u)
        k.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
        k.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
    end

    local v = function(s)
        local w = 2
        local x = tick()
        local y = 0
        repeat
            if k and m then
                if s.Velocity.Magnitude < 50 then
                    y = y + 100
                    r(s, CFrame.new(0, 1.5, 0) + m.MoveDirection * s.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(y), 0, 0))
                    task.wait()
                    r(s, CFrame.new(0, -1.5, 0) + m.MoveDirection * s.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(y), 0, 0))
                    task.wait()
                    r(s, CFrame.new(2.25, 1.5, -2.25) + m.MoveDirection * s.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(y), 0, 0))
                    task.wait()
                    r(s, CFrame.new(-2.25, -1.5, 2.25) + m.MoveDirection * s.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(y), 0, 0))
                    task.wait()
                    r(s, CFrame.new(0, 1.5, 0) + m.MoveDirection, CFrame.Angles(math.rad(y), 0, 0))
                    task.wait()
                    r(s, CFrame.new(0, -1.5, 0) + m.MoveDirection, CFrame.Angles(0, 0, 0))
                    task.wait()
                else
                    r(s, CFrame.new(0, 1.5, m.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                    task.wait()
                    r(s, CFrame.new(0, -1.5, -m.WalkSpeed), CFrame.Angles(0, 0, 0))
                    task.wait()
                end
            else
                break
            end
        until s.Velocity.Magnitude > 500 or s.Parent ~= h.Character or h.Parent ~= d or h.Character ~= l or m.Sit or j.Health <= 0 or tick() > x + w
    end

    workspace.FallenPartsDestroyHeight = 0 / 0

    local z = Instance.new("BodyVelocity")
    z.Name = "EpixVel"
    z.Parent = k
    z.Velocity = Vector3.new(9e8, 9e8, 9e8)
    z.MaxForce = Vector3.new(1 / 0, 1 / 0, 1 / 0)

    j:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    if n and o then
        if (n.CFrame.p - o.CFrame.p).Magnitude > 5 then
            v(o)
        else
            v(n)
        end
    elseif n and not o then
        v(n)
    elseif not n and o then
        v(o)
    elseif not n and not o and p and q then
        v(q)
    else
        print("Can't find a proper part of target player to fling.")
    end

    z:Destroy()
    j:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    workspace.CurrentCamera.CameraSubject = j

    repeat
        k.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
        i:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
        j:ChangeState("GettingUp")
        table.foreach(i:GetChildren(), function(A, B)
            if B:IsA("BasePart") then
                B.Velocity, B.RotVelocity = Vector3.new(), Vector3.new()
            end
        end)
        task.wait()
    until (k.Position - getgenv().OldPos.p).Magnitude < 25

    workspace.FallenPartsDestroyHeight = getgenv().FPDH
end

-- Iterate through all players and fling those who haven't been flung
for _, player in pairs(d:GetPlayers()) do
    if player ~= e and not hasFlung[player] then
        print("Flinging player: " .. player.Name)
        flingPlayer(player)
    end
end

-- Print when all players are done
print("All players have been flung.")
