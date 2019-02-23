#!/bin/bash
#qq 1969679546
#brief 移动小球
#date 2017.10.1
#y为行，x为列
#linux中2列的像素等于1行的像素


qiu_x=15 #小球的竖
qiu_y=30 #小球的横
hua=0

p_exit() {
echo -e "\033[?25h"    #显示光标
stty echo    #显示输出内容
exit
}

trap "p_exit;" INT TERM    #当按ctl+c强制退出则执行p_exit函数内容


qiu_clear() {
if [ $hua -eq 1 ];then
    echo -e "\033["40"m\033[${qiu_x};${qiu_y}H       \033[0m"
fi
}

shang() { #向上移动先把原来坐标小点抹去，把x轴-1
    qiu_clear
    let qiu_x-=1
    echo -e "\033["41"m\033[${qiu_x};${qiu_y}H  \033[0m"
}

xia() {
    qiu_clear
    let qiu_x+=1
    echo -e "\033["41"m\033[${qiu_x};${qiu_y}H  \033[0m"
}

zuo() {
    qiu_clear
    let qiu_y-=2 #像素问题
    echo -e "\033["41"m\033[${qiu_x};${qiu_y}H  \033[0m"
}

you() {
    qiu_clear
    let qiu_y+=2
    echo -e "\033["41"m\033[${qiu_x};${qiu_y}H  \033[0m"
}



#脚本主体
clear

echo -e "\033[?25l" #隐藏光标
stty -echo #隐藏输入

echo -e "\033["37"m\033[1;1H wasd移动,按空格切换绘画模式,p退出\033[0m"

echo -e "\033["41"m\033[${qiu_x};${qiu_y}H  \033[0m" #先显示一遍小点

while [ 1 ] #支持大小写操作
do
    read -s -n 1 option
    if [[ $option == "w" || $option == "W" ]];then
        shang
    elif [[ $option == "s" ||  $option == "S" ]];then
        xia
    elif [[ $option == "a" ||  $option == "A" ]];then
        zuo
    elif [[ $option == "d" ||  $option == "D" ]];then
        you
    elif [[ "[$option]" == "[]" ]];then #按空格绘制
        if [ $hua -eq 1 ];then
            hua=0
        else
            hua=1
        fi
    elif [[ $option == "p" ||  $option == "P" ]];then
        p_exit
    fi
done
