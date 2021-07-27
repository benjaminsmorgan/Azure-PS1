# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ListAzResourceLocks:        Lists all locks on a resource
    GetAzResourceGroup:         Collects resource object
} #>
<# Variables: {
    :GetAzureRSLock             Outer loop for managing function  
    $RSObject:                  Resource object
    $CallingFunction:           Name of this function
    $ObjectList:                List of all locks on the resource group
    $ObjectArray:               Array of items
    $ObjectInput:               $var used to load items into $ObjectArray
    GetAzResource{}             Gets $RSObject
} #>
<# Process Flow {
    Function
        Call ListAzResourceLocks > Get $null
            Call GetAzResource > Get $RSObject
            End GetAzResource
                Return ListAzResourceLocks > Send $RSObject
        End ListAzResourceLocks
            Return function > Send $null
}#>
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