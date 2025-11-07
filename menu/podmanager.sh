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
    echo "1. Enter container"
    echo "2. Create container"
    echo "3. List all existing container"
    echo "4. Delete container"
    echo "5. Pull images"
    echo "6. List all existing podman images"
    echo "7. Delete podman images"
    echo "8. Exit"
    echo "==============="
    echo ""

    # Menerima input pengguna
    read -p "Enter number : " pilihan

    # Sortir input
    case $pilihan in
    1) clear && podmanager-enter-container ; break ;;
    2) clear && podmanager-create-container ; break ;;
    3) clear && podmanager-list-container ; break ;;
    4) clear && podmanager-del-container ; break ;;
    5) clear && podmanager-pull-images ; break ;;
    6) clear && podmanager-list-images ; break ;;
    7) clear && podmanager-del-images ; break ;;
    8) exit 0 ;;
    *) clear && echo "Silakan masukkan pilihan yang benar!" && sleep 3 && clear ;;
    esac # Menutup case

# Menutup while-true
done
