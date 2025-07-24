# Color
NC='\e[0m' # No Color (reset)
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
MAGENTA='\e[0;35m'
CYAN='\e[0;36m'
WHITE='\e[0;37m'

# Menggunakan while-true agar terjadi pengulangan jika nilai yang dimasukkan pengguna salah
while true; do

    # clear dulu
    clear

    # Menampilkan menu
    echo "========"
    echo "Create container"
    echo "========"
    echo ""
    read -p "Enter container name : " nama_container
    echo ""
    
    ### Validasi nama container
    function is_valid_podman_container_name() {
    local name="$1"
    local max_length=63

    # 1. Check for empty input
    if [[ -z "$name" ]]; then
        echo -e "${RED}Error: Name cannot be empty.${RED}"
        echo ""
        return 1
    fi

    # 2. Check length
    if [[ ${#name} -gt $max_length ]]; then
        echo -e "${RED}Error: Name '$name' is too long (max $max_length characters).${RED}"
        echo ""
        return 1
    fi

    # 3. Check allowed characters and start character
    # Regex: Must start with alphanumeric, followed by alphanumeric, hyphens, underscores, or dots.
    if [[ ! "$name" =~ ^[a-zA-Z0-9][a-zA-Z0-9_.-]*$ ]]; then
        echo -e "${RED}Error: Name '$name' contains invalid characters or has an invalid start."
        echo -e "Allowed: alphanumeric, hyphens, underscores, dots. Must start with alphanumeric.${RED}"
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

    ### Meneruskan nilai nama container
    if is_valid_podman_container_name "$nama_container"; then
    echo -e "${GREEN}'$nama_container' is a valid name.${GREEN}"
    sleep 5
    break
    else
    echo -e "${RED}'$nama_container' is NOT a valid name.${RED}"
    sleep 5
    fi

done