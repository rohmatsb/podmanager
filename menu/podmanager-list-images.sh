# Color
NC='\e[0m' # No Color (reset)
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
MAGENTA='\e[0;35m'
CYAN='\e[0;36m'
WHITE='\e[0;37m'

# Deklarasi variabel global
# var=1
# var=""
# var=()
# Selesai mendeklarasikan var global

###########################################
### Mendefinisikan fungsi-fungsi global ###
###########################################

function list_images() {
    clear
    echo "================"
    echo "List Images"
    echo "================"
    echo ""
    echo "Menampilkan daftar container images yang telah di download..."
    sleep 3

    clear

    # buat daftar images podman menjadi array, disimpan ke variabel daftar_podman_images
    mapfile -t daftar_podman_images < <(podman images --format "{{.Repository}}")

    # echo ulang menu atas
    echo "================"
    echo "List Images"
    echo "================"
    echo ""
    echo "Daftar images"
    echo "--------------"
    echo ""
    
    n=1  # untuk digunakan di for-loop

    for imgs in "${daftar_podman_images[@]}"; do
    echo "${n}. ${imgs}"
    n=$((n + 1))
    done
}

###################################################
### Selesai mendefinisikan fungsi-fungsi global ###
###################################################

### Script Running ###

list_images

### Script ended ###