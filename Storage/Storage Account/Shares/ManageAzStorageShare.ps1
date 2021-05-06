# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageshare?view=azps-5.3.0
    Get-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageshare?view=azps-5.3.0
    Remove-AzStorageShare:      https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageshare?view=azps-5.3.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/NewAzStorageShare.ps1
    GetAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShare.ps1
    GetAzStorageShareAll:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShareAll.ps1
    RemoveAzStorageShare:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/RemoveAzStorageShare.ps1
    ManageAzStorageShareItems:  TBD
    GetAzStorageAccObject:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzStorageShare:       Manages all functions for storage shares
        NewAzStorageShare:          Creates a new storage share
        GetAzStorageShare:          Gets a storage share
        GetAzStorageShareAll:       Lists all storage shares in a subscription
        RemoveAzStorageShare:       Removes a storage share
        ManageAzStoreShareItems:    Management function for storage share items
        GetAzStorageAccount:        Collects the storage account object
        GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :ManageAzureStorageShare    Outer loop for managing function
    $OpSelect:      Operator input for selecting function
    $RGObject:                  Resource group object
    $StorageAccObject:          Storage account object
    $StorageShareObject:        Storage share object
    NewAzStorageShare{}         Function to create new storage share
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
    GetAzStorageShare{}         Gets $StorageShareObject               
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup {}        Gets $RGObject
    GetAzStorageShareAll{}      Gets all storage shares
    RemoveAzStorageShare{}      Removes $StorageShareObject
        GetAzStorageShare{}         Gets $StorageShareObject
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call ManageAzStorageShare > Get $null
            Call NewAzStorageShare > Get $StorageShareObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount
                    Return NewAzStorageShare > Send $StorageAccObject
            End NewAzStorageShare      
                Return Function > Send $StorageShareObject
            Call GetAzStorageShare > Get $StorageShareObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount
                    Return NewAzStorageShare > Send $StorageAccObject
            End GetAzStorageShare      
                Return Function > Send $StorageShareObject
            Call GetAzStorageShareAll > Get $null
            End GetAzStorageShareAll 
                Return Function > Send $null
            Call RemoveAzStorageShare > Get $null
                Call GetAzStorageShare > Get $StorageShareObject
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount
                        Return NewAzStorageShare > Send $StorageAccObject
                End GetAzStorageShare
            End RemoveAzStorageShare      
                Return ManageAzStorageShare > Send $null            
        End ManageAzStorageShare
            Return function > Send $null
}#>
function ManageAzStorageShare {                                                             # Function to manage azure storage shares
    Begin {                                                                                 # Begin function
        :ManageAzureStorageShares while ($true) {                                           # Outer loop for managing function
            Write-Host 'Azure Storage Share Management'                                     # Write message to screen
            Write-Host '[1] New Storage Share'                                              # Write message to screen
            Write-Host '[2] List Storage Shares'                                            # Write message to screen
            Write-Host '[3] Remove Storage Share'                                           # Write message to screen
            Write-Host '[4] Manage Storage Share Contents'                                  # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $OpSelect = Read-Host "Option?"                                                 # Operator input for selecting the management function
            if ($OpSelect -eq 'exit') {                                                     # If $OpSelect equals '0'
                Break ManageAzureStorageShares                                              # Breaks :ManageAzureStorageShares
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Storage Share'                                              # Write message to screen
                NewAzStorageShare                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Storage Shares'                                            # Write message to screen
                ListAzStorageShares                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Storage Share'                                           # Write message to screen
                RemoveAzStorageShare                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Manage Storage Share Contents'                                  # Write message to screen
                ManageAzStorageShareContent                                                 # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureStorageShares while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ManageAzStorageShare
function NewAzStorageShare {                                                                # Function to create a new storage share
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzStorageShare'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureStorageShare while ($true) {                                               # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break NewAzureStorageShare                                                  # Breaks :NewAzureStorageShare
            }                                                                               # End if (!$StorageAccObject)
            :SetAzureShareName while ($true) {                                              # Inner loop for setting the name of the new share
                $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789'                        # Creates a string of valid characters
                $ValidArray = $ValidArray.ToCharArray()                                     # Loads all valid characters into array
                Write-Host 'Storage share name must be atleast 3 characters'                # Write message to screen
                Write-Host 'and made up of letters and numbers only'                        # Write message to screen
                $ShareNameArray = $null                                                     # Clears $ShareNameArray
                $ShareNameInput = Read-Host 'Share name'                                    # Operator input for the share name
                $ShareNameInput = $ShareNameInput.ToLower()                                 # Recreates $ShareNameInput in lower
                $ShareNameArray = $ShareNameInput.ToCharArray()                             # Creates $ShareNameInput
                foreach ($_ in $ShareNameArray) {                                           # For each item in $ShareNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Share name cannot include any spaces'               # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $ShareNameInput = $null                                             # Clears $ShareNameInput
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $ShareNameArray)
                if (!$ShareNameInput) {                                                     # If $ShareNameInput is $null
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($ShareNameInput -eq '0')
                else {                                                                      # If $ShareNameInput not equal to '0'
                    Write-Host $ShareNameInput 'is correct'                                 # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of share name input
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureStorageShare                                          # Breaks NewAzureStorageShare
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm is equal to 'y'
                        Clear-Host                                                          # Clears screen
                        Break SetAzureShareName                                             # Breaks :SetAzureShareName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End else (if (!$ShareNameInput))
            }                                                                               # End :SetAzureShareName while ($true)
            Try {                                                                           # Try the following
                New-AzStorageShare -Name $ShareNameInput -Context `
                    $StorageAccObject.Context -ErrorAction 'Stop'                           # Creates the storage share
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'Check you permissions'                                          # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break NewAzureStorageShare                                                  # Breaks NewAzureStorageShare
            }                                                                               # End catch
            Write-Host 'The share has been created'                                         # Write message to screen
            Pause                                                                           # Pauses for operator input
            Break NewAzureStorageShare                                                      # Breaks NewAzureStorageShare
        }                                                                                   # End :NewAzureStorageShare while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzStorageShare
Function GetAzStorageShare {                                                                # Function to get a storage share
    Begin {                                                                                 # Begin function
        :GetAzureStorageShare while ($true) {                                               # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break GetAzureStorageShare                                                  # Breaks :GetAzureStorageShare
            }                                                                               # End if (!$StorageAccObject) 
            $ObjectList = Get-AzStorageShare -Context $StorageAccObject.Context             # Collects all shares in selected storage account
            if (!$ObjectList) {                                                             # If $ObjectList returns empty
                Write-Host 'No storage shares found'                                        # Message write to screen
                Write-Host 'on storage account'$StorageAccObject.StorageAccountName         # Message write to screen
                Pause                                                                       # Pauses all action for operator input
                Break GetAzureStorageShare                                                  # Breaks :GetAzureStorageShare
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray=@()                                  # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_.Name;`
                    'QU'=$_.Quota;'LM'=$_.LastModified;'IsSnap'=$_.IsSnapshot;`
                    'SST'=$_.SnapShotTime}                                                  # Creates $ObjectInput
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads content of $ObjectInput into $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
            }                                                                               # End foreach ($_ in $OpSelect)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                $Number = $_.Number                                                         # $Number is equal to current item .Number
                if ($Number -le 9) {                                                        # If $Number is 9 or less
                    Write-Host "[$Number]:         " $_.Name                                # Write message to screen
                }                                                                           # End if ($Number -le 9)
                else {                                                                      # If $Number is 10 or more
                    Write-Host "[$Number]:        " $_.Name                                 # Write message to screen
                }                                                                           # End else (if ($Number -le 9))
                Write-Host 'QuotaGiB:    '$_.QU                                             # Write message to screen
                Write-Host 'Last Mod:    '$_.LM                                             # Write message to screen
                if ($_.IsSnap -eq 'True') {                                                 # If current item .IsSnap is equal to true
                    Write-Host 'SnapshotTime:'$_.SST                                        # Write message to screen
                }                                                                           # End if ($_.IsSnap -eq 'True')
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureStorageShare while ($true) {                                        # Inner loop for selecting the storage share
                if ($CallingFunction) {                                                     # If $Calling function has a value
                    Write-Host 'You are selecting the storage share for:'$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Enter the storage share [#]'                         # Operator input for the storage share selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect is equal to '0'
                    Break GetAzureStorageShare                                              # Breaks :GetAzureStorageShare
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $StorageShareObject = Get-AzStorageShare -Name $OpSelect.Name -Context `
                    $StorageAccObject.Context                                               # Collects the full storage share object
                    if ($StorageShareObject) {                                              # If $StorageShareObject has a value
                        Clear-Host                                                          # Clears screen
                        Return $StorageShareObject, $StorageAccObject                       # Returns to $CallingFunction with $vars
                    }                                                                       # End if ($StorageShareObject)
                    else {                                                                  # If $StorageShareObject does not have a value
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Pause                                                               # Pauses for operator input
                        Break GetAzureStorageShare                                          # End Break GetAzureStorageShare
                    }                                                                       # End else (if ($StorageShareObject))
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End if ($OpSelect -eq '0')
            }                                                                               # End :SelectAzureStorageShare while ($true) 
        }                                                                                   # End :GetAzureStorageShare while ($true)
        Clear-Host                                                                          # Clears Screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function GetAzStorageShare
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
function GetAzResourceGroup {                                                               # Function to get a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $ObjectList = Get-AzResourceGroup                                               # Gets all resource groups and assigns to $ObjectList
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $ObjectNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host "[0]  Exit"                                                          # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number] "$_.Name "|" $_.Location                          # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]"$_.Name "|" $_.Location                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) )
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource group for"$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RGSelect = Read-Host "Enter the resource group number"                     # Operator input for the RG selection
                if ($RGSelect -eq '0') {                                                    # If $RGSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($RGSelect -eq '0')
                elseif ($RGSelect -in $ObjectArray.Number) {                                # If $RGSelect in $ObjectArray.Number
                    $RGSelect = $ObjectArray | Where-Object {$_.Number -eq $RGSelect}       # $RGSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $RGSelect                                  
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $RGSelect.Name}                           # Pulls the full resource group object
                    Clear-Host                                                              # Clears screen
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End elseif ($RGSelect -in $ListArray.Number)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureObjectList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup