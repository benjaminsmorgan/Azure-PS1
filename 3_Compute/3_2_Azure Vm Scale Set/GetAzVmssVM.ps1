# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzVmss:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-5.6.0
    Get-AzVmssVM:               https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmssvm?view=azps-5.6.0
} #>
<# Required Functions Links: {
    GetAzVmss:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/GetAzVmSS.ps1
} #>
<# Functions Description: {
    GetAzVmssVM:                Gets a Vmss instance
    GetAzVmss:                  Gets a Vmss
} #>
<# Variables: {
    :GetAzureVmssVM             Outer loop for managing function
    :SelectAzureVmssVM          Inner loop for selecting the Vmss instance
    $VmssObject:                Virtual machine scale set object
    $VmssVMList:                List of all instances on a specified Vmss
    $ListNumber:                $var used to list the instances
    $VmssVMArray:               Array containing the instance info
    $VmssVMStatus:              Power state of each instance
    $ArrayInput:                $var used to load info into $VmssVMArray
    $OperatorSelect:            Operator input for the instance selection
    $VmssVMObject:              The instance object
    GetAzVmss{}                 Gets $VmssObject                   
} #>
<# Process Flow {
    Function
        Call GetAzVmssVM > Get $VmssVMObject, $VmssObject
            Call GetAzVmss > Get $VmssObject
            End GetAzVmss
                Return GetAzVmssVM > Send $VmssObject
        End GetAzVmssVM
            Return function > Send $VmssVMObject, $VmssObject
}#>
function GetAzVmssVM {                                                                      # Function for getting a vmss instance
    Begin {                                                                                 # Begin function
        :GetAzureVmssVM while ($true) {                                                     # Outer loop for managing function
            if (!$VmssObject) {                                                             # If $var is $null
                $VmssObject = GetAzVmss                                                     # Calls function and assigns output to $var
                if (!$VmssObject) {                                                         # If $var is $null
                    Break GetAzureVmssVM                                                    # Breaks :GetAzureVmssVM
                }                                                                           # End if (!$VmssObject)
            }                                                                               # End if (!$VmssObject)
            $VmssVMList = Get-AzVmssVM -ResourceGroupName $VmssObject.ResourceGroupName `
                -VMScaleSetName $VmssObject.name                                            # Collects all instances and assigns to $var
            $ListNumber = 1                                                                 # List number creation
            [System.Collections.ArrayList]$VmssVMArray = @()                                # $VmssVMArray creation
            foreach ($_ in $VmssVMList) {                                                   # For each item in $var
                $VmssVMStatus = Get-AzVmssVM -ResourceGroupName `
                    $VmssObject.ResourceGroupName -VMScaleSetName $VmssObject.name `
                    -InstanceId $_.InstanceId -InstanceView                                 # Collects the Vmss Vm instance status
                $VmssVMStatus = ($VmssVMStatus.Statuses.Code).Split('/')[-1]                # Keeps the last portion of the Vmss VM instance status
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Number' = $ListNumber; 'Instance' = $_.InstanceID; `
                    'State' = $VmssVMStatus                                                 # Attributes and their values to load into the array
                }                                                                           # End creating $ArrayInput
                $VmssVMArray.Add($ArrayInput) | Out-Null                                    # Loads items into the array
                $ListNumber = $ListNumber + 1                                               # Increments $listNumber up by 1
            }                                                                               # End foreach ($_ in $VmssVMList)
            Write-Host '[ 0 ] Exit'                                                         # Write message to screen 
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $VmssVMArray) {                                                  # For each item in $var
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'InstanceID: '$_.Instance                                        # Write message to screen
                Write-Host 'State:      '$_.State                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $VmssVMArray)
            :SelectAzureVmssVM while ($true) {                                              # Inner loop for selecting the Vmss VM instance
                $OperatorSelect = Read-Host 'Enter the [ # ] of the Vmss VM instance'       # Operator input for the selection
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals '0'
                    Break GetAzureVmssVM                                                    # Breaks :GetAzureVmssVM
                }                                                                           # End if ($OperatorSelect -eq '0')
                elseif ($OperatorSelect -in $VmssVMArray.Number) {                          # Else if $OperatorSelect is in $VmssVMArray.Number
                    $OperatorSelect = $VmssVMArray | Where-Object `
                        {$_.Number -eq $OperatorSelect}                                     # $Operator select equals the item in $VmssVMArray where $OperatorSelect equals $VmssVMArray.Number
                    $VmssVMObject = Get-AzVmssVM -ResourceGroupName `
                        $VmssObject.ResourceGroupName -VMScaleSetName $VmssObject.Name `
                        -InstanceId $OperatorSelect.Instance                                # Pulls the full Vmss VM instance
                    if ($VmssVMObject) {                                                    # If $var is not $null
                        Return $VmssVMObject, $VmssObject                                   # Returns to calling function with $VmssVMObject and $VmssObject
                    }                                                                       # End if ($VmssVMObject) 
                    else {                                                                  # If $OperatorSelect did not meet any if or elseif statements
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureVmssVM                                                # Breaks :GetAzureVmssVM
                    }                                                                       # End else (if ($VmssVMObject))
                }                                                                           # End elseif ($OperatorSelect -in $VmssVMArray.Number)
                else {                                                                      # All other inputs for $OperatorSelect
                    Write-Host 'That was not a valid entry'                                 # Write message to screen
                }                                                                           # End else (if ($OperatorSelect -eq '0'))
            }                                                                               # End :SelectAzureVmssVM while ($true)
        }                                                                                   # End :GetAzureVmssVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVmssVM