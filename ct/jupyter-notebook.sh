#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/dave-code-creater/ProxmoxVE/refs/heads/jupyter_notebook/misc/build.func)
# Copyright (c) 2021-2025 community-scripts ORG
# Author: Dave-code-creater (Tan Dat, Ta)
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE
# Source: https://jupyter.org/

# App Default Values
APP="Jupyter Notebook"
# Name of the app (e.g. Google, Adventurelog, Apache-Guacamole"
TAGS="ai;dev-tools"
# Tags for Proxmox VE, maximum 2 pcs., no spaces allowed, separated by a semicolon ; (e.g. database | adblock;dhcp) 
var_cpu="2"
# Number of cores (1-X) (e.g. 4) - default are 2
var_ram="2048"
# Amount of used RAM in MB (e.g. 2048 or 4096)
var_disk="4"
# Amount of used disk space in GB (e.g. 4 or 10)
var_os="ubuntu"
# Default OS (e.g. debian, ubuntu, alpine)
var_version="22.04"
# Default OS version (e.g. 12 for debian, 24.04 for ubuntu, 3.20 for alpine)
var_unprivileged="[UNPRIVILEGED]"
# 1 = unprivileged container, 0 = privileged container

header_info "$APP"
variables
color
catch_errors

function update_script() {
    header_info
    check_container_storage
    check_container_resources

    # Check if installation is present | -f for file, -d for folder
    if [[ ! -f /etc/apt/sources.list.d/jupyter-notebook.list ]]; then
        msg_error "No ${APP} Installation Found!"
        exit
    fi
    
    msg_info "Updating ${APP} LXC"
    apt-get update &>/dev/null
    apt-get install -y jupyter-notebook &>/dev/null
    msg_ok "Updated Successfully"
    exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${CREATING}${GN}${APP} setup has been successfully initialized!${CL}"
echo -e "${INFO}${YW} Access it using the following URL:${CL}"
echo -e "${TAB}${GATEWAY}${BGN}http://${IP}:8888${CL}"