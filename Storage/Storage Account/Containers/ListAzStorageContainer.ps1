# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageContainer?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzStorageContainer:     Lists all storage containers by storage account
} #>
<# Variables: {
    $RGList:                    List of all resource groups in subscription
    $StorageAccList:            List of all storage accounts from current object in $RGList
    $StorageConList:            List of all storage containers from the current object in $StorageAccList
} #>
<# Process Flow {
    Function
        Call ListAzStorageContainer > Get $null
        End ListAzStorageContainer
            Return Function > Send $null
}#>
function ListAzStorageContainer {
    Begin {
        $RGList = Get-AzResourceGroup # creates list of all resource groups
        foreach ($_ in $RGList) { # For each object in $RGList
            Write-Host "------------------------------------------" # Write message to screen
            Write-Host $_.ResourceGroupName # Write message to screen
            $StorageAccList = Get-AzStorageAccount -ResourceGroupName $_.ResourceGroupName # Creates a list of all storage accounts in current resource group
            if ($StorageAccList) { # If storage accounts exist in this group
                foreach ($StorageAccountName in $StorageAccList) { # For each object in $StorageAccList
                    Write-Host "------------------------------------------" # Write message to screen
                    Write-Host "StorageAccount: " $StorageAccountName.StorageAccountName # Write message to screen
                    Try { # Try the following command
                        $StorageConList = Get-AzStorageContainer -Context $StorageAccountName.Context # Creates a list of all containers in current $StorageAccount
                    } # End Try
                    catch { # If try fails
                        Write-Host "You may not have the permissions to view this acount" # Write message to screen
                        Write-Host "The account maybe locked which prevents listing containers" # Write message to screen
                    } # End catch
                    if ($StorageConList) { # If storage containers exist in the current account
                        Write-Host "" # Write message to screen
                        foreach ($Name in $StorageConList) { # For each object in $StorageConList
                            Write-Host "Container Name:   " $Name.Name # Write message to screen
                        } # End foreach ($Name in $StorageConList)
                    } # End if ($StorageConList)
                    else { # If no storage containers exist in the current account
                        Write-Host "No containers exist in this storage account" # Write message to screen
                    } # End if ($StorageConList)
                } # End foreach ($_ in $StorageAccList)
            } # End if ($StorageAccList)
            else { # If no storage accounts exist in current group
                Write-Host "No Storage Accounts in this resource group" # Write message to screen
            } # End else(if ($StorageAccList))
        } # End foreach ($_ in $RGList)
        Write-Host "------------------------------------------" # Write message to screen
        Return # Returns to calling function
    } # End Begin
} # End function ListAzStorageContainer