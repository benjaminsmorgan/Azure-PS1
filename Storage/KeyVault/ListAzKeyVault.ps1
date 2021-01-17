# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.3.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzKeyVault:             Lists all key vaults in subscription
} #>
<# Variables: {      
        $KVList:                List of all jey vaults in $RGObject
} #>
<# Process Flow {
    function
        Call ListAzKeyVault > Get $null
        End ListAzKeyVault     
            Return Function > Send $null
}#>
function ListAzKeyVault { # Lists all key vaults in subscription
    Begin {
        #$ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        $KVList = Get-AzKeyVault # Gets all key vaults and assigns to $KVList
        if (!$KVList) { # If $KVList returns empty
            Write-Host "No key vaults found" # Message write to screen
        } # End if (!$KVList)
        else { # If $KVList has a value
            foreach ($_ in $KVList) { # For each item in $KVList
                Write-Host "VaultName:" $_.VaultName "ResourceGroup:" $_.ResourceGroupName # Write message to screen 
            } # End else 
        } # End else (if (!$KVList))
        Return # Returns to calling function with $null
    } # End Begin
} # End function ListAzKeyVault