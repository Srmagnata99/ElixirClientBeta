local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Função para criar uma linha
local function createLine(parent, startPos, endPos, thickness, lineColor, borderColor, zIndex)
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, (endPos - startPos).Magnitude, 0, thickness)
    line.Position = UDim2.new(0, (startPos.X + endPos.X) / 2, 0, (startPos.Y + endPos.Y) / 2)
    line.BackgroundColor3 = lineColor or Color3.new(1, 1, 1)
    line.AnchorPoint = Vector2.new(0.5, 0.5)
    line.ZIndex = zIndex -- Definir o ZIndex para garantir a ordem de empilhamento

    -- Calcula o ângulo da linha
    local direction = (endPos - startPos).Unit
    local angle = math.atan2(direction.Y, direction.X)
    line.Rotation = math.deg(angle)

    -- Criar o efeito de borda para a linha
    local border = Instance.new("UIStroke")
    border.Parent = line
    border.Color = borderColor -- Cor das bordas
    border.Thickness = thickness
    border.Transparency = 0.5 -- Ajuste conforme necessário

    line.Parent = parent
    
    -- Adiciona a animação de FadeIn
    line.BackgroundTransparency = 1
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
    local goal = {BackgroundTransparency = 0}
    local tween = TweenService:Create(line, tweenInfo, goal)
    tween:Play()
end

-- Função para criar uma letra "C" com borda e degradê
local function createLetterC(parent, position, size, borderColor)
    local letterC = Instance.new("TextLabel")
    letterC.Size = UDim2.new(0, size.X, 0, size.Y)
    letterC.Position = UDim2.new(0, position.X, 0, position.Y)
    letterC.Text = "C"
    letterC.Font = Enum.Font.SourceSansBold
    letterC.TextSize = size.Y * 2 -- Aumentar o tamanho da fonte
    letterC.TextColor3 = Color3.fromRGB(255, 255, 255)
    letterC.BackgroundTransparency = 1
    letterC.ZIndex = 2  -- Ficar atrás das linhas
    letterC.Parent = parent

    -- Criar o efeito de borda e degradê
    local border = Instance.new("UIStroke")
    border.Parent = letterC
    border.Color = borderColor
    border.Thickness = 5  -- Ajusta a espessura da borda
    border.Transparency = 0.1 -- Transparência para dar efeito de degradê
    
    -- Adiciona a animação de FadeIn
    letterC.TextTransparency = 1
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
    local goal = {TextTransparency = 0}
    local tween = TweenService:Create(letterC, tweenInfo, goal)
    tween:Play()
end

-- Função para criar um texto com bordas
local function createText(parent, position, text, size, borderColor)
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0, size.X, 0, size.Y)
    textLabel.Position = UDim2.new(0, position.X, 0, position.Y)
    textLabel.Text = text
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = size.Y
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.BackgroundTransparency = 1
    textLabel.ZIndex = 2
    textLabel.Parent = parent

    -- Criar o efeito de borda
    local border = Instance.new("UIStroke")
    border.Parent = textLabel
    border.Color = borderColor
    border.Thickness = 3 -- Espessura da borda
    border.Transparency = 0.5 -- Transparência para o efeito de borda

    -- Adiciona a animação de FadeIn
    textLabel.TextTransparency = 1
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
    local goal = {TextTransparency = 0}
    local tween = TweenService:Create(textLabel, tweenInfo, goal)
    tween:Play()
end

-- Determinar o centro da tela
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local screenSize = camera.ViewportSize
local center = Vector2.new(screenSize.X / 2, screenSize.Y / 2)

-- Tamanho da letra "C"
local letterCSize = Vector2.new(100, 150)

-- Criar a letra "C" com borda roxa no meio da tela, movida 3 cm para a esquerda
createLetterC(ScreenGui, center + Vector2.new(letterCSize.X / 2 - 80, -letterCSize.Y / 2), letterCSize, Color3.fromRGB(128, 0, 128)) -- Roxo

-- Ajustar o tamanho do losango "⧫" para o tamanho da letra "C"
local size = 75 * 0.5  -- Reduzido para metade do tamanho anterior

-- Definir os pontos para o losango "⧫" no centro da tela
local top = center - Vector2.new(0, size) -- Ponto superior
local bottom = center + Vector2.new(0, size) -- Ponto inferior
local left = center - Vector2.new(size, 0) -- Ponto esquerdo
local right = center + Vector2.new(size, 0) -- Ponto direito

-- Espessura das linhas do losango
local lineThickness = 5  -- Ajustado se necessário para combinar com o novo tamanho

-- Criar as quatro linhas que formam o "⧫" no centro da tela
createLine(ScreenGui, left, top, lineThickness, Color3.fromRGB(255, 255, 255), Color3.fromRGB(128, 0, 128), 1) -- Linha esquerda
createLine(ScreenGui, top, right, lineThickness, Color3.fromRGB(255, 255, 255), Color3.fromRGB(128, 0, 128), 3) -- Linha superior
createLine(ScreenGui, right, bottom, lineThickness, Color3.fromRGB(255, 255, 255), Color3.fromRGB(128, 0, 128), 1) -- Linha direita
createLine(ScreenGui, bottom, left, lineThickness, Color3.fromRGB(255, 255, 255), Color3.fromRGB(128, 0, 128), 1) -- Linha inferior

-- Criar o texto "Elixir Client" abaixo da letra "C"
local textSize = Vector2.new(200, 50)
createText(ScreenGui, center + Vector2.new(-textSize.X / 2, letterCSize.Y / 2 + -25), "Elixir Client Beta", textSize, Color3.fromRGB(128, 0, 128)) -- Roxo

-- Esperar 5 segundos e depois remover o ScreenGui
wait(5)
ScreenGui:Destroy()