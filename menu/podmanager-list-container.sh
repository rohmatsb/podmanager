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
 # var1=''
 # var2=''

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

    mapfile -t daftar_podman_container < <(podman ps -a --format "{{.Names}}")
    
}