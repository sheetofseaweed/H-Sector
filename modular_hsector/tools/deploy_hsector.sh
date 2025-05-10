#!/bin/bash

# This script will deploy our modular icon assets so iconforge can use them in spritesheet generation

mkdir -p \
    $1/modular_hsector/icons \
    $1/modular_hsector/code/datums/greyscale/json_configs

cp -r modular_hsector/icons/* $1/modular_hsector/icons/
cp -r modular_hsector/code/datums/greyscale/json_configs/* $1/modular_hsector/code/datums/greyscale/json_configs/
