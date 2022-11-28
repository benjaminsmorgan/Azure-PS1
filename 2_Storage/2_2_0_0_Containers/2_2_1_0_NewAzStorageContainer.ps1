# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    New-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    } #>
<# Functions Description: {
    NewAzStorageContainer:      Creates new storage container(s) in a storage account    
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :NewAzureStorageCon         Outer loop for managing function
    :SetAzureStorageConName     Inner loop for setting the container name
    :CheckAzureStorageConName   Inner loop for validating the container name
    :SetAzureStorageConRights   Inner loop for selecting the container rights
    $CallingFunction:           Name of this function or the one that called it
    $StorageAccObject:          Storage account that will hold the container
    $StorageConNameInput:       Operator input for the container name
    $StorageConNameSplit:       $StorageConNameInput split by space
    $OpConfirm:                 Operator confirmation of the container name
    $ObjectList:                List of all container rights
    $ObjectNumber:              $var used to list and select container rights
    $ObjectArray:               Array of the container rights to select from
    $ObjectInput:               $var used to add each item to $ObjectArray
    $Number:                    Current item .Number used for formatting
    $OpSelect:                  Operator input for selecting the container rights
    GetAzStorageAccount{}       Gets $StorageAccObject
        GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call NewAzStorageContainer > Get $null
            Call GetAzStorageAccount > Get $StorageAccObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzStorageAccount > Send $RGObject
            End GetAzStorageAccount 
                Return NewAzStorageContainer > Send $StorageAccObject
        End NewAzStorageContainer 
            Return Function > Send $null
}#>
function NewAzStorageContainer {                                                            # Creates new storage container(s) in a storage account
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'NewAzStorageContainer'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureStorageCon while ($true) {                                                 # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break NewAzureStorageCon                                                    # Breaks :NewAzureStorageCon
            }                                                                               # End if (!$StorageAccObject)
            :SetAzureStorageConName while ($true) {                                         # Inner loop for setting storage account name
                Try {                                                                       # First validation of the storage container name or names
                    $StorageConNameInput = '1'                                              # Sets $StorageConNameInput to '0'
                    $StorageConNameSplit = $null                                            # Clears $StorageConNameSplit
                    Write-Host 'Storage container names must be atleast 3 characters'       # Write message to screen
                    Write-Host 'and made up of letters and numbers only'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen    
                    Write-Host 'To create multiple containers in this storage account,'     # Write message to screen
                    Write-Host 'enter each name seperated by a [Space]'                     # Write message to screen
                    [ValidatePattern('^[a-z,0-9,\s]+$')]$StorageConNameInput = `
                        [string](Read-Host "Storage account name or names").ToLower()       # Operator input for the container names
                }                                                                           # End Try 
                catch {                                                                     # If try fails
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'The provided name(s) were not valid,'                       # Write message to screen
                    Write-Host 'accepted inputs are letters and numbers only'               # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                }                                                                           # End Catch
                if ($StorageConNameInput -eq '1') {                                         # If $StorageConNamInput is 1 (failed check)
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($StorageConNameInput -eq '1')
                else {                                                                      # If $StorageConNameInput has pass validation
                    :CheckAzureStorageConName while ($true) {                               # Inner loop for verifing each name
                        if ($StorageConNameInput -eq '0') {                                 # If $StorageConName equals '0'
                            Break NewAzStorageAccount                                       # Breaks :NewAzStorageAccount
                        }                                                                   # End if ($StorageConNameInput -eq '0')
                        $StorageConNameSplit = $StorageConNameInput.split()                 # $StorageConSplit equals $StorageConNameInput.Split()
                        foreach ($_ in $StorageConNameSplit) {                              # For each item in $StorageConNameSplit
                            if ($_.length -le 2) {                                          # If current item is 2 or less charaters
                                Write-Host ''                                               # Write message to screen
                                Write-Host 'The name'$_' is invalid, the minimum'           # Write message to screen
                                Write-Host 'length of a name is 3 characters'               # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                                Break CheckAzureStorageConName                              # End Break CheckAzureStorageConName
                            }                                                               # End if ($_.length -le 2)
                            elseif ($_.Length -ge 64) {                                     # If current item is 64 or more charaters
                                Write-Host ''                                               # Write message to screen
                                Write-Host 'The name'$_' is invalid, the maximium'          # Write message to screen
                                Write-Host 'length of a name is 63 characters'              # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                                Break CheckAzureStorageConName                              # End Break CheckAzureStorageConName
                            }                                                               # End elseif ($_.Length -ge 64)
                            else {                                                          # All other inputs for $_
                                Write-Host ''                                               # Write message to screen
                                Write-Host $_ 'is a valid name'                             # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                            }                                                               # End else (if ($_.length -le 2))
                        }                                                                   # End foreach ($_ in $StorageConNameSplit) 
                        if ($StorageConNameSplit.count -gt 1) {                             # If $StorageConNameSplit has more than one value
                            Write-Host 'Create multiple storage containers '                # Write message to screen
                            Write-Host 'with the following names:'                          # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Host $StorageConNameSplit -Separator `n                   # Writes all names to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End if ($StorageConNameSplit.count -gt 1)
                        else {                                                              # If $StorageConNameSplit has 1 value
                            Write-Host 'Create a storage account named:' `
                                $StorageConNameInput                                        # Write message to screen
                        }                                                                   # End else (if ($StorageConNameSplit.count -gt 1))
                        $OpConfirm = Read-Host '[Y] or [N]'                                 # Operator input for approving the name
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Clear-Host                                                      # Clears screen 
                            Break SetAzureStorageConName                                    # Breaks :SetAzureStorageConName
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        else {                                                              # All other inputs for $OpConfirm
                            Clear-Host                                                      # Clears screen 
                            Break CheckAzureStorageConName                                  # Breaks :CheckAzureStorageConName
                        }                                                                   # End else (if ($OpConfirm -eq 'y'))
                    }                                                                       # End :CheckAzureStorageConName while ($true)
                }                                                                           # End else (if ($StorageConNameInput -eq '0'))
            }                                                                               # End :SetAzureStorageConName while ($true)
            Write-Host 'Please review the following permissions'
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Container: Provides full read'                                      # Write message to screen
            Write-Host 'access to a container and its blobs.'                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Blob:      Provides read access to'                                 # Write message to screen
            Write-Host 'blob data throughout a container through'                           # Write message to screen
            Write-Host 'anonymous request, but does not provide'                            # Write message to screen
            Write-Host 'access to container data.'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Off:       Restricts access to only'                                # Write message to screen
            Write-Host 'the storage account owner.'                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $ObjectList = @('Container';'Blob';'Off')                                       # List of valid rights input
            $ObjectNumber = 1                                                               # Creates ObjectNumber
            [System.Collections.ArrayList]$ObjectArray=@()                                  # Creates ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput=[PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_}            # Combines $ObjectNumber and current item
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # ObjectNumber is $ObjectNumber + 1
            }                                                                               # End foreach ($_ in $ObjectList)
            :SetAzureStorageConRights while ($true) {                                       # Inner loop for setting the rights level
                Write-Host '[0] Exit'                                                       # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray 
                    $Number = $_.Number                                                     # $Number equals current item .Number
                    Write-Host "[$Number]"$_.Name                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                $OpSelect = Read-Host 'Select rights level [#]'                             # Operator input for the rights level
                if ($OpSelect -eq '0') {                                                    # If $OpSelect is equal to '0'
                    Break NewAzureStorageCon                                                # Breaks :NewAzureStorageCon
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect equals $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $StorageConRights = $OpSelect.Name                                      # $StorageConRights equals $OpSelect.Name
                    Break SetAzureStorageConRights                                          # Breaks :SetAzureStorageConRights
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureStorageConRights while ($true)
            if ($StorageConNameSplit.Count -gt 1) {                                         # If StorageConNameSplit is not $null
                Write-Host 'Creating storage containers, this may take a minute'            # Write message to screen
                Try {                                                                       # Try the following
                    $StorageConNameSplit | New-AzStorageContainer -context `
                        $StorageAccObject.Context -Permission $StorageConRights `
                        -ErrorAction 'Stop'                                                 # Creates the storage containers
                }                                                                           # End try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host  ''                                                          # Write message to screen
                    Write-Host 'The container name may'                                     # Write message to screen
                    Write-Host 'already exist in this account'                              # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Break NewAzureStorageCon                                                # Breaks :NewAzureStorageCon
                }                                                                           # End catch
                Write-Host 'The storage containers have been made'                          # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break NewAzureStorageCon                                                    # Breaks :NewAzureStorageCon
            }                                                                               # End if ($StorageConNameSplit.Count -gt 1) 
            else {                                                                          # If $StorageConNameSplit.count is 1
                Try {                                                                       # Try the following
                    Write-Host 'Creating the storage container, this may take a minute'     # Write message to screen
                    $StorageConNameSplit | New-AzStorageContainer -context `
                        $StorageAccObject.Context -Permission $StorageConRights `
                        -ErrorAction 'Stop'                                                 # Creates the storage container
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host  ''                                                          # Write message to screen
                    Write-Host 'The container name may'                                     # Write message to screen
                    Write-Host 'already exist in this account'                              # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Break NewAzureStorageCon                                                # Breaks :NewAzureStorageCon
                }                                                                           # End catch
                Write-Host 'The storage container has been made'                            # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break NewAzureStorageCon                                                    # Breaks :NewAzureStorageCon
            }                                                                               # End else (if ($StorageConNameSplit.Count -gt 1))
        }                                                                                   # End :NewAzureStorageCon while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzStorageContainer