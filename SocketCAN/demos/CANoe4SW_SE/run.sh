#!/bin/bash
script_root=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
canoe4sw_se_install_dir="/home/vector/canoe4sw-se_17.3.91/"

#run tests
$canoe4sw_se_install_dir/canoe4sw-se "$script_root/Default.venvironment" -d "$script_root/working-dir" --verbosity-level "2" --test-unit "$script_root/TestUnit.vtestunit"  --show-progress "tree-element"
