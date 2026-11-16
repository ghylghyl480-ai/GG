# ============================================================
#  MODO EFICIENCIA + LIMPA RAM - Kit PC (Positivo T4500 / 4GB)
# ============================================================
#  O QUE FAZ:
#   1. Programa em foco ganha prioridade ALTA, resto fica BAIXA.
#   2. Quando a RAM livre fica abaixo do limite (padrao: 800MB),
#      manda os programas de segundo plano soltarem memoria
#      (o mesmo que o "Reduce Memory" faz, mas automatico).
#
#  COMO USAR: botao direito neste arquivo -> "Executar com PowerShell"
#  (melhor ainda: PowerShell como Administrador)
#
#  COMO PARAR: feche esta janela (ou Ctrl + C)
# ============================================================

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class KitPC {
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
    [DllImport("user32.dll")]
    public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);
    [DllImport("psapi.dll")]
    public static extern bool EmptyWorkingSet(IntPtr hProcess);
}
"@

# ---- AJUSTES (pode mexer) ----
$limiteRamMB = 800      # se a RAM livre cair abaixo disso, limpa a dos de tras
$intervaloSegundos = 4  # de quanto em quanto tempo checa
# -------------------------------

$protegidos = @(
    "Idle", "System", "Registry", "smss", "csrss", "wininit", "services",
    "lsass", "svchost", "fontdrvhost", "winlogon", "dwm", "explorer",
    "taskmgr", "powershell", "pwsh", "conhost", "RuntimeBroker",
    "SearchHost", "StartMenuExperienceHost", "ShellExperienceHost",
    "audiodg", "spoolsv", "WmiPrvSE", "ctfmon", "sihost",
    "MsMpEng", "NisSrv", "SecurityHealthService", "MemCompression"
)

$ident = [Security.Principal.WindowsIdentity]::GetCurrent()
$isAdmin = (New-Object Security.Principal.WindowsPrincipal($ident)).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "AVISO: voce nao esta como Administrador. Alguns processos nao vao ser afetados." -ForegroundColor Yellow
    Write-Host "Pra valer 100%: feche, abra o PowerShell como Administrador e arraste este arquivo pra dentro." -ForegroundColor Yellow
}

function RamLivreMB {
    try {
        $os = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
        return [math]::Round($os.FreePhysicalMemory / 1024)
    } catch { return 99999 }
}

Write-Host ""
Write-Host "MODO EFICIENCIA + LIMPA RAM ATIVO!" -ForegroundColor Green
Write-Host ("Foco = prioridade ALTA | Limpa RAM quando ficar abaixo de {0}MB" -f $limiteRamMB) -ForegroundColor Cyan
Write-Host "Pode minimizar esta janela. Pra parar, feche ela." -ForegroundColor Cyan
Write-Host ""

while ($true) {
    $hwnd = [KitPC]::GetForegroundWindow()
    $pidAtivo = 0
    [void][KitPC]::GetWindowThreadProcessId($hwnd, [ref]$pidAtivo)

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

    # ---- LIMPA RAM (sombra do Reduce Memory, automatica) ----
    $livre = RamLivreMB
    if ($livre -lt $limiteRamMB) {
        $limpados = 0
        foreach ($p in $todos) {
            if ($p.ProcessName -eq $nomeAtivo) { continue }
            try {
                [void][KitPC]::EmptyWorkingSet($p.Handle)
                $limpados++
            } catch {
                # nao deu pra mexer nesse, segue o baile
            }
        }
        Write-Host ("[{0}] RAM apertada ({1}MB livres) -> soltei memoria de {2} processos de tras." -f (Get-Date -Format HH:mm:ss), $livre, $limpados) -ForegroundColor DarkCyan
    }

    Start-Sleep -Seconds $intervaloSegundos
}
