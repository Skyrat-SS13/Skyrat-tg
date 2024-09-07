#!/bin/bash
set -euo pipefail

source dependencies.sh

if [[ -e ~/.nvm/nvm.sh ]]; then
	source ~/.nvm/nvm.sh
<<<<<<< HEAD
	nvm install $NODE_VERSION
	nvm use $NODE_VERSION
=======
	nvm install $NODE_VERSION_COMPAT
	nvm use $NODE_VERSION_COMPAT
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
fi
