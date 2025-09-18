#!/usr/bin/env bash

set -euo pipefail

# HEX Proxy Setup Script
# Establishes SSH tunnel with SOCKS proxy

# Function to apply proxy settings to current shell
apply_proxy_to_shell() {
  export http_proxy="socks5h://127.0.0.1:1080"
  export https_proxy="socks5h://127.0.0.1:1080"
  export HTTP_PROXY="socks5h://127.0.0.1:1080"
  export HTTPS_PROXY="socks5h://127.0.0.1:1080"
  echo "✓ Proxy environment variables applied to current shell"
}

clear_screen() {
  if command -v tput >/dev/null 2>&1; then
    tput reset || printf '\033c'
  elif command -v clear >/dev/null 2>&1; then
    clear
  else
    printf '\033[2J\033[H'
  fi
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || return 1
}

print_header() {
  echo ""
  echo "============================================================"
  echo "$1"
  echo "============================================================"
}

abort() {
  echo "Error: $1" >&2
  exit 1
}

print_banner() {
  local MAGENTA CYAN GRAY SEP BOLD RESET
  if [ -t 1 ]; then
    MAGENTA='\033[38;5;141m'  # muted orchid
    CYAN='\033[38;5;81m'     # soft teal
    GRAY='\033[38;5;245m'    # neutral gray text
    SEP='\033[38;5;244m'     # subtle separator
    BOLD='\033[1m'
    RESET='\033[0m'
  else
    MAGENTA=''; CYAN=''; GRAY=''; SEP=''; BOLD=''; RESET=''
  fi

  clear_screen 
  echo ""
  echo -e "${SEP}╔════════════════════════════════════════════════════════════════════════╗${RESET}"
  echo -e "${SEP}║                                                                        ║${RESET}"
  echo -e "${SEP}║   ${MAGENTA}${BOLD}██╗  ██╗███████╗██╗  ██╗  ${CYAN} ██████╗ ██████╗  ██████╗ ██╗  ██╗██╗   ██╗${SEP}║${RESET}"
  echo -e "${SEP}║   ${MAGENTA}${BOLD}██║  ██║██╔════╝╚██╗██╔╝  ${CYAN} ██╔══██╗██╔══██╗██╔═══██╗╚██╗██╔╝╚██╗ ██╔╝${SEP}║${RESET}"
  echo -e "${SEP}║   ${MAGENTA}${BOLD}███████║█████╗   ╚███╔╝   ${CYAN} ██████╔╝██████╔╝██║   ██║ ╚███╔╝  ╚████╔╝ ${SEP}║${RESET}"
  echo -e "${SEP}║   ${MAGENTA}${BOLD}██╔══██║██╔══╝   ██╔██╗   ${CYAN} ██╔═══╝ ██╔══██╗██║   ██║ ██╔██╗   ╚██╔╝  ${SEP}║${RESET}"
  echo -e "${SEP}║   ${MAGENTA}${BOLD}██║  ██║███████╗██╔╝ ██╗  ${CYAN} ██║     ██║  ██║╚██████╔╝██╔╝ ██╗   ██║   ${SEP}║${RESET}"
  echo -e "${SEP}║   ${MAGENTA}${BOLD}╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝  ${CYAN} ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ${SEP}║${RESET}"
  echo -e "${SEP}║                                                                        ║${RESET}"
  echo -e "${SEP}╚════════════════════════════════════════════════════════════════════════╝${RESET}"
  echo -e "${GRAY} Website: https://hexapp.dev${RESET}"
  echo -e "${GRAY} telegram Channel: https://t.me/HEXApp_dev${RESET}"
  echo -e "${GRAY} SSH SOCKS Proxy Setup${RESET}\n"
}

print_banner

# Function to check if port 1080 is already in use
check_port() {
  if lsof -Pi :1080 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "Port 1080 is already in use. Killing existing process..."
    kill $(lsof -Pi :1080 -sTCP:LISTEN -t) 2>/dev/null
    sleep 2
  fi
}

# Function to establish SSH tunnel
establish_tunnel() {
  echo "Establishing SSH tunnel to $USERNAME@$SERVER_IP..."
  
  # Use sshpass to handle password authentication and auto-accept host key
  sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no -D 1080 -q -C -N "$USERNAME@$SERVER_IP" &
  
  # Store the PID of the SSH process
  SSH_PID=$!
  
  # Wait a moment for connection to establish
  sleep 3
  
  # Check if the process is still running
  if kill -0 $SSH_PID 2>/dev/null; then
    echo "✓ SSH tunnel established successfully (PID: $SSH_PID)"
    echo "✓ Tunnel is running in background on port 1080"
    return 0
  else
    echo "✗ Failed to establish SSH tunnel"
    return 1
  fi
}

# Function to set proxy environment variables
set_proxy() {
  echo "Setting proxy environment variables..."
  
  # Set both lowercase and uppercase versions for compatibility
  export http_proxy="socks5h://127.0.0.1:1080"
  export https_proxy="socks5h://127.0.0.1:1080"
  export HTTP_PROXY="socks5h://127.0.0.1:1080"
  export HTTPS_PROXY="socks5h://127.0.0.1:1080"
  
  echo "✓ Proxy settings applied:"
  echo "  http_proxy: $http_proxy"
  echo "  https_proxy: $https_proxy"
  echo "  HTTP_PROXY: $HTTP_PROXY"
  echo "  HTTPS_PROXY: $HTTPS_PROXY"
  echo
  echo "To make these settings permanent, add the following to your ~/.bashrc or ~/.profile:"
  echo "export http_proxy=\"socks5h://127.0.0.1:1080\""
  echo "export https_proxy=\"socks5h://127.0.0.1:1080\""
  echo "export HTTP_PROXY=\"socks5h://127.0.0.1:1080\""
  echo "export HTTPS_PROXY=\"socks5h://127.0.0.1:1080\""
}

