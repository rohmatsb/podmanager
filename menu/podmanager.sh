# Clear whatever in the screen
clear

# Store value 
script_version="1.0"

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
echo "==============="
echo ""
echo "CTRL + C to exit"