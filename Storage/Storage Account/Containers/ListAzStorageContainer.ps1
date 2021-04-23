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
function ListAzStorageContainer {                                                           # Function for listing storage containers
    Begin {                                                                                 # Begin function
        :ListAzStorageCon while ($true) {                                                   # Outer loop for managing function
            $RGList = Get-AzResourceGroup                                                   # creates list of all resource groups
            foreach ($_ in $RGList) {                                                       # For each object in $RGList
                $StorageAccList = Get-AzStorageAccount -ResourceGroupName `
                    $_.ResourceGroupName                                                    # Creates a list of all storage accounts in current resource group
                if ($StorageAccList) {                                                      # If $StorageAccList has a value
                    foreach ($_ in $StorageAccList) {                                       # For each item in $StorageAccList
                        Write-Host '------------------------------------------'             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Resource group:   '$_.ResourceGroupName                 # Write message to screen
                        Write-Host 'Storage account:  '$_.StorageAccountName                # Write message to screen
                        Try {                                                               # Try the following 
                            $StorageConList = Get-AzStorageContainer -Context $_.Context    # Creates a list of all containers in current $StorageAccount
                        }                                                                   # End Try
                        catch {                                                             # If try fails
                            Write-Host `
                                'You may not have the permissions to view this acount'      # Write message to screen
                            Write-Host 'The account may have a lock on it'                  # Write message to screen
                        }                                                                   # End catch
                        if ($StorageConList) {                                              # If $StorageConList has a value
                            foreach ($_ in $StorageConList) {                               # For each item in $StorageConList
                                Write-Host 'Storage container:'$_.Name 
                            }                                                               # End foreach ($_ in $StorageConList)
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End if ($StorageConList)
                        else {                                                              # If $StorageConList does not have a value
                            Write-Host 'Storage container: None'                            # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End else  (if ($StorageConList))
                    }                                                                       # End foreach ($_ in $StorageAccList)
                }                                                                           # End if ($StorageAccList)
                else {                                                                      # If $StorageAccList does not have a value
                    Write-Host '------------------------------------------'                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'Resource group:   '$_.ResourceGroupName                     # Write message to screen
                    Write-Host 'Storage account:   None'                                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End else(if ($StorageAccList))
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host '------------------------------------------'                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen 
            Pause                                                                           # Pauses for operator input
            Break ListAzStorageCon                                                          # Breaks :ListAzStorageCon
        }                                                                                   # End :ListAzStorageCon while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzStorageContainer