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
    echo "0. Custom URL"
    echo "1. Debian latest"
    echo "2. Arch latest"
    echo "3. Centos latest"
    echo "4. Alpine latest"
    echo "5. RockyLinux latest"
 

    # Menerima input user
    read -p "Enter number : " pilihan

    # Sortir input
    case $pilihan in
    0) 
        clear
        echo "========"
        echo "Enter url to pull container images!"
        echo "Example : 'quay.io/toolbx-images/debian-toolbox'"
        echo "========"
        echo ""
        read -p "Enter url : " custom_url
        podman pull $custom_url
        break # Menghentikan loop, karena pilihan sudah benar
        ;;
    1) clear && podman pull $debian ; break ;;
    2) clear && podman pull $arch ; break ;;
    3) clear && podman pull $centos ; break ;;
    4) clear && podman pull $alpine ; break ;;
    5) clear && podman pull $rocky ; break ;;
    *) clear && echo "Silakan masukkan pilihan yang benar!" && sleep 3 && clear ;;
    esac # Menutup case

# Menutup while-true
done