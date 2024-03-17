
# Kiểm tra quyền root
[[ $EUID -ne 0 ]] && echo -e "${red}Lỗi:${plain} Cần chạy với quyền root!\n" && exit 1

# Tải Gost
wget -N --no-check-certificate https://github.com/ginuerzh/gost/releases/download/v2.11.5/gost-linux-amd64-2.11.5.gz

# Giải nén Gost
gzip -d gost-linux-amd64-2.11.5.gz

# Đổi tên tệp thực thi
mv gost-linux-amd64-2.11.5 gost

# Cấp quyền thực thi cho tệp Gost
chmod 777 gost

# Hỏi người dùng về địa chỉ IP
read -p "Nhập địa chỉ IP Tiếp Nhận: " ip_address

# Kiểm tra xem địa chỉ IP có hợp lệ không (có thể thêm kiểm tra chi tiết hơn tùy ý)
if [[ $ip_address =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    # Thay thế địa chỉ IP trong lệnh với giá trị mới từ người dùng
    command="nohup ./gost -L udp://:80 -L tcp://:80 -F relay+tls://$ip_address:8000 >> /dev/null 2>&1 &"
    
    # Thực thi lệnh đã thay đổi
    eval $command
else
    echo "Địa chỉ IP không hợp lệ!"
    exit 1
fi
