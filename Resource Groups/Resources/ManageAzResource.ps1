# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    New-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcegroup?view=azps-5.1.0
    Remove-AzResourceGroup:     https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    NewAzResource:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/NewAzResource.ps1 
    GetAzResource:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResource.ps1
    ListAzResources:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/ListAzResources.ps1
    RemoveAzResource:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/RemoveAzResource.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
    GetAzRGLocksAll:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzRGLocksAll.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLocks.ps1
} #>
<# Functions Description: {
    ManageAzResource:      Manages a resource group 
    NewAzResource:         Creates a resource group object
    GetAzResource:         Gets resource group from full name match
    ListAzResources:          Lists all resources within a resource group    
    RemoveAzResource:      Removes a resource group object
    GetAzLocation:              Gets a list of azure locations
    GetAzRGLocksAll:            Gets a list of locks on $RSObject
    RemoveAzResourceLocks:      Removes all items in $Locks
} #>
<# Variables: {
    :ManageAzureSG              Outer loop for managing function
    $RSObject:                  Resource group object
    $ManageAzRS:                Operator input for search option
    NewAzResource{}            Creates $RSObject
        GetAzLocation{}                 Gets $LocationObject
    GetAzResource{}            Gets $RSObject
    ListAzResources{}             Lists $RSObjects
        GetAzResource{}            Gets $RSObject
    RemoveAzResource{}         Removes $RSObject
        GetAzResource{}            Gets $RSObject
        GetAzRGLocksAll{}               Gets $Locks
        RemoveAzResourceLocks{}         Gets $LocksRemoved
} #>
<# Process Flow {
    Function
        Call ManageAzResource
            Call NewAzResource > Get $RSObject
                Call GetAzLocation > Get $LocationObject
                End GetAzLocation
                    Return NewAzResource > Send $LocationObject
            End NewAzResource
                Return ManageAzResource > Send $RSObject
            Call GetAzResource > Get $RSObject
            End GetAzResource
                Return ManageAzResource > Send $RSObject
            Call ListAzResources > Get $null
                Call GetAzResource > Get $RSObject
                End GetAzResource
                    Return ListAzResources > Send $RSObject
            End ListAzResources
                Return ManageAzResource > Send $null
            Call RemoveAzResource > Get $null
                Call GetAzResource > Get $RSObject
                End GetAzResource
                    Return RemoveAzResource > Send $RSObject
                Call function GetAzRGLocksAll > Get $Locks
                End GetAzRGLocksAll
                    Return RemoveAzResource > Send $Locks
                Call Function RemoveAzResourceLocks > Get $LocksRemoved
                End RemoveAzResourceLocks
                    Return RemoveAzResource > Send $LocksRemoved
            End RemoveAzResource
                Return ManageAzResource > Send $null
        End Function ManageAzResource
                Return Function > Send $RSObject                                    
}#> 
function ManageAzResource {                                                                 # Function to manage resource
    Begin {                                                                                 # Begin function
        :ManageAzureSG while($true) {                                                       # Outer loop for managing function
            if ($RSObject) {                                                                # If $RSObject has a value
                Write-Host 'The currently selected resource is:'$RSObject.Name              # Write message to screen
            }                                                                               # End if ($RSObject)
            Write-Host "Manage A Resource Group"                                            # Write message to screen
            Write-Host '[0] Clear Objects'                                                  # Write message to screen
            Write-Host '[1] New Resource'                                                   # Write message to screen
            Write-Host '[2] Get Resource'                                                   # Write message to screen
            Write-Host '[3] List Resources by Group'                                        # Write message to screen
            Write-Host '[4] Remove Resource'                                                # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $ManageAzRS = Read-Host 'Enter [#] option?'                                     # Operator input for selecting management function
            if ($ManageAzRS -eq 'exit') {                                                   # If $ManageAzRS equals 'exit'
                Break ManageAzureSG                                                         # Breaks :ManageAzureSG
            }                                                                               # End if ($ManageAzRS -eq 'exit')
            elseif ($ManageAzRS -eq '1') {                                                  # else if $ManageAzRS equals '1'
                Write-Host "New Resource"                                                   # Write message to screen
                $RSObject = NewAzResource                                                   # Calls function and assigns ouput to $var
            }                                                                               # End elseif ($ManageAzRS -eq '1')
            elseif ($ManageAzRS -eq '2') {                                                  # else if $ManageAzRS equals '2'
                Write-Host "Get Resource "                                                  # Write message to screen
                $RSObject = GetAzResource                                                   # Calls function and assigns ouput to $var
            }                                                                               # End elseif ($ManageAzRS -eq '2')
            elseif ($ManageAzRS -eq '3') {                                                  # else if $ManageAzRS equals '3'
                Write-Host "List Resources By Group"                                        # Write message to screen
                ListAzResources ($RSObject)                                                 # Calls function
            }                                                                               # End elseif ($ManageAzRS -eq '3')
            elseif ($ManageAzRS -eq '4') {                                                  # else if $ManageAzRS equals '4'
                Write-Host "Remove Resource"                                                # Write message to screen
                RemoveAzResource ($RSObject)                                                # Calls function 
            }                                                                               # End elseif ($ManageAzRS -eq '4')
            elseif ($ManageAzRS -eq '0') {                                                  # else if $ManageAzRS equals '0'
                if ($RSObject) {                                                            # If $RSObject has a value
                    $RSObject = $null                                                       # Clears $RSObject
                    Write-Host '$RSObject has been cleared'                                 # Write message to screen
                }                                                                           # End if ($RSObject)
                else {                                                                      # If $RSObject does not have a value
                    Write-Host '$RSObject was already clear'                                # Write message to screen
                }                                                                           # End else (if ($RSObject))
            }                                                                               # End elseif ($ManageAzRS -eq '0')
            else {                                                                          # All other inputs for ManageAzRS
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzRS -eq 'exit'))
        }                                                                                   # End :ManageAzResource while ($true)
        Clear-Host                                                                          # Clears screen
        Return $RSObject                                                                    # Returns $vars to calling function
    }                                                                                       # End begin statement
}                                                                                           # End function ManageAzResource
function NewAzResource {                                                               # Function to create a resource group
    Begin {                                                                                 # Begin function
        :NewAzureRSObject while ($true) {                                                   # Outer loop for managing function
            $ErrorActionPreference='silentlyContinue'                                       # Disables Errors
            $Tag = $null                                                                    # Clears all previous use
            $RSObject = $null                                                               # Clears all previous use
            :SetAzureTag while ($true) {                                                    # Loop for creating and verifing $Tag
                $TagNameInput = Read-Host `
                    "Enter the name of the tag (leave blank to leave untagged)"             # Operator input for a tag name
                if (!$TagNameInput) {                                                       # If $TagNameInput equals 'skip'
                    Break SetAzureTag                                                       # Breaks :SetAzureTag
                }                                                                           # End if ($!TagNameInput)
                if ($TagNameInput -eq 'exit') {                                             # If $TagNameInput equals 'exit'
                    Break NewAzureRSObject                                                  # Breaks :NewAzrueRSObject
                }                                                                           # End if ($TagNameInput -eq 'exit')
                $TagValueInput = Read-Host "Enter the value of the tag"                     # Operator input for the tag value
                $Tag = @{$TagNameInput=$TagValueInput}                                      # Full tag to be applied to the resource group creation
                Write-Host "Tag { Name:"$TagNameInput "| Value:"$TagValueInput" }"          # Write message to screen
                Write-Host 'Apply this tag to the new resource'                       # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation that tag info is correct
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureTag                                                       # Break :SetAzureTag
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureTag while ($true)
            :SetAzureName while ($true) {                                                   # Inner loop for setting the resource group name
                $RSObjectInput = Read-Host 'New resource name'                        # Operator input for the resource group name
                if ($RSObjectInput -eq 'exit') {                                            # If $RSObjectInput equals 'exit'
                    Break NewAzureRSObject                                                  # Breaks :NewAzrueRSObject
                }                                                                           # End elseif ($RSObjectInput -eq 'exit') 
                Write-Host 'The new resource will be called' $RSObjectInput           # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation that the name is correct
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureName                                                      # Break :SetAzureName
                }                                                                           # End if ($OperatorConfirm -eq 'y')   
            }                                                                               # End :SetAzureName while ($true)
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                :SetAzureLocation while ($true) {                                           # Inner loop for setting the resource group location
                    $CallingFunction = 'NewAzResource'                                 # Creates $CallingFunction
                    $LocationObject = GetAzLocation ($CallingFunction)                      # Calls function and assigns output to $Var
                    if (!$LocationObject) {                                                 # If $LocationObject is $null
                        Break NewAzureRSObject                                              # Breaks :NewAzureRSObject
                    }                                                                       # End if (!$LocationObject)
                    Break SetAzureLocation                                                  # Breaks :SetAzureLocation
                }                                                                           # End :SetAzureLocation while ($true)
            }                                                                               # End if (!$LocationObject) 
            if ($Tag) {                                                                     # If $Tag has a value
                Try {                                                                       # Try the following
                    Write-Host 'Building the resource group with the following settings:'   # Write message to screen
                    Write-Host 'Name:'$RSObjectInput                                        # Write message to screen
                    Write-Host 'Loc: '$LocationObject.Location                              # Write message to screen
                    Write-Host 'Tags:'$TagNameInput $TagValueInput                          # Write message to screen
                    $RSObject = New-AzResourceGroup -Name $RSObjectInput -Location `
                        $LocationObject.Location -Tag $Tag -ErrorAction 'Stop'              # Creates the resouce group and assigns to $RSObject
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions required'                  # Write message to screen
                    Write-Host 'Policy may exist preventing this action'                    # Write message to screen
                    Start-Sleep(10)                                                         # Pauses all actions for 10 seconds
                    Break NewAzureRSObject                                                  # Breaks :NewAzureRSObject  
                }                                                                           # End catch
                Clear-Host                                                                  # Clears Screen
                Return $RSObject                                                            # Returns to calling function with $RSObject
            }                                                                               # End if ($Tag)
            else {                                                                          # If $Tag does not have a value
                Try {                                                                       # Try the following
                    Write-Host 'Building the resource group with the following settings:'   # Write message to screen
                    Write-Host 'Name:'$RSObjectInput                                        # Write message to screen
                    Write-Host 'Loc: '$LocationObject.Location                              # Write message to screen
                    $RSObject = New-AzResourceGroup -Name $RSObjectInput -Location `
                        $LocationObject.Location -Tag $Tag -ErrorAction 'Stop'              # Creates the resouce group and assigns to $RSObject
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions required'                  # Write message to screen
                    Write-Host 'Policy may exist preventing this action'                    # Write message to screen
                    Start-Sleep(10)                                                         # Pauses all actions for 10 seconds
                    Break NewAzureRSObject                                                  # Breaks :NewAzureRSObject  
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Return $RSObject                                                            # Returns to calling function with $RSObject
            }                                                                               # End else (if ($Tag))
        }                                                                                   # End :NewAzureRSObject while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End of begin statement
}                                                                                           # End function NewAzResource
function GetAzResource {                                                                    # Function to get a resource 
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResource while ($true) {                                                   # Outer loop for managing function
            $RSList = Get-AzResource                                                        # Gets all resources and assigns to $RSList
            $ListNumber = 1                                                                 # Sets $ListNumber to 1
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the list array
            foreach ($_ in $RSList) {                                                       # For each $_ in $RSListList
                $ListInput = [PSCustomObject]@{'Name'=$_.Name; `
                'RG' = $_.ResourceGroupName;'Number' = $ListNumber; `
                'Location' = $_.Location}                                                   # Creates the item to loaded into array
                $ListArray.Add($ListInput) | Out-Null                                       # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $ListNumber by 1
            }                                                                               # End foreach ($_ in $RSList)
            Write-Host "0 Exit"                                                             # Write message to screen
            foreach ($_ in $ListArray) {                                                    # For each $_ in $ListArray
                $Number = $_.Number                                                         # Sets $Number to current item .Number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number] "$_.Name                                          # Write message to screen
                }                                                                           # End if ($_.Number -le 9)
                else {                                                                      # If current item .number is more than 9
                    Write-Host "[$Number]"$_.Name                                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9))
                Write-Host 'RG: '$_.RG                                                      # Write message to screen
                Write-Host 'Loc:'$_.Location                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ListArray)
            :SelectAzureResource while ($true) {                                            # Inner loop to select the resource 
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource for"$CallingFunction         # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RSSelect = Read-Host "Enter the resource [#]"                              # Operator input for the resource selection
                if ($RSSelect -eq '0') {                                                    # If $RSSelect equals 0
                    Break GetAzureResource                                                  # Breaks :GetAzureResource
                }                                                                           # End if ($RSSelect -eq '0')
                if ($RSSelect -in $ListArray.Number) {                                      # If $RSSelect is in $ListArray
                    $RSSelect = $ListArray | Where-Object {$_.Number -eq $RSSelect}         # $RSSelect is equal to $ListArray where $ListArray.Number is equal to $RSSelect                                  
                    $RSObject = Get-AzResource -ResourceGroup $RSSelect.RG `
                        | Where-Object {$_.Name -eq $RSSelect.Name}                         # Pulls the full resource object
                    Clear-Host                                                              # Clears screen
                    Return $RSObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End if ($RSSelect -in $ListArray)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureResource while ($true)
        }                                                                                   # End :GetAzureResource while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResource
function ListAzResources {                                                                # Function to list all resources within a resource group
    Begin {                                                                                 # Begin function
        :ListAzureRGResources while ($true) {                                               # Outer loop for managing function
            if (!$RSObject) {                                                               # If $RSObject does not have a value
                $CallingFunction = 'ListAzResources'                                      # Creates $CallingFunction
                $RSObject = GetAzResource ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject does not have a value
                    Break ListAzureRGResources                                              # Breaks :ListAzureRGResources
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End if (!$RSObject) | Outer
            $RSList = Get-AzResource | Where-Object `
                {$_.ResourceGroupName -eq $RSObject.ResourceGroupName}                      # Creates a list of all resources within $RSObject
            if (!$RSList) {                                                                 # If $RSList is $null
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No resources in resource group'$RSObject.ResourceGroupName      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Break ListAzureRGResources                                                  # Breaks :ListAzureRGResources
            }                                                                               # End if (!$RSList)
            else {                                                                          # If $RSList has a value
                Write-Host ''                                                               # Write message to screen
                Write-Host `
                    'There are'$RSList.Count'resources in'$RSObject.ResourceGroupName       # Write message to screen
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
}                                                                                           # End function ListAzResources
function RemoveAzResource {                                                                 # Removes a selected resource
    Begin {                                                                                 # Begin function
        :RemoveAzureRSObject while ($true) {                                                # Outer loop for managing function
            if (!$RSObject) {                                                               # If $RSObject does not have a value
                $CallingFunction = 'RemoveAzResource'                                       # Creates $CallingFunction
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject does not have a value
                    Break RemoveAzureRSObject                                               # Breaks :GetAzureRSObject
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End if (!$RSObject) | Outer
            $RGLocks = Get-AzResourceLock -ResourceGroupName $RSObject.ResourceGroupName `
                -AtScope                                                                    # Collects all locks on $RSObject group and assigns to $RGLocks
            if ($RGLocks) {                                                                 # If $RGLocks is not empty
                Write-Host 'Locks exist on the resource group'$RSObject.ResourceGroupName   # Write message to screen
                Write-Host 'Locks muse be removed before this resource can be removed'      # Write message to screen
                Break RemoveAzureRSObject                                                   # Breaks :RemoveAzureRSObject
            }                                                                               # End if ($RGLocks)
            Write-Host "////////////////////////////WARNING\\\\\\\\\\\\\\\\\\\\\\\\\\\\"    # Write message to screen
            Write-Host ""$RSObject.Name "will be deleted, this cannot be undone"            # Write message to screen
            Write-Host " All resource locks will be removed automatically if confirmed "    # Write message to screen
            Write-Host " This option can be exited by typing 'Exit'                    "    # Write message to screen
            Write-Host "\\\\\\\\\\\\\\\\\\\\\\\\\\\\WARNING////////////////////////////"    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Delete this resource'                                               # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator input on confirming deletion of the resource
            $RSObjectName = $RSObject.Name                                                  # Collects the name of the resource group for later use
            if ($OperatorConfirm -eq 'Y') {                                                 # If $OperatorConfirm equals 'Y' 
                Write-Host "This resource has been approved for deletion"                   # Write message to screen
            }                                                                               # End if ($OperatorConfirm -eq 'Y')
            else {                                                                          # If $OperatorConfirm does not equal 'Y'
                Break RemoveAzureRSObject                                                   # Breaks :RemoveAzureRSObject
            }                                                                               # End else (if ($OperatorConfirm -eq 'Y'))
            $Locks = GetAzRSLocksAll ($RSObject)                                            # Calls function function and assigns output to $var
            if ($Locks) {                                                                   # If $Locks has a value
                Write-Host "Removing all locks"...                                          # Message write to screen
                RemoveAzResourceLocks ($Locks)                                              # Calls function RemoveAzResourceLocks
                Write-Host "Locks removed"                                                  # Message write to screen
            }                                                                               # End if ($Locks)
            Write-Host $RSObject.Name"is being removed, this may take a while"              # Message write to screen
            Try {                                                                           # Try the following
            Remove-AzResource -Name $RSObject.Name -ResourceGroup `
                $RSObject.ResourceGroupName -ResourceType $RSObject.ResourceType -Force     # Removes the resource assigned to $RSObject, -force removes confirmation
            }                                                                               # End try
            Catch {                                                                         # If try fauls 
                Write-Host `
                    $RSObjectName "was not deleted, you may not have correct permissions"   # Write message to screen
                Break RemoveAzureRSObject                                                   # Breaks :RemoveAzureRSObject
            }                                                                               # End Catch
            Write-Host 'The selected resource has been removed'                             # Write message to screen
            Break RemoveAzureRSObject                                                       # Breaks :RemoveAzureRSObject
        }                                                                                   # End :RemoveAzureRSObject while ($True)
        Start-Sleep(10)                                                                     # Pauses all actions for 10 seconds
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzResource
# Additional functions required for ManageAzResource
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
                    Clear-Host                                                              # Clears screen
                    Return $LocationObject                                                  # Returns $LocationObject to calling function
                }                                                                           # End elseif ($LocationSelect -in $ListArray.Number) 
                else {                                                                      # All other inputs for $LocationSelect
                    Write-Host "That was not a valid selection"                             # Write message to screen   
                }                                                                           # End else (if ($LocationSelect -eq '0'))
            }                                                                               # End :SelectAzureLocation while ($true)
        }                                                                                   # End :GetAzureLocation while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLocation
function GetAzRSLocksAll {                                                                  # Function to get all locks assigned to a resource
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        :GetAzureRSLocksAll while ($true) {                                                 # Outer loop for managing function
            if (!$RSObject) {                                                               # If $RSObject is $null
                $CallingFunction = 'GetAzRSLocksAll'                                        # Creates $CallingFunction
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject is $null
                    Break GetAzureRSLocksAll                                                # Breaks :GetAzureRSLocksAll
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End if (!$RSObject) | Outer
            $RSID = $RSObject.ResourceID                                                    # Isolates the resource ID
            $RSID = $RSID+'/*'                                                              # Adds a wildcard to the resource ID
            $Locks = Get-AzResourceLock | Where-Object {$_.ResourceID -like $RSID}          # Collects all locks and assigns to $Locks
            if (!$Locks) {                                                                  # If $Locks is $null
                Write-Host "No locks are on this resource "                                 # Write message to screen
                Start-Sleep(5)                                                              # Pauses all action for 5 seconds
                Break GetAzureRSLocksAll                                                    # Breaks :GetAzureRSLocksAll
            }                                                                               # End if (!$Locks)
            else {                                                                          # Else if $Locks has a value
                Return $Locks                                                               # Returns $Locks to the calling function
            }                                                                               # End else (if (!$Locks))
        }                                                                                   # End :GetAzureRSLocksAll while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzRSLocksAll
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
            }                                                                               # End if ($OperatorConfirm -eq 'Y') 
            else {                                                                          # Else if $Operatorconfirm is not equal to 'y'
                Write-Host "No changes made"                                                # Message write to screen
                $LocksRemoved = 'n'                                                         # Sets $LocksRemoved to 'n'
                Return $LocksRemoved                                                        # Returns to calling function with $LocksRemoved
            }                                                                               # End else (if ($OperatorConfirm -eq 'Y') )
        }                                                                                   # End :RemoveAzureLocks while ($true)
        Clear-Host                                                                          # Clears Screen
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function RemoveAzResourceLocks