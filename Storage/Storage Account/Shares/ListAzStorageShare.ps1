# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageshare?view=azps-5.3.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.3.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzStorageShareAll:       Lists all storage shares in a subscription
} #>
<# Variables: {
    :ListAzureStorageShare      Outer loop for managing function
    $RGList:                    List of all resource groups
    $RGObject:                  Current item .ResourceGroupName
    $StorageAccList:            List of all storage accounts undr $RGObject
    $StorageAccObject:          Storage account object
    $StorageShareList:          List of all storage shares under $StorageAccObject
    $ObjectArray:               Array used to display info on storage share
    $ObjectInput:               $var used to load into into $ObjectArray
} #>
<# Process Flow {
    function
        Call GetAzStorageShareAll > Get $null
        End GetAzStorageShareAll 
            Return Function > Send $null
}#>
Function ListAzStorageShare {                                                               # Function to list storage shares
    Begin {                                                                                 # Begin function
        :ListAzureStorageShare while ($true) {                                              # Outer loop for managing function
            Write-Host 'Getting shares list, this may take a moment'                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $RGList = Get-AzResourceGroup                                                   # Gets a list of all resource groups
            foreach ($_ in $RGList) {                                                       # For each item in $RGList
                $RGObject = $_.ResourceGroupName                                            # $RGObject is equal to current item .ResourceGroupName
                $StorageAccList = Get-AzStorageAccount -ResourceGroupName $RGObject         # Gets a list of all storage accounts on $RGObject
                if (!$StorageAccList) {                                                     # If $StorageAccList is $null
                    Write-Host 'Resource Group: ' $RGObject                                 # Write message to screen
                    Write-Host 'StorageAccount:  None'                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($StorageAccList)
                else {                                                                      # If $StorageAccList has a value
                    foreach ($_ in $StorageAccList) {                                       # For each item in $StorageAccList
                        $StorageAccObject = Get-AzStorageAccount -Name `
                            $_.StorageAccountName -ResourceGroupName $RGObject              # Pulls the full storage account context
                        $StorageShareList = Get-AzStorageShare -Context `
                            $StorageAccObject.Context                                       # Pulls a list for storage shares on $StorageAccObject
                        if (!$StorageShareList) {                                           # If $StorageShareList is $null
                            Write-Host 'Resource Group: ' $RGObject                         # Write message to screen
                            Write-Host 'Storage Account:' `
                                $StorageAccObject.StorageAccountName                        # Write message to screen
                            Write-Host 'Storage Share:   None'                              # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End if (!$StorageShareList)
                        else {                                                              # If $StorageShareList is not $null
                            [System.Collections.ArrayList]$ObjectArray=@()                  # Creates $ObjectArray
                            foreach ($_ in $StorageShareList) {                             # For each item in $ObjectList
                                $ObjectInput = [PSCustomObject]@{'Name'=$_.Name;`
                                    'QU'=$_.Quota;'LM'=$_.LastModified;`
                                    'IsSnap'=$_.IsSnapshot;'SST'=$_.SnapShotTime}           # Creates $ObjectInput
                                $ObjectArray.Add($ObjectInput) | Out-Null                   # Loads content of $ObjectInput into $ObjectArray
                            }                                                               # End foreach ($_ in $OpSelect)
                            foreach ($_ in $ObjectArray) {                                  # For each item in $ObjectArray
                                Write-Host 'Resource Group: ' $RGObject                     # Write message to screen
                                Write-Host 'Storage Account:' `
                                $StorageAccObject.StorageAccountName                        # Write message to screen
                                Write-Host 'Share Name:     '  $_.Name                      # Write message to screen
                                Write-Host 'QuotaGiB:       '$_.QU                          # Write message to screen
                                Write-Host 'Last Mod:       '$_.LM                          # Write message to screen
                                if ($_.IsSnap -eq 'True') {                                 # If current item .IsSnap is equal to true
                                    Write-Host 'SnapshotTime:   '$_.SST                     # Write message to screen
                                }                                                           # End if ($_.IsSnap -eq 'True')
                                Write-Host ''                                               # Write message to screen
                            }                                                               # End foreach ($_ in $ObjectArray)
                        }                                                                   # End else (if (!$StorageShareList))
                    }                                                                       # End foreach ($_ in $StorageAccList)
                }                                                                           # End else (if ($StorageAccList))
            }                                                                               # End foreach ($_ in $RGList)
            Pause                                                                           # Pauses for operator input
            Break ListAzureStorageShare                                                     # Breaks :ListAzureStorageShare
        }                                                                                   # End :ListAzureStorageShare while ($true)
        Clear-Host                                                                          # Clears Screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function ListAzStorageShare