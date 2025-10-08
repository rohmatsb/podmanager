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
    echo "4. Pull images"
    echo "5. List all existing podman images"
    echo "6. Delete podman images"
    echo "7. Exit"
    echo "==============="
    echo ""

    # Menerima input pengguna
    read -p "Enter number : " pilihan

    # Sortir input
    case $pilihan in
    1) clear && podmanager-create-container ; break ;;
    2) clear && podmanager-list-container ; break ;;
    3) clear && podmanager-del-container ; break ;;
    4) clear && podmanager-pull-images ; break ;;
    5) clear && podmanager-list-images ; break ;;
    6) clear && podmanager-del-images ; break ;;
    7) # exit
    *) clear && echo "Silakan masukkan pilihan yang benar!" && sleep 3 && clear ;;
    esac # Menutup case

# Menutup while-true
done