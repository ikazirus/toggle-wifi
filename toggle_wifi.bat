@echo off
setlocal enabledelayedexpansion

:: Define adapter names
set "wifi=Wi-Fi"
set "lan=Ethernet"

:: Get the current state of the Wi-Fi adapter
for /f "tokens=3 delims=: " %%i in ('netsh interface show interface name^="%wifi%" ^| findstr /i /c:"Administrative state"') do set "wifi_state=%%i"

:: Check the current state and toggle accordingly
if /i "!wifi_state!"=="Enabled" (
    echo Turning off Wi-Fi and turning on LAN...
    netsh interface set interface name="%wifi%" admin=disable
    netsh interface set interface name="%lan%" admin=enable
) else (
    echo Turning off LAN and turning on Wi-Fi...
    netsh interface set interface name="%wifi%" admin=enable
    netsh interface set interface name="%lan%" admin=disable
)

endlocal
