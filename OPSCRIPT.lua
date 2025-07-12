-- Local Script para Roblox Mobile: Lendas do Vôlei
-- Coloque este script dentro de StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Ícone Flutuante
local IconButton = Instance.new("ImageButton")
IconButton.Name = "VoleiHelperIcon"
IconButton.Size = UDim2.new(0, 60, 0, 60)
IconButton.Position = UDim2.new(0.05, 0, 0.3, 0)
IconButton.BackgroundTransparency = 0.5
IconButton.Image = "rbxassetid://14930328757" -- Substitua pelo seu ícone
IconButton.Parent = ScreenGui
IconButton.Draggable = true

-- Painel de Funções
local MainFrame = Instance.new("Frame")
MainFrame.Name = "HelperMain"
MainFrame.Size = UDim2.new(0, 260, 0, 320)
MainFrame.Position = UDim2.new(0.13, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
MainFrame.Draggable = true

local Title = Instance.new("TextLabel")
Title.Text = "Lendas do Vôlei - Helper"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.new(1,1,1)
Title.Parent = MainFrame

-- Função de Toggle da GUI
IconButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local function createToggleButton(name, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Text = name.." [OFF]"
    btn.Name = name.."Button"
    btn.Size = UDim2.new(0.9, 0, 0, 38)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,120)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 17
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Parent = MainFrame

    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.Text = name.." ["..(enabled and "ON" or "OFF").."]"
        callback(enabled)
    end)
    return btn
end

-- Funções Utilitárias

-- 1. Auto Save (Simulação)
local function autoSave(isOn)
    if isOn then
        print("Auto Save ativado!")
        -- Aqui você pode adicionar integração com sistemas de save, se permitido pelo jogo
    else
        print("Auto Save desativado.")
    end
end
createToggleButton("Auto Save", 45, autoSave)

-- 2. Auto Jump para bolas próximas
local autoJumpOn = false
local function autoJump(isOn)
    autoJumpOn = isOn
end
createToggleButton("Auto Jump", 90, autoJump)

-- 3. Ball Tracker (destaca a bola)
local highlight = nil
local function ballTracker(isOn)
    if isOn then
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj.Name:lower():find("bola") then
                highlight = Instance.new("Highlight")
                highlight.Adornee = obj
                highlight.FillColor = Color3.fromRGB(255, 255, 0)
                highlight.Parent = obj
            end
        end
    else
        if highlight then highlight:Destroy() end
    end
end
createToggleButton("Ball Tracker", 135, ballTracker)

-- 4. Fast Serve (Simulação de clique rápido)
local function fastServe(isOn)
    if isOn then
        print("Fast Serve ativado!")
        -- Adicione lógica específica do jogo para servir rapidamente
    else
        print("Fast Serve desativado.")
    end
end
createToggleButton("Fast Serve", 180, fastServe)

-- 5. GUI Flutuante
-- A GUI já é draggable, então flutua na tela!

-- Loop para Auto Jump
game:GetService("RunService").RenderStepped:Connect(function()
    if autoJumpOn then
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj.Name:lower():find("bola") and obj:IsA("Part") then
                local dist = (obj.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if dist < 10 then
                    -- Simula pulo
                    player.Character.Humanoid.Jump = true
                end
            end
        end
    end
end)

-- OBS: Adapte os nomes dos objetos de "bola" para o nome exato do item no seu jogo.

print("Script Helper Lendas do Vôlei carregado!")
