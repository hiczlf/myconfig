#!/usr/bin/env bash

function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"
    # 如果文件存在， 且是符号链接, 则删除链接
    if [ -L "${target}" ]; then
        unlink $target
    fi
    if [ -e "${target}" ] && [ ! -L "${target}" ]; then
        mv $target $target.df.bak
    fi

    ln -sf ${source} ${target}
}

function unlink_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"
    
    if [ -e "${target}.df.bak" ] && [ -L "${target}" ]; then
        unlink ${target}
        mv $target.df.bak $target
    elif [ -L "${target}" ]; then
        # 处理以前个人目录没有相应配置文件的情况
        rm ${target}
    fi
}


if [ "$1" = "restore" ]; then
    for i in _*
    do 
        unlink_file $i
    done
    exit
else
    for i in _*
    do
        link_file $i
    done
fi
