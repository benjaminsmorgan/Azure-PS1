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
    GetAzStorageShare {              
        :GetAzureStorageShare       Outer loop for managing function
        :GetAzureStorageShareNumber Inner loop for getting the named storage share
        $StorageAccObject:          Storage account object
        $StorageShareList:          List of all storage shares in storage account
        $StorageShareListNumber:    Number used for generating list
        $StorageShareListSelect:    Operator input for which list number to use
        $StorageShareObject:        Storage Share object
        Function GetAzStorageAccount    
            Function GetAzResourceGroup
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
            $StorageShareList = Get-AzStorageShare -Context $StorageAccObject.Context # Collects all shares in selected storage account
            if (!$StorageShareList) { # If $StorageSharelist returns empty
                Write-Host "No storage shares found" # Message write to screen
                Break GetAzureStorageShare # Ends :GetAzureStorageShare
            } # End if (!$StorageShareList)
            $StorageShareListNumber = 1 # Sets the base value of $StorageShareListNumber
            Write-Host "0. Exit" # Writes exit option to screen
            foreach ($_ in $StorageShareList) { # For each item in $StorageShareList
                Write-Host $StorageShareListNumber"." $_.Name # Writes $StorageShareList to screen
                $StorageShareListNumber = $StorageShareListNumber+1 # Adds 1 to $StorageShareListNumber
            } # End foreach ($_ in $StorageShareList)
            :GetAzureStorageShareNumber while ($true) {
                $StorageShareListNumber = 1 # Sets the base value of $StorageShareListNumber
                $StorageShareListSelect = Read-Host "Please enter the number of the storage share" # Operator input for the storage share selection
                if ($StorageShareListSelect -eq '0') { # If $StorageShareList is '0'
                    Break :GetAzureStorageShare # Ends :GetAzureStorageShare
                } # if ($StorageShareListSelect -eq '0')
                foreach ($_ in $StorageShareList) { # For each item in $StorageShareList
                    if ($StorageShareListSelect -eq $StorageShareListNumber) { # If the operator input matches the current $StorageShareListNumber
                        $StorageShareObject = $_ # Assigns current item in $StorageShareList to $StorageShareObject
                        Break GetAzureStorageShareNumber # Breaks :GetAzureStorageShare
                    } # End if ($StorageShareListSelect -eq $StorageShareListNumber)
                    else { # If user input does not match the current $StorageShareListNumber
                        $StorageShareListNumber = $StorageShareListNumber+1 # Adds 1 to $StorageShareListNumber
                    } # End else (if ($StorageShareListSelect -eq $StorageShareListNumber))
                } # End foreach ($_ in $StorageShareList)
                Write-Host "That was not a valid entry" # Write message to screen
            } # End :GetAzureStorageShare while ($true) {
            Return $StorageShareObject # Returns to calling function with $StorageShareObject
        } # End :GetAzureStorageShare while ($true)
        Return # Returns $null
    } # End Begin
} # End Function GetAzStorageShare
function GetAzStorageAccount { # Function to get a storage account, can pipe $StorageAccObject to another function
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables errors
        :GetAzureStorageAccByName while ($true) { # Outer loop for function
            $ErrorActionPreference ='silentlyContinue' # Disables errors
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls (Function) GetAzResourceGroup to get $RGObject
                if (!$RGObject) { # If $RGObject is $null
                    Break GetAzureStorageACCByName # Ends :GetAzureStorageAccByName
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            $StorageAccList = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName # Collects all storage accounts in $RGObject and assigns to $StorageAccList
            if (!$StorageAccList) { # If $StorageAcclist returns empty
                Write-Host "No storage accounts found" # Message write to screen
                Break GetAzureStorageACCByName # Ends :GetAzureStorageAccByName
            } # End if (!$StorageAccList)
            $StorageAccListNumber = 1 # Sets the base value of $StorageAccListNumber
            Write-Host "0. Exit" # Writes exit option to screen
            foreach ($_ in $StorageAccList) { # For each item in $StorageAccList
                Write-Host $StorageAccListNumber"." $_.StorageAccountName # Writes $StorageAccList to screen
                $StorageAccListNumber = $StorageAccListNumber+1 # Adds 1 to $StorageAccListNumber
            } # End foreach ($_ in $StorageAccList)
            :GetAzureStorageAccount while ($true) {
                $StorageAccListNumber = 1 # Sets the base value of $StorageAccListNumber
                $StorageAccListSelect = Read-Host "Please enter the number of the storage account" # Operator input for the storage account selection
                if ($StorageAccListSelect -eq '0') { # If $StorageAccList is '0'
                    Break GetAzureStorageACCByName # Ends :GetAzureStorageAccByName
                } # if ($StorageAccListSelect -eq '0')
                foreach ($_ in $StorageAccList) { # For each item in $StorageAccList
                    if ($StorageAccListSelect -eq $StorageAccListNumber) { # If the operator input matches the current $StorageAccListNumber
                        $StorageAccObject = $_ # Assigns current item in $StorageAccList to $StorageAccObject
                        Break GetAzureStorageAccount # Breaks :GetAzureStorageAccount
                    } # End if ($StorageAccListSelect -eq $StorageAccListNumber)
                    else { # If user input does not match the current $StorageAccListNumber
                        $StorageAccListNumber = $StorageAccListNumber+1 # Adds 1 to $StorageAccListNumber
                    } # End else (if ($StorageAccListSelect -eq $StorageAccListNumber))
                } # End foreach ($_ in $StorageAccList)
                Write-Host "That was not a valid entry" # Write message to screen
            } # End :GetAzureStorageAccount while ($true) {
            Return $StorageAccObject # Returns to calling function with $StorageAccObject
        } # End :GetAzureStorageAccByName while ($true)
        Return # Returns to calling function with $null
    } # End begin 
} # End function GetAzStorageAccount
function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        $RGList = Get-AzResourceGroup # Gets all resource groups and assigns to $RGList
        if (!$RGList) { # If $RGList returns empty
            Write-Host "No resource groups found" # Message write to screen
            Return # Returns to calling function with $null
        } # End if (!$RGList)
        $RGListNumber = 1 # Sets the base value of the list
        Write-Host "0. Exit" # Adds exit option to beginning of list
        foreach ($_ in $RGList) { # For each item in list
            Write-Host $RGListNumber"." $_.ResourceGroupName # Writes the option number and resource group name
            $RGListNumber = $RGListNumber+1 # Adds 1 to $RGListNumber
        } # End foreach ($_ in $RGList)
        :GetAzureResourceGroup while ($true) { # Loop for selecting the resource group object
            $RGListNumber = 1 # Resets list number to 1
            $RGListSelect = Read-Host "Please enter the number of the resource group" # Operator input for selecting which resource group
            if ($RGListSelect -eq '0') { # If $RGListSelect is equal to 0
                Return # Returns to calling function with $null
            } # End if ($RGListSelect -eq '0')
            foreach ($_ in $RGList) { # For each item in list
                if ($RGListSelect -eq $RGListNumber) { # If the operator input matches the current $RGListNumber
                    $RGObject = $_ # Currently selected item in $RGList is assigned to $RGObject
                    Return $RGObject # Returns $RGObject to calling function
                } # End if ($RGListSelect -eq $RGListNumber)
                else { # If user input does not match the current $RGListNumber
                    $RGListNumber = $RGListNumber+1 # Adds 1 to $RGListNumber
                } # End else (if ($RGListSelect -eq $RGListNumber))
            } # End foreach ($_ in $RGList)
            Write-Host "That was not a valid selection, please try again" # Write message to screen
        } # End :GetAzureResourceGroup while ($true)
        Return $RGObject # Returns $RGObject to calling function
    } # End of begin statement
} # End of function