#!/bin/bash

echo "🚀 Thiết lập Git và SSH trên EC2..."

# Cập nhật hệ thống
echo "📦 Cập nhật hệ thống..."
if command -v yum &> /dev/null; then
    sudo yum update -y
    sudo yum install git -y
elif command -v apt &> /dev/null; then
    sudo apt update
    sudo apt install git -y
fi

# Kiểm tra Git đã cài đặt
echo "✅ Kiểm tra Git version:"
git --version

# Cấu hình Git (người dùng cần thay đổi thông tin)
echo "⚙️ Cấu hình Git user info..."
read -p "Nhập tên của bạn: " git_name
read -p "Nhập email của bạn: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

# Tạo SSH key
echo "🔑 Tạo SSH key..."
ssh-keygen -t ed25519 -C "$git_email" -f ~/.ssh/id_ed25519 -N ""

# Khởi động SSH agent
echo "🔄 Khởi động SSH agent..."
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Hiển thị public key
echo ""
echo "📋 SSH Public Key của bạn (copy và thêm vào GitHub):"
echo "=================================================="
cat ~/.ssh/id_ed25519.pub
echo "=================================================="
echo ""

echo "📝 Hướng dẫn tiếp theo:"
echo "1. Copy public key ở trên"
echo "2. Vào GitHub → Settings → SSH and GPG keys → New SSH key"
echo "3. Paste public key và save"
echo "4. Chạy lệnh: ssh -T git@github.com để test"
echo "5. Clone repo: git clone git@github.com:trolevan26299/tm-upload-master.git"

echo ""
echo "✅ Thiết lập hoàn tất!" 