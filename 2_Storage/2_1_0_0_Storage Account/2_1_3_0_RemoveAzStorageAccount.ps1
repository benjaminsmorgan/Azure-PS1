# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzStorageAccount:    https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageaccount?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    RemoveAzStorageAccount:     Removes the selected storage account
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :RemoveAzureStorageAcc      Outer loop for managing function
    $StorageAccObject:          Storage account object 
    $OpConfirm:                 Operator confirmation to remove the storage account
    $RSLocks:                   Locks on the storage account
    $RGLocks:                   Locks on the containing resource group
    GetAzStorageAccount{}       Gets $StorageAccObject
        GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call RemoveAzStorageAccount > Get $null
            Call GetAzStorageAccount > Get $StorageAccObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzStorageAccount > Send $RGObject 
            End GetAzStorageAccount    
                Return RemoveAzStorageAccount > Send $StorageAccObject
        End RemoveAzStorageAccount
            Return Function > Send $null
}#>
function RemoveAzStorageAccount {                                                           # Function to remove a storage account
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not exist
            $CallingFunction = 'RemoveAzStorageAccount'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureStorageAcc while ($true) {                                              # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Calls function and assigns to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break RemoveAzureStorageAcc                                                 # Breaks RemoveAzureStorageAcc
            }                                                                               # End if (!$StorageAccObject)
            Write-Host 'Remove storage account:'$StorageAccObject.StorageAccountName        # Write message to screen
            Write-Host 'From resource group:'$StorageAccObject.ResourceGroupName            # Write message to screen
            $OpConfirm = Read-Host '[Y] or [N]'                                             # Operator confimation to remove the storage account
            if ($OpConfirm -ne 'y') {                                                       # If $OpConfirm is not equal to 'y'
                Break RemoveAzureStorageAcc                                                 # Breaks RemoveAzureStorageAcc
            }                                                                               # End if ($OpConfirm -ne 'y')
            Clear-Host                                                                      # Clears screen
            Write-Host "Checking for resource locks"                                        # Write message to screen
            $RSLocks = Get-AzResourceLock | Where-Object `
                {$_.ResourceName -eq $StorageAccObject.StorageAccountName}                  # Collects all locks on the storage account
            $RGLocks = Get-AzResourceLock -ResourceGroupName `
                $StorageAccObject.ResourceGroupName -AtScope                                # Collects all locks on the resource group holding the storage account
            if ($RSLocks -or $RGLocks) {      
                if ($RSLocks) {                                                             # If $RSLocks is not $null
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'There are locks on this this resource'                      # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                }                                                                           # End if ($RSLocks)
                if ($RGLocks) {                                                             # If $RGLocks is not $null
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'There are locks on the storage'                             # Write message to screen
                    Write-Host "accounts's resource group"                                  # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                }                                                                           # End if ($RGLocks)
                Write-Host ''                                                               # Write message to screen
                Write-Host 'All locks will need to be removed'                              # Write message to screen
                Write-Host 'prior to removing this storage account'                         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureStorageAcc                                                 # Breaks :RemoveAzureStorageAcc
            }                                                                               # End if ($RSLocks -or $RGLocks)
            else {                                                                          # If $RSLocks and $RGLocks are $null
                Write-Host "No locks present on this storage account"                       # Write message to screen
            }                                                                               # End else (if ($RSLocks -or $RGLocks) )
            Try {                                                                           # Try the following
                Remove-AzStorageAccount -ResourceGroupName `
                    $StorageAccObject.ResourceGroupName -AccountName `
                    $StorageAccObject.StorageAccountName -Force -ErrorAction 'Stop'         # Removes storage account
            }                                                                               # End Try
            catch {                                                                         # Try fails
                Write-Host 'The storage account was not deleted'                            # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-host 'to remove this storage account'                                 # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureStorageAcc                                                 # Breaks RemoveAzureStorageAcc
            }                                                                               # End Catch
            Write-Host 'The selected storage account has been removed'                      # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break RemoveAzureStorageAcc                                                     # Breaks :RemoveAzureStorageAcc
        }                                                                                   # End :RemoveAzureStorageAcc while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function RemoveAzStorageAccount