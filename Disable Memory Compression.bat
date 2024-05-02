@echo off
powershell -Command "Disable-MMAgent -mc"
bcdedit /set hypervisorlaunchtype off