# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
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
    ListAzStorageBlobs:         Lists blob(s) information
    GetAzStorageAccount:        Collects the storage account object
    GetAzStorageContainer:      Collects storage container in a storage account  
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :ListAzureBlobs             Outer loop for managing function
    $StorageConObject:          Storage container holding the blobs
    $StorageAccObject:          Storage account for the container holding the blobs
    $ObjectList:                List of all blobs in $StorageConObject
    $ObjectArray:               Array containing blob info
    $OjbjectInput:              $var used to load info into $ObjectArray
    GetAzStorageContainer{}     Gets $StorageConObject
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call ListAzStorageBlob > Get $null
            Call GetAzStorageContainer > Get $StorageConObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount 
                    Return GetAzStorageContainer > Send $StorageAccObject
            End GetAzStorageContainer 
                Return SetAzStorageBlob > Send $StorageConObject, $StorageAccObject
        End ListAzStorageBlob
            Return function > Send $null
}#>
function ListAzStorageBlob {                                                                # Function to list all blobs in storage container
    Begin {                                                                                 # Begin function
        $CallingFunction = 'ListAzStorageBlob'                                              # Creates $CallingFunction
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error messages
        :ListAzureBlobs while ($true) {                                                     # Outer loop for managing function
            $StorageConObject, $StorageAccObject = GetAzStorageContainer ($CallingFunction) # Calls function and assigns output to $var
            if (!$StorageConObject) {                                                       # If $StorageConObject is $null
                Break ListAzureBlobs                                                        # Breaks :ListAzureBlobs
            }                                                                               # End if (!$StorageConObject)
            $ObjectList = Get-AzStorageBlob -Context $StorageAccObject.context -Container `
                $StorageConObject.Name                                                      # Object containing the blob info objects
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No blobs exist in this container'                               # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break ListAzureBlobs                                                        # Breaks :ListAzureBlobs
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.Name;'Type'=$_.BlobType; `
                    'LM'=$_.LastModified;'AT'=$_.AccessTier;'Del'=$_.IsDeleted;`
                    'VID'=$_.VersionID}                                                     # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
            }                                                                               # End foreach ($_ in $ObjectList)
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Name:       '$_.Name                                            # Write message to screen
                Write-Host 'Type:       '$_.Type                                            # Write message to screen
                Write-Host 'Last Mod:   '$_.LM                                              # Write message to screen
                Write-Host 'Access Tier:'$_.AT                                              # Write message to screen
                Write-Host 'Deleted:    '$_.Del                                             # Write message to screen
                Write-Host 'VersionID:  '$_.VID                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureBlobs                                                            # Breaks :ListAzureBlobs
        }                                                                                   # End :ListAzureBlobs while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzStorageBlob