# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzKeyVaultCertificate:  https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultcertificate?view=azps-5.9.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
} #>
<# Functions Description: {
    GetAzKVCertificate:         Gets a key vault certificate
    GetAzKeyVault:              Gets key vault object
} #>
<# Variables: {
    :GetAzureKVCertificate      Outer loop for managing function
    :SelectAzureKVCert          Inner loop for selecting the cert
    $CallingFunction:           Name of this function or the one that called it
    $KeyVaultObject:            Key vault object
    $ObjectList:                List of all certs in $KeyVaultObject
    $ObjectNumber:              $var used for listing and selecting cert
    $ObjectArray:               Array containing all certificate items
    $ObjectInput:               $var used to load items into $ObjectArray
    $Number:                    Current item .number, used for formatting
    $OpSelect:                  Operator input to select the cert
    $KeyVaultCertObject:        Key vault certificate object
    $OpConfirm:                 Operator confirmation of the cert name
    GetAzKeyVault{}             Gets $KeyVaultObject
} #>
<# Process Flow {
    Function
        Call GetAzKVCertificate > Get $KeyVaultCertObject
            Call GetAzKeyVault > Get $KeyVaultObject
            End GetAzKeyVault
                Return GetAzKVCertificate > Send $KeyVaultObject 
        End GetAzKVCertificate
            Return Function > Send $KeyVaultCertObject, $KeyVaultObject
}#>
function GetAzKVCertificate {                                                               # Function to get a key vault certificate
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'GetAzKVCertificate'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureKVCertificate while ($true) {                                              # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break GetAzureKVCertificate                                                 # Breaks :GetAzureKVCertificate
            }                                                                               # End if (!$KeyVaultObject)
            $ObjectList = Get-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName    # Gets a list of all certs in $KeyVaultObject
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No certificates in:'$KeyVaultObject.VaultName                   # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureKVCertificate                                                 # Breaks :GetAzureKVCertificate
            }                                                                               # End if (!$ObjectList)    
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray =@()                                 # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_.Name; `
                    'ID'=$_.ID;'EN'=$_.Enabled;'CR'=$_.Created;'UP'=$_.Updated;`
                    'NB'=$_.NotBefore;'EX'=$_.Expires;'VER'=$_.Version}                     # Creates $ObjectInput
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increases $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                $Number = $_.Number                                                         # Number is equal to current item .number
                if ($Number -le 9) {                                                        # If $Number is 9 or less
                    Write-Host "[$Number]         "$_.Name                                  # Write message to screen
                }                                                                           # End if ($Number -le 9)
                else {                                                                      # If $Number is more than 9
                    Write-Host "[$Number]        "$_.Name                                   # Write message to screen
                }                                                                           # End else (if ($Number -le 9))
                Write-Host 'ID:         ' $_.ID                                             # Write message to screen
                Write-Host 'Enabled:    ' $_.EN                                             # Write message to screen
                Write-Host 'Created:    ' $_.CR                                             # Write message to screen
                Write-Host 'Updated:    ' $_.UP                                             # Write message to screen
                Write-Host 'Not Before: ' $_.NB                                             # Write message to screen
                Write-Host 'Expires:    ' $_.EX                                             # Write message to screen
                if ($_.Ver) {                                                               # If current item .ver has a value
                    Write-Host 'Version:    ' $_.Ver                                        # Write message to screen
                }                                                                           # End if ($_.Ver)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureKVCert while ($true) {                                              # Inner loop for selecting the certificate
                if ($CallingFunction -and $CallingFunction -ne 'GetAzKVCertificate') {      # If $CallingFunction has a value and is not 'GetAzKVCertificate'
                    Write-Host 'You are selecting the certificate for:'$CallingFunction     # Write message to screen
                }                                                                           # End if ($CallingFunction -and $CallingFunction -ne 'GetAzKVCertificate')
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the cert
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureKVCertificate                                             # Breaks :GetAzureKVCertificate
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect equals $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $KeyVaultCertObject = Get-AzKeyVaultCertificate -VaultName `
                        $KeyVaultObject.VaultName -Name $OpSelect.name                      # Pulls the full key vault cert object
                    Clear-Host                                                              # Clears screen
                    Return $KeyVaultCertObject, $KeyVaultObject                             # Returns to calling function with $vars 
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureKVCert while ($true)
        }                                                                                   # End :GetAzureKVCertificate while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzKVCertificate