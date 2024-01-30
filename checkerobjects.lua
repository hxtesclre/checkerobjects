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

-- Получаем доступ к рабочей области
local workspace = game:GetService("Workspace")

-- Получаем все объекты в рабочей области
local children = workspace:GetChildren()

-- Функция для отображения дополнительного GUI с содержимым объекта
local function showObjectDetails(object)
    local ObjectDetailsFrame = Instance.new("Frame")
    ObjectDetailsFrame.Size = UDim2.new(0.3, 0, 0.3, 0)
    ObjectDetailsFrame.Position = UDim2.new(0.5, -ObjectDetailsFrame.Size.X.Offset / 2, 0.1, 0)
    ObjectDetailsFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    ObjectDetailsFrame.Parent = ScreenGui

    local ObjectNameLabel = Instance.new("TextLabel")
    ObjectNameLabel.Size = UDim2.new(1, 0, 0.1, 0)
    ObjectNameLabel.Position = UDim2.new(0, 0, 0, 0)
    ObjectNameLabel.Text = "Object Name: " .. object.Name
    ObjectNameLabel.Parent = ObjectDetailsFrame

    local ObjectPropertiesLabel = Instance.new("TextLabel")
    ObjectPropertiesLabel.Size = UDim2.new(1, 0, 0.8, 0)
    ObjectPropertiesLabel.Position = UDim2.new(0, 0, 0.1, 0)
    ObjectPropertiesLabel.Text = "Properties: \n" .. table.concat(object:GetDescendants(), "\n")
    ObjectPropertiesLabel.TextWrapped = true
    ObjectPropertiesLabel.Parent = ObjectDetailsFrame
end

-- Создаем TextLabels для каждого объекта и добавляем их в ScrollFrame
for i, child in ipairs(children) do
    local ObjectTextLabel = Instance.new("TextLabel")
    ObjectTextLabel.Size = UDim2.new(1, 0, 0, 30)
    ObjectTextLabel.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
    ObjectTextLabel.Text = "Object " .. i .. ": " .. child.Name
    ObjectTextLabel.TextScaled = true
    ObjectTextLabel.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    ObjectTextLabel.Parent = ScrollFrame
    
    -- Обновляем размер CanvasSize, чтобы вместить все объекты
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, i * 30)
    
    -- Обработчик события для отображения содержимого объекта при нажатии
    ObjectTextLabel.MouseButton1Click:Connect(function()
        showObjectDetails(child)
    end)
end
