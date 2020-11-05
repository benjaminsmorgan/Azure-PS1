# Benjamin Morgan benjamin.s.morgan@outlook.com 
# Ref https://docs.microsoft.com/en-us/powershell/module/az.keyvault/set-azkeyvaultsecret?view=azps-5.0.0
function FunctionName { # Deploys a new secret and value to provided KeyVault
    [CmdletBinding()]
    param 
    (
        # Begin parameter input
        [Parameter(Mandatory=$true, Position=0)] # User input KeyVault name
            [string] $VaultName,
        [Parameter(Mandatory=$true, Position=1)] # User input Secret value
            [string] $SecretValue,
        [Parameter(Mandatory=$true, Position=2)] # User input for secret name
            [string] $SecretName    
    )   # End parameter input
    Begin
    {
        # Begin secret creation
        $SecretHash = ConvertTo-SecureString -String $SecretValue -AsPlainText -Force # Converts the user input to secure string
        $AZKV = (Get-AzKeyVault -Name $VaultName*).VaultName # Pulls Keyvault object based off name + wildcard ex: "ABC" will pull "ABC123"
        Set-AzKeyVaultSecret -VaultName $AZKV -Name $SecretName -SecretValue $SecretHash # Creates new secret based off user input
    }   # End secret creation
}      