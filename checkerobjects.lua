-- Создаем ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем Frame для списка объектов
local ObjectListFrame = Instance.new("Frame")
ObjectListFrame.Size = UDim2.new(0.3, 0, 0.5, 0)
ObjectListFrame.Position = UDim2.new(0.5, -ObjectListFrame.Size.X.Offset / 2, 0.25, 0)
ObjectListFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
ObjectListFrame.Parent = ScreenGui

-- Создаем TextLabel для отображения выбранного объекта
local SelectedObjectLabel = Instance.new("TextLabel")
SelectedObjectLabel.Size = UDim2.new(0.5, 0, 0, 30)
SelectedObjectLabel.Position = UDim2.new(0.5, -SelectedObjectLabel.Size.X.Offset / 2, 0.1, 0)
SelectedObjectLabel.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
SelectedObjectLabel.Parent = ObjectListFrame

-- Получаем объект "Unit" из рабочей области
local unit = game:GetService("Workspace"):WaitForChild("Unit")

-- Функция для отображения содержимого объекта "Unit"
local function showUnitContent()
    SelectedObjectLabel.Text = "Selected Object: Unit"
    
    -- Очищаем содержимое объекта
    for _, child in ipairs(ObjectListFrame:GetChildren()) do
        if child ~= SelectedObjectLabel then
            child:Destroy()
        end
    end
    
    -- Создаем TextLabels для дочерних объектов объекта "Unit"
    local descendants = unit:GetChildren()
    for i, descendant in ipairs(descendants) do
        local DescendantTextLabel = Instance.new("TextLabel")
        DescendantTextLabel.Size = UDim2.new(0.5, 0, 0, 30)
        DescendantTextLabel.Position = UDim2.new(0.5, -DescendantTextLabel.Size.X.Offset / 2, 0.2 + (i - 1) * 0.05, 0)
        DescendantTextLabel.Text = descendant.Name
        DescendantTextLabel.TextScaled = true
        DescendantTextLabel.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
        DescendantTextLabel.Parent = ObjectListFrame
    end
end

-- Обработчик события для отображения содержимого объекта при нажатии
SelectedObjectLabel.MouseButton1Click:Connect(function()
    showUnitContent()
end)

-- Отображаем содержимое объекта "Unit" при запуске скрипта
showUnitContent()
