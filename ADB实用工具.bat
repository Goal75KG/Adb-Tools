@ECHO OFF
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" ::","","runas",1)(window.close)&&exit
SET bat_name=ADBʵ�ù���
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
ECHO ּ�ڴ���һ��ʵ�õ�ADB���ߡ�
ECHO �ű�������ַ��https:^/^/Github.com/Goal75KG/ADB-Tools
ECHO       ___   ___          ___ 
ECHO      ( _ ) / _ \  /\ /\ / _ \
ECHO      / _ \^| ^| ^| ^|/ //_// /_\/
ECHO     ^| (_) ^| ^|_^| / __ \/ /_\\ 
ECHO      \___/ \___/\/  \/\____/ 
ECHO.
ECHO ********************************************************
ECHO �밴���������
PAUSE>NUL

:MENU
CLS
ECHO.           ���ܲ˵�
ECHO.********************************
ECHO.  1.ADB�˵�
ECHO.  2.BootLoader�˵�
ECHO.  3.һ����װADB����
ECHO.  
ECHO.********************************

SET choice=
SET /p choice=������ѡ���Ӧ�����ֻس�: 
IF not "%choice%"=="" SET choice=%choice:~0,1%
IF /i "%choice%"=="1" GOTO ADB_CHECK
IF /i "%choice%"=="2" GOTO BOOT_MODE
IF /i "%choice%"=="3" GOTO ADB_INSTALL_MODE
ECHO.
ECHO.������Ч������������...
TIMEOUT /t 1 /nobreak >NUL
ECHO.
GOTO MENU

:ADB_CHECK
CLS
ECHO    ���ڼ���豸�Ƿ���������...
ECHO.
ECHO.         ��ȷ����
ECHO.   1.�ֻ����ڿ���״̬
ECHO.   2.�ֻ�����USB����
ECHO.   3.�������Ѿ���ȷ��װ����
ECHO.   4.�ֻ���ʾUSB������Ȩʱ��ѡʼ�յ����Ȩ
TIMEOUT /t 1 /nobreak >NUL
%ADB_PATH% wait-for-device >NUL 2>NUL
GOTO ADB_MODE


:ADB_MODE
CLS
ECHO.           ADB����
ECHO.********************************
ECHO.   1.�г�ADB�豸     
ECHO.   2.�����豸��Bootloader
ECHO.   3.�����豸��Recovery
ECHO.   4.�����豸��EDL
ECHO.   5.������һ��
ECHO.********************************
SET choice=
SET /p choice=������ѡ���Ӧ�����ֻس�: 
IF not "%choice%"=="" SET choice=%choice:~0,1%
IF /i "%choice%"=="1" GOTO ADB_1
IF /i "%choice%"=="2" GOTO ADB_2
IF /i "%choice%"=="3" GOTO ADB_3
IF /i "%choice%"=="4" GOTO ADB_4
IF /i "%choice%"=="5" GOTO ADB_5

:ADB_1
%ADB_PATH% devices
TIMEOUT /t 1 /nobreak >NUL
ECHO ���������һ��
PAUSE >NUL
GOTO ADB_MODE

:ADB_2
ECHO ���������豸��BootLoader... 
%ADB_PATH% reboot bootloader
TIMEOUT /t 3 /nobreak >NUL
:GOTO_CHOICE_0
SET choice=
SET /p choice=�Ƿ�ǰ��BootLoader�˵�(y/n)?
IF not "%choice%"=="" SET choice=%choice:~0,1%
IF /i "%choice%"=="y" GOTO BOOT_CHECK
IF /i "%choice%"=="n" GOTO ADB_MODE
ECHO.
ECHO.������Ч������������...
TIMEOUT /t 2 /nobreak >NUL
ECHO.
GOTO GOTO_CHOICE_0

:ADB_3
ECHO ���������豸��Recovery...
TIMEOUT /t 3 /nobreak >NUL
%ADB_PATH% reboot recovery >NUL 2>NUL
ECHO ���������һ��
PAUSE >NUL
GOTO ADB_MODE

:ADB_4
ECHO ���������豸��DEL...
%ADB_PATH% reboot edl >NUL 2>NUL
ECHO ���������һ��
PAUSE >NUL
GOTO ADB_MODE
ECHO.
ECHO.������Ч������������...
TIMEOUT /t 1 /nobreak >NUL
ECHO.
GOTO ADB_MODE

