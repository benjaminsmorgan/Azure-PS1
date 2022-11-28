# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    GetAzResourceGroupLock:     Collects a named locks on a resource group
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :GetAzureRGLock             Outer loop for managing function  
    :SelectAzureObjectList      Inner loop for selecting the resource group lock
    $RGObject:                  Resource group object
    $CallingFunction:           Name of this function
    $ObjectList:                List of all locks on the resource group
    $ObjectNumber:              $var used for listing and selecting an item in $ObjectArray
    $ObjectArray:               Array of items
    $ObjectInput:               $var used to load items into $ObjectArray
    $Number:                    Current item .Number in $ObjectArray
    $LockSelect:                Operator input for selecting the lock
    $Locks:                     Lock object
    GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    Function
        Call GetAzResourceGroupLock > Get $Locks
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return GetAzResourceGroupLock > Send $RGObject
        End GetAzResourceGroupLock
            Return function > Send $Locks 
}#>
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
            if (!$ObjectList) {                                                             # If $ObjectList does not have a value
                Write-Host 'No locks on'$RGObject.ResourceGroupName                         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureRGLock                                                        # Breaks :GetAzureRGLock
            }                                                                               # End if (!$ObjectList)
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
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LockSelect))
            }                                                                               # End :SelectAzureObjectList while ($true)
            Clear-Host                                                                      # Clears the screen
            return                                                                          # Returns to calling function with $null
        }                                                                                   # End :GetAzureRGLock while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroupLock