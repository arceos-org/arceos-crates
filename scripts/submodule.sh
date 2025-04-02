#!/bin/bash

cmd=$1

if [ -z $cmd ]; then
    echo "Usage: $0 <init|pull>"
    exit 1
fi

ROOT=https://github.com/arceos-org
REPOS=(
    "allocator"
    "arm_gicv2"
    "arm_pl011"
    "arm_pl031"
    "axdriver_crates"
    "axerrno"
    "axfs_crates"
    "axio"
    "axmm_crates"
    "cap_access"
    "cpumask"
    "crate_interface"
    "ctor_bare"
    "dw_apb_uart"
    "flatten_objects"
    "handler_table"
    "int_ratio"
    "kernel_guard"
    "kspin"
    "lazyinit"
    "linked_list"
    "page_table_multiarch"
    "percpu"
    "riscv_goldfish"
    "riscv_plic"
    "scheduler"
    "slab_allocator"
    "timer_list"
    "tuple_for_each"
    "x86_rtc"
)

mkdir -p crates

for repo in ${REPOS[@]};
do
    if [ $cmd == "init" ]; then
        git submodule add $ROOT/$repo.git crates/$repo
    elif [ $cmd == "pull" ]; then
        pushd crates/$repo > /dev/null
        git pull origin main
        popd > /dev/null
    else
        echo "Invalid command: $cmd"
        exit 1
    fi
done
