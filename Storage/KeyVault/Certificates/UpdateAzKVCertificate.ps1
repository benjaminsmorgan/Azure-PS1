# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Update-AzKeyVaultCertificate:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/update-azkeyvaultcertificate?view=azps-5.1.0
    Get-AzKeyVaultCertificate:  https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultcertificate?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKVCertificate:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Certificates/GetAzKVCertificate.ps1
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
} #>
<# Functions Description: {
    UpdateAzKVCertificate:      Updates key vault certificate
    GetAzKVCertificate:         Gets a key vault certificate object
    GetAzKeyVault:              Gets key vault object
} #>
<# Variables: {
    :UpdateAzureKVCertificate   Outer loop for managing function
    :AddAzureKVCertTags         Inner loop for setting the tags
    :SetAzureKVCertTag          Inner loop for adding a tag
    :ReviewAzureKVCertTags      Inner loop for reviewing tags
    $CallingFunction:           Name of this function or the one that called it
    $KeyVaultCertObject:        Key vault certificate item
    $KeyVaultObject:            Key vault item
    $OpSelect:                  Operator input for selecting options
    $ObjectArray:               Array used to holud multiple tag entries
    $ObjectNumber:              Used for listing items in arrays
    $TagName:                   Operator input for new tag name
    $TagValue:                  Operator input for new tag value
    $OpConfirm:                 Operator confirmation of actions
    $ObjectItem:                $var used to load items into $ObjectArray
    $Tags:                      Hash table used to add tags to certificate
    $Name:                      Current item .name
    $Value:                     Current item .value
    $KeyArray:                  Array holding all tag keys
    $ValueArray:                Array holding all tag values
    $CurrentTags:               List of current tags on $KeyVaultCertObject
    $CurrentKeys:               $CurrentTags.Keys
    $CurrentValues:             $CurrentTags.Values
    $KeyAdd:                    $var used to load items into $KeyArray
    $ValueAdd:                  $var used to load items into $ValueArray
    $Key:                       Current item
    $Number:                    Current item .Number
    GetAzKVCertificate{}        Gets $KeyVaultCertObject
        GetAzKeyVault{}             Gets $KeyVaultCertificate
} #>
<# Process Flow {
    Function
        Call UpdateAzKVCertificate > Get $null
            Call GetAzKVCertificate > Get $KeyVaultCertObject
                Call GetAzKeyVault > Get $KeyVaultObject
                End GetAzKeyVault
                    Return GetAzKVCertificate > Send $KeyVaultObject
            End GetAzKVCertificate
                Return UpdateAzKVCertificate > Send $KeyVaultCertObject, $KeyVaultObject  
        End UpdateAzKVCertificate
            Return Function > Send $null
}#>
function UpdateAzKVCertificate {                                                            # Function to update a key vault certificate
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables errors
        $WarningPreference = 'silentlyContinue'                                             # Disables key vault warnings
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'UpdateAzKVCertificate'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :UpdateAzureKVCertificate while ($true) {                                           # Outer loop for managing function
            $KeyVaultCertObject, $KeyVaultObject = GetAzKVCertificate ($CallingFunction)    # Calls function and assigns output to $Var
            if (!$KeyVaultCertObject) {                                                     # If $KeyVaultCertObject is $null
                Break UpdateAzureKVCertificate                                              # Breaks :UpdateAzureKVCertificate
            }                                                                               # End if (!$KeyVaultCertObject)
            Write-Host 'Update options'                                                     # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            if ($KeyVaultCertObject.Enabled -eq $True) {                                    # If $KeyVaultCertObject.Enabled is $true
                Write-Host '[1] Disable certificate'                                        # Write message to screen
            }                                                                               # End if ($KeyVaultCertObject.Enabled -eq $True) 
            else {                                                                          # If $KeyVaultCertObject.Enabled is not $true
                Write-Host '[1] Enable certificate'                                         # Write message to screen
            }                                                                               # End else (if ($KeyVaultCertObject.Enabled -eq $True))
            Write-Host '[2] Replace tags'                                                   # Write message to screen
            Write-Host '[3] Remove tags'                                                    # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting update function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break UpdateAzureKVCertificate                                              # Breaks :UpdateAzureKVCertificate
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OPSelect -eq '1' -and $KeyVaultCertObject.Enabled -eq $true) {         # If $OpSelect equals '1' $KeyVaultCertObject.Enabled is $true
                Try {                                                                       # Try the following
                    Write-Host 'Disabling:'$KeyVaultCertObject.Name                         # Write message to screen
                    Update-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                        -Name $KeyVaultCertObject.Name -Enable $false -ErrorAction 'Stop'   # Disables to cert
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'There was an error while disabling the certificate'         # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break UpdateAzureKVCertificate                                          # Breaks :UpdateAzureKVCertificate
                }                                                                           # End catch
                Write-Host 'Certificate has been disabled'                                  # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break UpdateAzureKVCertificate                                              # Breaks :UpdateAzureKVCertificate
            }                                                                               # End elseif ($OPSelect -eq '1' -and $KeyVaultCertObject.Enabled -eq $true)
            elseif ($OPSelect -eq '1' -and $KeyVaultCertObject.Enabled -eq $false) {        # If $OpSelect equals '1' $KeyVaultCertObject.Enabled is $false
                Try {                                                                       # Try the following
                    Write-Host 'Enabling:'$KeyVaultCertObject.Name                          # Write message to screen
                    Update-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                        -Name $KeyVaultCertObject.Name -Enable $true -ErrorAction 'Stop'    # Enables to cert
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'There was an error while enabling the certificate'          # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break UpdateAzureKVCertificate                                          # Breaks :UpdateAzureKVCertificate
                }                                                                           # End catch
                Write-Host 'Certificate has been enabled'                                   # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break UpdateAzureKVCertificate                                              # Breaks :UpdateAzureKVCertificate
            }                                                                               # End elseif ($OPSelect -eq '1' -and $KeyVaultCertObject.Enabled -eq $false)
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                [System.Collections.ArrayList]$ObjectArray =@()                             # Creates $ObjectArray
                $ObjectNumber = 1                                                           # Creates $ObjectNumber
                :AddAzureKVCertTags while ($true) {                                         # Inner loop for setting the tags
                    :SetAzureKVCertTag while ($true) {                                      # Inner loop for adding a tag
                        Write-Host 'Replacement tag:'$ObjectNumber                          # Write message to screen
                        $TagName = Read-Host 'Name'                                         # Operator input for tag name
                        $TagValue = Read-Host 'Value'                                       # Operator input for tag value
                        Write-Host 'Add tag:'$TagName ':'$TagValue                          # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the tag pair
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'e') {                                           # If $OpConfirm equals 'e'
                            Break UpdateAzureKVCertificate                                  # Breaks :UpdateAzureKVCertificate
                        }                                                                   # End if ($OpConfirm -eq 'e')
                        elseif ($OpConfirm -eq 'y') {                                       # Else if $OpConfirm equals 'y'
                            $ObjectItem = [PSCustomObject]@{'Name'=$TagName;`
                            'Value'=$TagValue}                                              # Adds $TagName and $TagValue to $ObjectItem
                            $ObjectArray.Add($ObjectItem) | Out-Null                        # Adds $Objectitem to $ObjectArray
                            $ObjectNumber = $ObjectNumber + 1                               # Increments $ObjectNumber up by 1
                            Break SetAzureKVCertTag                                         # Breaks :SetAzureKVCertTag
                        }                                                                   # End elseif ($OpConfirm -eq 'y')
                        else {                                                              # All other inputs for $OpConfirm
                            Break SetAzureKVCertTag                                         # Breaks :SetAzureKVCertTag
                        }                                                                   # End else (if ($OpConfirm -eq 'e'))
                    }                                                                       # End :SetAzureKVCertTag while ($true)
                    :ReviewAzureKVCertTags while ($true) {                                  # Inner loop for reviewing tags
                        Write-Host 'Current tags'                                           # Write message to screen
                        foreach ($_ in $ObjectArray) {                                      # For each item in $ObjectArray
                            Write-Host $_.Name ':'$_.Value                                  # Write message to screen
                        }                                                                   # End foreach ($_ in $ObjectArray)
                        Write-Host $ObjectArray
                        Write-Host ''                                                       # Write message to screen
                        Write-Host '[0] Exit'                                               # Write message to screen
                        Write-Host '[1] Add additional tag'                                 # Write message to screen
                        Write-Host '[2] Save current tags to certificate'                   # Write message to screen
                        $OpSelect = Read-Host 'Option [#]'                                  # Operator input for next action
                        Clear-Host                                                          # Clears screen
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals '0'
                            Break UpdateAzureKVCertificate                                  # Breaks :UpdateAzureKVCertificate
                        }                                                                   # End if ($OpSelect -eq '0')
                        elseif ($OpSelect -eq '1') {                                        # Else if $OpSelect equals '1'
                            Break ReviewAzureKVCertTags                                     # Breaks :ReviewAzureKVCertTags
                        }                                                                   # End elseif ($OpSelect -eq '1')
                        elseif ($OpSelect -eq '2') {                                        # Else if $OpSelect equals '2'
                            Break AddAzureKVCertTags                                        # Breaks :AddAzureKVCertTags
                        }                                                                   # End elseif ($OpSelect -eq '2')
                        
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End if ($OpSelect -eq '0')
                    }                                                                       # End :ReviewAzureKVCertTags while ($true)
                }                                                                           # End :AddAzureKVCertTags while ($true)
                $Tags = @{}                                                                 # Creates $Tags hash table
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Name = $_.name                                                         # Isolates current item .name
                    $Value = $_.Value                                                       # Isolates current item .value
                    $tags.add($Name,$Value)                                                 # Adds $Name and $value to $Tags
                }                                                                           # End foreach ($_ in $ObjectArray)
                Try {                                                                       # Try the following
                    Write-Host 'Adding tags to:'$KeyVaultCertObject.name                    # Write message to screen
                    Update-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                        -Name $KeyVaultCertObject.Name -Tag $Tags -PassThru `
                        -ErrorAction 'Stop'                                                 # Replaces the current tag list
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error occured while modifing the tags'                   # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break UpdateAzureKVCertificate                                          # Breaks :UpdateAzureKVCertificate
                }                                                                           # End catch
                Write-Host 'Tags have been updated'                                         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break UpdateAzureKVCertificate                                              # Breaks :UpdateAzureKVCertificate
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove the following tags from:'$KeyVaultCertObject.name        # Write message to screen
                [System.Collections.ArrayList]$KeyArray =@()                                # Creates $KeyArray
                [System.Collections.ArrayList]$ValueArray =@()                              # Creates $ValueArray
                $ObjectNumber = 1                                                           # Creates $ObjectNumber
                $CurrentTags = $KeyVaultCertObject.Tags                                     # Isolates the tags
                $CurrentKeys = $CurrentTags.Keys                                            # Isolates the tag keys
                $CurrentValues = $CurrentTags.Values                                        # Isolates the tags values
                foreach ($_ in $CurrentKeys) {                                              # For each item in $CurrentKeys
                    $KeyAdd = [PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_}           # Creates $KeyAdd
                    $KeyArray.Add($KeyAdd) | Out-Null                                       # Adds $KeyAdd to $KeyArray
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                }                                                                           # End foreach ($_ in $CurrentKeys)
                $ObjectNumber = 1                                                           # Resets $ObjectNumber to 1
                foreach ($_ in $CurrentValues) {                                            # For each item in $CurrentValues
                    $ValueAdd = [PSCustomObject]@{'Number'=$ObjectNumber;'Value'=$_}        # Creates $ValueAdd
                    $ValueArray.Add($ValueAdd) | Out-Null                                   # Adds $ValueAdd to $ValueArray
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1     
                }                                                                           # End foreach ($_ in $CurrentValues)
                foreach ($_ in $KeyArray) {                                                 # For each item in $KeyArray
                    $Key = $_                                                               # Pulls current item into $Key
                    $Number = $Key.Number                                                   # Isolates $Key.Number
                    $Value = $ValueArray | Where-Object {$_.Number -eq $Number}             # Value is equal to $ValueArray where $ValueArray.Number equals $number
                    Write-Host $Key.Name':' $Value.Value                                    # Write message to screen
                }                                                                           # End foreach ($_ in $KeyArray)
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation to remove the tags
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfrim equals 'y'
                    $Tags = @{}                                                             # Creates $Tags hash table
                    Try {                                                                   # Try the following
                        Write-Host 'Removing tags from:'$KeyVaultCertObject.name            # Write message to screen
                        Update-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                            -Name $KeyVaultCertObject.Name -Tag $Tags -PassThru `
                            -ErrorAction 'Stop'                                             # Replaces the current tag list
                    }                                                                       # End try
                    Catch {                                                                 # If try fails
                        Write-Host 'An error occured while modifing the tags'               # Write message to screen
                        Write-Host 'You may not have the permissions to do this'            # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break UpdateAzureKVCertificate                                      # Breaks :UpdateAzureKVCertificate
                    }                                                                       # End catch
                    Write-Host 'Tags have been removed'                                     # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break UpdateAzureKVCertificate                                          # Breaks :UpdateAzureKVCertificate
                }                                                                           # End if ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Break UpdateAzureKVCertificate                                          # Breaks :UpdateAzureKVCertificate
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End elseif ($OpSelect -eq '3')
        }                                                                                   # End :UpdateAzureKVCertificate while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzKVCertificate