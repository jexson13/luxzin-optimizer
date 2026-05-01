Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Ventana principal
$form = New-Object System.Windows.Forms.Form
$form.Text = "LUXZIN OPTIMIZER PRO"
$form.Size = New-Object System.Drawing.Size(400,500)
$form.StartPosition = "CenterScreen"

# Título
$title = New-Object System.Windows.Forms.Label
$title.Text = "LUXZIN OPTIMIZER"
$title.Size = New-Object System.Drawing.Size(300,30)
$title.Location = New-Object System.Drawing.Point(50,10)
$form.Controls.Add($title)

# CHECKBOXES

# 1. Desactivar SysMain
$chkSysMain = New-Object System.Windows.Forms.CheckBox
$chkSysMain.Text = "Desactivar SysMain (Mejor para HDD)"
$chkSysMain.Location = "20,60"
$form.Controls.Add($chkSysMain)

# 2. Desactivar Telemetría
$chkTelemetry = New-Object System.Windows.Forms.CheckBox
$chkTelemetry.Text = "Desactivar Telemetría"
$chkTelemetry.Location = "20,90"
$form.Controls.Add($chkTelemetry)

# 3. Modo Gaming
$chkGaming = New-Object System.Windows.Forms.CheckBox
$chkGaming.Text = "Activar Modo Gaming"
$chkGaming.Location = "20,120"
$form.Controls.Add($chkGaming)

# 4. Limpiar temporales
$chkTemp = New-Object System.Windows.Forms.CheckBox
$chkTemp.Text = "Limpiar archivos temporales"
$chkTemp.Location = "20,150"
$form.Controls.Add($chkTemp)

# 5. Optimizar red
$chkNetwork = New-Object System.Windows.Forms.CheckBox
$chkNetwork.Text = "Optimizar red"
$chkNetwork.Location = "20,180"
$form.Controls.Add($chkNetwork)

# BOTÓN APLICAR
$btnApply = New-Object System.Windows.Forms.Button
$btnApply.Text = "Aplicar cambios"
$btnApply.Size = "150,40"
$btnApply.Location = "120,250"

$btnApply.Add_Click({

    if ($chkSysMain.Checked) {
        Stop-Service "SysMain" -Force -ErrorAction SilentlyContinue
        Set-Service "SysMain" -StartupType Disabled
    }

    if ($chkTelemetry.Checked) {
        Stop-Service "DiagTrack" -Force -ErrorAction SilentlyContinue
        Set-Service "DiagTrack" -StartupType Disabled
    }

    if ($chkGaming.Checked) {
        powercfg -setactive SCHEME_MIN
    }

    if ($chkTemp.Checked) {
        Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    }

    if ($chkNetwork.Checked) {
        netsh int tcp set global autotuninglevel=normal
    }

    [System.Windows.Forms.MessageBox]::Show("Optimización completada")
})

$form.Controls.Add($btnApply)

# Mostrar ventana
$form.ShowDialog()