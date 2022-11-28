# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Remove-AzResource:          https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresource?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/GetAzResource.ps1
    ListAzResources:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/ListAzResources.ps1
    RemoveAzResource:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/RemoveAzResource.ps1
    GetAzRSLocksAll:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzRSLocksAll.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLocks.ps1
} #>
<# Functions Description: {
    ManageAzResource:           Manages a resource 
    GetAzResource:              Gets resource
    ListAzResources:            Lists all resources within a resource group    
    RemoveAzResource:           Removes a resource object
    GetAzRSLocksAll:            Gets a list of locks on $RSObject
    RemoveAzResourceLocks:      Removes all items in $Locks
} #>
<# Variables: {
    :ManageAzureSG              Outer loop for managing function
    $RSObject:                  Resource group object
    $ManageAzRS:                Operator input for search option
    GetAzResource{}            Gets $RSObject
    ListAzResources{}             Lists $RSObjects
    RemoveAzResource{}         Removes $RSObject
        GetAzResource{}            Gets $RSObject
        GetAzRSLocksAll{}               Gets $Locks
        RemoveAzResourceLocks{}         Gets $LocksRemoved
} #>
<# Process Flow {
    Function
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
                Call function GetAzRSLocksAll > Get $Locks
                End GetAzRSLocksAll
                    Return RemoveAzResource > Send $Locks
                Call Function RemoveAzResourceLocks > Get $LocksRemoved
                End RemoveAzResourceLocks
                    Return RemoveAzResource > Send $LocksRemoved
            End RemoveAzResource
                Return ManageAzResource > Send $null
        End Function ManageAzResource
                Return Function > Send $RSObject                                    
}#> 
# 1_2_0_0 Manage Resources 28NOV22
function ManageAzResource {                                                                 # Function to manage resource
    Begin {                                                                                 # Begin function
        :ManageAzureSG while($true) {                                                       # Outer loop for managing function
            Write-Host 'Manage Resources'                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] List Resources by Group'                                        # Write message to screen
            Write-Host '[2] Remove Resource'                                                # Write message to screen
            $ManageAzRS = Read-Host 'Option [#]'                                            # Operator input for selecting management function
            if ($ManageAzRS -eq '0') {                                                      # If $ManageAzRS equals '0'
                Break ManageAzureSG                                                         # Breaks :ManageAzureSG
            }                                                                               # End if ($ManageAzRS -eq '0')                                                                     
            elseif ($ManageAzRS -eq '1') {                                                  # else if $ManageAzRS equals '1'
                Write-Host "List Resources By Group"                                        # Write message to screen
                ListAzResources ($RSObject)                                                 # Calls function
            }                                                                               # End elseif ($ManageAzRS -eq '1')
            elseif ($ManageAzRS -eq '2') {                                                  # else if $ManageAzRS equals '2'
                Write-Host "Remove Resource"                                                # Write message to screen
                RemoveAzResource ($RSObject)                                                # Calls function 
            }                                                                               # End elseif ($ManageAzRS -eq '2')
            else {                                                                          # All other inputs for ManageAzRS
                Write-Host 'That was not a valid option'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($ManageAzRS -eq '0'))
        }                                                                                   # End :ManageAzResource while ($true)
        Clear-Host                                                                          # Clears screen
        Return $RSObject                                                                    # Returns $vars to calling function
    }                                                                                       # End begin statement
}                                                                                           # End function ManageAzResource
# 1_2_1_0 ListAzResources 28NOV22
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
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Break ListAzureResources                                                        # Breaks :ListAzureResources
        }                                                                                   # End :ListAzureResources while ($true)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzResources
# 1_2_2_0 RemoveAzResource 28NOV22
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
                    Pause                                                                   # Pauses all actions for operator input
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
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureRSObject                                                   # Breaks :RemoveAzureRSObject
            }                                                                               # End Catch
            Write-Host 'The selected resource has been removed'                             # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break RemoveAzureRSObject                                                       # Breaks :RemoveAzureRSObject
        }                                                                                   # End :RemoveAzureRSObject while ($True)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzResource
# 1_2_G_0 GetAzResource 28NOV22
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
            Write-Host '[0] Exit'                                                           # Write message to screen
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
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureResource while ($true)
        }                                                                                   # End :GetAzureResource while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResource
# End 1_2_0_0 Manage Resources 

# Additional functions required for ManageAzResource
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