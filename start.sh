#!/bin/bash
# Attribution: Nat Tuck's Lecture 8 
export MIX_ENV=prod
export PORT=4801

CFGD=$(readlink -f ~/.config/hangman)

if [ ! -e "$CFGD/base" ]; then
    echo "Need to deploy first"
    exit 1
fi

SECRET_KEY_BASE=$(cat "$CFGD/base")
export SECRET_KEY_BASE

_build/prod/rel/bulls/bin/bulls start