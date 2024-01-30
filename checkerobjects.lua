-- Создаем ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем Frame для списка объектов
local ObjectListFrame = Instance.new("Frame")
ObjectListFrame.Size = UDim2.new(0.3, 0, 0.5, 0)
ObjectListFrame.Position = UDim2.new(0.5, -ObjectListFrame.Size.X.Offset / 2, 0.25, 0)
ObjectListFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
ObjectListFrame.Parent = ScreenGui

-- Создаем ScrollFrame для прокрутки списка
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.Parent = ObjectListFrame

-- Получаем объект "Unit" из рабочей области
local unit = workspace:WaitForChild("Unit")

-- Создаем TextLabels для каждого дочернего объекта "Unit" и добавляем их в ScrollFrame
local descendants = unit:GetChildren()
for i, child in ipairs(descendants) do
    local ObjectTextLabel = Instance.new("TextLabel")
    ObjectTextLabel.Size = UDim2.new(1, 0, 0, 30)
    ObjectTextLabel.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
    ObjectTextLabel.Text = "Object " .. i .. ": " .. child.Name
    ObjectTextLabel.TextScaled = true
    ObjectTextLabel.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    ObjectTextLabel.Parent = ScrollFrame
    
    -- Обновляем размер CanvasSize, чтобы вместить все объекты
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, i * 30)
end

-- Применяем код к каждому объекту "Unit"
for _, child in ipairs(children) do
    local args = {
        [1] = "Upgrade",
        [2] = child
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):InvokeServer(unpack(args))
end
