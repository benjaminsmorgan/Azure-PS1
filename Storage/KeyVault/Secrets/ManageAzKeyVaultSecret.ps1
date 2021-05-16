# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Set-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/set-azkeyvaultsecret?view=azps-5.1.0
    Remove-AzKeyVaultSecret:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultsecret?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/NewAzKeyVaultSecret.ps1
    ListAzKeyVaultSecret:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/ListAzKeyVaultSecret.ps1
    GetAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecret.ps1
    GetAzKeyVaultSecretValue:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecretValue.ps1
    UpdateAzKeyVaultSecret:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/UpdateAzKeyVaultSecret.ps1
    RemoveAzKeyVaultSecret:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/RemoveAzKeyVaultSecret.ps1
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
} #>
<# Functions Description: {
    ManageAzKeyVaultSecret:     Management function for key vault secrets
    NewAzKeyVaultSecret:        Creates a new key vault secret
    ListAzKeyVaultSecret:       Lists all key vault secrets by vault name
    GetAzKeyVaultSecret:        Gets a key vault secret
    UpdateAzKeyVaultSecret:     Updates the value of selected key vault secret
    RemoveAzKeyVaultSecret:     Removes a selected key vault secret
    GetAzKeyVault:              Gets key vault object
} #>
<# Variables: {
    :ManageAzureKeyVaultSecret  Outer loop for managing function
    $ManageAzKeyVaultSecretSel: Additional azure object needed to get main object
    $RGObject:                  Resource group object
    $KeyVaultObject:            Key vault object
    $KeyVaultSecretObject:      Key vault secret object
    NewAzKeyVaultSecret{}       Creates $KeyVaultSecretObject
        GetAzKeyVault{}             Gets $KeyVaultSecret
            GetAzResourceGroup{}        Gets $RGObject
    ListAzKeyVaultSecret{}      Lists all secrets in subscription
    GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
        GetAzKeyVault{}             Gets $KeyVaultObject
            GetAzResourceGroup{}        Gets $RGObject 
    GetAzKeyVaultSecretValue{}  Lists value of $KeyVaultSecretObject
        GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
            GetAzKeyVault{}             Gets $KeyVaultObject
                GetAzResourceGroup{}        Gets $RGObject
    UpdateAzKeyVaultSecret{}    Updates $KeyVaultSecretObject
        GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
            GetAzKeyVault{}             Gets $KeyVaultObject
                GetAzResourceGroup{}        Gets $RGObject   
    RemoveAzKeyVaultSecret{}    Removes $KeyVaultSecretObject
        GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
            GetAzKeyVault{}             Gets $KeyVaultObject
                GetAzResourceGroup{}        Gets $RGObject   
} #>
<# Process Flow {
    Function
        Call ManageAzKeyVaultSecret > Get $KeyVaultSecretObject
            Call NewAzKeyVaultSecret > Get $KeyVaultSecretObject
                Call GetAzKeyVault > Get $KeyVaultObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzKeyVault > Send $RGObject
                End GetAzKeyVault
                    Return NewAzKeyVaultSecret > Send $KeyVaultObject  
            End NewAzKeyVaultSecret
                Return ManageAzKeyVaultSecret > Send $KeyVaultSecretObject
            Call ListAzKeyVaultSecret > Get $null
            End ListAzKeyVaultSecret
                Return ManageAzKeyVaultSecret > Send $null          
            Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                Call GetAzKeyVault > Get $KeyVaultObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzKeyVault > Send $RGObject
                End GetAzKeyVault
                    Return GetAzKeyVaultSecret > Send $KeyVaultObject
            End GetAzKeyVaultSecret 
                Return ManageAzKeyVaultSecret> Send $KeyVaultSecretObject            
            Call GetAzKeyVaultSecretValue > Get $null
                Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                    Call GetAzKeyVault > Get $KeyVaultObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzKeyVault > Send $RGObject
                    End GetAzKeyVault
                        Return GetAzKeyVaultSecret > Send $KeyVaultObject
                End GetAzKeyVaultSecret
                    Return GetAzKeyVaultSecretValue > Send $KeyVaultSecretObject  
            End GetAzKeyVaultSecretValue
                Return ManageAzKeyVaultSecret > Send $null                   
            Call RemoveAzKeyVaultSecret > Get $null
                Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                    Call GetAzKeyVault > Get $KeyVaultObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzKeyVault > Send $RGObject
                    End GetAzKeyVault
                        Return GetAzKeyVaultSecret > Send $KeyVaultObject
                End GetAzKeyVaultSecret
                    Return RemoveAzKeyVaultSecret > Send $KeyVaultSecretObject  
            End RemoveAzKeyVaultSecret
                Return ManageAzKeyVaultSecret > Send $null   
        End ManageAzKeyVaultSecret
            Return Function > Send $KeyVaultSecretObject
}#>
function ManageAzKeyVaultSecret {                                                           # Function for managing key vault secrets
    Begin {                                                                                 # Begin function
        :ManageAzureKeyVaultSecret while ($true) {                                          # Outer loop for managing function
            Write-Host '[0] To exit'                                                        # Write message to screen
            Write-Host '[1] New Key Vault Secret'                                           # Write message to screen
            Write-Host '[2] List All Key Vaults Secret'                                     # Write message to screen
            Write-Host '[3] Get Key Vault Secret Value'                                     # Write message to screen
            Write-Host '[4] Update Key Vault Secret Value'                                  # Write message to screen
            Write-Host '[5] Remove Key Vault Secret Value'                                  # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the management function
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureKeyVaultSecret                                             # Breaks :ManageAzureKeyVaultSecret
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'            
                Write-Host 'New Key Vault Secret'                                           # Write message to screen
                NewAzKeyVaultSecret                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'            
                Write-Host 'List All Key Vaults Secrets'                                    # Write message to screen
                ListAzKeyVaultSecret                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'            
                Write-Host 'Get Key Vault Secret Value'                                     # Write message to screen
                GetAzKeyVaultSecretValue                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'            
                Write-Host 'Update Key Vault Secret Value'                                  # Write message to screen
                UpdateAzKeyVaultSecret                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'            
                Write-Host 'Remove Key Vault Secret Value'                                  # Write message to screen
                RemoveAzKeyVaultSecret                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
            }                                                                               # End else (if ($OpSelect -eq '0'))
            Clear-Host                                                                      # Clears screen
        }                                                                                   # End :ManageAzureKeyVaultSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statemnt
}                                                                                           # End function ManageAzKeyVaultSecret
function NewAzKeyVaultSecret {                                                              # Function to create a new key vault secret
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'NewAzKeyVaultSecret'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        :NewAzureKVSecret while ($true) {                                                   # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $Var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break NewAzureKVSecret                                                      # Breaks :NewAzureKVSecret
            }                                                                               # End if (!$KeyVaultObject)
            :NewAzureKVSecretName while ($true) {                                           # Inner loop for setting the new key vault secret name
                Write-Host 'Please enter the name of the new secret'                        # Write message to screen
                $KeyVaultSecretName = Read-Host 'Secret name'                               # Operator input for the secret name
                Write-Host 'Use:'$KeyVaultSecretName 'as the secret name'                   # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of name
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is equal to 'e'
                    Break NewAzureKVSecret                                                  # Breaks :NewAzureKVSecret
                }                                                                           # End if ($OpConfirm -eq 'e')
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm is equal to 'y'
                    Clear-Host                                                              # Clears screen
                    Break NewAzureKVSecretName                                              # Breaks :NewAzureKVSecretName
                }                                                                           # End if ($OpConfirm -eq 'y')
                Clear-Host                                                                  # Clears screen
            }                                                                               # End :NewAzureKVSecretName while ($true)
            :NewAzureKVSecretValue while ($true) {                                          # Inner loop for setting the new key vault secret value
                Write-Host 'Please enter the value of the new secret'                       # Write message to screen
                $KeyVaultSecretValue = Read-Host Read-Host 'Secret value'                   # Operator input for the secret value
                Write-Host 'Use:'$KeyVaultSecretValue 'as the secret value'                 # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of name
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is equal to 'e'
                    Break NewAzureKVSecret                                                  # Breaks :NewAzureKVSecret
                }                                                                           # End if ($OpConfirm -eq 'e')
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm is equal to 'y'
                    Clear-Host                                                              # Clears screen
                    $KeyVaultSecretHash = ConvertTo-SecureString -String `
                        $KeyVaultSecretValue -AsPlainText -Force                            # Converts the secret to a hashed value
                    Break NewAzureKVSecretValue                                             # Breaks :NewAzureKVSecretValue
                }                                                                           # End if ($OpConfirm -eq 'y')
                Clear-Host                                                                  # Clears screen
            }                                                                               # End :NewAzureKVSecretValue while ($true)
            Try {                                                                           # Try the following
                Set-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName -Name `
                    $KeyVaultSecretName -SecretValue $KeyVaultSecretHash `
                    -ErrorAction 'Stop'                                                     # Creates new secret
            }                                                                               # End Try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have the'                                           # Write message to screen
                Write-Host 'permissions to do this'                                         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureKVSecret                                                      # Breaks :NewAzureKVSecret
            }                                                                               # End Catch
            Write-Host 'The secret has been created'                                        # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureKVSecret                                                          # Breaks :NewAzureKVSecret
        }                                                                                   # End :NewAzureKVSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzKeyVaultSecret
function ListAzKeyVaultSecret {                                                             # Function to list all key vault secrets
    Begin {                                                                                 # Begin function
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        $KVList = Get-AzKeyVault                                                            # Creates lists of all key vaults
        foreach ($VaultName in $KVList) {                                                   # For each key vault in $KVList
            Write-Host '------------------------------------------------------------------' # Write message to screen
            $KVSecretlist = Get-AzKeyVaultSecret -VaultName $VaultName.VaultName            # Creates a list of all secrets in current $VaultName
            Write-Host 'Vault Name: ' $VaultName.VaultName                                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if ($KVSecretlist) {                                                            # If $KVSecretList has a value
                foreach ($Name in $KVSecretlist) {                                          # For each secret name in $KVSecretList
                    Write-Host 'Secret Name:' $Name.Name                                    # Write message to screen
                    Write-Host 'Secret ID:  ' $Name.ID                                      # Write message to screen
                    Write-Host 'Enabled:    ' $Name.Enabled                                 # Write message to screen
                    Write-Host 'Updated:    ' $Name.Updated                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($Name in $KVSecretlist)
            }                                                                               # End if ($KVSecretlist)
            else {                                                                          # If $KVSecretlist does not have a value
                Write-Host 'No secrets in this vault'                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End else (if ($KVSecretlist))
        }                                                                                   # End foreach ($VaultName in $KVList)
        Write-Host '------------------------------------------------------------------'     # Write message to screen
        Pause                                                                               # Pauses all action for operator input
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin 
}                                                                                           # End function ListAzKeyVaultSecret
function GetAzKeyVaultSecret { # Function to get a key vault secret
    Begin {
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :GetAzureKeyVaultSecret while ($true) { # Outer loop for managing function
            if (!$KeyVaultObject) { # If $KeyVaultObject is $null 
                $KeyVaultObject = GetAzKeyVault # Calls function and assigns output to $var
                if (!$KeyVaultObject) { # If $var is still $null
                    Break GetAzureKeyVaultSecret # Breaks :GetAzureKeyVaultSecret    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            $KVSecretlist = Get-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName # Creates list of all secrets in vault
            if (!$KVSecretlist) { # If $KVSecretlist returns empty
                Write-Host "No secrets found" # Message write to screen
                Break GetAzureKeyVaultSecret # Breaks :GetAzureKeyVaultSecret
            } # End if (!$KVSecretlist)
            $KVSecretlistNumber = 1 # Sets the base value of the list
            Write-Host "0. Exit" # Write message to screen
            foreach ($_ in $KVSecretlist) { # For each item in list
                Write-Host $KVSecretlistNumber"." $_.Name # Writes list to screen
                $KVSecretlistNumber = $KVSecretlistNumber+1 # Adds 1 to $KVSecretlistNumber
            } # End foreach ($_ in $KVSecretlist) 
            $KVSecretlistNumber = 1 # Resets list number to 1
            $KVSecretlistSelect = Read-Host "Enter the option number" # Operator input to select from list
            if ($KVSecretlistSelect -eq '0') { # If $KVSecretListSelect is 0
                Break GetAzureKeyVaultSecret # Breaks :GetAzureKeyVaultSecret
            } # End if ($KVSecretlistSelect -eq '0')
            :SelectAzureKeyVaultSecret foreach ($_ in $KVSecretlist) { # For each item in list
                if ($KVSecretlistSelect -eq $KVSecretlistNumber) { # If the user input matches the current $KVSecretlistNumber
                    $KeyVaultSecretObject = Get-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName -Name $_.Name # Collects the full $KeyVaultSecretObject
                    Break SelectAzureKeyVaultSecret # Breaks :SelectAzureKeyVaultSecret
                } # End if ($KVSecretlistSelect -eq $KVSecretlistNumber)
                else { # If user input does not match the current $KVSecretlistNumber
                    $KVSecretlistNumber = $KVSecretlistNumber+1 # Adds 1 to $KVSecretlistNumber
                } # End else (if ($KVSecretlistSelect -eq $KVSecretlistNumber))
            } # End :SelectAzureKeyVaultSecret
            Return $KeyVaultSecretObject # Returns $KeyVaultSecretObject to calling function
        } # End :GetAzureKeyVaultSecret while ($true) {
        Return # Returns $null to calling function
    } # End begin statement
} # End GetAzKeyVaultSecret
function GetAzKeyVaultSecretValue { # Function to return the value of a key vault secret
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        :GetAzureKeyVaultSecretVal while ($true) { # Outer loop for managing function
            if (!$KeyVaultSecretObject) { # If $var is $null
                $KeyVaultSecretObject = GetAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function and assigns output to $Var
                if (!$KeyVaultSecretObject) { # If $var is $null
                    Break GetAzureKeyVaultSecretVal # Breaks :GetAzureKeyVaultSecretVal
                } # End if (!$KeyVaultSecretObject)
            } # End if (!$KeyVaultSecretObject)
            $KeyVaultSecretValue = $null # Clears $KeyVaultSecretValue from all previous use
            $KeyVaultSecretHash = $null # Clears $KeyVaultSecretHash from all previous use
            $KeyVaultSecretHash = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($KeyVaultSecretObject.SecretValue) # Provided by MS Azure
            try { # Provided by MS Azure
                $KeyVaultSecretValue = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($KeyVaultSecretHash) # Provided by MS Azure
            } # Provided by MS Azure
            Catch { # Catch for try statement
                Write-Host "An error has occured, you may not have permissions to this secret or vault" # Write message to screen
                Break GetAzureKeyVaultSecretVal # Breaks :GetAzureKeyVaultSecretVal
            } # End catch
            finally { # Provided by MS Azure
                [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($KeyVaultSecretHash) # Provided by MS Azure
            } # Provided by MS Azure # This code was provided by MS, at this time is not needed and has commented out
            Write-Host "The value of"$KeyVaultSecretObject.Name "is:" $KeyVaultSecretValue # Prints secret name and value to screen
            Break GetAzureKeyVaultSecretVal # Breaks :GetAzureKeyVaultSecretVal
        } # End :GetAzureKeyVaultSecretValue while ($true) 
        Return # Returns to calling function with $null
    } # End begin statement   
} # End function GetAzKeyVaultSecretValue
function UpdateAzKeyVaultSecret { # Updates the value of selected key
    Begin { 
        :UpdateAzureKeyVaultSecret while ($true) { # Outer loop for managing funciton
            if (!$KeyVaultSecretObject) { # If $var is $null
                $KeyVaultSecretObject = GetAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function and assigns output to $Var
                if (!$KeyVaultSecretObject) { # If $var is $null
                    Break UpdateAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret
                } # End if (!$KeyVaultSecretObject)
            } # End if (!$KeyVaultSecretObject)
            :UpdateAzureKVSecretValue while ($true) { # Inner loop for updating key vault secret value
                $KeyVaultSecretValue = Read-Host "New key vault secret value for"$KeyVaultSecretObject.Name # Prompt for operator input for $KeyVaultSecretvalue
                if ($KeyVaultSecretValue -eq 'exit') { # If $KeyVaultSecretValue is equal to 'exit'
                    Break UpdateAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if ($KeyVaultSecretValue -eq 'exit')
                Write-Host $KeyVaultSecretValue # Write message to screen
                $OperatorConfirm = Read-Host "Use this as the secret value [Y] or [N]" # Operator confirmation of value
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm is equal to 'y'
                    Break UpdateAzureKVSecretValue # Breaks :UpdateAzureKVSecretValue
                } # End if ($OperatorConfirm -eq 'y')
            } # End :UpdateAzureKVSecretValue while ($true)
            $KeyVaultSecretHash = ConvertTo-SecureString -String $KeyVaultSecretValue -AsPlainText -Force # Converts the operator input to secure string
            try { # Try to do the following
                $KeyVaultSecretObject = Set-AzKeyVaultSecret -VaultName $KeyVaultSecretObject.VaultName -Name $KeyVaultSecretObject.Name -SecretValue $KeyVaultSecretHash # Updates $KeyVaultSecretObject
            } # End Try
            catch { # If try statement fails
                Write-Host "There was an issue updating this secret" # Write message to screen
                Write-Host "You may not have the permissions to modify this secret" # Write message to screen
                Break UpdateAzureKeyVaultSecret # Breaks :UpdateAzureKVSecretValue 
            } # End catch
            Write-Host $KeyVaultSecretObject.Name"has been updated with the new value" # Write message to screen
            Break UpdateAzureKeyVaultSecret # Breaks :UpdateAzureKVSecretValue
        } # End  :UpdateAzureKeyVaultSecret while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function UpdateAzKeyVaultSecret
function RemoveAzKeyVaultSecret {
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        :RemoveAzureKeyVaultSecret while ($true) { # Outer loop for managing function
            if (!$KeyVaultSecretObject) { # If $var is $null
                $KeyVaultSecretObject = GetAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function and assigns output to $Var
                if (!$KeyVaultSecretObject) { # If $var is $null
                    Break RemoveAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret
                } # End if (!$KeyVaultSecretObject)
            } # End if (!$KeyVaultSecretObject)
            Write-host "The selected secret for removal is:"$KeyVaultSecretObject.Name"in vault:"$KeyVaultSecretObject.VaultName # Write message to screen
            $ConfirmDelete = Read-Host "Remove this secret [Y] or [N]" # Operator confirmation for deletion
            if (!($ConfirmDelete -eq 'y')) { # $Confirm delete is not equal to 'y'
                Break RemoveAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret
            } # End if (!($ConfirmDelete -eq 'y'))
            else { # If $ConfirmDelete is equal to 'y'
                Write-Host "Removing" $KeyVaultSecretObject.Name # Write message to screen
                Try { # Try the following
                    Remove-AzKeyVaultSecret -Name $KeyVaultSecretObject.Name -VaultName $KeyVaultSecretObject.VaultName -Force # Removes the selected key
                } # End Try
                catch { # If error on Try
                    Write-Host "There was an issue removing the selected key" # Write message to screen
                    Write-Host "You may not have the permissions to remove this key" # Write message to screen
                    Break RemoveAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret 
                } # End catch
                Write-Host "This secret has been removed" # Write message to screen
                Break RemoveAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret
            } # End else (if (!($ConfirmDelete -eq 'y')))
        } # End :RemoveAzureKeyVaultSecret while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function RemoveAzKeyVaultSecret
# Additional functions for ManageAzKeyVaultSecret
function GetAzKeyVault {                                                                    # Function to get a key vault object
    Begin {                                                                                 # Begin function
        :GetAzureKeyVault while ($true) {                                                   # Outer loop for managing function
            $ObjectList = Get-AzKeyVault                                                    # Gets all key vaults and assigns to $ObjectList
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Number' = $ObjectNumber; `
                'Name'=$_.VaultName;'RG'=$_.ResourceGroupName;'Loc' = $_.Location}          # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host '[0]  Exit'                                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number] "$_.Name                                          # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]"$_.Name                                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9))
                Write-Host 'RG Name: '$_.RG                                                 # Write message to screen
                Write-Host 'Location:'$_.Loc                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureKeyVault while ($true) {                                            # Inner loop for selecting the key vault
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host 'You are selecting the key vault for:'$CallingFunction       # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Enter option[#]'                                     # Operator input for the key vault selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureKeyVault                                                  # Breaks :GetAzureKeyVault
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $OpSelect                                  
                    $KeyVaultObject = Get-AzKeyVault -VaultName $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full key vault object
                    Clear-Host                                                              # Clears screen
                    Return $KeyVaultObject                                                  # Returns to calling function with $KeyVaultObject
                }                                                                           # End elseif ($RGSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureKeyVault while ($true)
        }                                                                                   # End :GetAzureKeyVault while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzKeyVault
