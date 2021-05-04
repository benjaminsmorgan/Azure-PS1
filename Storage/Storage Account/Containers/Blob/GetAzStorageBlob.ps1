# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzStorageBlob:          https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageblob?view=azps-5.3.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/GetAzStorageContainer.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    GetAzStorageBlob:           Gets a storage blob
    GetAzStorageAccount:        Collects the storage account object
    GetAzStorageContainer:      Collects storage container in a storage account  
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :GetAzureBlobs              Outer loop for managing function
    :SelectAzureBlobs           Inner loop for selecting the blob
    $CallingFunction:           Name of this function or the one that called it
    $StorageConObject:          Storage container object
    $StorageAccObject:          Storage account object
    $ObjectList:                List of all blobs in $StorageConObject
    $ObjectArray:               Array where blob info will be loaded
    $ObjectNumber:              $var used for listing and selecting from $ObjectArray
    $ObjectInput:               $var used to load info into $ObjectArray
    $Number:                    Current item .Number used fro formatting
    $OpSelect:                  Operator input for selecting the blob
    $StorageBlobObject:         Storage blob object
    GetAzStorageContainer{}     Gets $StorageConObject
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call GetAzStorageBlob > Get $StorageBlobObject
            Call GetAzStorageContainer > Get $StorageConObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount 
                    Return GetAzStorageContainer > Send $StorageAccObject
            End GetAzStorageContainer 
                Return SetAzStorageBlob > Send $StorageConObject, $StorageAccObject
        End GetAzStorageBlob
            Return function > Send $StorageBlobObject
}#>
function GetAzStorageBlob {                                                                 # Function to get a blob in storage container
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'GetAzStorageBlob'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error messages
        :GetAzureBlobs while ($true) {                                                      # Outer loop for managing function
            $StorageConObject, $StorageAccObject = GetAzStorageContainer ($CallingFunction) # Calls function and assigns output to $var
            if (!$StorageConObject) {                                                       # If $StorageConObject is $null
                Break GetAzureBlobs                                                         # Breaks :GetAzureBlobs
            }                                                                               # End if (!$StorageConObject)
            $ObjectList = Get-AzStorageBlob -Context $StorageAccObject.context -Container `
                $StorageConObject.Name                                                      # Object containing the blob info objects
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No blobs exist in this container'                               # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break GetAzureBlobs                                                         # Breaks :GetAzureBlobs
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber;'Name' = $_.Name;`
                    'Type'=$_.BlobType;'LM'=$_.LastModified;'AT'=$_.AccessTier;`
                    'Del'=$_.IsDeleted;'VID'=$_.VersionID}                                  # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                $Number = $_.Number                                                         # Creates $Number from current item .number
                if ($Number -le 9) {                                                        # If $Number is less than 10
                    Write-Host "[$number]:        "$_.Name                                  # Write message to screen
                }                                                                           # End if ($Number -le 9)
                else {                                                                      # If $number is greater than 9
                    Write-Host "[$number]:       "$_.Name                                   # Write message to screen
                }                                                                           # End else (if ($Number -le 9))
                Write-Host 'Type:       '$_.Type                                            # Write message to screen
                Write-Host 'Last Mod:   '$_.LM                                              # Write message to screen
                Write-Host 'Access Tier:'$_.AT                                              # Write message to screen
                Write-Host 'Deleted:    '$_.Del                                             # Write message to screen
                Write-Host 'VersionID:  '$_.VID                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureBlobs while ($true) {                                               # Inner loop for selecting the blob
                if ($CallingFunction -ne 'GetAzStorageBlob') {                              # If $CallingFunction is not equal 'GetAzStorageBlob'
                    Write-Host 'You are selecting the blob for:'$CallingFunction            # Write message to screen
                }                                                                           # End if ($CallingFunction -ne 'GetAzStorageBlob')
                $OpSelect = Read-Host 'Enter the blob [#]'                                  # Operator input to select the blob
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureBlobs                                                     # Breaks :GetAzureBlobs
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.number) {                                # If $OpSelect is in $ObjectArray.Number
                    $StorageBlobObject = $ObjectArray | Where-Object `
                        {$_.Number -eq $OpSelect}                                           # $StorageBlobObject is equal to $ObjectArray where $ObjectArray.Number eqauls $OpSelect
                    if ($CallingFunction -ne 'GetAzStorageBlob') {                          # If $CallingFunction is not equal 'GetAzStorageBlob'
                        $StorageBlobObject = Get-AzStorageBlob -Blob `
                            $StorageBlobObject.Name -Container $StorageConObject.Name `
                            -Context $StorageAccObject.Context                              # Collects the full blob object
                        Clear-Host                                                          # Clears screen
                        Return $StorageBlobObject, $StorageConObject, $StorageAccObject     # Returns to calling function with $vars
                    }                                                                       # End if ($CallingFunction -ne 'GetAzStorageBlob')
                    else {                                                                  # If $CallingFunction is equal to 'GetAzStorageBlob'
                        Break GetAzureBlobs                                                 # Breaks :GetAzureBlobs
                    }                                                                       # End else (if ($CallingFunction -ne 'GetAzStorageBlob'))
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureBlobs while ($true)
        }                                                                                   # End :GetAzureBlobs while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzStorageBlob