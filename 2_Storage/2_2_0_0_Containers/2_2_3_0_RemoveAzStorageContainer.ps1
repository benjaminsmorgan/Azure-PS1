# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzStorageContainer:  https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/GetAzStorageContainer.ps1
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    } #>
<# Functions Description: {
    RemoveAzStorageContainer:   Removes existing storage container
    GetAzStorageContainer:      Collects storage container in a storage account    
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    RemoveAzStorageContainer {
        :RemoveAzureStorageCon      Outer loop for managing function
        $StorageConObject:          Storage container object
        $StorageAccObject:          Storage account object
        $OpConfirm:                 Operator confirmation to remove the storage container
        GetAzStorageContainer{}     Gets $StorageConObject
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call RemoveAzStorageContainer > Get $null
            Call GetAzStorageContainer > Get $StorageConObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount
                    Return GetAzStorageContainer > Send $StorageAccObject
            End GetAzStorageContainer
                Return RemoveAzStorageContainer > Send $StorageConObject, $StorageAccObject
        End RemoveAzStorageContainer 
            Return Function > Send $null
}#>
function RemoveAzStorageContainer {                                                         # Function to removes existing storage container
    Begin {                                                                                 # Begin function
        $CallingFunction = 'RemoveAzStorageContainer'                                       # Creates $CallingFunction
        :RemoveAzureStorageCon while ($true) {                                              # Outer loop for managing function
            $StorageConObject, $StorageAccObject = GetAzStorageContainer ($CallingFunction) # Calls function and assigns output to $var
            if (!$StorageConObject) {                                                       # If $StorageConObject is $null
                Break RemoveAzureStorageCon                                                 # Breaks :RemoveAzureStorageCon
            }                                                                               # End if (!$StorageAccObject)
            Write-Host 'Remove storage container:' $StorageConObject.Name                   # Write message to screen
            Write-Host 'from storage account:    ' $StorageAccObject.StorageAccountName     # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confimation to remove the storage container
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzStorageContainer -Context $StorageAccObject.Context -Name `
                        $StorageConObject.Name -Force -ErrorAction 'Stop'                   # Removes storage container
                }                                                                           # End Try
                catch {                                                                     # Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the'                                       # Write message to screen
                    Write-Host 'permissions required'                                       # Write message to screen
                    Write-Host 'to complete this action'                                    # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Break RemoveAzureStorageCon                                             # Breaks RemoveAzureStorageAcc
                }                                                                           # End Catch
                Write-Host $StorageConObject.Name'has been removed'                         # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break RemoveAzureStorageCon                                                 # Breaks :RemoveAzureStorageCon
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes made'                                                # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break RemoveAzureStorageCon                                                 # Breaks :RemoveAzureStorageCon
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureStorageCon while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzStorageContainer