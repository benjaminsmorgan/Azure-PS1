# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageshare?view=azps-5.3.0
    Get-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageshare?view=azps-5.3.0
    Remove-AzStorageShare:      https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageshare?view=azps-5.3.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/NewAzStorageShare.ps1
    GetAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShare.ps1
    GetAzStorageShareAll:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShareAll.ps1
    RemoveAzStorageShare:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/RemoveAzStorageShare.ps1
    ManageAzStorageShareItems:  TBD
    GetAzStorageAccObject:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzStorageShare:       Manages all functions for storage shares
        NewAzStorageShare:          Creates a new storage share
        GetAzStorageShare:          Gets a storage share
        GetAzStorageShareAll:       Lists all storage shares in a subscription
        RemoveAzStorageShare:       Removes a storage share
        ManageAzStoreShareItems:    Management function for storage share items
        GetAzStorageAccount:        Collects the storage account object
        GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :ManageAzureStorageShare    Outer loop for managing function
    $ManageAzStorageShare:      Operator input for selecting function
    $RGObject:                  Resource group object
    $StorageAccObject:          Storage account object
    $StorageShareObject:        Storage share object
    NewAzStorageShare{}         Function to create new storage share
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
    GetAzStorageShare{}         Gets $StorageShareObject               
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup {}        Gets $RGObject
    GetAzStorageShareAll{}      Gets all storage shares
    RemoveAzStorageShare{}      Removes $StorageShareObject
        GetAzStorageShare{}         Gets $StorageShareObject
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call ManageAzStorageShare > Get $null
            Call NewAzStorageShare > Get $StorageShareObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount
                    Return NewAzStorageShare > Send $StorageAccObject
            End NewAzStorageShare      
                Return Function > Send $StorageShareObject
            Call GetAzStorageShare > Get $StorageShareObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount
                    Return NewAzStorageShare > Send $StorageAccObject
            End GetAzStorageShare      
                Return Function > Send $StorageShareObject
            Call GetAzStorageShareAll > Get $null
            End GetAzStorageShareAll 
                Return Function > Send $null
            Call RemoveAzStorageShare > Get $null
                Call GetAzStorageShare > Get $StorageShareObject
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount
                        Return NewAzStorageShare > Send $StorageAccObject
                End GetAzStorageShare
            End RemoveAzStorageShare      
                Return ManageAzStorageShare > Send $null            
        End ManageAzStorageShare
            Return function > Send $null
}#>
function ManageAzStorageShare { # Manages storage blob functions
    Begin {
        :ManageAzureStorageShares while ($true) { # :ManageAzureStorageShares named loop to select search function
            Write-Host "Azure Storage Share Management" # Write message to screen
            Write-Host "1 New Storage Share" # Write message to screen
            Write-Host "2 Get Storage Share" # Write message to screen
            Write-Host "3 List All Storage Shares" # Write message to screen
            Write-Host "4 Remove Storage Share" # Write message to screen
            Write-Host "5 Manage Storage Share Contents" # Write message to screen
            Write-Host "0 Unselect currently selected resources" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageShare = Read-Host "Option?" # Collects operator input on $ManageAzStorageShare option
            if ($ManageAzStorageShare -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorageShares # Ends :ManageAzureStorageShares loop, leading to return statement
            } # End if ($ManageAzStorageShare -eq 'exit')
            elseif ($ManageAzStorageShare -eq '1') { # Elseif statement for managing storage accounts
                Write-Host "New Storage Share" # Write message to screen
                $StorageShareObject = NewAzStorageShare ($StorageAccObject, $RGObject) # Calls function and assigns to $var 
                Write-Host $StorageShareObject.Name
            } # End elseif ($ManageAzStorageShare -eq '1')
            elseif ($ManageAzStorageShare -eq '2') { # Elseif statement for managing storage containers
                Write-Host "Get Storage Share" # Write message to screen
                $StorageShareObject, $StorageAccObject = GetAzStorageShare ($StorageAccObject, $RGObject) # Calls function and assigns to $var 
            } # End elseif ($ManageAzStorageShare -eq '2')
            elseif ($ManageAzStorageShare -eq '3') { # Elseif statement for managing Blobs
                Write-Host "List All Storage Shares" # Write message to screen
                GetAzStorageShareAll # Calls function 
            } # End elseif ($ManageAzStorageShare -eq '3')
            elseif ($ManageAzStorageShare -eq '4') { # Elseif statement for managing Storage shares
                Write-Host "Remove Storage Share" # Write message to screen
                RemoveAzStorageShare ($StorageAccObject, $StorageShareObject) # Calls function and assigns to $var
            } # End elseif ($ManageAzStorageShare -eq '4')
            elseif ($ManageAzStorageShare -eq '0') { # Elseif statement for managing disks
                if ($RGObject) { # If $var is not $null
                Write-Host "Clearing" $RGObject.ResourceGroupName # Write message to screen
                $RGObject = $null # Sets $var to $null
                } # End if ($RGObject)
                if ($StorageAccObject) { # If $var is not $null
                Write-Host "Clearing" $StorageAccObject.StorageAccountName # Write message to screen
                $StorageAccObject = $null # Sets $var to $null
                } # End if ($StorageAccObject)
                if ($StorageShareObject) { # If $var is not $null
                Write-Host "Clearing" $StorageShareObject.Name # Write message to screen
                $StorageShareObject = $null # Sets $var to $null
                } # End if ($StorageBlobObject)
                Write-Host "All objects have been cleared" # Write message to screen
            } # End elseif ($ManageAzStorageShare -eq '0')
            Write-Host "" # Write message to screen
            if ($RGObject) { # If $var is not $null
                Write-Host "Current Resource Group:    " $RGObject.ResourceGroupName # Write message to screen
            } # End if ($RGObject)
            if ($StorageAccObject) { # If $var is not $null
                Write-Host "Current Storage Account:   " $StorageAccObject.StorageAccountName # Write message to screen
            } # End if ($StorageAccObject)
            if ($StorageShareObject) { # If $var is not $null
                Write-Host "Current Storage Share:   " $StorageShareObject.Name # Write message to screen
            } # End if ($StorageBlobObject)
            Write-Host "" # Write message to screen
        } # End :ManageAzureStorageShares while ($true)
        Return # Returns to calling function if no search option is used
    } # End begin
} # End function ManageAzStorage