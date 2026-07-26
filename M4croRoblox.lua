local _0x1=game:GetService("Players")
local _0x2=game:GetService("RunService")
local _0x3=game:GetService("CoreGui")
local _0x4=game:GetService("TweenService")

local _0x5=_0x1.LocalPlayer
local _0x6=workspace.CurrentCamera
local _0x7=nil
local _0x8=nil

local _0x9=Instance.new("\83\99\114\101\101\110\71\117\105")
local _0x10=Instance.new("\84\101\120\116\66\117\116\116\111\110")
local _0x11=Instance.new("\85\73\67\111\114\110\101\114")
local _0x12=Instance.new("\85\73\83\116\114\111\107\101")

_0x9.Name="\68\101\108\116\97\71\101\116\101\114\77\97\99\114\111"
_0x9.Parent=_0x3
_0x9.ResetOnSpawn=false

_0x10.Name="\71\101\116\101\114\66\117\116\116\111\110"
_0x10.Parent=_0x9
_0x10.Position=UDim2.new(0.75,0,0.30,0)
_0x10.Size=UDim2.new(0,75,0,75)

_0x10.Text="\72\73\73\69\76\76\48\48\49"
_0x10.TextColor3=Color3.fromRGB(255,255,255)
_0x10.Font=Enum.Font.SourceSansBold
_0x10.TextSize=14
_0x10.Active=true
_0x10.Draggable=false

_0x10.BackgroundColor3=Color3.fromRGB(0,0,0)
_0x10.BackgroundTransparency=0.9
_0x10.TextTransparency=0.6

_0x11.CornerRadius=UDim.new(1,0)
_0x11.Parent=_0x10

_0x12.Parent=_0x10
_0x12.Thickness=2
_0x12.Color=Color3.fromRGB(255,255,255)
_0x12.Transparency=0.7
_0x12.ApplyStrokeMode=Enum.ApplyStrokeMode.Border

local function _0x13()
    local _0x14=_0x5.Character
    if _0x14 and _0x14:FindFirstChild("\72\117\109\97\110\111\105\100\82\111\111\116\80\97\114\116") then
        local _0x15=_0x14.HumanoidRootPart
        local _0x16=_0x6.CFrame.LookVector
        
        local _0x17=math.atan2(-_0x16.X,-_0x16.Z)
        
        local _0x18=0.08
        local _0x19=math.random(-1,1)*_0x18
        local _0x1A=math.random(-1,1)*_0x18
        
        local _0x1B=_0x15.Position
        local _0x1C=_0x1B+Vector3.new(_0x19,0,_0x1A)
        
        _0x15.CFrame=CFrame.new(_0x1C)*CFrame.Angles(0,_0x17,0)
    end
end

local function _0x1D(_0x1E,_0x1F,_0x20,_0x21,_0x22,_0x23)
    local _0x24=TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
    
    _0x4:Create(_0x10,_0x24,{
        Size=_0x1E,
        BackgroundColor3=_0x21,
        BackgroundTransparency=_0x22,
        TextTransparency=_0x23
    }):Play()
    
    _0x4:Create(_0x12,_0x24,{
        Color=_0x1F,
        Transparency=_0x20
    }):Play()
end

local _0x25=UDim2.new(0,75,0,75)
local _0x26=UDim2.new(0,68,0,68)

local function _0x27()
    _0x1D(_0x26,Color3.fromRGB(0,255,100),0,Color3.fromRGB(0,0,0),0.2,0)
    
    if not _0x7 then
        _0x7=_0x2.RenderStepped:Connect(_0x13)
    end
end

local function _0x28()
    if _0x8 then
        _0x8:Disconnect()
        _0x8=nil
    end
    
    _0x1D(_0x25,Color3.fromRGB(255,255,255),0.7,Color3.fromRGB(0,0,0),0.9,0.6)
    
    if _0x7 then
        _0x7:Disconnect()
        _0x7=nil
    end
end

_0x10.InputBegan:Connect(function(_0x29)
    if _0x29.UserInputType==Enum.UserInputType.MouseButton1 or _0x29.UserInputType==Enum.UserInputType.Touch then
        _0x27()
        
        _0x8=_0x29.Changed:Connect(function()
            if _0x29.UserInputState==Enum.UserInputState.End then
                _0x28()
            end
        end)
    end
end)
