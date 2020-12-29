# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
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
} #>
<# Process Flow {
    function
        Call GetAzStorageAccount > Get $StorageAccObject
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return GetAzStorageAccount > Send $RGObject
        End GetAzStorageAccount 
            Return Function > Send $StorageAccObject
}#>
function GetAzStorageAccount { # Function to get a storage account, can pipe $StorageAccObject to another function
    Begin {
        :GetAzureStorageAccByName while ($true) { # Outer loop for function
            $ErrorActionPreference ='silentlyContinue' # Disables errors
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls (Function) GetAzResourceGroup to get $RGObject
                if (!$RGObject) { # If $RGObject is $null
                    Break GetAzureStorageACCByName # Ends :GetAzureStorageAccByName
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            :GetAzureStorageAcc while ($true) { # Loop to continue getting a storage account until the operator provided name matches an existing account
                $StorageAccObjectInput = Read-Host "Storage account name" # Operator input of the storage account name
                $StorageAccObject = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName -Name $StorageAccObjectInput # Collection of the storage account from the operator input
                if (!$StorageAccObject) { # Error reporting if input does not match and existing account
                    Write-Host "The name provided does not match an existing storage account" # Error reporting
                    $SAList = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName # Collects all storage accounts within $RGObject and assigns to $SAList
                    Write-Host "" # Error reporting
                    Write-Host $SAList.Storageaccountname -Separator `n # Write-host used so list is written to screen when function is used as $StorageAccObject = GetAzStorageAccount
                    Write-Host "" # Error reporting
                } # End (!$StorageAccObject)
                else { # Else for when $StorageAccObject is assigned
                    Write-Host $StorageAccObject.StorageAccountName 'Has been assigned to "$StorageAccObject"' # Writes the storage account name to the screen before ending function
                    Return $StorageAccObject # Returns $var to calling function
                } #End else ((!$StorageAccObject))
            } # End :GetAzureStorageAcc while ($true)
        } # End :GetAzureStorageAccByName while ($true)
        Return # Returns to calling function with $null
    } # End of begin statement
} # End of function