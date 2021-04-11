# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ListAzResourceGroupLocks:   Lists all locks on a resource group
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :GetAzureRGLock             Outer loop for managing function  
    $RGObject:                  Resource group object
    $CallingFunction:           Name of this function
    $ObjectList:                List of all locks on the resource group
    $ObjectArray:               Array of items
    $ObjectInput:               $var used to load items into $ObjectArray
    GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    Function
        Call ListAzResourceGroupLocks > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return ListAzResourceGroupLocks > Send $RGObject
        End ListAzResourceGroupLocks
            Return function > Send $null
}#>
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
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Name: '$_.Name                                                  # Write message to screen
                Write-Host 'Level:'$_.Properties.Level                                      # Write message to screen
                if ($_.Properties.Notes) {                                                  # If $_.Properties.Notes has a value
                    Write-Host 'Notes:'$_.Properties.Notes                                  # Write message to screen
                }                                                                           # End if ($_.Properties.Notes)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Start-Sleep(15)                                                                 # Pauses all actions for 15 seconds
            Clear-Host                                                                      # Clears the screen
            return                                                                          # Returns to calling function with $null
        }                                                                                   # End :GetAzureRGLock while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function ListAzResourceGroupLocks