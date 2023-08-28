# Load powerline-go prompt
# See https://github.com/justjanne/powerline-go for customization info
# function global:prompt {
#     $pwd = $ExecutionContext.SessionState.Path.CurrentLocation
#     $startInfo = New-Object System.Diagnostics.ProcessStartInfo
#     $startInfo.FileName = "powerline-go"
#     $startInfo.Arguments = "-shell bare -modules 'venv,host,ssh,cwd,perms,git,hg,jobs,exit,root' -trim-ad-domain -newline -hostname-only-if-ssh"
#     $startInfo.Environment["TERM"] = "xterm-256color"
#     $startInfo.CreateNoWindow = $true
#     $startInfo.StandardOutputEncoding = [System.Text.Encoding]::UTF8
#     $startInfo.RedirectStandardOutput = $true
#     $startInfo.UseShellExecute = $false
#     $startInfo.WorkingDirectory = $pwd
#     $process = New-Object System.Diagnostics.Process
#     $process.StartInfo = $startInfo
#     $process.Start() | Out-Null
#     $standardOut = $process.StandardOutput.ReadToEnd()
#     $process.WaitForExit()
#     $standardOut
# }
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_lean.omp.json" | Invoke-Expression
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Import-Module gsudoModule

Invoke-Expression (&sfsu hook)

(& volta completions powershell) | Out-String | Invoke-Expression
Import-Module scoop-completion

Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Alias docker to podman for convenience
Set-Alias -Name docker -Value podman