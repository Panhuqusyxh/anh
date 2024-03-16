#!/bin/bash

[[ $EUID -ne 0 ]] && echo -e "${red}Lỗi:${plain} Cần chạy với quyền root!\n" && exit 1

# Tải Gost
wget -N --no-check-certificate https://github.com/ginuerzh/gost/releases/download/v2.11.5/gost-linux-amd64-2.11.5.gz

# Giải nén Gost
gzip -d gost-linux-amd64-2.11.5.gz

# Đổi tên tệp thực thi
mv gost-linux-amd64-2.11.5 gost

# Cấp quyền thực thi cho tệp Gost
chmod 777 gost

nohup ./gost -L relay+tls://:800/127.0.0.1:80 >> /dev/null 2>&1 &


# Add cloudflare gpg key
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg

# Add this repo to your apt repositories
echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
# Install
sudo apt-get update && sudo apt-get install cloudflare-warp

warp-cli registration new


clear 
echo "          Vui Lòng Mở Địa Chỉ IP IN bằng lệnh "
echo "          warp-cli  tunnel ip add 'IP' "
echo "DEMO:     warp-cli  tunnel ip add 1.1.1.1   "
echo "          Để bật Warp-cli vui lòng dùng "
echo "          Warp-cli connect "

