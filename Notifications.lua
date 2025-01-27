return function(Text)
	local TweenService = game:GetService("TweenService") -- Lấy dịch vụ Tween
	local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui") -- Lấy giao diện của người chơi
	
	-- Tạo Notifications Frame nếu chưa tồn tại
	local notificationsFrame = playerGui:FindFirstChild("Notifications")
	if not notificationsFrame then
		notificationsFrame = Instance.new("Frame")
		notificationsFrame.Name = "Notifications"
		notificationsFrame.Size = UDim2.new(0, 600, 0, 40) -- Kích thước
		notificationsFrame.Position = UDim2.new(0.5, -300, 0, 4) -- Vị trí
		notificationsFrame.BackgroundTransparency = 1 -- Độ trong suốt
		notificationsFrame.Parent = playerGui -- Đặt vào PlayerGui
	end

	-- Tạo TextLabel
	local textLabel = Instance.new("TextLabel")
	textLabel.Parent = notificationsFrame -- Đảm bảo Notifications đã tồn tại
	textLabel.Name = "DitMeMay"
	textLabel.Size = UDim2.new(0, 600, 0, 40) -- Kích thước
	textLabel.Position = UDim2.new(0, 0, 0, 0) -- Vị trí
	textLabel.AnchorPoint = Vector2.new(0, 0) -- Điểm neo
	textLabel.Visible = true -- Hiển thị
	textLabel.ZIndex = 25 -- Thứ tự hiển thị
	textLabel.Rotation = 0 -- Góc xoay
	textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Màu nền
	textLabel.BackgroundTransparency = 1 -- Độ trong suốt của nền
	textLabel.BorderColor3 = Color3.fromRGB(27, 42, 53) -- Màu viền
	textLabel.BorderMode = Enum.BorderMode.Outline -- Kiểu viền
	textLabel.BorderSizePixel = 1 -- Độ dày của viền
	textLabel.Text = Text -- Đặt màu vàng cho chữ
	textLabel.RichText = true -- Bật RichText
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Màu chữ (có thể giữ trắng hoặc thay đổi theo ý thích)
	textLabel.TextTransparency = 1 -- Độ trong suốt của chữ (bắt đầu ẩn)
	textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) -- Màu viền chữ
	textLabel.TextStrokeTransparency = 0.5 -- Độ trong suốt viền chữ
	textLabel.TextScaled = false -- Không tự động co dãn chữ
	textLabel.TextSize = 32 -- Kích thước chữ
	textLabel.Font = Enum.Font.SourceSansSemibold -- Kiểu chữ
	textLabel.TextXAlignment = Enum.TextXAlignment.Center -- Căn chỉnh chữ ngang
	textLabel.TextYAlignment = Enum.TextYAlignment.Center -- Căn chỉnh chữ dọc
	textLabel.LineHeight = 1 -- Khoảng cách dòng
	textLabel.SizeConstraint = Enum.SizeConstraint.RelativeXY -- Hạn chế kích thước
	textLabel.Active = false -- Không thể nhận sự tương tác
	textLabel.Selectable = false -- Không thể chọn
	textLabel.ClipsDescendants = false -- Không cắt bớt nội dung
	textLabel.AutoLocalize = false -- Không tự động dịch ngôn ngữ
	textLabel.SelectionOrder = 0 -- Thứ tự chọn
	textLabel.LayoutOrder = 0 -- Thứ tự sắp xếp khi dùng Layout

	-- Hiện TextLabel từ từ
	local function fadeIn()
		textLabel.TextTransparency = 1 -- Bắt đầu với độ trong suốt 1 (ẩn)
		textLabel.Visible = true -- Hiển thị TextLabel

		-- Tween cho hiệu ứng hiện lên
		local fadeInTween = TweenService:Create(textLabel, TweenInfo.new(1), {TextTransparency = 0})
		fadeInTween:Play()
		fadeInTween.Completed:Wait() -- Chờ cho hiệu ứng hoàn tất
	end

	-- Biến mất từ từ
	local function fadeOut()
		-- Tween cho hiệu ứng biến mất
		local fadeOutTween = TweenService:Create(textLabel, TweenInfo.new(1), {TextTransparency = 1})
		fadeOutTween:Play()
		fadeOutTween.Completed:Wait() -- Chờ cho hiệu ứng hoàn tất
		textLabel.Visible = false -- Ẩn TextLabel sau khi biến mất
	end

	-- Chạy hiệu ứng
	fadeIn() -- Hiện lên
	wait(2) -- Giữ TextLabel hiển thị trong 2 giây
	fadeOut() -- Biến mất
	textLabel:Destroy() -- Hủy bỏ TextLabel
end
