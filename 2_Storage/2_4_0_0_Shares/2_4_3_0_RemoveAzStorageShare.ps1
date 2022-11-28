# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzStorageShare:      https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageshare?view=azps-5.3.0
    Get-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageshare?view=azps-5.3.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShare.ps1
    GetAzStorageAccObject:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    RemoveAzStorageShare:       Removes a storage share
    GetAzStorageShare:          Gets a storage share
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :RemoveAzureStorageShare    Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $StorageAccObject:          Storage account object
    $StorageShareObject:        Storage share object
    $OpConfirm:                 Operator confirmation to remove the share
    GetAzStorageShare{}         Gets $StorageShareObject      
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call RemoveAzStorageShare > Get $null
            Call GetAzStorageShare > Get $StorageShareObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount
                    Return NewAzStorageShare > Send $StorageAccObject
            End GetAzStorageShare
                Return RemoveAzStorageShare > Send $StorageShareObject, $StorageAccObject
        End RemoveAzStorageShare      
            Return Function > Send $null
}#>
function RemoveAzStorageShare {                                                             # Function to remove a storage share
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzStorageShare'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureStorageShare while ($true) {                                            # Outer loop for managing function
            $StorageShareObject, $StorageAccObject = GetAzStorageShare ($CallingFunction)   # Calls function and assigns output to $vars
            if (!$StorageShareObject) {                                                     # If $StorageShareObject is $null
                Break RemoveAzureStorageShare                                               # Breaks :RemoveAzureStorageShare
            }                                                                               # End if (!$StorageShareObject)
            Write-Host 'Remove the share:    '$StorageShareObject.Name                      # Write message to screen
            Write-Host 'From storage account:'$StorageAccObject.StorageAccountName          # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the share
            if ($OpConfirm -eq 'y') {                                                       # If OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzStorageShare -Name $StorageShareObject.Name -Context `
                        $StorageAccObject.Context -ErrorAction 'Stop'                       # Removes the share
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'Check you permissions'                                      # Write message to screen
                    Write-Host 'A lock or policy may'                                       # Write message to screen
                    Write-Host 'have prevented this action'                                 # Write message to screen
                    Pause                                                                   # Pauses action for operator input
                    Break RemoveAzureStorageShare                                           # Breaks :RemoveAzureStorageShare
                }                                                                           # End catch
                Write-Host 'The selected share has been removed'                            # Write message to screen
                Pause                                                                       # Pauses action for operator input
                Break RemoveAzureStorageShare                                               # Breaks :RemoveAzureStorageShare
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Break RemoveAzureStorageShare                                               # Breaks :RemoveAzureStorageShare
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureStorageShare while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzStorageShare