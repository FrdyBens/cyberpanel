#!/bin/bash

echo "Initialized...

CyberPanel Installer v2.3.5"

# Prompt for Full Service components
read -p "Install Full Service (PowerDNS, Postfix, Pure-FTPd)? [Y/n]: " full_service
full_service=${full_service:-Y}  # Default to Y if no input

# Prompt for Remote MySQL
read -p "Enable Remote MySQL? [y/N]: " remote_mysql
remote_mysql=${remote_mysql:-N}  # Default to N if no input

# Prompt for CyberPanel Version
read -p "CyberPanel Version (default Latest Version): " cyberpanel_version
cyberpanel_version=${cyberpanel_version:-Latest Version}  # Default to "Latest Version" if no input

# Prompt for Memcached
read -p "Enable Memcached? [y/N]: " memcached
memcached=${memcached:-N}  # Default to N if no input

# Prompt for Redis
read -p "Enable Redis? [y/N]: " redis
redis=${redis:-N}  # Default to N if no input

# Prompt for Watchdog
read -p "Enable Watchdog? [Y/n]: " watchdog
watchdog=${watchdog:-Y}  # Default to Y if no input

# Prompt for CyberPanel installation type
read -p "
CyberPanel Installer v2.3.5

RAM check : 185/3863MB (4.79%)
Disk check : 1/78GB (2%) (Minimal 10GB free space)

1. Install CyberPanel with OpenLiteSpeed.
2. Install CyberPanel with LiteSpeed Enterprise.
3. Exit.

Please enter the number[1-3]: " cyberpanel_option

case $cyberpanel_option in
    1)
        install_type="OpenLiteSpeed"
        ;;
    2)
        install_type="LiteSpeed Enterprise"
        ;;
    3)
        echo "Exiting CyberPanel installation."
        exit 0
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
esac

# Installation command with selected options
sudo su - -c "sh <(curl https://cyberpanel.net/install.sh || wget -O - https://cyberpanel.net/install.sh) -s ${full_service} -r ${remote_mysql} -v '${cyberpanel_version}' -m ${memcached} -e ${redis} -w ${watchdog} --${install_type}"
