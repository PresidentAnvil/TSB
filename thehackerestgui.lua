getgenv().scripttitle = "the hackerest gui"
getgenv().FolderName = "the hackerest gui"
workspace.FallenPartsDestroyHeight = 0/0
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Awakenchan/jan/main/JanModifiedSource'))()
local fl = loadstring(game:HttpGet("https://raw.githubusercontent.com/Coolmandfgfgdvcgfg/criminology/main/fly_fork"))()
local p = game:GetService("Players").LocalPlayer
local LegitTab = library:AddTab("main")
local LegitColunm1 = LegitTab:AddColumn()
local LegitColunm2 = LegitTab:AddColumn() 

local char = LegitColunm1:AddSection("player")
local hacks = LegitColunm2:AddSection("hacks")
local ws = 1
char:AddToggle{
    text = "WalkSpeed", 
    callback = function(a)
        if not a then
            if walkspeedthing then
                walkspeedthing:Disconnect()
            end
            return
        end
        walkspeedthing = game:GetService"RunService".PostSimulation:Connect(function()
            p.Character.Humanoid.WalkSpeed = ws
        end)
    end
}
char:AddSlider{
    text = "Speed", 
    min = 16, 
    max = 500, 
    value = 1, 
    suffix = " walkspeed",
    tip = "nyoom",
    callback = function(a)
        ws = a
    end
}

char:AddToggle{
    text = "Fly", 
    callback = function(a)
        if not a then
            fl.NOFLY()
        else
            fl.sFLY(false)
        end
    end
}
hacks:AddToggle{
    text = "Insta-kill",
    tip="only works with gauro's 1 and 2", 
    callback = function(a)
        if not a then
            pcall(function()
                coroutine.close(getgenv().theme)
            end)
            pcall(function()
                getgenv().theme=nil
            end)
            return
        end
        local animations = {
            ["rbxassetid://12273188754"]=1.31,
            ["rbxassetid://12296113986"]=1.2,
        }
        function ifind(t,a)
            for i,v in pairs(t) do
                if i==a then
                    return i
                end
            end
            return false
        end
        local plr = game.Players.LocalPlayer
        getgenv().theme = coroutine.create(function()
            local dothetech = false
            local lastcf
            while task.wait() do 
                local character = plr.Character
                local animate = character.Humanoid.Animator
        
                for i,v in pairs(animate:GetPlayingAnimationTracks()) do
                    if ifind(animations, v.Animation.AnimationId) then
                        wait(animations[v.Animation.AnimationId])
                        dothetech=true
                        lastcf = character.HumanoidRootPart.CFrame
                        v.Stopped:Connect(function()
                            dothetech=false
                        end)
                        repeat wait()
                            workspace.Camera.CameraType = Enum.CameraType.Scriptable
                            character.HumanoidRootPart.CFrame = CFrame.new(9e9,-9e9,9e9)
                            character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                            character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                        until not dothetech
                        wait(0.1)
                        character.HumanoidRootPart.CFrame=lastcf
                        workspace.Camera.CameraType = Enum.CameraType.Custom
                        workspace.Camera.CameraSubject = character.Humanoid
                        wait(1)
                    end
                end
            end
        end)
        coroutine.resume(getgenv().theme)
    end
}
local function align(x,b)
	local att0 = Instance.new("Attachment", x)
	att0.Position = Vector3.new(0,0,0)
	local att1 = Instance.new("Attachment", b)
	att1.Position = Vector3.new(0,0,0)
	att1.Orientation = Vector3.new(0,0,0)
	local AP = Instance.new("AlignPosition", x)
	AP.Attachment0 = att0
	AP.Attachment1 = att1
	AP.RigidityEnabled = false
	AP.ReactionForceEnabled = false
	AP.ApplyAtCenterOfMass = true
	AP.MaxForce = 9999999
	AP.MaxVelocity = math.huge
	AP.Responsiveness = 200
	local AO = Instance.new("AlignOrientation", x)
	AO.Attachment0 = att0
	AO.Attachment1 = att1
	AO.ReactionTorqueEnabled = false
	AO.PrimaryAxisOnly = false
	AO.MaxTorque = 9999999
	AO.MaxAngularVelocity = math.huge
	AO.Responsiveness = 200
