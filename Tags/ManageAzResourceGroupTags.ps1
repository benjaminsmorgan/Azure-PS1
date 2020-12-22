# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AZTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/new-aztag?view=azps-5.2.0
    Get-AzTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/get-aztag?view=azps-5.2.0
    Update-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/update-aztag?view=azps-5.2.0             
    Remove-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-aztag?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0

} #>
<# Required Functions Links: {
    NewAzResourceGroupTag:      TBD
    NewAzResourceTag:           TBD
    GetAzResourceTag:           TBD
    GetAzResourceGroup:         TBD
    GetAzResource:              TBD
} #>
<# Functions Description: {
    ManageAzResourceGroupTags:  Management function for tags functions
    SetAzTagPair:               Create a tag for multiple uses
    NewAzResourceGroupTag:      Create a new resource lock on a resource group
    GetAzResourceGroupLocksTag: Collects tag on a resource group
    GetAzResourceTag:           Collects tag on a resource
    GetAzResourceGroup:         Collects resource group object
    GetAzResource:              Collects resources within a resource group
} #>
<# Variables: {
    ManageAzResourceGroupLocks {
        $OperatorManageOption:  Operator input for management option
        $OperatorSelect:        Operator input for clearing $Vars
        :ManageAzureRGTag       Outer loop for function
        SetAzTagPair {
            $TagNameInput:          Operator input for the tag name
            $TagValueInput:         Operator input for the tag value
            $TagFull:               Tag array
            $Tags:                  Tag object
            :SetAzureTagPair        Outer loop for function
            :GetAzureTagName        Inner loop for getting tag name
            :GetAzureTagValue       Inner loop for getting tag value
        }
        NewAzResourceGroupTag {
            $RGObject:              Resource group object
            $TagNameInput:          Operator input for the tag name
            $TagValueInput:         Operator input for the tag value
            $TagFull:               Tag array
            $Tags:                  Tag object
            :NewAzureRGTag          Outer loop for function
            :GetAzureTagName        Inner loop for getting tag name
            :GetAzureTagValue       Inner loop for getting tag value
        }
        NewAzResourceTag {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $TagNameInput:          Operator input for the tag name
            $TagValueInput:         Operator input for the tag value
            $TagFull:               Tag array
            $Tags:                  Tag object
            :NewAzureRSTag          Outer loop for function
            :GetAzureTagName        Inner loop for getting tag name
            :GetAzureTagValue       Inner loop for getting tag value
        }
        GetAzResourceGroupTag {
            $RGObject:              Resource group object
            $TagNameInput:          Operator input for the tag name
            $TagValueInput:         Operator input for the tag value
            $TagFull:               Tag array
            $Tags:                  Tag object
            :GetAzureRGTag          Outer loop for function
            :GetAzureTagName        Inner loop for getting tag name
            :GetAzureTagValue       Inner loop for getting tag value
        }
        GetAzResourceTag {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $TagNameInput:          Operator input for the tag name
            $TagValueInput:         Operator input for the tag value
            $TagFull:               Tag array
            $Tags:                  Tag object
            :GetAzureRGTag          Outer loop for function
            :GetAzureTagName        Inner loop for getting tag name
            :GetAzureTagValue       Inner loop for getting tag value
        }
        RemoveAzResourceTags {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $TagNameInput:          Operator input for the tag name
            $TagValueInput:         Operator input for the tag value
            $TagFull:               Tag array
            $Tags:                  Tag object
            :GetAzureRGTag          Outer loop for function
            :GetAzureTagName        Inner loop for getting tag name
            :GetAzureTagValue       Inner loop for getting tag value
        }    
        GetAzResourceGroup {
            $RGObject:              Resource group object
            $RGObjectInput:         Operator input for the resource group name
            $RGList:                Variable used for printing all resource groups to screen if needed
        }
            GetAzResource {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $RSObjectInput:         Operator input for the resource name
            $RSList:                Variable used for printing all resources to screen if needed
        }
    } End ManageAzResourceGroupLocks
} #>
<# Process Flow { # FIX THIS***************
    Function
        Call ManageAzResourceGroupLock
            Call NewAzResourceGroupLock > Get $Locks
                Return ManageAzResourceGroupLock > Send $Locks
            Call NewAzResourceLock > Get $Locks 
                Return ManageAzResourceGroupLock > Send $Locks
            Call GetAzResourceGroupLocksAll > Get $Locks
                Call GetAzResourceGroup > Get $RGObject
                    Return GetAzResourceGroupLocksAll > Send $RGObject
                Return ManageAzResourceGroupLock > Send $Locks
            Call GetAzResourceGroupLockNamed > Get $Locks
                Call GetAzResourceGroup > Get RGObject
                    Return GetAzResourceGroup > Send $RGObject
                Return ManageAzResourceGroupLock > Send $Locks                
            Call GetAzResourceLocksAll > Get $Locks
                Call GetAzResourceGroup > Get $RGObject
                    Return GetAzResourceLocksAll > Send $RGObject
                Call GetAzResource > Get $RSObject
                    Return GetAzResource > Send $RSObject
                Return ManageAzResourceGroupLock > Send $Locks
            Call GetAzResourceLockNamed > Get $Locks
                Call GetAzResourceGroup > Get $RGObject
                    Return GetAzResourceLockNamed > Send $RGObject
                Call GetAzResource > Get $RSObject
                    Return GetAzResourceLockNamed > Send $RSObject
                Return ManageAzResourceGroupLock > Send $Locks
            Call RemoveAzResourceLocks > Send $Locks
                Return ManageAzResourceGroupLock 
            End Function
                Return Function
}#>
function ManageAzResourceGroupTags {
    Begin {
        :ManageAzureRGTag while($true) { # :ManageAzureRGTag loop for managing resource group tags 
            Write-Host "Resource Group Tag Management" # Write message to screen
            Write-Host "1 Set Tag Info For Multiple Use" # Write message to screen
            Write-Host "2 New Resource Group Tag" # Write message to screen
            Write-Host "3 New Resource Tag" # Write message to screen
            Write-Host "4 Get Resource Group Tag" # Write message to screen
            Write-Host "5 Get Resource Tag" # Write message to screen
            Write-Host "6 Remove Tag" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $OperatorManageOption = Read-Host "Option?" # Operator input to select management function
            if ($OperatorManageOption -eq 'exit') { # If statement for exiting this function
                Break ManageAzureRGTag # Ends :ManageAzureRGTag loop, returning to calling function 
            } # End if ($OperatorManageOption -eq 'exit')
            elseif ($OperatorManageOption -eq '1') { # Option for setting tag name and value
                Write-Host "Set Tag Info For Multiple Use" # Write message to screen
                $TagNameInput, $TagValueInput = SetAzTagPair # Calls function 
                $Tags = @{$TagNameInput=$TagValueInput}
            } # End elseif ($OperatorManageOption -eq '1')
            elseif ($OperatorManageOption -eq '2') { # Option for new resource group tag
                Write-Host "New Resource Group Tag" # Write message to screen
                $Tags = NewAzResourceGroupTag ($Tags) # Calls function and assigns value to $Tags
                $Tags # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '2')
            elseif ($OperatorManageOption -eq '3') { # Option for new resource tag
                Write-Host "New Resource Tag" # Write message to screen
                $Tags = NewAzResourceTag # Calls function and assigns value to $Tags
                $Tags # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '3')
            elseif ($OperatorManageOption -eq '4') { # Option to get tag on a resource group
                Write-Host "Get Resource Group Tag" # Write message to screen
                $Tags = GetAzResourceGroupTag # Calls function and assigns value to $Tag
                $Tags # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '4')
            elseif ($OperatorManageOption -eq '5') { # Option to get a tag on a resource
                Write-Host "Get Resource Tag" # Write message to screen
                $Tags = GetAzResourceTag # Calls function and assigns value to $Tag
                $Tags # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '5')
            elseif ($OperatorManageOption -eq '6') { # Option to remove tag
                Write-Host "Remove Tag" # Write message to screen
                RemoveAzResourceTag ($Tags) # Calls function to remove $Tags
                $Tags # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '6')
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
                    if ($TagNameInput -gt 1) { # If $Tags has 2 or more objects
                        Write-Host $TagNameInput "are the currently selected Tags" # Write message to screen
                    } # End if ($Tags.count -gt 1)
                    else { # If $Tags has a single object
                    Write-Host $TagNameInput "is the currently selected Tag" # Write message to screen
                    } # End else if ($Tags.count -gt 1)
                } # End if ($Tags)
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
function SetAzTagPair {
    Begin {
        :SetAzureTagPair while ($true) {
            :SetAzureTagName while ($true) {
                $TagNameInput = Read-Host "Tag Name"
                if ($TagNameInput -eq 'exit') { # If $TagNameInput equals 'exit'
                    Break SetAzureTagPair # Breaks :SetAzureTagPair loop
                } # End if ($TagNameInput -eq 'exit')
                $OperatorConfirm = Read-Host $TagNameInput "is correct" # Operator confirmation that the name entered is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                    Break SetAzureTagName # Breaks :setAzureTagName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetAzureTagName while ($true)
            :SetAzureTagValue while ($true) {
                $TagValueInput = Read-Host "Tag Value"
                if ($TagValueInput -eq 'exit') { # If $TagValueInput equals 'exit'
                    Break SetAzureTagPair # Breaks :SetAzureTagPair loop
                } # End if ($TagVlaueInput -eq 'exit')
                $OperatorConfirm = Read-Host $TagValueInput "is correct" # Operator confirmation that the value entered is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                    Break SetAzureTagValue # Breaks :SetAzureTagName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetAzureTagValue while ($true)
            :SetAzureTagArray while ($true) {
                #$TagsArray = @{$TagNameInput=$TagValueInput}
                Write-Host "Tag name is:"$TagNameInput
                Write-Host "Tag value is:"$TagValueInput
                $OperatorConfirm = Read-Host "Is this correct" # Operator confirmation that the tag entered is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                    Return $TagNameInput, $TagValueInput
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                Break SetAzureTagArray
            } # End :GetAzureTagArray while ($true)
        } # End :SetAzureTagPair while ($true)
        Return
    } # End begin
} # End function SetAzTagPair

function NewAzResourceGroupTag { # Function to create a new resource lock on a resource
    Begin {
        :NewAzureRGTag while ($true) { # :NewAzureRGTag loop for creating a new resource group lock
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break NewAzureRGTag # Breaks :NewAzureRGTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$Tags) {
                :SetAzureTagName while ($true) { # :GetAzureTagName loop for setting the tag name
                    $TagNameInput = Read-Host "Tag Name"
                    if ($TagNameInput -eq 'exit') { # If $TagNameInput equals 'exit'
                        Break SetAzureTagPair # Breaks :SetAzureTagPair loop
                    } # End if ($TagNameInput -eq 'exit')
                    $OperatorConfirm = Read-Host $TagNameInput "is correct" # Operator confirmation that the name entered is correct
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureTagName # Breaks :setAzureTagName
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End :SetAzureTagName while ($true)
                :SetAzureTagValue while ($true) { # :GetAzureTagValue loop for setting lock level
                    $TagValueInput = Read-Host "Tag Value"
                    if ($TagValueInput -eq 'exit') { # If $TagValueInput equals 'exit'
                        Break SetAzureTagPair # Breaks :SetAzureTagPair loop
                    } # End if ($TagVlaueInput -eq 'exit')
                    $OperatorConfirm = Read-Host $TagValueInput "is correct" # Operator confirmation that the value entered is correct
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureTagValue # Breaks :SetAzureTagName
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End :SetAzureTagValue while ($true)
                :SetAzureTagArray while ($true) {
                    $Tags = @{$TagNameInput=$TagValueInput}
                    Write-Host "Tag name is:"$TagNameInput
                    Write-Host "Tag value is:"$TagValueInput
                    $OperatorConfirm = Read-Host "Is this correct" # Operator confirmation that the tag entered is correct
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                    Break SetAzureTagArray
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetAzureTagValue while($true)
                Update-AzTag -ResourceID $RGObject.ResourceID -Operation Merge -Tag $Tags
                #Return  # Returns $Locks to calling function
            } # End else (if ($OperatorSelect -eq "y" -or $OperatorSelect -eq 'yes'))
        } # End :NewAzureRGTag while ($true) {
        Return
    } # End begin
} # End function NewAzResourceGroupLock
function NewAzResourceLock { # Function to create a new resource lock on a resource
    Begin {
        :NewAzureRSLock while ($true) { # :NewAzureRsLock loop for creating a new resource lock
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break NewAzureRGTag # Breaks :NewAzureRGTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$RSObject) { # If $RSObject is $null
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break NewAzureRSLock # Breaks :NewAzureRSLock loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            :GetAzureTagName while ($true) { # :GetAzureTagName loop for setting the lock name
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
                    Break GetAzureTagName # Breaks :GetAzureTagName
                } # End elseif ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :GetAzureTagName while ($true)
            :GetAzureTagValue while ($true) { # :GetAzureTagValue loop for setting lock level
                Write-Host "1 Read Only" # Write message to screen
                Write-Host "2 Can Not Delete" # Write message to screen
                $LockLevel = Read-Host "Option"
                if ($LockLevel -eq 'exit') { # If operator input is 'exit'
                    Break NewAzureRSLock # Breaks :NewAzureRSLock loop
                } # End if ($LockLevel -eq 'exit')
                elseif ($LockLevel -eq '1') { # If $LockLevel is '1'
                    $LockLevel = 'ReadOnly' # Sets $LockLevel to 'ReadOnly'
                    Break GetAzureTag:GetAzureTagValue # Breaks GetAzureTag:GetAzureTagValue
                } # End elseif ($LockLevel -eq '1')
                elseif ($LockLevel -eq '2') { # If $LockLevel is '2'
                    $LockLevel = 'CanNotDelete'# Sets $LockLevel to 'CanNotDelete'
                    Break GetAzureTag:GetAzureTagValue # Breaks GetAzureTag:GetAzureTagValue
                } # End elseif ($LockLevel -eq '2')
                else { # All other inputs for $LockLevel
                    Write-Host "That is not a valid option"  # Write message to screen
                } # End else (if ($LockLevel -eq 'exit'))
            } # End :GetAzureTagValue while($true)
            $LockNotes = Read-Host "Add lock notes" # Operator input for lock notes
            if ($LockNotes) { # If $LocksNotes has a value
                $Locks = New-AzResourceLock -LockLevel $LockLevel -LockNotes $LockNotes -LockName $LockName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType -ResourceGroupName $RGObject.ResourceGroupName -Force # Deploys resource lock to resource (With lock notes)   
                Return $Locks # Returns $Locks to calling function
            } # End if ($OperatorSelect -eq "y" -or $OperatorSelect -eq 'yes')
            else { # If $LockNotes is $null
                $Locks = New-AzResourceLock -LockLevel $LockLevel -LockName $LockName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType -ResourceGroupName $RGObject.ResourceGroupName -Force # Deploys resource lock to resource (No lock notes)
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
function GetAzResourceLocksAll { # Function to get all locks assigned to a resource, can pipe $Locks to another function
    Begin {
        $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
        if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
            Write-Host "GetAzResourceLocksAll function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        $RSObject = GetAzResource # Calls function GetAzResourceGroup and assigns to $RGObject
        if (!$RSObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
            Write-Host "GetAzResourceLocksAll function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType | Where-Object {$_.ResourceName -eq $RSObject.Name} # Collects all locks and assigns to $Locks
        if (!$Locks) { # If statement for no object assigned to $Locks
            Write-Host "No locks are on this resource" # Write message to screen
            Write-Host "The GetAzResourceLocksAll function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        else { # Else statement for an object being assigned to $Locks
            Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceLocksAll
            Return $Locks # Returns $Locks to the calling function
        } # End else statement
    } # End begin statement
} # End function
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
} # End funtion
function RemoveAzResourceLocks { # Function to remove resource locks, No input validation is done
    Begin {
        if (!$Locks) { # If statement if $Locks is $null
            $Locks = GetAzResourceLocks # Calls GetAzResourceLocks and assigns to $Locks
            if(!$Locks) { # If statement if $Locks is $null after calling function to assign
                Write-Host "RemoveAzResourceLocks function was terminated, no changes made" # Message write to screen
                Return $Locks # Returns to calling function
            } # End if statement
        } # End if statement
        $Locks.Name # Writes all names contained in $Locks
        $OperatorConfirm = Read-Host "Type 'Y' or 'Yes' to remove these locks" # Operator confirmation to remove the listed locks
        if (!($OperatorConfirm -ceq 'Y' -or $OperatorConfirm -ceq 'Yes')) { # If $Operatorconfirm is not (Equal to 'Y' or 'Yes') statement
            $Locks = $null # $Locks is set to $null
            Write-Host "RemoveAzResourceLocks function was terminated, no changes made" # Message write to screen
            Return $Locks # Return to calling function
        } # End if statement
        else { # Else statement if $Operatorconfirm is (Equal to 'Y' or 'Yes')
            $ErrorActionPreference='silentlyContinue' # Disables Errors
            foreach ($LockId in $Locks) { # Completes the command in a loop untill performed on all LockIds within $Locks
                $LockId.name # Prints the LockId for each lock as the cycle goes
                Remove-AzResourceLock -LockId $LockId.LockId -force # Removes the lock by targeting the LockID, -force removes operator confirmation
            } # End foreach loop
            $Locks = $null # Clears $Locks prior to returning to calling function
            Return $Locks # Returns to calling function
        } # End else statement
    } # End begin statement
} # End function
function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RGObject = $null # Clears $RGObject from all previous use
        :GetAzureResourceGroup while ($true) { # Loop to continue getting a resource group until the operator provided name matches an existing group
            $RGObjectInput = Read-Host "Resource group name" # Operator input of the resource group name
            if ($RGObjectInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResourceGroup function was terminated"
                Break GetAzureResourceGroup # Ends :GetAzureResourceGroup loop
            } # End if statement
            $RGObject = Get-AzResourceGroup -Name $RGObjectInput # Collection of the resource group from the operator input
            if (!$RGObject) { # Error reporting if input does not match an existing group
                Write-Host "The name provided does not match an existing resource group" # Error note
                Write-Host "This is the list of available resource groups" # Error note
                $RGList = Get-AzResourceGroup # Collects all resource group objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $RGList.ResourceGroupName -Separator `n # Write-host used so list is written to screen when function is used as $RGObject = GetAzResourceGroup
                Write-Host "" # Error reporting
            } # End of if statement
            else { # Else for when $RGObject is assigned
                Write-Host $RGObject.ResourceGroupName 'Has been assigned to "$RGObject"' # Writes the resource group name to the screen before ending function
                Return $RGObject
            } # End of else statement
        } # End of while statement
        Return # Returns to calling function
    } # End of begin statement
} # End of function
function GetAzResource { # Function to get a resource, can pipe $RSObject to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RSObject = $null # Sets $RSObject to $null from previous uses
        if (!$RGObject) { # If statement if $RGObject is $null
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResource function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if statement
        } # End if statement
        while (!$RSObject) { # Loop to continue getting a resource until the operator provided name matches an existing resource
            $RSObjectInput = Read-Host "Resource name" # Operator input of the resource name
            if ($RSObjectInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResource function was terminated"
                Return # Returns to calling function
            } # End if statement
            $RSObject = Get-AzResource -Name $RSObjectInput -ResourceGroupName $RGObject.ResourceGroupName # Collection of the resource from the operator input
            if (!$RSObject) { # Error reporting if input does not match an existing group
                Write-Host "The name provided does not match an existing resource" # Error note
                Write-Host "This is the list of available resources" # Error note
                $RSList = Get-AzResource -ResourceGroupName $RGObject.ResourceGroupName # Collects all resource objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $RSList.Name -Separator `n # Write-host used so list is written to screen when function is used as $RGObject = GetAzResourceGroup
                Write-Host "" # Error reporting
            } # End of if statement
            else { # Else for when $RSObject is assigned
                Write-Host $RSObject.Name 'Has been assigned to "$RSObject"' # Writes the resource name to the screen before ending function
            } # End of else statement
        } # End of while statement
        Return $RSObject  # Returns the value of $RSObject to a function that called it
    } # End begin statement
} # End function 