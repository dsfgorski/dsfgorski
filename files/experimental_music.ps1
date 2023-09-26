$URL = "https://www.youtube.com/watch?v=b0Kj2XSCSQI"
#$URL = "https://www.youtube.com/watch?v=t0Q2otsqC4I"

<# $WindowStates = @{ 
    'FORCEMINIMIZE'   = 11
    'HIDE'            = 0
    'MAXIMIZE'        = 3
    'MINIMIZE'        = 6
    'RESTORE'         = 9
    'SHOW'            = 5
    'SHOWDEFAULT'     = 10
    'SHOWMAXIMIZED'   = 3
    'SHOWMINIMIZED'   = 2
    'SHOWMINNOACTIVE' = 7
    'SHOWNA'          = 8
    'SHOWNOACTIVATE'  = 4
    'SHOWNORMAL'      = 1
}#>
$Win32ShowWindowAsync = Add-Type –memberDefinition @”
[DllImport("user32.dll")]
public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
“@ -name “Win32ShowWindowAsync” -namespace Win32Functions –passThru

$A = Get-Process| Where-Object {$_.Name -eq "chrome" -and $_.MainWindowTitle };
Start-Process chrome "$URL --new-window"
while (Get-Process -Name chrome |Where-Object {$_.MainWindowTitle -eq $A.MainWindowTitle}) {};
$Win32ShowWindowAsync::ShowWindowAsync((Get-Process -PID $A.Id|Where-Object {$_.MainWindowTitle }).MainWindowHandle, 0) | Out-Null