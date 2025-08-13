#!/bin/bash
set -e  # Exit on any error

# Colors
GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[0m"

echo -e "${BLUE}=== Installing Windsurf ===${RESET}"

# Step 1: Install prerequisites
echo -e "${GREEN}[*] Installing wget and gpg...${RESET}"
sudo apt-get update -y
sudo apt-get install -y wget gpg apt-transport-https

# Step 2: Download and add GPG key
echo -e "${GREEN}[*] Downloading GPG key...${RESET}"
wget -qO- "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" \
    | gpg --dearmor > windsurf-stable.gpg

echo -e "${GREEN}[*] Installing GPG key...${RESET}"
sudo install -D -o root -g root -m 644 windsurf-stable.gpg /etc/apt/keyrings/windsurf-stable.gpg
rm -f windsurf-stable.gpg

# Step 3: Add repository
echo -e "${GREEN}[*] Adding Windsurf repository...${RESET}"
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/windsurf-stable.gpg] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" \
    | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null

# Step 4: Update package list
echo -e "${GREEN}[*] Updating package list...${RESET}"
sudo apt-get update -y

# Step 5: Install Windsurf
echo -e "${GREEN}[*] Installing Windsurf...${RESET}"
sudo apt-get install -y windsurf

echo -e "${BLUE}=== Windsurf installation complete! ===${RESET}"
