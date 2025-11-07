# Update terlebih dahulu
sudo apt update

# Install paket yang dibutuhkan
sudo apt install podman uidmap slirp4netns -y

# Mengunduh file yang dibutuhkan
wget https://raw.githubusercontent.com/rohmatsb/podmanager/main/menu/podmanager-create-container.sh
wget https://raw.githubusercontent.com/rohmatsb/podmanager/main/menu/podmanager-del-container.sh
wget https://raw.githubusercontent.com/rohmatsb/podmanager/main/menu/podmanager-del-images.sh
wget https://raw.githubusercontent.com/rohmatsb/podmanager/main/menu/podmanager-enter-container.sh
wget https://raw.githubusercontent.com/rohmatsb/podmanager/main/menu/podmanager-list-container.sh
wget https://raw.githubusercontent.com/rohmatsb/podmanager/main/menu/podmanager-list-images.sh
wget https://raw.githubusercontent.com/rohmatsb/podmanager/main/menu/podmanager-pull-images.sh
wget https://raw.githubusercontent.com/rohmatsb/podmanager/main/menu/podmanager.sh

# Pindahkan file sekalian rename, ke $HOME/podmanager/bin
mv podmanager-create-container.sh "$HOME/podmanager/bin/podmanager-create-container"
mv podmanager-del-container.sh "$HOME/podmanager/bin/podmanager-del-container"
mv podmanager-del-images.sh "$HOME/podmanager/bin/podmanager-del-images"
mv podmanager-enter-container.sh "$HOME/podmanager/bin/podmanager-enter-container"
mv podmanager-list-container.sh "$HOME/podmanager/bin/podmanager-list-container"
mv podmanager-list-images.sh "$HOME/podmanager/bin/podmanager-list-images"
mv podmanager-pull-images.sh "$HOME/podmanager/bin/podmanager-pull-images"
mv podmanager.sh "$HOME/podmanager/bin/podmanager"

# Chmod semua file
chmod 700 "$HOME/podmanager/bin/podmanager-create-container"
chmod 700 "$HOME/podmanager/bin/podmanager-del-container"
chmod 700 "$HOME/podmanager/bin/podmanager-del-images"
chmod 700 "$HOME/podmanager/bin/podmanager-enter-container"
chmod 700 "$HOME/podmanager/bin/podmanager-list-container"
chmod 700 "$HOME/podmanager/bin/podmanager-list-images"
chmod 700 "$HOME/podmanager/bin/podmanager-pull-images"
chmod 700 "$HOME/podmanager/bin/podmanager"

# Masukkan direktori bin podmanager ke PATH
echo 'export PATH="$HOME/podmanager/bin:$PATH"' >> ~/.profile

# Finish
clear
echo "Setup sudah selesai, ketik 'podmanager' untuk membuka menu."
