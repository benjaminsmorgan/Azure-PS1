# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcelock?view=azps-5.2.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzResourceGroupLock:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/NewAzResourceGroupLock.ps1
    GetAzResourceGroupLock:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceGroupLock.ps1
    ListAzResourceGroupLocks:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/ListAzResourceGroupLocks.ps1
    RemoveAzResourceGroupLock:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceGroupLock.ps1
    NewAzResourceLock:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/NewAzResourceLock.ps1
    GetAzResourceLock:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceLock.ps1  
    ListAzResourceLocks:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/ListAzResourceLocks.ps1
    RemoveAzResourceLock:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLock.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLocks.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/GetAzResource.ps1
} #>
<# Functions Description: {
    ManageAzLocks:              Management function for Locks functions
    NewAzResourceGroupLock:     Create a new resource lock on a resource group
    GetAzResourceGroupLock:     Collects a lock on a resource group
    ListAzResourceGroupLocks:   Lists all locks on a resource group
    RemoveAzResourceGroupLock:  Gets a resource group lock and sends it to RemoveAzResourceLocks
    NewAzResourceLock:          Create a new resource lock on a resource
    GetAzResourceLock:          Collects a lock on a resource   
    ListAzResourceLocks:        Lists all locks on a resource
    RemoveAzResourceLock:       Gets a resource lock and sends it to RemoveAzResourceLocks
    RemoveAzResourceLocks:      Removes all $Locks
    GetAzResourceGroup:         Collects resource group object
    GetAzResource:              Collects resource object 
} #>
<# Variables: {
    :ManageAzureLocks         Outer loop for managing function
    $Locks:                     Lock object
    $LockID:                    Current item in $locks .ResourceID
    $ResProvider:               $LockID split '/' 7th position
    $ResName:                   $LockID split '/' 8th position
    $OpSelect:                  Opertator input to select management option
    NewAzResourceGroupLock{}    Gets $Locks
        GetAzResourceGroup{}        Gets $RGObject
    GetAzResourceGroupLock{}    Gets $Locks
        GetAzResourceGroup{}        Gets $RGObject
    ListAzResourceGroupLocks{}  Gets $null
        GetAzResourceGroup{}        Gets $RGObject
    RemoveAzResourceGroupLock{} Gets $null
        GetAzResourceGroupLock{}    Gets $Locks
            GetAzResourceGroup{}        Gets $RGObject
        RemoveAzResourceLocks{}     Gets $LocksRemoved
    NewAzResourceLock{}         Gets $Locks
        GetAzResource{}             Gets RSObject
    GetAzResourceLock{}         Gets $Locks
        GetAzResource{}             Gets $RSObject
    ListAzResourceLocks{}       Gets $null
        GetAzResource{}             Gets $RSObject
    RemoveAzResourceLock{}      Gets $null
        GetAzResourceLock{}         Gets $Locks
        RemoveAzResourceLocks{}         Gets $LocksRemoved
} #>
<# Process Flow {
    Function
        Call ManageAzLocks > Get $Locks
            Call NewAzResourceGroupLock > Get $Locks
                Call GetAzResourceGroup > Get RGObject
                End GetAzResourceGroup
                    Return NewAzResourceGroupLock > Send $RGObject
                End NewAzResourceGroupLock
                    Return ManageAzLocks > Send $Locks
            Call GetAzResourceGroupLock > Get $Locks
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzResourceGroupLock > Send $RGObject
            End GetAzResourceGroupLock
                Return ManageAzLocks > Send $Locks 
            Call ListAzResourceGroupLocks > Get $null
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return ListAzResourceGroupLocks > Send $RGObject
            End ListAzResourceGroupLocks
                Return ManageAzLocks > Send $null    
            Call RemoveAzResourceGroupLock > Get $null
                Call GetAzResourceGroupLock > Get $Locks
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzResourceGroupLock > Send $RGObject
                End GetAzResourceGroupLock
                    Return RemoveAzResourceGroupLock > Send $Locks 
                Call RemoveAzResourceLocks > Get $LocksRemoved
                End RemoveAzResourceLocks
                    Return RemoveAzResourceGroupLock > Send $LocksRemoved
            End RemoveAzResourceGroupLock
                Return ManageAzLocks > Send $null
            Call NewAzResourceLock > Get $Locks
                Call GetAzResource > Get RSObject
                End GetAzResource
                    Return NewAzResourceLock > Send $RSObject    
            End NewAzResourceLock
                    Return ManageAzLocks > Send $Locks
            Call GetAzResourceLock > Get $Locks
                Call GetAzResource > Get $RSObject
                End GetAzResource
                    Return GetAzResourceLock > Send $RSObject
            End GetAzResourceLock
                Return ManageAzLocks > Send $Locks
            Call ListAzResourceLocks > Get $null
                Call GetAzResource > Get $RSObject
                End GetAzResource
                    Return ListAzResourceLocks > Send $RSObject
            End ListAzResourceLocks
                Return ManageAzLocks > Send $null
            Call RemoveAzResourceLock > Get $null
                Call GetAzResourceLock > Get $Locks
                    Call GetAzResource > Get $RSObject
                    End GetAzResource
                        Return GetAzResourceLock > Send $RSObject
                End GetAzResourceLock
                    Return RemoveAzResourceLock > Send $Locks 
                Call RemoveAzResourceLocks > Get $LocksRemoved
                End RemoveAzResourceLocks
                    Return RemoveAzResourceLock > Send $LocksRemoved
            End RemoveAzResourceLock
                Return ManageAzLocks > Send $null
        End ManageAzLocks
            Return function > Send $Locks
}#>
function ManageAzLocks {                                                                    # Function for managing resource locks
    Begin {                                                                                 # Begin function
        :ManageAzureLocks while($true) {                                                    # Outer loop for managing function 
            Write-Host 'Resource Group Lock Management'                                     # Write message to screen
            if ($Locks) {                                                                   # If $Locks has a value
                Write-Host 'The following locks are currently selected'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen    
                foreach ($_ in $Locks) {                                                    # For each item in $Locks
                    $LockID = $_.ResourceID                                                 # $LockID equals current item .ResourceID
                    $ResProvider = $LockID.Split('/')[7]                                    # Collects the resource provider if lock on a resource
                    $ResName = $LockID.Split('/')[8]                                        # Collects the resource name if lock on a resource
                    Write-Host 'LockName:'$_.name                                           # Write message to screen
                    if ($ResProvider -ne 'locks') {                                         # If $ResProvider not equal to 'locks'
                        Write-Host 'ResName: '$ResName                                      # Write message to screen
                    }                                                                       # End if ($ResProvider -ne 'locks')
                    Write-Host 'RGName:  '$_.ResourceGroupName                              # Write message to screen
                    Write-Host 'Notes:   '$_.Properties                                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LockID = $null                                                         # Clears the selected $var
                    $ResProvider = $null                                                    # Clears the selected $var
                    $ResName = $null                                                        # Clears the selected $var
                }                                                                           # End foreach ($_ in $Locks)
            }                                                                               # End if ($Locks)
            Write-Host '[0] Clear "$Locks"'                                                 # Write message to screen
            Write-Host '[1] New Resource Group Lock'                                        # Write message to screen
            Write-Host '[2] Get Resource Group Lock'                                        # Write message to screen
            Write-Host '[3] List Resource Group Locks'                                      # Write message to screen
            Write-Host '[4] Remove Resource Group Lock'                                     # Write message to screen
            Write-Host '[5] New Resource Lock'                                              # Write message to screen
            Write-Host '[6] Get Resource Lock'                                              # Write message to screen
            Write-Host '[7] List Resource Locks'                                            # Write message to screen
            Write-Host '[8] Remove Resource Lock'                                           # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $OPSelect = Read-Host "Option?"                                                 # Operator input to select management function
            if ($OPSelect -eq 'exit') {                                                     # If $OPSelect equals 'exit'
                Break ManageAzureLocks                                                      # Breaks :ManageAzureLocks 
            }                                                                               # End if ($OPSelect -eq 'exit')
            elseif ($OPSelect -eq '1') {                                                    # Else if $OPSelect equals '1'
                Write-Host 'New Resource Group Lock'                                        # Write message to screen
                $Locks = NewAzResourceGroupLock                                             # Calls function and assigns output to $var
            }                                                                               # End elseif ($OPSelect -eq '1')
            elseif ($OPSelect -eq '2') {                                                    # Else if $OPSelect equals '2'
                Write-Host 'Get Resource Group Lock'                                        # Write message to screen
                $Locks = GetAzResourceGroupLock                                             # Calls function and assigns output to $var
            }                                                                               # End elseif ($OPSelect -eq '2')
            elseif ($OPSelect -eq '3') {                                                    # Else if $OPSelect equals '3'
                Write-Host 'List Resource Group Locks'                                      # Write message to screen
                ListAzResourceGroupLocks                                                    # Calls function 
            }                                                                               # End elseif ($OPSelect -eq '3')
            elseif ($OPSelect -eq '4') {                                                    # Else if $OPSelect equals '4'
                Write-Host 'Remove Resource Group Lock'                                     # Write message to screen
                RemoveAzResourceGroupLock                                                   # Calls function
            }                                                                               # End elseif ($OPSelect -eq '4')
            elseif ($OPSelect -eq '5') {                                                    # Else if $OPSelect equals '5'
                Write-Host 'New Resource Lock'                                              # Write message to screen
                $Locks = NewAzResourceLock                                                  # Calls function and assigns output to $var
        }                                                                                   # End elseif ($OPSelect -eq '5')
            elseif ($OPSelect -eq '6') {                                                    # Else if $OPSelect equals '6'
                Write-Host "Get Resource Lock"                                              # Write message to screen
                $Locks = GetAzResourceLock                                                  # Calls function and assigns output to $var
            }                                                                               # End elseif ($OPSelect -eq '6')
            elseif ($OPSelect -eq '7') {                                                    # Else if $OPSelect equals '7'
                Write-Host 'List Resource Locks'                                            # Write message to screen
                ListAzResourceLocks                                                         # Calls function
            }                                                                               # End elseif ($OPSelect -eq '7')
            elseif ($OPSelect -eq '8') {                                                    # Else if $OPSelect equals '8'
                Write-Host 'Remove Resource Lock'                                           # Write message to screen
                RemoveAzResourceLock                                                        # Calls function
            }                                                                               # End elseif ($OPSelect -eq '8')
            elseif ($OPSelect -eq '0') {                                                    # Else if $OPSelect equals '0'
                If ($Locks) {                                                               # If $Locks has a value
                    $Locks = $null                                                          # Clears $var
                    Write-Host '"$Locks" has been cleared'                                  # Write message to screen
                }                                                                           # End If ($Locks)
                else {                                                                      # If $Locks does not have a value
                    Write-Host '"$Locks was already cleared'                                # Write message to screen
                }                                                                           # End else (If ($Locks))
            }                                                                               # End elseif ($OPSelect -eq '0')
            else {                                                                          # All other inputs for $OpSelect
                Write-host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect-eq 'exit'))
        }                                                                                   # End :ManageAzureLocks while ($true)
        Clear-Host                                                                          # Clears the screen
        if ($Locks) {                                                                       # If $Locks has a value
            Return $Locks                                                                   # Returns to calling function with $Locks
        }                                                                                   # End if ($Locks)
        else {                                                                              # If $Locks does not have a value
            Return                                                                          # Returns to calling function with $null
        }                                                                                   # End else (if ($Locks))
    }                                                                                       # End begin
}                                                                                           # End function ManageAzLocks
function NewAzResourceGroupLock {                                                           # Function to create a new resource lock on a resource group
    Begin {                                                                                 # Begin function
        :NewAzureRGLock while ($true) {                                                     # Outer loop for managing fucntion
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'NewAzResourceGroupLock'                                 # Creates $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var                                         
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            :SetAzureLockName while ($true) {                                               # Inner loop for setting the lock name
                $LockName = Read-Host "Lock Name?"                                          # Operator input for the lock name
                if ($LockName -eq 'exit') {                                                 # If $LockName equals 'exit'
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End if ($LockName -eq 'exit')
                Write-Host "The lock name will be" $LockName                                # Write message to screen
                $OpConfirm = Read-Host '[Y] or [N]'                                         # Operator input to confirm the lock name
                if ($OpConfirm -eq 'exit') {                                                # If $OpConfirm equals 'exit' 
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End if ($OpConfirm -eq 'exit')
                elseif ($OpConfirm -eq 'y') {                                               # $OpConfirm equals 'y'
                    Break SetAzureLockName                                                  # Breaks :SetAzureLockName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($OpConfirm -eq 'exit'))
            }                                                                               # End :SetAzureLockName while ($true)
            :SetAzureLockLevel while ($true) {                                              # Inner loop for setting lock level
                Write-Host '[1] Read Only'                                                  # Write message to screen
                Write-Host '[2] Can Not Delete'                                             # Write message to screen
                Write-Host '[Exit] to leave function'                                       # Write message to screen
                $LockLevel = Read-Host 'Option [#]'                                         # Operator input for the lock level
                if ($LockLevel -eq 'exit') {                                                # If $LockLevel equals 'exit'
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End if ($LockLevel -eq 'exit')
                elseif ($LockLevel -eq '1') {                                               # If $LockLevel equals '1'
                    $LockLevel = 'ReadOnly'                                                 # Sets $LockLevel to 'ReadOnly'
                    Break SetAzureLockLevel                                                 # Breaks :SetAzureLockLevel
                }                                                                           # End elseif ($LockLevel -eq '1')
                elseif ($LockLevel -eq '2') {                                               # If $LockLevel equals '2'
                    $LockLevel = 'CanNotDelete'                                             # Sets $LockLevel to 'CanNotDelete'
                    Break SetAzureLockLevel                                                 # Breaks :SetAzureLockLevel
                }                                                                           # End elseif ($LockLevel -eq '2')
                else {                                                                      # All other inputs for $LockLevel
                    Write-Host "That is not a valid option"                                 # Write message to screen
                }                                                                           # End else (if ($LockLevel -eq 'exit'))
            }                                                                               # End :SetAzureLockLevel while($true)
            $LockNotes = Read-Host 'Enter any lock notes here'                              # Operator input for lock notes
            if ($LockNotes) {                                                               # If $LocksNotes has a value
                Try {                                                                       # Try the following
                    $Locks = New-AzResourceLock -LockLevel $LockLevel -LockNotes `
                        $LockNotes -LockName $LockName -ResourceGroupName `
                        $RGObject.ResourceGroupName -Force -ErrorAction 'Stop'              # Deploys resource lock to resource group (With lock notes)   
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have permissions'                               # Write message to screen
                    Start-Sleep(10)                                                         # Pauses all actions for 10 seconds
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End catch
                Clear-Host                                                                  # Clears the screen
                Return $Locks                                                               # Returns to calling function with $var
            }                                                                               # End if ($LockNotes)
            else {                                                                          # If $LockNotes is $null
                Try {                                                                       # Try the following
                    $Locks = New-AzResourceLock -LockLevel $LockLevel -LockName $LockName `
                        -ResourceGroupName $RGObject.ResourceGroupName -Force `
                        -ErrorAction 'Stop'                                                 # Deploys resource lock to resource group   
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have permissions'                               # Write message to screen
                    Start-Sleep(10)                                                         # Pauses all actions for 10 seconds
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End catch
                Clear-Host                                                                  # Clears the screen
                Return $Locks                                                               # Returns to calling function with $var
            }                                                                               # End else (if ($LockNotes))
        }                                                                                   # End :NewAzureRGLock while ($true) 
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzResourceGroupLock
function GetAzResourceGroupLock {                                                           # Function to get a lock assigned to a resource group
    Begin {                                                                                 # Begin function
        :GetAzureRGLock while ($true) {                                                     # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                if (!$CallingFunction) {                                                    # If $CallingFunction is $null
                    $CallingFunction = 'GetAzResourceGroupLock'                             # Creates $CallingFunction
                }                                                                           # End if (!$CallingFunction)
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break GetAzureRGLock                                                    # Breaks :GetAzureRGLock
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End (!$RGObject) | Outer
            $ObjectList = Get-AzResourceLock -ResourceGroupName `
                $RGObject.ResourceGroupName -AtScope                                        # Collects all locks on $RGObject
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_.Name; `
                    'Properties'=$_.Properties}                                             # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number]   "$_.Name                                        # Write message to screen
                    Write-Host 'Level:'$_.Properties.Level                                  # Write message to screen
                    if ($_.Properties.Notes) {                                              # If $_.Properties.Notes has a value
                        Write-Host 'Notes:'$_.Properties.Notes                              # Write message to screen
                    }                                                                       # End if ($_.Properties.Notes)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]  "$_.Name                                         # Write message to screen
                    Write-Host 'Level:'$_.Properties.Level                                  # Write message to screen
                    if ($_.Properties.Notes) {                                              # If $_.Properties.Notes has a value
                        Write-Host 'Notes:'$_.Properties.Notes                              # Write message to screen
                    }                                                                       # End if ($_.Properties.Notes)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) )
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the lock
                if ($CallingFunction -ne 'GetAzResourceGroupLock') {                        # If $CallingFunction does not equal 'GetAzResourceGroupLock'
                    Write-Host "You are selecting the lock for"$CallingFunction             # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $LockSelect = Read-Host "Enter the lock [#]"                                # Operator input for the lock selection
                if ($LockSelect -eq '0') {                                                  # If $LockSelect equals 0
                    Break GetAzureRGLock                                                    # Breaks :GetAzureRGLock
                }                                                                           # End if ($LockSelect -eq '0')
                elseif ($LockSelect -in $ObjectArray.Number) {                              # If $LockSelect in $ObjectArray.Number
                    $LockSelect = $ObjectArray | Where-Object {$_.Number -eq $LockSelect}   # $LockSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $LockSelect                                  
                    $Locks = Get-AzResourceLock -Name $LockSelect.Name -ResourceGroupName `
                        $RGObject.ResourceGroupName                                         # Pulls the full lock object
                    Clear-Host                                                              # Clears screen
                    Return $Locks                                                           # Returns to calling function with $var
                }                                                                           # End elseif ($LockSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $LockSelect
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($LockSelect))
            }                                                                               # End :SelectAzureObjectList while ($true)
            Clear-Host                                                                      # Clears the screen
            return                                                                          # Returns to calling function with $null
        }                                                                                   # End :GetAzureRGLock while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroupLock
function ListAzResourceGroupLocks {                                                         # Function to list locks assigned to a resource group
    Begin {                                                                                 # Begin function
        :GetAzureRGLock while ($true) {                                                     # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                if (!$CallingFunction) {                                                    # If $CallingFunction is $null
                    $CallingFunction = 'ListAzResourceGroupLocks'                           # Creates $CallingFunction
                }                                                                           # End if (!$CallingFunction)
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break GetAzureRGLock                                                    # Breaks :GetAzureRGLock
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End (!$RGObject) | Outer
            $ObjectList = Get-AzResourceLock -ResourceGroupName `
                $RGObject.ResourceGroupName -AtScope                                        # Collects all locks on $RGObject
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name'=$_.Name;'Properties'=$_.Properties} # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No locks are present on this resource group'                    # Write message to screen
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
            }                                                                               # End if (!$ObjectArray)
            else {                                                                          # If $ObjectArray has a value
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    Write-Host 'Name: '$_.Name                                              # Write message to screen
                    Write-Host 'Level:'$_.Properties.Level                                  # Write message to screen
                    if ($_.Properties.Notes) {                                              # If $_.Properties.Notes has a value
                        Write-Host 'Notes:'$_.Properties.Notes                              # Write message to screen
                    }                                                                       # End if ($_.Properties.Notes)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                $SleepCount = $ObjectArray.Count * 5                                        # $SleepCount is equal to $ObjectArray.Count time 5
                Start-Sleep($SleepCount)                                                    # Pauses all actions for $SleepCount
            }                                                                               # End else (if (!$ObjectArray))
            Clear-Host                                                                      # Clears the screen
            return                                                                          # Returns to calling function with $null
        }                                                                                   # End :GetAzureRGLock while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function ListAzResourceGroupLocks
function RemoveAzResourceGroupLock {                                                        # Function to remove a single resource group lock
    Begin {                                                                                 # Begin function
        :RemoveAzureRGLock while ($true) {                                                  # Outer loop for managing function
            if (!$CallingFunction) {                                                        # If $CallingFunction is $null
                $CallingFunction = 'RemoveAzResourceGroupLock'                              # Creates $CallingFunction
            }                                                                               # End if (!$CallingFunction)
            if (!$Locks) {                                                                  # If $Locks is $null
                $Locks = GetAzResourceGroupLock ($CallingFunction)                          # Calls function and assigns output to $var
                if (!$Locks) {                                                              # If $Locks is $null
                    Break RemoveAzureRGLock                                                 # Breaks :RemoveAzureRGLock
                }                                                                           # End if (!$Locks) | Inner
            }                                                                               # End if (!$Locks) | Outer
            $LocksRemoved = RemoveAzResourceLocks ($Locks)                                  # Calls function and assigns output to $var
            $LocksRemoved = $null
            Break RemoveAzureRGLock                                                         # Breaks :RemoveAzureRGLock
        }                                                                                   # End :RemoveAzureRGLock while ($true) 
        Clear-Host                                                                          # Clears screen
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzResourceGroupLock
function NewAzResourceLock {                                                                # Function to create a new resource lock on a resource
    Begin {                                                                                 # Begin function
        :NewAzureRSLock while ($true) {                                                     # Outer loop for managing fucntion
            if (!$RSObject) {                                                               # If $RSObject is $null
                $CallingFunction = 'NewAzResourceLock'                                      # Creates $CallingFunction
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var                                         
                if (!$RSObject) {                                                           # If $RSObject is $null
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End if (!$RSObject) | Outer
            :SetAzureLockName while ($true) {                                               # Inner loop for setting the lock name
                $LockName = Read-Host "Lock Name?"                                          # Operator input for the lock name
                if ($LockName -eq 'exit') {                                                 # If $LockName equals 'exit'
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End if ($LockName -eq 'exit')
                Write-Host "The lock name will be" $LockName                                # Write message to screen
                $OpConfirm = Read-Host '[Y] or [N]'                                         # Operator input to confirm the lock name
                if ($OpConfirm -eq 'exit') {                                                # If $OpConfirm equals 'exit' 
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End if ($OpConfirm -eq 'exit')
                elseif ($OpConfirm -eq 'y') {                                               # $OpConfirm equals 'y'
                    Break SetAzureLockName                                                  # Breaks :SetAzureLockName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($OpConfirm -eq 'exit'))
            }                                                                               # End :SetAzureLockName while ($true)
            :SetAzureLockLevel while ($true) {                                              # Inner loop for setting lock level
                Write-Host '[1] Read Only'                                                  # Write message to screen
                Write-Host '[2] Can Not Delete'                                             # Write message to screen
                Write-Host '[Exit] to leave function'                                       # Write message to screen
                $LockLevel = Read-Host 'Option [#]'                                         # Operator input for the lock level
                if ($LockLevel -eq 'exit') {                                                # If $LockLevel equals 'exit'
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End if ($LockLevel -eq 'exit')
                elseif ($LockLevel -eq '1') {                                               # If $LockLevel equals '1'
                    $LockLevel = 'ReadOnly'                                                 # Sets $LockLevel to 'ReadOnly'
                    Break SetAzureLockLevel                                                 # Breaks :SetAzureLockLevel
                }                                                                           # End elseif ($LockLevel -eq '1')
                elseif ($LockLevel -eq '2') {                                               # If $LockLevel equals '2'
                    $LockLevel = 'CanNotDelete'                                             # Sets $LockLevel to 'CanNotDelete'
                    Break SetAzureLockLevel                                                 # Breaks :SetAzureLockLevel
                }                                                                           # End elseif ($LockLevel -eq '2')
                else {                                                                      # All other inputs for $LockLevel
                    Write-Host "That is not a valid option"                                 # Write message to screen
                }                                                                           # End else (if ($LockLevel -eq 'exit'))
            }                                                                               # End :SetAzureLockLevel while($true)
            $LockNotes = Read-Host 'Enter any lock notes here'                              # Operator input for lock notes
            if ($LockNotes) {                                                               # If $LocksNotes has a value
                Try {                                                                       # Try the following
                    $Locks = New-AzResourceLock -LockLevel $LockLevel -LockNotes `
                        $LockNotes -LockName $LockName -ResourceName $RSObject.Name `
                        -ResourceType $RSObject.ResourceType -ResourceGroupName `
                        $RSObject.ResourceGroupName -Force -ErrorAction 'Stop'              # Deploys resource lock to resource (With lock notes)   
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have permissions'                               # Write message to screen
                    Start-Sleep(10)                                                         # Pauses all actions for 10 seconds
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End catch
                Clear-Host                                                                  # Clears the screen
                Return $Locks                                                               # Returns to calling function with $var
            }                                                                               # End if ($LockNotes)
            else {                                                                          # If $LockNotes is $null
                Try {                                                                       # Try the following
                    $Locks = New-AzResourceLock -LockLevel $LockLevel -LockName $LockName `
                        -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType `
                        -ResourceGroupName $RSObject.ResourceGroupName -Force `
                        -ErrorAction 'Stop'                                                 # Deploys resource lock to resource
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have permissions'                               # Write message to screen
                    Start-Sleep(10)                                                         # Pauses all actions for 10 seconds
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End catch
                Clear-Host                                                                  # Clears the screen
                Return $Locks                                                               # Returns to calling function with $var
            }                                                                               # End else (if ($LockNotes))
        }                                                                                   # End :NewAzureRSLock while ($true) 
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzResourceLock
function GetAzResourceLock {                                                                # Function to get a lock assigned to a resource
    Begin {                                                                                 # Begin function
        :GetAzureRSLock while ($true) {                                                     # Outer loop for managing function
            if (!$RSObject) {                                                               # If $RSObject is $null
                if (!$CallingFunction) {                                                    # If $CallingFunction is $null
                    $CallingFunction = 'GetAzResourceLock'                                  # Creates $CallingFunction
                }                                                                           # End if (!$CallingFunction)
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject is $null
                    Break GetAzureRSLock                                                    # Breaks :GetAzureRSLock
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End (!$RSObject) | Outer
            $ObjectList = Get-AzResourceLock | Where-Object `
                {$_.ResourceName -eq $RSObject.Name}                                        # Collects all locks on $RSObject
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_.Name; `
                    'Properties'=$_.Properties}                                             # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number]   "$_.Name                                        # Write message to screen
                    Write-Host 'Level:'$_.Properties.Level                                  # Write message to screen
                    if ($_.Properties.Notes) {                                              # If $_.Properties.Notes has a value
                        Write-Host 'Notes:'$_.Properties.Notes                              # Write message to screen
                    }                                                                       # End if ($_.Properties.Notes)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]  "$_.Name                                         # Write message to screen
                    Write-Host 'Level:'$_.Properties.Level                                  # Write message to screen
                    if ($_.Properties.Notes) {                                              # If $_.Properties.Notes has a value
                        Write-Host 'Notes:'$_.Properties.Notes                              # Write message to screen
                    }                                                                       # End if ($_.Properties.Notes)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) )
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the lock
                if ($CallingFunction -ne 'GetAzResourceLock') {                             # If $CallingFunction does not equal 'GetAzResourceLock'
                    Write-Host "You are selecting the lock for"$CallingFunction             # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $LockSelect = Read-Host "Enter the lock [#]"                                # Operator input for the lock selection
                if ($LockSelect -eq '0') {                                                  # If $LockSelect equals 0
                    Break GetAzureRSLock                                                    # Breaks :GetAzureRSLock
                }                                                                           # End if ($LockSelect -eq '0')
                elseif ($LockSelect -in $ObjectArray.Number) {                              # If $LockSelect in $ObjectArray.Number
                    $LockSelect = $ObjectArray | Where-Object {$_.Number -eq $LockSelect}   # $LockSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $LockSelect                                  
                    $Locks = Get-AzResourceLock -Name $LockSelect.Name -ResourceGroupName `
                        $RSObject.ResourceGroupName -ResourceName $RSObject.Name `
                        -ResourceType $RSObject.ResourceType                                # Pulls the full lock object
                    Clear-Host                                                              # Clears screen
                    Return $Locks                                                           # Returns to calling function with $var
                }                                                                           # End elseif ($LockSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $LockSelect
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($LockSelect))
            }                                                                               # End :SelectAzureObjectList while ($true)
            Clear-Host                                                                      # Clears the screen
            return                                                                          # Returns to calling function with $null
        }                                                                                   # End :GetAzureRSLock while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceLock
function ListAzResourceLocks {                                                              # Function to list locks assigned to a resource 
    Begin {                                                                                 # Begin function
        :GetAzureRSLock while ($true) {                                                     # Outer loop for managing function
            if (!$RSObject) {                                                               # If $RSObject is $null
                if (!$CallingFunction) {                                                    # If $CallingFunction is $null
                    $CallingFunction = 'ListAzResourceLocks'                                # Creates $CallingFunction
                }                                                                           # End if (!$CallingFunction)
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject is $null
                    Break GetAzureRSLock                                                    # Breaks :GetAzureRSLock
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End (!$RSObject) | Outer
            $ObjectList = Get-AzResourceLock | Where-Object `
                {$_.ResourceName -eq $RSObject.Name}                                        # Collects all locks on $RSObject
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name'=$_.Name;'Properties'=$_.Properties} # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No locks are present on this resource'                          # Write message to screen
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
            }                                                                               # End if (!$ObjectArray)
            else {                                                                          # If $ObjectArray has a value
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    Write-Host 'Name: '$_.Name                                              # Write message to screen
                    Write-Host 'Level:'$_.Properties.Level                                  # Write message to screen
                    if ($_.Properties.Notes) {                                              # If $_.Properties.Notes has a value
                        Write-Host 'Notes:'$_.Properties.Notes                              # Write message to screen
                    }                                                                       # End if ($_.Properties.Notes)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                $SleepCount = $ObjectArray.Count * 5                                        # $SleepCount is equal to $ObjectArray.Count time 5
                Start-Sleep($SleepCount)                                                    # Pauses all actions for $SleepCount
            }                                                                               # End else (if (!$ObjectArray))
            Clear-Host                                                                      # Clears the screen
            return                                                                          # Returns to calling function with $null
        }                                                                                   # End :GetAzureRSLock while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function ListAzResourceLocks
function RemoveAzResourceLock {                                                             # Function to remove a single resource lock
    Begin {                                                                                 # Begin function
        :RemoveAzureRSLock while ($true) {                                                  # Outer loop for managing function
            if (!$CallingFunction) {                                                        # If $CallingFunction is $null
                $CallingFunction = 'RemoveAzResourceLock'                                   # Creates $CallingFunction
            }                                                                               # End if (!$CallingFunction)
            if (!$Locks) {                                                                  # If $Locks is $null
                $Locks = GetAzResourceLock ($CallingFunction)                               # Calls function and assigns output to $var
                if (!$Locks) {                                                              # If $Locks is $null
                    Break RemoveAzureRSLock                                                 # Breaks :RemoveAzureRSLock
                }                                                                           # End if (!$Locks) | Inner
            }                                                                               # End if (!$Locks) | Outer
            $LocksRemoved = RemoveAzResourceLocks ($Locks)                                  # Calls function and assigns output to $var
            $LocksRemoved = $null                                                           # Clears $LocksRemoved
            Break RemoveAzureRSLock                                                         # Breaks :RemoveAzureRSLock
        }                                                                                   # End :RemoveAzureRSLock while ($true) 
        Clear-Host                                                                          # Clears screen
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzResourceLock
function RemoveAzResourceLocks {                                                            # Function to remove resource locks
    Begin {                                                                                 # Begin function
        :RemoveAzureLocks while ($true) {                                                   # Outer loop for managing function
            if (!$Locks) {                                                                  # If $Locks is $null
                Write-Host 'No locks were passed to this function'                          # Write message to screen
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
                Break RemoveAzureLocks                                                      # Breaks :RemoveAzureLocks
            }                                                                               # End if(!$Locks) 
            foreach ($_ in $Locks) {                                                        # For each item in $Locks
                Write-Host $_.Name                                                          # Write message to screen
            }                                                                               # End foreach ($_ in $Locks)
            if ($Locks.Count -gt 1) {                                                       # If $Locks.Count greater than 1
                Write-Host 'Remove these locks'                                             # Write message to screen
            }                                                                               # End if ($Locks.Count -gt 1)
            else {                                                                          # If $Locks.Count is not greater than 1
                Write-Host 'Remove this lock'                                               # Write message to screen
            }                                                                               # End else (if ($Locks.Count -gt 1))
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
                if ($Locks.Count -gt 1) {                                                   # If $Locks.Count greater than 1
                    Write-Host 'Locks removed'                                              # Write message to screen
                }                                                                           # End if ($Locks.Count -gt 1)
                else {                                                                      # If $Locks.Count is not greater than 1
                    Write-Host 'Lock removed'                                               # Write message to screen
                }                                                                           # End else (if ($Locks.Count -gt 1))
                $LocksRemoved = 'y'                                                         # Sets $LocksRemoved to 'n'
                Start-Sleep(5)                                                             # Pauses actions for 10 seconds
                Clear-Host                                                                  # Clears Screen
                Return $LocksRemoved                                                        # Returns to calling function with $LocksRemoved
            }                                                                               # End if ($OperatorConfirm -eq 'Y') 
            else {                                                                          # Else if $Operatorconfirm is not equal to 'y'
                Write-Host "No changes made"                                                # Message write to screen
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
                $LocksRemoved = 'n'                                                         # Sets $LocksRemoved to 'n'
                Return $LocksRemoved                                                        # Returns to calling function with $LocksRemoved
            }                                                                               # End else (if ($OperatorConfirm -eq 'Y') )
        }                                                                                   # End :RemoveAzureLocks while ($true)
        Clear-Host                                                                          # Clears Screen
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function RemoveAzResourceLocks
# End ManageAzLocks
# Additional external functions required for ManageAzLocks
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