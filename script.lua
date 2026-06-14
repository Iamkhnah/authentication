repeat task.wait()
    until game:IsLoaded() and game:GetService("Players") and game:GetService("Players").LocalPlayer and game.ReplicatedStorage and game.Players.LocalPlayer:FindFirstChild("PlayerGui")
if not game.Players.LocalPlayer.Team then
    repeat
        task.wait(0.1)
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
    until game.Players.LocalPlayer.Team
end
local pos = CFrame.new(-5035.42285, 28.6520386, 4324.50293)
local nameboss = "Vice Admiral"

function ServerHop(a, b, recursive)
    local HttpService = game:GetService("HttpService")
    local LocalPlayer = game.Players.LocalPlayer
    local TeleportService = game:GetService("TeleportService")

    if not recursive and CalledServerHop then
        return
    end

    CalledServerHop = true
    local success, _ = pcall(function()
        local AllServers = HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. game.PlaceId .. '/servers/Public?sortOrder=Asc&limit=100'))
        for _, server in pairs(AllServers["data"]) do
            if server["maxPlayers"] > server["playing"] then
                game:GetService("ReplicatedStorage"):WaitForChild("__ServerBrowser"):InvokeServer("teleport", server.id)
            end
        end
    end)
    if not success then
        ServerHop(a,b,true)
    end
end
function getquest()
    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('StartQuest', "MarineQuest2", 2)
end

function GetBladeHits()
    local t = {}

    function d(v)
        return (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    end

    for _, p in pairs({
        game.Workspace.Enemies,
        game.Workspace.Characters,
    })do
        for _, v in pairs(p:GetChildren())do
            if v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Head') and v:FindFirstChild('Humanoid') then
                if d(v.HumanoidRootPart) < 60 then
                    table.insert(t, v)
                end
            end
        end
    end

    return t
end
function AttackAll()
    local plr = game.Players.LocalPlayer
    local ch = plr.Character

    if not ch then
        return
    end

    local ew = ch:FindFirstChild('EquippedWeapon')

    if not ew then
        return
    end

    local e = GetBladeHits()

    if #e > 0 then
        local n = game:GetService('ReplicatedStorage'):WaitForChild('Modules'):WaitForChild('Net')

        n:WaitForChild('RE/RegisterAttack'):FireServer(-math.huge)

        local a = {nil, {}}

        for i, v in pairs(e)do
            if not a[1] then
                a[1] = v.Head
            end

            a[2][i] = {
                v,
                v.HumanoidRootPart,
            }
        end

        n:WaitForChild('RE/RegisterHit'):FireServer(unpack(a))
    end
end

_tp = function(I)
    local e = game.Players.LocalPlayer.Character

    if not e or not e:FindFirstChild("HumanoidRootPart") then
        return
    end

    local HRP = e.HumanoidRootPart

    shouldTween = true
    getgenv().OnFarm = false

    if HRP.Anchored then
        HRP.Anchored = false

        task.wait()
    end

    local dist = (I.Position - HRP.Position).Magnitude
    local speed = dist <= 15 and (getgenv().TweenSpeedNear or 370) or (getgenv().TweenSpeedFar or 370)
    local info = TweenInfo.new(dist / speed, Enum.EasingStyle.Linear)
    local tween = game:GetService("TweenService"):Create(e:FindFirstChild("HumanoidRootPart"), info, {CFrame = I})

    if e.Humanoid.Sit == true then
        e:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(e:FindFirstChild("HumanoidRootPart").Position.X, I.Y, e:FindFirstChild("HumanoidRootPart").Position.Z)
    end

    tween:Play()
end
EquipWeapon = function(I)
    if not I then
        return
    end
    if game.Players.LocalPlayer.Backpack:FindFirstChild(I) then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild(I))
    end
end
weaponSc = function(I)
    for e, K in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if K:IsA("Tool") then
            if K.ToolTip == I then
                EquipWeapon(K.Name)
            end
        end
    end
end
function getboss()
    local boss = game.ReplicatedStorage:FindFirstChild(nameboss) or Workspace.Enemies:FindFirstChild(nameboss)
    if boss and boss:FindFirstChild("HumanoidRootPart") and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
        return boss
    end
    return
end
spawn(function ()
    while wait() do
        local boss = getboss()
        if boss then
            getquest()
            repeat
                wait()
                if game.Players.LocalPlayer.Character and not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
                end
                -- AttackAll()
                weaponSc("Melee")
                pcall(function ()
                    if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                        local I = Instance.new("BodyVelocity")

                        I.Name = "BodyClip"
                        I.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
                        I.MaxForce = Vector3.new(100000, 100000, 100000)
                        I.Velocity = Vector3.new(0, 0, 0)
                    end
                    _tp(boss.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                end)
            until not boss or not boss:FindFirstChild("HumanoidRootPart") or not boss:FindFirstChild("Humanoid") or boss.Humanoid.Health <= 0 
        else
            ServerHop()
        end
    end
end)

spawn(function ()
    while wait() do
        AttackAll()
    end
end)

queue_on_teleport([==[
loadstring(game:HttpGet("http://127.0.0.1:5000/raw"))()
]==])
