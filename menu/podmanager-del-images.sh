# Color
NC='\e[0m' # No Color (reset)
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
MAGENTA='\e[0;35m'
CYAN='\e[0;36m'
WHITE='\e[0;37m'

### Deklarasikan Variabel Global ###
akan_dihapus="" 
### Selesai mendeklarasikan Variabel Global ###

#############################
### Mendefinisikan Fungsi ###
#############################

function menu_hapus {
    # memasukkan daftar nama container kedalam array
    while true; do
        clear
        echo "================="
        echo "Delete Images"
        echo "================="
        echo ""
        echo "Pilih image yang akan dihapus :"
        echo ""

        # memasukkan daftar container yang ada ke dalam array
        mapfile -t daftar_podman_images < <(podman images --format "{{.Repository}}")

        # print pesan yang akan ditampilkan di bawah menu (saat input)
        PS3="Masukkan angka pilihan : "
        
        # print pilihan menggunakan select
        select imgs in "${daftar_podman_images[@]}"; do
            if [[ -n "${imgs}" ]]; then
                akan_dihapus=${imgs}
                break 2
            else
                echo ""
                echo -e "${RED}Input invalid, silahkan masukkan ulang!${NC}"
                sleep 3
                continue 2
            fi
        done
    done
}

function yn_delete_menu {
    clear
    echo "================="
    echo "Delete Images"
    echo "================="
    echo ""
    echo -e "Yakin ingin menghapus image ${akan_dihapus}?"
    echo ""
    echo "Enter y/n/yes/no (case insensitive)"
    read -p "Masukkan pilihan : " yn_delete
}

function deleting {
    podman rmi ${akan_dihapus} #aksi menghapus

    clear
    echo "================="
    echo "Delete Images"
    echo "================="
    echo ""
    echo -e "Image ${RED}${akan_dihapus}${NC} telah dihapus!"
}

###################################################
### Selesai mendefinisikan fungsi-fungsi global ###
###################################################

menu_hapus
yn_delete_menu


if [[ "${yn_delete,,}" == "yes" || "${yn_delete,,}" == "y" ]]; then
    deleting
elif [[ "${yn_delete,,}" == "no" || "${yn_delete,,}" == "n" ]]; then
    exit
else
    echo ""
    echo -e "${RED}Invalid, masukkan pilihan yang benar!${NC}"
    sleep 2
    continue
fi