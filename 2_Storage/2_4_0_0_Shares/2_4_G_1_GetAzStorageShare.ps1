# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageshare?view=azps-5.3.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzStorageAccObject:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    GetAzStorageShare:          Gets a storage share
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {      
    :GetAzureStorageShare       Outer loop for managing function
    :SelectAzureStorageShare    Inner loop for selecting the storage share
    $StorageAccObject:          Storage account object
    $ObjectList:                List of all shares in $StorageAccObject
    $ObjectNumber:              Number used for listing and selecting share
    $ObjectArray:               Array holding share information
    $ObjectInput:               $var used to load share info into $ObjectArray
    $Number:                    Current item .number, used for formatting
    $CallingFunction:           Name of the function that called this one
    $OpSelect:                  Operator input for selecting the share
    $StorageShareObject:        Storage Share object
    GetAzStorageAccount{}       Gets $StorageAccObject    
        GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call GetAzStorageShare > Get $StorageShareObject
            Call GetAzStorageAccount > Get $StorageAccObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzStorageAccount > Send $RGObject
            End GetAzStorageAccount
                Return NewAzStorageShare > Send $StorageAccObject
        End GetAzStorageShare      
            Return Function > Send $StorageShareObject, $StorageAccObject
}#>
Function GetAzStorageShare {                                                                # Function to get a storage share
    Begin {                                                                                 # Begin function
        :GetAzureStorageShare while ($true) {                                               # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break GetAzureStorageShare                                                  # Breaks :GetAzureStorageShare
            }                                                                               # End if (!$StorageAccObject) 
            $ObjectList = Get-AzStorageShare -Context $StorageAccObject.Context             # Collects all shares in selected storage account
            if (!$ObjectList) {                                                             # If $ObjectList returns empty
                Write-Host 'No storage shares found'                                        # Message write to screen
                Write-Host 'on storage account'$StorageAccObject.StorageAccountName         # Message write to screen
                Pause                                                                       # Pauses all action for operator input
                Break GetAzureStorageShare                                                  # Breaks :GetAzureStorageShare
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray=@()                                  # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_.Name;`
                    'QU'=$_.Quota;'LM'=$_.LastModified;'IsSnap'=$_.IsSnapshot;`
                    'SST'=$_.SnapShotTime}                                                  # Creates $ObjectInput
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads content of $ObjectInput into $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
            }                                                                               # End foreach ($_ in $OpSelect)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                $Number = $_.Number                                                         # $Number is equal to current item .Number
                if ($Number -le 9) {                                                        # If $Number is 9 or less
                    Write-Host "[$Number]:         " $_.Name                                # Write message to screen
                }                                                                           # End if ($Number -le 9)
                else {                                                                      # If $Number is 10 or more
                    Write-Host "[$Number]:        " $_.Name                                 # Write message to screen
                }                                                                           # End else (if ($Number -le 9))
                Write-Host 'QuotaGiB:    '$_.QU                                             # Write message to screen
                Write-Host 'Last Mod:    '$_.LM                                             # Write message to screen
                if ($_.IsSnap -eq 'True') {                                                 # If current item .IsSnap is equal to true
                    Write-Host 'SnapshotTime:'$_.SST                                        # Write message to screen
                }                                                                           # End if ($_.IsSnap -eq 'True')
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureStorageShare while ($true) {                                        # Inner loop for selecting the storage share
                if ($CallingFunction) {                                                     # If $Calling function has a value
                    Write-Host 'You are selecting the storage share for:'$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Enter the storage share [#]'                         # Operator input for the storage share selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect is equal to '0'
                    Break GetAzureStorageShare                                              # Breaks :GetAzureStorageShare
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $StorageShareObject = Get-AzStorageShare -Name $OpSelect.Name -Context `
                    $StorageAccObject.Context                                               # Collects the full storage share object
                    if ($StorageShareObject) {                                              # If $StorageShareObject has a value
                        Clear-Host                                                          # Clears screen
                        Return $StorageShareObject, $StorageAccObject                       # Returns to $CallingFunction with $vars
                    }                                                                       # End if ($StorageShareObject)
                    else {                                                                  # If $StorageShareObject does not have a value
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Pause                                                               # Pauses for operator input
                        Break GetAzureStorageShare                                          # End Break GetAzureStorageShare
                    }                                                                       # End else (if ($StorageShareObject))
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($OpSelect -eq '0')
            }                                                                               # End :SelectAzureStorageShare while ($true) 
        }                                                                                   # End :GetAzureStorageShare while ($true)
        Clear-Host                                                                          # Clears Screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function GetAzStorageShare