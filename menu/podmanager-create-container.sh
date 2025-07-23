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
        echo "Error: Name cannot be empty."
        return 1
    fi

    # 2. Check length
    if [[ ${#name} -gt $max_length ]]; then
        echo "Error: Name '$name' is too long (max $max_length characters)."
        return 1
    fi

    # 3. Check allowed characters and start character
    # Regex: Must start with alphanumeric, followed by alphanumeric, hyphens, underscores, or dots.
    if [[ ! "$name" =~ ^[a-zA-Z0-9][a-zA-Z0-9_.-]*$ ]]; then
        echo "Error: Name '$name' contains invalid characters or has an invalid start."
        echo "Allowed: alphanumeric, hyphens, underscores, dots. Must start with alphanumeric."
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
    echo "'$nama_container' is a valid name."
    else
    echo "'$nama_container' is NOT a valid name."
    fi

done