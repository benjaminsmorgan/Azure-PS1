# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    New-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcegroup?view=azps-5.1.0
    Remove-AzResourceGroup:     https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    NewAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/NewAzResourceGroup.ps1 
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
    ListAzRGResources:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/ListAzRGResources.ps1
    RemoveAzResourceGroup:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/RemoveAzResourceGroup.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
    GetAzRGLocksAll:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzRGLocksAll.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLocks.ps1
} #>
<# Functions Description: {
    ManageAzResourceGroup:      Manages a resource group 
    NewAzResourceGroup:         Creates a resource group object
    ListAzResourceGroup:        Lists resource groups 
    GetAzResourceGroup:         Gets resource group from full name match
    ListAzRGResources:          Lists all resources within a resource group    
    RemoveAzResourceGroup:      Removes a resource group object
    GetAzLocation:              Gets a list of azure locations
    GetAzRGLocksAll:            Gets a list of locks on $RGObject
    RemoveAzResourceLocks:      Removes all items in $Locks
} #>
<# Variables: {
    :ManageAzureRG              Outer loop for managing function
    $OpSelect:                  Operator input for search option
    NewAzResourceGroup{}            Creates $RGObject
        GetAzLocation{}                 Gets $LocationObject
    ListAzResourceGroup{}           Lists $RGObjects
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
            Call NewAzResourceGroup > Get $null
                Call GetAzLocation > Get $LocationObject
                End GetAzLocation
                    Return NewAzResourceGroup > Send $LocationObject
            End NewAzResourceGroup
                Return ManageAzResourceGroup > Send $null
            Call ListAzResourceGroup > Get $null
            End ListAzResourceGroup
                Return ManageAzResourceGroup > Send $null
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
            Write-Host 'Manage A Resource Group'                                            # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Resource Group'                                             # Write message to screen
            Write-Host '[2] List Resource Groups'                                           # Write message to screen
            Write-Host '[3] List Resources in Group'                                        # Write message to screen
            Write-Host '[4] Search Resource Group'                                          # Write message to screen
            Write-Host '[5] Remove Resource Group'                                          # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureRG                                                         # Breaks :ManageAzureRG
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Resource Group'                                             # Write message to screen
                NewAzResourceGroup                                                          # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Resource Groups'                                           # Write message to screen
                ListAzResourceGroup                                                         # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'List Resources in Group'                                        # Write message to screen
                ListAzRGResources                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Search Resource Group'                                          # Write message to screen
                SearchAzResourceGroup                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Remove Resource Group'                                          # Write message to screen
                RemoveAzResourceGroup                                                       # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '5')
            else {                                                                          # All other inputs for ManageAzRG
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function ManageAzResourceGroup
function NewAzResourceGroup {                                                               # Function to create a resource group
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzResourceGroup'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureRGObject while ($true) {                                                   # Outer loop for managing function
            $ErrorActionPreference='silentlyContinue'                                       # Disables Errors
            $CurrentRGNames = Get-AzResourceGroup | Select-Object ResourceGroupName         # Gets a list of all currently existing names
            :SetAzureName while ($true) {                                                   # Inner loop for setting the resource group name
                Write-Host 'Enter a resource group name'                                    # Write message to screen
                $RGObjectInput = Read-Host 'Name'                                           # Operator input for the resource group name
                Clear-Host                                                                  # Clears screen
                if ($RGObjectInput -in $CurrentRGNames.ResourceGroupName) {                 # If $RGObjectInput is in $CurrentRGNames.ResourceGroupName
                    Write-Host $RGObjectInput 'is currently in use'                         # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    $RGObjectInput = $null                                                  # Clears $RGObjectInput
                }                                                                           # End if ($RGObjectInput -in $CurrentRGNames.ResourceGroupName)
                if ($RGObjectInput -eq 'exit') {                                            # If $RGObjectInput equals 'exit'
                    Break NewAzureRGObject                                                  # Breaks :NewAzrueRGObject
                }                                                                           # End elseif ($RGObjectInput -eq 'exit') 
                if ($RGObjectInput) {                                                       # If $RGObjectInput has a value
                    Write-Host 'The new resource group will be called:'$RGObjectInput       # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation that the name is correct
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureName                                                  # Break :SetAzureName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                    elseif ($OpConfirm -eq 'e') {                                           # Else if $OpConfirm equals 'e'
                        Break NewAzureRGObject                                              # Breaks :NewAzrueRGObject
                    }                                                                       # End elseif ($OpConfirm -eq 'e')
                }                                                                           # End if ($RGObjectInput)
            }                                                                               # End :SetAzureName while ($true)
            $LocationObject = GetAzLocation ($CallingFunction)                              # Calls function and assigns output to $Var
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                Break NewAzureRGObject                                                      # Breaks :NewAzureRGObject
            }                                                                               # End if (!$LocationObject)
            :SetAzureTag while ($true) {                                                    # Loop for creating and verifing $Tag
                Write-Host 'Enter a tag name'                                               # Write message to screen
                Write-Host 'Leave blank to create the'                                      # Write message to screen
                Write-Host 'resource group without tags'                                    # Write message to screen
                $TagNameInput = Read-Host 'Tag name'                                        # Operator input for a tag name
                Clear-Host                                                                  # Clears screen
                if (!$TagNameInput) {                                                       # If $TagNameInput equals 'skip'
                    Break SetAzureTag                                                       # Breaks :SetAzureTag
                }                                                                           # End if ($!TagNameInput)
                if ($TagNameInput -eq 'exit') {                                             # If $TagNameInput equals 'exit'
                    Break NewAzureRGObject                                                  # Breaks :NewAzrueRGObject
                }                                                                           # End if ($TagNameInput -eq 'exit')
                Write-Host 'Enter the tag value for:'$TagNameInput                          # Write message to screen
                $TagValueInput = Read-Host 'Tag value'                                      # Operator input for the tag value
                Clear-Host                                                                  # Clears screen
                $Tag = @{$TagNameInput=$TagValueInput}                                      # Full tag to be applied to the resource group creation
                Write-Host "Tag { Name:"$TagNameInput "| Value:"$TagValueInput" }"          # Write message to screen
                Write-Host 'Apply this tag to the new resource group'                       # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation that tag info is correct
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureTag                                                       # Break :SetAzureTag
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'e') {                                               # Else if $OpConfirm equals 'e'
                    Break NewAzureRGObject                                                  # Breaks :NewAzureRGObject
                }                                                                           # End elseif ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureTag while ($true)
            Try {                                                                       # Try the following
                if ($Tag) {                                                                     # If $Tag has a value        
                    Write-Host 'Building the resource group with the following settings:'   # Write message to screen
                    Write-Host 'Name:'$RGObjectInput                                        # Write message to screen
                    Write-Host 'Loc: '$LocationObject.Location                              # Write message to screen
                    Write-Host 'Tags:'$TagNameInput $TagValueInput                          # Write message to screen
                    New-AzResourceGroup -Name $RGObjectInput -Location `
                        $LocationObject.Location -Tag $Tag -ErrorAction 'Stop'              # Creates the resouce group and assigns to $RGObject
                }                                                                           # End if ($Tag)
                else {                                                                      # If $Tag is $null
                    Write-Host 'Building the resource group with the following settings:'   # Write message to screen
                    Write-Host 'Name:'$RGObjectInput                                        # Write message to screen
                    Write-Host 'Loc: '$LocationObject.Location                              # Write message to screen
                    New-AzResourceGroup -Name $RGObjectInput -Location `
                        $LocationObject.Location -Tag $Tag -ErrorAction 'Stop'              # Creates the resouce group and assigns to $RGObject
                }                                                                           # End else (if ($Tag))
            }                                                                               # End Try
            catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $MSG = $Error[0]                                                            # Gets the error message
                if ($MSG.Exception.InnerException.Body.Message) {                           # If $MSG.Exception.InnerException.Body.Message has a value             
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen    
                }                                                                           # End if ($MSG.Exception.InnerException.Body.Message)
                else {                                                                      # Else if $MSG.Exception.InnerException.Body.Message is $null
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen        
                }                                                                           # End else (if ($MSG.Exception.InnerException.Body.Message))
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureRGObject                                                      # Breaks :NewAzureRGObject    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears Screen
            Write-Host 'The resource group has been created'                                # Write message to screen
            Pause                                                                           # Pauses all actions for operator input 
            Break NewAzureRGObject                                                          # Breaks :NewAzureRGObject  
        }                                                                                   # End :NewAzureRGObject while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End of begin statement
}                                                                                           # End function NewAzResourceGroup
function ListAzResourceGroup {                                                              # Function to list all resource groups
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :ListAzureResourceGroup while ($true) {                                             # Outer loop for managing function
            $ObjectList = Get-AzResourceGroup                                               # Gets all resource groups and assigns to $ObjectList
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No resource groups in this subscription'                        # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureResourceGroup                                                # Breaks :ListAzureResourceGroup    
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates $ObjectListArray
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{                                           # PSCustom object to load items into array
                    'Name'=$_.ResourceGroupName;'Location'=$_.Location;'Tags'=$_.Tags}      # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
            }                                                                               # End foreach ($_ in $ObjectList)
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Name:      '$_.Name                                             # Write message to screen
                Write-Host 'Location   '$_.Location                                         # Write message to screen
                Write-Host 'Tag Names: '$_.Tags.Keys                                        # Write message to screen
                Write-Host 'Tag Values:'$_.Tags.Values                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureResourceGroup                                                    # Breaks :ListAzureResourceGroup
        }                                                                                   # End :ListAzureResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function ListAzResourceGroup
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
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                Write-Host '[0]  Exit'                                                      # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number] "$_.Name '|' $_.Location                      # Write message to screen
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        Write-Host "[$Number]"$_.Name '|' $_.Location                       # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9) )
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host 'You are selecting the resource group for:'$CallingFunction  # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the RG selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $OpSelect                                  
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $OpSelect.Name}                           # Pulls the full resource group object
                    Clear-Host                                                              # Clears screen
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End elseif ($OpSelect -in $ListArray.Number)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureObjectList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
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
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject does not have a value
                    Break RemoveAzureRGObject                                               # Breaks :RemoveAzureRGObject
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            Write-Host '////////////////////////////WARNING\\\\\\\\\\\\\\\\\\\\\\\\\\\\'    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host ' This will delete:'$RGObject.ResourceGroupName                      # Write message to screen
            Write-Host ' This action cannot be undone once completed'                       # Write message to screen
            Write-Host ' All resource locks will be removed automatically if confirmed '    # Write message to screen
            Write-Host ' All resources within the resource group will also be deleted  '    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '\\\\\\\\\\\\\\\\\\\\\\\\\\\\WARNING////////////////////////////'    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Delete this resource group'                                         # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator input on confirming deletion of the resource group
            Clear-Host                                                                      # Clears screen
            $RGObjectName = $RGObject.ResourceGroupName                                     # Collects the name of the resource group for later use
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                    Write-Host 'Checking for locks on:'$RGObjectName                        # Write message to screen
                $Locks = GetAzRGLocksAll ($RGObject)                                        # Calls function and assigns output to $vat
                if ($Locks) {                                                               # If $Locks has a value
                    Write-Host 'Removing all locks'                                         # Write message to screen
                    $LocksRemoved = RemoveAzResourceLocks ($Locks)                          # Calls function and assigns output to $var
                    if ($LocksRemoved -eq 'n') {                                            # If $LocksRemoved equals 'n'
                        Break RemoveAzureRGObject                                           # Breaks :RemoveAzureRGObject
                    }                                                                       # End if ($LocksRemoved -eq 'n')
                    Write-Host 'All Locks removed'                                          # Write message to screen
                }                                                                           # End if ($Locks)
                else {                                                                      # If $Locks does not have a value
                    Write-Host 'No locks on this resource group'                            # Write message to screen
                }                                                                           # End if ($Locks)
                Write-Host $RGObject.ResourceGroupName'is being removed'                    # Write message to screen
                Write-Host 'this may take a while'                                          # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzResourceGroup -Name $RGObject.ResourceGroupName -Force `
                        -ErrorAction 'Stop' | Out-Null                                      # Removes the resource group
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $MSG = $Error[0]                                                        # Gets the error message
                    if ($MSG.Exception.InnerException.Body.Message) {                       # If $MSG.Exception.InnerException.Body.Message has a value             
                        $MSG = $MSG.Exception.InnerException.Body.Message                   # Isolates the error message
                        Write-Warning $MSG                                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen    
                    }                                                                       # End if ($MSG.Exception.InnerException.Body.Message)
                    else {                                                                  # Else if $MSG.Exception.InnerException.Body.Message is $null
                        Write-Warning $MSG                                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen        
                    }                                                                       # End else (if ($MSG.Exception.InnerException.Body.Message))
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureRGObject                                               # Breaks :RemoveAzureRGObject    
                }                                                                           # End Catch
                Write-Host $RGObjectName'has been removed'                                  # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureRGObject                                                   # Break RemoveAzureRGObject
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureRGObject                                                   # Breaks :RemoveAzureRGObject
            }                                                                               # End else (if ($OpConfirm -eq 'y')
            
        }                                                                                   # End :RemoveAzureRGObject while ($True)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function RemoveAzResourceGroup