end
local p = ""
wantedspeed = 2
rotaten = 1
radius = 5
players = game:GetService("Players")
local strafetog;strafetog=hacks:AddToggle{
	text = "Strafe", 
	callback = function(a)
		rotaten=1
		if not a then
			if strafeloop then coroutine.close(strafeloop) strafeloop=nil orbittingpart:Destroy()orbittingpart=nil end
			return
		end
		p=p:lower()
		local actualp
		for i,v in ipairs(players:GetPlayers()) do
			local name = string.lower(string.sub(v.Name,0,#p))
			if name==p then
				actualp=v
				break
			end
		end

		if typeof(actualp)=="string" then 
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "error";
				Text = "player not found";
				Duration = 5;
			})
			strafetog:SetState(false) 
			return 
		end
		if actualp.Character then
			if not actualp.Character:FindFirstChild("HumanoidRootPart") then
				game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "error";
                    Text = "target has no humanoidrootpart ("..actualp.Name..")";
                    Duration = 5;
                })
				strafetog:SetState(false)
				return
			end	
			
			orbittingpart = Instance.new("Part",workspace)
			orbittingpart.Anchored = true
			orbittingpart.CanCollide = false
			orbittingpart.CFrame = actualp.Character.HumanoidRootPart.CFrame
            orbittingpart.Transparency = 0
			align(players.LocalPlayer.Character.HumanoidRootPart,orbittingpart)
			strafeloop=coroutine.create(function()
				local s,e = pcall(function()
					while strafetog.state and task.wait() do
						rotaten+=(0.01*(wantedspeed))
						local angle = rotaten * (2*math.pi)
						local pos = Vector3.new(math.sin(angle)*radius,0,math.cos(angle)*radius)
						local poss = (actualp.Character.HumanoidRootPart.Position+pos)
						orbittingpart.Position = poss
						orbittingpart.CFrame = CFrame.lookAt(poss, actualp.Character.HumanoidRootPart.Position)
					end
				end)
				if not s then strafetog:SetState(false)print(e) end
			end)
			coroutine.resume(strafeloop)
		else
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "error";
				Text = "target isn't spawned in ("..actualp.Name..")";
				Duration = 5;
			})
		end
		
		
	end,
	tip = "orbit around the target, pairs well with melee killaura"
}
hacks:AddBox{
	text = "Target", 
	callback = function(a)
		p=a
	end,
	tip = "target of strafe, doesn't have to be full username"
}

hacks:AddSlider{
	text = "Strafe Speed", 
	min = 0.25, 
	max = 5, 
	value = 2,
	float = 0.1, 
	suffix = "",
	callback = function(a)
		wantedspeed=a
	end
}
hacks:AddSlider{
	text = "Strafe Radius", 
	min = 3, 
	max = 10, 
	value = 5,
	float = 0.1, 
	tip = 'i would recommend keeping this at 5',
	suffix = "",
	callback = function(a)
		radius=a
	end
}

-- EVERYTHING DOWN HERE YOU NEED U CANNOT DELETE IDK WHY

local SettingsTab = library:AddTab("Settings")
local SettingsColumn = SettingsTab:AddColumn()
local SettingSection = SettingsColumn:AddSection("Settings")
local Warning = library:AddWarning({type = "confirm"})

SettingSection:AddBind({
	text = "Open / Close", 
	flag = "UI Toggle", 
	nomouse = true, 
	key = Enum.KeyCode.RightShift,
	callback = function()
		library:Close()
	end
})

SettingSection:AddButton({
	text = "Unload UI", 
	callback = function()
		local r, g, b = library.round(library.flags["Menu Accent Color"])
		Warning.text = "<font color='rgb(" .. r .. "," .. g .. "," .. b .. ")'>" .. 'Are you sure you want to unload the UI?' .. "</font>"
		if Warning:Show() then
			library:Unload()
			getgenv().Sense.Unload()
		end
	end
})

SettingSection:AddColor({
	text = "Accent Color", 
	flag = "Menu Accent Color", 
	color = getgenv().CurrentColor, 
	callback = function(color)
		getgenv().CurrentColor = color
		if library.currentTab then
			library.currentTab.button.TextColor3 = color
		end
		for i,v in pairs(library.theme) do
			v[(v.ClassName == "TextLabel" and "TextColor3") or (v.ClassName == "ImageLabel" and "ImageColor3") or "BackgroundColor3"] = color
		end
	end
})
library:Init()
library:selectTab(library.tabs[1]) 
