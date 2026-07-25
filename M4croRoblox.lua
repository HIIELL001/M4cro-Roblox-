local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local koneksiUpdate = nil
local koneksiState = nil 

-- Buat Tombol GUI
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

-- PERUBAHAN UTAMA: Membuat tombol sangat transparan saat diam
GeterButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
GeterButton.BackgroundTransparency = 0.9 -- Sangat transparan (hampir tidak terlihat)
GeterButton.TextTransparency = 0.6       -- Teks dibuat samar agar tidak mengganggu

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = GeterButton

-- PERUBAHAN UTAMA: Garis tepi melingkar juga dibuat sangat samar saat diam
UIStroke.Parent = GeterButton
UIStroke.Thickness = 2 
UIStroke.Color = Color3.fromRGB(255, 255, 255) -- Warna putih samar saat diam
UIStroke.Transparency = 0.7                  -- Garis dibuat tipis transparan
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Fungsi Inti Macro Geter
local function prosesGeter()
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local cameraLook = camera.CFrame.LookVector
        
        local targetRotation = math.atan2(-cameraLook.X, -cameraLook.Z)
        
        local intensitasGeter = 0.08 
        local shakeX = math.random(-1, 1) * intensitasGeter
        local shakeZ = math.random(-1, 1) * intensitasGeter
        
        local posisiSaatIni = hrp.Position
        local posisiBaru = posisiSaatIni + Vector3.new(shakeX, 0, shakeZ)
        
        hrp.CFrame = CFrame.new(posisiBaru) * CFrame.Angles(0, targetRotation, 0)
    end
end

-- Fungsi Animasi Transisi Warna & Transparansi
local function mainkanAnimasi(ukuranTarget, warnaGaris, transparansiGaris, warnaBg, transparansiBg, transparansiTeks)
    local infoTween = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    TweenService:Create(GeterButton, infoTween, {
        Size = ukuranTarget,
        BackgroundColor3 = warnaBg,
        BackgroundTransparency = transparansiBg,
        TextTransparency = transparansiTeks
    }):Play()
    
    TweenService:Create(UIStroke, infoTween, {
        Color = warnaGaris,
        Transparency = transparansiGaris
    }):Play()
end

local ukuranAsli = UDim2.new(0, 75, 0, 75)
local ukuranDitekan = UDim2.new(0, 68, 0, 68)

-- Fungsi Memulai Makro (Saat Dipencet)
local function startMacro()
    -- PERUBAHAN: Saat dipencet, background jadi hitam pekat (0.2), lingkaran berubah hijau menyala (0), teks jadi jelas (0)
    mainkanAnimasi(ukuranDitekan, Color3.fromRGB(0, 255, 100), 0, Color3.fromRGB(0, 0, 0), 0.2, 0)
    
    if not koneksiUpdate then
        koneksiUpdate = RunService.RenderStepped:Connect(prosesGeter)
    end
end

-- Fungsi Menghentikan Makro (Saat Dilepas)
local function stopMacro()
    if koneksiState then
        koneksiState:Disconnect()
        koneksiState = nil
    end
    
    -- PERUBAHAN: Saat dilepas, kembali ke mode super transparan & samar
    mainkanAnimasi(ukuranAsli, Color3.fromRGB(255, 255, 255), 0.7, Color3.fromRGB(0, 0, 0), 0.9, 0.6)
    
    if koneksiUpdate then
        koneksiUpdate:Disconnect()
        koneksiUpdate = nil
    end
end

-- Sistem Deteksi Tekanan Jari yang Terkunci Aman
GeterButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        startMacro()
        
        koneksiState = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                stopMacro()
            end
        end)
    end
end)
