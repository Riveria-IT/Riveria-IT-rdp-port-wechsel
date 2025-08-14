@echo off
:: ==============================================
:: Script zum Ändern des RDP-Ports in Windows
:: ==============================================

:: Check ob Script mit Adminrechten läuft
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo ==================================================
    echo  FEHLER: Dieses Script muss als Administrator laufen!
    echo  Rechtsklick -> "Als Administrator ausführen"
    echo ==================================================
    pause
    exit /b
)

echo ================================
echo   RDP Port Wechsel Tool
echo ================================
set /p RDPPORT=Bitte neuen RDP-Port eingeben (z.B. 3390):

if "%RDPPORT%"=="" (
  echo Kein Port eingegeben – beende.
  pause
  exit /b
)

echo Neuer Port wird gesetzt: %RDPPORT%

:: Registry ändern
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber /t REG_DWORD /d %RDPPORT% /f

:: Firewallregeln hinzufügen (TCP + UDP inbound)
netsh advfirewall firewall add rule name="RDP Custom Port %RDPPORT% TCP" dir=in action=allow protocol=TCP localport=%RDPPORT%
netsh advfirewall firewall add rule name="RDP Custom Port %RDPPORT% UDP" dir=in action=allow protocol=UDP localport=%RDPPORT%

:: Fallback: Standardport 3389 auch freigeben (TCP+UDP)
netsh advfirewall firewall add rule name="RDP Fallback Port 3389 TCP" dir=in action=allow protocol=TCP localport=3389
netsh advfirewall firewall add rule name="RDP Fallback Port 3389 UDP" dir=in action=allow protocol=UDP localport=3389

:: RDP-Dienst neu starten
echo Starte Remote Desktop Dienst neu...
net stop TermService /y
net start TermService

echo =====================================
echo Fertig!
echo Neuer Port: %RDPPORT%
echo Fallback: 3389 bleibt zusaetzlich offen
echo Verbinde mit: mstsc /v:SERVERIP:%RDPPORT%
echo Oder als Backup mit: mstsc /v:SERVERIP:3389
echo =====================================
pause
