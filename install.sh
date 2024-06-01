#!/bin/bash

# ⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⡿⠻⣟⣻⣻⠿⣿⣿⣿⣿⣿⣿⣿⣿  _____ ____ ____  ___ ____  _  _   
# ⣿⣿⣿⣿⣿⣿⣿⢿⣿⣾⣿⣿⣿⣷⣜⢉⣟⣾⡷⣽⡻⣿⣿⣿⣿⣿ | ____/ ___|___ \( _ ) ___|| || |  
# ⣿⣿⣿⣿⣿⡿⣡⣾⣿⣿⣿⣿⡿⢿⣿⣷⡩⡽⣛⢷⣿⡪⡻⣿⣿⣿ |  _|| |     __) / _ \___ \| || |_ 
# ⣿⣿⣿⣿⡟⡾⡋⣼⣿⡿⠛⣩⣾⣿⡿⣫⣶⣿⡾⣿⣮⣿⡦⡙⣿⣿ | |__| |___ / __/ (_) |__) |__   _|
# ⣿⣿⣿⣿⢁⠞⣼⡏⡷⣡⡬⡿⣹⡿⣹⣿⢹⣧⢿⢨⡹⢨⡺⢷⡹⣿ |_____\____|_____\___/____/   |_|  
# ⣿⣿⣿⡟⢪⣸⣿⠸⣉⡟⠜⡵⡟⣼⣿⡇⣿⣿⣿⢸⡍⣔⢸⣸⢷⢹ -----------------------------------
# ⣿⣿⣿⣷⣎⠟⢸⣸⣭⠁⡞⣁⡇⣿⡿⣹⣿⣿⡻⠀⡇⣿⠎⢼⠺⢸ Ewa (EC2854)
# ⣿⣿⣿⣿⡛⠸⡇⢹⡏⠀⠈⠭⠘⡘⢣⠟⢡⠃⠑⠀⢸⠏⠚⠘⡆⣸ https://github.com/EC2854
# ⣿⣿⣿⣿⣷⡀⠩⡸⠁⢲⣤⣼⣷⠃⣀⡄⣠⣀⣸⠆⠀⠀⡄⣸⣷⣿ https://www.reddit.com/user/EC2854
# ⣿⣿⣿⣿⣿⣿⡦⠀⠨⡂⠨⣛⣧⣾⣯⢾⣿⣛⠁⠀⠀⠀⣿⣿⣿⣿ -----------------------------------
# ⣿⣿⣿⣿⣿⡿⣡⣶⣿⣷⣶⡌⣙⣛⣓⣾⡭⠁⠀⠀⢠⢰⣿⣿⣿⣿ Install script for https://github.com/EC2854/Hyprland-Dots
# ⣿⣿⣿⡿⢏⣾⣿⣿⣿⣿⣿⣷⠘⠿⣻⣥⡀⣀⣴⣧⣿⣿⣿⣿⣿⣿
# ⣿⣟⣽⠊⣾⠟⠀⢀⢹⣿⣿⣿⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
# ⡿⠾⠇⠀⣿⡐⣨⣧⣾⣿⣿⡇⠈⢻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
# ⡗⡟⠀⠀⣿⣿⣾⣿⣿⣿⠉⢰⡄⠘⢷⣮⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿

# Print Functions
print_message() {
    local color="$1"
    local marker="$2"
    local message="$3"
    echo -e "\e[1;${color}m[${marker}] \e[0m$message\e[0m"
}
## errors
print_error() {
    print_message 31 "ERROR" "$1"  # Red color for errors (31)
}
## warnings
print_warning() {
    print_message 33 "WARNING" "$1"  # Yellow color for warnings (33)
}
## success
print_success() {
    print_message 32 "SUCCESS" "$1"  # Green color for successes (32)
}
## general 
print_info() {
    print_message 36 "INFO" "$1"  # Cyan color for general messages (36)
}

# Install programs (Arch linux only)
not_arch_btw=false # variable to skip installing packages 
packages_to_install=( # list of packages to install
    "hyprland" "swww" "hyprpicker-git" "polkit-gnome" "aylurs-gtk-shell-git" "anyrun-git" "cpio" "sddm" "bc" "hyprwayland-scanner"# important stuff
    "networkmanager" "blueman" 
    "bibata-cursor-theme" "papirus-icon-theme" "papirus-folders-catppuccin-git" "ttf-jetbrains-mono-nerd" # Themes
    "totem" "loupe" "amberol" "nautilus" "gnome-control-center" # Gnome Stuff
    "zsh" "eza" "bat" "ripgrep" "fzf" "yazi" "foot" "neovim" "fastfetch" "starship" # terminal stuff
) 
install_packages() {
    print_info "installing packages"
    paru -S --noconfirm ${packages_to_install[@]}
}

