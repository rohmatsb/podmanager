# Update terlebih dahulu
sudo apt update

# Install paket yang dibutuhkan
sudo apt install podman uidmap -y

# Mengunduh file yang dibutuhkan
# wget file1
# wget file2
# wget file3

# Pindahkan file sekalian rename, ke $HOME/podmanager/bin
# mv file1
# mv file2
# mv file3

# Chmod semua file
# chmod file1
# chmod file2
# chmod file3

# Masukkan direktori bin podmanager ke PATH
# echo export path ke $HOME/.profile

clear
echo "Setup sudah selesai, ketik 'podmanager' untuk membuka menu."
