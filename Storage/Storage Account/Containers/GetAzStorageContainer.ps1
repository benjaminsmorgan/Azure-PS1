# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    } #>
<# Functions Description: {
    GetAzStorageContainer:      Collects storage container in a storage account    
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    GetAzStorageContainer {
        :GetAzureStorageContainer   Outer loop for managing function
        :GetAzureStorageConName     Inner loop for getting the storage container
        $StorageAccObject:          Storage account object    
        $StorageConNameInput:       Operator input for the storage container name
        $StorageConObject:          Storage container object
        $StorageConList:            List of all containers in storage account
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
    } End GetAzStorageContainer
} #>
<# Process Flow {
    function
        Call GetAzStorageContainer > Get $StorageConObject
            Call GetAzStorageAccount > Get $StorageAccObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzStorageAccount > Send $RGObject
            End GetAzStorageContainer 
                Return Function > Send $StorageConObject
}#>
function GetAzStorageContainer { # Collects storage container in a storage accoun
    Begin {
        $ErrorActionPreference='silentlyContinue'
        $StorageConObject = $null # Clears $StorageConObject from all previous use
        :GetAzureStorageContainer while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Call function and assigns to $var
                if (!$StorageAccObject) { # If $StorageAccObject is $null after returning from function
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            :GetAzureStorageConName while ($true) { # Inner loop for getting the storage container
                if (Get-AzResourceLock -AtScope -ResourceGroupName $StorageAccObject.ResourceGroupName | Where-Object {$_.Properties -like "@{Level=Read*"}) { # Checks for a ReadOnly lock on the owning resource group
                    Write-Host "There is a ReadOnly lock on"$StorageAccObject.ResourceGroupName"that is preventing the search of the storage container" # Write message to screen
                    Write-Host "This will need to be removed or converted to a CanNotDeleteLock" # Write message to screen
                    Break GetAzureStorageContainer # Break :GetAzureStorageContainer
                } # End if (Get-AzResourceLock -AtScope -ResourceGroupName $StorageAccObject.ResourceGroupName | Where-Object {$_.Properties -like "@{Level=Read*"}) 
                $StorageConNameInput = Read-Host "Storage container name" # Operator input for the storage container name
                if ($StorageConNameInput -eq 'exit') { # If $StorageConNameInput is 'exit'
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if ($StorageConNameInput -eq 'exit')
                if (!$StorageConNameInput) { # If $StorageConNameInput is $null
                    $StorageConNameInput = '0' # Sets a value that cannot be an existing storage container name
                } # End if (!$StorageConNameInput)
                $StorageConObject = Get-AzStorageContainer -Name $StorageConNameInput -Context $StorageAccObject.Context # Gets the storage container and assigns to $StorageConObject
                if ($StorageConObject) { # If $StorageConObject has a value
                    Return $StorageConObject # Returns $StorageConObject to calling function
                } # End if ($StorageConObject)
                else { # If $StorageConObject is empty
                    Write-Host "The name provided does not match and existing storage container" # Write message to screen
                    $StorageConList = Get-AzStorageContainer -Context $StorageAccObject.Context # Gets list of all containers in storage account
                    Write-Host $StorageConList.Name -Separator `n # Writes $StorageConList list to screen
                    Write-Host " " # Write message to screen
                    Write-Host "Please re-enter the storage container name" # Write message to screen
                } # End else (if ($StorageConObject))
            } # End :GetAzureStorageConName while ($true)
        } # End :GetAzureStorageContainer while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function GetAzStorageContainer