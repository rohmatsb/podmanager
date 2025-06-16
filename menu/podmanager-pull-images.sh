# Clear whatever in the screen
clear

# Simpan url pull ke dalam variabel
debian="quay.io/toolbx-images/debian-toolbox"
arch="quay.io/toolbx/arch-toolbox"
centos="quay.io/toolbx-images/centos-toolbox"
alpine="quay.io/toolbx-images/alpine-toolbox"
rocky="quay.io/toolbx-images/rockylinux-toolbox"

# Menggunakan  while-true, agar terjadi pengulangan jika user input invalid
while true; do

    # Print menu
    echo "==============="
    echo "PULL IMAGES"
    echo "==============="
    echo "1. Debian latest"
    echo "2. Arch latest"
    echo "3. Centos latest"
    echo "4. Alpine latest"
    echo "5. RockyLinux latest"

    # Menerima input user
    read -p "Enter number : " pilihan

    # Sortir input
    case $pilihan in
    1) 