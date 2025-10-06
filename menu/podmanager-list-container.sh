# Color
NC='\e[0m' # No Color (reset)
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
MAGENTA='\e[0;35m'
CYAN='\e[0;36m'
WHITE='\e[0;37m'

### Deklarasi variabel global ###
daftar_podman_container=()
cont=""  # container yang akan dicek

### Selesai deklarasi variabel global ###

###########################################
### Mendefinisikan fungsi-fungsi global ###
###########################################

function menu {
    echo "==============="
    echo "List containers"
    echo "==============="
    echo ""
    echo "Dibawah ini adalah list container yang telah dibuat :"
    echo ""

    # memasukkan daftar container yang ada ke dalam array
    mapfile -t daftar_podman_container < <(podman ps -a --format "{{.Names}}")

    # print pesan yang akan ditampilkan di bawah menu (saat input)
    PS3="Masukkan angka pilihan : "
    
    # print pilihan menggunakan select
    select cont in "${daftar_podman_container[@]}"; do
        if [[ -n "${cont}" ]]; then
            echo ""
            echo -e "Mengecek detail container ${GREEN}${cont}${NC}..."
            break
        else
            echo ""
            echo -e "${RED}Input invalid, silahkan masukkan ulang!${NC}"
            sleep 3
        fi
    done
}

=====================
=== START RUNNING ===
=====================

menu