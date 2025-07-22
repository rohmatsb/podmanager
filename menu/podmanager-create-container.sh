# clear dulu
clear

# Menggunakan while-true agar terjadi pengulangan jika nilai yang dimasukkan pengguna salah
while true; do

# Menampilkan menu
echo "========"
echo "Create container"
echo "========"
echo ""
read -p "Enter container name : " nama_container
read -p "Enter container port to forward : " container_port
read -p "Enter host port : " host_port
