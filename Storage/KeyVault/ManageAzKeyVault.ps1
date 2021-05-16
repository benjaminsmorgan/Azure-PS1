# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    New-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/new-azkeyvault?view=azps-5.3.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Remove-AzKeyVault:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvault?view=azps-5.3.0
    Get-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultkey?view=azps-5.4.0
    Add-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/add-azkeyvaultkey?view=azps-5.4.0
    Remove-AzKeyVaultKey:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultkey?view=azps-5.4.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Set-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/set-azkeyvaultsecret?view=azps-5.1.0
    Remove-AzKeyVaultSecret:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultsecret?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/NewAzKeyVault.ps1
    ListAzKeyVault:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/ListAzKeyVault.ps1
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
    RemoveAzKeyVault:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/RemoveAzKeyVault.ps1
    ManageAzKeyVaultKey:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/ManageAzKeyVaultKey.ps1
        NewAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/NewAzKeyVaultKey.ps1
        AddAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/AddAzKeyVaultKey.ps1
        ListAzKeyVaultKey:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/ListAzKeyVaultKey.ps1
        GetAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/GetAzKeyVaultKey.ps1
        DownloadAzKeyVaultKey:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/DownloadAzKeyVaultKey.ps1
        RemoveAzKeyVaultKey:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/RemoveAzKeyVaultKey.ps1
    ManageAzKeyVaultSecret:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/ManageAzKeyVaultSecret.ps1
        NewAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/NewAzKeyVaultSecret.ps1
        ListAzKeyVaultSecret:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/ListAzKeyVaultSecret.ps1
        GetAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecret.ps1
        GetAzKeyVaultSecretValue:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecretValue.ps1
        UpdateAzKeyVaultSecret:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/UpdateAzKeyVaultSecret.ps1
        RemoveAzKeyVaultSecret:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/RemoveAzKeyVaultSecret.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1 
} #>
<# Functions Description: {
    ManageAzKeyVault:            Management function for key vaults
        NewAzKeyVault:              Creates new key vault object
        ListAzKeyVault:             Lists all key vaults in subscription
        GetAzKeyVault:              Gets $KeyVaultObject
        RemoveAzKeyVault:           Removes $KeyVaultObject
        ManageAzKeyVaultKey:        Management function for key vault keys
            NewAzKeyVaultKey:           Creates a new key vault Key
            AddAzKeyVaultKey:           Uploads an existing key into vault
            ListAzKeyVaultKey:          Lists all key vault Keys by vault name
            GetAzKeyVaultKey:           Gets a key vault Key
            DownloadAzKeyVaultKey:      Downloads selected key vault Key
            RemoveAzKeyVaultKey:        Removes a selected key vault Key
        ManageAzKeyVaultSecret:     Management function for key vault secrets
            NewAzKeyVaultSecret:        Creates a new key vault secret
            ListAzKeyVaultSecret:       Lists all key vault secrets by vault name
            GetAzKeyVaultSecret:        Gets a key vault secret
            UpdateAzKeyVaultSecret:     Updates the value of selected key vault secret
            RemoveAzKeyVaultSecret:     Removes a selected key vault secret
        GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :ManageAureKeyVault         Outer loop for managing function
    $ManageAzKeyVaultSelect:    Operator input for selecting management function
    $RGObject:                  Resource group object
    $KeyVaultObject:            Key vault object
    NewAzKeyvault{}             Creates $KeyVaultObject
        GetAzResourceGroup{}        Gets $RGObject
    ListAzKeyVault{}            Lists all key vaults in subscription
    GetAzKeyVault{}             Gets $KeyVaultObject
        GetAzResourceGroup{}        Gets $RGObject
    RemoveAzKeyVault{}          Removes $KeyVaultObject
        GetAzKeyVault{}             Gets $KeyVaultObject
            GetAzResourceGroup{}        Gets $RGObject
    ManageAzKeyVaultKey{}       Manages $KeyVaultKeyObject
        NewAzKeyVaultKey{}          Creates $KeyVaultKeyObject
            GetAzKeyVault{}             Gets $KeyVaultObject
        AddAzKeyVaultKey{}          Uploads $KeyVaultKeyObject
            GetAzKeyVault{}             Gets $KeyVaultObject
        ListAzKeyVaultKey{}         Lists all key vault keys in vault
            GetAzKeyVault{}             Gets $KeyVaultObject
                GetAzResourceGroup{}        Gets $RGObject
        RemoveAzKeyVaultKey{}       Removes $KeyVaultKeyObject
            GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
                GetAzKeyVault{}             Gets $KeyVaultObject
    ManageAzKeyVaultSecret{}    Manages $KeyVaultSecretObject
        NewAzKeyVaultSecret{}       Creates $KeyVaultSecretObject
            GetAzKeyVault{}             Gets $KeyVaultSecret
        ListAzKeyVaultSecret{}      Lists all secrets in subscription
        GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
            GetAzKeyVault{}             Gets $KeyVaultObject
        GetAzKeyVaultSecretValue{}  Lists value of $KeyVaultSecretObject
            GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
                GetAzKeyVault{}             Gets $KeyVaultObject
        UpdateAzKeyVaultSecret{}    Updates $KeyVaultSecretObject
            GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
                GetAzKeyVault{}             Gets $KeyVaultObject
        RemoveAzKeyVaultSecret{}    Removes $KeyVaultSecretObject
            GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
                GetAzKeyVault{}             Gets $KeyVaultObject
} #>
<# Process Flow {
    Function
        Call ManageAzKeyVault > Get $null
            Call NewAzKeyvault
                Call GetAzResource Group > Get $RGObject
                End GetAzResourceGroup
                    Return NewAzKeyVault > Send $RGObject
            End NewAzKeyvault
                Return ManageAzKeyVault > Send $KeyVaultObject
            Call ListAzKeyVault
            End ListAzKeyVault
                Return ManageAzKeyVault > Send $null
            Call GetAzKeyVault
                Call GetAzResource Group > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzKeyVault > Send $RGObject
            End GetAzKeyVault
                Return ManageAzKeyVault > Send $KeyVaultObject
            Call RemoveAzKeyVault
                Call GetAzKeyVault
                    Call GetAzResource Group > Get $RGObject
                    End GetAzResourceGroup
                    Return GetAzKeyVault > Send $RGObject
                End GetAzKeyVault
                Return RemoveAzKeyVault > Send $KeyVaultObject
            End RemoveAzKeyVault
                Return ManageAzKeyVault > Send $null    
            Call ManageAzKeyVaultKey > Get $null
                Call NewAzKeyVaultKey > Get $null
                    Call GetAzKeyVault > Get $KeyVaultObject
                    End GetAzKeyVault
                        Return NewAzKeyVaultKey > Send $KeyVaultObject  
                End NewAzKeyVaultKey
                    Return ManageAzKeyVaultKey > Send $null
                Call AddAzKeyVaultKey > Get $null
                    Call GetAzKeyVault > Get $KeyVaultObject
                    End GetAzKeyVault
                        Return AddAzKeyVaultKey > Send $KeyVaultObject  
                End AddAzKeyVaultKey
                    Return ManageAzKeyVaultKey > Send $null
                Call ListAzKeyVaultKey > Get $null
                End ListAzKeyVaultKey
                    Return ManageAzKeyVaultKey > Send $null
                Call DownloadKeyVaultKey > Get $null
                    Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
                        Call GetAzKeyVault > Get $KeyVault
                        End GetAzKeyVault
                            Return GetAzKeyVaultKey > Send $KeyVault
                    End GetAzKeyVaultKey
                        Return DownloadKeyVaultKey > Send $KeyVaultKeyObject
                End DownloadKeyVaultKey
                    Return ManageAzKeyVaultKey > Send $null
                Call RemoveAzKeyVaultKey > Get $null
                    Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                        End GetAzKeyVault
                            Return GetAzKeyVaultKey > Send $KeyVaultObject
                    End GetAzKeyVaultKey
                        Return RemoveAzKeyVaultKey > Send $KeyVaultKeyObject  
                End RemoveAzKeyVaultKey
                    Return ManageAzKeyVaultKey > Send $null
            End ManageAzKeyVaultKey
                Return ManageAzKeyVault > Send $null                
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
                Return ManageAzKeyVault > Send $null
        End ManageAzKeyVault
            Return function > Send $null
}#>
function ManageAzKeyVault {                                                                 # Function for managing Azure key vaults
    Begin {                                                                                 # Begin function
        :ManageAzureKeyVault while ($true) {                                                # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Key Vault'                                                  # Write message to screen
            Write-Host '[2] List All Key Vaults'                                            # Write message to screen
            Write-Host '[3] Remove Key Vault'                                               # Write message to screen
            Write-Host '[4] Manage Key Vault Keys'                                          # Write message to screen
            Write-Host '[5] Manage Key Vault Secrets'                                       # Write message to screen
            Write-Host '[6] Manage Key Vault Certificates'                                  # Write message to screen
            $OpSelect= Read-Host 'Select option [#]'                                        # Operator input for which option they need to run
            Clear-Host                                                                      # Clears screen
            if ($OpSelect-eq '0') {                                                         # If $OpSelect equals '0'
                Break ManageAzureKeyVault                                                   # Breaks :ManageAzureKeyVault
            }                                                                               # End if ($OpSelect-eq '0')
            elseif ($OpSelect-eq '1') {                                                     # Else if $OpSelect equals '1'                  
                Write-Host 'New Key Vault'                                                  # Write message to screen
                NewAzKeyVault                                                               # Calls function 
            }                                                                               # End elseif ($OpSelect-eq '1')
            elseif ($OpSelect-eq '2') {                                                     # Else if $OpSelect equals '2'                  
                Write-Host 'List All Key Vaults'                                            # Write message to screen
                ListAzKeyVault                                                              # Calls function 
            }                                                                               # End elseif ($OpSelect-eq '2')
            elseif ($OpSelect-eq '3') {                                                     # Else if $OpSelect equals '3'                  
                Write-Host 'Remove Key Vault'                                               # Write message to screen
                RemoveAzKeyVault                                                            # Calls function 
            }                                                                               # End elseif ($OpSelect-eq '3')
            elseif ($OpSelect-eq '4') {                                                     # Else if $OpSelect equals '4'                  
                Write-Host 'Manage Key Vault Keys'                                          # Write message to screen
                ManageAzKeyVaultKey                                                         # Calls function 
            }                                                                               # End elseif ($OpSelect-eq '4')
            elseif ($OpSelect-eq '5') {                                                     # Else if $OpSelect equals '5'                  
                Write-Host 'Manage Key Vault Secrets'                                       # Write message to screen
                ManageAzKeyVaultSecret                                                      # Calls function 
            }                                                                               # End elseif ($OpSelect-eq '5')
            elseif ($OpSelect-eq '6') {                                                     # Else if $OpSelect equals '6'                  
                Write-Host 'Manage Key Vault Certificates'                                  # Write message to screen
                #ManageAzKeyVaultCert                                                        # Calls function 
            }                                                                               # End elseif ($OpSelect-eq '6')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect-eq '0'))
        }                                                                                   # End :ManageAzureKeyVault while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ManageAzKeyVault
function NewAzKeyVault {                                                                    # Function to create a new key vault
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Turns off error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'NewAzKeyVault'                                              # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureKeyVault while ($true) {                                                   # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureKeyVault                                                      # Breaks :NewAzureKeyVault
            }                                                                               # End if (!$RGObject)
            $LocationObject = GetAzLocation ($CallingFunction)                              # Calls function and assigns output to var
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                Break NewAzureKeyVault                                                      # Breaks :NewAzureKeyVault
            }                                                                               # End if (!$LocationObject)
            :SetAzureKeyVaultName while ($true) {                                           # Inner loop for setting the key vault name
                $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-'                       # Creates a string of valid characters
                $ValidArray = $ValidArray.ToCharArray()                                     # Loads all valid characters into array
                Write-Host 'Vault name must be atleast 3 characters'                        # Write message to screen
                Write-Host 'and made up of letters and numbers only'                        # Write message to screen
                $VaultNameArray = $null                                                     # Clears $VaultNameArray
                $VaultNameInput = Read-Host 'Vault name'                                    # Operator input for the share name
                if ($VaultNameInput.Length -ge 3) {                                         # If $ValutNameinput is 3 or more characters
                    $VaultNameArray = $VaultNameInput.ToCharArray()                         # Creates $VaultNameInput
                    $VaultNameLast = $VaultNameInput.Length                                 # Gets total character count of $VaultNameInput
                    $VaultNameLast = $VaultNameLast - 1                                     # Reduces $VaultNameLast by one to match index
                    if ($VaultNameArray[0] -eq '-') {                                       # If $VaultNameArray first entry equals '-'
                        Write-Host ''                                                       # Write message to screen
                        Write-Host "Vault name first character cannot be '-'"               # Write message to screen
                        $VaultNameInput = $null                                             # Clears $VaultNameInput
                    }                                                                       # End if ($VaultNameArray[0] -eq '-')
                    if ($VaultNameArray[$VaultNameLast] -eq '-') {                          # If $VaultNameArray Last entry equals '-'
                        Write-Host ''                                                       # Write message to screen
                        Write-Host "Vault name last character cannot be '-'"                # Write message to screen
                        $VaultNameInput = $null                                             # Clears $VaultNameInput
                    }                                                                       # End if ($VaultNameArray[0] -eq '-')
                    foreach ($_ in $VaultNameArray) {                                       # For each item in $VaultNameArray
                        if ($_ -notin $ValidArray) {                                        # If current item is not in $ValidArray
                            if ($_ -eq ' ') {                                               # If current item equals 'space'
                                Write-Host ''                                               # Write message to screen    
                                Write-Host 'Vault name cannot include any spaces'           # Write message to screen
                            }                                                               # End if ($_ -eq ' ')
                            else {                                                          # If current item is not equal to 'space'
                                Write-Host ''                                               # Write message to screen    
                                Write-Host $_' is not a valid character'                    # Write message to screen
                            }                                                               # End else (if ($_ -eq ' '))
                            $VaultNameInput = $null                                         # Clears $VaultNameInput
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $VaultNameArray)
                    if (!$VaultNameInput) {                                                 # If $VaultNameInput is $null
                        Pause                                                               # Pauses for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End if ($VaultNameInput -eq '0')
                    else {                                                                  # If $VaultNameInput not equal to '0'
                        Write-Host $VaultNameInput 'is correct'                             # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of share name input
                        if ($OpConfirm -eq 'e') {                                           # If $OpConfirm equals 'e'
                            Break NewAzureKeyVault                                          # Breaks NewAzureKeyVault
                        }                                                                   # End if ($OpConfirm -eq 'e')
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm is equal to 'y'
                            Clear-Host                                                      # Clears screen
                            Break SetAzureKeyVaultName                                      # Breaks :SetAzureKeyVaultName
                        }                                                                   # End if ($OpConfirm -eq 'y')
                    }                                                                       # End else (if (!$VaultNameInput))
                }                                                                           # End if ($VaultNameInput.Length -ge 3)
                else {                                                                      # If $KeyVaultNameInput is less than 3 characters
                    Write-Host 'Vault name must be atleast 3 characters'                    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($VaultNameInput.Length -ge 3))
            }                                                                               # :SetAzureKeyVaultName while ($true)
            Try {                                                                           # Try the following
                New-AzKeyVault -ResourceGroupName $RGObject.ResourceGroupName `
                    -Location $LocationObject.DisplayName -Name $VaultNameInput `
                    -ErrorAction 'Stop'                                                     # Creates the key vault
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-Host 'The vault name may already be in use'                           # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureKeyVault                                                      # Breaks :NewAzureKeyVault
            }                                                                               # End catch
            Write-Host 'The key vault has been created'                                     # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureKeyVault                                                          # Breaks :NewAzureKeyVault
        }                                                                                   # End :NewAzureKeyVault while ($true)
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzkeyvault
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
function ListAzKeyVault {                                                                   # Function to list a key vault objects
    Begin {                                                                                 # Begin function
        :ListAzureKeyVault while ($true) {                                                  # Outer loop for managing function
            $ObjectList = Get-AzKeyVault                                                    # Gets all key vaults and assigns to $ObjectList
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name'=$_.VaultName; `
                'RG'=$_.ResourceGroupName;'Loc' = $_.Location}                              # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Vault name:'$_.Name                                             # Write message to screen
                Write-Host 'RG Name:   '$_.RG                                               # Write message to screen
                Write-Host 'Location:  '$_.Loc                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureKeyVault                                                         # Breaks :ListAzureKeyVault
        }                                                                                   # End :ListAzureKeyVault while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzKeyVault
function RemoveAzKeyVault {                                                                 # Function to remove a key vault object
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzKeyVault'                                           # Creates $Calling function
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureKeyVault while ($true) {                                                # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break RemoveAzureKeyVault                                                   # Breaks :RemoveAzureKeyVault
            }                                                                               # End if (!$KeyVaultObject)
            Write-Host 'Remove Vault: '$KeyVaultObject.VaultName                            # Write message to screen
            Write-Host 'from resource group: '$KeyVaultObject.ResourceGroupName             # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Write message to screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing:'$KeyVaultObject.VaultName                             # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzKeyVault -VaultName $KeyVaultObject.VaultName `
                        -ResourceGroupName $KeyVaultObject.ResourceGroupName -force `
                        -ErrorAction 'Stop'                                                 # Removes the key vault
                }                                                                           # End try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'This resource maybe locked'                                 # Write message to screen
                    Write-Host 'The resource group maybe locked'                            # Write message to screen
                    Write-Host 'You may not have the permissions'                           # Write message to screen
                    Write-Host 'To perform a remove action'                                 # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Break RemoveAzureKeyVault                                               # Breaks :RemoveAzureKeyVault
                }                                                                           # End catch
                Write-Host $KeyVaultObject.VaultName 'has been removed'                     # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break RemoveAzureKeyVault                                                   # Breaks :RemoveAzureKeyVault
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break RemoveAzureKeyVault                                                   # Breaks :RemoveAzureKeyVault
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureKeyVault while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzKeyVault
# Functions for ManageAzKeyVaultKey
function ManageAzKeyVaultKey {                                                              # Function for managing key vault keys
    Begin {                                                                                 # Begin function
        :ManageAzureKeyVaultKey while ($true) {                                             # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Key Vault Key'                                              # Write message to screen
            Write-Host '[2] Add Key Vault Key'                                              # Write message to screen
            Write-Host '[3] List All Key Vaults Keys'                                       # Write message to screen
            Write-Host '[4] Download Key Vault Key'                                         # Write message to screen
            Write-Host '[5] Remove Key Vault Key'                                           # Write message to screen
            $OpSelect = Read-Host 'Chose option [#]'                                        # Operator selection for management function
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureKeyVaultKey                                                # Breaks :ManageAzureKeyVaultKey
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Elseif $OpSelect equals '1'
                Write-Host 'New Key Vault Key'                                              # Write message to screen
                NewAzKeyVaultKey                                                            # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Elseif $OpSelect equals '2'
                Write-Host 'Add Key Vault Key'                                              # Write message to screen
                AddAzKeyVaultKey                                                            # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Elseif $OpSelect equals '3'
                Write-Host 'List All Key Vaults Keys'                                       # Write message to screen
                ListAzKeyVaultKey                                                           # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Elseif $OpSelect equals '4'
                Write-Host 'Download Key Vault Key'                                         # Write message to screen
                DownloadAzKeyVaultKey                                                       # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Elseif $OpSelect equals '5'
                Write-Host 'Remove Key Vault Key'                                           # Write message to screen
                RemoveAzKeyVaultKey                                                         # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '5')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureKeyVaultKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statemnt
}                                                                                           # End function ManageAzKeyVaultKey
function NewAzKeyVaultKey {                                                                 # Function to create a new key vault key
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not exist
            $CallingFunction = 'NewAzKeyVaultKey'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureKeyVaultKey while ($true) {                                                # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break NewAzureKeyVaultKey                                                   # Breaks :NewAzureKeyVaultKey    
            }                                                                               # End if (!$KeyVaultObject)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789'                            # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            :AzureKeyVaultKeyName while ($true) {                                           # Inner loop for setting $KeyVaultKeyObject name
                $KeyVaultKeyNameInput = $null                                               # Clears $KeyVaultKeyNameInput
                Write-Host 'Key name may only include letters and numbers'                  # Write message to screen
                Write-Host 'Key name cannot inlude any spaces'                              # Write message to screen
                Write-Host 'Key name must be less that 64 characters'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $KeyVaultKeyNameInput = Read-Host 'Key name'                                # Operator input for the key name
                $KeyVaultKeyNameArray = $KeyVaultKeyNameInput.ToCharArray()                 # Creates an array from $KeyVaultKeyNameInput 
                if ($KeyVaultKeyNameInput -eq 'exit') {                                     # $KeyVaultKeyNameInput is equal to exit
                    Break NewAzureKeyVaultKey                                               # Breaks :NewAzureKeyVaultkey
                }                                                                           # if ($KeyVaultKeyNameInput -eq 'exit')
                if ($KeyVaultKeyNameInput.Length -ge 64) {                                  # If $KeyVaultKeyNameInput is greater than 63 characters
                    Write-Host 'The key name must be less than 64 characters'               # Write message to screen
                    $KeyVaultKeyNameInput = $null                                           # Clears $KeyVaultKeyNameInput                                   
                }                                                                           # End if ($KeyVaultKeyNameInput.Length -ge 63)
                foreach ($_ in $KeyVaultKeyNameArray) {
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Key name cannot include any spaces'                 # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $KeyVaultKeyNameInput = $null                                       # Clears $VaultNameInput
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $KeyVaultKeyNameArray)
                if (!$KeyVaultKeyNameInput) {                                               # If $KeyVaultNameInput is $null
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if (!$KeyVaultKeyNameInput)
                else {                                                                      # If $KeyVaultKeyNameInput has a value
                    Write-Host 'Use:' $KeyVaultKeyNameInput 'as key name'                   # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No'                                 # Operator confirmation of key name
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm is equal to 'y'
                        Clear-Host                                                          # Clears screen
                        Break AzureKeyVaultKeyName                                          # Breaks SetAzureKeyVaultName
                    }                                                                       # End If ($OpConfirm -eq 'y')
                }                                                                           # End else (if (!$KeyVaultKeyNameInput))
            }                                                                               # End :AzureKeyVaultKeyName while ($true)
            Write-Host 'Set an expiration date on this key'                                 # Write message to screen
            $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                                 # Operator input for setting a key expiration
            if ($OpSelect -eq 'e') {                                                        # If $OpSelect equals 'e'
                Break NewAzureKeyVaultKey                                                   # Breaks :NewAzureKeyVaultkey
            }                                                                               # End if ($OpSelect -eq 'e')
            if ($OpSelect -eq 'y') {                                                        # If $OpSelect equals 'y'
                :AzureKeyVaultKeyExpire while ($true) {                                     # Inner loop for setting expiration date
                    $StartDate = (Get-Date).Date                                            # Gets current date
                    Write-Host 'Enter the date in the following format: YYYY-MM-DD'         # Write message to screen
                    Write-Host 'Example: 2050-07-04 to have the key expire on 4 July 2050'  # Write message to screen
                    $EndDate = Read-Host 'Key expiration date'                              # Operator input for end date
                    if ($EndDate -eq 'exit') {                                              # If $EndDate equals 'exit'
                        Break NewAzureKeyVaultKey                                           # Breaks :NewAzureKeyVaultKey
                    }                                                                       # End if ($EndDate -eq 'exit')
                    $DateDiff = New-TimeSpan -Start $StartDate -End $EndDate                # Gets count of days between current and end date
                    if (!$DateDiff) {                                                       # If $DateDiff does not have a value (Result of bad $EndDate entry)
                        Write-Host 'The expiration date entry was not valid'                # Write message to screen
                        Write-Host 'Please enter a date in the listed format'               # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End if (!$DateDiff)
                    elseif ($DateDiff -le 0) {                                              # $DateDiff is 0 or less
                        Write-Host 'The date entered was not in the future'                 # Write message to screen
                        Write-Host 'Please enter a future date'                             # Write message to screen
                        $DateDiff = $null                                                   # Clears $DateDiff
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End elseif ($DateDiff -le 0) 
                    elseif ($DateDiff) {                                                    # If $DateDiff has a value of 1 or higher
                        $KeyExpires = (Get-Date).AddDays($DateDiff.Days).ToUniversalTime()  # Sets $KeyExpires to operator selected date
                        $KeyNotBefore = (Get-Date).ToUniversalTime()                        # Sets $KeyNotBefore to current date
                        Clear-Host                                                          # Clears screen
                        Break AzureKeyVaultKeyExpire                                        # Breaks :AzureKeyVaultKeyExpire
                    }                                                                       # End if ($DateDiff)
                }                                                                           # End AzureKeyVaultKeyExpire while ($true)
            }                                                                               # End if ($OpSelect -eq 'y')
            :AzureKeyVaultKeyEncrypt while ($true) {                                        # Inner loop for setting the encyption type
                Write-Host 'Select key encyption type'                                      # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] HSM'                                                        # Write message to screen
                Write-Host '[2] Software'                                                   # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for encryption type
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0' 
                    Break NewAzureKeyVaultKey                                               # Breaks :NewAzureKeyVaultKey
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $KeyEncryptType = 'HSM'                                                 # Sets $KeyEncryptType to 'HSM'
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $KeyEncryptType = 'Software'                                            # Sets $KeyEncryptType to 'Software'
                    Clear-Host                                                              # Clears screen
                    Break AzureKeyVaultKeyEncrypt                                           # Breaks :AzureKeyVaultKeyEncrypt
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break NewAzureKeyVaultKey                                               # Breaks :NewAzureKeyVaultKey
                }                                                                           # End else (if ($OpSelect -eq '0'))
                if ($KeyEncryptType -eq 'HSM') {                                            # If $KeyEncryptType is equal to 'HSM'
                    if ($KeyVaultObject.SKU -eq 'Standard') {                               # If $KeyVaultObject.SKU is equal to 'Standard'
                        Write-Host 'HSM is not supported on this key vault'                 # Write message to screen
                        Write-Host '[0] Exit'                                               # Write message to screen
                        Write-Host '[1] Change encryption to software'                      # Write message to screen
                        $OpSelect = Read-Host 'Option [#]'                                  # Operator input on changing type or exiting
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals '0'
                            Break NewAzureKeyVaultKey                                       # Breaks :NewAzureKeyVaultKey
                        }                                                                   # End if ($OpSelect -eq '0')
                        elseif ($OpSelect -eq '1') {                                        # Else if $OpSelect equals '1'
                            $KeyEncryptType = 'Software'                                    # Sets $KeyEncryptType to 'Software'
                            Clear-Host                                                      # Clears screen
                            Break AzureKeyVaultKeyEncrypt                                   # Breaks :AzureKeyVaultKeyEncrypt
                        }                                                                   # End elseif ($OpSelect -eq '1')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpSelect -eq '0'))
                    }                                                                       # End if ($KeyVaultObject.Sku -eq 'Standard')
                    else {                                                                  # If $KeyVaultObject.SKU does not equal 'standard'
                        Clear-Host                                                          # Clears screen
                        Break AzureKeyVaultKeyEncrypt                                       # Breaks :AzureKeyVaultKeyEncrypt 
                    }                                                                       # End else (if ($KeyVaultObject.Sku -eq 'Standard'))
                }                                                                           # End elseif ($KeyEncryptType -eq 'HSM')
            }                                                                               # End :AzureKeyVaultKeyEncrypt while ($true)
            if ($KeyNotBefore) {                                                            # If $KeyNotBefore has a value
                Try {                                                                       # Try the following
                    Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name `
                        $KeyVaultKeyNameInput -Destination $KeyEncryptType -Expires `
                        $KeyExpires -NotBefore $KeyNotBefore -ErrorAction 'Stop'            # Creates the new key
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions to preform this action'    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break NewAzureKeyVaultKey                                               # Breaks :NewAzureKeyVaultKey
                }                                                                           # End Catch
                Write-Host 'The key has been created'                                       # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break NewAzureKeyVaultKey                                                   # Breaks :NewAzureKeyVaultKey
            }                                                                               # End if ($KeyNotBefore)
            else {                                                                          # If $KeyNotBefore is $null
                Try {                                                                       # Try the following
                    Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name `
                        $KeyVaultKeyNameInput -Destination $KeyEncryptType `
                        -ErrorAction 'Stop'                                                 # Creates the new key
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions to preform this action'    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break NewAzureKeyVaultKey                                               # Breaks :NewAzureKeyVaultKey
                }                                                                           # End Catch
                Write-Host 'The key has been created'                                       # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break NewAzureKeyVaultKey                                                   # Breaks :NewAzureKeyVaultKey
            }                                                                               # End else (if ($KeyNotBefore))
        }                                                                                   # End :NewAzureKeyVaultKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzKeyVaultKey
function AddAzKeyVaultKey {                                                                 # Function to add an existing key to key vault
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'AddAzKeyVaultKey'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureKeyVaultKey while ($true) {                                                # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break AddAzureKeyVaultKey                                                   # Breaks :AddAzureKeyVaultKey    
            }                                                                               # End if (!$KeyVaultObject)
            :GetLocalDownloadPath while ($true) {                                           # Inner loop for getting the file patch
                Write-Host 'Please provide the path to the key'                             # Write message to screen
                Write-Host 'Example: C:\users\admin\documents\key.pfx'                      # Write message to screen
                $FilePath = Read-Host 'Path to file'                                        # Operator input for the download path
                if ($FilePath -eq 'exit') {                                                 # If $var is equal to 'exit' 
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultKey
                }                                                                           # End if ($FilePath -eq 'exit')
                if (Test-Path -Path $FilePath) {                                            # If file exists
                    Write-Host 'Upload: '$FilePath                                          # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No'                                 # Operator confirmation to use this file
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        :GetKeyPassword while ($true) {                                     # Inner loop for getting key password
                            Write-Host 'Enter the password key'                             # Write message to screen
                            $Password1 = Read-Host 'Password'                               # Operator input for the key password
                            if ($Password1 -eq 'exit') {                                    # If $Password1 equals 'exit'
                                Break AddAzureKeyVaultKey                                   # Breaks :AddAzureKeyVaultKey
                            }                                                               # End if ($Password1 -eq 'exit')
                            $Password2 = Read-Host 'Re-enter to confirm'                    # Operator input to confirm key password
                            if ($Password1 -eq $Password2) {                                # If $Password1 equals $Password2
                                $Password = ConvertTo-SecureString -String $Password1 `
                                -AsPlainText -Force                                         # Creates hashed password
                                Clear-Host                                                  # Clears screen
                                Break GetLocalDownloadPath                                  # Breaks :GetLocalDownloadPath
                            }                                                               # End if ($Password1 -eq $Password2)
                            else {                                                          # If $Password1 does not equal $Password2
                                Write-Host 'Passwords do not match'                         # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($Password1 -eq $Password2))
                        }                                                                   # End :GetKeyPassword while ($true)
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if (Test-Path -Path $FilePath)
                else {                                                                      # If file does not exist
                    Write-Host 'The file path:'$FilePath 'is not valid'                     # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if (Test-Path -Path $FilePath))
            }                                                                               # End :GetLocalDownloadPath while ($true)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789'                            # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            :AzureKeyVaultKeyName while ($true) {                                           # Inner loop for setting $KeyVaultKeyObject name
                $KeyVaultKeyNameInput = $null                                               # Clears $KeyVaultKeyNameInput
                Write-Host 'Key name may only include letters and numbers'                  # Write message to screen
                Write-Host 'Key name cannot inlude any spaces'                              # Write message to screen
                Write-Host 'Key name must be less that 64 characters'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $KeyVaultKeyNameInput = Read-Host 'Key name'                                # Operator input for the key name
                $KeyVaultKeyNameArray = $KeyVaultKeyNameInput.ToCharArray()                 # Creates an array from $KeyVaultKeyNameInput 
                if ($KeyVaultKeyNameInput -eq 'exit') {                                     # $KeyVaultKeyNameInput is equal to exit
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultkey
                }                                                                           # if ($KeyVaultKeyNameInput -eq 'exit')
                if ($KeyVaultKeyNameInput.Length -ge 64) {                                  # If $KeyVaultKeyNameInput is greater than 63 characters
                    Write-Host 'The key name must be less than 64 characters'               # Write message to screen
                    $KeyVaultKeyNameInput = $null                                           # Clears $KeyVaultKeyNameInput                                   
                }                                                                           # End if ($KeyVaultKeyNameInput.Length -ge 63)
                foreach ($_ in $KeyVaultKeyNameArray) {
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Key name cannot include any spaces'                 # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $KeyVaultKeyNameInput = $null                                       # Clears $VaultNameInput
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $KeyVaultKeyNameArray)
                if (!$KeyVaultKeyNameInput) {                                               # If $KeyVaultNameInput is $null
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if (!$KeyVaultKeyNameInput)
                else {                                                                      # If $KeyVaultKeyNameInput has a value
                    Write-Host 'Use:' $KeyVaultKeyNameInput 'as key name'                   # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No'                                 # Operator confirmation of key name
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm is equal to 'y'
                        Clear-Host                                                          # Clears screen
                        Break AzureKeyVaultKeyName                                          # Breaks SetAzureKeyVaultName
                    }                                                                       # End If ($OpConfirm -eq 'y')
                }                                                                           # End else (if (!$KeyVaultKeyNameInput))
            }                                                                               # End :AzureKeyVaultKeyName while ($true)
            Write-Host 'Set an expiration date on this key'                                 # Write message to screen
            $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                                 # Operator input for setting a key expiration
            if ($OpSelect -eq 'e') {                                                        # If $OpSelect equals 'e'
                Break AddAzureKeyVaultKey                                                   # Breaks :AddAzureKeyVaultkey
            }                                                                               # End if ($OpSelect -eq 'e')
            if ($OpSelect -eq 'y') {                                                        # If $OpSelect equals 'y'
                :AzureKeyVaultKeyExpire while ($true) {                                     # Inner loop for setting expiration date
                    $StartDate = (Get-Date).Date                                            # Gets current date
                    Write-Host 'Enter the date in the following format: YYYY-MM-DD'         # Write message to screen
                    Write-Host 'Example: 2050-07-04 to have the key expire on 4 July 2050'  # Write message to screen
                    $EndDate = Read-Host 'Key expiration date'                              # Operator input for end date
                    if ($EndDate -eq 'exit') {                                              # If $EndDate equals 'exit'
                        Break AddAzureKeyVaultKey                                           # Breaks :AddAzureKeyVaultKey
                    }                                                                       # End if ($EndDate -eq 'exit')
                    $DateDiff = New-TimeSpan -Start $StartDate -End $EndDate                # Gets count of days between current and end date
                    if (!$DateDiff) {                                                       # If $DateDiff does not have a value (Result of bad $EndDate entry)
                        Write-Host 'The expiration date entry was not valid'                # Write message to screen
                        Write-Host 'Please enter a date in the listed format'               # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End if (!$DateDiff)
                    elseif ($DateDiff -le 0) {                                              # $DateDiff is 0 or less
                        Write-Host 'The date entered was not in the future'                 # Write message to screen
                        Write-Host 'Please enter a future date'                             # Write message to screen
                        $DateDiff = $null                                                   # Clears $DateDiff
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End elseif ($DateDiff -le 0) 
                    elseif ($DateDiff) {                                                    # If $DateDiff has a value of 1 or higher
                        $KeyExpires = (Get-Date).AddDays($DateDiff.Days).ToUniversalTime()  # Sets $KeyExpires to operator selected date
                        $KeyNotBefore = (Get-Date).ToUniversalTime()                        # Sets $KeyNotBefore to current date
                        Clear-Host                                                          # Clears screen
                        Break AzureKeyVaultKeyExpire                                        # Breaks :AzureKeyVaultKeyExpire
                    }                                                                       # End if ($DateDiff)
                }                                                                           # End AzureKeyVaultKeyExpire while ($true)
            }                                                                               # End if ($OpSelect -eq 'y')
            :AzureKeyVaultKeyEncrypt while ($true) {                                        # Inner loop for setting the encyption type
                Write-Host 'Select key encyption type'                                      # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] HSM'                                                        # Write message to screen
                Write-Host '[2] Software'                                                   # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for encryption type
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0' 
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultKey
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $KeyEncryptType = 'HSM'                                                 # Sets $KeyEncryptType to 'HSM'
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $KeyEncryptType = 'Software'                                            # Sets $KeyEncryptType to 'Software'
                    Clear-Host                                                              # Clears screen
                    Break AzureKeyVaultKeyEncrypt                                           # Breaks :AzureKeyVaultKeyEncrypt
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultKey
                }                                                                           # End else (if ($OpSelect -eq '0'))
                if ($KeyEncryptType -eq 'HSM') {                                            # If $KeyEncryptType is equal to 'HSM'
                    if ($KeyVaultObject.SKU -eq 'Standard') {                               # If $KeyVaultObject.SKU is equal to 'Standard'
                        Write-Host 'HSM is not supported on this key vault'                 # Write message to screen
                        Write-Host '[0] Exit'                                               # Write message to screen
                        Write-Host '[1] Change encryption to software'                      # Write message to screen
                        $OpSelect = Read-Host 'Option [#]'                                  # Operator input on changing type or exiting
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals '0'
                            Break AddAzureKeyVaultKey                                       # Breaks :AddAzureKeyVaultKey
                        }                                                                   # End if ($OpSelect -eq '0')
                        elseif ($OpSelect -eq '1') {                                        # Else if $OpSelect equals '1'
                            $KeyEncryptType = 'Software'                                    # Sets $KeyEncryptType to 'Software'
                            Clear-Host                                                      # Clears screen
                            Break AzureKeyVaultKeyEncrypt                                   # Breaks :AzureKeyVaultKeyEncrypt
                        }                                                                   # End elseif ($OpSelect -eq '1')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpSelect -eq '0'))
                    }                                                                       # End if ($KeyVaultObject.Sku -eq 'Standard')
                    else {                                                                  # If $KeyVaultObject.SKU does not equal 'standard'
                        Clear-Host                                                          # Clears screen
                        Break AzureKeyVaultKeyEncrypt                                       # Breaks :AzureKeyVaultKeyEncrypt 
                    }                                                                       # End else (if ($KeyVaultObject.Sku -eq 'Standard'))
                }                                                                           # End elseif ($KeyEncryptType -eq 'HSM')
            }                                                                               # End :AzureKeyVaultKeyEncrypt while ($true)
            if ($KeyNotBefore) {                                                            # If $KeyNotBefore has a value
                Try {                                                                       # Try the following
                    Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name `
                        $KeyVaultKeyNameInput -Destination $KeyEncryptType -Expires `
                        $KeyExpires -NotBefore $KeyNotBefore -KeyFilePath $FilePath `
                        -KeyFilePassword $Password -ErrorAction 'Stop'                      # Adds the key
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions to preform this action'    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultKey
                }                                                                           # End Catch
                Write-Host 'The key has been created'                                       # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break AddAzureKeyVaultKey                                                   # Breaks :AddAzureKeyVaultKey
            }                                                                               # End if ($KeyNotBefore)
            else {                                                                          # If $KeyNotBefore is $null
                Try {                                                                       # Try the following
                    Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name `
                    $KeyVaultKeyNameInput -Destination $KeyEncryptType -KeyFilePath `
                    $FilePath -KeyFilePassword $Password -ErrorAction 'Stop'                # Adds the key
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions to preform this action'    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultKey
                }                                                                           # End Catch
                Write-Host 'The key has been added'                                         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break AddAzureKeyVaultKey                                                   # Breaks :AddAzureKeyVaultKey
            }                                                                               # End else (if ($KeyNotBefore))
        }                                                                                   # End :AddAzureKeyVaultKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzKeyVaultKey
function ListAzKeyVaultKey {                                                                # Function to list all key vault keys
    Begin {                                                                                 # Begin function
        $KVList = Get-AzKeyVault                                                            # Creates lists of all key vaults
        foreach ($VaultName in $KVList) {                                                   # For each key vault in $KVList
            Write-Host '------------------------------------------------------------------' # Write message to screen
            $KVKeylist = Get-AzKeyVaultKey -VaultName $VaultName.VaultName                  # Creates a list of all keys in current $VaultName
            Write-Host 'Vault Name: ' $VaultName.VaultName                                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if ($KVKeylist) {                                                               # If $KVKeyList has a value
                foreach ($Name in $KVKeylist) {                                             # For each Key name in $KVKeyList
                    Write-Host 'Key Name:   ' $Name.Name                                    # Write message to screen
                    Write-Host 'Key ID:     ' $Name.ID                                      # Write message to screen
                    Write-Host 'Enabled:    ' $Name.Enabled                                 # Write message to screen
                    Write-Host 'Updated:    ' $Name.Updated                                 # Write message to screen
                    if ($Name.Expires) {                                                    # If current item has an existing expiration
                        Write-Host 'Expires:    ' $Name.Expires                             # Write message to screen
                        Write-Host 'NotBefore:  ' $Name.NotBefore                           # Write message to screen
                    }                                                                       # End if ($Name.Expires)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($Name in $KVKeylist)
            }                                                                               # End if ($KVKeylist)
            else {                                                                          # If $KVKeylist does not have a value
                Write-Host 'No Keys in this vault'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End else (if ($KVKeylist))
        }                                                                                   # End foreach ($VaultName in $KVList)
        Write-Host '------------------------------------------------------------------'     # Write message to screen
        Pause                                                                               # Pauses all action for operator input
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin 
}                                                                                           # End function ListAzKeyVaultKey
function GetAzKeyVaultKey {                                                                 # Function to get a key vault Key
    Begin {                                                                                 # Begin function
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'GetAzKeyVaultKey'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureKeyVaultKey while ($true) {                                                # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break GetAzureKeyVaultKey                                                   # Breaks :GetAzureKeyVaultKey    
            }                                                                               # End if (!$KeyVaultObject)
            $Objectlist = Get-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName            # Creates list of all Keys in vault
            if (!$ObjectList) {                                                             # If $ObjectList is empty
                Write-Host 'No Keys found'                                                  # Message write to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureKeyVaultKey                                                   # Breaks :GetAzureKeyVaultKey
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Number' = $ObjectNumber; `
                'Name'=$_.Name;'ID'=$_.Id;'Enabled'=$_.Enabled;'Updated'=$_.Updated; `
                'EXP'=$_.Expires;'NB'=$_.NotBefore}                                         # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host '[0]  Exit'                                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number]       "$_.Name                                    # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]      "$_.Name                                     # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9))
                Write-Host 'ID:       '$_.ID                                                # Write message to screen
                Write-Host 'Enabled:  '$_.Enabled                                           # Write message to screen
                Write-Host 'Updated:  '$_.Updated                                           # Write message to screen
                if ($_.EXP) {                                                               # If current item .EXP has a value
                    Write-Host 'Expires:  '$_.EXP                                           # Write message to screen
                    Write-Host 'NotBefore:'$_.NB                                            # Write message to screen
                }                                                                           # End if ($_.EXP)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureKeyVaultKey foreach ($_ in $ObjectArray) {                          # For each item in $ObjectArray
                if ($CallingFunction -and $CallingFunction -ne 'GetAzKeyVaultKey') {        # If $CallingFunction exists and not equal to 'GetAzKeyVaultKey'
                    Write-Host 'You are selecting the key for:'$CallingFunction             # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Enter option[#]'                                     # Operator input for the key selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureKeyVaultKey                                               # Breaks :GetAzureKeyVaultKey
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $OpSelect                                  
                    $KeyVaultKeyObject = Get-AzKeyVaultKey -VaultName `
                    $KeyVaultObject.VaultName -Name $OpSelect.Name                          # Pulls the full key object
                    Clear-Host                                                              # Clears screen
                    Return $KeyVaultKeyObject, $KeyVaultObject                              # Returns to calling function with $vars
                }                                                                           # End elseif ($RGSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host "That was not a valid option"                                # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureKeyVaultKey
        }                                                                                   # End :GetAzureKeyVaultKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzKeyVaultKey
function DownloadAzKeyVaultKey {                                                            # Function to download a key vault key
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'DownloadAzKeyVaultKey'                                      # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :DownloadAzureKVKey while ($true) {                                                 # Outer loop for managing function
            $KeyVaultKeyObject, $KeyVaultObject = GetAzKeyVaultKey ($CallingFunction)       # Calls function and assigns output to $vars
            if (!$KeyVaultKeyObject) {                                                      # If $KeyVaultKeyObject is $null
                Break DownloadAzureKeyVaultKey                                              # Breaks :DownloadAzureKeyVaultKey    
            }                                                                               # End if (!$KeyVaultObject)
            :SetLocalFilePath while ($true) {                                               # Inner loop for setting the local download path
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Downloads folder'                                           # Write message to screen
                Write-Host '[2] Custom path'                                                # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for download path selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break DownloadAzureKeyVaultKey                                          # Breaks :DownloadAzureKeyVaultKey
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $UserName = $env:USERNAME                                               # Gets session username
                    if ($UserName -like '*\*') {                                            # If $Username has a '\'
                        $UserName = $UserName.Split('\')[1]                                 # Removes \ and text before it
                    }                                                                       # End if ($UserName -like '*\*')
                    $LocalFileDownloadPath = 'c:\users\'+$UserName+'\downloads\'            # Creates $Localdownloadpath
                    Clear-Host                                                              # Clears screen
                    Break SetLocalFilePath                                                  # Breaks :SetLocalFilePath  
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    :VerifyPath while ($true) {                                             # Inner loop for verifying local download path
                        $LocalFileDownloadPath = Read-Host `
                            'Enter the folder path to download key to'                      # Operator input for local download path
                        if ($LocalFileDownloadPath -eq 'exit') {                            # If $LocalFileDownloadPath equals 'exit'
                            Break DownloadAzureKeyVaultKey                                  # Breaks :DownloadAzureKeyVaultKey
                        }                                                                   # End if ($LocalFileDownloadPath -eq 'exit')
                        if (Test-Path $LocalFileDownloadPath) {                             # If $LocalFileDownloadPath is valid
                            Clear-Host                                                      # Clears screen
                            Break SetLocalFilePath                                          # Breaks :SetLocalFilePath
                        }                                                                   # End if (Test-Path $LocalFileDownloadPath)
                        else {                                                              # If Test-Path is false
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'The listed path was not valid'                      # Write message to screen
                            Write-Host 'Please double check the folder path'                # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Enter "exit" to leave this function'                # Write message to screen
                            Pause                                                           # Pauses for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if (Test-Path $LocalFileDownloadPath))
                    }                                                                       # End :VerifyPath while ($true)
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetLocalFilePath while ($true)
            :SetLocalFileName while ($true) {                                               # Inner loop for setting the key local name
                $LocalFileName = Read-Host 'Enter the key name'                             # Operator input for the key name
                if ($LocalFileName -eq 'exit') {                                            # If $LocalFileName is equal to 'exit'
                    Break DownloadAzureKVKey                                                # Breaks :DownloadAzureKVKey
                }                                                                           # End if ($LocalFileName -eq 'exit')
                $LocalfileName = $LocalFileName+'.pem'                                      # Adds .pem to file name
                Write-Host 'User this file name:'$LocalFileName                             # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation of file name
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetLocalFileName                                                  # Breaks :SetLocalFileName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetLocalFileName while ($true)
            $Fullpath = $LocalFileDownloadPath+$LocalFileName                               # Creates the full download path and name $var
            Try {                                                                           # Try the following
                Get-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name `
                    $KeyVaultKeyObject.Name -OutFile $Fullpath -ErrorAction 'Stop'          # Downloads the selected key
            }                                                                               # End Try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have permissions to this key'                       # Write message to screen
                Write-Host 'You may not have permissions to the download location'          # Write message to screen
                Write-Host 'The selected download location may not exist'                   # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break DownloadAzureKVKey                                                    # Breaks :DownloadAzureKVKey    
            }                                                                               # End Catch
            Write-Host 'The key has been downloaded'                                        # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Break DownloadAzureKVKey                                                        # Breaks :DownloadAzureKVKey    
        }                                                                                   # End :DownloadAzureKVKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function DownloadAzKeyVaultKey
function RemoveAzKeyVaultKey {                                                              # Function to remove a key vault key
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzKeyVaultKey'                                        # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureKeyVaultKey while ($true) {
            $KeyVaultKeyObject, $KeyVaultObject = GetAzKeyVaultKey ($CallingFunction)       # Calls function and assigns output to $var
            if (!$KeyVaultKeyObject) {                                                      # If $KeyVaultKeyObject is $null
                Break RemoveAzureKeyVaultKey                                                # Breaks :DownloadAzureKeyVaultKey    
            }                                                                               # End if (!$KeyVaultObject)
            Write-host 'The remove key:'$KeyVaultKeyObject.Name                             # Write message to screen
            Write-Host 'From vault:'    $KeyVaultObject.VaultName                           # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation for deletion
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm is equal to 'y'
                Write-Host 'Removing:' $KeyVaultKeyObject.Name                              # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzKeyVaultKey -Name $KeyVaultKeyObject.Name -VaultName `
                        $KeyVaultKeyObject.VaultName -Force -ErrorAction 'Stop'             # Removes the selected key
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'There was an issue removing the selected key'               # Write message to screen
                    Write-Host 'You may not have the permissions to remove this key'        # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break RemoveAzureKeyVaultKey                                            # Breaks :RemoveAzureKeyVaultKey 
                }                                                                           # End catch
                Write-Host 'The Key has been removed'                                       # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break RemoveAzureKeyVaultKey                                                # Breaks :RemoveAzureKeyVaultKey
            }                                                                               # End if ($ConfirmDelete -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break RemoveAzureKeyVaultKey                                                # Breaks :RemoveAzureKeyVaultKey
            }                                                                               # End else (if ($ConfirmDelete -eq 'y'))
        }                                                                                   # End :RemoveAzureKeyVaultKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to callign function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzKeyVaultKey
