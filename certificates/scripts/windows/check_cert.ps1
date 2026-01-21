param(
    [string]$thumbprint
)

# Limpa o thumbprint
$thumbprint = $thumbprint.Replace(' ', '').ToUpper()

# Obtém todos os certificados
$allCerts = Get-ChildItem -Path Cert:\LocalMachine\My

# Filtra apenas pelo thumbprint
$cert = $allCerts | Where-Object {
    $_.Thumbprint -eq $thumbprint
} | Select-Object -First 1

# Se o certificado existir, calcula os dias restantes
if ($cert -and $cert.NotAfter) {
    $dias = ($cert.NotAfter - (Get-Date)).Days
    if ($dias -ge 0) {
        Write-Output $dias
    } else {
        Write-Output "0"  # Expirado
    }
} else {
    Write-Output "-1"  # Não encontrado
}