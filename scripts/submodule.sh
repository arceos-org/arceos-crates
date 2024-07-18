#!/bin/bash

ORG=arceos-org

repos=(
    "allocator"
    "arm_gicv2"
    "arm_pl011"
    "arm_pl031"
    "axdriver_crates"
    "axerrno"
    "axfs_crates"
    "axio"
    "cap_access"
    "crate_interface"
    "dw_apb_uart"
    "flatten_objects"
    "handler_table"
    "int_ratio"
    "kernel_guard"
    "kspin"
    "lazyinit"
    "memory_addr"
    "page_table_multiarch"
    "percpu"
    "riscv_goldfish"
    "scheduler"
    "slab_allocator"
    "timer_list"
    "tuple_for_each"
    "x86_rtc"
)

mkdir -p crates

for repo in ${repos[@]};
do
    git submodule add https://github.com/$ORG/$repo.git crates/$repo
done