# Function to cleanup on exit
cleanup() {
  echo
  echo "Cleaning up..."
  if [ ! -z "$SSH_PID" ]; then
    kill $SSH_PID 2>/dev/null
    echo "✓ SSH tunnel terminated"
  fi
  exit 0
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM

# Install sshpass silently if not present
if ! require_cmd sshpass; then
  echo "Installing sshpass..."
  if require_cmd apt-get; then
    sudo apt-get update -y >/dev/null 2>&1
    sudo apt-get install -y sshpass >/dev/null 2>&1
  elif require_cmd dnf; then
    sudo dnf install -y sshpass >/dev/null 2>&1
  elif require_cmd yum; then
    sudo yum install -y sshpass >/dev/null 2>&1
  elif require_cmd pacman; then
    sudo pacman -Sy --noconfirm sshpass >/dev/null 2>&1
  elif require_cmd brew; then
    brew install sshpass >/dev/null 2>&1
  else
    abort "sshpass is not installed and no package manager found. Please install it manually:
    Ubuntu/Debian: sudo apt-get install sshpass
    CentOS/RHEL: sudo yum install sshpass
    macOS: brew install sshpass"
  fi
  echo "✓ sshpass installed successfully"
fi

# Main menu loop

# Function to show menu
show_menu() {
  echo ""
  echo "============================================================"
  echo "HEX Proxy Menu"
  echo "============================================================"
  echo "1. Configure SSH tunnel"
  echo "2. Remove SSH tunnel"
  echo "3. Exit"
  echo "============================================================"
}

# Function to check if tunnel is running
check_tunnel_status() {
  if lsof -Pi :1080 -sTCP:LISTEN -t >/dev/null 2>&1; then
    SSH_PID=$(lsof -Pi :1080 -sTCP:LISTEN -t)
    return 0
  else
    SSH_PID=""
    return 1
  fi
}

# Function to remove tunnel
remove_tunnel() {
  if check_tunnel_status; then
    echo "Removing SSH tunnel (PID: $SSH_PID)..."
    kill $SSH_PID 2>/dev/null
    sleep 2
    if ! check_tunnel_status; then
      echo "✓ SSH tunnel removed successfully"
    else
      echo "✗ Failed to remove SSH tunnel"
    fi
  else
    echo "No SSH tunnel is currently running"
  fi
}

# Function to configure tunnel
configure_tunnel() {
  if check_tunnel_status; then
    echo "SSH tunnel is already running (PID: $SSH_PID)"
    echo "Do you want to remove it and create a new one? (y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
      remove_tunnel
    else
      return 0
    fi
  fi
  
  # Get user input for server details
  read -rp "Enter server IP address: " SERVER_IP
  read -rp "Enter username (default: root): " USERNAME
  USERNAME=${USERNAME:-root}
  read -rsp "Enter password: " PASSWORD
  echo

  [[ -z "$SERVER_IP" ]] && abort "Server IP cannot be empty."
  [[ -z "$USERNAME" ]] && abort "Username cannot be empty."
  [[ -z "$PASSWORD" ]] && abort "Password cannot be empty."

  # Check if port is available
  check_port

  # Establish SSH tunnel
  if establish_tunnel; then
    # Set proxy environment variables
    set_proxy
    
    # Create a script to source the proxy variables in the current shell
    cat > /tmp/hex_proxy_setup.sh << 'EOF'
export http_proxy="socks5h://127.0.0.1:1080"
export https_proxy="socks5h://127.0.0.1:1080"
export HTTP_PROXY="socks5h://127.0.0.1:1080"
export HTTPS_PROXY="socks5h://127.0.0.1:1080"
echo "✓ Proxy environment variables set in current shell"
EOF
    
    echo ""
    echo "============================================================"
    echo "Setup Complete"
    echo "============================================================"
    echo "✓ SSH tunnel is running in background"
    echo "✓ Proxy is configured and ready to use"
    echo ""
    echo "To apply proxy settings to your current shell, run:"
    echo "source <(echo 'export http_proxy=\"socks5h://127.0.0.1:1080\"; export https_proxy=\"socks5h://127.0.0.1:1080\"; export HTTP_PROXY=\"socks5h://127.0.0.1:1080\"; export HTTPS_PROXY=\"socks5h://127.0.0.1:1080\"')"
    echo ""
    echo "Or simply run:"
    echo "export http_proxy=\"socks5h://127.0.0.1:1080\""
    echo "export https_proxy=\"socks5h://127.0.0.1:1080\""
    echo ""
    echo "To test the proxy, try: curl --proxy socks5h://127.0.0.1:1080 http://httpbin.org/ip"
    echo ""
  else
    abort "Failed to establish SSH tunnel. Please check your credentials and network connection."
  fi
}

# Main menu loop
while true; do
  show_menu
  read -rp "Select an option (1-3): " choice
  
  case $choice in
    1)
      print_header "Configuring SSH tunnel"
      configure_tunnel
      ;;
    2)
      print_header "Removing SSH tunnel"
      remove_tunnel
      ;;
    3)
      echo "Exiting..."
      if check_tunnel_status; then
        echo "SSH tunnel is still running in background (PID: $SSH_PID)"
        echo "To stop it later, run: kill $SSH_PID"
        echo ""
        echo "To apply proxy settings to your current shell, run:"
        echo "export http_proxy=\"socks5h://127.0.0.1:1080\""
        echo "export https_proxy=\"socks5h://127.0.0.1:1080\""
      fi
      exit 0
      ;;
    *)
      echo "Invalid option. Please select 1, 2, or 3."
      ;;
  esac
  
  echo ""
  echo "Press Enter to continue..."
  read -r
done
