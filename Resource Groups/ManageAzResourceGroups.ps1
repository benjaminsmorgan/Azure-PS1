# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    New-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcegroup?view=azps-5.1.0
    Remove-AzResourceGroup:     https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
    Get-AzResourceProvider:     https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourceprovider?view=azps-5.2.0
    Get-AzTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azTag?view=azps-5.2.0
    Remove-AzResource:          https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresource?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    ManageAzResourceGroup:      TBD
        NewAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/NewAzResourceGroup.ps1 
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
        ListAzRGResources:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/ListAzRGResources.ps1
        RemoveAzResourceGroup:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/RemoveAzResourceGroup.ps1
        GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
        GetAzRGLocksAll:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzRGLocksAll.ps1
        RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLocks.ps1
    SearchAzResourceGroup:      TBD
        SearchAzResourceGroupName:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/SearchAzResourceGroupName.ps1
        SearchAzResourceGroupType:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/SearchAzResourceGroupType.ps1
        SearchAzResourceGroupLoc:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/SearchAzResourceGroupLoc.ps1
        SearchAzResourceGroupTag:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/SearchAzResourceGroupTag.ps1
        GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/GetAzResource.ps1
        SearchAzResourceTag:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/SearchAzResourceTag.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
        GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
        SearchAzResourceType:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/SearchAzResourceType.ps1
    ManageAzResource:           TBD
        GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/GetAzResource.ps1
        ListAzResources:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/ListAzResources.ps1
        RemoveAzResource:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/RemoveAzResource.ps1
        GetAzRSLocksAll:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzRSLocksAll.ps1
        RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLocks.ps1
    SearchAzResource:           TBD
    ManageAzLocks:              TBD
    ManageAZTags:               TBD
} #>
<# Functions Description: {
    ManageAzResourceGroup:      Manages a resource group 
        NewAzResourceGroup:         Creates a resource group object
        GetAzResourceGroup:         Gets resource group from full name match
        ListAzRGResources:          Lists all resources within a resource group    
        RemoveAzResourceGroup:      Removes a resource group object
    SearchAzResourceGroup:      Management function for all SearchAzResourceGroup functions
        SearchAzResourceGroupName:  Searchs for resource group using partial name matches on the group name, or a contained resource name
        SearchAzResourceGroupType:  Searchs for resource group resource provider or type on a resource or resource group
        SearchAzResourceGroupLoc:   Searchs for resource group using location matches on the group, or a contained resource
        SearchAzResourceGroupTag:   Searchs for resource group using tag matches on the group, or a contained resource
    ManageAzResource:           Manages a resource 
        GetAzResource:              Gets resource
        ListAzResources:            Lists all resources within a resource group    
        RemoveAzResource:           Removes a resource object
    SearchAzResource:           Management function for all SearchAzResource functions
    ManageAzLocks:              Management function for all lock functions
        GetAzRGLocksAll:            Gets a list of locks on $RGObject
        GetAzRSLocksAll:            Gets a list of locks on $RSObject
        RemoveAzResourceLocks:      Removes all items in $Locks
    ManageAZTags:               Management function for all tags
    GetAzLocation:              Gets a list of azure locations
} #>
<# Variables: {
    :ManageAzureRG              Outer loop for managing function
    $RGObject:                  Resource group object
    $RSObject:                  Resource object
    $ManageAzRG:                Operator input for search option
    ManagageAzResourceGroup{}   Manages $RGObject
        NewAzResourceGroup{}            Creates $RGObject
            GetAzLocation{}                 Gets $LocationObject
        GetAzResourceGroup{}            Gets $RGObject
        ListAzRGResources{}             Lists $RSObjects
            GetAzResourceGroup{}            Gets $RGObject
        RemoveAzResourceGroup{}         Removes $RGObject
            GetAzResourceGroup{}            Gets $RGObject
            GetAzRGLocksAll{}               Gets $Locks
            RemoveAzResourceLocks{}         Gets $LocksRemoved
    SearchAzResourceGroup{}     Gets $RGObject
        SearchAzResourceGroupName{} Gets $RGObject
            GetAzResource{}             Gets $RSObject
            GetAzResourceGroup{}        Gets $RGObject
        SearchAzResourceGroupType{} Gets $RGObject
            SearchAzResourceType{}      Gets $RSObject
        SearchAzResourceGroupLoc{}  Gets $RGObject
            GetAzLocation{}             Gets $LocationObject
        SearchAzResourceGroupTag{}  Gets $RGObject
            SearchAzResourceTag{}       Gets $RSObject
    ManageAzResource{}          Manages $RSObject
        GetAzResource{}            Gets $RSObject
        ListAzResources{}             Lists $RSObjects
        RemoveAzResource{}         Removes $RSObject
            GetAzResource{}            Gets $RSObject
            GetAzRGLocksAll{}               Gets $Locks
            RemoveAzResourceLocks{}         Gets $LocksRemoved
    SearchAzResource{}          Gets $RSObject
} #>
<# Process Flow {
    Function
        Call ManageAzResourceGroups > Get $null
            Call ManageAzResourceGroup > Get $RGObject
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
                    Return ManageAzResourceGroups > Send $RGObject 
            Call SearchAzResourceGroup > Get $RGObject
                Call SearchAzResourceGroupName > Get $RGObject
                    Call GetAzResource > Get $RSObject
                    End GetAzResource
                        Return SearchAzResourceGroupName > Send $RSObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup    
                        Return SearchAzResourceGroupName > Send $RGObject
                End SearchAzResourceGroupName
                    Return SearchAzResourceGroup > Send $RGObject
                Call SearchAzResourceGroupType > Get $RGObject
                    Call SearchAzResourceType > Get $RSObject
                    End SearchAzResourceType
                        Return SearchAzResourceGroupType > Send $RSObject
                End SearchAzResourceGroupType
                    Return SearchAzResourceGroup > Send $RGObject
                Call SearchAzResourceGroupLoc  > Get $RGObject
                    Call GetAzLocation > Get $LocationObject
                    End GetAzLocation
                        Return SearchAzResourceGroupLoc > Send $LocationObject
                End SearchAzResourceGroupLoc
                    Return SearchAzResourceGroup > Send $RGObject
                Call SearchAzResourceGroupLoc > Get $RGObject
                    Call SearchAzResourceTag  > Get $RSObject
                    End SearchAzResourceTag
                        Return SearchAzResourceGroupLoc > Send $RSObject
                End SearchAzResourceGroupLoc
                    Return SearchAzResourceGroup > Send $RGObject
            End SearchAzResourceGroup
                Return ManageAzResourceGroups > Send $RGObject    
            Call ManageAzResource
                Call GetAzResource > Get $RSObject
                End GetAzResource
                    Return ManageAzResource > Send $RSObject
                Call ListAzResources > Get $null
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
                    Return ManageAzResourceGroups > Send $RSObject  
        End ManageAzResourceGroups
            Return function > Send $null
}#> 
function ManageAzResourceGroups {                                                           # Function to manage resource groups
    Begin {                                                                                 # Begin function
        :ManageAzureRG while($true) {                                                       # Outer loop for managing function
            if ($RGObject) {                                                                # If $RGObject has a value
                Write-Host 'The currently selected resource group is:' `
                    $RGObject.ResourceGroupName                                             # Write message to screen
            }                                                                               # End if ($RGObject)
            if ($RSObject) {                                                                # If $RSObject has a value
                Write-Host 'The currently selected resource is:' $RSObject.Name             # Write message to screen
            }                                                                               # End if ($RSObject)
            Write-Host "Resource Group Management"                                          # Write message to screen
            Write-Host "[0] Clear Objects"                                                  # Write message to screen
            Write-Host "[1] Manage Resource Group"                                          # Write message to screen
            Write-Host "[2] Search For Resource Group"                                      # Write message to screen
            Write-Host "[3] Manage Resource"                                                # Write message to screen 
            Write-Host "[4] Search For Resource"                                            # Write message to screen
            Write-Host "[5] Manage Locks"                                                   # Write message to screen
            Write-Host "[6] Manage Tags"                                                    # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzRG = Read-Host 'Enter [#] option?'                                     # Operator input for selecting management function
            if ($ManageAzRG -eq 'exit') {                                                   # If $ManageAzRG equals 'exit'
                Break ManageAzureRG                                                         # Breaks :ManageAzureRG
            }                                                                               # End if ($ManageAzRG -eq 'exit')
            elseif ($ManageAzRG -eq '1') {                                                  # else if $ManageAzRG equals '1'
                Clear-Host                                                                  # Clear the screen
                Write-Host "Manage Resource Group"                                          # Write message to screen
                $RGObject = ManageAzResourceGroup ($RGObject)                               # Calls function and assigns ouput to $var
            }                                                                               # End elseif ($ManageAzRG -eq '1')
            elseif ($ManageAzRG -eq '2') {                                                  # else if $ManageAzRG equals '2'
                Clear-Host                                                                  # Clear the screen
                Write-Host "Search For Resource Group"                                      # Write message to screen
                $RGObject = SearchAzResourceGroup                                           # Calls function and assigns ouput to $var
            }                                                                               # End elseif ($ManageAzRG -eq '2')
            elseif ($ManageAzRG -eq '3') {                                                  # else if $ManageAzRG equals '3'
                Clear-Host                                                                  # Clear the screen
                Write-Host "Manage Resource"                                                # Write message to screen
                $RSObject = ManageAzResource ($RGObject, $RSObject)                         # Calls function and assigns ouput to $var
            }                                                                               # End elseif ($ManageAzRG -eq '3')
            elseif ($ManageAzRG -eq '4') {                                                  # else if $ManageAzRG equals '4'
                Write-Host "Search For Resource"                                            # Write message to screen
                $RSObject = SearchAzResource                                                # Calls function and assigns ouput to $var
            }                                                                               # End elseif ($ManageAzRG -eq '4')
            elseif ($ManageAzRG -eq '5') {                                                  # else if $ManageAzRG equals '5'
                Write-Host 'Manage Locks'                                                   # Write message to screen
                ManageAzResourceGroupLocks ($RGObject, $RSObject)                           # Calls function 
            }                                                                               # End elseif ($ManageAzRG -eq '5')
            elseif ($ManageAzRG -eq '6') {                                                  # else if $ManageAzRG equals '6'
                Write-Host 'Manage Tags'                                                    # Write message to screen
                ManageAzResourceGroupTags ($RGObject, $RSObject)                            # Calls function 
            }                                                                               # End elseif ($ManageAzRG -eq '6')
            elseif ($ManageAzRG -eq '0') {                                                  # else if $ManageAzRG equals '0'
                if ($RGObject) {                                                            # If $RGObject has a value
                    $RGObject = $null                                                       # Clears $RGObject
                    Write-Host '$RGObject has been cleared'                                 # Write message to screen
                }                                                                           # End if ($RGObject)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host '$RGObject was already clear'                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
                if ($RSObject) {                                                            # If $RSObject has a value
                    $RSObject = $null                                                       # Clears $RSObject
                    Write-Host '$RSObject has been cleared'                                 # Write message to screen
                }                                                                           # End if ($RSObject)
                else {                                                                      # If $RSObject does not have a value
                    Write-Host '$RSObject was already clear'                                # Write message to screen
                }                                                                           # End else (if ($RSObject))
            }                                                                               # End elseif ($ManageAzRG -eq '0')
            else {                                                                          # All other inputs for ManageAzRG
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzRG -eq 'exit'))
        }                                                                                   # End :ManageAzResourceGroup while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $RGObject, $RSOBject                                                         # Returns $vars to calling function
    }                                                                                       # End begin statement
}                                                                                           # End function ManageAzResourceGroups
# Functions for ManageAzResourceGroup
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
        Clear-Host                                                                          # Clears screen
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
                if ($RGObjectInput -eq 'exit') {                                            # If $RGObjectInput equals 'exit'
                    Break NewAzureRGObject                                                  # Breaks :NewAzrueRGObject
                }                                                                           # End elseif ($RGObjectInput -eq 'exit') 
                Write-Host 'The new resource group will be called' $RGObjectInput           # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation that the name is correct
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureName                                                      # Break :SetAzureName
                }                                                                           # End if ($OperatorConfirm -eq 'y')   
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
                    Write-Host 'Building the resource group with the following settings:'   # Write message to screen
                    Write-Host 'Name:'$RGObjectInput                                        # Write message to screen
                    Write-Host 'Loc: '$LocationObject.Location                              # Write message to screen
                    Write-Host 'Tags:'$TagNameInput $TagValueInput                          # Write message to screen
                    $RGObject = New-AzResourceGroup -Name $RGObjectInput -Location `
                        $LocationObject.Location -Tag $Tag -ErrorAction 'Stop'              # Creates the resouce group and assigns to $RGObject
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions required'                  # Write message to screen
                    Write-Host 'Policy may exist preventing this action'                    # Write message to screen
                    Start-Sleep(10)                                                         # Pauses all actions for 10 seconds
                    Break NewAzureRGObject                                                  # Breaks :NewAzureRGObject  
                }                                                                           # End catch
                Clear-Host                                                                  # Clears Screen
                Return $RGObject                                                            # Returns to calling function with $RGObject
            }                                                                               # End if ($Tag)
            else {                                                                          # If $Tag does not have a value
                Try {                                                                       # Try the following
                    Write-Host 'Building the resource group with the following settings:'   # Write message to screen
                    Write-Host 'Name:'$RGObjectInput                                        # Write message to screen
                    Write-Host 'Loc: '$LocationObject.Location                              # Write message to screen
                    $RGObject = New-AzResourceGroup -Name $RGObjectInput -Location `
                        $LocationObject.Location -Tag $Tag -ErrorAction 'Stop'              # Creates the resouce group and assigns to $RGObject
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions required'                  # Write message to screen
                    Write-Host 'Policy may exist preventing this action'                    # Write message to screen
                    Start-Sleep(10)                                                         # Pauses all actions for 10 seconds
                    Break NewAzureRGObject                                                  # Breaks :NewAzureRGObject  
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Return $RGObject                                                            # Returns to calling function with $RGObject
            }                                                                               # End else (if ($Tag))
        }                                                                                   # End :NewAzureRGObject while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End of begin statement
}                                                                                           # End function NewAzResourceGroup
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
            Clear-Host                                                                      # Clears screen
            Write-Host "////////////////////////////WARNING\\\\\\\\\\\\\\\\\\\\\\\\\\\\"    # Write message to screen
            Write-Host `
                ""$RGObject.ResourceGroupName "will be deleted, this cannot be undone"      # Write message to screen
            Write-Host " All resource locks will be removed automatically if confirmed "    # Write message to screen
            Write-Host " All resources within the resource group will also be deleted  "    # Write message to screen
            Write-Host "\\\\\\\\\\\\\\\\\\\\\\\\\\\\WARNING////////////////////////////"    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Delete this resource group'                                         # Write message to screen
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
                    -ErrorAction 'Stop' | Out-Null                                          # Removes the resource group
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
        Start-Sleep(5)                                                                      # Pauses actions for 5 seconds
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function RemoveAzResourceGroup
# End ManageAzResourceGroup
# Functions for SearchAzResourceGroup
function SearchAzResourceGroup {                                                            # Function to manage search for resource group functions
    Begin {                                                                                 # Begin function
        :SearchAzureRG while($true) {                                                       # Outer loop for managing function
            Write-Host "Azure Resource Group Search"                                        # Write message to screen
            Write-Host "[1] Search by name lookup"                                          # Write message to screen
            Write-Host "[2] Search by contained resource type"                              # Write message to screen
            Write-Host "[3] Search by resource group location"                              # Write message to screen
            Write-Host "[4] Search by tags"                                                 # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $SearchAzRG = Read-Host "Option?"                                               # Operator input on $SearchAzRG option
            if ($SearchAzRG -eq 'exit') {                                                   # If $SearchAzRG equals 'exit'
                Break SearchAzureRG                                                         # Breaks :SearchAzureRG
            }                                                                               # End if ($SearchAzRG -eq 'exit')
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
            }                                                                               # End else (if($SearchAzRG -eq 'exit'))
            if ($RGObject) {                                                                # If $RGObject has a value
                Return $RGObject                                                            # Returns to calling function with $RGObject
            }                                                                               # End if ($RGObject)
            else {                                                                          # If $RGObject does not have a value
                Write-Host 'No resource group selected'                                     # Write message to screen
            }                                                                               # End else (if ($RGObject))
        }                                                                                   # End :SearchAzureRG while($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function SearchAzResourceGroup
function SearchAzResourceGroupName {                                                        # Function to search for resource group by name
    Begin {                                                                                 # Begin function
        :SearchAzureRGByName while($true) {                                                 # Outer loop for managing function
            $CallingFunction = 'SearchAzResourceGroupName'                                  # Creates $CallingFunction
            Write-Host "Resource Group Search By Name"                                      # Write message to screen
            Write-Host "[1] Search by resource name"                                        # Write message to screen
            Write-Host "[2] Search by group name"                                           # Write message to screen
            $OperatorSearchOption = Read-Host "Option?"                                     # Operator input for search method
            if ($OperatorSearchOption -eq 'exit') {                                         # If $OperatorSearchOption equals 'exit'
                Break SearchAzureRGByName                                                   # Breaks :SearchAzureRGByName
            }                                                                               # End if ($OperatorSearchOption -eq 'exit')
            elseif ($OperatorSearchOption -eq '1') {                                        # Else if $OperatorSearchOption equals '1' 
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject does not have a value
                    Break SearchAzureRGByName                                               # Breaks :SearchAzureRGByName
                }                                                                           # End if (!$RSObject)
                $RGObject = Get-AzResourceGroup | Where-Object `
                    {$_.ResourceGroupName -eq $RSObject.ResourceGroupName}                  # Pulls the resource group object holding $RSObject
                Return $RGObject                                                            # Returns $RGObject to calling function
            }                                                                               # End elseif ($OperatorSearchOption -eq '1')
            elseif ($OperatorSearchOption -eq '2') {                                        # Else if $OperatorSearchOption equals '2' 
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject does not have a value
                    Break SearchAzureRGByName                                               # Breaks :SearchAzureRGByName
                }                                                                           # End if (!$RGObject)        
                Return $RGObject                                                            # Returns $RGObject to calling function 
            }                                                                               # End elseif ($OperatorSearchOption -eq '2')
            else {                                                                          # All other inputs for $OperatorSearchOption
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # if ($OperatorSearchOption -eq 'exit')
        }                                                                                   # End :SearchAzureRGByName while($true)
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
            $OperatorSelect = Read-Host 'Enter option [#]'                                  # Operator input for the search option
            if ($OperatorSelect -eq '0') {                                                  # If $OperatorSelect equals '0'
                Break SearchAzureByLoc                                                      # End Break SearchAzureByLoc
            }                                                                               # End if ($OperatorSelect -eq '0')
            elseif ($OperatorSelect -eq '1') {                                              # Else if $OperatorSelect equals '1'
                $RSList = Get-AzResource | Where-Object `
                    {$_.Location -eq $LocationObject.Location}                              # Gets a list of all resources within the $LocationObject.Location
                if (!$RSList) {                                                             # If $RSList is $null
                    Write-Host 'No resource found'                                          # Write message to screen
                    Break SearchAzureByLoc                                                  # End Break SearchAzureByLoc
                }                                                                           # End if (!$RSList)
                elseif ($RSList.Count -gt 1) {                                              # If $RSList.Count greater than 1
                    $ListNumber = 1                                                         # Sets $ListNumber to 1
                    [System.Collections.ArrayList]$ListArray = @()                          # Creates the $ListArray
                    foreach ($_ in $RSList) {                                               # For each $_ in $RSList
                        $ListInput = [PSCustomObject]@{'Name' = $_.Name; `
                            'Number'=$ListNumber;'RG'=$_.ResourceGroupName}                 # Creates the item to loaded into array
                        $ListArray.Add($ListInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                    }                                                                       # End foreach ($_ in $ProviderList)
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    foreach ($_ in $ListArray) {                                            # For each item in $ListArray
                        $Number = $_.number                                                 # $Number equals current item .Number
                        Write-Host "[$Number]" $_.Name $_.RG                                # Write message to screen
                    }                                                                       # End foreach ($_ in $ListArray)
                    :SelectAzureResource while ($true) {                                    # Inner loop for selecting a resource from list
                        $OperatorSelect = Read-Host 'Enter the resource [#]'                # Operator input to select the resource
                        if ($OperatorSelect -eq '0') {                                      # If $OperatorSelect equals '0'
                        Break SearchAzureByLoc                                              # End Break SearchAzureByLoc
                        }                                                                   # End if ($OperatorSelect -eq '0')
                        elseif ($OperatorSelect -in $ListArray.Number) {                    # Else if $OperatorSelect -in $ListArray.Number
                            $RGObject = $ListArray | Where-Object `
                                {$_.Number -eq $OperatorSelect}                             # $RGObject equals $ListArray where $OperatorSelect equals $ListArray.Number
                            $RGObject = Get-AzResourceGroup -name $RGObject.RG              # Pulls the full resource group object
                            Return $RGObject                                                # Returns to calling function with $RGObject
                        }                                                                   # End elseif ($OperatorSelect -in $ListArray.Number)
                        else {                                                              # All other inputs for $OperatorSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OperatorSelect -eq '0'))
                    }                                                                       # End :SelectAzureResource while ($true) 
                }                                                                           # End elseif ($RSList.Count -gt 1)
                else {                                                                      # If $RSList has only a single item
                    $RGObject = Get-AzResourceGroup -name $RSList.ResourceGroupName         # Pulls the full resource group object
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End else (if (!$RSList))
            }                                                                               # End elseif ($OperatorSelect -eq '1')
            elseif ($OperatorSelect -eq '2') {                                              # Else if $OperatorSelect equals '2'
                $RGList = Get-AzResourceGroup | Where-Object `
                    {$_.Location -eq $LocationObject.Location}                              # Gets a list of all resources within the $LocationObject.Location
                if (!$RGList) {                                                             # If $RGList is $null
                    Write-Host 'No resource groups found'                                   # Write message to screen
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
                            Return $RGObject                                                # Returns to calling function with $RGObject
                        }                                                                   # End elseif ($OperatorSelect -in $ListArray.Number)
                        else {                                                              # All other inputs for $OperatorSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OperatorSelect -eq '0'))
                    }                                                                       # End :SelectAzureRG while ($true) 
                }                                                                           # End elseif ($RGList.Count -gt 1)
                else {                                                                      # If $RGList has only a single item
                    $RGObject = Get-AzResourceGroup -name $RGList.Name                      # Pulls the full resource group object
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End else (if (!$RGList))
            }                                                                               # End elseif ($OperatorSelect -eq '2')
            else {                                                                          # All other inputs for $OperatorSelect 
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSelect -eq '0'))
        }                                                                                   # End :SearchAzureByLoc while ($true) 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End SearchAzResourceGroupLoc
function SearchAzResourceGroupTag {                                                         # Function to find a resource group from container tag 
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        :SearchAzureRGByTag while($true) {                                                  # :SearchAzureRGByTag loop finds a resource group off tag values
            $CallingFunction = 'SearchAzResourceGroupTag'                                   # Creates $CallingFunction
            Write-Host "Resource Group Search By Tag"                                       # Write message to screen
            Write-Host "[1] Search by resource tag"                                         # Write message to screen
            Write-Host "[2] Search by group tag"                                            # Write message to screen
            $OperatorSearchOption = Read-Host "Option?"                                     # Operator input for $OperatorSearchOption
            if ($OperatorSearchOption -eq 'exit') {                                         # If $OperatorSearchOption equals 'exit'
                Break SearchAzureRGByTag                                                    # Breaks :SearchAzureRGByTag 
            }                                                                               # End if ($OperatorSearchOption -eq 'exit')
            elseif ($OperatorSearchOption -eq '1') {                                        # Else if $OperatorSearchOption equals '1'
                $RSObject = SearchAzResourceTag ($CallingFunction)                          # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject does not have a value
                    Break SearchAzureRGByTag                                                # Breaks :SearchAzureRGByTag
                }                                                                           # if (!$RSObject)
                else {
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $RSObject.ResourceGroupName}              # Pulls the resource group object holding $RSObject
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
                            $TagName = $TagName.Name                                        # Isolates .Name in $TagName
                            Break SelectTagName                                             # Breaks :SelectTagName
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
                        Break SearchAzureRGByTag                                            # Breaks :SearchAzureRGByTag 
                    }                                                                       # End if (!$RGObject)
                }                                                                           # End if ($TagValue)
                else {                                                                      # Else statement for $TagValueInput not having a value
                    $RGObject = Get-AzResourceGroup -Tag @{$TagName=''}                     # Collects all resource groups where tag name matches $TagName
                    if (!$RGObject) {                                                       # $RGObject does not have a value
                        Write-Host "No resource group found for the Tag name"$TagName       # Write message to screen
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
                            Break SearchAzureRGByTag                                          # Breaks :SearchAzureRGByTag
                        }                                                                   # End if ($RGSelect -eq '0')
                        elseif ($RGSelect -in $ObjectArray.Number) {                        # If $RGSelect is in $ObjectArray
                            $RGSelect = $ObjectArray | Where-Object `
                                {$_.Number -eq $RGSelect}                                   # $RGSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $RGSelect                                  
                            $RGObject = Get-AzResourceGroup -name $RGSelect.RG `
                                | Where-Object {$_.Name -eq $RGSelect.Name}                 # Pulls the full resource object
                            Return $RGObject                                                # Returns $RGObject to calling function
                        }                                                                   # End if ($RGSelect -in $ObjectArray)
                        else {                                                              # If $RGObject does not have a value
                            Write-Host "That was not a valid option"                        # Write message to screen
                        }                                                                   # End else (if ($RGSelect -eq '0')))
                    }                                                                       # End :SelectAzureResourceGroup while ($true)
                }                                                                           # End if ($RGObject.count -eq 1) 
                else {                                                                      # If $RGObject has a single value
                    Write-Host 'A single matching resource group is named:'$RGObject.Name   # Write message to screen
                    Return $RGObject                                                        # Returns $RGObject to calling function       
                }                                                                           # End else (if ($RGObject.count -eq 1))
            }                                                                               # End elseif ($OperatorSearchOption -eq '2')
            else {                                                                          # All other inputs for $OperatorSearchOption
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSearchOption -eq 'exit'))
        }                                                                                   # End :SearchAzureRGByTag while($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SearchAzResourceGroupTag
# End SearchAzResourceGroup
# Functions for ManageAzResource
function ManageAzResource {                                                                 # Function to manage resource
    Begin {                                                                                 # Begin function
        :ManageAzureSG while($true) {                                                       # Outer loop for managing function
            if ($RSObject) {                                                                # If $RSObject has a value
                Write-Host 'The currently selected resource is:'$RSObject.Name              # Write message to screen
            }                                                                               # End if ($RSObject)
            Write-Host "Manage A Resource"                                                  # Write message to screen
            Write-Host '[0] Clear Objects'                                                  # Write message to screen
            Write-Host '[1] Get Resource'                                                   # Write message to screen
            Write-Host '[2] List Resources by Group'                                        # Write message to screen
            Write-Host '[3] Remove Resource'                                                # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $ManageAzRS = Read-Host 'Enter [#] option?'                                     # Operator input for selecting management function
            if ($ManageAzRS -eq 'exit') {                                                   # If $ManageAzRS equals 'exit'
                Break ManageAzureSG                                                         # Breaks :ManageAzureSG
            }                                                                               # End if ($ManageAzRS -eq 'exit')                                                                      # End elseif ($ManageAzRS -eq '1')
            elseif ($ManageAzRS -eq '1') {                                                  # else if $ManageAzRS equals '1'
                Write-Host "Get Resource "                                                  # Write message to screen
                $RSObject = GetAzResource                                                   # Calls function and assigns ouput to $var
            }                                                                               # End elseif ($ManageAzRS -eq '1')
            elseif ($ManageAzRS -eq '2') {                                                  # else if $ManageAzRS equals '2'
                Write-Host "List Resources By Group"                                        # Write message to screen
                ListAzResources ($RSObject)                                                 # Calls function
            }                                                                               # End elseif ($ManageAzRS -eq '2')
            elseif ($ManageAzRS -eq '3') {                                                  # else if $ManageAzRS equals '3'
                Write-Host "Remove Resource"                                                # Write message to screen
                RemoveAzResource ($RSObject)                                                # Calls function 
            }                                                                               # End elseif ($ManageAzRS -eq '3')
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
function ListAzResources {                                                                  # Function to list all resources within a resource group
    Begin {                                                                                 # Begin function
        :ListAzureResources while ($true) {                                                 # Outer loop for managing function
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the list array
            $RGList = Get-AzResourceGroup                                                   # Gets a list of all resource groups
            foreach ($_ in $RGList) {                                                       # For each item in $RGList
                $RGObject = $_                                                              # Isolates the current item
                $RGName = $RGObject.ResourceGroupName                                       # Isolates the resource group name
                $ListObject = Get-AzResource | Where-Object `
                    {$_.ResourceGroupName -eq $RGName}                                      # Creates a list of all resources within $RGObject
                foreach ($_ in $ListObject) {                                               # For each $_ in $ListObject
                    $ListInput = [PSCustomObject]@{'Name'=$_.Name;'RG' = $RGName;`
                        'Location'=$_.Location;'Type'=$_.ResourceType}                      # Creates the item to loaded into array
                    $ListArray.Add($ListInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                }                                                                           # End foreach ($_ in $ListObject)    
            }                                                                               # End foreach ($_ in $RGList)
            foreach ($_ in $ListArray) {                                                    # For each item in $ListArray
                Write-Host 'Name:'$_.Name                                                   # Write message to screen
                Write-Host 'RG:  '$_.RG                                                     # Write message to screen
                Write-Host 'Loc: '$_.Location                                               # Write message to screen
                Write-Host 'Type:'$_.Type                                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ListArray)
            Break ListAzureResources                                                        # Breaks :ListAzureResources
        }                                                                                   # End :ListAzureResources while ($true)
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
            if ($OperatorConfirm -eq 'Y') {                                                 # If $OperatorConfirm equals 'Y' 
                Write-Host "This resource has been approved for deletion"                   # Write message to screen
            }                                                                               # End if ($OperatorConfirm -eq 'Y')
            else {                                                                          # If $OperatorConfirm does not equal 'Y'
                Break RemoveAzureRSObject                                                   # Breaks :RemoveAzureRSObject
            }                                                                               # End else (if ($OperatorConfirm -eq 'Y'))
            $Locks = GetAzRSLocksAll ($RSObject)                                            # Calls function function and assigns output to $var
            if ($Locks) {                                                                   # If $Locks has a value
                Write-Host "Removing all locks"...                                          # Message write to screen
                $LocksRemoved = RemoveAzResourceLocks ($Locks)                              # Calls function RemoveAzResourceLocks
                if ($LocksRemoved -eq 'n') {                                                # If $LocksRemoved equals 'n' 
                    Write-Host 'Locks must be removed before'                               # Write message to screen
                    Write-Host 'this resource can be removed'                               # Write message to screen
                    Break RemoveAzureRSObject                                               # End Break RemoveAzureRSObject   
                }                                                                           # End if ($LocksRemoved -eq 'n') 
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
# End ManageAzResource
function SearchAzResource {                                                                 # Function to manage search resource functions
    Begin {                                                                                 # Begin function
        :SearchAzureRS while($true) {                                                       # Outer loop for managing function 
            Write-Host 'Azure Resource Search'                                              # Write message to screen
            Write-Host '[1] Search by resource type'                                        # Write message to screen
            Write-Host '[2] Search by resource location'                                    # Write message to screen
            Write-Host '[3] Search by tags'                                                 # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $OpSelect = Read-Host 'Enter option [#]'                                        # Operator input to select the search function
            if ($OpSelect -eq 'exit') {                                                     # If $OpSelect equals 'exit' 
                Break SearchAzureRS                                                         # Breaks :SearchAzureRS 
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Search by type'                                                 # Write message to screen
                $RSObject = SearchAzResourceType                                            # Calls function to assign output to $var
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'Search by location'                                             # Write message to screen
                $RSObject = SearchAzResourceLoc                                             # Calls function to assign output to $var
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Search by tag'                                                  # Write message to screen
                $RSObject = SearchAzResourceTag                                             # Calls function to assign output to $var
            }                                                                               # End elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
            if ($RSObject) {                                                                # If $RSObject has a value
                Clear-Host                                                                  # Clears the screen
                Return $RSObject                                                            # Returns to calling function with $var
            }                                                                               # End if ($RSObject)
        }                                                                                   # End :SearchAzureRS while($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SearchAzResource 
function SearchAzResourceType {                                                             # Function to search for resource group by resource provider or type
    Begin {                                                                                 # Begin function
        $ProviderList = Get-AzResourceProvider | select-object ProviderNamespace            # Collects all current Azure resource provider names
        :SearchAzureRSByType while($True) {                                                 # Outer loop for manaing function
            $ListNumber = 1                                                                 # Sets $ListNumber to '1'
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the $ListArray
            foreach ($_ in $ProviderList) {                                                 # For each $_ in $ProviderList
                $ListInput = [PSCustomObject]@{'Name' = $_.ProviderNamespace; `
                    'Number' = $ListNumber}                                                 # Creates the item to loaded into array
                $ListArray.Add($ListInput) | Out-Null                                       # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $ListNumber by 1
            }                                                                               # End foreach ($_ in $ProviderList)
            Write-Host 'Resource Group Search By Resource Type'                             # Write message to screen
            Write-Host '[Exit] this function'                                               # Write message to screen
            Write-Host '[1] Search by provider type'                                        # Write message to screen
            Write-Host '[2] Search by resource type'                                        # Write message to screen
            $OpSelect = Read-Host 'Search option [#]'                                       # Operator input for $OpSelect
            if ($OpSelect -eq 'exit') {                                                     # If $OpSelect equals 'exit'
                Break SearchAzureRSByType                                                   # Breaks :SearchAzureRSByType
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                :SearchAzureRSProvider while($True) {                                       # Inner loop to find a resource off  provider
                    $RPObject = $null                                                       # Clears $RPObject
                    $RSObject = $null                                                       # Clears $RSObject
                    Write-Host '[0]  Exit'                                                  # Write message to screen
                    foreach ($_ in $ListArray) {                                            # For each item in $ListArray
                        $Number = $_.Number                                                 # $Number is equal to current item .Number
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number] " $_.Name                                 # Write message to screen
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $Number is 10 or more
                            Write-Host "[$Number]" $_.Name                                  # Write message to screen
                        }                                                                   # End else (if ($Number -le 9))
                    }                                                                       # End foreach ($_ in $ListArray)
                    :SelectAzureRSProvider while ($True) {                                  # Inner loop for selecting a resource provider name
                        $RPObjectInput = Read-Host "Resource provider"                      # Operator input for $RPObjectInput
                        if ($RPObjectInput -eq '0') {                                       # If $RPObjectInput equals '0'
                            Break SearchAzureRSProvider                                     # Breaks :SearchAzureRSProvider 
                        }                                                                   # End if ($RPObjectInput -eq '0')
                        elseif ($RPObjectInput -in $ListArray.Number) {                     # If $RPObjectInput in $ListArray.Number
                            $RPObject = $ListArray | Where-Object `
                                {$_.Number -eq $RPObjectInput}                              # $RPObjectInput is equal to $ListArray where $RPObjectInput equals $ListArray.number 
                            $RPObject = $RPObject.Name                                      # Isolates the resource provider name
                            $RPObject = $RPObject+"/*"                                      # Adds a wild card to the resource search 
                            Break SelectAzureRSProvider                                     # Breaks :SelectAzureRSProvider 
                        }                                                                   # End elseif ($RPObjectInput -in $ListArray.Number)
                        else {                                                              # All other inputs for $RPObjectInput
                            Write-Host 'That was not a valid input'                         # Write message to screen
                        }                                                                   # End else (if ($RPObjectInput -eq '0'))
                    }                                                                       # End :SelectAzureRSProvider while ($True)
                    $RSObject = Get-AzResource | Where-Object `
                        {$_.ResourceType -like $RPObject}                                   # Collects all resource with a resource provider matching $RPObject
                    if (!$RSObject) {                                                       # If $RSObject does not have a value
                        Write-Host `
                            'No resources found with the selected provider type'$RPObject   # Write message to screen
                        Break SearchAzureRSProvider                                         # Breaks :SearchAzureRSProvider
                    }                                                                       # End if (!$RSObject)
                    if ($RSObject.count -gt 1) {                                            # If $RSObject count is greater than 1
                        $ListArray = $null                                                  # Clears $ListArray
                        [System.Collections.ArrayList]$ListArray = @()                      # Recreates the $ListArray
                        $ListNumber = 1                                                     # Sets $ListNumber to '1'
                        foreach ($_ in $RSObject) {                                         # For each $_ in $ProviderList
                            $ListInput = [PSCustomObject]@{'Name'=$_.Name; `
                                'Number' = $ListNumber;'RG'=$_.ResourceGroupName}           # Creates the item to loaded into array
                            $ListArray.Add($ListInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                            $ListNumber = $ListNumber + 1                                   # Increments $ListNumber by 1
                        }                                                                   # End foreach ($_ in $RSObject)
                        :SelectAzureRSObject while ($True) {                                # Inner loop for selecting a resource from a list
                            Write-Host '[0] Exit'                                           # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            foreach ($_ in $ListArray) {                                    # For each item in $ListArray
                                $Number = $_.Number                                         # $Number is equal to current item .Number
                                if ($Number -le 9) {                                        # If $Number is 9 or less
                                    Write-Host "[$Number] " $_.Name                         # Write message to screen
                                    Write-Host 'RG: '$_.RG                                  # Write message to screen
                                    Write-Host ''                                           # Write message to screen
                                }                                                           # End if ($Number -le 9)
                                else {                                                      # If $Number is 10 or more
                                    Write-Host "[$Number]" $_.Name                          # Write message to screen
                                    Write-Host 'RG: '$_.RG                                  # Write message to screen
                                    Write-Host ''                                           # Write message to screen
                                }                                                           # End else (if ($Number -le 9))
                            }                                                               # End foreach ($_ in $ListArray)
                            $RSObjectInput = Read-Host 'Enter the [#] of the resource'      # Operator input to select the resource
                            if ($RSObjectInput -eq '0') {                                   # If $RSObjectInput equals '0'
                                Break SearchAzureRSProvider                                 # Breaks :SearchAzureRSProvider
                            }                                                               # End if ($RSObjectInput -eq '0')
                            elseif ($RSObjectInput -in $ListArray.Number) {                 # IF $RSObjectInput in $ListArray.Number
                                $RSObject = $ListArray | Where-Object `
                                    {$_.Number -eq $RSObjectInput}                          # $RSObject equals $ListArray where $RSObjectInput equals $ListArray.Number
                                $RSObject = Get-AzResource -Name $RSObject.Name `
                                    -ResourceGroupName $RSObject.RG                         # Pulls the full resource object
                                Clear-Host                                                  # Clear the screen
                                Return $RSObject                                            # Returns to calling function with $var
                            }                                                               # End elseif ($RSObjectInput -in $ListArray.Number)
                            else {                                                          # All other inputs for $RSObjectInput
                                Write-Host 'That was not a valid input'                     # Write message to screen
                            }                                                               # End else (if ($RSObjectInput -eq '0'))
                        }                                                                   # End :SelectAzureRSObject while ($True)
                    }                                                                       # End if ($RSObject.count -gt 1) 
                    else {                                                                  # If $RSObject has a value and the count is not greater than '1'
                        Clear-Host                                                          # Clear the screen
                        Return $RSObject                                                    # Returns to calling function with $var
                    }                                                                       # End else (if ($RSObject.count -gt 1))
                }                                                                           # End :SearchAzureRSProvider while ($True)
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals
                :SearchAzureRSProvider while($True) {                                       # Inner loop to find a resource off types
                    $RPObject = $null                                                       # Clears $RPObject
                    $RPTObject = $null                                                      # Clears $RPTObject
                    $RSObject = $null                                                       # Clears $RSObject
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    foreach ($_ in $ListArray) {                                            # For each item in $ListArray
                        $Number = $_.Number                                                 # $Number is equal to current item .Number
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number] " $_.Name                                 # Write message to screen
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $Number is 10 or more
                            Write-Host "[$Number]" $_.Name                                  # Write message to screen
                        }                                                                   # End else (if ($Number -le 9))
                    }                                                                       # End foreach ($_ in $ListArray)
                    :SelectAzureRSProvider while ($True) {                                  # Inner loop for selecting a resource provider 
                        $RPObjectInput = Read-Host "Resource provider"                      # Operator input for $RPObjectInput
                        if ($RPObjectInput -eq '0') {                                       # If $RPObjectInput equals '0'
                            Break SearchAzureRSProvider                                     # Breaks :SearchAzureRSProvider 
                        }                                                                   # End if ($RPObjectInput -eq '0')
                        elseif ($RPObjectInput -in $ListArray.Number) {                     # If $RPObjectInput in $ListArray.Number
                            $RPObject = $ListArray | Where-Object `
                                {$_.Number -eq $RPObjectInput}                              # $RPObjectInput is equal to $ListArray where $RPObjectInput equals $ListArray.number 
                            $RPObject = $RPObject.Name                                      # Isolates the resource provider name
                            Break SelectAzureRSProvider                                     # Breaks :SelectAzureRSProvider 
                        }                                                                   # End elseif ($RPObjectInput -in $ListArray.Number)
                        else {                                                              # All other inputs for $RPObjectInput
                            Write-Host 'That was not a valid input'                         # Write message to screen
                        }                                                                   # End else (if ($RPObjectInput -eq '0'))
                    }                                                                       # End :SelectAzureRSProvider while ($True)
                    $RPTObjectList = (Get-AzResourceProvider | Where-Object `
                        {$_.ProviderNamespace -eq $RPObject`
                        }).ResourceTypes                                                    # Creates a list of resrouce provider types
                    $ListArray = $null                                                      # Clears $ListArray
                    [System.Collections.ArrayList]$ListArray = @()                          # Recreates the $ListArray
                    $ListNumber = 1                                                         # Sets $ListNumber to '1'
                    foreach ($_ in $RPTObjectList) {                                        # For each $_ in $ProviderList
                        $ListInput = [PSCustomObject]@{'Name'=$_.ResourceTypeName; `
                            'Number' = $ListNumber}                                         # Creates the item to loaded into array
                        $ListArray.Add($ListInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                    }                                                                       # End foreach ($_ in $RPTObjectList)
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    foreach ($_ in $ListArray) {                                            # For each item in $ListArray
                        $Number = $_.Number                                                 # $Number is equal to current item .Number
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number] " $_.Name                                 # Write message to screen
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $Number is 10 or more
                            Write-Host "[$Number]" $_.Name                                  # Write message to screen
                        }                                                                   # End else (if ($Number -le 9))
                    }                                                                       # End foreach ($_ in $ListArray)
                    :SelectAzureRPType while ($True) {                                      # Inner loop for selecting the resource provider type
                        $RPTObjectInput = Read-Host 'Enter the type [#]'                    # Operator input for the resource provider type name
                        if ($RPTObjectInput -eq '0') {                                      # If $RPTObjectInput equals '0' 
                            Break SearchAzureRSType                                         # Breaks :SearchAzureRSType
                        }                                                                   # End if ($RPTObjectInput -eq '0')
                        elseif ($RPTObjectInput -in $ListArray.Number) {                    # If $RPTObjectInput in $ListArry.Number
                            $RPTObject = $ListArray | Where-Object `
                                {$_.Number -eq $RPTObjectInput}                             # $RPTObject equals $ListArray where $RPTObjectInput equals $ListArray.number
                            $RPTObject = $RPTObject.Name                                    # RPTObject equals $RPTObject.Name
                            $RPTObjectName = $RPObject+"/"+$RPTObject                       # Merges $RPObject and $RPTObject for resource search
                            Break SelectAzureRPType                                         # Breaks :SelectAzureRPType
                        }                                                                   # End elseif ($RPTObjectInput -in $ListArray.Number)
                        else {                                                              # All other inputs for $RPTObject
                            Write-Host 'That was not a valid input'                         # Write message to screen
                        }                                                                   # End else (if ($RPTObjectInput -eq '0'))
                    }                                                                       # End :GetAzureRPTObject while ($True)
                    $RSObject = Get-AzResource -ResourceType $RPTObjectName                 # Collects all resource with a resource provider type matching $RPTObject
                    if (!$RSObject) {                                                       # If $RSObject does not have a value
                        Write-Host `
                            'No resources found with provider type'$RPTObjectName           # Write message to screen
                        Break SearchAzureRSType                                             # Breaks :SearchAzureRSType
                    }                                                                       # End if (!$RSObject)
                    if ($RSObject.count -gt 1) {                                            # If $RSObject count is greater than 1
                        $ListArray = $null                                                  # Clears $ListArray
                        [System.Collections.ArrayList]$ListArray = @()                      # Recreates the $ListArray
                        $ListNumber = 1                                                     # Sets $ListNumber to '1'
                        foreach ($_ in $RSObject) {                                         # For each $_ in $ProviderList
                            $ListInput = [PSCustomObject]@{'Name'=$_.Name; `
                                'Number'= $ListNumber;'RG'=$_.ResourceGroupName}            # Creates the item to loaded into array
                            $ListArray.Add($ListInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                            $ListNumber = $ListNumber + 1                                   # Increments $ListNumber by 1
                        }                                                                   # End foreach ($_ in $RSObject)
                        :SelectAzureRSObject while ($True) {                                # Inner loop for selecting a resource from a list
                            Write-Host '[0] Exit'                                           # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            foreach ($_ in $ListArray) {                                    # For each item in $ListArray
                                $Number = $_.Number                                         # $Number is equal to current item .Number
                                if ($Number -le 9) {                                        # If $Number is 9 or less
                                    Write-Host "[$Number] " $_.Name                         # Write message to screen
                                    Write-Host 'RG: '$_.RG                                  # Write message to screen
                                    Write-Host ''                                           # Write message to screen
                                }                                                           # End if ($Number -le 9)
                                else {                                                      # If $Number is 10 or more
                                    Write-Host "[$Number]" $_.Name                          # Write message to screen
                                    Write-Host 'RG: '$_.RG                                  # Write message to screen
                                    Write-Host ''                                           # Write message to screen
                                }                                                           # End else (if ($Number -le 9))
                            }                                                               # End foreach ($_ in $ListArray)
                            $RSObjectInput = Read-Host 'Enter the [#] of the resource'      # Operator input to select the resource
                            if ($RSObjectInput -eq '0') {                                   # If $RSObjectInput equals '0'
                                Break SearchAzureRSProvider                                 # Breaks :SearchAzureRSProvider
                            }                                                               # End if ($RSObjectInput -eq '0')
                            elseif ($RSObjectInput -in $ListArray.Number) {                 # If $RSObjectInput in $ListArray.Number
                                $RSObject = $ListArray | Where-Object `
                                    {$_.Number -eq $RSObjectInput}                          # $RSObject equals $ListArray where $RSObjectInput equals $ListArray.Number
                                $RSObject = Get-AzResource -Name $RSObject.Name `
                                    -ResourceGroupName $RSObject.ResourceGroupName          # Pulls the full resource object
                                Clear-Host                                                  # Clear the screen
                                Return $RSObject                                            # Returns to calling function with $var
                            }                                                               # End elseif ($RSObjectInput -in $ListArray.Number)
                            else {                                                          # All other inputs for $RSObjectInput
                                Write-Host 'That was not a valid input'                     # Write message to screen
                            }                                                               # End else (if ($RSObjectInput -eq '0'))
                        }                                                                   # End :SelectAzureRSObject while ($True)
                    }                                                                       # End if ($RSObject.count -gt 1) 
                    else {                                                                  # If $RSObject has a value and the count is not greater than '1'
                        Clear-Host                                                          # Clear the screen
                        Return $RSObject                                                    # Returns to calling function with $var        
                    }                                                                       # End else (if ($RSObject.count -gt 1))
                }                                                                           # End :SearchAzureRSProvider while ($True)
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for if $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :SearchAzRGByType while ($true)
        Start-Sleep(5)                                                                      # Pauses all actions for 5 seconds
        Clear-Host                                                                          # Clear the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End  function SearchAzResourceType
function SearchAzResourceLoc {                                                              # Function to get a resource based off location
    Begin {                                                                                 # Begin function
        :SearchAzureRSByLoc while($true) {                                                  # Outer loop for managing function
            $CallingFunction = 'SearchAzResourceLoc'                                        # Creates $CallingFunction
            $LocationObject = GetAzLocation ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                Break SearchAzureRSByLoc                                                    # Breaks :SearchAzureRSByLoc
            }                                                                               # End if (!$LocationObject)
            else {                                                                          # If $LocationObject has a value
                $RSObject = Get-AzResource | Where-Object `
                    {$_.Location -eq $LocationObject.Location}                              # Pulls all matching resources
                if (!$RSObject) {
                    Write-Host 'No resources found in'$LocationObject.Location              # Write message to screen
                    Start-Sleep(5)                                                          # Pauses all action for 5 seconds
                    Break SearchAzureRSByLoc                                                # Breaks :SearchAzureRSByLoc
                }                                                                           # End if (!$RSObject)
                elseif ($RSObject.Count -gt 1) {                                            # If $RSObject exists and has a count greater than 1
                    $ListNumber = 1                                                         # Sets $ListNumber to 1
                    [System.Collections.ArrayList]$ListArray = @()                          # Creates the list array
                    foreach ($_ in $RSObject) {                                             # For each $_ in $RSObject
                        $ListInput = [PSCustomObject]@{'Name'=$_.Name; `
                        'RG' = $_.ResourceGroupName;'Number' = $ListNumber}                 # Creates the item to loaded into array
                        $ListArray.Add($ListInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                    }                                                                       # End foreach ($_ in $RSObject)
                    Write-Host '[0]  Exit'                                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ListArray) {                                            # For each $_ in $ListArray
                        $Number = $_.Number                                                 # Sets $Number to current item .Number
                        if ($_.Number -le 9) {                                              # If current item .number is 9 or less
                            Write-Host "[$Number] "$_.Name                                  # Write message to screen
                        }                                                                   # End if ($_.Number -le 9)
                        else {                                                              # If current item .number is more than 9
                            Write-Host "[$Number]"$_.Name                                   # Write message to screen
                        }                                                                   # End else (if ($_.Number -le 9))
                        Write-Host 'RG: '$_.RG                                              # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $ListArray)
                    :SelectAzureResource while ($true) {                                    # Inner loop to select the resource
                        $RSSelect = Read-Host "Enter the resource [#]"                      # Operator input for the resource selection
                        if ($RSSelect -eq '0') {                                            # If $RSSelect equals 0
                            Break SearchAzureRSByLoc                                        # Breaks :SearchAzureRSByLoc
                        }                                                                   # End if ($RSSelect -eq '0')
                        if ($RSSelect -in $ListArray.Number) {                              # If $RSSelect is in $ListArray
                            $RSSelect = $ListArray | Where-Object {$_.Number -eq $RSSelect} # $RSSelect is equal to $ListArray where $ListArray.Number is equal to $RSSelect                                  
                            $RSObject = Get-AzResource -ResourceGroup $RSSelect.RG `
                                | Where-Object {$_.Name -eq $RSSelect.Name}                 # Pulls the full resource object
                            Clear-Host                                                      # Clears screen
                            Return $RSObject                                                # Returns to calling function with $RGObject
                        }                                                                   # End if ($RSSelect -in $ListArray)
                        else {                                                              # All other inputs for RSSelect
                            Write-Host "That was not a valid option"                        # Write message to screen
                        }                                                                   # End else (if ($RSSelect -in $ListArray.Number))
                    }                                                                       # End :SelectAzureResource while ($true)
                }                                                                           # End elseif (($RSObject.Count -gt 1))
                else {                                                                      # If $RSObject exists with a single object
                    Clear-Host                                                              # Clears screen
                    Return $RSObject                                                        # Returns to calling function with $var
                }                                                                           # End else (if (!$RSObject))
            }                                                                               # End else (if (!$LocationObject))
        }                                                                                   # End :SearchAzureRSByLoc while($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SearchAzResourceLoc
function SearchAzResourceTag { # Searchs for resource group using tag matches on the group, or a contained resource
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $ValidTagName = Get-AzTag # Collects the list of all existing tags
        :SearchAzureRSByTag while($true) { # :SearchAzureRSByTag loop finds a resource group off tag values
            :SearchAzureRSTag while ($true) { # :SearchAzureRSTag loop finds resource group off Tag
                Write-Host "Search by resource Tag" # Write message to screen
                $TagNameInput = $null # Clears $var from previous use
                $TagValueInput = $null # Clears $var from previous use
                $RSObject = $null # Clears $var from previous use
                :SetTagName while ($true) { # Loop for getting and verifing $TagNameInput
                    $TagNameInput = Read-Host "Resource Tag" # Operator input for the Tag
                    if ($TagNameInput -eq 'exit') { # If statement to end this function
                        Break SearchAzureRSByTag # Ends :SearchAzureRSByTag loop
                    } # End if ($TagNameInput -eq 'exit')
                    elseif ($TagNameInput -iin $ValidTagName.Name) { # Validates $TagNameInput against $ValidTagName
                        Break SetTagName # End :SetTagName while ($true) 
                    } # End elseif ($TagNameInput -iin $ValidTagName.Name)
                    else { # Else statement for $TagNameInput not matching anything in $ValidTagName
                        Write-Host "The tag name provided is not valid, please chose from the following" # Error reporting to the screen
                        Write-Host $ValidTagName.Name -Separator `n # Outputs the valid Tag lists
                    } # End if ($TagNameInput -eq 'exit')
                } # End :SetTagName while ($true)
                $OperatorSearchOption = Read-Host "Include a tag value in search" # Operator input for searching just by tag name, or adding a tag value
                if ($OperatorSearchOption -eq 'y' -or $OperatorSearchOption -eq 'yes') { # If statement for adding a tag value
                    :SetTagValue while ($true) { # :SetTagValue while loop, used to verify that the value is an available option on the tag name
                        $ValidTagValue = (Get-AzTag -Name $TagNameInput).values # Gets all tag values under the tag name $TagNameInput
                        $TagValueInput = Read-Host "Tag value" # Operator input for the tag value
                        if ($TagValueInput -eq 'exit') { # If statement to end this function
                            Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRSByTag loop
                        } # End if ($TagValueInput -eq 'exit')
                        elseif ($TagValueInput -iin $ValidTagValue.Name) { # elseif statement if $TagValueInput is in the list of $ValidTagValue
                            Break SetTagValue # Breaks out of :SetTagValue loop
                        } # End elseif ($TagValueInput -iin $ValidTagValue.Name)
                        else { # Else statement for $TagValueInput not matching anything in $ValidTagValue
                            Write-Host "The tag value provided is not valid, please chose from the following" # Error reporting to the screen
                            Write-Host $ValidTagValue.Name -Separator `n # Outputs the valid Tag lists
                        } # End else (if ($TagValueInput -eq 'exit'))
                    } # End :SetTagValue while ($true) 
                } # End if ($OperatorSearchOption -eq 'y' -or $OperatorSearchOption -eq 'yes') 
                if ($TagValueInput) { # If statement for $TagValueInput having a value
                    $RSObject = Get-AzResource -TagName $TagNameInput -TagValue $TagValueInput # Collects all resource objects where tag name and value matches $TagNameInput and TagValueInput
                } # End if ($TagValueInput)
                else {  # Else statement for $TagValueInput not having a value
                    $RSObject = Get-AzResource -TagName $TagNameInput # Collects all resource objects where tag name matches $TagNameInput
                } # End else if (($TagValueInput))
                if (!$RSObject) { # If statement if no resources match the resource tag name
                    Write-Host "No resources found for the Tag name"$TagNameInput # Write message to screen
                    Break SearchAzureRSByTag # Ends :SearchAzureRSByTag loop
                } # End if (!$RSObject)
                :GetAzureRSObject while ($true) { # :GetAzureRSObject loop for narrowing down matching resources
                    if ($RSObject.count -gt 1) { # If statement if more than 1 resource matches the resource tag
                        if ($TagValueInput) { # If statement removes the option to narrow search using tag value if a tag value input has already been provided
                            Write-Host "Multiple resources found" # Write message to screen
                            $ForEachCount = 1 # Counter used in foreach statement
                            foreach ($Name in $RSObject) { # For each resource name in $RSObject
                                Write-Host "" # Write message to screen
                                Write-Host "Matching resource" $ForEachCount # Write message to screen
                                Write-Host "Resource Name: "$Name.Name # Write $RSObject name
                                Write-Host "Resource Group:"$Name.ResourceGroupName # Write $RSObject resource group name
                                $ForEachCount = $ForEachCount+1 # Adds 1 to $ForEachCount
                            } # End foreach ($Name in $RSObject)
                            Write-Host "" # Write message to screen
                            $OperatorSearchOption  = '2' # Sets follow up search option to use the resource name
                        } # End if ($TagValueInput) 
                        else { # else statement for $TagValueInput not having a value
                            Write-Host "Multiple resources found" # Write message to screen
                            $ForEachCount = 1 # Counter used in foreach statement
                            foreach ($Name in $RSObject) { # For each resource name in $RSObject
                                Write-Host "" # Write message to screen
                                Write-Host "Matching resource" $ForEachCount # Write message to screen
                                Write-Host "Resource Name: "$Name.Name # Write $RSObject name
                                Write-Host "Resource Group:"$Name.ResourceGroupName # Write $RSObject resource group name
                                $ForEachCount = $ForEachCount+1 # Adds 1 to $ForEachCount
                            } # End foreach ($Name in $RSObject)
                            Write-Host "" # Write message to screen
                            Write-Host "1 Narrow search using tag value" # Write message to screen
                            Write-Host "2 Narrow Search using resource name" # Write message to screen
                            $OperatorSearchOption = Read-Host "Option?" # Operator input for $OperatorSearchOption
                        } # End else if ($TagValueInput)
                        if ($OperatorSearchOption -eq 'exit') { # If statement for exiting :SearchAzureRSTag
                            Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRSByTag loop
                        } # End if ($OperatorSearchOption -eq 'exit')
                        elseif ($OperatorSearchOption -eq '1') { # Elseif statement for narrowing search by adding a tag value
                            $TagValueInput = Read-Host "Tag value" # Operator input for $TagValueInput
                            $RSObject = Get-AzResource -TagName $TagNameInput -TagValue $TagValueInput # Collects $RSObject with additional search values
                        } # End elseif ($OperatorSearchOption -eq '1')
                        elseif ($OperatorSearchOption -eq '2') { # Elseif statement for narrowing search by adding a resource name
                            $RSObjectInput = Read-Host "Resource name" # Operator inout for the resource name
                            if ($RSObjectInput -eq 'exit') { # If statement for exiting :SearchAzureRSTag
                                Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRSByTag loop
                            } # End if ($RSObjectInput -eq 'exit')
                            $RSObjectInput = "*"+$RSObjectInput+"*" # Adds wildcards to $RSObjectInput
                            $RGObjectInput = Read-Host "Resource group name" # Collects resource group name value to narrow selection
                            $RGObjectInput = "*"+$RGObjectInput+"*" # Adds wildcards to $RGObjectInput
                            $RSObject = Get-AzResource -TagName $TagNameInput | Where-Object {$_.Name -like $RSObjectInput -and $_.ResourceGroupName -like $RGObjectInput} # Collects $RSObject again using the narrower search options
                        } # End elseif ($OperatorSearchOption -eq '2')
                    } # End if ($RSObject.count -gt 1)
                    elseif ($RSObject.count -eq 1) { # elseif statement for a single matching resource object
                        Write-Host "Returning with RSObject" # Write message to screen
                        Return $RSObject # Returns $RSObject to calling function # Returns $RSObject to calling function
                    } # End if ($RSObject.count -eq 1) 
                } # End :GetAzureRSObject while ($True)
            } # End :SearchAzureRSTag while ($true)
        } # End :SearchAzureRSByTag while($true)
        Return # Returns to calling function empty if operator has used 'exit' options
    } # End begin statement
} # End SearchAzResourceTag
function ManageAzResourceGroupLocks {
    Begin {
        :ManageAzureRGLocks while($true) { # :ManageAzureRGLocks loop for managing resource group locks 
            Write-Host "Resource Group Lock Management" # Write message to screen
            Write-Host "1 New Resource Group Lock" # Write message to screen
            Write-Host "2 New Resource Lock" # Write message to screen
            Write-Host "3 Get All Resource Group Locks" # Write message to screen
            Write-Host "4 Get Named Resource Group Lock" # Write message to screen
            Write-Host "5 Get All Resource Locks" # Write message to screen
            Write-Host "6 Get Named Resource Lock" # Write message to screen
            Write-Host "7 Remove Locks" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $OperatorManageOption = Read-Host "Option?" # Operator input to select management function
            if ($OperatorManageOption -eq 'exit') { # If statement for exiting this function
                Break ManageAzureRGLocks # Ends :ManageAzureRGLocks loop, returning to calling function 
            } # End if ($OperatorManageOption -eq 'exit')
            elseif ($OperatorManageOption -eq '1') { # Option for new resource group lock
                Write-Host "New Resource Group Lock" # Write message to screen
                $Locks = NewAzResourceGroupLock # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '1')
            elseif ($OperatorManageOption -eq '2') { # Option for new resource lock
                Write-Host "New Resource Lock" # Write message to screen
                $Locks = NewAzResourceLock # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '2')
            elseif ($OperatorManageOption -eq '3') { # Option to get all locks on a resource group
                Write-Host "Get All Resource Group Locks" # Write message to screen
                $Locks = GetAzResourceGroupLocksAll # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '3')
            elseif ($OperatorManageOption -eq '4') { # Option to get a named lock on a resource group
                Write-Host "Get Named Resource Group Lock" # Write message to screen
                $Locks = GetAzResourceGroupLockNamed # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '4')
            elseif ($OperatorManageOption -eq '5') { # Option to get all locks on a resource
                Write-Host "Get All Resource Locks" # Write message to screen
                $Locks = GetAzResourceLocksAll # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '5')
            elseif ($OperatorManageOption -eq '6') { # Option to get a named lock on a resource
                Write-Host "Get Named Resource Lock" # Write message to screen
                $Locks = GetAzResourceLockNamed # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '6')
            elseif ($OperatorManageOption -eq '7') { # Option to remove locks
                Write-Host "7 Remove Locks" # Write message to screen
                RemoveAzResourceLocks ($Locks) # Calls function to remove locks, passed $Locks
            } # End elseif ($OperatorManageOption -eq '7')
            elseif ($OperatorManageOption -eq '0') { # Option to clear the current $Locks, $RGObject, $RSObject values
                $OperatorSelect = Read-Host "Lock, RGObject, and/or RSObject" # Operator input for removing a value from $var
                if ($OperatorSelect -like "*Lock*") { # Option for clearing $Locks
                    $Locks = $null # Clears $Locks value
                    Write-Host '$Locks has been cleared' # Write message to screen
                } # End if ($OperatorSelect -like "*Lock*")
                if ($OperatorSelect -like "*RGObject*") { # Option for clearing $RGObject
                    $RGObject = $null # Clears $RGObject value
                    Write-Host '$RGObject has been cleared' # Write message to screen
                } # #End if ($OperatorSelect -like "*RGObject*")
                if ($OperatorSelect -like "*RSObject*") { # Option for clearing $RSObject
                    $RSObject = $null # Clears $RSObject value
                    Write-Host '$RSObject has been cleared' # Write message to screen
                } # End if ($OperatorSelect -like "*RSObject*")
            } # End elseif ($OperatorManageOption -eq '0')
            if ($Locks -or $RGObject -or $RSObject) { # If $Locks, $RGObject, or $RSObject object has a value, writes info to screen
                if ($Locks) { # If $Locks has a value
                    if ($Locks.count -gt 1) { # If $Locks has 2 or more objects
                        Write-Host "The following locks are selected"
                        $ForEachCount = 1 # Counter used in foreach statement
                        foreach ($Name in $Locks) { # For each lock name in $Locks
                            Write-Host "" # Write message to screen
                            Write-Host "Matching resource" $ForEachCount # Write message to screen
                            Write-Host "Lock name:          "$Name.Name
                            Write-Host "Lock properties:    "$Name.Properties
                            Write-Host "Lock resource name: "$Name.ResourceName
                            $ForEachCount = $ForEachCount+1 # Adds 1 to $ForEachCount
                        } # End foreach ($Name in $Locks)
                        Write-Host ""
                    } # End if ($Locks.count -gt 1)
                    else { # If $Locks has a single object
                    Write-Host $Locks.Name "is the currently selected lock" # Write message to screen
                    } # End else if ($Locks.count -gt 1)
                } # End if ($Locks)
                if ($RGObject) { # If $RGObject has a value
                    Write-Host $RGObject.ResourceGroupName "is the currently selected resource group" # Write message to screen
                } # End if ($RGObject)
                if ($RSObject) { # If $RSObject has a value
                    Write-Host $RSObject.Name "is the currently selected resource" # Write message to screen
                } # End if ($RSObject) 
            Write-Host 'Use option "0" to clear $Locks' # Write message to screen
            } # End if ($Locks -or $RGObject -or $RSObject)
            $OperatorManageOption = $null # Clears $Operator search option incase of error
        }# End :ManageAzureRGLocks while loop
        Return # Returns to calling function, no info is returned
    } # End begin
} # End function ManageAzResourceGroupLocks
function NewAzResourceGroupLock { # Function to create a new resource lock on a resource
    Begin {
        :NewAzureRGLock while ($true) { # :NewAzureRGLock loop for creating a new resource group lock
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break NewAzureRGLock # Breaks :NewAzureRGLock loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            :GetAzureLockName while ($true) { # :GetAzureLockName loop for setting the lock name
                $LockName = Read-Host "Lock Name?" # Operator input for the lock name
                if ($LockName -eq 'exit') { # If operator input is 'exit'
                    Break NewAzureRGLock # Breaks :NewAzureRGLock loop
                } # End if ($LockName -eq 'exit')
                Write-Host "The lock name will be" $LockName # Write message to screen
                $OperatorConfirm = Read-Host "Confirm?" # Operator input to confirm the lock name
                if ($OperatorConfirm -eq 'exit') { # If operator input is 'exit' 
                    Break NewAzureRGLock # Breaks :NewAzureRGLock loop
                } # End if ($OperatorConfirm -eq 'exit')
                elseif ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # Operator confirm is 'y' or 'yes'
                    Break GetAzureLockName # Breaks :GetAzureLockName
                } # End elseif ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :GetAzureLockName while ($true)
            :GetAzureLockLevel while ($true) { # :GetAzureLockLevel loop for setting lock level
                Write-Host "1 Read Only" # Write message to screen
                Write-Host "2 Can Not Delete" # Write message to screen
                $LockLevel = Read-Host "Option"
                if ($LockLevel -eq 'exit') { # If operator input is 'exit'
                    Break NewAzureRGLock # Breaks :NewAzureRGLock loop
                } # End if ($LockLevel -eq 'exit')
                elseif ($LockLevel -eq '1') { # If $LockLevel is '1'
                    $LockLevel = 'ReadOnly' # Sets $LockLevel to 'ReadOnly'
                    Break GetAzureLockLevel # Breaks GetAzureLockLevel
                } # End elseif ($LockLevel -eq '1')
                elseif ($LockLevel -eq '2') { # If $LockLevel is '2'
                    $LockLevel = 'CanNotDelete'# Sets $LockLevel to 'CanNotDelete'
                    Break GetAzureLockLevel # Breaks GetAzureLockLevel
                } # End elseif ($LockLevel -eq '2')
                else { # All other inputs for $LockLevel
                    Write-Host "That is not a valid option"  # Write message to screen
                } # End else (if ($LockLevel -eq 'exit'))
            } # End :GetAzureLockLevel while($true)
            $LockNotes = Read-Host "Add lock notes" # Operator input for lock notes
            if ($LockNotes) { # If $LocksNotes has a value
                $Locks = New-AzResourceLock -LockLevel $LockLevel -LockNotes $LockNotes -LockName $LockName -ResourceGroupName $RGObject.ResourceGroupName -Force # Deploys resource lock to resource group (With lock notes)   
                Return $Locks # Returns $Locks to calling function
            } # End if ($OperatorSelect -eq "y" -or $OperatorSelect -eq 'yes')
            else { # If $LockNotes is $null
                $Locks = New-AzResourceLock -LockLevel $LockLevel -LockName $LockName -ResourceGroupName $RGObject.ResourceGroupName -Force # Deploys resource lock to resource group (No lock notes)
                Return $Locks # Returns $Locks to calling function
            } # End else (if ($OperatorSelect -eq "y" -or $OperatorSelect -eq 'yes'))
        } # End :NewAzureRGLock while ($true) {
        Return
    } # End begin
} # End function NewAzResourceGroupLock
function NewAzResourceLock { # Function to create a new resource lock on a resource
    Begin {
        :NewAzureRSLock while ($true) { # :NewAzureRsLock loop for creating a new resource lock
            if (!$RSObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break NewAzureRGLock # Breaks :NewAzureRGLock loop
                } # End if (!$RGObject)
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break NewAzureRSLock # Breaks :NewAzureRSLock loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            :GetAzureLockName while ($true) { # :GetAzureLockName loop for setting the lock name
                $LockName = Read-Host "Lock Name?" # Operator input for the lock name
                if ($LockName -eq 'exit') { # If operator input is 'exit'
                    Break NewAzureRSLock # Breaks :NewAzureRSLock loop
                } # End if ($LockName -eq 'exit')
                Write-Host "The lock name will be" $LockName # Write message to screen
                $OperatorConfirm = Read-Host "Confirm?" # Operator input to confirm the lock name
                if ($OperatorConfirm -eq 'exit') { # If operator input is 'exit' 
                    Break NewAzureRSLock # Breaks :NewAzureRSLock loop
                } # End if ($OperatorConfirm -eq 'exit')
                elseif ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # Operator confirm is 'y' or 'yes'
                    Break GetAzureLockName # Breaks :GetAzureLockName
                } # End elseif ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :GetAzureLockName while ($true)
            :GetAzureLockLevel while ($true) { # :GetAzureLockLevel loop for setting lock level
                Write-Host "1 Read Only" # Write message to screen
                Write-Host "2 Can Not Delete" # Write message to screen
                $LockLevel = Read-Host "Option"
                if ($LockLevel -eq 'exit') { # If operator input is 'exit'
                    Break NewAzureRSLock # Breaks :NewAzureRSLock loop
                } # End if ($LockLevel -eq 'exit')
                elseif ($LockLevel -eq '1') { # If $LockLevel is '1'
                    $LockLevel = 'ReadOnly' # Sets $LockLevel to 'ReadOnly'
                    Break GetAzureLockLevel # Breaks GetAzureLockLevel
                } # End elseif ($LockLevel -eq '1')
                elseif ($LockLevel -eq '2') { # If $LockLevel is '2'
                    $LockLevel = 'CanNotDelete'# Sets $LockLevel to 'CanNotDelete'
                    Break GetAzureLockLevel # Breaks GetAzureLockLevel
                } # End elseif ($LockLevel -eq '2')
                else { # All other inputs for $LockLevel
                    Write-Host "That is not a valid option"  # Write message to screen
                } # End else (if ($LockLevel -eq 'exit'))
            } # End :GetAzureLockLevel while($true)
            $LockNotes = Read-Host "Add lock notes" # Operator input for lock notes
            if ($LockNotes) { # If $LocksNotes has a value
                $Locks = New-AzResourceLock -LockLevel $LockLevel -LockNotes $LockNotes -LockName $LockName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType -ResourceGroupName $RSObject.ResourceGroupName -Force # Deploys resource lock to resource (With lock notes)   
                Return $Locks # Returns $Locks to calling function
            } # End if ($OperatorSelect -eq "y" -or $OperatorSelect -eq 'yes')
            else { # If $LockNotes is $null
                $Locks = New-AzResourceLock -LockLevel $LockLevel -LockName $LockName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType -ResourceGroupName $RSObject.ResourceGroupName -Force # Deploys resource lock to resource (No lock notes)
                Return $Locks # Returns $Locks to calling function
            } # End else (if ($OperatorSelect -eq "y" -or $OperatorSelect -eq 'yes'))
        } # End :NewAzureRSLock while ($true) {
        Return
    } # End begin
} # End function NewAzResourceLock
function GetAzResourceGroupLocksAll { # Function to get all locks assigned to a resource group, can pipe $Locks to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        if (!$RGObject) { # If statement if $RGObject is $null
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceGroupLocksAll function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if statement
        } # End if statement
        $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName # Collects all locks and assigns to $Locks
        if (!$Locks) { # If statement for no object assigned to $Locks
            Write-Host "No locks are on this resource group" # Write message to screen
            Write-Host "The GetAzResourceGroupLocksAll function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        else { # Else statement for an object being assigned to $Locks
            Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLocksAll
            Return $Locks # Returns $Locks to the calling function
        } # End else statement
    } # End begin statement
} # End function
function GetAzResourceGroupLockNamed { # Function to get a named lock assigned to a resource group, can pipe $Locks to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        if (!$RGObject) { # If statement if $RGObject is $null
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceGroupLockNamed function was terminated"
                Return # Returns to calling function
            } # End if statement
        } # End if statement
        $Locks = $null
        while (!$Locks) { # While statement used for looping until the correct lock has been found
            $LocksInput = Read-Host "Enter the lock name" # Operator input for a resource group lock name
            if ($LocksInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResourceGroupLockNamed function was terminated"
                Return # Returns to calling function
            } # End if statement
            $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -LockName $LocksInput # Collects the named lock and assigns to $Locks
            if (!$Locks) { # If statement for no object assigned to $Locks
                Write-Host "No locks by that name were found on this resource group" # Write message to screen
                Write-Host "The following are the current locks assigned to" $RGObject.ResourceGroupName
                $LocksList = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -AtScope
                Write-Host $LocksList.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLocksAll
            } # End if statement
            else { # Else statement if a lock is found with the operator input
                $OperatorConfirm = Read-Host "Is this the correct lock" $Locks.Name 
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLock
                    Return $Locks # Returns $Locks to the calling function
                } # End if statement
                elseif ($OperatorSelect -eq 'Exit') { # Elseif statement for 'Exit'
                    Write-Host "GetAzResourceGroupLockNamed function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End elseif statement
                else { # Else statement if operator does not confirm the lock
                    $Locks = $null # Clears $Locks to restart the loop
                } # End else statement
            } # End else statement
        } # End while statement
    } # End begin statement
} # End function 
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
function GetAzResourceLockNamed { # Function to get a named lock assigned to a resource, can pipe $Locks to another function
    Begin {
        $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
        if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
            Write-Host "GetAzResourceLockNamed function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        $RSObject = GetAzResource # Calls function GetAzResourceGroup and assigns to $RGObject
        if (!$RSObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
            Write-Host "GetAzResourceLockNamed function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        $Locks = $null
        while (!$Locks) { # While statement used for looping until the correct lock has been found
            $LocksInput = Read-Host "Enter the lock name" # Operator input for a resource lock name
            if ($LocksInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResourceLockNamed function was terminated"
                Return # Returns to calling function
            } # End if statement
            $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType -LockName $LocksInput | Where-Object {$_.ResourceName -eq $RSObject.Name} # Collects all locks and assigns to $Locks
            if (!$Locks) { # If statement for no object assigned to $Locks
                Write-Host "No locks by that name were found on this resource" # Write message to screen
                Write-Host "The following are the current locks assigned to" $RSObject.Name
                $LocksList = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType | Where-Object {$_.ResourceName -eq $RSObject.Name} # Collects all locks and assigns to $Locks
                Write-Host $LocksList.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLocksAll
            } # End if statement
            else {
                $OperatorConfirm = Read-Host "Is this the correct lock" $Locks.Name 
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLock
                    Return $Locks # Returns $Locks to the calling function
                } # End if statement
                elseif ($OperatorSelect -eq 'Exit') { # Elseif statement for 'Exit'
                    Write-Host "GetAzResourceLockNamed function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End elseif statement
                else { # Else statement if operator does not confirm the lock
                    $Locks = $null # Clears $Locks to restart the loop
                } # End else statement
            } # End else statement
        } # End while statement
    } # End begin statement
} # End function
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
function ManageAzResourceGroupTags { # Management function for tags
    Begin {
        :ManageAzureRGTag while($true) { # :ManageAzureRGTag loop for managing resource group tags 
            Write-Host "Resource Group Tag Management" # Write message to screen
            Write-Host "1 Set Tag Info For Multiple Use" # Write message to screen
            Write-Host "2 Add Resource Group Tag" # Write message to screen
            Write-Host "3 Add Resource Tag" # Write message to screen
            Write-Host "4 Get All Resource Group Tags" # Write message to screen
            Write-Host "5 Get All Resource Tags" # Write message to screen
            Write-Host "6 Remove Named Resource Group Tag" # Write message to screen
            Write-Host "7 Remove Named Resource Tag" # Write message to screen
            Write-Host "8 Remove All Resource Group Tags" # Write message to screen
            Write-Host "9 Remove All Resource Tags" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $OperatorManageOption = Read-Host "Option?" # Operator input to select management function
            if ($OperatorManageOption -eq 'exit') { # If statement for exiting this function
                Break ManageAzureRGTag # Ends :ManageAzureRGTag loop, returning to calling function 
            } # End if ($OperatorManageOption -eq 'exit')
            elseif ($OperatorManageOption -eq '1') { # Option for setting tag name and value
                Write-Host "Set Tag Info For Multiple Use" # Write message to screen
                $TagNameInput, $TagValueInput = SetAzTagPair # Calls function
            } # End elseif ($OperatorManageOption -eq '1')
            elseif ($OperatorManageOption -eq '2') { # Option for new resource group tag
                Write-Host "Add Resource Group Tag" # Write message to screen
                $TagsList = AddAzResourceGroupTag ($RGObject, $TagNameInput, $TagValueInput) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '2')
            elseif ($OperatorManageOption -eq '3') { # Option for new resource tag
                Write-Host "Add Resource Tag" # Write message to screen
                $TagsList = AddAzResourceTag ($RGObject, $RSObject, $TagNameInput, $TagValueInput) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '3')
            elseif ($OperatorManageOption -eq '4') { # Option to get tags a resource group
                Write-Host "Get Resource Group Tag" # Write message to screen
                $TagsList = GetAzResourceGroupTags ($RGObject) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '4')
            elseif ($OperatorManageOption -eq '5') { # Option to get tags on a resource
                Write-Host "Get Resource Tag" # Write message to screen
                $TagsList = GetAzResourceTags ($RGObject, $RSObject) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '5')
            elseif ($OperatorManageOption -eq '6') { # Option to remove a named tag on resource group
                Write-Host "Remove Named Resource Group Tag" # Write message to screen
                $TagsList = RemoveAzResourceGroupTag ($RGObject, $TagNameInput, $TagValueInput) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '6')
            elseif ($OperatorManageOption -eq '7') { # Option to remove a named tag on a resource
                Write-Host "Remove Named Resource Tag" # Write message to screen
                $TagsList = RemoveAzResourceTag ($RGObject, $RSObject, $TagNameInput, $TagValueInput) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '7')
            elseif ($OperatorManageOption -eq '8') { # Option to remove all resource group tags
                Write-Host "Remove Resource Group Tag" # Write message to screen
                $TagsList = RemoveAzResourceGroupTags ($RGObject) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '8')
            elseif ($OperatorManageOption -eq '9') { # Option to remove all resource tags
                Write-Host "Remove Resource Tag" # Write message to screen
                $TagsList = RemoveAzResourceTags ($RGObject, $RSObject) # Calls function and assigns value to $TagsList
                Write-Host $TagsList # Writes existing tags to screen
            } # End elseif ($OperatorManageOption -eq '9')
            elseif ($OperatorManageOption -eq '0') { # Option to clear the current $Tags, $RGObject, $RSObject values
                $OperatorSelect = Read-Host "Tag, RGObject, and/or RSObject" # Operator input for removing a value from $var
                if ($OperatorSelect -like "*Tag*") { # Option for clearing $TagNameInput
                    $TagNameInput = $null # Clears $TagNameInput value
                    $TagValueInput = $null # Clears $TagValueInput value
                    Write-Host '$TagNameInput and $TagValueInput has been cleared' # Write message to screen
                } # End if ($OperatorSelect -like "*Lock*")
                if ($OperatorSelect -like "*RGObject*") { # Option for clearing $RGObject
                    $RGObject = $null # Clears $RGObject value
                    Write-Host '$RGObject has been cleared' # Write message to screen
                } # #End if ($OperatorSelect -like "*RGObject*")
                if ($OperatorSelect -like "*RSObject*") { # Option for clearing $RSObject
                    $RSObject = $null # Clears $RSObject value
                    Write-Host '$RSObject has been cleared' # Write message to screen
                } # End if ($OperatorSelect -like "*RSObject*")
            } # End elseif ($OperatorManageOption -eq '0')
            if ($TagNameInput -or $RGObject -or $RSObject) { # If $TagNameInput, $RGObject, or $RSObject object has a value, writes info to screen
                if ($TagNameInput) { # If $TagsName has a value
                    Write-Host $TagNameInput "is the currently selected Tag" # Write message to screen
                } # End if if ($TagNameInput)
                if ($RGObject) { # If $RGObject has a value
                    Write-Host $RGObject.ResourceGroupName "is the currently selected resource group" # Write message to screen
                } # End if ($RGObject)
                if ($RSObject) { # If $RSObject has a value
                    Write-Host $RSObject.Name "is the currently selected resource" # Write message to screen
                } # End if ($RSObject) 
            Write-Host 'Use option "0" to clear $Tags' # Write message to screen
            } # End if ($TagNameInput -or $RGObject -or $RSObject)
            $OperatorManageOption = $null # Clears $Operator search option incase of error
        }# End :ManageAzureRGTag while loop
        Return # Returns to calling function, no info is returned
    } # End begin
} # End function ManageAzResourceGroupTags
function SetAzTagPair { # Function for setting the tag name and value pair
    Begin {
        :SetAzureTagPair while ($true) { # :SetAzureTagPairLoop
            :SetAzureTagName while ($true) { # :SetAzureTagNameLoop
                $TagNameInput = Read-Host "Tag Name" # Operator input for the tag name
                if ($TagNameInput -eq 'exit') { # If $TagNameInput equals 'exit'
                    Break SetAzureTagPair # Breaks :SetAzureTagPair loop
                } # End if ($TagNameInput -eq 'exit')
                $OperatorConfirm = Read-Host $TagNameInput "is correct" # Operator confirmation that the name entered is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                    Break SetAzureTagName # Breaks :setAzureTagName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetAzureTagName while ($true)
            :SetAzureTagValue while ($true) { # :SetAzureTagValue loop
                $TagValueInput = Read-Host "Tag Value" # Operator input for the tag value
                if ($TagValueInput -eq 'exit') { # If $TagValueInput equals 'exit'
                    Break SetAzureTagPair # Breaks :SetAzureTagPair loop
                } # End if ($TagVlaueInput -eq 'exit')
                $OperatorConfirm = Read-Host $TagValueInput "is correct" # Operator confirmation that the value entered is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                    Break SetAzureTagValue # Breaks :SetAzureTagName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetAzureTagValue while ($true)
            Return $TagNameInput, $TagValueInput # Returns $TagNameInput and $TagValueInput to the calling function
        } # End :SetAzureTagPair while ($true)
        Return # Retruns to calling function with $null
    } # End begin
} # End function SetAzTagPair
function AddAzResourceGroupTag { # Function to add a new tag to a resource group
    Begin {
        :AddAzureRGTag while ($true) { # :AddAzureRGTag loop for adding a new tag on a resource group
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break AddAzureRGTag # Breaks :AddAzureRSTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$TagNameInput) { # If $TagNameInput is $null
                :SetAzureTagArray while ($true) { # :SetAzureTagArray loop
                    $TagNameInput, $TagValueInput = SetAzTagPair # Calls function
                    if (!$TagNameInput) { # if SetAzTagPair returns $null
                        Break AddAzureRGTag # Breaks :AddAzureRGTag loop
                    } # End if (!$TagNameInput)
                    $TagsArray = @{$TagNameInput=$TagValueInput} # Builds the tag array to be applied 
                    Break SetAzureTagArray # Breaks :SetAzureTagArray
                } # End :SetAzureTagArray while ($true)
            } # End if (!$TagNameInput)
            Update-AzTag -ResourceID $RGObject.ResourceID -Operation 'Merge' -Tag $TagsArray # Adds the new tag to the resource group without changing the others
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            Return $TagsList # Returns $TagsList to the calling function
        } # End :AddAzureRGTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function AddAzResourceGroupTag
function AddAzResourceTag { # Function to add a new tag to a resource
    Begin {
        :AddAzureRSTag while ($true) { # :AddAzureRSTag loop for adding a new tag on a resource group
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break AddAzureRSTag # Breaks :AddAzureRSTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$RSObject) { # If $RSObject is $null
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break AddAzureRSTag # Breaks :AddAzureRSTag loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            if (!$TagNameInput) { # If $TagNameInput is $null
                :SetAzureTagArray while ($true) { # :SetAzureTagArray loop
                    $TagNameInput, $TagValueInput = SetAzTagPair # Calls function
                    if (!$TagNameInput) { # if SetAzTagPair returns $null
                        Break AddAzureRSTag # Breaks :AddAzureRSTag loop
                    } # End if (!$TagNameInput)
                    $TagsArray = @{$TagNameInput=$TagValueInput} # Builds the tag array to be applied 
                    Break SetAzureTagArray # Breaks :SetAzureTagArray
                } # End :SetAzureTagArray while ($true)
            } # End if (!$TagNameInput)
            Update-AzTag -ResourceID $RSObject.ResourceID -Operation 'Merge' -Tag $TagsArray # Adds the new tag to the resource group without changing the others
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable | Out-String
            Return $TagsList # Returns $Tags to the calling function
        } # End :AddAzureRSTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function AddAzResourceTag
function GetAzResourceGroupTags { # Gets all resource group tags and writes them to screen with values
    Begin {
        :GetAzureRGTag while ($true) { # :GetAzureRGTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break GetAzureRGTag # Breaks :GetAzureRGTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable | Out-String # Formats hashable array into 
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $TagsList to the calling function
        } # End :GetAzureRGTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function GetAzResourceGroupTags
function GetAzResourceTags {
    Begin {
        :GetAzureRSTag while ($true) { # :GetAzureRSTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break GetAzureRSTag # Breaks :GetAzureRSTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$RSObject) { # If $RSObject is $null
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break GetAzureRSTag # Breaks :GetAzureRSTag loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $TagsList to the calling function
        } # End :GetAzureRSTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function GetAzResourceTags
function RemoveAzResourceGroupTag { # Function to remove all tags from a resource
    Begin {
        :RemoveAzureRGTag while ($true) { # :RemoveAzureRGTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break RemoveAzureRGTag # Breaks :RemoveAzureRGTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            $ValidTagName = (Get-AzResourceGroup -ResourceId $RGObject.ResourceId).Tags.Keys # Collects current tag names on resource group and lists them in $ValidTagName
            if ($TagNameInput -notin $ValidTagName) { # Checks passed $TagNameInput against $ValidTagName
                $TagNameInput = $null # Clears $TagNameInput
            } # End if ($TagNameInput -notin $ValidTagName)
            if (!$TagNameInput) { # If $TagNameInput is $null
                :SetAzureTagArray while ($true) { # :SetAzureTagArray loop      
                    $TagNameInput = Read-Host "Tag name to be removed"
                    if (!$TagNameInput -or $TagNameInput -eq 'exit') { # if SetAzTagPair is $null or 'exit'
                        Break RemoveAzureRGTag # Breaks :RemoveAzureRGTag loop
                    } # End if (!$TagNameInput)
                    elseif ($TagNameInput -iin $ValidTagName) { # If $TagNameInput is in $ValidTagName
                        $TagsArray = @{$TagNameInput=""} # Builds the tag array to be removed
                        Break SetAzureTagArray # Breaks :SetAzureTagArray
                    } # End elseif ($TagNameInput -iin $ValidTagName) 
                    else { # All other inputs for $TagNameInput
                        Write-Host "The Tag name provided does not exist" # Write message to screen
                        Write-Host "Please select from the following" # Write message to screen
                        Write-Host $ValidTagName -Separator `n # Write $ValidTagName list to screen
                    } # End else (if (!$TagNameInput -or $TagNameInput -eq 'exit'))
                } # End :SetAzureTagArray while ($true)
            } # End if (!$TagNameInput)
            else { # If $TagNameInput is not $null and is in $ValidTagName build the array
                $TagsArray = @{$TagNameInput=""} # Builds the tag array to be removed
            } # End else (if (!$TagNameInput))
            Update-AzTag -ResourceID $RGObject.ResourceID -Operation 'Delete' -Tag $TagsArray # Removes the named tag from the resource group without changing the others
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource group" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $TagsList to the calling function
        } # End :RemoveAzureRGTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function RemoveAzResouceGroupTag
function RemoveAzResourceTag { # Function to remove all tags from a resource
    Begin {
        :RemoveAzureRSTag while ($true) { # :RemoveAzureRSTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break RemoveAzureRSTag # Breaks :RemoveAzureRSTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$RSObject) { # If $RSObject is $null
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break RemoveAzureRSTag # Breaks :RemoveAzureRSTag loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            $ValidTagName = (Get-AzResource -ResourceId $RSObject.ResourceId).Tags.Keys # Collects current tag names on resource and lists them in $ValidTagName
            if ($TagNameInput -notin $ValidTagName) {
                $TagNameInput = $null
            } # End if ($TagNameInput -notin $ValidTagName)
            if (!$TagNameInput) { # If $TagNameInput is $null
                :SetAzureTagArray while ($true) { # :SetAzureTagArray loop      
                    $TagNameInput = Read-Host "Tag name to be removed"
                    if (!$TagNameInput -or $TagNameInput -eq 'exit') { # if SetAzTagPair is $null or 'exit'
                        Break RemoveAzureRSTag # Breaks :RemoveAzureRSTag loop
                    } # End if (!$TagNameInput)
                    elseif ($TagNameInput -iin $ValidTagName) { # If $TagNameInput is in $ValidTagName
                        $TagsArray = @{$TagNameInput=""} # Builds the tag array to be removed
                        Break SetAzureTagArray # Breaks :SetAzureTagArray
                    } # End elseif ($TagNameInput -iin $ValidTagName) 
                    else { # All other inputs for $TagNameInput
                        Write-Host "The Tag name provided does not exist" # Write message to screen
                        Write-Host "Please select from the following" # Write message to screen
                        Write-Host $ValidTagName -Separator `n # Write $ValidTagName list to screen
                    } # End else (if (!$TagNameInput -or $TagNameInput -eq 'exit'))
                } # End :SetAzureTagArray while ($true)
            } # End if (!$TagNameInput)
            else { # If $TagNameInput is not $null and is in $ValidTagName, build the array
                $TagsArray = @{$TagNameInput=""} # Builds the tag array to be removed
            } # End else (if (!$TagNameInput))
            Update-AzTag -ResourceID $RSObject.ResourceID -Operation 'Delete' -Tag $TagsArray # Removes the named tag from the resource without changing the others
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $Tags to the calling function
        } # End :RemoveAzureRSTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function RemoveAzResouceTags
function RemoveAzResourceGroupTags {
    Begin { 
        :RemoveAzureRGTags while ($true) { # :RemoveAzureRGTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break RemoveAzureRGTags # Breaks :RemoveAzureRGTags loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
        Remove-AzTag -ResourceId $RGObject.ResourceID -PassThru # Removes all tags on the resource group
        $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
        if (!$TagsList) { # If $TagsList is $null
            Write-Host "No tags exist on this resource group" # Write message to screen
        } # End if (!$TagsList)
        Return $TagsList # Returns $TagsList to the calling function
    } # End :RemoveAzureRGTags while ($true) {
    Return # Returns to the calling function with $null
    } # End begin
} # End function RemoveAzResourceGroupTags
function RemoveAzResourceTags {
    Begin {
        :RemoveAzureRSTags while ($true) { # :RemoveAzureRSTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break RemoveAzureRSTags # Breaks :RemoveAzureRSTags loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$RSObject) { # If $RSObject is $null
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break RemoveAzureRSTags # Breaks :RemoveAzureRSTags loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            Remove-AzTag -ResourceId $RSObject.ResourceID -PassThru # Removes all tags on the resource
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $Tags to the calling function
        } # End :RemoveAzureRSTags while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function RemoveAzResourceTags
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