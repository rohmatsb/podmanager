# Color
NC='\e[0m' # No Color (reset)
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
MAGENTA='\e[0;35m'
CYAN='\e[0;36m'
WHITE='\e[0;37m'

# Mendeklarasikan variabel global
akan_dibuka=""

# Mendefinisikan fungsi-fungsi global
function menu_masuk {
    while true; do
        clear
        echo "================="
        echo "Enter containers"
        echo "================="
        echo ""
        echo "Pilih container yang akan dibuka terminal nya :"
        echo ""

        # memasukkan daftar container yang ada ke dalam array
        mapfile -t daftar_podman_container < <(podman ps -a --format "{{.Names}}")

        # print pesan yang akan ditampilkan di bawah menu (saat input)
        PS3="Masukkan angka pilihan : "
        
        # print pilihan menggunakan select
        select cont in "${daftar_podman_container[@]}"; do
            if [[ -n "${cont}" ]]; then
                akan_dibuka=${cont}
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

function yn_enter_container {
    clear
    echo "================="
    echo "Enter container"
    echo "================="
    echo ""
    echo -e "Yakin ingin membuka container ${akan_dibuka}?"
    echo ""
    echo "Enter y/n/yes/no (case insensitive)"
    read -p "Masukkan pilihan : " yn_enter

    if [[ "${yn_enter,,}" == "yes" || "${yn_enter,,}" == "y" ]]; then
        : #do-nothing-and-continue-script
    elif [[ "${yn_enter,,}" == "no" || "${yn_enter,,}" == "n" ]]; then
        podmanager
    else
        echo ""
        echo -e "${RED}Invalid, masukkan pilihan yang benar!${NC}"
        sleep 2
        continue
    fi
}

function check_for_running {
    running_container=()
    running_container=$(podman ps --format json | jq -r ".[].Names.[]")

    for rcont in "${running_container[@]}"; do
        if [[ "${akan_dibuka}" == "${rcont}" ]]; then
            : #do-nothing-and-continue-sc
        else
            podman start ${akan_dibuka}
        fi
    done
}

##### Menjalankan script utama #####
menu_masuk
yn_enter_container
check_for_running

podman exec -it ${akan_dibuka} /bin/bash