:ADB_5
ECHO ������һ��
GOTO MENU


:BOOT_CHECK
CLS
ECHO    ���ڼ���豸�Ƿ���������...
ECHO.
ECHO.         ��ȷ����
ECHO.   1.�ֻ�����Bootloader״̬
TIMEOUT /t 2 /nobreak >NUL
%BOOTLOADER_PATH% wait-for-device >NUL 2>NUL
GOTO BOOT_MODE

:BOOT_MODE
CD /d "%~dp0"
CLS
ECHO.           Bootloader����
ECHO.********************************
ECHO.   1.�г�Fastboot�豸
ECHO.   2.�����豸
ECHO.   3.�����豸��Bootloader
ECHO.   4.�����豸��Recovery
ECHO.   5.ˢдָ������
ECHO.   6.������һ��
ECHO.********************************
SET choice=
SET /p choice=������ѡ���Ӧ�����ֻس�: 
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
ECHO ���������һ��
PAUSE >NUL
GOTO BOOT_MODE

:BOOT_2
ECHO ���������豸...
%BOOTLOADER_PATH% reboot >NUL 
TIMEOUT /t 2 /nobreak >NUL
ECHO ���������һ��
PAUSE >NUL
GOTO BOOT_MODE

:BOOT_3
ECHO ���������豸��Bootloader...
%BOOTLOADER_PATH% reboot-bootloader >NUL 
TIMEOUT /t 2 /nobreak >NUL
ECHO ���������һ��
PAUSE >NUL
GOTO BOOT_MODE

:BOOT_4
ECHO ���������豸��Recovery...
%BOOTLOADER_PATH% reboot-recovery >NUL 
TIMEOUT /t 2 /nobreak >NUL
ECHO ���������һ��
PAUSE >NUL
GOTO BOOT_MODE

:BOOT_5
ECHO ��ע�⣡�����������·����д�����µ�һ�к���Ը���
ECHO ��������Ҫˢд�ķ���(���ִ�Сд��): 
SET /p FLASH_PARTITION= 
ECHO ��������Ҫˢд�ľ����ճ�������·��: 
SET /p FLASH_PATH=
%BOOTLOADER_PATH% flash %FLASH_PARTITION% %FLASH_PATH% || GOTO FLASH_FAILED

:FLASH_FAILED
ECHO.
ECHO. ����������
timeout /t 6 /nobreak >NUL
CLS
ECHO.
ECHO.       ˢ��ʧ��                       
ECHO.
ECHO.   1.�����ֻ��ͺ��Ƿ���ȷ
ECHO.   2.��ȷ��fastboot�Ƿ�����
ECHO.   3.��ѹ���������б�����
ECHO.   ����������˳�����
ECHO.********************************
ECHO.
timeout /t 1 /nobreak >NUL
pause >NUL
EXIT

:BOOT_6
ECHO ������һ��
GOTO MENU

:ADB_INSTALL_MODE
CLS
ECHO.           ���ٰ�װADB
ECHO.********************************
ECHO    �ű��Դ�ADB������Ĭ����������谲װ��
ECHO    1.һ����װ����ADB��ϵͳBeta
ECHO    2.������һ��
:ECHO    2.�ֶ�ָ���汾�Ž��а�װ
SET choice=
SET /p choice=������ѡ���Ӧ�����ֻس�: 
IF not "%choice%"=="" SET choice=%choice:~0,1%
IF /i "%choice%"=="1" GOTO ADB_AUTO
IF /i "%choice%"=="2" GOTO MENU
:IF /i "%choice%"=="2" GOTO ADB_MANUAL

:ADB_AUTO
ECHO �����������°汾...
wget -P C:/ADB "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
::timeout /t 10 /nobreak >NUL
ECHO ���ڽ�ѹ...
timeout /t 2 /nobreak >NUL
7z x C:/ADB/platform-tools-latest-windows.zip -oC:/ADB
ECHO �������û�������...
timeout /t 2 /nobreak >NUL
SETX /M path "%path%;"C:\ADB\platform-tools" 
ECHO ����������...
DEL C:\ADB\platform-tools-latest-windows.zip
ECHO ����������Դ������...
taskkill /f /im explorer.exe & start explorer.exe
timeout /t 2 /nobreak >NUL
ECHO ������ɣ�����������Ӧ�ø��ġ�������һ����
PAUSE >NUL
GOTO MENU
::ADB_MANUAL


