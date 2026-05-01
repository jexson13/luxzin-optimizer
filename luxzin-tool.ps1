# ==========================================
# LUXZIN OPTIMIZER TOOL
# ==========================================

Clear-Host

function Show-Menu {
    Write-Host ""
    Write-Host "==============================="
    Write-Host "   LUXZIN OPTIMIZER TOOL"
    Write-Host "==============================="
    Write-Host "1. Limpiar sistema"
    Write-Host "2. Optimizar servicios"
    Write-Host "3. Optimizar red"
    Write-Host "4. Modo gaming"
    Write-Host "5. Salir"
    Write-Host ""
}

function Clean-System {
    Write-Host "Limpiando temporales..."
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "✔ Limpieza completada"
}

function Optimize-Services {
    Write-Host "Optimizando servicios..."
    Stop-Service "SysMain" -Force -ErrorAction SilentlyContinue
    Set-Service "SysMain" -StartupType Disabled

    Stop-Service "DiagTrack" -Force -ErrorAction SilentlyContinue
    Set-Service "DiagTrack" -StartupType Disabled

    Write-Host "✔ Servicios optimizados"
}

function Optimize-Network {
    Write-Host "Optimizando red..."
    netsh int tcp set global autotuninglevel=normal
    netsh int tcp set global rss=enabled
    netsh int tcp set global chimney=enabled
    Write-Host "✔ Red optimizada"
}

function Gaming-Mode {
    Write-Host "Activando modo gaming..."
    powercfg -setactive SCHEME_MIN
    Write-Host "✔ Modo gaming activado"
}

do {
    Show-Menu
    $option = Read-Host "Selecciona una opcion"

    switch ($option) {
        "1" { Clean-System }
        "2" { Optimize-Services }
        "3" { Optimize-Network }
        "4" { Gaming-Mode }
        "5" { exit }
        default { Write-Host "Opcion invalida" }
    }

} while ($true)