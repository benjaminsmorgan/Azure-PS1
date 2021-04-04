# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    New-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcegroup?view=azps-5.1.0
    Remove-AzResourceGroup:     https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/NewAzResourceGroup.ps1 
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
    ListAzRGResources:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/ListAzRGResources.ps1
    RemoveAzResourceGroup:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/RemoveAzResourceGroup.ps1
    GetAzLocation: 
    GetAzRGLocksAll:            
    RemoveAzResourceLocks:      
} #>
<# Functions Description: {
    ManageAzResourceGroup:      Manages a resource group 
    NewAzResourceGroup:         Creates a resource group object
    GetAzResourceGroup:         Gets resource group from full name match
    ListAzRGResources:          Lists all resources within a resource group    
    RemoveAzResourceGroup:      Removes a resource group object
    GetAzLocation:              Gets a list of azure locations
    GetAzRGLocksAll:            Gets a list of locks on $RGObject
    RemoveAzResourceLocks:      Removes all items in $Locks
} #>
<# Variables: {
    :ManageAzureRG              Outer loop for managing function
    $RGObject:                  Resource group object
    $ManageAzRG:                Operator input for search option
    NewAzResourceGroup{}            Creates $RGObject
        GetAzLocation{}                 Gets $LocationObject
    GetAzResourceGroup{}            Gets $RGObject
    ListAzRGResources{}             Lists $RSObjects
        GetAzResourceGroup{}            Gets $RGObject
    RemoveAzResourceGroup{}         Removes $RGObject
        GetAzResourceGroup{}            Gets $RGObject
        GetAzRGLocksAll{}               Gets $Locks
        RemoveAzResourceLocks{}         Gets $LocksRemoved
} #>
<# Process Flow {
    Function
        Call ManageAzResourceGroup
            Call NewAzResourceGroup > Get $RGObject
                Call GetAzLocation > Get $LocationObject
                End GetAzLocation
                    Return NewAzResourceGroup > Send $LocationObject
            End NewAzResourceGroup
                Return ManageAzResourceGroup > Send $RGObject
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return ManageAzResourceGroup > Send $RGObject
            Call ListAzRGResources > Get $null
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return ListAzRGResources > Send $RGObject
            End ListAzRGResources
                Return ManageAzResourceGroup > Send $null
            Call RemoveAzResourceGroup > Get $null
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return RemoveAzResourceGroup > Send $RGObject
                Call function GetAzRGLocksAll > Get $Locks
                End GetAzRGLocksAll
                    Return RemoveAzResourceGroup > Send $Locks
                Call Function RemoveAzResourceLocks > Get $LocksRemoved
                End RemoveAzResourceLocks
                    Return RemoveAzResourceGroup > Send $LocksRemoved
            End RemoveAzResourceGroup
                Return ManageAzResourceGroup > Send $null
        End Function ManageAzResourceGroup
                Return Function > Send $RGObject                                    
}#> 
function ManageAzResourceGroup {                                                            # Function to manage resource groups
    Begin {                                                                                 # Begin function
        :ManageAzureRG while($true) {                                                       # Outer loop for managing function
            if ($RGObject) {                                                                # If $RGObject has a value
                Write-Host 'The currently selected resource group is:' `
                    $RGObject.ResourceGroupName                                             # Write message to screen
            }                                                                               # End if ($RGObject)
            Write-Host "Manage A Resource Group"                                            # Write message to screen
            Write-Host '[0] Clear Objects'                                                  # Write message to screen
            Write-Host '[1] New Resource Group'                                             # Write message to screen
            Write-Host '[2] Get Resource Group'                                             # Write message to screen
            Write-Host '[3] List Resources in Group'                                        # Write message to screen
            Write-Host '[4] Remove Resource Group'                                          # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $ManageAzRG = Read-Host 'Enter [#] option?'                                     # Operator input for selecting management function
            if ($ManageAzRG -eq 'exit') {                                                   # If $ManageAzRG equals 'exit'
                Break ManageAzureRG                                                         # Breaks :ManageAzureRG
            }                                                                               # End if ($ManageAzRG -eq 'exit')
            elseif ($ManageAzRG -eq '1') {                                                  # else if $ManageAzRG equals '1'
                Write-Host "New Resource Group"                                             # Write message to screen
                $RGObject = NewAzResourceGroup                                              # Calls function and assigns ouput to $var
            }                                                                               # End elseif ($ManageAzRG -eq '1')
            elseif ($ManageAzRG -eq '2') {                                                  # else if $ManageAzRG equals '2'
                Write-Host "Get Resource Group"                                             # Write message to screen
                $RGObject = GetAzResourceGroup                                              # Calls function and assigns ouput to $var
            }                                                                               # End elseif ($ManageAzRG -eq '2')
            elseif ($ManageAzRG -eq '3') {                                                  # else if $ManageAzRG equals '3'
                Write-Host "List Resources in Group"                                        # Write message to screen
                ListAzRGResources ($RGObject)                                               # Calls function
            }                                                                               # End elseif ($ManageAzRG -eq '3')
            elseif ($ManageAzRG -eq '4') {                                                  # else if $ManageAzRG equals '4'
                Write-Host "Remove Resource Group"                                          # Write message to screen
                RemoveAzResourceGroup ($RGObject)                                           # Calls function 
            }                                                                               # End elseif ($ManageAzRG -eq '4')
            elseif ($ManageAzRG -eq '0') {                                                  # else if $ManageAzRG equals '0'
                if ($RGObject) {                                                            # If $RGObject has a value
                    $RGObject = $null                                                       # Clears $RGObject
                    Write-Host '$RGObject has been cleared'                                 # Write message to screen
                }                                                                           # End if ($RGObject)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host '$RGObject was already clear'                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End elseif ($ManageAzRG -eq '0')
            else {                                                                          # All other inputs for ManageAzRG
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzRG -eq 'exit'))
        }                                                                                   # End :ManageAzResourceGroup while ($true)
        Return $RGObject                                                                    # Returns $vars to calling function
    }                                                                                       # End begin statement
}                                                                                           # End function ManageAzResourceGroup
function NewAzResourceGroup {                                                               # Function to create a resource group
    Begin {                                                                                 # Begin function
        :NewAzureRGObject while ($true) {                                                   # Outer loop for managing function
            $ErrorActionPreference='silentlyContinue'                                       # Disables Errors
            $Tag = $null                                                                    # Clears all previous use
            $RGObject = $null                                                               # Clears all previous use
            :SetAzureTag while ($true) {                                                    # Loop for creating and verifing $Tag
                $TagNameInput = Read-Host `
                    "Enter the name of the tag (leave blank to leave untagged)"             # Operator input for a tag name
                if (!$TagNameInput) {                                                       # If $TagNameInput equals 'skip'
                    Break SetAzureTag                                                       # Breaks :SetAzureTag
                }                                                                           # End if ($!TagNameInput)
                if ($TagNameInput -eq 'exit') {                                             # If $TagNameInput equals 'exit'
                    Break NewAzureRGObject                                                  # Breaks :NewAzrueRGObject
                }                                                                           # End if ($TagNameInput -eq 'exit')
                $TagValueInput = Read-Host "Enter the value of the tag"                     # Operator input for the tag value
                $Tag = @{$TagNameInput=$TagValueInput}                                      # Full tag to be applied to the resource group creation
                Write-Host "Tag { Name:"$TagNameInput "| Value:"$TagValueInput" }"          # Write message to screen
                Write-Host 'Apply this tag to the new resource group'                       # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation that tag info is correct
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureTag                                                       # Break :SetAzureTag
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureTag while ($true)
            :SetAzureName while ($true) {                                                   # Inner loop for setting the resource group name
                $RGObjectInput = Read-Host 'New resource group name'                        # Operator input for the resource group name
                Write-Host 'The new resource group will be called' $RGObjectInput           # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation that the name is correct
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureName                                                      # Break :SetAzureName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
                elseif ($OperatorConfirm -eq 'exit') {                                      # If $OperatorConfirm equals 'exit'
                    Break NewAzureRGObject                                                  # Breaks :NewAzrueRGObject
                }                                                                           # End elseif ($OperatorConfirm -eq 'exit')    
            }                                                                               # End :SetAzureName while ($true)
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                :SetAzureLocation while ($true) {                                           # Inner loop for setting the resource group location
                    $CallingFunction = 'NewAzResourceGroup'                                 # Creates $CallingFunction
                    $LocationObject = GetAzLocation ($CallingFunction)                      # Calls function and assigns output to $Var
                    if (!$LocationObject) {                                                 # If $LocationObject is $null
                        Break NewAzureRGObject                                              # Breaks :NewAzureRGObject
                    }                                                                       # End if (!$LocationObject)
                    Break SetAzureLocation                                                  # Breaks :SetAzureLocation
                }                                                                           # End :SetAzureLocation while ($true)
            }                                                                               # End if (!$LocationObject) 
            if ($Tag) {                                                                     # If $Tag has a value
                Try {                                                                       # Try the following
                    $RGObject = New-AzResourceGroup -Name $RGObjectInput -Location `
                        $LocationObject.Location -Tag $Tag -ErrorAction 'Stop'              # Creates the resouce group and assigns to $RGObject
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions required'                  # Write message to screen
                    Write-Host 'Policy may exist preventing this action'                    # Write message to screen
                    Break NewAzureRGObject                                                  # Breaks :NewAzureRGObject  
                }                                                                           # End catch
                Return $RGObject                                                            # Returns to calling function with $RGObject
            }                                                                               # End if ($Tag)
            else {                                                                          # If $Tag does not have a value
                Try {                                                                       # Try the following
                    $RGObject = New-AzResourceGroup -Name $RGObjectInput -Location `
                        $LocationObject.Location -Tag $Tag -ErrorAction 'Stop'              # Creates the resouce group and assigns to $RGObject
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions required'                  # Write message to screen
                    Write-Host 'Policy may exist preventing this action'                    # Write message to screen
                    Break NewAzureRGObject                                                  # Breaks :NewAzureRGObject  
                }                                                                           # End catch
                Return $RGObject                                                            # Returns to calling function with $RGObject
            }                                                                               # End else (if ($Tag))
        }                                                                                   # End :NewAzureRGObject while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End of begin statement
}                                                                                           # End function NewAzResourceGroup
function GetAzResourceGroup {                                                               # Function to get a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $RGList = Get-AzResourceGroup                                                   # Gets all resource groups and assigns to $RGList
            $RGListNumber = 1                                                               # Sets $RGListNumber to 1
            [System.Collections.ArrayList]$RGListArray = @()                                # Creates the RG list array
            foreach ($_ in $RGList) {                                                       # For each $_ in $RGListList
                $RGListInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $RGListNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $RGListArray.Add($RGListInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $RGListNumber = $RGListNumber + 1                                           # Increments $RGListNumber by 1
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host "[0]  Exit"                                                          # Write message to screen
            foreach ($_ in $RGListArray) {                                                  # For each $_ in $RGListArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number] "$_.Name "|" $_.Location                          # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]"$_.Name "|" $_.Location                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) )
            }                                                                               # End foreach ($_ in $RGListArray)
            :SelectAzureRGList while ($true) {                                              # Inner loop to select the resource group
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource group for"$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RGSelect = Read-Host "Enter the resource group number"                     # Operator input for the RG selection
                if ($RGSelect -eq '0') {                                                    # If $RGSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($RGSelect -eq '0')
                elseif ($RGSelect -in $ListArray.Number) {                                  # If $RGSelect in $ListArray.Number
                    $RGSelect = $RGListArray | Where-Object {$_.Number -eq $RGSelect}       # $RGSelect is equal to $RGArray where $RGArray.Number is equal to $RGSelect                                  
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $RGSelect.Name}                           # Pulls the full resource group object
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End elseif ($RGSelect -in $ListArray.Number)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureRGList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup
function ListAzRGResources {                                                                # Function to list all resources within a resource group
    Begin {                                                                                 # Begin function
        :ListAzureRGResources while ($true) {                                               # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject does not have a value
                $CallingFunction = 'ListAzRGResources'                                      # Creates $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject does not have a value
                    Break ListAzureRGResources                                              # Breaks :ListAzureRGResources
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            $RSList = Get-AzResource | Where-Object `
                {$_.ResourceGroupName -eq $RGObject.ResourceGroupName}                      # Creates a list of all resources within $RGObject
            if (!$RSList) {                                                                 # If $RSList is $null
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No resources in resource group'$RGObject.ResourceGroupName      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Break ListAzureRGResources                                                  # Breaks :ListAzureRGResources
            }                                                                               # End if (!$RSList)
            else {                                                                          # If $RSList has a value
                Write-Host ''                                                               # Write message to screen
                Write-Host `
                    'There are'$RSList.Count'resources in'$RGObject.ResourceGroupName       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $RSList) {                                                   # For each item in $RSList
                    Write-Host 'Name:'$_.Name                                               # Write message to screen
                    Write-Host 'Loc: '$_.Location                                           # Write message to screen
                    Write-Host 'Type:'$_.ResourceType                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $RSList)
                Break ListAzureRGResources                                                  # Breaks :ListAzureRGResources
            }                                                                               # End else (End if (!$RSList))
        }                                                                                   # End :ListAzureRGResources while ($true)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzRGResources
function RemoveAzResourceGroup {                                                            # Function to remove a resource group
    Begin {                                                                                 # Begin funciton
        :RemoveAzureRGObject while ($true) {                                                # Outer loop for managing function
            $ErrorActionPreference='silentlyContinue'                                       # Disables Errors
            if (!$RGObject) {                                                               # If $RGObject does not have a value
                $CallingFunction = 'RemoveAzResourceGroup'                                  # Creates $CallingFunction
                $RGObject = GetAzResourceGoup ($CallingFunction)                            # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject does not have a value
                    Break RemoveAzureRGObject                                               # Breaks :RemoveAzureRGObject
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            Write-Host "|////////////////////////////WARNING\\\\\\\\\\\\\\\\\\\\\\\\\\\\|"  # Write message to screen
            Write-Host `
                "|"$RGObject.ResourceGroupName "will be deleted, this cannot be undone"     # Write message to screen
            Write-Host "| All resource locks will be removed automatically if confirmed |"  # Write message to screen
            Write-Host "| All resources within the resource group will also be deleted  |"  # Write message to screen
            Write-Host "|\\\\\\\\\\\\\\\\\\\\\\\\\\\\WARNING////////////////////////////|"  # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator input on confirming deletion of the resource group
            $RGObjectName = $RGObject.ResourceGroupName                                     # Collects the name of the resource group for later use
            if ($OperatorConfirm -eq "Y") {                                                 # If $OperatorConfirm equals 'y'
                Write-Host "This resource group has been approved for deletion"             # Write message to screen
            }                                                                               # End if ($OperatorConfirm -eq 'Y')
            else {                                                                          # Else if $OperatorConfirm does not equal 'y'
                Break RemoveAzureRGObject                                                   # Breaks :RemoveAzureRGObject
            }                                                                               # End else (if ($OperatorConfirm -eq 'y')
            $Locks = $null                                                                  # Clears any previous use of $Locks
            $Locks = GetAzRGLocksAll ($RGObject)                                            # Calls function and assigns output to $vat
            if ($Locks) {                                                                   # If $Locks has a value
                Write-Host "Removing all locks"...                                          # Write message to screen
                $LocksRemoved = RemoveAzResourceLocks ($Locks)                              # Calls function
                if ($LocksRemoved -eq 'n') {                                                # If $LocksRemoved equals 'n'
                    Break RemoveAzureRGObject                                               # Breaks :RemoveAzureRGObject
                }                                                                           # End if ($LocksRemoved -eq 'n')
                Write-Host "Locks removed"                                                  # Write message to screen
            }                                                                               # End if ($Locks)
            Write-Host $RGObject.ResourceGroupName"is being removed, this may take a while" # Message write to screen
            Try {                                                                           # Try the following
                Remove-AzResourceGroup -Name $RGObject.ResourceGroupName -Force `
                    -ErrorAction 'Stop'                                                     # Removes the resource group
            }                                                                               # End Try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'The resource group was not removed'                             # Write message to screen
                Write-Host 'You may not have the permssions to complete this action'        # Write message to screen
                Break RemoveAzureRGObject                                                   # Break RemoveAzureRGObject   
            }                                                                               # End catch
            Write-Host $RGObjectName'has been removed'                                      # Write message to screen
            Break RemoveAzureRGObject                                                       # Break RemoveAzureRGObject
        }                                                                                   # End :RemoveAzureRGObject while ($True)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function RemoveAzResourceGroup
# Additional functions required for ManageAzResourceGroup
function GetAzLocation {                                                                    # Function to get azure location
    Begin {                                                                                 # Begin function
        :GetAzureLocation while ($true) {                                                   # Outer loop for managing function
            $ListObject = Get-AzLocation                                                    # Gets a list of all Azure locations
            $ListNumber = 1                                                                 # $Var for selecting the location
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the list array
            foreach ($_ in $ListObject) {                                                   # For each $_ in $ListObject
                $ListInput = [PSCustomObject]@{'Number' = $ListNumber; 'Location' `
                = $_.DisplayName}                                                           # Creates the item to load into array
                $ListArray.Add($ListInput) | Out-Null                                       # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $ListNumber by 1
            }                                                                               # End foreach ($_ in $ListObject)
            Write-Host "[ 0 ] Exit"                                                         # Write message to screen
            foreach ($_ in $ListArray) {                                                    # For each $_ in $ListArray
                Write-Host '['$_.Number']' $_.Location                                      # Writes number and location to screen
            }                                                                               # End foreach ($_ in $ListArray)
            :SelectAzureLocation while ($true) {                                            # Inner loop for selecting location from list
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the location for"$CallingFunction         # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $LocationSelect = Read-Host "Please enter [#] of the location"              # Operator input for the selection
                if ($LocationSelect -eq '0') {                                              # If $LocationSelect is 0
                    Break GetAzureLocation                                                  # Breaks :GetAzureLocation
                }                                                                           # End if ($LocationSelect -eq '0')
                elseif ($LocationSelect -in $ListArray.Number) {                            # If $LocationSelect in $ListArray.Number
                    $LocationSelect = $ListArray | Where-Object {$_.Number -eq `
                        $LocationSelect}                                                    # LocationSelect is equal to $ListArray where $LocationSelect equals $ListArray.Number
                    Try {                                                                   # Try the following
                        $LocationObject = Get-AzLocation | Where-Object {$_.DisplayName `
                            -eq $LocationSelect.Location} -ErrorAction 'Stop'               # Pulls the full $LocationObject
                    }                                                                       # End try
                    catch {                                                                 # If try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Write-Host 'Please try again later'                                 # Write message to screen
                        Break GetAzureLocation                                              # Breaks :GetAzureLocation 
                    }                                                                       # End catch
                    Return $LocationObject                                                  # Returns $LocationObject to calling function
                }                                                                           # End elseif ($LocationSelect -in $ListArray.Number) 
                else {                                                                      # All other inputs for $LocationSelect
                    Write-Host "That was not a valid selection"                             # Write message to screen   
                }                                                                           # End else (if ($LocationSelect -eq '0'))
            }                                                                               # End :SelectAzureLocation while ($true)
        }                                                                                   # End :GetAzureLocation while ($true)
        Return                                                                              # Returns with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLocation
function GetAzRGLocksAll {                                                                  # Function to get all locks assigned to a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        :GetAzureRGLocksAll while ($true) {                                                 # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'GetAzRGLocksAll'                                        # Creates $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break GetAzureRGLocksAll                                                # Breaks :GetAzureRGLocksAll
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName      # Collects all locks and assigns to $Locks
            if (!$Locks) {                                                                  # If $Locks is $null
                Write-Host "No locks are on this resource group"                            # Write message to screen
                Break GetAzureRGLocksAll                                                    # Breaks :GetAzureRGLocksAll
            }                                                                               # End if (!$Locks)
            else {                                                                          # Else if $Locks has a value
                Return $Locks                                                               # Returns $Locks to the calling function
            }                                                                               # End else (if (!$Locks))
        }                                                                                   # End :GetAzureRGLocksAll while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzRGLocksAll
function RemoveAzResourceLocks {                                                            # Function to remove resource locks
    Begin {                                                                                 # Begin function
        :RemoveAzureLocks while ($true) {                                                   # Outer loop for managing function
            if (!$Locks) {                                                                  # If $Locks is $null
                $Locks = GetAzResourceLocks                                                 # Calls GetAzResourceLocks and assigns to $Locks
                if(!$Locks) {                                                               # If $Locks is $null
                    Break RemoveAzureLocks                                                  # Breaks :RemoveAzureLocks
                }                                                                           # End if(!$Locks) | Inner
            }                                                                               # End if(!$Locks) | Outer
            foreach ($_ in $Locks) {                                                        # For each item in $Locks
                Write-Host $_.Name                                                          # Write message to screen
            }                                                                               # End foreach ($_ in $Locks)
            Write-Host 'Remove these locks'                                                 # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the locks
            if ($OperatorConfirm -eq 'Y') {                                                 # If $Operatorconfirm equals 'y' 
                foreach ($_ in $Locks) {                                                    # For each item in $Locks
                    Try {                                                                   # Try the following
                        Write-Host 'Removing'$_.name                                        # Write message to screen
                        Remove-AzResourceLock -LockId $_.LockId -force -ErrorAction 'Stop'  # Removes the current item in $Locks
                    }                                                                       # End try
                    catch {                                                                 # If Try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        $LocksRemoved = 'n'                                                 # Sets $LocksRemoved to 'n'
                        Return $LocksRemoved                                                # Returns to calling function with $LocksRemoved
                    }                                                                       # End catch
                }                                                                           # End foreach ($_ in $Locks)
                Write-Host 'All locks removed'                                              # Write message to screen
                $LocksRemoved = 'y'                                                         # Sets $LocksRemoved to 'y'
                Return $LocksRemoved                                                        # Returns to calling function with $LocksRemoved
            }                                                                               # End if ($OperatorConfirm -eq 'Y') 
            else {                                                                          # Else if $Operatorconfirm is not equal to 'y'
                Write-Host "No changes made"                                                # Message write to screen
                $LocksRemoved = 'n'                                                         # Sets $LocksRemoved to 'n'
                Return $LocksRemoved                                                        # Returns to calling function with $LocksRemoved
            }                                                                               # End else (if ($OperatorConfirm -eq 'Y') )
        }                                                                                   # End :RemoveAzureLocks while ($true)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function RemoveAzResourceLocks