function SearchAzResourceGroup {                                                            # Function to manage search for resource group functions
    Begin {                                                                                 # Begin function
        :SearchAzureRG while($true) {                                                       # Outer loop for managing function
            Write-Host 'Azure Resource Group Search'                                        # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Search by name lookup'                                          # Write message to screen
            Write-Host '[2] Search by contained resource type'                              # Write message to screen
            Write-Host '[3] Search by resource group location'                              # Write message to screen
            Write-Host '[4] Search by tags'                                                 # Write message to screen
            $SearchAzRG = Read-Host 'Option [#]'                                            # Operator input on $SearchAzRG option
            if ($SearchAzRG -eq '0') {                                                      # If $SearchAzRG equals '0'
                Break SearchAzureRG                                                         # Breaks :SearchAzureRG
            }                                                                               # End if ($SearchAzRG -eq '0')
            elseif ($SearchAzRG -eq '1') {                                                  # Else if $SearchAzRG equals '1'
                Write-Host "Search by name"                                                 # Write message to screen
                $RGObject = SearchAzResourceGroupName                                       # Calls function and assigns output to $var
            }                                                                               # End elseif ($SearchAzRG -eq '1')
            elseif ($SearchAzRG -eq '2') {                                                  # Else if $SearchAzRG equals '2'
                Write-Host "Search by type"                                                 # Write message to screen
                $RGObject = SearchAzResourceGroupType                                       # Calls function and assigns output to $var
            }                                                                               # End elseif ($SearchAzRG -eq '2')
            elseif ($SearchAzRG -eq '3') {                                                  # Else if $SearchAzRG equals '3'
                Write-Host "Search by location"                                             # Write message to screen
                $RGObject = SearchAzResourceGroupLoc                                        # Calls function and assigns output to $var
            }                                                                               # End elseif ($SearchAzRG -eq '3')
            elseif ($SearchAzRG -eq '4') {                                                  # Else if $SearchAzRG equals '4'
                Write-Host "Search by tag"                                                  # Write message to screen
                $RGObject = SearchAzResourceGroupTag                                        # Calls function and assigns output to $var
            }                                                                               # End elseif ($SearchAzRG -eq '4')
            else {                                                                          # All other inputs for $SearchAzRG
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if($SearchAzRG -eq '0'))
            if ($RGObject) {                                                                # If $RGObject has a value
                Clear-Host                                                                  # Clears the screen
                Return $RGObject                                                            # Returns to calling function with $RGObject
            }                                                                               # End if ($RGObject)
            else {                                                                          # If $RGObject does not have a value
                Write-Host 'No resource group selected'                                     # Write message to screen
            }                                                                               # End else (if ($RGObject))
        }                                                                                   # End :SearchAzureRG while($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function SearchAzResourceGroup
function SearchAzResourceGroupName {                                                        # Function to search for resource group by name
    Begin {                                                                                 # Begin function
        :SearchAzureRGByName while($true) {                                                 # Outer loop for managing function
            $CallingFunction = 'SearchAzResourceGroupName'                                  # Creates $CallingFunction
            Write-Host 'Resource Group Search By Name'                                      # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Search by resource name'                                        # Write message to screen
            Write-Host '[2] Search by group name'                                           # Write message to screen
            $OperatorSearchOption = Read-Host 'Option [#]'                                  # Operator input for search method
            if ($OperatorSearchOption -eq '0') {                                            # If $OperatorSearchOption equals '0'
                Break SearchAzureRGByName                                                   # Breaks :SearchAzureRGByName
            }                                                                               # End if ($OperatorSearchOption -eq '0')
            elseif ($OperatorSearchOption -eq '1') {                                        # Else if $OperatorSearchOption equals '1' 
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject does not have a value
                    Break SearchAzureRGByName                                               # Breaks :SearchAzureRGByName
                }                                                                           # End if (!$RSObject)
                $RGObject = Get-AzResourceGroup | Where-Object `
                    {$_.ResourceGroupName -eq $RSObject.ResourceGroupName}                  # Pulls the resource group object holding $RSObject
                Clear-Host                                                                  # Clears the screen
                Return $RGObject                                                            # Returns $RGObject to calling function
            }                                                                               # End elseif ($OperatorSearchOption -eq '1')
            elseif ($OperatorSearchOption -eq '2') {                                        # Else if $OperatorSearchOption equals '2' 
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject does not have a value
                    Break SearchAzureRGByName                                               # Breaks :SearchAzureRGByName
                }                                                                           # End if (!$RGObject)        
                Return $RGObject                                                            # Returns $RGObject to calling function 
                Clear-Host                                                                  # Clears the screen
            }                                                                               # End elseif ($OperatorSearchOption -eq '2')
            else {                                                                          # All other inputs for $OperatorSearchOption
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # if ($OperatorSearchOption -eq '0')
        }                                                                                   # End :SearchAzureRGByName while($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SearchAzResourceGroupName
function SearchAzResourceGroupType {                                                        # Function to search for resource group by resource provider or type
    Begin {                                                                                 # Begin function
        :SearchAzureRGByType while($True) {                                                 # Outer loop for manaing function
            $RSObject = SearchAzResourceType                                                # Calls function and assigns output to $var
            if (!$RSObject) {                                                               # If $RSObject does not have a value
                Break SearchAzureRGByType                                                   # Breaks :SearchAzureRGByType
            }                                                                               # End if (!$RSObject)
            else {                                                                          # If $RSObject has a value
                $RGObject = Get-AzResourceGroup -name $RSObject.ResourceGroupName           # Pulls the resource group
                Clear-Host                                                                  # Clears the screen
                Return $RGObject                                                            # Returns to calling function with $var
            }                                                                               # End else if (!$RSObject)
        }                                                                                   # End :SearchAzRGByType while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function SearchAzResourceGroupType
function SearchAzResourceGroupLoc {                                                         # Function to search for a resource group by resource or group location
    Begin {                                                                                 # Begin function
        :SearchAzureByLoc while ($true) {                                                   # Outer loop for managing function
            if (!$LocationObject) {                                                         # If $LocationObject does not have a value
                $CallingFunction = 'SearchAzResourceGroupLoc'                               # Creates $CallingFunction
                $LocationObject = GetAzLocation ($CallingFunction)                          # Calls function and assigns output to $var
                if (!$LocationObject) {                                                     # If $LocationObject does not have a value
                    Break SearchAzureByLoc                                                  # End Break SearchAzureByLoc
                }                                                                           # End (Inner) if (!$LocationObject)
            }                                                                               # End (Outer) if (!$LocationObject)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Find Resource'                                                  # Write message to screen
            Write-Host '[2] Find Resource Group'                                            # Write message to screen
            $OperatorSelect = Read-Host 'Option [#]'                                        # Operator input for the search option
            if ($OperatorSelect -eq '0') {                                                  # If $OperatorSelect equals '0'
                Break SearchAzureByLoc                                                      # End Break SearchAzureByLoc
            }                                                                               # End if ($OperatorSelect -eq '0')
            elseif ($OperatorSelect -eq '1') {                                              # Else if $OperatorSelect equals '1'
                $RSObject = SearchAzResourceGroupLoc ($CallingFunction)                     # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject does not have a value
                    Break SearchAzureByLoc                                                  # Breaks :SearchAzureByLoc
                }                                                                           # End if (!$RSObject)
                else {                                                                      # If $RSObject does have a value
                    $RGObject = Get-AzResourceGroup -Name $RSObject.ResourceGroupName       # Pulls the resource group object
                    Clear-Host                                                              # Clears the screen
                    Return $RGObject                                                        # Returns to calling function with $var
                }                                                                           # End else (if (!$RSObject))
            }                                                                               # End elseif ($OperatorSelect -eq '1')
            elseif ($OperatorSelect -eq '2') {                                              # Else if $OperatorSelect equals '2'
                $RGList = Get-AzResourceGroup | Where-Object `
                    {$_.Location -eq $LocationObject.Location}                              # Gets a list of all resources within the $LocationObject.Location
                if (!$RGList) {                                                             # If $RGList is $null
                    Write-Host 'No resource groups found in'$LocationObject.Location        # Write message to screen
                    Start-Sleep(5)                                                          # Pauses all actions for 5 seconds
                    Break SearchAzureByLoc                                                  # End Break SearchAzureByLoc
                }                                                                           # End if (!$RGList)
                elseif ($RGList.Count -gt 1) {                                              # If $RGList.Count greater than 1
                    $ListNumber = 1                                                         # Sets $ListNumber to 1
                    [System.Collections.ArrayList]$ListArray = @()                          # Creates the $ListArray
                    foreach ($_ in $RGList) {                                               # For each $_ in $RGList
                        $ListInput = [PSCustomObject]@{'RG'=$_.ResourceGroupName; `
                            'Number'=$ListNumber}                                           # Creates the item to loaded into array
                        $ListArray.Add($ListInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                    }                                                                       # End foreach ($_ in $ProviderList)
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    foreach ($_ in $ListArray) {                                            # For each item in $ListArray
                        $Number = $_.number                                                 # $Number equals current item .Number
                        Write-Host "[$Number]" $_.RG                                        # Write message to screen
                    }                                                                       # End foreach ($_ in $ListArray)
                    :SelectAzureRG while ($true) {                                          # Inner loop for selecting a resource from list
                        $OperatorSelect = Read-Host 'Enter the resource group [#]'          # Operator input to select the resource
                        if ($OperatorSelect -eq '0') {                                      # If $OperatorSelect equals '0'
                        Break SearchAzureByLoc                                              # End Break SearchAzureByLoc
                        }                                                                   # End if ($OperatorSelect -eq '0')
                        elseif ($OperatorSelect -in $ListArray.Number) {                    # Else if $OperatorSelect -in $ListArray.Number
                            $RGObject = $ListArray | Where-Object `
                                {$_.Number -eq $OperatorSelect}                             # $RGObject equals $ListArray where $OperatorSelect equals $ListArray.Number
                            $RGObject = Get-AzResourceGroup -name $RGObject.RG              # Pulls the full resource group object
                            Clear-Host                                                      # Clears the screen
                            Return $RGObject                                                # Returns to calling function with $RGObject
                        }                                                                   # End elseif ($OperatorSelect -in $ListArray.Number)
                        else {                                                              # All other inputs for $OperatorSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OperatorSelect -eq '0'))
                    }                                                                       # End :SelectAzureRG while ($true) 
                }                                                                           # End elseif ($RGList.Count -gt 1)
                else {                                                                      # If $RGList has only a single item
                    $RGObject = Get-AzResourceGroup -name $RGList.Name                      # Pulls the full resource group object
                    Clear-Host                                                              # Clears the screen
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End else (if (!$RGList))
            }                                                                               # End elseif ($OperatorSelect -eq '2')
            else {                                                                          # All other inputs for $OperatorSelect 
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSelect -eq '0'))
        }                                                                                   # End :SearchAzureByLoc while ($true)
        Clear-Host                                                                          # Clears the screen 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End SearchAzResourceGroupLoc
function SearchAzResourceGroupTag {                                                         # Function to find a resource group from container tag 
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        :SearchAzureRGByTag while($true) {                                                  # :SearchAzureRGByTag loop finds a resource group off tag values
            $CallingFunction = 'SearchAzResourceGroupTag'                                   # Creates $CallingFunction
            Write-Host "Resource Group Search By Tag"                                       # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Search by resource tag'                                         # Write message to screen
            Write-Host '[2] Search by group tag'                                            # Write message to screen
            $OperatorSearchOption = Read-Host 'Option [#]'                                  # Operator input for $OperatorSearchOption
            if ($OperatorSearchOption -eq '0') {                                            # If $OperatorSearchOption equals '0'
                Break SearchAzureRGByTag                                                    # Breaks :SearchAzureRGByTag 
            }                                                                               # End if ($OperatorSearchOption -eq '0')
            elseif ($OperatorSearchOption -eq '1') {                                        # Else if $OperatorSearchOption equals '1'
                $RSObject = SearchAzResourceTag ($CallingFunction)                          # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject does not have a value
                    Break SearchAzureRGByTag                                                # Breaks :SearchAzureRGByTag
                }                                                                           # if (!$RSObject)
                else {
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $RSObject.ResourceGroupName}              # Pulls the resource group object holding $RSObject
                    Clear-Host                                                              # Clears the screen
                    Return $RGObject                                                        # Returns $RGObject to calling function
                }                                                                           # End (if (!$RSObject))
            }                                                                               # End elseif ($OperatorSearchOption -eq '1')
            elseif ($OperatorSearchOption -eq '2') {                                        # Else if $OperatorSearchOption equals '2'
                $RGList = Get-AzResourceGroup                                               # Creates a list of all resource groups
                $ObjectList = Get-AzTag | Where-Object {$_.Name -in $RGList.Tags.Keys}      # Pulls list of all tags in $RGList and assigns to $var
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$ObjectArray = @()                            # Creates the object array
                foreach ($_ in $ObjectList) {                                               # For each $_ in $ObjectList
                    $ObjectInput = [PSCustomObject]@{'Name' = $_.Name; `
                        'Number' = $ObjectNumber}                                           # Creates the item to loaded into array
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $ObjectList)
                Write-Host "[0]  Exit"                                                      # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number] "$_.Name                                      # Write message to screen
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        Write-Host "[$Number]"$_.Name                                       # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9) )
                }                                                                           # End foreach ($_ in $ObjectArray)
                :SelectTagName while ($true) {                                              # Loop for getting $TagNameInput
                    $TagNameInput = Read-Host "Enter the tag [#]"                           # Operator input for the Tag
                    if ($TagNameInput -eq '0') {                                            # If $TagNameInput equals '0'
                        Break SearchAzureRGByTag                                            # Breaks :SearchAzureRGByTag
                    }                                                                       # End if ($TagNameInput -eq '0')
                    elseif ($TagNameInput -in $ObjectArray.Number) {                        # If $TagNameInput in $ObjectArray.Number
                        $TagName = $ObjectArray | Where-Object `
                            {$_.Number -eq $TagNameInput}                                   # Pulls the tag name from $ObjectArray
                        $TagName = $TagName.Name                                            # Isolates .Name in $TagName
                        Clear-Host                                                          # Clears the screen
                        Break SelectTagName                                                 # Breaks :SelectTagName
                    }                                                                       # End elseif ($TagNameInput -in $ObjectArray.Number)
                    else {                                                                  # All other inputs for $TagNameInput
                        Write-Host 'That was not a valid option'                            # Write message to screen
                    }                                                                       # End else (if ($TagNameInput -eq '0'))
                }                                                                           # End :SelectTagName while ($true)
                Write-Host "Include a tag value in search"                                  # Write message to screen
                $OperatorGearchOption = Read-Host '[Y] or [N]'                              # Operator input for searching just by tag name, or adding a tag value
                if ($OperatorGearchOption -eq 'y') {                                        # If statement for adding a tag value
                    $ObjectList = (Get-AzTag -Name $TagName).values | Where-Object `
                        {$_.Name -in $RGList.Tags.Values}                                   # Gets all tag values under the tag name $TagName and in $RGList
                    $ObjectNumber = 1                                                       # Sets $ObjectNumber to 1
                    [System.Collections.ArrayList]$ObjectArray = @()                        # Creates the object array
                    foreach ($_ in $ObjectList) {                                           # For each $_ in $ObjectList
                        $ListInput = [PSCustomObject]@{'Name' = $_.Name; `
                            'Number' = $ObjectNumber}                                       # Creates the item to loaded into array
                        $ObjectArray.Add($ListInput) | Out-Null                             # Loads item into array, out-null removes write to screen
                        $ObjectNumber = $ObjectNumber + 1                                   # Increments $ObjectNumber by 1
                    }                                                                       # End foreach ($_ in $ObjectList)
                    Write-Host "[0]  Exit"                                                  # Write message to screen
                    foreach ($_ in $ObjectArray) {                                          # For each $_ in $ObjectArray
                        $Number = $_.Number                                                 # Sets $Number to current item .number
                        if ($_.Number -le 9) {                                              # If current item .number is 9 or less
                            Write-Host "[$Number] "$_.Name                                  # Write message to screen
                        }                                                                   # End if ($_.Number -le 9) 
                        else {                                                              # If current item .number is greater then 9
                            Write-Host "[$Number]"$_.Name                                   # Write message to screen
                        }                                                                   # End else (if ($_.Number -le 9) )
                    }                                                                       # End foreach ($_ in $ObjectArray)
                    :SelectTagValue while ($true) {                                         # Loop for getting $TagNameValue
                        $TagValueInput = Read-Host "Enter the tag value [#]"                # Operator input for the Tag value
                        if ($TagValueInput -eq '0') {                                       # If $TagValueInput equals '0'
                            Break SearchAzureRGByTag                                        # Breaks :SearchAzureRGByTag
                        }                                                                   # End if ($TagValueInput -eq '0')
                        elseif ($TagValueInput -in $ObjectArray.Number) {                   # If $TagValueInput in $ObjectArray.Number
                            $TagValue = $ObjectArray | Where-Object `
                                {$_.Number -eq $TagValueInput}                              # Pulls the tag value from $ObjectArray
                            $TagValue = $TagValue.Name                                      # Isolates the tag value name
                            Clear-Host                                                      # Clears the screen
                            Break SelectTagValue                                            # Breaks :SelectTagValue
                        }                                                                   # End elseif ($TagValueInput -in $ObjectArray.Number)
                        else {                                                              # All other inputs for $TagValueInput
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($TagValueInput -eq '0'))
                    }                                                                       # End :SelectTagValue while ($true)
                }                                                                           # End if ($OperatorGearchOption -eq 'y') 
                if ($TagValue) {                                                            # If statement for $TagValue having a value
                    $RGObject = Get-AzResourceGroup -Tag @{$TagName=$TagValue}              # Collects all resource groups where tag name and value matches $TagName and TagValue
                    if (!$RGObject) {                                                       # $RGObject does not have a value
                        Write-Host `
                            "No resource group found for the Tag Value"$TagValue.Name       # Write message to screen
                        Start-Sleep(5)                                                      # Pauses all actions for 5 seconds
                        Break SearchAzureRGByTag                                            # Breaks :SearchAzureRGByTag 
                    }                                                                       # End if (!$RGObject)
                }                                                                           # End if ($TagValue)
                else {                                                                      # Else statement for $TagValueInput not having a value
                    $RGObject = Get-AzResourceGroup -Tag @{$TagName=''}                     # Collects all resource groups where tag name matches $TagName
                    if (!$RGObject) {                                                       # $RGObject does not have a value
                        Write-Host "No resource group found for the Tag name"$TagName       # Write message to screen
                        Start-Sleep(5)                                                      # Pauses all actions for 5 seconds
                        Break SearchAzureRGByTag                                            # Breaks :SearchAzureRGByTag 
                    }                                                                       # End if (!$RGObject)
                }                                                                           # End else if (($TagValue))
                if ($RGObject.count -gt 1) {                                                # If $RGObject has more than 1 value
                    $ObjectNumber = 1                                                       # Sets $ObjectNumber to 1
                    [System.Collections.ArrayList]$ObjectArray = @()                        # Creates the object array
                    foreach ($_ in $RGObject) {                                             # For each $_ in $RGListList
                        $ListInput = [PSCustomObject]@{'Name'=$_.Name; `
                        'RG' = $_.ResourceGroupName;'Number' = $ObjectNumber; `
                        'Location' = $_.Location}                                           # Creates the item to loaded into array
                        $ObjectArray.Add($ListInput) | Out-Null                             # Loads item into array, out-null removes write to screen
                        $ObjectNumber = $ObjectNumber + 1                                   # Increments $ObjectNumber by 1
                    }                                                                       # End foreach ($_ in $RGObject)
                    Write-Host "[0]  Exit"                                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ObjectArray) {                                          # For each $_ in $ObjectArray
                        $Number = $_.Number                                                 # Sets $Number to current item .Number
                        if ($_.Number -le 9) {                                              # If current item .number is 9 or less
                            Write-Host "[$Number]   "$_.RG                                  # Write message to screen
                        }                                                                   # End if ($_.Number -le 9)
                        else {                                                              # If current item .number is more than 9
                            Write-Host "[$Number]  "$_.RG                                   # Write message to screen
                        }                                                                   # End else (if ($_.Number -le 9))
                        Write-Host 'Loc:  '$_.Location                                      # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $ObjectArray)
                    :SelectAzureResourceGroup while ($true) {                               # Inner loop to select the resource group
                        if ($CallingFunction) {                                             # If $CallingFunction exists
                            Write-Host `
                                "You are selecting the resource group for"$CallingFunction  # Write message to screen
                        }                                                                   # End if ($CallingFunction)
                        $RGSelect = Read-Host "Enter the resource group [#]"                # Operator input for the resource selection
                        if ($RGSelect -eq '0') {                                            # If $RGSelect equals 0
                            Break SearchAzureRGByTag                                        # Breaks :SearchAzureRGByTag
                        }                                                                   # End if ($RGSelect -eq '0')
                        elseif ($RGSelect -in $ObjectArray.Number) {                        # If $RGSelect is in $ObjectArray
                            $RGSelect = $ObjectArray | Where-Object `
                                {$_.Number -eq $RGSelect}                                   # $RGSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $RGSelect                                  
                            $RGObject = Get-AzResourceGroup -name $RGSelect.RG `
                                | Where-Object {$_.Name -eq $RGSelect.Name}                 # Pulls the full resource object
                            Clear-Host                                                      # Clears the screen
                            Return $RGObject                                                # Returns $RGObject to calling function
                        }                                                                   # End if ($RGSelect -in $ObjectArray)
                        else {                                                              # If $RGObject does not have a value
                            Write-Host "That was not a valid option"                        # Write message to screen
                        }                                                                   # End else (if ($RGSelect -eq '0')))
                    }                                                                       # End :SelectAzureResourceGroup while ($true)
                }                                                                           # End if ($RGObject.count -eq 1) 
                else {                                                                      # If $RGObject has a single value
                    Write-Host 'A single matching resource group is named:'$RGObject.Name   # Write message to screen
                    Start-Sleep(5)                                                          # Pauses all actions for 5 seconds
                    Clear-Host                                                              # Clears the screen
                    Return $RGObject                                                        # Returns $RGObject to calling function       
                }                                                                           # End else (if ($RGObject.count -eq 1))
            }                                                                               # End elseif ($OperatorSearchOption -eq '2')
            else {                                                                          # All other inputs for $OperatorSearchOption
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSearchOption -eq '0'))
        }                                                                                   # End :SearchAzureRGByTag while($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SearchAzResourceGroupTag
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
            :SelectAzureLocation while ($true) {                                            # Inner loop for selecting location from list
                Write-Host '[0]   Exit'                                                     # Write message to screen
                foreach ($_ in $ListArray) {                                                # For each $_ in $ListArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$Number]  "$_.Location                                 # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is more than 9
                        Write-Host "[$Number] "$_.Location                                  # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                }                                                                           # End foreach ($_ in $ListArray)
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host 'You are selecting the location for:'$CallingFunction        # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect is '0'
                    Break GetAzureLocation                                                  # Breaks :GetAzureLocation
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ListArray.Number) {                                  # If $OpSelect in $ListArray.Number
                    $OpSelect = $ListArray | Where-Object {$_.Number -eq $OpSelect}         # OpSelect is equal to $ListArray where $OpSelect equals $ListArray.Number
                    $LocationObject = Get-AzLocation | Where-Object {$_.DisplayName `
                        -eq $OpSelect.Location} -ErrorAction 'Stop'                         # Pulls the full $LocationObject
                    Return $LocationObject                                                  # Returns $LocationObject to calling function
                }                                                                           # End elseif ($OpSelect -in $ListArray.Number) 
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen   
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLocation while ($true)
        }                                                                                   # End :GetAzureLocation while ($true)
        Clear-Host                                                                          # Clears screen
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
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
                Break GetAzureRGLocksAll                                                    # Breaks :GetAzureRGLocksAll
            }                                                                               # End if (!$Locks)
            else {                                                                          # Else if $Locks has a value
                Return $Locks                                                               # Returns $Locks to the calling function
            }                                                                               # End else (if (!$Locks))
        }                                                                                   # End :GetAzureRGLocksAll while ($true)
        Clear-Host                                                                          # Clears the screen
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
            $OpConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the locks
            if ($OpConfirm -eq 'Y') {                                                 # If $Opconfirm equals 'y' 
                foreach ($_ in $Locks) {                                                    # For each item in $Locks
                    Try {                                                                   # Try the following
                        Write-Host 'Removing'$_.name                                        # Write message to screen
                        $Temp = Remove-AzResourceLock -LockId $_.LockId -force `
                            -ErrorAction 'Stop'                                             # Removes the current item in $Locks, $temp removes $True/$False from return
                    }                                                                       # End try
                    catch {                                                                 # If Try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        $LocksRemoved = 'n'                                                 # Sets $LocksRemoved to 'n'
                        Start-Sleep(10)                                                     # Pauses actions for 10 seconds
                        Clear-Host                                                          # Clears Screen
                        Return $LocksRemoved                                                # Returns to calling function with $LocksRemoved
                    }                                                                       # End catch
                }                                                                           # End foreach ($_ in $Locks)
                Write-Host 'All locks removed'                                              # Write message to screen
                $LocksRemoved = 'y'                                                         # Sets $LocksRemoved to 'n'
                Start-Sleep(10)                                                             # Pauses actions for 10 seconds
                Clear-Host                                                                  # Clears Screen
                Return $LocksRemoved                                                        # Returns to calling function with $LocksRemoved
            }                                                                               # End if ($OpConfirm -eq 'Y') 
            else {                                                                          # Else if $Opconfirm is not equal to 'y'
                Write-Host "No changes made"                                                # Message write to screen
                $LocksRemoved = 'n'                                                         # Sets $LocksRemoved to 'n'
                Return $LocksRemoved                                                        # Returns to calling function with $LocksRemoved
            }                                                                               # End else (if ($OpConfirm -eq 'Y') )
        }                                                                                   # End :RemoveAzureLocks while ($true)
        Clear-Host                                                                          # Clears Screen
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function RemoveAzResourceLocks