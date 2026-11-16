# ============================================================
#  MODO EFICIENCIA - Kit PC (feito pro Positivo T4500 / 4GB)
# ============================================================
#  O QUE FAZ: o programa que esta em foco ganha prioridade ALTA,
#  todo o resto (abas em segundo plano) fica em prioridade BAIXA.
#
#  COMO USAR: clique com o botao direito neste arquivo ->
#  "Executar com PowerShell" (melhor ainda: como Administrador)
#
#  COMO PARAR: feche esta janela (ou aperte Ctrl + C)
# ============================================================

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class JanelaAtiva {
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
    [DllImport("user32.dll")]
    public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);
}
"@

# Processos do Windows e de seguranca que NAO devem ser mexidos
$protegidos = @(
    "Idle", "System", "Registry", "smss", "csrss", "wininit", "services",
    "lsass", "svchost", "fontdrvhost", "winlogon", "dwm", "explorer",
    "taskmgr", "powershell", "pwsh", "conhost", "RuntimeBroker",
    "SearchHost", "StartMenuExperienceHost", "ShellExperienceHost",
    "audiodg", "spoolsv", "WmiPrvSE", "ctfmon", "sihost",
    "MsMpEng", "NisSrv", "SecurityHealthService", "MemCompression"
)

# Aviso se nao estiver como Administrador (funciona mesmo assim, mas cobre menos)
$ident = [Security.Principal.WindowsIdentity]::GetCurrent()
$isAdmin = (New-Object Security.Principal.WindowsPrincipal($ident)).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "AVISO: voce nao esta como Administrador. Alguns processos nao vao mudar de prioridade." -ForegroundColor Yellow
    Write-Host "Pra valer 100%%: feche, clique com o botao direito no PowerShell e 'Executar como administrador'." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "MODO EFICIENCIA ATIVO! Programa em foco = prioridade ALTA, resto = BAIXA." -ForegroundColor Green
Write-Host "Pode minimizar esta janela. Pra parar, feche ela." -ForegroundColor Cyan
Write-Host ""

while ($true) {
    $hwnd = [JanelaAtiva]::GetForegroundWindow()
    $pidAtivo = 0
    [void][JanelaAtiva]::GetWindowThreadProcessId($hwnd, [ref]$pidAtivo)

    $procAtivo = Get-Process -Id $pidAtivo -ErrorAction SilentlyContinue
    $nomeAtivo = if ($procAtivo) { $procAtivo.ProcessName } else { "" }

    $todos = Get-Process -ErrorAction SilentlyContinue | Where-Object {
        $_.SessionId -gt 0 -and ($protegidos -notcontains $_.ProcessName) -and $_.Id -ne $PID
    }

    foreach ($p in $todos) {
        try {
            if ($p.ProcessName -eq $nomeAtivo) {
                if ($p.PriorityClass -ne [System.Diagnostics.ProcessPriorityClass]::High) {
                    $p.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
                }
            } else {
                if ($p.PriorityClass -ne [System.Diagnostics.ProcessPriorityClass]::Idle) {
                    $p.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::Idle
                }
            }
        } catch {
            # Sem permissao pra esse processo? Ignora e segue.
        }
    }

    Start-Sleep -Seconds 4
}
