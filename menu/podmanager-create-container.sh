# Color
NC='\e[0m' # No Color (reset)
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
MAGENTA='\e[0;35m'
CYAN='\e[0;36m'
WHITE='\e[0;37m'

#### Deklarasi Variabel Global ####

nama_container=""

port_container_1=""
port_host_1=""

port_container_2=""
port_host_2=""

image_pilihan=""

#### Selesai Deklarasi Variabel Global ####

#############################################
#### Mendefinisikan fungsi-fungsi global ####
#############################################

# Menu input nama container
function input_container_name() {
    clear
    echo "================"
    echo "Create container"
    echo "================"
    echo ""
    read -p "Enter container name : " nama_container
    echo ""
}

# Fungsi validasi nama container
function is_valid_podman_container_name() {
    local name="$1"
    local max_length=63

    # 1. Check for empty input
    if [[ -z "$name" ]]; then
        echo -e "${RED}Error: Name cannot be empty.${NC}"
        echo ""
        return 1
    fi

    # 2. Check length
    if [[ ${#name} -gt $max_length ]]; then
        echo -e "${RED}Error: Name '$name' is too long (max $max_length characters).${NC}"
        echo ""
        return 1
    fi

    # 3. Check allowed characters and start character
    # Regex: Must start with alphanumeric, followed by alphanumeric, hyphens, underscores, or dots.
    if [[ ! "$name" =~ ^[a-zA-Z0-9][a-zA-Z0-9_.-]*$ ]]; then
        echo -e "${RED}Error: Name '$name' contains invalid characters or has an invalid start."
        echo -e "Allowed: alphanumeric, hyphens, underscores, dots. Must start with alphanumeric.${NC}"
        echo ""
        return 1
    fi

    # 4. Check for uniqueness (requires Podman to be installed)
    #if podman container exists "$name" &>/dev/null; then
    #    echo "Error: Container name '$name' already exists."
    #    return 1
    #fi

    return 0 # All checks passed, name is valid
}

# Apakah ingin forward port (menu tanya)
function menu_tanya_forward_port() {
    clear
    echo "================"
    echo "Create container"
    echo "================"
    echo ""
    echo "Do you want to forward port?"
    read -p "Yes or No : " yn_portforward
}

# Menu Input Port

function menu_input_port_1() {

    while true; do
        clear
        echo "================"
        echo "Create container"
        echo "================"
        echo ""
        echo "Masukkan port yang ingin kamu forward (port inside container)"
        read -p "Input port : " port_container_1
        echo ""
        echo "Masukkan port host machine (port outside container)"
        read -p "Input port : " port_host_1
        echo ""

        # Validasi port container
        if check_port_container ${port_container_1}; then
            echo -e "${GREEN}Port container is valid, continue...${NC}"
            sleep 3
        else
            echo -e "${RED}Port container invalid, please re-enter!${NC}"
            sleep 3
            continue
        fi

        # Validasi port host
        if check_port_host ${port_host_1}; then
            echo -e "${GREEN}Port host is valid, continue...${NC}"
            sleep 3
            break
        else
            echo -e "${RED}Port host is invalid, please re-enter!${NC}"
            sleep 3
            continue
        fi
    done
}

function menu_input_port_2() {

    while true; do
        clear
        echo "================"
        echo "Create container"
        echo "================"
        echo ""
        echo "Masukkan port yang ingin kamu forward (port inside container)"
        read -p "Input port : " port_container_2
        echo ""
        echo "Masukkan port host machine (port outside container)"
        read -p "Input port : " port_host_2
        echo ""

        # Validasi port container
        if check_port_container ${port_container_2}; then
            echo -e "${GREEN}Port container is valid, continue...${NC}"
            sleep 3
        else
            echo -e "${RED}Port container invalid, please re-enter!${NC}"
            sleep 3
            continue
        fi

        # Validasi port host
        if check_port_host ${port_host_2}; then
            echo -e "${GREEN}Port host is valid, continue...${NC}"
            sleep 3
            break
        else
            echo -e "${RED}Port host is invalid, please re-enter!${NC}"
            sleep 3
            continue
        fi
    done
}

# Konfirmasi apakah lanjut forward port lain
function lanjut_port_forward() {

    while true; do
        clear
        echo "================"
        echo "Create container"
        echo "================"
        echo ""
        echo "Forward port lain?"
        read -p "Yes or No : " yn_lanjut_port_forward
        echo ""

        if [[ "${yn_lanjut_port_forward,,}" == "yes" || "${yn_lanjut_port_forward,,}" == "y" ]]; then
            return 0
        elif [[ "${yn_lanjut_port_forward,,}" == "no" || "${yn_lanjut_port_forward,,}" == "n" ]]; then
            return 1
        else
            echo -e "${RED}Invalid, masukkan pilihan yang benar!${NC}"
            continue
        fi

    done     
}

# Validasi port inside container
function check_port_container() {
    local port=$1

    # Return 1 (failure) if the port input is invalid.
    if [[ -z "$port" ]] || ! [[ "$port" =~ ^[0-9]+$ ]] || (( port < 1 || port > 65535 )); then
        return 1
    fi

    # Cara pakai fungsi nanti
    # check_port_container 80
    # check_port_container 443
    # return exit code 1 atau 0
}

# Validasi port host
function check_port_host() {
    local port=$1

    # Return 1 (failure) if the port input is invalid.
    if [[ -z "$port" ]] || ! [[ "$port" =~ ^[0-9]+$ ]] || (( port < 1 || port > 65535 )); then
        return 1
    fi

    # The `if !` inverts the check. The block now runs if lsof FAILS (i.e., port is available).
    if ! lsof -i :"$port" >/dev/null 2>&1; then
        return 0 # Success: Port is available.
    else
        return 1 # Failure: Port is in use.
    fi

    # Cara pakai fungsi nanti
    # check_port_host 80
    # check_port_host 443
    # return exit code 1 atau 0
}

function pilih_images() {
    clear
    echo "================"
    echo "Create container"
    echo "================"
    echo ""
    echo "Menampilkan daftar container images yang telah di download..."
    sleep 3

    clear

    # buat daftar images podman menjadi array, disimpan ke variabel daftar_podman_images
    mapfile -t daftar_podman_images < <(podman images | tail -n +2 | awk '{print $1}')

    # echo ulang menu atas
    echo "================"
    echo "Create container"
    echo "================"
    echo ""
    echo "Daftar images"
    echo "--------------"
    echo ""
    
    # print pesan yang akan ditampilkan di bawah menu (saat input)
    PS3="Masukkan angka pilihan : "

    # print pilihan menggunakan select
    select img in "${daftar_podman_images[@]}"; do
        if [[ -n "${img}" ]]; then
            echo ""
            echo -e "Container akan dibuat menggunakan image '${GREEN}${img}${NC}'"
            image_pilihan="${img}"
            break
        else
            echo ""
            echo -e "${RED}Input invalid, silahkan masukkan ulang!${NC}"
            sleep 3
        fi
    done
}

function summary_screen() {
    
    # clear
    clear

    echo "================"
    echo "Create container"
    echo "================"
    echo ""
    echo "SUMMARY"
    echo "-------"
    echo ""
    echo -e "Container name    : ${GREEN}${nama_container}${NC}"
    echo -e "Image pilihan     : ${GREEN}${image_pilihan}${NC}"
    echo ""
    echo "Detail port forward (Container --> Host)"
    echo "1.) ${port_container_1} --> ${port_host_1}"
    echo "2.) ${port_container_2} --> ${port_host_2}"
    echo ""
    echo "Yakin sudah benar?"
    echo "Klik 'enter' untuk lanjut. Klik CTRL+C untuk keluar."
    read -p "Pleasa confirm : " confirm_summary
}

##############################################
#### Selesai mendefinisikan fungsi global ####
##############################################

# Section memasukkan nama container
while true; do

    # clear dulu
    clear

    # Menampilkan menu
    input_container_name

    ### Meneruskan nilai nama container
    if is_valid_podman_container_name "$nama_container"; then
        echo -e "${GREEN}'$nama_container' is a valid name.${NC}"
        sleep 3
        break
    else
        echo -e "${RED}'$nama_container' is NOT a valid name.${NC}"
        sleep 3
    fi

done

# Section port forwarding
while true; do

    # clear dulu
    clear

    # Menampilkan menu
    menu_tanya_forward_port

    # if-else apakah mau port forward
    if [[ "${yn_portforward,,}" == "yes" || "${yn_portforward,,}" == "y" ]]; then
        
        # Tampilkan menu pertama
        menu_input_port_1
        
        # if-else lanjut atau tidak
        if lanjut_port_forward; then
            menu_input_port_2
        fi

        # selesai
        break

    elif [[ "${yn_portforward,,}" == "no" || "${yn_portforward,,}" == "n" ]]; then
        break
    else
        echo ""
        echo -e "${RED}Invalid, masukkan pilihan yang benar!${NC}"
        sleep 3
    fi

done

# Section memilih daftar podman images yang telah di download
pilih_images

# Section untuk mengkonfirmasi detail container yang akan dibuat
summary_screen