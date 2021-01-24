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
    GetAzResourceGroup:         Collects storage container object
} #>
<# Variables: {
    :GetAzureStorageContainer   Outer loop for managing function
    :GetAzureStorageConName     Inner loop for getting the storage container
    $StorageAccObject:          Storage account object    
    $SCList:                    List of all storage containers
    $SCListNumber:              $Var used for selecting $StorageConObject
    $SCListSelect:              Operator input for the matching $StorageConObject
    GetAzStorageAccount{}           Gets $StorageAccObject    
        GetAzResourceGroup{}            Gets $RGObject
} #>
<# Process Flow {
    function
        Call GetAzStorageContainer > Get $StorageConObject
            Call GetAzStorageAccount > Get $StorageAccObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzStorageAccount > Send $RGObject
            End GetAzStorageContainer 
                Return Function > Send $StorageConObject, $StorageAccObject
}#>
function GetAzStorageContainer {
    Begin {
        $ErrorActionPreference='silentlyContinue'
        :GetAzureStorageContainer while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Call function and assigns to $var
                if (!$StorageAccObject) { # If $StorageAccObject is $null after returning from function
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            $SCList = Get-AzStorageContainer -Context $StorageAccObject.Context
            $SCListNumber = 1 # Sets the base value of the list
            Write-Host "0. Exit" # Adds exit option to beginning of list
            foreach ($_ in $SCList) { # For each item in list
                Write-Host $SCListNumber"." $_.Name # Writes the option number and storage container name
                $SCListNumber = $SCListNumber+1 # Adds 1 to $SCListNumber
            } # End foreach ($_ in $SCList)
            :GetAzureStorageConName while ($true) { # Loop for selecting the storage container object
                $SCListNumber = 1 # Resets list number to 1
                $SCListSelect = Read-Host "Please enter the number of the storage container" # Operator input for selecting which storage container
                if ($SCListSelect -eq '0') { # If $SCListSelect is equal to 0
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if ($SCListSelect -eq '0')
                foreach ($_ in $SCList) { # For each item in list
                    if ($SCListSelect -eq $SCListNumber) { # If the operator input matches the current $SCListNumber
                        $StorageConObject = Get-AzStorageContainer -Context $StorageAccObject.Context -Name $_.Name # collects the full storage container object
                        Break GetAzureStorageConName # Breaks :GetAzureStorageConName 
                    } # End if ($SCListSelect -eq $SCListNumber)
                    else { # If user input does not match the current $SCListNumber
                        $SCListNumber = $SCListNumber+1 # Adds 1 to $SCListNumber
                    } # End else (if ($SCListSelect -eq $SCListNumber))
                } # End foreach ($_ in $SCList)
                Write-Host "That was not a valid selection, please try again" # Write message to screen
            } # End :GetAzureStorageConName while ($true)
            Return $StorageConObject
        } # End GetAzureStorageContainer
        Return # Returns to calling function with #null
    } # End Begin
} # End GetAzStorageContainer