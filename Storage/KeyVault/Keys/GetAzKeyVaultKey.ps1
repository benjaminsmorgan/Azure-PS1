# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultKey?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    GetAzKeyVaultKey:           Gets a key vault Key
    GetAzKeyVault:              Gets key vault object
    GetAzResourceGroup:         Gets resource group object
} #>
<# Variables: {
    :GetAzureKeyVaultKey        Outer loop for managing function
    :SelectAzureKeyVaultKey     Inner loop for selecting $KeyVaultKeyObject
    $KeyVaultObject:            Additional azure object needed to get main object
    $KVKeylist:                 List of all key vault Keys
    $KVKeylistNumber:           List number
    $KVKeylistSelect:           Operator input to select $KVKeyListNumber
    $KeyVaultKeyObject:         Target of this function
    GetAzKeyVault{}             Gets $KeyVaultObject
        GetAzResourceGroup{}        Gets $RGObject      
} #>
<# Process Flow {
    Function
        Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
            Call GetAzKeyVault > Get $KeyVault
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzKeyVault > Send $RGObject
            End GetAzKeyVault
                Return GetAzKeyVaultKey > Send $KeyVault
        End GetAzKeyVaultKey
            Return Function > Send $KeyVaultKeyObject
}#>
function GetAzKeyVaultKey { # Function to get a key vault Key
    Begin {
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :GetAzureKeyVaultKey while ($true) { # Outer loop for managing function
            if (!$KeyVaultObject) { # If $KeyVaultObject is $null 
                $KeyVaultObject = GetAzKeyVault # Calls function and assigns output to $var
                if (!$KeyVaultObject) { # If $var is still $null
                    Break GetAzureKeyVaultKey # Breaks :GetAzureKeyVaultKey    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            $KVKeylist = Get-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName # Creates list of all Keys in vault
            if (!$KVKeylist) { # If $KVKeylist returns empty
                Write-Host "No Keys found" # Message write to screen
                Break GetAzureKeyVaultKey # Breaks :GetAzureKeyVaultKey
            } # End if (!$KVKeylist)
            $KVKeylistNumber = 1 # Sets the base value of the list
            Write-Host "0. Exit" # Write message to screen
            foreach ($_ in $KVKeylist) { # For each item in list
                Write-Host $KVKeylistNumber"." $_.Name # Writes list to screen
                $KVKeylistNumber = $KVKeylistNumber+1 # Adds 1 to $KVKeylistNumber
            } # End foreach ($_ in $KVKeylist) 
            $KVKeylistNumber = 1 # Resets list number to 1
            $KVKeylistSelect = Read-Host "Enter the option number" # Operator input to select from list
            if ($KVKeylistSelect -eq '0') { # If $KVKeyListSelect is 0
                Break GetAzureKeyVaultKey # Breaks :GetAzureKeyVaultKey
            } # End if ($KVKeylistSelect -eq '0')
            :SelectAzureKeyVaultKey foreach ($_ in $KVKeylist) { # For each item in list
                if ($KVKeylistSelect -eq $KVKeylistNumber) { # If the user input matches the current $KVKeylistNumber
                    $KeyVaultKeyObject = Get-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name $_.Name # Collects the full $KeyVaultKeyObject
                    Break SelectAzureKeyVaultKey # Breaks :SelectAzureKeyVaultKey
                } # End if ($KVKeylistSelect -eq $KVKeylistNumber)
                else { # If user input does not match the current $KVKeylistNumber
                    $KVKeylistNumber = $KVKeylistNumber+1 # Adds 1 to $KVKeylistNumber
                } # End else (if ($KVKeylistSelect -eq $KVKeylistNumber))
            } # End :SelectAzureKeyVaultKey
            Return $KeyVaultKeyObject # Returns $KeyVaultKeyObject to calling function
        } # End :GetAzureKeyVaultKey while ($true) {
        Return # Returns $null to calling function
    } # End begin statement
} # End GetAzKeyVaultKey