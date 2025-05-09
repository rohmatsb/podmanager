# Clear whatever in the screen
clear

# Store value 
script_version="1.0"

# Menggunakan while-true, agar terjadi pengulangan jika user input invalid
while true; do

    # Print menu
    echo "==============="
    echo "PODMAN MANAGER"
    echo "==============="
    echo "STATUS"
    echo "------"
    echo "script-version   : ${script_version}"
    echo "podman-version   : $(podman --version | awk '{print $3}')"
    echo "==============="
    echo "1. Create container"
    echo "2. List all existing container"
    echo "3. Delete container"
    echo "4. Exit"
    echo "==============="
    echo ""

    # Menerima input pengguna
    read -p "Enter number : " pilihan

    # Sortir input
    case $pilihan in
    1) clear && create-container ; break ;;
    2) clear && list-container ; break ;;
    3) clear && delete-container ; break ;;
    4) exit ;;
    *) clear && echo "Silakan masukkan pilihan yang benar!" && sleep 3 && clear ;;

    # Menutup case
    esac

# Menutup while-true
done