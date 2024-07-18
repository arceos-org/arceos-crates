#!/bin/bash

ROOT=https://github.com/arceos-org
CRATES=(
    "allocator"
    "arm_gicv2"
    "arm_pl011"
    "arm_pl031"
    "axdriver_base"
    "axdriver_block"
    "axdriver_display"
    "axdriver_net"
    "axdriver_pci"
    "axdriver_virtio"
    "axerrno"
    "axfs_devfs"
    "axfs_ramfs"
    "axfs_vfs"
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
    "page_table_entry"
    "page_table_multiarch"
    "percpu"
    "percpu_macros"
    "riscv_goldfish"
    "scheduler"
    "slab_allocator"
    "timer_list"
    "tuple_for_each"
    "x86_rtc"
)


echo '| Crate | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[crates.io](crates.io)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Documentation | Description |'
echo '|----|:--:|:--:|----|'

for c in ${CRATES[@]};
do
    if [[ $c == axdriver* ]]; then
        repo="axdriver_crates"
        subcrate=1
    elif [[ $c == axfs* ]]; then
        repo="axfs_crates"
        subcrate=1
    elif [[ $c == page_table* ]]; then
        repo="page_table_multiarch"
        subcrate=1
    elif [[ $c == percpu* ]]; then
        repo="percpu"
        subcrate=1
    else
        repo="$c"
        subcrate=0
    fi

    if [[ $subcrate == 0 ]]; then
        url="$ROOT/$c"
        toml="crates/$repo/Cargo.toml"
    else
        url="$ROOT/$repo/tree/main/$c"
        toml="crates/$repo/$c/Cargo.toml"
    fi

    description=`cat $toml | sed -n 's/^description = "\([^"]*\)"/\1/p'`
    if [[ $description != *. ]]; then
        description+="."
    fi

    if [[ `curl -s https://crates.io/api/v1/crates/$c | grep arceos-org` ]]
    then
        # In crates.io
        crates_io="[![Crates.io](https://img.shields.io/crates/v/$c)](https://crates.io/crates/$c)"
        doc="[![Docs.rs](https://docs.rs/$c/badge.svg)](https://docs.rs/$c)"
    else
        # Not in crates.io
        crates_io="N/A"
        if [[ $subcrate == 1 ]]; then
            doc_url="https://arceos-org.github.io/$repo/$c"
        else
            doc_url="https://arceos-org.github.io/$c"
        fi
        doc="[![Docs.rs](https://img.shields.io/badge/docs-pages-green)]($doc_url)"
    fi
    echo "| [$c]($url) | $crates_io | $doc | $description |"
done
