
#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# VS Code terminal integration
if ($env:TERM_PROGRAM -eq "vscode") { . "$(code --locate-shell-integration-path pwsh)" }

Import-Module gsudoModule

Invoke-Expression (&sfsu hook)

(& volta completions powershell) | Out-String | Invoke-Expression
Import-Module scoop-completion


# Prompt

# Alternatives
# https://github.com/justjanne/powerline-go
# oh-my-posh init pwsh --config "~\Documents\Powershell\powerlevel10k_lean.omp.json" | Invoke-Expression

Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
