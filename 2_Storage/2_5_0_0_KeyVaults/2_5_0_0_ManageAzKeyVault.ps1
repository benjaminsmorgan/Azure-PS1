# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    New-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/new-azkeyvault?view=azps-5.3.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Remove-AzKeyVault:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvault?view=azps-5.3.0
    Get-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultkey?view=azps-5.4.0
    Add-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/add-azkeyvaultkey?view=azps-5.4.0
    Remove-AzKeyVaultKey:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultkey?view=azps-5.4.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Set-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/set-azkeyvaultsecret?view=azps-5.1.0
    Remove-AzKeyVaultSecret:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultsecret?view=azps-5.1.0
    Add-AzKeyVaultCertificate:  https://docs.microsoft.com/en-us/powershell/module/az.keyvault/add-azkeyvaultcertificate?view=azps-5.9.0
    New-AzKeyVaultCertificatePolicy:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/new-azkeyvaultcertificatepolicy?view=azps-5.9.0
    Import-AzKeyVaultCertificate    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/import-azkeyvaultcertificate?view=azps-5.9.0
    Get-AzKeyVaultCertificate:  https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultcertificate?view=azps-5.1.0
    Update-AzKeyVaultCertificate:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/update-azkeyvaultcertificate?view=azps-5.1.0
    Remove-AzKeyVaultCertificate:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultcertificate?view=azps-5.1.0
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
    ManageAzKVCertificate:      https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/ManageAzKVCertificate.ps1
        NewAzKVCertificate:         https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/NewAzKVCertificate.ps1        
        NewAzKVCertificatePolicy:   https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/NewAzKVCertificatePolicy.ps1
        ImportAzKVCertificate:      https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/ImportAzKVCertificate.ps1      
        ListAzKVCertificate:        https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/ListAzKVCertificate.ps1        
        UpdateAzKVCertificate:      https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/UpdateAzKVCertificate.ps1      
        GetAzKVCertificate:         https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/GetAzKVCertificate.ps1         
        DownloadAzKVCertificate:    https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/DownloadAzKVCertificate.ps1    
        RemoveAzKVCertificate:      https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/RemoveAzKVCertificate.ps1 
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
        ManageAzKVCertificate:      Management function for key vault certs
            NewAzKVCertificate:         Creates a new key vault certificate
            NewAzKVCertificatePolicy:   Creates a new key vault certificate policy
            ImportAzKVCertificate:      Imports a key vault certificate
            ListAzKVCertificate:        Lists all key vault certificates
            UpdateAzKVCertificate:      Updates key vault certificate
            GetAzKVCertificate:         Gets a key vault certificate object
            DownloadAzKVCertificate:    Downloads a key vault certificate
            RemoveAzKVCertificate:      Removes key vault certificate
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
        GetAzKeyVaultSecretValue{}  Lists value of $KeyVaultSecretObject
            GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
                GetAzKeyVault{}             Gets $KeyVaultObject
        UpdateAzKeyVaultSecret{}    Updates $KeyVaultSecretObject
            GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
                GetAzKeyVault{}             Gets $KeyVaultObject
        RemoveAzKeyVaultSecret{}    Removes $KeyVaultSecretObject
            GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
                GetAzKeyVault{}             Gets $KeyVaultObject
    ManageAzKVCertificate{}     Manages $KeyVaultCertObject
        NewAzKVCertificate{}        Creates $KeyVaultCertObject
            GetAzKeyVault{}             Gets $KeyVaultObject
            NewAzKVCertificatePolicy{}  Gets $Policy
        ImportAzKVCertificate{}     Imports $KeyVaultCertObject
            GetAzKeyVault{}             Gets $KeyVaultObject
            GetAzKeyVaultSecretValue{}  Gets $KVSV
        UpdateAzKVCertificate{}     Gets $null
            GetAzKVCertificate{}        Gets $KeyVaultCertObject
                GetAzKeyVault{}             Gets $KeyVaultObject
        DownloadAzKVCertificate{}   Gets $null
            GetAzKVCertificate{}        Gets KeyVaultCertObject
                GetAzKeyVault{}             Gets $KeyVaultObject
            GetAzKeyVaultSecretValue{}  Gets $KVSV
                GetAzKeyVault{}             Gets $KeyVaultObject
        RemoveAzKVCertificate{}     Gets $null
            GetAzKVCertificate{}        Gets $KeyVaultCertObject
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
                Call NewAzKeyVaultSecret > Get $null
                    Call GetAzKeyVault > Get $KeyVaultObject
                    End GetAzKeyVault
                        Return NewAzKeyVaultSecret > Send $KeyVaultObject  
                End NewAzKeyVaultSecret
                    Return ManageAzKeyVaultSecret > Send $null
                Call ListAzKeyVaultSecret > Get $null
                End ListAzKeyVaultSecret
                    Return ManageAzKeyVaultSecret > Send $null
                Call GetAzKeyVaultSecretValue > Get $null
                    Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                        End GetAzKeyVault
                            Return GetAzKeyVaultSecret > Send $KeyVaultObject
                    End GetAzKeyVaultSecret
                        Return GetAzKeyVaultSecretValue > Send $KeyVaultSecretObject, $KeyVaultObject  
                End GetAzKeyVaultSecretValue
                    Return ManageAzKeyVaultSecret > Send $null            
                Call UpdateAzKeyVaultSecret > Get $null
                    Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                        End GetAzKeyVault
                            Return GetAzKeyVaultSecret > Send $KeyVaultObject
                    End GetAzKeyVaultSecret
                        Return UpdateAzKeyVaultSecret > Send $KeyVaultSecretObject  
                End UpdateAzKeyVaultSecret
                    Return ManageAzKeyVaultSecret > Send $null
                Call RemoveAzKeyVaultSecret > Get $null
                    Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                        End GetAzKeyVault
                            Return GetAzKeyVaultSecret > Send $KeyVaultObject
                    End GetAzKeyVaultSecret
                        Return RemoveAzKeyVaultSecret > Send $KeyVaultSecretObject, $KeyVaultObject  
                End RemoveAzKeyVaultSecret
                    Return ManageAzKeyVaultSecret > Send $null
            End ManageAzKeyVaultSecret
                Return ManageAzKeyVault > Send $null
            Call ManageAzKVCertificate > Get $null
                Call NewAzKVCertificate > Get $null
                    Call GetAzKeyVault > Get $KeyVaultObject
                    End GetAzKeyVault
                        Return NewAzKVCertificate > Send $KeyVaultObject 
                    Call  NewAzKVCertificatePolicy > Get $Policy
                    End NewAzKVCertificatePolicy
                        Return NewAzKVCertificate > Send $Policy
                End NewAzKVCertificate
                    Return ManageAzKVCertificate > Send $null
                Call ImportAzKVCertificate > Get $null
                    Call GetAzKeyVault > Get $KeyVaultObject
                    End GetAzKeyVault
                        Return ImportAzKVCertificate > Send $KeyVaultObject 
                    Call GetAzKeyVaultSecretValue > Get $KVSV
                        Call GetAzKeyVault > Get $KeyVaultObject
                        End GetAzKeyVault
                            Return GetAzKeyVaultSecretValue > Send $KeyVaultObject
                    End GetAzKeyVaultSecretValue
                        Return ImportAzKVCertificate > Send $KVSV
                End ImportAzKVCertificate
                    Return ManageAzKVCertificate > Send $null
                Call NewAzKVCertificate > Get $null
                End NewAzKVCertificate
                    Return ManageAzKVCertificate > Send $null
                Call UpdateAzKVCertificate > Get $null
                    Call GetAzKVCertificate > Get $KeyVaultCertObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                        End GetAzKeyVault
                            Return GetAzKVCertificate > Send $KeyVaultObject
                    End GetAzKVCertificate
                        Return UpdateAzKVCertificate > Send $KeyVaultCertObject, $KeyVaultObject  
                End UpdateAzKVCertificate
                    Return ManageAzKVCertificate > Send $null
                Call DownloadAzKVCertificate > Get $null
                    GetAzKVCertificate > Get KeyVaultCertObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                        End GetAzKeyVault
                            Return GetAzKVCertificate > Send $KeyVaultObject 
                    End GetAzKVCertificate
                        Return DownloadAzKVCertificate > Send KeyVaultCertObject
                    Call GetAzKeyVaultSecretValue > Get $KVSV
                        Call GetAzKeyVault > Get $KeyVaultObject
                        End GetAzKeyVault
                            Return GetAzKeyVaultSecretValue > Send $KeyVaultObject
                    End GetAzKeyVaultSecretValue
                        Return DownloadAzKVCertificate > Send $KVSV
                End DownloadAzKVCertificate
                    Return ManageAzKVCertificate > Send $null
                Call RemoveAzKVCertificate > Get $null
                    Call GetAzKVCertificate > Get $KeyVaultCertObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                        End GetAzKeyVault
                            Return GetAzKVCertificate > Send $KeyVaultObject
                    End GetAzKVCertificate
                        Return RemoveAzKVCertificate > Send $KeyVaultCertObject, $KeyVaultObject  
                End RemoveAzKVCertificate
                    Return ManageAzKVCertificate > Send $null
            End ManageAzKVCertificate
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
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the management function
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
                ManageAzKVCertificate                                                       # Calls function 
            }                                                                               # End elseif ($OpSelect-eq '6')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
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
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the management function
            Clear-Host                                                                      # Clears screen
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
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
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
# Functions for ManageAzKeyVaultSecret
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
            Clear-Host                                                                      # Clears screen
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
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
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
function GetAzKeyVaultSecret {                                                              # Function to get a key vault secret
    Begin {                                                                                 # Begin function
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'GetAzKeyVaultSecret'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureKeyVaultSecret while ($true) {                                             # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $$KeyVaultObject is $null
                Break GetAzureKeyVaultSecret                                                # Breaks :GetAzureKeyVaultSecret    
            }                                                                               # End if (!$KeyVaultObject)
            $ObjectList = Get-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName         # Creates list of all secrets in vault
            if (!$ObjectList) {                                                             # If $ObjectList returns empty
                Write-Host 'No secrets present in this vault'                               # Message write to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureKeyVaultSecret                                                # Breaks :GetAzureKeyVaultSecret
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets the base value of the list
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber; `
                'Name'=$_.Name;'ID'=$_.ID;'EN'=$_.Enabled;'CR'=$_.created; `
                'UP'=$_.Updated;}                                                           # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host '[0]  Exit'                                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number]     "$_.Name                                      # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]    "$_.Name                                       # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9))
                Write-Host 'Enabled:'$_.EN                                                  # Write message to screen
                Write-Host 'Created:'$_.CR                                                  # Write message to screen
                Write-Host 'Updated:'$_.UP                                                  # Write message to screen
                Write-Host 'ID:     '$_.ID                                                  # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureKeyVaultSecret while ($true) {                                      # Inner loop for selecting the secret
                if ($CallingFunction -and $CallingFunction -ne 'GetAzKeyVaultSecret') {     # If $CallingFunction exists
                    Write-Host 'You are selecting the secret for:'$CallingFunction          # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Enter option[#]'                                     # Operator input for the key vault selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureKeyVaultSecret                                            # Breaks :GetAzureKeyVaultSecret
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $OpSelect                                  
                    $KeyVaultSecretObject = Get-AzKeyVaultSecret -VaultName `
                        $KeyVaultObject.VaultName -Name $OpSelect.Name                      # Pulls the full secret object
                    Clear-Host                                                              # Clears screen
                    Return $KeyVaultSecretObject, $KeyVaultObject                           # Returns to calling function with $vars
                }                                                                           # End elseif ($RGSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host "That was not a valid option"                                # Write message to screen
                    Clear-Host                                                              # Clears screen
                    Pause                                                                   # Pauses all actions for operator input
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureKeyVaultSecret
        }                                                                                   # End :GetAzureKeyVaultSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzKeyVaultSecret
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
function UpdateAzKeyVaultSecret {                                                           # Function to update the value of selected key
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'UpdateAzKeyVaultSecret'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :UpdateAzureKeyVaultSecret while ($true) {                                          # Outer loop for managing funciton
            $KeyVaultSecretObject, $KeyVaultObject = GetAzKeyVaultSecret ($CallingFunction) # Calls function and assigns output to $Var
            if (!$KeyVaultSecretObject) {                                                   # If $KeyVaultSecretObject is $null
                Break UpdateAzureKeyVaultSecret                                             # Breaks :UpdateAzureKeyVaultSecret
            }                                                                               # End if (!$KeyVaultSecretObject)
            :UpdateAzureKVSecretValue while ($true) {                                       # Inner loop for updating key vault secret value
                Write-Host 'Please enter a new value for:'$KeyVaultSecretObject.Name        # Write message to screen
                $KeyVaultSecretValue = Read-Host 'New value'                                # Operator input for the new secret value
                Write-Host 'Use:'$KeyVaultSecretValue'as the new value'                     # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of value
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is equal to 'e'
                    Break UpdateAzureKeyVaultSecret                                         # Breaks :NewAzureKeyVaultSecret
                }                                                                           # End if ($OpConfirm -eq 'e')
                if ($OpConfirm -eq 'y') {                                                   # If $OConfirm is equal to 'y'
                    Clear-Host                                                              # Clears screen
                    Break UpdateAzureKVSecretValue                                          # Breaks :UpdateAzureKVSecretValue
                }                                                                           # End if ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End :UpdateAzureKVSecretValue while ($true)
            $KeyVaultSecretHash = ConvertTo-SecureString -String $KeyVaultSecretValue `
                -AsPlainText -Force                                                         # Converts the operator input to secure string
            try {                                                                           # Try to do the following
                Set-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName -Name `
                    $KeyVaultSecretObject.Name -SecretValue $KeyVaultSecretHash `
                    -ErrorAction 'Stop'                                                     # Updates $KeyVaultSecretObject
            }                                                                               # End Try
            catch {                                                                         # If try statement fails
                Write-Host 'There was an issue updating this secret'                        # Write message to screen
                Write-Host 'You may not have the permissions to modify this secret'         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break UpdateAzureKeyVaultSecret                                             # Breaks :UpdateAzureKVSecretValue 
            }                                                                               # End catch
            Write-Host $KeyVaultSecretObject.Name'has been updated'                         # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break UpdateAzureKeyVaultSecret                                                 # Breaks :UpdateAzureKVSecretValue
        }                                                                                   # End :UpdateAzureKeyVaultSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzKeyVaultSecret
function RemoveAzKeyVaultSecret {                                                           # Function to remove a key vault secret
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables errors
        $WarningPreference = 'silentlyContinue'                                             # Disables key vault warnings
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzKeyVaultSecret'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureKeyVaultSecret while ($true) {                                          # Outer loop for managing function
            $KeyVaultSecretObject, $KeyVaultObject = GetAzKeyVaultSecret ($CallingFunction) # Calls function and assigns output to $Var
            if (!$KeyVaultSecretObject) {                                                   # If $KeyVaultSecretObject is $null
                Break RemoveAzureKeyVaultSecret                                             # Breaks :RemoveAzureKeyVaultSecret
            }                                                                               # End if (!$KeyVaultSecretObject)
            Write-host ''                                                                   # Write message to screen
            Write-host 'Remove:    '$KeyVaultSecretObject.Name                              # Write message to screen
            Write-Host 'From vault:'$KeyVaultSecretObject.VaultName                         # Write message to screen
            Write-host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to delete 
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing' $KeyVaultSecretObject.Name                            # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzKeyVaultSecret -Name $KeyVaultSecretObject.Name -VaultName `
                        $KeyVaultSecretObject.VaultName -Force -ErrorAction 'Stop'          # Removes the selected secret
                }                                                                           # End Try
                catch {                                                                     # If try fails
                    Write-Host 'There was an issue removing the selected key'               # Write message to screen
                    Write-Host 'You may not have the permissions to remove this key'        # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureKeyVaultSecret                                         # Breaks :RemoveAzureKeyVaultSecret 
                }                                                                           # End catch
                Write-Host 'The secret has been removed'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureKeyVaultSecret                                             # Breaks :RemoveAzureKeyVaultSecret
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm is not equal to 'y'
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureKeyVaultSecret                                             # Breaks :RemoveAzureKeyVaultSecret
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureKeyVaultSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzKeyVaultSecret
# End ManageAzKeyVaultSecret
# Functions for ManageAzKVCertificate
function ManageAzKVCertificate {                                                            # Function for managing key vault certs
    Begin {                                                                                 # Begin function
        :ManageAzureKeyVaultCert while ($true) {                                            # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Key Vault Cert'                                             # Write message to screen
            Write-Host '[2] Import Key Vault Cert'                                          # Write message to screen
            Write-Host '[3] List All Key Vaults Certs'                                      # Write message to screen
            Write-Host '[4] Download Key Vault Cert'                                        # Write message to screen
            Write-Host '[5] Update Key Vault Cert'                                          # Write message to screen
            Write-Host '[6] Remove Key Vault Cert'                                          # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureKeyVaultCert                                               # Breaks :ManageAzureKeyVaultCert
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'            
                Write-Host 'New Key Vault Cert'                                             # Write message to screen
                NewAzKVCertificate                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'            
                Write-Host 'Import Key Vault Cert'                                          # Write message to screen
                ImportAzKVCertificate                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'            
                Write-Host 'List All Key Vaults Certs'                                      # Write message to screen
                ListAzKVCertificate                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'            
                Write-Host 'Download Key Vault Cert'                                        # Write message to screen
                DownloadAzKVCertificate                                                     # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'            
                Write-Host 'Update Key Vault Cert'                                          # Write message to screen
                UpdateAzKVCertificate                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'            
                Write-Host 'Remove Key Vault Cert'                                          # Write message to screen
                RemoveAzKVCertificate                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '6')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureKeyVaultSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statemnt
}                                                                                           # End function ManageAzKeyVaultSecret
function NewAzKVCertificate {                                                               # Function to create a certificate
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzKVCertificate'                                         # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureKVCert while ($true) {                                                     # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break NewAzureKVCert                                                        # Breaks :NewAzureKVCert
            }                                                                               # End if (!$KeyVaultObject)
            $Policy = NewAzKVCertificatePolicy ($CallingFunction)                           # Calls function and assigns output to $var
            if (!$Policy) {                                                                 # If $Policy is $null
                Break NewAzureKVCert                                                        # Breaks :NewAzureKVCert
            }                                                                               # End if (!$Policy)
            :SetAzureKVCertName while ($true) {                                             # Inner loop for setting the cert name
                Write-Host 'Enter the name of the certificate'                              # Write message to screen
                $CertName = Read-Host 'Name'                                                # Operator input of the cert name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$CertName'as the certificate name?'                        # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the cert name
                if ($OpConfirm -eq 'e') {                                                   # If $OpSelect equals 'e'
                    Break NewAzureKVCert                                                    # Breaks :NewAzureKVCert
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Else if $OpSelect equals 'y'
                    Break SetAzureKVCertName                                                # Breaks :SetAzureKVCertName
                }                                                                           # End elseif ($OpConfirm -eq 'y') 
                else {                                                                      # All other inputs for $OpSelect
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'e'))
            }                                                                               # End :SetAzureKVCertName while ($true)
            try {                                                                           # Try the following
                Add-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName -Name `
                    $CertName -CertificatePolicy $Policy -ErrorAction 'Stop'                # Adds cert to key vault
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureKVCert                                                        # Breaks :NewAzureKVCert
            }                                                                               # End catch
            Write-Host 'The certificate has been added'                                     # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureKVCert                                                            # Breaks :NewAzureKVCert
        }                                                                                   # End :NewAzureKVCertPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzKVCertificate
function NewAzKVCertificatePolicy {                                                         # Function to create a local certificate
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzKVCertificatePolicy'                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureKVCertPolicy while ($true) {                                               # Outer loop for managing function
            :SetAzureKVCertIssuer while ($true) {                                           # Inner loop for setting the issuer name
                Write-Host 'Issuer name'                                                    # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Self'                                                       # Write message to screen
                Write-Host '[2] Custom issuer'                                              # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the issuer name
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $IssuerName = 'Self'                                                    # $IssuerName is equal to 'Self'
                    Break SetAzureKVCertIssuer                                              # Breaks :SetAzureKVCertIssuer
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    Write-Host 'Enter the issuer name'                                      # Write message to screen
                    $IssuerName = Read-Host 'Name'                                          # Operator input for the issuer name
                    Write-Host 'Use'$IssuerName' as the issuer name'                        # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator input for confriming the issuer name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureKVCertPolicy                                          # Breaks :NewAzureKVCertPolicy
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureKVCertIssuer                                          # Breaks :SetAzureKVCertIssuer
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                    else {                                                                  # All other inputs for $OpConfirm
                    }                                                                       # End else (if ($OpConfirm -eq 'e'))
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other options to for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureKVCertIssuer while ($true)
            :SetAzureKVCertType while ($true) {                                             # Inner loop for setting the cert type
                Write-Host 'Key Type'                                                       # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] RSA'                                                        # Write message to screen
                Write-Host '[2] RSA-HSM'                                                    # Write message to screen
                Write-Host '[3] EC'                                                         # Write message to screen
                Write-Host '[4] EC-HSM'                                                     # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the key type
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $KeyType = 'RSA'                                                        # $KeyType is equal to 'RSA'
                    Break SetAzureKVCertType                                                # Breaks :SetAzureKVCertType
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $KeyType = 'RSA-HSM'                                                    # $KeyType is equal to 'RSA-HSM'
                    Break SetAzureKVCertType                                                # Breaks :SetAzureKVCertType
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $KeyType = 'EC'                                                         # $KeyType is equal to 'EC'
                    Break SetAzureKVCertType                                                # Breaks :SetAzureKVCertType
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # Else if $OpSelect equals '4'
                    $KeyType = 'EC-HSM'                                                     # $KeyType is equal to 'EC-HSM'
                    Break SetAzureKVCertType                                                # Breaks :SetAzureKVCertType
                }                                                                           # End elseif ($OpSelect -eq '4')
                else {                                                                      # All other options to for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureKVCertType while ($true)
            :SetAzureKVCertKeySize while ($true) {                                          # Inner loop for setting key size
                Write-Host 'Key Size'                                                       # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] 4096'                                                       # Write message to screen
                Write-Host '[2] 3072'                                                       # Write message to screen
                Write-Host '[3] 2048'                                                       # Write message to screen
                Write-Host '[4] 521'                                                        # Write message to screen
                Write-Host '[5] 384'                                                        # Write message to screen
                Write-Host '[6] 256'                                                        # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the key type
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # If $OpSelct equals '1'
                    $KeySize = '4096'                                                       # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # If $OpSelct equals '2'
                    $KeySize = '3072'                                                       # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # If $OpSelct equals '3'
                    $KeySize = '2048'                                                       # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # If $OpSelct equals '4'
                    $KeySize = '521'                                                        # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '4')
                elseif ($OpSelect -eq '5') {                                                # If $OpSelct equals '5'
                    $KeySize = '384'                                                        # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '5')
                elseif ($OpSelect -eq '6') {                                                # If $OpSelct equals '6'
                    $KeySize = '256'                                                        # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '6')
                else {                                                                      # All other options to for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureKVCertKeySize while ($true)
            :SetAzureKVCertKeyUse while ($true) {                                           # Inner loop for setting key use
                Write-Host 'Key Usage'                                                      # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] None'                                                       # Write message to screen
                Write-Host '[2] EncipherOnly'                                               # Write message to screen
                Write-Host '[3] CrlSign'                                                    # Write message to screen
                Write-Host '[4] KeyCertSign'                                                # Write message to screen
                Write-Host '[5] KeyAgreement'                                               # Write message to screen
                Write-Host '[6] DataEncipherment'                                           # Write message to screen
                Write-Host '[7] KeyEncipherment'                                            # Write message to screen
                Write-Host '[8] NonRepudiation'                                             # Write message to screen
                Write-Host '[9] DigitalSignature'                                           # Write message to screen
                Write-Host '[A] DecipherOnly'                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the key type
                $KeyUsage = $null                                                           # Clears $KeyUsage
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                if ($OpSelect -eq '1') {                                                    # If $OpSelct equals '1'
                    $KeyUsage = 'None'                                                      # Sets $KeyUsage
                    Break SetAzureKVCertKeyUse                                              # Breaks :SetAzureKVCertKeyUse
                }                                                                           # End if ($OpSelect -eq '1')
                if ($OpSelect -like '*2*') {                                                # If $OpSelct equals '2'
                    $KeyUsage = $KeyUsage +',EncipherOnly'                                  # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*2*'
                if ($OpSelect -like '*3*') {                                                # If $OpSelct equals '3'
                    $KeyUsage = $KeyUsage+',CRLSign'                                        # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*3*')
                if ($OpSelect -like '*4*') {                                                # If $OpSelct equals '4'
                    $KeyUsage = $KeyUsage+',KeyCertSign'                                    # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*4*')
                if ($OpSelect -like '*5*') {                                                # If $OpSelct equals '5'
                    $KeyUsage = $KeyUsage+',KeyAgreement'                                   # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*5*')
                if ($OpSelect -like '*6*') {                                                # If $OpSelct equals '6'
                    $KeyUsage = $KeyUsage+',DataEncipherment'                               # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*6*')
                if ($OpSelect -like '*7*') {                                                # If $OpSelct equals '7'
                    $KeyUsage = $KeyUsage+',KeyEncipherment'                                # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*7*')
                if ($OpSelect -like '*8*') {                                                # If $OpSelct equals '8'
                    $KeyUsage = $KeyUsage+',NonRepudiation'                                 # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*8*')
                if ($OpSelect -like '*9*') {                                                # If $OpSelct equals '9'
                    $KeyUsage = $KeyUsage+',DigitalSignature'                               # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*9*')
                if ($OpSelect -eq 'A') {                                                    # If $OpSelct equals 'A'
                    $KeyUsage = 'DecipherOnly'                                              # Sets $KeyUsage
                    Break SetAzureKVCertKeyUse                                              # Breaks :SetAzureKVCertKeyUse
                }                                                                           # End if ($OpSelect -eq 'A')
                if (!$KeyUsage) {                                                           # If $KeyUsage is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End if (!$KeyUsage)
                else {                                                                      # If $KeyUsage has a value
                    $KeyUsage = $KeyUsage.Substring(1)                                      # Removes first ',' from $KeyUsage
                    Write-Host 'Current key use options:'$KeyUsage                          # Write message to screen
                    Write-Host 'Is this list correct'                                       # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of $KeyUsage
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals '0'
                        Break NewAzureKVCertPolicy                                          # Breaks :NewAzureKVCertPolicy
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureKVCertKeyUse                                          # Breaks :SetAzureKVCertKeyUse
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End else (if (!$KeyUsage))
            }                                                                               # End :SetAzureKVCertKeyUse while ($true)
            :SetAzureKVSContentType while ($true) {                                         # Inner loop for setting the secret content type
                Write-Host 'Secret Content Type'                                            # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] x-pkcs12'                                                   # Write message to screen
                Write-Host '[2] x-pem-file'                                                 # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the secret content type
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $SecretContentType = 'application/x-pkcs12'                             # $SecretContentType is equal to 'application/x-pkcs12'
                    Break SetAzureKVSContentType                                            # Breaks :SetAzureKVSContentType
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '2'
                    $SecretContentType = 'application/x-pem-file'                           # $SecretContentType is equal to 'application/x-pem-file'
                    Break SetAzureKVSContentType                                            # Breaks :SetAzureKVSContentType
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other options to for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureKVSContentType while ($true)
            :SetAzureKVSubjectName while ($true) {                                          # Inner loop for setting the subject name
                Write-Host 'Enter the Subject name'                                         # Write message to screen
                $SubjectName = Read-Host 'Name'                                             # Operator input for the subjectname
                if ($SubjectName -notlike 'CN=*' -or $SubjectName -notlike 'O=*' ) {        # If $SubjectName does not start with 'CN=' or 'O='
                    :SetAzureKVSNType while ($true) {                                       # Inner loop for setting the subject name type
                        Write-Host '[0] Exit'                                               # Write message to screen
                        Write-Host '[1] Canonical Name'                                     # Write message to screen
                        Write-Host '[2] Organization Name'                                  # Write message to screen
                        $OpSelect = Read-Host 'Option [#]'                                  # Operator input for the subject name type
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals '0'
                            Break NewAzureKVCertPolicy                                      # Breaks :NewAzureKVCertPolicy
                        }                                                                   # End if ($OpSelect -eq '0')
                        elseif ($OpSelect -eq '1') {                                        # If $OpSelect equals '1'
                            if ($SubjectName -like '*.com' -or '*.org' -or '*.edu') {       # If $SubjectName ends with .com, .org, .edu
                            }                                                               # End if ($SubjectName -like '*.com' -or '*.org' -or '*.edu')
                            elseif ($SubjectName -like '*.gov' -or '*.mil') {               # If $SubjectName ends with .gov .mil
                            }                                                               # End elseif ($SubjectName -like '*.gov' -or '*.mil')
                            elseif ($SubjectName -like '*.*' -or '*,*') {                   # If $SubjectName has a '.' or ','
                                $SubjectName = '"'+$SubjectName+'"'                         # Adds quotes around $SubjectName
                            }                                                               # End if ($SubjectName -like '*.*' -or '*,*')    
                            $SubjectName = 'CN='+$SubjectName                               # Adds 'CN=' to the start of $Subjectname
                            Break SetAzureKVSNType                                          # Breaks :SetAzureKVSNType
                        }                                                                   # elseif ($OpSelect -eq '1')
                        elseif ($OpSelect -eq '2') {                                        # If $OpSelect equals '2'
                            if ($SubjectName -like '*.*' -or '*,*') {                       # If $SubjectName has a '.' or ','
                                $SubjectName = '"'+$SubjectName+'"'                         # Adds quotes around $SubjectName
                            }                                                               # End if ($SubjectName -like '*.*' -or '*,*')
                            $SubjectName = 'O='+$SubjectName                                # Adds 'O=' to the start of $Subjectname
                            Break SetAzureKVSNType                                          # Breaks :SetAzureKVSNType
                        }                                                                   # End elseif ($OpSelect -eq '2')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OpSelect -eq '0'))      
                    }                                                                       # End :SetAzureKVSNType while ($true)          
                }                                                                           # End if ($SubjectName -notlike 'CN=*')
                Write-Host 'Use'$SubjectName' as the subject name'                          # Write message to screen                                            
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the subject name
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Else if $OpConfirm equals 'y'
                    Clear-Host                                                              # Clears screen
                    Break SetAzureKVSubjectName                                             # Breaks :SetAzureKVSubjectName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'e'))
            }                                                                               # End :SetAzureKVSubjectName while ($true)
            Try {                                                                           # Try the following
                $Policy = New-AzKeyVaultCertificatePolicy -IssuerName $IssuerName -KeyType `
                    $KeyType -KeySize $KeySize -SecretContentType $SecretContentType `
                    -SubjectName $SubjectName -ValidityInMonths 6 -ReuseKeyOnRenewal    
                    -ErrorAction 'Stop'                                                     # Creates the cert policy
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureKVCertPolicy                                                  # Breaks :NewAzureKVCertPolicy
            }                                                                               # End Catch
            Return $Policy                                                                  # Returns to calling function with $var
        }                                                                                   # End :NewAzureKVCertPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzKVCertificatePolicy
function ImportAzKVCertificate {                                                            # Function to import an existing certificate
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'ImportAzKVCertificate'                                      # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureKVCert while ($true) {                                                     # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject does not have a value
                Break AddAzureKVCert                                                        # Breaks :AddAzureKVCert
            }                                                                               # End if (!$KeyVaultObject)
            :GetLocalfilepath while ($true) {                                               # Inner loop for locating the cert to import
                Write-Host 'Enter the full file path, name, and extenstion'                 # Write message to screen
                Write-Host 'Example c:\users\admin\downloads\cert.pfx'                      # Write message to screen
                Write-Host '"Exit" to leave this function'                                  # Write message to screen
                $LocalFilePath = Read-Host 'Path'                                           # Operator input for the local file path
                Clear-Host                                                                  # Clears screen
                if ($LocalFilePath -eq 'exit') {                                            # If $LocalFilePath equals 'exit'
                    Break AddAzureKVCert                                                    # Breaks :AddAzureKVCert
                }                                                                           # End if ($LocalFilePath -eq 'exit')
                if (Test-Path -Path $LocalFilePath) {                                       # If $LocalFilePath is valid
                    Write-Host 'Import the following:'$LocalFilePath                        # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No'                                 # Operator confirmation of the file
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break GetLocalfilepath                                              # Breaks :GetLocalfilepath
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if (Test-Path -Path $LocalFilePath)
                else {                                                                      # If $LocalFilePath is not valid
                    Write-Host 'Unable to locate file'                                      # Write message to screen
                    Write-Host 'Please re-enter the path'                                   # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if (Test-Path -Path $LocalFilePath)
            }                                                                               # End :GetLocalfilepath while ($true)
            :GetLocalFilePassword while ($true) {                                           # Inner loop for getting the cert password
                Write-Host 'Certificate password'                                           # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Manually enter password'                                    # Write message to screen
                Write-Host '[2] Get key vault secret'                                       # Write message to screen
                Write-Host '[3] No password'                                                # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection to provide password
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break AddAzureKVCert                                                    # Breaks :AddAzureKVCert
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # If $OpSelect equals '1'
                    Write-Host 'Please enter the password for the certificate'              # Write message to screen
                    Write-Host '"Exit" to leave this function'                              # Write message to screen
                    $LocalFilePassword = Read-Host 'Password'                               # Operator input for the cert password
                    Clear-Host                                                              # Clears screen
                    Write-Host 'Confirm the password for the certificate'                   # Write message to screen
                    $LocalFilePassword2 = Read-Host 'Password'                              # Operator input for the cert password
                    Clear-Host                                                              # Clears screen
                    if ($LocalFilePassword -eq $LocalFilePassword2) {                       # If $LocalFilePassword equals $LocalFilePassword2
                        $Password = ConvertTo-SecureString -String $LocalFilePassword `
                            -AsPlainText -Force                                             # Converts $LocalFilePassword to secure string $Password
                        Break GetLocalFilePassword                                          # Breaks :GetLocalFilePassword
                    }                                                                       # End if ($LocalFilePassword -eq $LocalFilePassword2)
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $KVSV = GetAzKeyVaultSecretValue ($CallingFunction)                     # Calls function and assigns output to $var
                    if (!$KVSV) {                                                           # If $KVSV does not have a value
                        Break AddAzureKVCert                                                # Breaks :AddAzureKVCert
                    }                                                                       # End if (!$KVSV)
                    else {                                                                  # If $KVSV has a value
                        $Password = ConvertTo-SecureString -String $KVSV `
                            -AsPlainText -Force                                             # Converts $KVSV to secure string $Password
                        Break GetLocalFilePassword                                          # Breaks :GetLocalFilePassword
                    }                                                                       # End else (if (!$KVSV))
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $Password = $null                                                       # Clears $Password
                    Break GetLocalFilePassword                                              # Breaks :GetLocalFilePassword
                }                                                                           # End elseif ($OpSelect -eq '3')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen   
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetLocalFilePassword while ($true)   
            :SetAzureKVCertName while ($true) {                                             # Inner loop for setting the cert name
                Write-Host 'Enter the name of the certificate'                              # Write message to screen
                $CertName = Read-Host 'Name'                                                # Operator input of the cert name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$CertName'as the certificate name?'                        # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the cert name
                if ($OpConfirm -eq 'e') {                                                   # If $OpSelect equals 'e'
                    Break AddAzureKVCert                                                    # Breaks :NewAzureKVCert
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Else if $OpSelect equals 'y'
                    Break SetAzureKVCertName                                                # Breaks :SetAzureKVCertName
                }                                                                           # End elseif ($OpConfirm -eq 'y') 
                else {                                                                      # All other inputs for $OpSelect
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'e'))
            }                                                                               # End :SetAzureKVCertName while ($true)
            if ($Password) {                                                                # If $Password has a value
                Try {                                                                       # Try the following
                    Import-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                        -Name $CertName -FilePath $LocalFilePath -Password $Password 
                        -ErrorAction 'Stop'                                                 # Imports the certificate
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The certicate was not imported'                             # Write message to screen
                    Write-Host 'There maybe an issue with the certificate'                  # Write message to screen
                    Write-Host 'The password provided may not be valid'                     # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break AddAzureKVCert                                                    # Breaks :AddAzureKVCert 
                }                                                                           # End catch
            }                                                                               # End if ($Password)
            else {                                                                          # If $Password does not have a value
                Try {
                    Import-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                        -Name $CertName -FilePath $LocalFilePath -ErrorAction 'Stop'        # Imports the certificate
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The certicate was not imported'                             # Write message to screen
                    Write-Host 'There maybe an issue with the certificate'                  # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break AddAzureKVCert                                                    # Breaks :AddAzureKVCert 
                }                                                                           # End catch    
            }                                                                               # End else (if ($Password))
            Write-Host 'The certificate has been imported successfully'                     # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureKVCert                                                            # Breaks :AddAzureKVCert                                    
        }                                                                                   # End :AddAzureKVCert while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ImportAzKVCertificate
function ListAzKVCertificate {                                                              # Function to list key vault certs
    Begin {                                                                                 # Begin function
        $KVList = Get-AzKeyVault                                                            # Pulls a list of all key vaults
        foreach ($_ in $KVList) {                                                           # For each item in $KVList
            $KeyVaultName = $_.VaultName                                                    # $KeyVaultName is equal to current item .VaultName
            $CertList = Get-AzKeyVaultCertificate -VaultName $KeyVaultName                  # Pulls a list of all certs in $KeyVaultNAme
            Write-Host '------------------------------------------------------------------' # Write message to screen
            Write-Host 'Vault Name:'$KeyVaultName                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if (!$CertList) {                                                               # If $CertList is $null
                Write-Host 'No certs in this vault'                                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if (!$CertList)
            else {                                                                          # If $CertList has a value
                foreach ($_ in $CertList) {                                                 # For each item in $CertList
                    Write-Host 'Name:       ' $_.name                                       # Write message to screen
                    Write-Host 'ID:         ' $_.ID                                         # Write message to screen
                    Write-Host 'Enabled:    ' $_.Enabled                                    # Write message to screen
                    Write-Host 'Created:    ' $_.Created                                    # Write message to screen
                    Write-Host 'Updated:    ' $_.Updated                                    # Write message to screen
                    Write-Host 'Not Before: ' $_.NotBefore                                  # Write message to screen
                    Write-Host 'Expires:    ' $_.Expires                                    # Write message to screen
                    if ($_.Version) {                                                       # If current item .version has a value
                        Write-Host 'Version:    ' $_.Version                                # Write message to screen
                    }                                                                       # End if ($_.Version)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $CertList)
            }                                                                               # End else (if (!$CertList))
            Write-Host '------------------------------------------------------------------' # Write message to screen
        }                                                                                   # End foreach ($_ in $KVList)
        Pause                                                                               # Pauses all actions for operator input
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzKVCertificate 
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
function DownloadAzKVCertificate {                                                          # Function to download a key vault certificate
    Begin {                                                                                 # Begin function
        if ($CallingFunction) {                                                             # If $CallingFunction is $null
            $CallingFunction = 'DownloadAzKVCertificate'                                    # Creates $CallingFunction
        }                                                                                   # End if ($CallingFunction)
        :DownloadAzureKVCert while ($true) {                                                # Outer loop for managing function
            $KeyVaultCertObject, $KeyVaultObject = GetAzKVCertificate ($CallingFunction)    # Calls function and assigns output to $var
            if (!$KeyVaultCertObject) {                                                     # If $KeyVaultCertObject is $null
                Break DownloadAzureKVCert                                                   # Breaks :DownloadAzureKVCert
            }                                                                               # End if (!$KeyVaultCertObject)
            Write-Host 'Certificate selected'                                               # Write message to screen
            Write-Host 'Please locate the matching key vault secret'                        # Write message to screen
            Pause
            $KVSV = GetAzKeyVaultSecretValue ($CallingFunction)                             # Calls function and assigns output to $var
            if (!$KVSV) {                                                                   # If $KVSV does not have a value
                Break DownloadAzureKVCert                                                   # Breaks :DownloadAzureKVCert
            }                                                                               # End if (!$KVSV)
            Write-Host 'Secret selected'                                                    # Write message to screen
            :GetDownloadPath while ($True) {                                                # Inner loop for setting the download path
                Write-Host 'Please enter the download path'                                 # Write message to screen
                Write-Host 'Example: C:\users\Admin\Downloads\'                             # Write message to screen
                $Localdownloadpath = Read-Host 'Path'                                       # Operator input for download path
                if ($Localdownloadpath -notlike '*\') {                                     # If $LocalDownloadPath does not end in '\'
                    $Localdownloadpath = $Localdownloadpath+'\'                             # Adds '\' to end of $LocalDownloadPath
                    if (Test-Path -Path $Localdownloadpath) {                               # If $LocalDownloadPath is valud
                        Break GetDownloadPath                                               # Breaks :GetDownloadPath
                    }                                                                       # End if (Test-Path -Path $Localdownloadpath)     
                    else {                                                                  # If $Localdownload path is not valid
                        Write-Host 'The path:'$Localdownloadpath                            # Write message to screen
                        Write-Host 'was not valid'                                          # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if (Test-Path -Path $Localdownloadpath))
                }                                                                           # End if ($Localdownloadpath -notlike '*\')
                else {                                                                      # If $LocalDownloadPath ends with '\'
                    if (Test-Path -Path $Localdownloadpath) {                               # If $LocalDownloadPath is valud
                        Break GetDownloadPath                                               # Breaks :GetDownloadPath
                    }                                                                       # End if (Test-Path -Path $Localdownloadpath)     
                    else {                                                                  # If $Localdownload path is not valid
                        Write-Host 'The path:'$Localdownloadpath                            # Write message to screen
                        Write-Host 'was not valid'                                          # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if (Test-Path -Path $Localdownloadpath))
                }                                                                           # End else (if ($Localdownloadpath -notlike '*\'))
            }                                                                               # End :GetDownloadPath while ($True)
            :GetDownloadName while ($true) {                                                # Inner loop for setting download name
                Write-Host 'Enter the filename'                                             # Write message to screen
                Write-Host 'Example: downloadedcert'                                        # Write message to screen
                $DownloadName = Read-Host 'Name'                                            # Operator input for file name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$DownloadName 'as the file name'                           # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the file name
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break DownloadAzureKVCert                                               # Breaks :DownloadAzureKVCert
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Else if $OpConfirm equals 'y'
                    Break GetDownloadName                                                   # Breaks :GetDownloadName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'e'))
            }                                                                               # End :GetDownloadName while ($true)
            :GetLocalFilePassword while ($true) {                                           # Inner loop for getting the cert password
                Write-Host 'Please create a password for the certificate'                   # Write message to screen
                $LocalFilePassword = Read-Host 'Password'                                   # Operator input for the cert password
                Clear-Host                                                                  # Clears screen
                Write-Host 'Confirm the password for the certificate'                       # Write message to screen
                $LocalFilePassword2 = Read-Host 'Password'                                  # Operator input for the cert password
                Clear-Host                                                                  # Clears screen
                if ($LocalFilePassword -eq $LocalFilePassword2) {                           # If $LocalFilePassword equals $LocalFilePassword2
                    $Password = ConvertTo-SecureString -String $LocalFilePassword `
                        -AsPlainText -Force                                                 # Converts $LocalFilePassword to secure string $Password
                    Break GetLocalFilePassword                                              # Breaks :GetLocalFilePassword
                }                                                                           # End if ($LocalFilePassword -eq $LocalFilePassword2)
                else {                                                                      # If $LocalFilePassword does not equal $LocalFulePassword2
                    Write-Host 'Passwords did not match'                                    # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LocalFilePassword -eq $LocalFilePassword2))
            }                                                                               # End :GetLocalFilePassword while ($true)   
            $FullDownloadPath = $Localdownloadpath+$DownloadName+'.pfx'                     # Creates $FullDownloadPath
            Try {                                                                           # Try the following
                $secretByte = [Convert]::FromBase64String($KVSV)                            # Converts key vault secret
                $x509Cert = New-Object `
                    System.Security.Cryptography.X509Certificates.X509Certificate2 `
                    ($secretByte, "", "Exportable,PersistKeySet")                           # Creates X509 cer
                $type = `
                    [System.Security.Cryptography.X509Certificates.X509ContentType]::Pfx
                $pfxFileByte = $x509Cert.Export($type, $password)                           # Converts to PFX
                [System.IO.File]::WriteAllBytes($FullDownloadPath, $pfxFileByte)            # Writes cert to file
            }                                                                               # End try
            catch {                                                                         # If Try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break DownloadAzureKVCert                                                   # Breaks :DownloadAzureKVCert
            }                                                                               # End catch
            Write-Host 'Download complete'                                                  # Write message to screen
            Write-Host 'Path:'$FullDownloadPath                                             # Write message to screen
            Write-Host 'Password:'$LocalFilePassword                                        # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break DownloadAzureKVCert                                                       # Breaks :DownloadAzureKVCert
        }                                                                                   # End :DownloadAzureKVCert while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function DownloadAzKVCertificate
function RemoveAzKVCertificate {                                                            # Function to remove a key vault certificate
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables errors
        $WarningPreference = 'silentlyContinue'                                             # Disables key vault warnings
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzKVCertificate'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureKVCertificate while ($true) {                                           # Outer loop for managing function
            $KeyVaultCertObject, $KeyVaultObject = GetAzKVCertificate ($CallingFunction)    # Calls function and assigns output to $Var
            if (!$KeyVaultCertObject) {                                                     # If $KeyVaultCertObject is $null
                Break RemoveAzureKVCertificate                                              # Breaks :RemoveAzureKVCertificate
            }                                                                               # End if (!$KeyVaultCertObject)
            Write-host ''                                                                   # Write message to screen
            Write-host 'Remove:    '$KeyVaultCertObject.Name                                # Write message to screen
            Write-Host 'From vault:'$KeyVaultCertObject.VaultName                           # Write message to screen
            Write-host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to delete 
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing' $KeyVaultCertObject.Name                              # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzKeyVaultCertificate -Name $KeyVaultCertObject.Name -VaultName `
                        $KeyVaultCertObject.VaultName -Force -ErrorAction 'Stop'            # Removes the selected cert
                }                                                                           # End Try
                catch {                                                                     # If try fails
                    Write-Host 'There was an issue removing the selected cert'              # Write message to screen
                    Write-Host 'You may not have the permissions to remove this cert'       # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureKVCertificate                                          # Breaks :RemoveAzureKVCertificate 
                }                                                                           # End catch
                Write-Host 'The certificate has been removed'                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureKVCertificate                                              # Breaks :RemoveAzureKVCertificate
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm is not equal to 'y'
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureKVCertificate                                              # Breaks :RemoveAzureKVCertificate
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureKVCertificate while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzKVCertificate
# End ManageAzKVCertificate
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