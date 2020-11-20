# Benjamin Morgan benjamin.s.morgan@outlook.com 
# Ref https://docs.microsoft.com/en-us/powershell/module/az.keyvault/set-azkeyvaultsecret?view=azps-5.0.0
# $VaultNameInput - Operator input for the name of an existing keyvault
# $SecretName - Operator input for the name of the new secret
# $SecretValue - Operator input for the value to be hashed and stored in the keyvault
# $WarningPreference - Set for continue silently to surpress keyvault changes coming up
# $SecretHash - Hashed input of $SecretValue
# $VaultName - vault object .vaultname
function SETAZKEYVAULTSECRET { # Deploys a new secret and value to provided KeyVault
    [CmdletBinding()]
    param 
    (
        # Begin parameter input
        [Parameter(Mandatory=$true, Position=0)] # User input KeyVault name
            [string] $VaultNameInput,
        [Parameter(Mandatory=$true, Position=1)] # User input for secret name
            [string] $SecretName,
        [Parameter(Mandatory=$true, Position=2)] # User input Secret value
            [string] $SecretValue    
    )   # End parameter input
    Begin
    {
        # Begin secret creation
        $WarningPreference = "silentlyContinue" # Disables KeyVault warnings
        $SecretHash = ConvertTo-SecureString -String $SecretValue -AsPlainText -Force # Converts the user input to secure string
        $VaultName = (Get-AzKeyVault -Name $VaultNameInput).VaultName # Pulls Keyvault object based off name + wildcard ex: "ABC" will pull "ABC123"
        if (!$VaultName -or !$SecretHash) {
            Write-Host "Incorrect info provided"
            Break
        }
        Set-AzKeyVaultSecret -VaultName $VaultName -Name $SecretName -SecretValue $SecretHash # Creates new secret based off user input
    }   # End secret creation
}      