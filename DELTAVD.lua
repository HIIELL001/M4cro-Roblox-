local VERSION = "1.0"
local HUB_NAME = "HIIELL001 Hub"

-- FITUR NOTIFIKASI LOADING
local StarterGui = game:GetService("StarterGui")
local function showNotification(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3
        })
    end)
end

showNotification(HUB_NAME, "Loading Script... Please wait!", 3)

-- DAFTAR GAME DAN SCRIPT KHUSUS MILIK ANDA
local games = {
    -- [PlaceId] = "Link RAW Script Game Tersebut"
    
    -- Violent District (VD)
    [6739698191] = "https://raw.githubusercontent.com/HIIELL001/M4cro-Roblox-/main/DELTAVD.lua",
}

local universeId = game.GameId
local placeId    = game.PlaceId

-- Cek apakah game yang sedang dimainkan ada di daftar milik Anda
local scriptURL  = games[universeId] or games[placeId]

if scriptURL then
    showNotification(HUB_NAME, "Game terdeteksi! Memuat script khusus...", 3)

    local ok, err = pcall(function()
        loadstring(game:HttpGet(scriptURL))()
    end)

    if ok then
        showNotification(HUB_NAME, "Script Berhasil Dimuat!", 3)
    else
        showNotification(HUB_NAME, "Gagal memuat script game!", 5)
        warn(string.format("[%s] Gagal load script: %s", HUB_NAME, tostring(err)))
    end
else
    -- JIKA MAIN DI GAME LAIN, OTOMATIS MENJALANKAN MACRO GETER
    showNotification(HUB_NAME, "Memuat Macro Geter HIIELL001...", 3)
    
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    
    local player = Players.LocalPlayer
    local camera = workspace.CurrentCamera
    local koneksiUpdate, koneksiState

    local ScreenGui = Instance.new("ScreenGui")
    local GeterButton = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")

    ScreenGui.Name = "DeltaGeterMacro"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

    GeterButton.Name = "GeterButton"
    GeterButton.Parent = ScreenGui
    GeterButton.Position = UDim2.new(0.75, 0, 0.30, 0) 
    GeterButton.Size = UDim2.new(0, 75, 0, 75) 
    GeterButton.Text = "HIIELL001"
    GeterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    GeterButton.Font = Enum.Font.SourceSansBold
    GeterButton.TextSize = 14
    GeterButton.Active = true
    GeterButton.Draggable = false 

    GeterButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    GeterButton.BackgroundTransparency = 0.9
    GeterButton.TextTransparency = 0.6

    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = GeterButton

    UIStroke.Parent = GeterButton
    UIStroke.Thickness = 2 
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Transparency = 0.7
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local function prosesGeter()
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local cameraLook = camera.CFrame.LookVector
            local targetRotation = math.atan2(-cameraLook.X, -cameraLook.Z)
            local intensitasGeter = 0.08 
            local shakeX = math.random(-1, 1) * intensitasGeter
            local shakeZ = math.random(-1, 1) * intensitasGeter
            
            hrp.CFrame = CFrame.new(hrp.Position + Vector3.new(shakeX, 0, shakeZ)) * CFrame.Angles(0, targetRotation, 0)
        end
    end

    local function mainkanAnimasi(ukuranTarget, warnaGaris, transparansiGaris, warnaBg, transparansiBg, transparansiTeks)
        local infoTween = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(GeterButton, infoTween, {
            Size = ukuranTarget, BackgroundColor3 = warnaBg, BackgroundTransparency = transparansiBg, TextTransparency = transparansiTeks
        }):Play()
        TweenService:Create(UIStroke, infoTween, {
            Color = warnaGaris, Transparency = transparansiGaris
        }):Play()
    end

    GeterButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            mainkanAnimasi(UDim2.new(0, 68, 0, 68), Color3.fromRGB(0, 255, 100), 0, Color3.fromRGB(0, 0, 0), 0.2, 0)
            if not koneksiUpdate then koneksiUpdate = RunService.RenderStepped:Connect(prosesGeter) end
            
            koneksiState = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    if koneksiState then koneksiState:Disconnect() koneksiState = nil end
                    mainkanAnimasi(UDim2.new(0, 75, 0, 75), Color3.fromRGB(255, 255, 255), 0.7, Color3.fromRGB(0, 0, 0), 0.9, 0.6)
                    if koneksiUpdate then koneksiUpdate:Disconnect() koneksiUpdate = nil end
                end
            end)
        end
    end)
    
    showNotification(HUB_NAME, "Macro Geter Siap Digunakan!", 3)
end
