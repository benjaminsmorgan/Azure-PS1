# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.3.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    GetAzKeyVault:              Collects a key vault object
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {      
        :GetAzureKeyVault           Outer loop for managing function
        :SelectAzureKeyVault        Inner loop for selecting the key vault
        $RGObject:                  Resource group object
        $KVList:                    List of all jey vaults in $RGObject
        $KVListNumber:              $Var used for numbering items in list
        $KVListSelect:              Operator input to select the key vault
        $KVObject:                  Key vault object
        GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call GetAzKeyVault > Get $KeyVaultObject
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return GetAzStorageAccount > Send $RGObject
        End GetAzKeyVault     
            Return Function > Send $StorageKeyVaultObject
}#>
function GetAzKeyVault { # Collects a key vault object
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :GetAzureKeyVault while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is empty
                $RGObject = GetAzResourceGroup # Calls function and assigns output to $var
                if (!$RGObject) { # If $RGObject is still empty after returning
                    Break GetAzureKeyVault # Breaks :GetAzureKeyVault
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            $KVList = Get-AzKeyVault -ResourceGroupName $RGObject.ResourceGroupName # Gets all key vaults in resource group and assigns to $KVList
            if (!$KVList) { # If $KVList returns empty
                Write-Host "No key vaults found" # Message write to screen
                Break GetAzureKeyVault # Breaks :GetAzureKeyVault
            } # End if (!$KVList)
            $KVListNumber = 1 # Sets the base value of the list
            Write-Host "0. Exit" # Adds exit option to beginning of list
            foreach ($_ in $KVList) { # For each item in list
                Write-Host $KVListNumber"." $_.VaultName # Writes the option number and key vault name
                $KVListNumber = $KVListNumber+1 # Adds 1 to $KVListNumber
            } # End foreach ($_ in $KVList)
            :SelectAzureKeyVault while ($true) { # Loop for selecting the key vault object
                $KVListNumber = 1 # Resets list number to 1
                $KVListSelect = Read-Host "Enter the option number" # Operator input for selecting which key vault
                if ($KVListSelect -eq '0') { # If $KVListSelect is equal to 0
                    Break GetAzureKeyVault # Breaks :GetAzureKeyVault
                } # End if ($KVListSelect -eq '0')
                foreach ($_ in $KVList) { # For each item in list
                    if ($KVListSelect -eq $KVListNumber) { # If the operator input matches the current $KVListNumber
                        $KeyVaultObject = Get-AzKeyVault -VaultName $_.VaultName # Currently selected item in $KVList is assigned to $KeyVaultObject
                        Break SelectAzureKeyVault # Breaks :SelectAzureKeyVault
                    } # End if ($KVListSelect -eq $KVListNumber)
                    else { # If user input does not match the current $KVListNumber
                        $KVListNumber = $KVListNumber+1 # Adds 1 to $KVListNumber
                    } # End else (if ($KVListSelect -eq $KVListNumber))
                } # End foreach ($_ in $KVList)
                Write-Host "That was not a valid selection, please try again" # Write message to screen
            } # End :SelectAzureKeyVault while ($true)
            Return $KeyVaultObject # Returns $RGObject to calling function
        } # End :GetAzureKeyVault while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function GetAzKeyVault