# clone function
clone_repository() {
    local repository_url="$1"
    local destination="$2"

    print_info "Cloning $repository_url..."
    git clone --quiet "$repository_url" "$destination" && print_success "Cloned $destination successfully" && print_error "Error cloning $repository_url to $destination"
}
# copy function
copy_folder() {
    local source=("$1"/*)  # Capture the list of files and directories
    local destination="$2"

    ls "$destination" &>/dev/null || mkdir -p $destination

    print_info "Copying files from $1 to $destination"
    cp -f "${source[@]}" "$destination" && print_success "Files copied successfully to $destination" || print_error "Error while copying to $destination"
}
copy_files() {
    local source=$1 
    local destination="$2"

    print_info "Copying files from $1 to $destination"
    cp -f "$source" "$destination" && print_success "Files copied successfully to $destination" && print_error "Error while copying to $destination"
}
# Install Hyprland Plugins
install_plugin() {
    local name=$1
    
    hyprpm add $name && print_success "$name installed successfully" || print_error "Error while installing $name"
}
#Install Kitty Plugins
# clone_kitty() {
#     local  repository_url=$1
#     
#     print_info "Creating tmp folder"
#     mkdir ./tmp && print_success "Folder Created successfully" # create tmp folder
# 
#     print_info "Cloning $repository_url..."
#     git clone --quiet "$repository_url" && print_success "Cloned $repository_url successfully" && print_error "Error cloning $repository_url"
#     print_info "Moving .py files to ~/.config/kitty/"
#     mv -f ./tmp/*.py ~/.config/kitty/ && print_success "Files moved successfully" || print_error "Error moving files"
# 
#     print_info "Removing tmp folder"
#     rm -rf "./tmp" && print_success "Folder removed successfully" # remove tmp folder
# }

# confirmation
ask_for_confirmation() {
    print_warning "Caution: This script overwrites config files. Change resolution in ./config/hypr/hyprland.conf. RTFM: https://wiki.hyprland.org/Configuring/Monitors/"
    read -p "Do you want to continue? (y/n): " choice
    case "$choice" in 
        y|Y ) return 0 ;; # Continue
        n|N ) exit 0 ;;   # Exit script
        * ) 
            echo "Invalid choice. Please enter 'y' or 'n'."
            ask_for_confirmation ;;
    esac
}
# Check Distro
command -v  pacman &>/dev/null || print_warning "This script is intended for Arch Linux. You can still run this script, but it won't install any packages." && not_arch_btw=true

# Check for paru
command -v paru &>/dev/null || print_warning "paru not found. You can still run this script, but it won't install any packages." && not_arch_btw=true

# Check for internet connection
ping -q -c 1 -W 1 github.com &>/dev/null || print_error "No internet connection. Exiting..." && exit 1

# Check Folder
ls $(pwd)/install.sh &>/dev/null || print_error "Please open folder with this script before running it" && exit 1

# Ask for confirmation before continuing
ask_for_confirmation


if [[ $not_arch_btw == false ]]; then
    install_packages
fi

# Copy files to ~/.config directory
copy_folder ./.config ~/.config/

# Copy .zshrc
copy_files ./.zshrc ~/
# Copy Bashrc
copy_files ./.bashrc ~/

# Clone zsh plugins
clone_repository https://github.com/Aloxaf/fzf-tab ~/.config/zsh/fzf-tab
clone_repository https://github.com/zsh-users/zsh-autosuggestions.git ~/.config/zsh/zsh-autosuggestions
clone_repository https://github.com/zsh-users/zsh-history-substring-search.git ~/.config/zsh/zsh-history-substring-search
clone_repository https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting

# Install Kitty plugins
# clone_kitty https://github.com/knubie/vim-kitty-navigator
# clone_kitty https://github.com/yurikhan/kitty-smart-tab

# Copy Wallpapers
copy_folder ./Wallpapers ~/Pictures/Wallpapers/

# Quick fix for gtk 4
ln -sf /usr/share/themes/Catppuccin-Mocha-Standard-Mauve-Dark/gtk-4.0 $HOME/.config/gtk-4.0

# Hyprland Plugins
print_info "Plugins time!"
print_warning "this part can fail. i don't know what to do about it."
print_info "if it will fail install hyprland-plugins and Hyprspace plugins manually"

install_plugin https://github.com/hyprwm/hyprland-plugins
install_plugin https://github.com/KZDKM/Hyprspace

# Final message
print_info "That's it! Uncopied stuff is: web folder"
print_info "Reboot ur system :3"
print_warning "Run 'hyprpm enable Hyprspace' after installation"
