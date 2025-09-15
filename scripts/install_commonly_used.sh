#!/bin/bash

install_from_repo() {
  sudo apt update
  sudo apt install -y htop
  sudo apt install -y terminator
  sudo apt install -y flameshot
  sudo apt install -y build-essential
  sudo apt install -y git
  sudo apt install -y openssh-server
  sudo apt install -y curl
  sudo apt install -y cmake-curses-gui
  sudo apt install -y xclip
  sudo apt install -y file-roller
}

#contribution: albert dalmases
install_mouseless(){
  TEMP_DIR=$(mktemp -d)
  script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
  trap 'popd >/dev/null; rm -rf "$TEMP_DIR"' EXIT # ensures temp-dir cleanup even if script fails
  pushd "$TEMP_DIR" >/dev/null

  latest_tag=$(curl -sL https://api.github.com/repos/jbensmann/mouseless/releases/latest | grep -Po '"tag_name":\s*"\K[^"]+')
  latest_ver=${latest_tag#v}
  if command -v mouseless >/dev/null; then 
    current_ver=$(mouseless --version | grep -oP '\d+\.\d+\.\d+' | head -n1)
  else
    current_ver=""
  fi
  
  if [ -z "$current_ver" ] || ! dpkg --compare-versions "$current_ver" ge "$latest_ver"; then
    echo " Installing/Updating mouseless keyboard mouse (version: $latest_tag)" 
    curl -sL "https://github.com/jbensmann/mouseless/releases/download/${latest_tag}/mouseless-linux-amd64.tar.gz" -o "$TEMP_DIR/mouseless.tar.gz" 
    tar -xzf "$TEMP_DIR/mouseless.tar.gz"
    sudo install -Dm755 "$TEMP_DIR/dist/mouseless" "/usr/local/bin/mouseless"
  else
    echo " Mouseless keyboard mouse already installed and up-to-date (version: $latest_tag)"
  fi

  # set it as a systemctl service 
  service_file="/etc/systemd/system/mouseless.service"
  cfg_path="$HOME/.config/mouseless/config.yaml"  

sudo install -Dm644 /dev/stdin "$service_file" <<EOF
[Unit]
Description=Mouseless keyboard mouse 

[Service]
ExecStartPre=/bin/sleep 2
ExecStart=/usr/local/bin/mouseless --config $cfg_path

[Install]
WantedBy=multi-user.target
EOF

# popd
mkdir -pv $HOME/.config/mouseless/
cp -v $script_dir/mouseless_config.yaml $HOME/.config/mouseless/config.yaml

  sudo systemctl daemon-reload
  sudo systemctl --quiet enable --now "$(basename "$service_file")"

}

install_mouseless
