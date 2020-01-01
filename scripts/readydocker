#!/usr/bin/env bash

###############################################################
# Ready Docker
###############################################################
#
# Ensure Docker.app is running and ready to bring containers up
#
# Designed to be used in environments where you want to bring
# up a container without human interaction.
#
# Example Usage:
#
# readydocker && docker-compose up -d
#
# Expectations:
#
# - Docker should be located at /Applications/Docker.app
# - /tmp/ should be writable
# - docker command should be on $PATH

##############################################################
# Checks if another readydocker is running
##############################################################
lock_exists() { [[ -e /tmp/readydocker.lock ]]; }

##############################################################
# Adds lock
##############################################################
add_lock() { touch /tmp/readydocker.lock; }

##############################################################
# Removes a lock if it exists
##############################################################
remove_lock() {
    if lock_exists ; then
        rm /tmp/readydocker.lock
    fi
}

###############################################################
# Runs when the script exits but only if lock has been obtained
###############################################################
exit_script() {
    remove_lock
    # Clear trap
    trap - SIGINT SIGTERM
    kill -- -$$
}

##############################################################
# Returns the status code of docker stats which will be 0
# if successful
##############################################################
is_docker_ready() { docker stats --no-stream >/dev/null 2>&1; }

# Check for another readydocker
if lock_exists ; then
    echo "Waiting for another readydocker process to release lock"

    # Wait until another process has released the lock
    while lock_exists ; do
        echo -n "."
        sleep 1
    done

    # Final newline
    echo ""
fi

# Register traps
trap exit_script SIGINT SIGTERM
trap remove_lock EXIT

# Adds lock to work with concurrent readydocker commands
add_lock

echo "Checking if Docker.app is ready"
if ! is_docker_ready ; then
    echo "Starting Docker.app"
    open /Applications/Docker.app

    while ! is_docker_ready ; do
        echo -n "."
        sleep 1
    done

    # Final newline
    echo ""
fi

echo "Docker.app is ready"
