@ECHO OFF
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" ::","","runas",1)(window.close)&&exit
SET bat_name=ADB实用工具
SET bat_auther=80KG
SET bat_version=V1.0
SET bat_date=2022.3.26
SET ADB_PATH=%~dp0/adb.exe
SET BOOTLOADER_PATH=%~dp0/fastboot.exe
SET FLASH_PARTITION=
SET FLASH_PATH=
SET REGPATH=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session""Manager\Environment
TITLE %bat_name% --by %bat_auther% --%bat_version%
:COLOR 3f
CD /d "%~dp0"

:LOGO
ECHO.          %bat_name% %bat_version%
ECHO ********************************************************
ECHO 旨在打造一个实用的ADB工具。
ECHO 脚本发布地址：https:^/^/Github.com/Goal75KG/ADB-Tools
ECHO       ___   ___          ___ 
ECHO      ( _ ) / _ \  /\ /\ / _ \
ECHO      / _ \^| ^| ^| ^|/ //_// /_\/
ECHO     ^| (_) ^| ^|_^| / __ \/ /_\\ 
ECHO      \___/ \___/\/  \/\____/ 
ECHO.
ECHO ********************************************************
ECHO 请按任意键继续
PAUSE>NUL

:MENU
CLS
ECHO.           功能菜单
ECHO.********************************
ECHO.  1.ADB菜单
ECHO.  2.BootLoader菜单
ECHO.  3.一键安装ADB驱动
ECHO.  
ECHO.********************************

SET choice=
SET /p choice=请输入选项对应的数字回车: 
IF not "%choice%"=="" SET choice=%choice:~0,1%
IF /i "%choice%"=="1" GOTO ADB_CHECK
IF /i "%choice%"=="2" GOTO BOOT_MODE
IF /i "%choice%"=="3" GOTO ADB_INSTALL_MODE
ECHO.
ECHO.输入无效，请重新输入...
TIMEOUT /t 1 /nobreak >NUL
ECHO.
GOTO MENU

:ADB_CHECK
CLS
ECHO    正在检查设备是否正常连接...
ECHO.
ECHO.         请确保：
ECHO.   1.手机处于开机状态
ECHO.   2.手机开启USB调试
ECHO.   3.电脑上已经正确安装驱动
ECHO.   4.手机提示USB调试授权时勾选始终点击授权
TIMEOUT /t 1 /nobreak >NUL
%ADB_PATH% wait-for-device >NUL 2>NUL
GOTO ADB_MODE


:ADB_MODE
CLS
ECHO.           ADB命令
ECHO.********************************
ECHO.   1.列出ADB设备     
ECHO.   2.重启设备到Bootloader
ECHO.   3.重启设备到Recovery
ECHO.   4.重启设备到EDL
ECHO.   5.返回上一级
ECHO.********************************
SET choice=
SET /p choice=请输入选项对应的数字回车: 
IF not "%choice%"=="" SET choice=%choice:~0,1%
IF /i "%choice%"=="1" GOTO ADB_1
IF /i "%choice%"=="2" GOTO ADB_2
IF /i "%choice%"=="3" GOTO ADB_3
IF /i "%choice%"=="4" GOTO ADB_4
IF /i "%choice%"=="5" GOTO ADB_5

:ADB_1
%ADB_PATH% devices
TIMEOUT /t 1 /nobreak >NUL
ECHO 点击返回上一级
PAUSE >NUL
GOTO ADB_MODE

:ADB_2
ECHO 正在重启设备到BootLoader... 
%ADB_PATH% reboot bootloader
TIMEOUT /t 3 /nobreak >NUL
:GOTO_CHOICE_0
SET choice=
SET /p choice=是否前往BootLoader菜单(y/n)?
IF not "%choice%"=="" SET choice=%choice:~0,1%
IF /i "%choice%"=="y" GOTO BOOT_CHECK
IF /i "%choice%"=="n" GOTO ADB_MODE
ECHO.
ECHO.输入无效，请重新输入...
TIMEOUT /t 2 /nobreak >NUL
ECHO.
GOTO GOTO_CHOICE_0

:ADB_3
ECHO 正在重启设备到Recovery...
TIMEOUT /t 3 /nobreak >NUL
%ADB_PATH% reboot recovery >NUL 2>NUL
ECHO 点击返回上一级
PAUSE >NUL
GOTO ADB_MODE

:ADB_4
ECHO 正在重启设备到DEL...
%ADB_PATH% reboot edl >NUL 2>NUL
ECHO 点击返回上一级
PAUSE >NUL
GOTO ADB_MODE
ECHO.
ECHO.输入无效，请重新输入...
TIMEOUT /t 1 /nobreak >NUL
ECHO.
GOTO ADB_MODE

:ADB_5
ECHO 返回上一级
GOTO MENU


