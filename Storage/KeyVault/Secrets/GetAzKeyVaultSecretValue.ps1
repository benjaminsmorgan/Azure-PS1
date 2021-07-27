# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Convert value to plain txt: https://docs.microsoft.com/en-us/azure/key-vault/secrets/quick-create-powershell
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecret.ps1
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
} #>
<# Functions Description: {
    GetAzKeyVaultSecretValue:   Returns the value of a key vault secret
    GetAzKeyVaultSecret:        Gets the key vault secret object
    GetAzKeyVault:              Gets key vault object
} #>
<# Variables: {
    :GetAzureKeyVaultSecretVal  Outer loop for managing function
    $CallingFunction:           Name of this function
    $KeyVaultSecretObject:      Key vault secret object
    $KeyVaultObject:            Key vault object
    $KVSO:                      $KeyVaultSecretObject
    $KVSH:                      Allocates an unmanaged binary string (BSTR) and copies the contents of a managed SecureString object into it.
    $KVSV:                      Allocates a managed String and copies a binary string (BSTR) stored in unmanaged memory into it.
    $KVSV:                      Frees a BSTR using the COM SysFreeString function.
    GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
        GetAzKeyVault{}             Gets $KeyVaultSecret
} #>
<# Process Flow {
    Function
        Call GetAzKeyVaultSecretValue > Get $null
            Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                Call GetAzKeyVault > Get $KeyVaultObject
                End GetAzKeyVault
                    Return GetAzKeyVaultSecret > Send $KeyVaultObject
            End GetAzKeyVaultSecret
                Return GetAzKeyVaultSecretValue > Send $KeyVaultSecretObject, $KeyVaultObject  
        End GetAzKeyVaultSecretValue
            Return Function > Send $null
}#>
function GetAzKeyVaultSecretValue {                                                         # Function to return the value of a key vault secret
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'GetAzKeyVaultSecretValue'                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureKeyVaultSecretVal while ($true) {                                          # Outer loop for managing function
            $KeyVaultSecretObject, $KeyVaultObject = GetAzKeyVaultSecret ($CallingFunction) # Calls function and assigns output to $Var
            if (!$KeyVaultSecretObject) {                                                   # If $KeyVaultSecretObject is $null
                Break GetAzureKeyVaultSecretVal                                             # Breaks :GetAzureKeyVaultSecretVal
            }                                                                               # End if (!$KeyVaultSecretObject)
            $KVSO = $KeyVaultSecretObject                                                   # KVSO is equal to $KeyVaultSecretObject
            $KVSV = $null                                                                   # Clears $KVSV from all previous use
            $KVSH = $null                                                                   # Clears $KVSH from all previous use
            $KVSH = `
            [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($KVSO.SecretValue) # $KVSH is equal to to $KVSO.SecretValue
            try {                                                                           # Try the following
                $KVSV = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($KVSH)    # KVSV is equal to $KVSH
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'you may not have permissions'                                   # Write message to screen
                Write-Host 'to this secret or vault'                                        # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureKeyVaultSecretVal                                             # Breaks :GetAzureKeyVaultSecretVal
            }                                                                               # End catch
            finally {                                                                       # If try succeeds
                [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($KVSV)               # Finishes unhashing $KVSV
            }                                                                               # End finally
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Write to screen'                                                # Write message to screen
            Write-Host '[2] Pass value to:'$CallingFunction                                 # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selection option
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break GetAzureKeyVaultSecretVal                                             # Breaks :GetAzureKeyVaultSecretVal
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Secret Name: '$KVSO.Name                                        # Write message to screen
                Write-Host 'Secret Value:'$KVSV                                             # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureKeyVaultSecretVal                                             # Breaks :GetAzureKeyVaultSecretVal
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Clear-Host                                                                  # Clears screen
                Return $KVSV                                                                # Returns to calling function with $var
            }                                                                               # End elseif ($OpSelect -eq '1')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :GetAzureKeyVaultSecretValue while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statement   
}                                                                                           # End function GetAzKeyVaultSecretValue