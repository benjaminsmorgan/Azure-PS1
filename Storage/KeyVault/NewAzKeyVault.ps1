# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    New-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/new-azkeyvault?view=azps-5.3.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
} #>
<# Functions Description: {
    NewAzKeyVault:              Creates new key vault object
    GetAzResourceGroup:         Collects resource group object
    GetAzLocation:              Collects an Azure location
} #>
<# Variables: {
    :NewAzureKeyVault           Outer loop for managing function
    :SetAzureKeyVaultName       Inner loop for setting the key vault name
    $CallingFunction:           Name of this function or the one that called it
    $RGObject:                  Resource group object
    $LocationObject:            Azure location object
    $ValidArray:                Array of valid characters
    $VaultNameInput:            Operator input of the vault name
    $VaultNameLast:             Number of the last character in vault name
    $OpConfirm:                 Operator confirmation of $VaultNameInput
    GetAzResourceGroup{}        Gets $RGObject
    GetAzLocation{}             Gets $LocationObject
} #>
<# Process Flow {
    function
        Call NewAzKeyVault > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return NewAzKeyVault > Send $RGObject
            Call GetAzLocation > Get $LocationObject
            End GetAzLocation
                Return NewAzKeyVault > Send $LocationObject
        End NewAzKeyVault 
            Return Function > Send $null
}#>
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