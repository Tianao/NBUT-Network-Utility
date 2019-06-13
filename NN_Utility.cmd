@echo off
title NBUT Network Utility v1.1 - By Tianao

goto menu
:menu
echo Copyright by Tianao. All rights reserved.
echo 欢迎使用宁波工程学院校园网实用工具
echo.
echo 部分修复操作需使用管理员身份运行（如未以管理员身份运行，建议先关闭本工具，再右键单击我的图标，选择以管理员身份运行）
echo.
echo 1 诊断信息收集（面向高级用户，普通用户请在运维工程师或其他专业人士指导下使用）
echo.
echo 2 快速修复，命令网络适配器的 TCP/IPv4 协议栈重新通过 DHCP 自动配置（初次使用请选此项，不会触动重要配置，是十分保守的操作）
echo.
echo 3 深度修复，重置 Winsock 目录和 TCP/IP 协议栈，然后重启 Windows，会丢失已保存的无线网络（适用于由新装软件或 Windows 更新带来的疑难/玄学问题，也可以作为重装系统前的尝试，高级用户请注意 Winsock 目录变动对应用程序带来的影响）
echo.
echo 4 打开校园网登录页面（适用于 Captive Portal 异常时，说人话就是弹不出登录页面）
echo.
set /p option=请输入命令序号后按回车键执行: 
if "%option%" == "1" goto diagnostics
if "%option%" == "2" goto fastrepair
if "%option%" == "3" goto deeprepair
if "%option%" == "4" goto portal else (
cls
goto menu
)

:diagnostics
cls
echo Starting NBUT Network Diagnostics...

ver
ipconfig /all

echo.
echo route print -4
route print -4

echo.
echo arp -a
arp -a

ping 127.0.0.1 -n 1
ping 10.23.4.165 -n 3
ping 10.23.4.165 -n 2 -f -l 1472
ping 223.5.5.5 -n 3

echo.
echo nslookup i.nbut.edu.cn
nslookup i.nbut.edu.cn

echo.
echo nslookup i.nbut.edu.cn 10.23.4.149
nslookup i.nbut.edu.cn 10.23.4.149

echo.
echo nslookup www.baidu.com
nslookup www.baidu.com

echo.
echo curl http://captive.apple.com
curl http://captive.apple.com

echo.
echo curl https://captive.apple.com
curl https://captive.apple.com

echo.
echo 快速网络诊断完成，诊断程序未对您的计算机执行任何修改。
echo 请将上述结果复制、截图或拍照给运维工程师，如果工程师要求继续执行高级诊断请按任意键。
pause
cls
echo Starting Advanced Diagnostics...

tracert 223.5.5.5

echo.
echo 高级网络诊断完成，诊断程序未对您的计算机执行任何修改。
echo 请将上述结果复制、截图或拍照给运维工程师。
pause
exit

:fastrepair
cls
netsh interface show interface
set /p interface=请输入待修复的网络适配器名称（有线网络请输入以太网或本地连接，如有数字不可省略），按回车键完成: 
echo.
echo 设定接口地址来源使用 DHCP
netsh interface ip set address name="%interface%" source=dhcp
echo 设定接口 DNS 来源使用 DHCP
netsh interface ip set dnsservers name="%interface%" source=dhcp
echo 释放所有网络适配器的 IPv4 地址
ipconfig /release *
echo 重获所有网络适配器的 IPv4 地址
ipconfig /renew *
echo 刷新系统 DNS 缓存
ipconfig /flushdns
echo.
echo 已尝试执行快速修复并打开校园网登录页面
start "" "http://10.23.4.165"
pause
exit



:deeprepair
cls
netsh winsock reset
netsh int ip reset
echo 按任意键立即重新启动 Windows，请在重启后再次尝试使用校园网，无线网络需要手动重新连接。
pause
shutdown /r /t 0 /f

:portal
start "" "http://10.23.4.165"