# 🔐 RDP Port Wechsel

Ein einfaches Batch-Script, um den **Remote Desktop Port (RDP)** unter Windows Server schnell und sicher zu ändern.  
Ideal, wenn du mehr Sicherheit möchtest oder den Standardport **3389** nicht verwenden willst.

---

## ✨ Features
- 📝 Interaktive Eingabe des neuen RDP-Ports  
- 🔧 Automatische Anpassung der **Registry**  
- 🔒 Neue **Firewallregeln** für TCP + UDP  
- 🛟 **Fallback-Port 3389** bleibt zusätzlich offen, um Aussperren zu verhindern  
- ♻️ Automatischer Neustart des RDP-Dienstes  
- 🛡️ **Admin-Check**: Script prüft, ob es mit Administratorrechten läuft  

---

## 🚀 Nutzung

1. Lade die Datei **`Change-RDPPort.bat`** herunter.  
2. Rechtsklick → **Als Administrator ausführen**.  
3. Gib den gewünschten Port ein (z. B. `3390`).  
4. Verbinde dich anschließend über RDP mit dem neuen Port:  

```powershell
mstsc /v:SERVERIP:3390
