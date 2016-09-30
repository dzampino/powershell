Set-StrictMode -Version Latest 

<#
.Synopsis
   Creates a shortcut
.EXAMPLE
   New-Shortcut -Location C:\Users\Public\Desktop -Target cmd.exe
.EXAMPLE
   New-Shortcut -Target https://www.google.com -Name Google
.EXAMPLE
   New-Shortcut -Location C:\ -Target \\lan.fabrikam.com\NETLOGON 
#>

Function New-Shortcut {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$false)]
        $Location = (Get-Location).Path,

        [Parameter(Mandatory=$true)]
        $Target,

        [Parameter(Mandatory=$false)]
        #$Name = (Get-ChildItem $Target).BaseName
        $Name = [io.path]::GetFileNameWithoutExtension("$Target")
    )

    $Shell = New-Object -ComObject WScript.Shell
    $Shortcut = $Shell.CreateShortcut("$Location\$Name.lnk")
    $Shortcut.TargetPath = "$Target" 
    $Shortcut.Save()
}