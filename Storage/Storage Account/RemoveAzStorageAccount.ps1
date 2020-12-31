# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzStorageAccount:    https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageaccount?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResourceLocksAll:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceLocksAll.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/RemoveAzResourceLocks.ps1 
} #>
<# Functions Description: {
    RemoveAzStorageAccount:     Removes the selected storage account
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects resource group object
    RemoveAzResourceLocks:      Removes locks
    GetAzResourceLocksAll:      Collects all locks on a resource
} #>
<# Variables: {
    RemoveAzStorageAccount{
        :RemoveAzureStorageAcc      Outer loop for managing function
        $StorageAccObject:          Storage account object 
        $StoreAccName:              Storage account object name
        $OperatorConfirm:           Operator confirmation to remove the storage account
        $RSObject:                  Resource object
        $RGObject:                  Resource group object
        $Locks:                     Locks on the storage account
        GetAzResourceGroup {
            $RGObject:                  Resource group object
            $RGObjectInput:             Operator input for the resource group name
            $RGList:                    Variable used for printing all resource groups to screen if needed
        } End GetAzResourceGroup
        GetAzResourceLocksAll {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $Locks:                 Locks object
        } End GetAzResourceLocksAll
        RemoveAzResourceLocks {
            $Locks:                 Lock or locks object
        } End RemoveAzResourceLocks    
    } End GetAzStorageAccount
} #>
<# Process Flow {
    function
        Call RemoveAzStorageAccount > Send $StorageAccObject > Get $null
            Call GetAzStorageAccount > Send $null > Get $StorageAccObject
                Call GetAzResourceGroup Send $null > Get $RGObject
                    Return GetAzStorageAccount > Send $RGObject 
                Return RemoveAzStorageAccount > Send $StorageAccObject
            Call GetAzResourceLocksAll > Send $RSObject > Get $Locks
                Return RemoveAzStorageAccount > Send $RGObject
            Call RemoveAzResourceLocks > Send $Locks > Get $null
                Return RemoveAzStorageAccount > Send $null 
            Return Function > Send $null
}#>
function RemoveAzStorageAccount { # Function to get a storage account, can pipe $StorageAccObject to another function
    Begin {
        :RemoveAzureStorageAcc while ($true) { # Outer loop for function
            $ErrorActionPreference ='silentlyContinue' # Disables errors
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Calls function and assigns to $var
                    if (!$StorageAccObject) { # If $StorageAccObject is still $null after calling function
                        Break RemoveAzureStorageAcc # Breaks RemoveAzureStorageAcc
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            else { # Else for when $StorageAccObject is assigned
                $StoreAccName = $StorageAccObject.name # Collects the name of the storage account and assigns to own $var
                $OperatorConfirm = Read-Host "Remove the following storage account" $StorageAccObject.Name "in" $StorageAccObject.ResourceGroupName # Operator confimation to remove the storage account
                if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')) { # If Operator confirm is not (equal 'y' or 'yes')
                    Break RemoveAzureStorageAcc # Breaks RemoveAzureStorageAcc
                } # End if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes'))
                Write-Host "Checking for resource locks" # Write message to screen
                $RSObject = Get-AzResource -Name $StorageAccObject.StorageAccountName -ResourceGroupName $StorageAccObject.ResourceGroupName # Collects the $RSObject 
                $RGObject = Get-AzResourceGroup -Name $StorageAccObject.ResourceGroupName # Collects the $RGObject
                $Locks = GetAzResourceLocksAll ($RSObject, $RGObject) #Calls function and assigns to $var
                if ($Locks) { # If $Locks is not $null
                    RemoveAzResourceLocks ($Locks) # Calls function assigns $null
                } # End if ($Locks)
                else { # If $Locks is $null
                    Write-Host "No locks present on this storage account" # Write message to screen
                } # End else (if ($Locks))
                Try { # Try to execute Remove-AzStorageAccount
                    Remove-AzStorageAccount -ResourceGroupName $StorageAccObject.ResourceGroupName -AccountName $StorageAccObject.StorageAccountName -Force -ErrorAction Stop # Removes storage account, -ErrorAction Stop used for catch statement
                } # End Try
                catch { # Try fails
                    Write-Host "The storage account was not deleted" # Write message to screen
                    if (Get-AzResourceLock -ResourceGroupName $StorageAccObject.ResourceGroupName -AtScope) { # If a lock exists on the resource group
                        Write-Host "There are locks on the resource group that must be removed before this storage account can be removed" # Write message to screen
                    } # End if (Get-AzResourceLock -ResourceGroupName $StorageAccObject.ResourceGroupName -AtScope)
                    else { # All other results for failing to remove the storage account
                        Write-Host "You may not have the permissions to remove this storage account" # Write message to screen
                    } # End else (if (Get-AzResourceLock -ResourceGroupName $StorageAccObject.ResourceGroupName -AtScope))
                    Break RemoveAzureStorageAcc # Breaks RemoveAzureStorageAcc
                } # End Catch
                Write-Host $StoreAccName"has been removed" # Write message to screen
                Return # Returns to calling function
            } # End else ((!$StorageAccObject))
        } # End :RemoveAzureStorageAcc while ($true)
        Write-Host "No changes made"
        Return # Returns to calling function with $null
    } # End begin 
} # End function GetAzStorageAccount