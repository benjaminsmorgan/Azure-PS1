# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageshare?view=azps-5.3.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzStorageAccObject:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    GetAzStorageShare:          Gets a storage share
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    GetAzStorageShare               
        :GetAzureStorageShare       Outer loop for managing function
        :GetAzureStorageShareName   Inner loop for getting the named storage share
        $StorageAccObject:          Storage account object
        $ShareNameInput:            Operator input for the share name
        $StorageShareObject:        Storage share object
        $StorageShareList:          List of all storage shares in storage account
        GetAzStorageAccount{
            :GetAzureStorageAccByName   Outer loop for managing funciton
            :GetAzureStorageAcc         Inner loop for getting the storage account
            $RGObject:                  Resource group object
            $StorageAccObjectInput:     Operator input for the name of the storage account
            $SAList:                    List of all storage accounts within $RGObject
            $StorageAccObject:          Storage account object    
            GetAzResourceGroup {
                $RGObject:                  Resource group object
                $RGObjectInput:             Operator input for the resource group name
                $RGList:                    Variable used for printing all resource groups to screen if needed
            } End GetAzResourceGroup
        } End GetAzStorageAccount
    } End GetAzStorageShare
} #>
<# Process Flow {
    function
        Call GetAzStorageShare > Get $StorageShareObject
            Call GetAzStorageAccount > Get $StorageAccObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzStorageAccount > Send $RGObject
            End GetAzStorageAccount
                Return NewAzStorageShare > Send $StorageAccObject
        End GetAzStorageShare      
            Return Function > Send $StorageShareObject
}#>
Function GetAzStorageShare { # Gets a storage share
    Begin {
        :GetAzureStorageShare while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $var is $null
                $StorageAccObject = GetAzStorageAccount ($RGObject) # Calls function and assigns to $var
                if (!$StorageAccObject) { # If $var is $null
                    Break GetAzureStorageShare # Breaks :GetAzureStorageShare
                } # End if (!$StorageAccObject) 
            } # End if (!$StorageAccObject) {
            :GetAzureStorageShareName while ($true) { # Inner loop for getting the named storage share
                $ShareNameInput = Read-Host "Storage share name" # Operator input for the share name
                if ($ShareNameInput -eq 'exit') { # If $ShareNameInput is 'exit'
                    Break GetAzureStorageShare # Breaks :GetAzureStorageShare
                } # End if ($ShareNameInput -eq 'exit')
                Try { # Try to get $StorageShareObject
                    $StorageShareObject = Get-AzStorageShare -Context $StorageAccObject.Context -Name $ShareNameInput # Collects the Storage share and assigns to $StorageShareObject
                } # End Try
                Catch { # If Try fails
                    $StorageShareObject = $null # Clears from previous use
                    Write-Host "The name provided does not match an existing share" # Write message to screen
                    Write-Host "Please select from the following" # Write message to screen
                    Write-Host "" # Write message to screen
                    $StorageShareList = Get-AzStorageShare -Context $StorageAccObject.Context # Collects all shares in selected storage account
                    Write-Host $StorageShareList.Name -Separator `n # Writes $StorageShareList to screen
                    Write-Host "" # Write message to screen
                } # End catch
                if ($StorageShareObject) { # If $StorageShareObject is not $null
                    Return $StorageShareObject # Returns $StorageShareObject to calling function
                } # End if ($StorageShareObject) 
            } # End :GetAzureStorageShareName while ($true)
        } # End :GetAzureStorageShare while ($true)
        Return # Returns nothing
    } # End Begin
} # End Function GetAzStorageShare