:BOOT_CHECK
CLS
ECHO    正在检查设备是否正常连接...
ECHO.
ECHO.         请确保：
ECHO.   1.手机处于Bootloader状态
TIMEOUT /t 2 /nobreak >NUL
%BOOTLOADER_PATH% wait-for-device >NUL 2>NUL
GOTO BOOT_MODE

:BOOT_MODE
CD /d "%~dp0"
CLS
ECHO.           Bootloader命令
ECHO.********************************
ECHO.   1.列出Fastboot设备
ECHO.   2.重启设备
ECHO.   3.重启设备到Bootloader
ECHO.   4.重启设备到Recovery
ECHO.   5.刷写指定分区
ECHO.   6.返回上一级
ECHO.********************************
SET choice=
SET /p choice=请输入选项对应的数字回车: 
IF not "%choice%"=="" SET choice=%choice:~0,1%
IF /i "%choice%"=="1" GOTO BOOT_1
IF /i "%choice%"=="2" GOTO BOOT_2
IF /i "%choice%"=="3" GOTO BOOT_3
IF /i "%choice%"=="4" GOTO BOOT_4
IF /i "%choice%"=="5" GOTO BOOT_5
IF /i "%choice%"=="6" GOTO BOOT_6

:BOOT_1
%BOOTLOADER_PATH% devices >NUL 
TIMEOUT /t 2 /nobreak >NUL
ECHO 点击返回上一级
PAUSE >NUL
GOTO BOOT_MODE

:BOOT_2
ECHO 正在重启设备...
%BOOTLOADER_PATH% reboot >NUL 
TIMEOUT /t 2 /nobreak >NUL
ECHO 点击返回上一级
PAUSE >NUL
GOTO BOOT_MODE

:BOOT_3
ECHO 正在重启设备到Bootloader...
%BOOTLOADER_PATH% reboot-bootloader >NUL 
TIMEOUT /t 2 /nobreak >NUL
ECHO 点击返回上一级
PAUSE >NUL
GOTO BOOT_MODE

:BOOT_4
ECHO 正在重启设备到Recovery...
%BOOTLOADER_PATH% reboot-recovery >NUL 
TIMEOUT /t 2 /nobreak >NUL
ECHO 点击返回上一级
PAUSE >NUL
GOTO BOOT_MODE

:BOOT_5
ECHO 请注意！如分区名或镜像路径填写错误导致的一切后果自负！
ECHO 请输入需要刷写的分区(区分大小写！): 
SET /p FLASH_PARTITION= 
ECHO 请拖入需要刷写的镜像或粘贴镜像的路径: 
SET /p FLASH_PATH=
%BOOTLOADER_PATH% flash %FLASH_PARTITION% %FLASH_PATH% || GOTO FLASH_FAILED

:FLASH_FAILED
ECHO.
ECHO. ！！出错！！
timeout /t 6 /nobreak >NUL
CLS
ECHO.
ECHO.       刷入失败                       
ECHO.
ECHO.   1.请检查手机型号是否正确
ECHO.   2.请确认fastboot是否正常
ECHO.   3.解压后重新运行本程序，
ECHO.   （按任意键退出程序）
ECHO.********************************
ECHO.
timeout /t 1 /nobreak >NUL
pause >NUL
EXIT

:BOOT_6
ECHO 返回上一级
GOTO MENU

:ADB_INSTALL_MODE
CLS
ECHO.           快速安装ADB
ECHO.********************************
ECHO    脚本自带ADB环境，默认情况下无需安装。
ECHO    1.一键安装最新ADB进系统Beta
ECHO    2.返回上一级
:ECHO    2.手动指定版本号进行安装
SET choice=
SET /p choice=请输入选项对应的数字回车: 
IF not "%choice%"=="" SET choice=%choice:~0,1%
IF /i "%choice%"=="1" GOTO ADB_AUTO
IF /i "%choice%"=="2" GOTO MENU
:IF /i "%choice%"=="2" GOTO ADB_MANUAL

:ADB_AUTO
ECHO 正在下载最新版本...
wget -P C:/ADB "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
::timeout /t 10 /nobreak >NUL
ECHO 正在解压...
timeout /t 2 /nobreak >NUL
7z x C:/ADB/platform-tools-latest-windows.zip -oC:/ADB
ECHO 正在设置环境变量...
timeout /t 2 /nobreak >NUL
SETX /M path "%path%;"C:\ADB\platform-tools" 
ECHO 正在清理缓存...
DEL C:\ADB\platform-tools-latest-windows.zip
ECHO 正在重启资源管理器...
taskkill /f /im explorer.exe & start explorer.exe
timeout /t 2 /nobreak >NUL
ECHO 配置完成，重启电脑以应用更改。返回上一级？
PAUSE >NUL
GOTO MENU
::ADB_MANUAL


