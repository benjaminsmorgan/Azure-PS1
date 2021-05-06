# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageshare?view=azps-5.3.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzStorageAccObject:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    NewAzStorageShare:          Creates a new storage share
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :NewAzureStorageShare       Outer loop for managing function
    :SetAzureShareName          Inner loop for setting the share name
    $CallingFunction:           Name of this function, or the one that called it
    $StorageAccObject:          Storage account object
    $ValidArray:                Array of valid characters for share name
    $ShareNameInput:            Operator input of the share name
    $ShareNameArray:            $ShareNameInput converted to array
    $OpConfirm:                 Operator confirmation of the share name
    GetAzStorageAccount{}       Gets $StorageAccObject
        GetAzResourceGroup{}        Gets $RGObject 
} #>
<# Process Flow {
    function
        Call NewAzStorageShare > Get $null
            Call GetAzStorageAccount > Get $StorageAccObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzStorageAccount > Send $RGObject
            End GetAzStorageAccount
                Return NewAzStorageShare > Send $StorageAccObject
        End NewAzStorageShare      
            Return Function > Send $null
}#>
function NewAzStorageShare {                                                                # Function to create a new storage share
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzStorageShare'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureStorageShare while ($true) {                                               # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break NewAzureStorageShare                                                  # Breaks :NewAzureStorageShare
            }                                                                               # End if (!$StorageAccObject)
            :SetAzureShareName while ($true) {                                              # Inner loop for setting the name of the new share
                $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789'                        # Creates a string of valid characters
                $ValidArray = $ValidArray.ToCharArray()                                     # Loads all valid characters into array
                Write-Host 'Storage share name must be atleast 3 characters'                # Write message to screen
                Write-Host 'and made up of letters and numbers only'                        # Write message to screen
                $ShareNameArray = $null                                                     # Clears $ShareNameArray
                $ShareNameInput = Read-Host 'Share name'                                    # Operator input for the share name
                $ShareNameInput = $ShareNameInput.ToLower()                                 # Recreates $ShareNameInput in lower
                $ShareNameArray = $ShareNameInput.ToCharArray()                             # Creates $ShareNameInput
                foreach ($_ in $ShareNameArray) {                                           # For each item in $ShareNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Share name cannot include any spaces'               # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $ShareNameInput = $null                                             # Clears $ShareNameInput
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $ShareNameArray)
                if (!$ShareNameInput) {                                                     # If $ShareNameInput is $null
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($ShareNameInput -eq '0')
                else {                                                                      # If $ShareNameInput not equal to '0'
                    Write-Host $ShareNameInput 'is correct'                                 # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of share name input
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureStorageShare                                          # Breaks NewAzureStorageShare
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm is equal to 'y'
                        Clear-Host                                                          # Clears screen
                        Break SetAzureShareName                                             # Breaks :SetAzureShareName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End else (if (!$ShareNameInput))
            }                                                                               # End :SetAzureShareName while ($true)
            Try {                                                                           # Try the following
                New-AzStorageShare -Name $ShareNameInput -Context `
                    $StorageAccObject.Context -ErrorAction 'Stop'                           # Creates the storage share
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'Check you permissions'                                          # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break NewAzureStorageShare                                                  # Breaks NewAzureStorageShare
            }                                                                               # End catch
            Write-Host 'The share has been created'                                         # Write message to screen
            Pause                                                                           # Pauses for operator input
            Break NewAzureStorageShare                                                      # Breaks NewAzureStorageShare
        }                                                                                   # End :NewAzureStorageShare while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzStorageShare