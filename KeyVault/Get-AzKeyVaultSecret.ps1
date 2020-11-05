# Benjamin Morgan benjamin.s.morgan@outlook.com 
# Ref https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.0.0
function FunctionName { # Retrieves a secret and value to provided KeyVault
    [CmdletBinding()]
    param 
    (
        # Begin parameter input
        [Parameter(Mandatory=$true, Position=0)] # User input KeyVault name
            [string] $VaultName,
        [Parameter(Mandatory=$true, Position=1)] # User input for secret name
            [string] $SecretName    
    )   # End parameter input
    Begin
    {
        # Begin secret value collection
        $WarningPreference = "silentlyContinue" # Disables KeyVault warnings
        $AZKV = (Get-AzKeyVault -Name $VaultName*).VaultName # Pulls Keyvault object based off name + wildcard ex: "ABC" will pull "ABC123"
        $SecretHash = (Get-AzKeyVaultSecret -VaultName $AZKV | Where-Object {$_.Name -like "$SecretName*"} | select name) # Pulls Keyvault secret name based off name + wildcard ex: "ABC" will pull "ABC123"
        $SecretHash2 = (Get-AzKeyVaultSecret -VaultName $AZKV -Name $SecretHash.Name) # Uses complete secret name to pull the latest version
        # This code is provided by MS to change the hashed value into plain text https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.0.0#examples
        $secretValueText = ''; 
        $ssPtr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecretHash2.SecretValue)
        try {
            $secretValueText = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($ssPtr)
        } 
        finally {
            [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ssPtr)
        }
        # End MS provided code
        Write-Host $SecretHash.Name
        Write-Host $secretValueText 
    }
}      