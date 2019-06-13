@echo off
title NBUT Network Utility v1.1 - By Tianao

goto menu
:menu
echo Copyright by Tianao. All rights reserved.
echo ��ӭʹ����������ѧԺУ԰��ʵ�ù���
echo.
echo �����޸�������ʹ�ù���Ա������У���δ�Թ���Ա������У������ȹرձ����ߣ����Ҽ������ҵ�ͼ�꣬ѡ���Թ���Ա������У�
echo.
echo 1 �����Ϣ�ռ�������߼��û�����ͨ�û�������ά����ʦ������רҵ��ʿָ����ʹ�ã�
echo.
echo 2 �����޸������������������� TCP/IPv4 Э��ջ����ͨ�� DHCP �Զ����ã�����ʹ����ѡ������ᴥ����Ҫ���ã���ʮ�ֱ��صĲ�����
echo.
echo 3 ����޸������� Winsock Ŀ¼�� TCP/IP Э��ջ��Ȼ������ Windows���ᶪʧ�ѱ�����������磨����������װ����� Windows ���´���������/��ѧ���⣬Ҳ������Ϊ��װϵͳǰ�ĳ��ԣ��߼��û���ע�� Winsock Ŀ¼�䶯��Ӧ�ó��������Ӱ�죩
echo.
echo 4 ��У԰����¼ҳ�棨������ Captive Portal �쳣ʱ��˵�˻����ǵ�������¼ҳ�棩
echo.
set /p option=������������ź󰴻س���ִ��: 
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
echo �������������ɣ���ϳ���δ�����ļ����ִ���κ��޸ġ�
echo �뽫����������ơ���ͼ�����ո���ά����ʦ���������ʦҪ�����ִ�и߼�����밴�������
pause
cls
echo Starting Advanced Diagnostics...

tracert 223.5.5.5

echo.
echo �߼����������ɣ���ϳ���δ�����ļ����ִ���κ��޸ġ�
echo �뽫����������ơ���ͼ�����ո���ά����ʦ��
pause
exit

:fastrepair
cls
netsh interface show interface
set /p interface=��������޸����������������ƣ�����������������̫���򱾵����ӣ��������ֲ���ʡ�ԣ������س������: 
echo.
echo �趨�ӿڵ�ַ��Դʹ�� DHCP
netsh interface ip set address name="%interface%" source=dhcp
echo �趨�ӿ� DNS ��Դʹ�� DHCP
netsh interface ip set dnsservers name="%interface%" source=dhcp
echo �ͷ����������������� IPv4 ��ַ
ipconfig /release *
echo �ػ����������������� IPv4 ��ַ
ipconfig /renew *
echo ˢ��ϵͳ DNS ����
ipconfig /flushdns
echo.
echo �ѳ���ִ�п����޸�����У԰����¼ҳ��
start "" "http://10.23.4.165"
pause
exit



:deeprepair
cls
netsh winsock reset
netsh int ip reset
echo ������������������� Windows�������������ٴγ���ʹ��У԰��������������Ҫ�ֶ��������ӡ�
pause
shutdown /r /t 0 /f

:portal
start "" "http://10.23.4.165"