# End ManageAzKeyVaultKey
function ManageAzKeyVaultSecret { # Script for managing Azure
    Begin {
        :ManageAzureKeyVaultSecret while ($true) { # Outer loop for managing function
            if ($RGObject) { # If $RGObject has a value
                Write-Host '$RGObject:' $RGObject.ResourceGroupName # Write message to screen 
            } # End if ($RGObject)
            if ($KeyVaultObject) { # If $KeyVaultObject has a value
                Write-Host '$KeyVaultObject:' $KeyVaultObject.VaultName # Write message to screen
            } # End if ($KeyVaultObject)
            if ($KeyVaultSecretObject) { # If $KeyVaultObjectSecret has a value
                Write-Host '$KeyVaultObjectSecret:' $KeyVaultSecretObject.Name # Write message to screen
            } # End if ($KeyVaultSecretObject)
            if ($RGObject -or $KeyVaultObject -or $KeyVaultSecretObject) { # If $RGObject, $KeyVaultObject, or $KeyVaultSecretObject has a value
                Write-Host '0 to clear $RGObject, $KeyVaultObject $KeyVaultSecretObject' # Write message to screen
            } # End if ($RGObject -or $KeyVaultObject)
            Write-Host "1 New Key Vault Secret" # Write message to screen
            Write-Host "2 List All Key Vaults Secret" # Write message to screen
            Write-Host "3 Get Key Vault Secret" # Write message to screen
            Write-Host "4 Get Key Vault Secret Value" # Write message to screen
            Write-Host "5 Update Key Vault Secret Value" # Write message to screen
            Write-Host "6 Remove Key Vault Secret Value" # Write message to screen
            Write-Host "'Exit' to end script" # Write option list to screen
            $ManageAzKeyVaultSecretSel = Read-Host "Chose option" # Operator input for which option they need to run
            if ($ManageAzKeyVaultSecretSel -eq '1') { # Elseif statement for option 1
                Write-Host "New Key Vault Secrets" # Option selection write to screen
                $KeyVaultSecretObject = NewAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function NewAzKeyVaultSecret
            } # End if statement
            elseif ($ManageAzKeyVaultSecretSel -eq '2') { # Elseif statement for option 2
                Write-Host "List All Key Vaults Secrets" # Option selection write to screen
                ListAzKeyVaultSecret # Calls function ListAzKeyVaultSecret
            } # End elseif statement
            elseif ($ManageAzKeyVaultSecretSel -eq '3') { # Elseif statement for option 3
                Write-Host "Get Key Vault Secret" # Option selection write to screen
                $KeyVaultSecretObject = GetAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function GetAzKeyVaultSecret
                $KeyVaultSecretObject
            } # End elseif statement
            elseif ($ManageAzKeyVaultSecretSel -eq '4') { # Elseif statement for option 4
                Write-Host "Get Key Vaule Secret Value" # Option selection write to screen
                GetAzKeyVaultSecretValue ($RGObject, $KeyVaultObject, $KeyVaultSecretObject) # Calls function GetAzKeyVaultSecretValue
            } # End elseif statement
            elseif ($ManageAzKeyVaultSecretSel -eq '5') { # Elseif statement for option 5
                Write-Host "Update Key Vault Secret Value" # Option selection write to screen
                UpdateAzKeyVaultSecret ($RGObject, $KeyVaultObject, $KeyVaultSecretObject) # Calls function UpdateAzKeyVaultSecret
            } # End elseif statement
            elseif ($ManageAzKeyVaultSecretSel -eq '6') { # Elseif statement for option 6
                Write-Host "Remove Key Vault Secret Value" # Option selection write to screen
                RemoveAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function RemoveAzKeyVaultSecret
            } # End elseif statement
            elseif ($ManageAzKeyVaultSecretSel -eq '0') { # Elseif statement for option 0
                $RGObject = $null # Sets $var to $null
                $KeyVaultObject = $null # Sets $var to $null
                $KeyVaultSecretObject = $null # Sets $var to $null
                Write-Host '$RGObject, $KeyVaultObject, and $KeyVaultSecret have been cleared'
            } # End elseif ($ManageAzKeyVaultSecretSel -eq '0')
            elseif ($ManageAzKeyVaultSecretSel -eq 'exit') { # Elseif statement for ending the srcipt
                Break ManageAzureKeyVaultSecret # Breaks :ManageAzureKeyVaultSecret
            } # End elseif statement
            else { # Esle statement for all other values
                Write-Host "Invalid option" # Option selection write to screen
            } # End else statement
        } # End :ManageAzureKeyVaultSecret while ($true)
        Return # Returns to calling function with $null
    } # End begin statemnt
} # End ManageAzKeyVaultSecret
function NewAzKeyVaultSecret { # Creates a new key vault secret
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        :NewAzureKeyVaultSecret while ($true) { # Outer loop for managing function
            if (!$KeyVaultObject) { # If $var is $null
                $KeyVaultObject = GetAzKeyVault ($RGObject) # Calls function and assigns output to $Var
                if (!$KeyVaultObject) { # If $var is $null
                    Break NewAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            :NewAzureKeyVaultSecretName while ($true) { # Inner loop for setting the new key vault secret name
                $KeyVaultSecretName = Read-Host "New key vault secret name" # Prompt for operator input for $KeyVaultSecretName
                Write-Host $KeyVaultSecretName # Write message to screen
                $OperatorConfirm = Read-Host "Use this as the secret name [Y] or [N]" # Operator confirmation of name
                if ($OperatorConfirm -eq 'exit') { # If $OperatorConfirm is equal to 'exit'
                    Break NewAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if ($OperatorConfirm -eq 'exit')
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm is equal to 'y'
                    Break :NewAzureKeyVaultSecretName # Breaks :NewAzureKeyVaultSecretName
                } # End if ($OperatorConfirm -eq 'y')
            } # End :NewAzureKeyVaultSecretName while ($true)
            :NewAzureKeyVaultSecretValue while ($true) { # Inner loop for setting the new key vault secret value
                $KeyVaultSecretValue = Read-Host "New key vault secret value" # Prompt for operator input for $KeyVaultSecretvalue
                Write-Host $KeyVaultSecretValue # Write message to screen
                $OperatorConfirm = Read-Host "Use this as the secret value [Y] or [N]" # Operator confirmation of value
                if ($OperatorConfirm -eq 'exit') { # If $OperatorConfirm is equal to 'exit'
                    Break NewAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if ($OperatorConfirm -eq 'exit')
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm is equal to 'y'
                    Break :NewAzureKeyVaultSecretValue # Breaks :NewAzureKeyVaultSecretValue
                } # End if ($OperatorConfirm -eq 'y')
            } # End :NewAzureKeyVaultSecretValue while ($true)
            $KeyVaultSecretHash = ConvertTo-SecureString -String $KeyVaultSecretValue -AsPlainText -Force # Converts the operator input to secure string
            $KeyVaultSecretObject = Set-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName -Name $KeyVaultSecretName -SecretValue $KeyVaultSecretHash # Creates $KeyVaultSecretObject
            Return $KeyVaultSecretObject # Returns to calling function with $KeyVaultSecretObject
        } # End :NewAzureKeyVaultSecret while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function NewAzKeyVaultSecret
function ListAzKeyVaultSecret { # Lists all key vault secrets
    Begin {
        $KVList = Get-AzKeyVault # Creates lists of all key vaults
        foreach ($VaultName in $KVList) { # For each key vault in $KVList
            Write-Host "-----------------------------------" # Write message to screen
            $KVSecretlist = Get-AzKeyVaultSecret -VaultName $VaultName.VaultName # Creates a list of all keys in current $VaultName
            Write-Host "Vault Name: " $VaultName.VaultName # Write message to screen
            Write-Host "" # Write message to screen
            foreach ($Name in $KVSecretlist) { # For each secret name in $KVSecretList
                Write-Host "Secret Name:" $Name.Name # Write message to screen
                Write-Host "Enabled:    " $Name.Enabled # Write message to screen
                Write-Host "Created:    " $Name.Created # Write message to screen
                Write-Host "Updated:    " $Name.Updated # Write message to screen
                if ($Name.Expires) { # If Selected key has an existing expiration
                    Write-Host "Expires:    " $Name.Expires # Write message to screen
                } # End if ($Name.Expires)
                Write-Host "" # Write message to screen
            } # End foreach ($Name in $KVSecretlist)
        } # End foreach ($VaultName in $KVList)
        Write-Host "-----------------------------------" # Write message to screen
        Return # Retures to calling function with $null
    } # End Begin 
} # End function ListAzKeyVaultSecret
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
# Additional functions required for ManageAzKeyVault
function GetAzLocation {                                                                    # Function to get azure location
    Begin {                                                                                 # Begin function
        :GetAzureLocation while ($true) {                                                   # Outer loop for managing function
            $ListObject = Get-AzLocation                                                    # Gets a list of all Azure locations
            $ListNumber = 1                                                                 # $Var for selecting the location
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the list array
            foreach ($_ in $ListObject) {                                                   # For each $_ in $ListObject
                $ListInput = [PSCustomObject]@{'Number' = $ListNumber; 'Location' `
                = $_.DisplayName}                                                           # Creates the item to load into array
                $ListArray.Add($ListInput) | Out-Null                                       # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $ListNumber by 1
            }                                                                               # End foreach ($_ in $ListObject)
            Write-Host "[ 0 ] Exit"                                                         # Write message to screen
            foreach ($_ in $ListArray) {                                                    # For each $_ in $ListArray
                Write-Host '['$_.Number']' $_.Location                                      # Writes number and location to screen
            }                                                                               # End foreach ($_ in $ListArray)
            :SelectAzureLocation while ($true) {                                            # Inner loop for selecting location from list
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the location for"$CallingFunction         # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $LocationSelect = Read-Host "Please enter [#] of the location"              # Operator input for the selection
                if ($LocationSelect -eq '0') {                                              # If $LocationSelect is 0
                    Break GetAzureLocation                                                  # Breaks :GetAzureLocation
                }                                                                           # End if ($LocationSelect -eq '0')
                elseif ($LocationSelect -in $ListArray.Number) {                            # If $LocationSelect in $ListArray.Number
                    $LocationSelect = $ListArray | Where-Object {$_.Number -eq `
                        $LocationSelect}                                                    # LocationSelect is equal to $ListArray where $LocationSelect equals $ListArray.Number
                    Try {                                                                   # Try the following
                        $LocationObject = Get-AzLocation | Where-Object {$_.DisplayName `
                            -eq $LocationSelect.Location} -ErrorAction 'Stop'               # Pulls the full $LocationObject
                    }                                                                       # End try
                    catch {                                                                 # If try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Write-Host 'Please try again later'                                 # Write message to screen
                        Break GetAzureLocation                                              # Breaks :GetAzureLocation 
                    }                                                                       # End catch
                    Clear-Host                                                              # Clears screen
                    Return $LocationObject                                                  # Returns $LocationObject to calling function
                }                                                                           # End elseif ($LocationSelect -in $ListArray.Number) 
                else {                                                                      # All other inputs for $LocationSelect
                    Write-Host "That was not a valid selection"                             # Write message to screen   
                }                                                                           # End else (if ($LocationSelect -eq '0'))
            }                                                                               # End :SelectAzureLocation while ($true)
        }                                                                                   # End :GetAzureLocation while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLocation
function GetAzResourceGroup {                                                               # Function to get a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $ObjectList = Get-AzResourceGroup                                               # Gets all resource groups and assigns to $ObjectList
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $ObjectNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host "[0]  Exit"                                                          # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number] "$_.Name "|" $_.Location                          # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]"$_.Name "|" $_.Location                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) )
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource group for"$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RGSelect = Read-Host "Enter the resource group number"                     # Operator input for the RG selection
                if ($RGSelect -eq '0') {                                                    # If $RGSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($RGSelect -eq '0')
                elseif ($RGSelect -in $ObjectArray.Number) {                                # If $RGSelect in $ObjectArray.Number
                    $RGSelect = $ObjectArray | Where-Object {$_.Number -eq $RGSelect}       # $RGSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $RGSelect                                  
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $RGSelect.Name}                           # Pulls the full resource group object
                    Clear-Host                                                              # Clears screen
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End elseif ($RGSelect -in $ListArray.Number)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureObjectList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup