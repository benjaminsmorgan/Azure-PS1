# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultKey?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/GetAzKeyVaultKey.ps1
        GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
            GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    DownloadAzKeyVaultKey:      Downloads a key vault key
    GetAzKeyVaultKey:           Gets a key vault Key
    GetAzKeyVault:              Gets key vault object
    GetAzResourceGroup:         Gets resource group object
} #>
<# Variables: {
    :DownloadAzureKVKey         Outer loop for managing function
    :SetLocalDownloadPath       Inner loop for setting the download path
    :SetLocalFileName           Inner loop for setting the key local name
    $KeyVaultKeyObject          Key vault key being downloaded
    $LocalPath                  Operator input for the download path
    $LocalFileName              Operator input for the key name
    $OperatorConfirm            Operator confirmation of file name
    $Fullpath                   Creates the full download path and name $var
    GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
        GetAzKeyVault{}             Gets $KeyVaultObject
            GetAzResourceGroup{}        Gets $RGObject      
} #>
<# Process Flow {
    Function
        Call DownloadKeyVaultKey > Get $null
            Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
                Call GetAzKeyVault > Get $KeyVault
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzKeyVault > Send $RGObject
                End GetAzKeyVault
                    Return GetAzKeyVaultKey > Send $KeyVault
            End GetAzKeyVaultKey
                Return DownloadKeyVaultKey > Send $KeyVaultKeyObject
        End DownloadKeyVaultKey
            Return function > Send $null
}#>
function DownloadAzKeyVaultKey { # Downloads a selected key vault key
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :DownloadAzureKVKey while ($true) { # Outer loop for managing function
            if (!$KeyVaultKeyObject) { # If $KeyVaultKeyObject is $null 
                $KeyVaultKeyObject = GetAzKeyVaultKey # Calls function and assigns output to $var
                if (!$KeyVaultKeyObject) { # If $var is still $null
                    Break DownloadAzureKeyVaultKey # Breaks :DownloadAzureKeyVaultKey    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            :SetLocalDownloadPath while ($true) { # Inner loop for setting the download path
                $LocalPath = Read-Host "Please enter the file path (E.X. C:\Users\Admin\Downloads\)" # Operator input for the download path
                if ($LocalPath -eq 'exit') { # If $var is equal to 'exit' 
                    Break DownloadAzureKVKey # Breaks :DownloadAzureKVKey
                } # End if ($LocalPath -eq 'exit')
                if ($LocalPath -notlike '*\') { # If $LocalPath does not end with \
                    Write-Host "The path is not valid" # Write message to screen
                    Write-Host "Please re-enter the path" # Write message to screen
                } # End if ($LocalPath -notlike '*\')
                else { # If $LocalPath ends with \
                    Break SetLocalDownloadPath # Breaks :SetLocalDownloadPath
                } # End else (if ($LocalPath -notlike '*\'))
            } # End :SetLocalDownloadPath while ($true)
            :SetLocalFileName while ($true) { # Inner loop for setting the key local name
                $LocalFileName = Read-Host "Enter the key name" # Operator input for the key name
                if ($LocalFileName -eq 'exit') { # If $var is equal to 'exit'
                    Break DownloadAzureKVKey # Breaks :DownloadAzureKVKey
                } # End if ($LocalFileName -eq 'exit')
                $LocalfileName = $LocalFileName+'.pem' # Adds .pem to file name
                Write-Host $LocalFileName # Write message to screen
                $OperatorConfirm = Read-Host "Use this file name [Y] or [N]" # Operator confirmation of file name
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm equals 'y'
                    Break SetLocalFileName # Breaks :SetLocalFileName
                } # End if ($OperatorConfirm -eq 'y')
            } # End :SetLocalFileName while ($true)
            $Fullpath = $LocalPath+$LocalFileName # Creates the full download path and name $var
            Try { # Try the following
                Get-AzKeyVaultKey -VaultName $KeyVaultKeyObject.VaultName -Name $KeyVaultKeyObject.Name -OutFile $Fullpath -ErrorAction Stop # Downloads the selected key
            } # End Try
            Catch { # If try fails
                Write-Host "An error has occured" # Write message to screen
                Write-Host "You may not have permissions to this key" # Write message to screen
                Write-Host "You may not have permissions to the download location" # Write message to screen
                Write-Host "The selected download location may not exist" # Write message to screen
            } # End Catch
            Break DownloadAzureKVKey # Breaks :DownloadAzureKVKey
        } # End :DownloadAzureKVKey while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function DownloadAzKeyVaultKey